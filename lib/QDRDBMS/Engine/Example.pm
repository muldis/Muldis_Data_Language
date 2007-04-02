use 5.008001;
use utf8;
use strict;
use warnings FATAL => 'all';

use QDRDBMS;
use QDRDBMS::Engine::Example::PhysType;

###########################################################################
###########################################################################

my $EMPTY_STR = q{};

###########################################################################
###########################################################################

{ package QDRDBMS::Engine::Example; # package
    our $VERSION = 0.000;
    # Note: This given version applies to all of this file's packages.

###########################################################################

sub new_dbms {
    my (undef, $args) = @_;
    return QDRDBMS::Engine::Example::DBMS->new( $args );
}

###########################################################################

} # package QDRDBMS::Engine::Example

###########################################################################
###########################################################################

{ package QDRDBMS::Engine::Example::DBMS; # class
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

} # class QDRDBMS::Engine::Example::DBMS

###########################################################################
###########################################################################

{ package QDRDBMS::Engine::Example::Command; # class



###########################################################################



###########################################################################

} # class QDRDBMS::Engine::Example::Command

###########################################################################
###########################################################################

{ package QDRDBMS::Engine::Example::Value; # class



###########################################################################



###########################################################################

} # class QDRDBMS::Engine::Example::Value

###########################################################################
###########################################################################

{ package QDRDBMS::Engine::Example::Variable; # class



###########################################################################



###########################################################################

} # class QDRDBMS::Engine::Example::Variable

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

This document describes QDRDBMS::Engine::Example version 0.0.0.

=head1 SYNOPSIS

I<This documentation is pending.>

=head1 DESCRIPTION

I<This documentation is pending.>

=head1 INTERFACE

I<This documentation is pending; this section may also be split into several.>

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

QDRDBMS is Copyright (c) 2002-2007, Darren Duncan.

See the LICENCE AND COPYRIGHT of L<QDRDBMS> for details.

=head1 ACKNOWLEDGEMENTS

The ACKNOWLEDGEMENTS in L<QDRDBMS> apply to this file too.

=cut
