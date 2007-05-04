use 5.008001;
use utf8;
use strict;
use warnings FATAL => 'all';

use QDRDBMS;
use QDRDBMS::Engine::Example::Operators;

###########################################################################
###########################################################################

{ package QDRDBMS::Engine::Example; # class
    our $VERSION = 0.000000;
    # Note: This given version applies to all of this file's packages.

    use base 'QDRDBMS::Engine::Role';

###########################################################################

sub new_dbms {
    my ($class, $args) = @_;
    my ($dbms_config) = @{$args}{'dbms_config'};
    return QDRDBMS::Engine::Example::DBMS->new({
        'dbms_config' => $dbms_config });
}

###########################################################################

} # class QDRDBMS::Engine::Example

###########################################################################
###########################################################################

{ package QDRDBMS::Engine::Example::DBMS; # class
    use base 'QDRDBMS::Engine::Role::DBMS';

    use Carp;

    my $ATTR_DBMS_CONFIG = 'dbms_config';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    my ($dbms_config) = @{$args}{'dbms_config'};

    $self->{$ATTR_DBMS_CONFIG} = $dbms_config;

    return $self;
}

###########################################################################

sub new_var {
    my ($self, $args) = @_;
    my ($decl_type) = @{$args}{'decl_type'};
    return QDRDBMS::Engine::Example::HostGateVar->new({
        'dbms' => $self, 'decl_type' => $decl_type });
}

sub prepare {
    my ($self, $args) = @_;
    my ($rtn_ast) = @{$args}{'rtn_ast'};
    return QDRDBMS::Engine::Example::HostGateRtn->new({
        'dbms' => $self, 'rtn_ast' => $rtn_ast });
}

###########################################################################

} # class QDRDBMS::Engine::Example::DBMS

###########################################################################
###########################################################################

{ package QDRDBMS::Engine::Example::HostGateVar; # class
    use base 'QDRDBMS::Engine::Role::HostGateVar';

    use Carp;

    my $ATTR_DBMS      = 'dbms';
    my $ATTR_DECL_TYPE = 'decl_type';
    my $ATTR_VAL_AST   = 'val_ast';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    my ($dbms, $decl_type) = @{$args}{'dbms', 'decl_type'};

    $self->{$ATTR_DBMS}      = $dbms;
    $self->{$ATTR_DECL_TYPE} = $decl_type;
    $self->{$ATTR_VAL_AST}   = undef; # TODO: make default val of decl type

    return $self;
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

} # class QDRDBMS::Engine::Example::HostGateVar

###########################################################################
###########################################################################

{ package QDRDBMS::Engine::Example::HostGateRtn; # class
    use base 'QDRDBMS::Engine::Role::HostGateRtn';

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
    my ($dbms, $rtn_ast) = @{$args}{'dbms', 'rtn_ast'};

    my $prep_rtn = sub { 1; }; # TODO; the real thing.

    $self->{$ATTR_DBMS}           = $dbms;
    $self->{$ATTR_RTN_AST}        = $rtn_ast;
    $self->{$ATTR_PREP_RTN}       = $prep_rtn;
    $self->{$ATTR_BOUND_UPD_ARGS} = {};
    $self->{$ATTR_BOUND_RO_ARGS}  = {};

    return $self;
}

###########################################################################

sub bind_host_params {
    my ($self, $args) = @_;
    my ($upd_args, $ro_args) = @{$args}{'upd_args', 'ro_args'};
    my $bound_upd_args = $self->{$ATTR_BOUND_UPD_ARGS};
    my $bound_ro_args = $self->{$ATTR_BOUND_RO_ARGS};
    # TODO: Compare declared type of each routine param and the variable
    # we are trying to bind to it, that they are of compatible types.
    foreach my $elem (@{$upd_args}) {
        $bound_upd_args->{$elem->[0]->text()} = $elem->[1];
    }
    foreach my $elem (@{$ro_args}) {
        $bound_ro_args->{$elem->[0]->text()} = $elem->[1];
    }
    return;
}

###########################################################################

sub execute {
    my ($self) = @_;
    $self->{$ATTR_PREP_RTN}->({ %{$self->{$ATTR_BOUND_UPD_ARGS}},
        %{$self->{$ATTR_BOUND_RO_ARGS}} });
    return;
}

###########################################################################

} # class QDRDBMS::Engine::Example::HostGateRtn

###########################################################################
###########################################################################

{ package QDRDBMS::Engine::Example::Value; # class



###########################################################################



###########################################################################

} # class QDRDBMS::Engine::Example::Value

###########################################################################
###########################################################################

1; # Magic true value required at end of a reuseable file's code.
__END__

=pod

=encoding utf8

=head1 NAME

QDRDBMS::Engine::Example -
Self-contained reference implementation of a QDRDBMS Engine

=head1 VERSION

This document describes QDRDBMS::Engine::Example version 0.0.0 for Perl 5.

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
L<QDRDBMS-0.0.0|QDRDBMS>.

=head1 INCOMPATIBILITIES

None reported.

=head1 SEE ALSO

Go to L<QDRDBMS> for the majority of distribution-internal references, and
L<QDRDBMS::SeeAlso> for the majority of distribution-external references.

=head1 BUGS AND LIMITATIONS

I<This documentation is pending.>

=head1 AUTHOR

Darren Duncan (C<perl@DarrenDuncan.net>)

=head1 LICENCE AND COPYRIGHT

This file is part of the QDRDBMS framework.

QDRDBMS is Copyright © 2002-2007, Darren Duncan.

See the LICENCE AND COPYRIGHT of L<QDRDBMS> for details.

=head1 ACKNOWLEDGEMENTS

The ACKNOWLEDGEMENTS in L<QDRDBMS> apply to this file too.

=cut
