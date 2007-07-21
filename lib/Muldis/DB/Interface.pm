use 5.008001;
use utf8;
use strict;
use warnings FATAL => 'all';

use Muldis::DB::Literal;

###########################################################################
###########################################################################

{ package Muldis::DB::Interface; # module
    our $VERSION = 0.002000;
    # Note: This given version applies to all of this file's packages.

###########################################################################

sub new_dbms {
    my ($args) = @_;
    my ($engine_name, $dbms_config)
        = @{$args}{'engine_name', 'dbms_config'};
    return Muldis::DB::Interface::DBMS->new({
        'engine_name' => $engine_name, 'dbms_config' => $dbms_config });
}

###########################################################################

} # module Muldis::DB::Interface

###########################################################################
###########################################################################

{ package Muldis::DB::Interface::DBMS; # class

    use Carp;
    use Encode qw(is_utf8);
    use Scalar::Util qw(blessed);

    my $ATTR_DBMS_ENG = 'dbms_eng';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    $self->_build( $args );
    return $self;
}

sub _build {
    my ($self, $args) = @_;
    my ($engine_name, $dbms_config)
        = @{$args}{'engine_name', 'dbms_config'};

    confess q{new(): Bad :$engine_name arg; Perl 5 does not consider}
            . q{ it to be a character string, or it is the empty string.}
        if !defined $engine_name or $engine_name eq q{}
            or (!is_utf8 $engine_name
                and $engine_name =~ m/[^\x00-\x7F]/xs);

    # A class may be loaded due to it being embedded in a non-excl file.
    if (!do {
            no strict 'refs';
            defined %{$engine_name . '::'};
        }) {
        # Note: We have to invoke this 'require' in an eval string
        # because we need the bareword semantics, where 'require'
        # will munge the module name into file system paths.
        eval "require $engine_name;";
        if (my $err = $@) {
            confess q{new(): Could not load Muldis::DB Engine class}
                . qq{ '$engine_name': $err};
        }
        confess qq{new(): Could not load Muldis::DB Engine class}
                . qq{ '$engine_name': while that file did compile without}
                . q{ errors, it did not declare the same-named class.}
            if !do {
                no strict 'refs';
                defined %{$engine_name . '::'};
            };
    }
    confess qq{new(): The Muldis::DB root Engine class '$engine_name' is}
            . q{ not a Muldis::DB::Engine::Role-doing class.}
        if !$engine_name->isa( 'Muldis::DB::Engine::Role' );
    my $dbms_eng = eval {
        $engine_name->new_dbms({ 'dbms_config' => $dbms_config });
    };
    if (my $err = $@) {
        confess qq{new(): The Muldis::DB Engine class '$engine_name' threw}
            . qq{ an exception during its new_dbms() execution: $err};
    }
    confess q{new(): The new_dbms() constructor submeth of the Muldis::DB}
            . qq{ root Engine class '$engine_name' did not return an}
            . q{ object of a Muldis::DB::Engine::Role::DBMS-doing class.}
        if !blessed $dbms_eng
            or !$dbms_eng->isa( 'Muldis::DB::Engine::Role::DBMS' );

    $self->{$ATTR_DBMS_ENG} = $dbms_eng;

    return;
}

###########################################################################

sub new_var {
    my ($self, $args) = @_;
    my ($decl_type) = @{$args}{'decl_type'};
    return Muldis::DB::Interface::HostGateVar->new({
        'dbms' => $self, 'decl_type' => $decl_type });
}

sub prepare {
    my ($self, $args) = @_;
    my ($rtn_ast) = @{$args}{'rtn_ast'};
    return Muldis::DB::Interface::HostGateRtn->new({
        'dbms' => $self, 'rtn_ast' => $rtn_ast });
}

###########################################################################

} # class Muldis::DB::Interface::DBMS

###########################################################################
###########################################################################

{ package Muldis::DB::Interface::HostGateVar; # class

    use Carp;
    use Scalar::Util qw(blessed);

    my $ATTR_DBMS    = 'dbms';
    my $ATTR_VAR_ENG = 'var_eng';

    my $DBMS_ATTR_DBMS_ENG = 'dbms_eng';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    $self->_build( $args );
    return $self;
}

sub _build {
    my ($self, $args) = @_;
    my ($dbms, $decl_type) = @{$args}{'dbms', 'decl_type'};

    confess q{new(): Bad :$dbms arg; it is not an object of a}
            . q{ Muldis::DB::Interface::DBMS-doing class.}
        if !blessed $dbms or !$dbms->isa( 'Muldis::DB::Interface::DBMS' );
    my $dbms_eng = $dbms->{$DBMS_ATTR_DBMS_ENG};
    my $dbms_eng_class = blessed $dbms_eng;

    confess q{new(): Bad :$decl_type arg; it is not an object of a}
            . q{ Muldis::DB::Literal::_TypeInvo-doing class.}
        if !blessed $decl_type
            or !$decl_type->isa( 'Muldis::DB::Literal::_TypeInvo' );

    my $var_eng = eval {
        $dbms_eng->new_var({ 'decl_type' => $decl_type });
    };
    if (my $err = $@) {
        confess qq{new(): The Muldis::DB DBMS Eng class '$dbms_eng_class'}
            . q{ threw an exception during its new_var()}
            . qq{ execution: $err};
    }
    confess q{new(): The new_var() method of the Muldis::DB}
            . qq{ DBMS class '$dbms_eng_class' did not return an object}
            . q{ of a Muldis::DB::Engine::Role::HostGateVar-doing class.}
        if !blessed $var_eng
            or !$var_eng->isa( 'Muldis::DB::Engine::Role::HostGateVar' );

    $self->{$ATTR_DBMS}    = $dbms;
    $self->{$ATTR_VAR_ENG} = $var_eng;

    return;
}

###########################################################################

sub fetch_ast {
    my ($self) = @_;

    my $var_eng = $self->{$ATTR_VAR_ENG};
    my $val_ast = eval {
        $var_eng->fetch_ast();
    };
    if (my $err = $@) {
        my $var_eng_class = blessed $var_eng;
        confess q{fetch_ast(): The Muldis::DB HostGateVar Engine}
            . qq{ class '$var_eng_class' threw an exception during its}
            . qq{ fetch_ast() execution: $err};
    }

    return $val_ast;
}

###########################################################################

sub store_ast {
    my ($self, $args) = @_;
    my ($val_ast) = @{$args}{'val_ast'};

    confess q{store_ast(): Bad :$val_ast arg; it is not an object of a}
            . q{ Muldis::DB::Literal::Node-doing class.}
        if !blessed $val_ast or !$val_ast->isa( 'Muldis::DB::Literal::Node' );

    my $var_eng = $self->{$ATTR_VAR_ENG};
    eval {
        $var_eng->store_ast({ 'val_ast' => $val_ast });
    };
    if (my $err = $@) {
        my $var_eng_class = blessed $var_eng;
        confess q{store_ast(): The Muldis::DB HostGateVar Engine}
            . qq{ class '$var_eng_class' threw an exception during its}
            . qq{ store_ast() execution: $err};
    }

    return;
}

###########################################################################

} # class Muldis::DB::Interface::HostGateVar

###########################################################################
###########################################################################

{ package Muldis::DB::Interface::HostGateRtn; # class

    use Carp;
    use Scalar::Util qw(blessed);

    my $ATTR_DBMS    = 'dbms';
    my $ATTR_RTN_AST = 'rtn_ast';
    my $ATTR_RTN_ENG = 'rtn_eng';

    my $DBMS_ATTR_DBMS_ENG     = 'dbms_eng';
    my $VAR_ATTR_VAR_ENG       = 'var_eng';
    my $ASTHGR_ATTR_UPD_PARAMS = 'upd_params';
    my $ASTHGR_ATTR_RO_PARAMS  = 'ro_params';
    my $TYPEDICT_ATTR_MAP_HOA  = 'map_hoa';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    $self->_build( $args );
    return $self;
}

sub _build {
    my ($self, $args) = @_;
    my ($dbms, $rtn_ast) = @{$args}{'dbms', 'rtn_ast'};

    confess q{new(): Bad :$dbms arg; it is not an object of a}
            . q{ Muldis::DB::Interface::DBMS-doing class.}
        if !blessed $dbms or !$dbms->isa( 'Muldis::DB::Interface::DBMS' );
    my $dbms_eng = $dbms->{$DBMS_ATTR_DBMS_ENG};
    my $dbms_eng_class = blessed $dbms_eng;

    confess q{new(): Bad :$rtn_ast arg; it is not an object of a}
            . q{ Muldis::DB::Literal::HostGateRtn-doing class.}
        if !blessed $rtn_ast
            or !$rtn_ast->isa( 'Muldis::DB::Literal::HostGateRtn' );

    my $rtn_eng = eval {
        $dbms_eng->prepare({ 'rtn_ast' => $rtn_ast });
    };
    if (my $err = $@) {
        confess qq{new(): The Muldis::DB DBMS Eng class '$dbms_eng_class'}
            . qq{ threw an exception during its prepare() execution: $err};
    }
    confess q{new(): The prepare() method of the Muldis::DB}
            . qq{ DBMS class '$dbms_eng_class' did not return an object}
            . q{ of a Muldis::DB::Engine::Role::HostGateRtn-doing class.}
        if !blessed $rtn_eng
            or !$rtn_eng->isa( 'Muldis::DB::Engine::Role::HostGateRtn' );

    $self->{$ATTR_DBMS}    = $dbms;
    $self->{$ATTR_RTN_AST} = $rtn_ast;
    $self->{$ATTR_RTN_ENG} = $rtn_eng;

    return;
}

###########################################################################

sub bind_host_params {
    my ($self, $args) = @_;
    my ($upd_args, $ro_args) = @{$args}{'upd_args', 'ro_args'};

    my $exp_upd_args_map_hoa = $self->{$ATTR_RTN_AST
        }->{$ASTHGR_ATTR_UPD_PARAMS}->{$TYPEDICT_ATTR_MAP_HOA};
    my $exp_ro_args_map_hoa = $self->{$ATTR_RTN_AST
        }->{$ASTHGR_ATTR_RO_PARAMS}->{$TYPEDICT_ATTR_MAP_HOA};

    confess q{bind_host_params(): Bad :$upd_args arg; it is not an Array.}
        if ref $upd_args ne 'ARRAY';
    my $seen_upd_param_names = {};
    my $upd_arg_engs = [];
    for my $elem (@{$upd_args}) {
        confess q{bind_host_params(): Bad :$upd_args arg elem; it is not a}
                . q{ 2-element Array.}
            if ref $elem ne 'ARRAY' or @{$elem} != 2;
        my ($param_name, $var_intf) = @{$elem};
        confess q{bind_host_params(): Bad :$upd_args arg elem; its first}
                . q{ element is not an object of a}
                . q{ Muldis::DB::Literal::EntityName-doing class.}
            if !blessed $param_name
                or !$param_name->isa( 'Muldis::DB::Literal::EntityName' );
        my $param_name_text = $param_name->text();
        confess q{bind_host_params(): Bad :$upd_args arg elem; its first}
                . q{ element does not match the name of a}
                . q{ subject-to-update routine param.}
            if !exists $exp_upd_args_map_hoa->{$param_name_text};
        confess q{bind_host_params(): Bad :$vars arg elem; its first elem}
                . q{ is not distinct between the arg elems.}
            if exists $seen_upd_param_names->{$param_name_text};
        $seen_upd_param_names->{$param_name_text} = 1;
        confess q{bind_host_params(): Bad :$upd_args arg elem; its second}
                . q{ element is not an object of a}
                . q{ Muldis::DB::Interface::HostGateVar-doing class.}
            if !blessed $var_intf
                or !$var_intf->isa( 'Muldis::DB::Interface::HostGateVar' );
        push @{$upd_arg_engs},
            [$param_name, $var_intf->{$VAR_ATTR_VAR_ENG}];
    }

    confess q{bind_host_params(): Bad :$ro_args arg; it is not an Array.}
        if ref $ro_args ne 'ARRAY';
    my $seen_ro_param_names = {};
    my $ro_arg_engs = [];
    for my $elem (@{$ro_args}) {
        confess q{bind_host_params(): Bad :$ro_args arg elem; it is not a}
                . q{ 2-element Array.}
            if ref $elem ne 'ARRAY' or @{$elem} != 2;
        my ($param_name, $var_intf) = @{$elem};
        confess q{bind_host_params(): Bad :$ro_args arg elem; its first}
                . q{ element is not an object of a}
                . q{ Muldis::DB::Literal::EntityName-doing class.}
            if !blessed $param_name
                or !$param_name->isa( 'Muldis::DB::Literal::EntityName' );
        my $param_name_text = $param_name->text();
        confess q{bind_host_params(): Bad :$ro_args arg elem; its first}
                . q{ element does not match the name of a}
                . q{ read-only routine param.}
            if !exists $exp_ro_args_map_hoa->{$param_name_text};
        confess q{bind_host_params(): Bad :$vars arg elem; its first elem}
                . q{ is not distinct between the arg elems.}
            if exists $seen_ro_param_names->{$param_name_text};
        $seen_ro_param_names->{$param_name_text} = 1;
        confess q{bind_host_params(): Bad :$ro_args arg elem; its second}
                . q{ element is not an object of a}
                . q{ Muldis::DB::Interface::HostGateVar-doing class.}
            if !blessed $var_intf
                or !$var_intf->isa( 'Muldis::DB::Interface::HostGateVar' );
        push @{$ro_arg_engs},
            [$param_name, $var_intf->{$VAR_ATTR_VAR_ENG}];
    }

    my $rtn_eng = $self->{$ATTR_RTN_ENG};
    eval {
        $rtn_eng->bind_host_params({
            'upd_args' => $upd_arg_engs, 'ro_args' => $ro_arg_engs });
    };
    if (my $err = $@) {
        my $rtn_eng_class = blessed $rtn_eng;
        confess q{bind_host_params(): The Muldis::DB HostGateRtn Engine}
            . qq{ class '$rtn_eng_class' threw an exception during its}
            . qq{ bind_host_params() execution: $err};
    }

    return;
}

###########################################################################

sub execute {
    my ($self) = @_;
    my $rtn_eng = $self->{$ATTR_RTN_ENG};
    eval {
        $rtn_eng->execute();
    };
    if (my $err = $@) {
        my $rtn_eng_class = blessed $rtn_eng;
        confess q{execute(): The Muldis::DB HostGateRtn Engine}
            . qq{ class '$rtn_eng_class' threw an exception during its}
            . qq{ execute() execution: $err};
    }
    return;
}

###########################################################################

} # class Muldis::DB::Interface::HostGateRtn

###########################################################################
###########################################################################

{ package Muldis::DB::Engine::Role; # role
    use Carp;

    sub new_dbms {
        my ($class) = @_;
        confess q{not implemented by subclass } . $class;
    }

} # role Muldis::DB::Engine::Role

###########################################################################
###########################################################################

{ package Muldis::DB::Engine::Role::DBMS; # role
    use Carp;
    use Scalar::Util qw(blessed);

    sub new_var {
        my ($self) = @_;
        confess q{not implemented by subclass } . (blessed $self);
    }

    sub prepare {
        my ($self) = @_;
        confess q{not implemented by subclass } . (blessed $self);
    }

} # role Muldis::DB::Engine::Role::DBMS

###########################################################################
###########################################################################

{ package Muldis::DB::Engine::Role::HostGateVar; # role
    use Carp;
    use Scalar::Util qw(blessed);

    sub fetch_ast {
        my ($self) = @_;
        confess q{not implemented by subclass } . (blessed $self);
    }

    sub store_ast {
        my ($self) = @_;
        confess q{not implemented by subclass } . (blessed $self);
    }

} # role Muldis::DB::Engine::Role::HostGateVar

###########################################################################
###########################################################################

{ package Muldis::DB::Engine::Role::HostGateRtn; # role
    use Carp;
    use Scalar::Util qw(blessed);

    sub bind_host_params {
        my ($self) = @_;
        confess q{not implemented by subclass } . (blessed $self);
    }

    sub execute {
        my ($self) = @_;
        confess q{not implemented by subclass } . (blessed $self);
    }

} # role Muldis::DB::Engine::Role::HostGateRtn

###########################################################################
###########################################################################

1; # Magic true value required at end of a reusable file's code.
__END__

=pod

=encoding utf8

=head1 NAME

Muldis::DB::Interface -
Common public API for Muldis::DB Engines

=head1 VERSION

This document describes Muldis::DB::Interface version 0.2.0 for Perl 5.

It also describes the same-number versions for Perl 5 of
Muldis::DB::Interface::DBMS ("DBMS"), Muldis::DB::Interface::HostGateVar
("HostGateVar"), and Muldis::DB::Interface::HostGateRtn ("HostGateRtn").

It also describes the same-number versions for Perl 5 of
Muldis::DB::Engine::Role, Muldis::DB::Engine::Role::DBMS,
Muldis::DB::Engine::Role::HostGateVar, and
Muldis::DB::Engine::Role::HostGateRtn.

=head1 SYNOPSIS

    use Muldis::DB::Interface;

    # Instantiate a Muldis::DB DBMS / virtual machine.
    my $dbms = Muldis::DB::Interface::new_dbms({
            'engine_name' => 'Muldis::DB::Engine::Example',
            'dbms_config' => {},
        });

    # TODO: Create or connect to a repository and work with it.

I<This documentation is pending.>

=head1 DESCRIPTION

I<This documentation is pending.>

=head1 INTERFACE

The interface of Muldis::DB::Interface is fundamentally object-oriented;
you use it by creating objects from its member classes, usually invoking
C<new()> on the appropriate class name, and then invoking methods on those
objects.  All of their attributes are private, so you must use accessor
methods.

Muldis::DB::Interface also provides the not-exportable wrapper subroutine
C<Muldis::DB::new_dbms> for the C<Muldis::DB::Interface::DBMS> constructor,
which has identical parameters, and exists solely as syntactic sugar.
Similarly, the C<DBMS> methods C<new_var> and C<prepare> exist purely as
syntactic sugar over the C<HostGateVar> and C<HostGateRtn> constructors.
I<TODO: Reimplement these as lexical aliases or compile-time macros
instead, to avoid the overhead of extra routine calls.>

The usual way that Muldis::DB::Interface indicates a failure is to throw an
exception; most often this is due to invalid input.  If an invoked routine
simply returns, you can assume that it has succeeded, even if the return
value is undefined.

=head2 The Muldis::DB::Interface::DBMS Class

I<This documentation is pending.>

=head2 The Muldis::DB::Interface::HostGateVar Class

I<This documentation is pending.>

=head2 The Muldis::DB::Interface::HostGateRtn Class

I<This documentation is pending.>

=head2 The Muldis::DB::Engine::Role(|::\w+) Roles

This "Muldis::DB" file also defines a few roles that the public interface
classes of all Engine modules must implement, and explicitly declare that
they are doing so.

The initial Engine class, which users specify in the C<$engine_name>
argument to the C<Muldis::DB::Interface::DBMS> constructor, must compose
the C<Muldis::DB::Engine::Role>, and implement the C<new_dbms> submethod.
The DBMS Engine object returned by C<new_dbms> must compose the
C<Muldis::DB::Engine::Role::DBMS> role, and implement the methods
C<new_var> and C<prepare>.  The HostGateVar Engine object returned by
C<new_var> must compose the C<Muldis::DB::Engine::Role::HostGateVar> role,
and implement the methods C<fetch_ast> and C<store_ast>.  The HostGateRtn
Engine object returned by C<new_var> must compose the
C<Muldis::DB::Engine::Role::HostGateRtn> role, and implement the methods
C<bind_host_params> and C<execute>.

The Muldis::DB Interface classes don't just validate user input on behalf
of Engines (allowing them to be simpler), but they also validate each
requested Engine's APIs and results, to some extent, on behalf of users (so
an application can more gracefully handle a bad Engine); the Engine Role
roles exist to help with the latter kind of validation, and they mainly
just declare shims for the required (sub|)methods, which die on invocation
if the Engine didn't declare its own versions; they don't presently contain
any actual functionality for Engines to use.

=head1 DIAGNOSTICS

I<This documentation is pending.>

=head1 CONFIGURATION AND ENVIRONMENT

I<This documentation is pending.>

=head1 DEPENDENCIES

This file requires any version of Perl 5.x.y that is at least 5.8.1.

It also requires these Perl 5 classes that are in the current distribution:
L<Muldis::DB::Literal-(0.2.0)|Muldis::DB::Literal>.

=head1 INCOMPATIBILITIES

None reported.

=head1 SEE ALSO

Go to L<Muldis::DB> for the majority of distribution-internal references,
and L<Muldis::DB::SeeAlso> for the majority of distribution-external
references.

=head1 BUGS AND LIMITATIONS

The Muldis::DB framework for Perl 5 is built according to certain
old-school or traditional Perl-5-land design principles, including that
there are no explicit attempts in code to enforce privacy of the
framework's internals, besides not documenting them as part of the public
API.  (The Muldis::DB framework for Perl 6 is different.)  That said, you
should still respect that privacy and just use the public API that
Muldis::DB provides.  If you bypass the public API anyway, as Perl 5
allows, you do so at your own peril.

I<This documentation is pending.>

=head1 AUTHOR

Darren Duncan (C<perl@DarrenDuncan.net>)

=head1 LICENSE AND COPYRIGHT

This file is part of the Muldis::DB framework.

Muldis::DB is Copyright © 2002-2007, Darren Duncan.

See the LICENSE AND COPYRIGHT of L<Muldis::DB> for details.

=head1 ACKNOWLEDGEMENTS

The ACKNOWLEDGEMENTS in L<Muldis::DB> apply to this file too.

=cut
