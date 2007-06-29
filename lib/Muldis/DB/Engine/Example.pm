use 5.008001;
use utf8;
use strict;
use warnings FATAL => 'all';

use Muldis::DB;
use Muldis::DB::Engine::Example::Operators;

###########################################################################
###########################################################################

{ package Muldis::DB::Engine::Example; # class
    our $VERSION = 0.000001;
    # Note: This given version applies to all of this file's packages.

    use base 'Muldis::DB::Engine::Role';

###########################################################################

sub new_dbms {
    my ($class, $args) = @_;
    my ($dbms_config) = @{$args}{'dbms_config'};
    return Muldis::DB::Engine::Example::DBMS->new({
        'dbms_config' => $dbms_config });
}

###########################################################################

} # class Muldis::DB::Engine::Example

###########################################################################
###########################################################################

{ package Muldis::DB::Engine::Example::DBMS; # class
    use base 'Muldis::DB::Engine::Role::DBMS';

    use Carp;

    my $ATTR_DBMS_CONFIG = 'dbms_config';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    $self->_build( $args );
    return $self;
}

sub _build {
    my ($self, $args) = @_;
    my ($dbms_config) = @{$args}{'dbms_config'};
    $self->{$ATTR_DBMS_CONFIG} = $dbms_config;
    return;
}

###########################################################################

sub new_var {
    my ($self, $args) = @_;
    my ($decl_type) = @{$args}{'decl_type'};
    return Muldis::DB::Engine::Example::HostGateVar->new({
        'dbms' => $self, 'decl_type' => $decl_type });
}

sub prepare {
    my ($self, $args) = @_;
    my ($rtn_ast) = @{$args}{'rtn_ast'};
    return Muldis::DB::Engine::Example::HostGateRtn->new({
        'dbms' => $self, 'rtn_ast' => $rtn_ast });
}

###########################################################################

} # class Muldis::DB::Engine::Example::DBMS

###########################################################################
###########################################################################

{ package Muldis::DB::Engine::Example::HostGateVar; # class
    use base 'Muldis::DB::Engine::Role::HostGateVar';

    use Carp;

    use Muldis::DB::AST qw(newBoolLit);

    my $ATTR_DBMS      = 'dbms';
    my $ATTR_DECL_TYPE = 'decl_type';
    my $ATTR_VAL_AST   = 'val_ast';

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

    $self->{$ATTR_DBMS}      = $dbms;
    $self->{$ATTR_DECL_TYPE} = $decl_type;
    $self->{$ATTR_VAL_AST}   = newBoolLit({ 'v' => (1 == 0) });
        # TODO: make default val of decl type

    return;
}

###########################################################################

sub fetch_ast {
    my ($self) = @_;
    return $self->{$ATTR_VAL_AST};
}

###########################################################################

sub store_ast {
    my ($self, $args) = @_;
    my ($val_ast) = @{$args}{'val_ast'};
    $self->{$ATTR_VAL_AST} = $val_ast;
    return;
}

###########################################################################

} # class Muldis::DB::Engine::Example::HostGateVar

###########################################################################
###########################################################################

{ package Muldis::DB::Engine::Example::HostGateRtn; # class
    use base 'Muldis::DB::Engine::Role::HostGateRtn';

    use Carp;

    my $ATTR_DBMS           = 'dbms';
    my $ATTR_RTN_AST        = 'rtn_ast';
    my $ATTR_PREP_RTN       = 'prep_rtn';
    my $ATTR_BOUND_UPD_ARGS = 'bound_upd_args';
    my $ATTR_BOUND_RO_ARGS  = 'bound_ro_args';

    my $VAR_ATTR_DECL_TYPE = 'decl_type';

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

    my $prep_rtn = sub { 1; }; # TODO; the real thing.

    $self->{$ATTR_DBMS}           = $dbms;
    $self->{$ATTR_RTN_AST}        = $rtn_ast;
    $self->{$ATTR_PREP_RTN}       = $prep_rtn;
    $self->{$ATTR_BOUND_UPD_ARGS} = {};
    $self->{$ATTR_BOUND_RO_ARGS}  = {};

    return;
}

###########################################################################

sub bind_host_params {
    my ($self, $args) = @_;
    my ($upd_args, $ro_args) = @{$args}{'upd_args', 'ro_args'};
    my $bound_upd_args = $self->{$ATTR_BOUND_UPD_ARGS};
    my $bound_ro_args = $self->{$ATTR_BOUND_RO_ARGS};
    # TODO: Compare declared type of each routine param and the variable
    # we are trying to bind to it, that they are of compatible types.
    for my $elem (@{$upd_args}) {
        $bound_upd_args->{$elem->[0]->text()} = $elem->[1];
    }
    for my $elem (@{$ro_args}) {
        $bound_ro_args->{$elem->[0]->text()} = $elem->[1];
    }
    return;
}

###########################################################################

sub execute {
    my ($self) = @_;
    # TODO: Fix this!
#    $self->{$ATTR_PREP_RTN}->({ %{$self->{$ATTR_BOUND_UPD_ARGS}},
#        %{$self->{$ATTR_BOUND_RO_ARGS}} });
    return;
}

###########################################################################

} # class Muldis::DB::Engine::Example::HostGateRtn

###########################################################################
###########################################################################

1; # Magic true value required at end of a reusable file's code.
__END__

=pod

=encoding utf8

=head1 NAME

Muldis::DB::Engine::Example -
Self-contained reference implementation of a Muldis::DB Engine

=head1 VERSION

This document describes Muldis::DB::Engine::Example version 0.0.1 for Perl
5.

=head1 SYNOPSIS

I<This documentation is pending.>

=head1 DESCRIPTION

I<This documentation is pending.>

=head1 INTERFACE

I<This documentation is pending; this section may also be split into
several.>

=head1 DIAGNOSTICS

I<This documentation is pending.>

=head1 CONFIGURATION AND ENVIRONMENT

I<This documentation is pending.>

=head1 DEPENDENCIES

This file requires any version of Perl 5.x.y that is at least 5.8.1.

It also requires these Perl 5 classes that are in the current distribution:
L<Muldis::DB-0.0.1|Muldis::DB>.

=head1 INCOMPATIBILITIES

None reported.

=head1 SEE ALSO

Go to L<Muldis::DB> for the majority of distribution-internal references,
and L<Muldis::DB::SeeAlso> for the majority of distribution-external
references.

=head1 BUGS AND LIMITATIONS

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
