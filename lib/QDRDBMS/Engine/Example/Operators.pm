use 5.008001;
use utf8;
use strict;
use warnings FATAL => 'all';

###########################################################################
###########################################################################

{ package QDRDBMS::Engine::Example::Operators; # module
    our $VERSION = 0.000000;

    use bigint; # this is experimental

    use Carp;

    use QDRDBMS::Engine::Example::PhysType
        qw( dBool dText dBlob dInt
            dTextKeyedMap dHeading dTuple dRelation );

    my $OPS = { # Hash

###########################################################################

## sys.type.Bool ##


## sys.type.Text ##


## sys.type.Blob ##


## sys.type.Int ##

'sys.rtn.Int.eq' => sub {
    my ($args) = @_;
    my ($v1, $v2) = @{$args}{'v1', 'v2'};
    return dBool( $v1->v() == $v2->v() );
},

'sys.rtn.Int.ne' => sub {
    my ($args) = @_;
    my ($v1, $v2) = @{$args}{'v1', 'v2'};
    return dBool( $v1->v() != $v2->v() );
},

'sys.rtn.Int.sum' => sub {
    my ($args) = @_;
    my ($v1, $v2) = @{$args}{'v1', 'v2'};
    return dInt( $v1->v() + $v2->v() );
},

'sys.rtn.Int.difference' => sub {
    my ($args) = @_;
    my ($start, $remove) = @{$args}{'start', 'remove'};
    return dInt( $start->v() - $remove->v() );
},

'sys.rtn.Int.product' => sub {
    my ($args) = @_;
    my ($v1, $v2) = @{$args}{'v1', 'v2'};
    return dInt( $v1->v() * $v2->v() );
},

'sys.rtn.Int.quotient' => sub {
    my ($args) = @_;
    my ($dividend, $divisor) = @{$args}{'dividend', 'divisor'};
    my $divisor_v = $divisor->v();
    confess q{sys.rtn.Int.quotient(): Arg :$divisor is zero.}
        if $divisor_v == 0;
    my $p5_num = $dividend->v() / $divisor_v;
    my $p5_int
        = int $p5_num == $p5_num ? $p5_num # includes $p5_num == 0
        : $p5_num > 0            ? int $p5_num     # floor(2.3)  ->  2
        :                          int $p5_num - 1 # floor(-2.3) -> -3
        ;
    return dInt( $p5_int );
},

'sys.rtn.Int.remainder' => sub {
    my ($args) = @_;
    my ($dividend, $divisor) = @{$args}{'dividend', 'divisor'};
    my $divisor_v = $divisor->v();
    confess q{sys.rtn.Int.remainder(): Arg :$divisor is zero.}
        if $divisor_v == 0;
    return dInt( $dividend->v() % $divisor_v );
},

'sys.rtn.Int.abs' => sub {
    my ($args) = @_;
    my ($v) = @{$args}{'v'};
    return dInt( abs $v->v() );
},

'sys.rtn.Int.power' => sub {
    my ($args) = @_;
    my ($radix, $exponent) = @{$args}{'radix', 'exponent'};
    return dInt( $radix->v() ** $exponent->v() );
},

## sys.type.Tuple ##


## sys.type.Relation ##


###########################################################################

    }; # my Hash $OPS

    sub get_ops {
        return $OPS;
    }

} # module QDRDBMS::Engine::Example::Operators

###########################################################################
###########################################################################

1; # Magic true value required at end of a reuseable file's code.
__END__

=pod

=encoding utf8

=head1 NAME

QDRDBMS::Engine::Example::Operators -
Implementations of all core QDRDBMS D system-defined operators

=head1 VERSION

This document describes QDRDBMS::Engine::Example::Operators version 0.0.0
for Perl 5.

=head1 DESCRIPTION

This file is used internally by L<QDRDBMS::Engine::Example>; it is not
intended to be used directly in user code.

It provides implementations of all core QDRDBMS D system-defined operators,
and their API is designed to exactly match the operator definitions in
L<QDRDBMS::Language>.

Specifically, this file implements the core system-defined operators that
all QDRDBMS D implementations must have, which is the selectors for and
general purpose functions and update operators for these data types: Bool,
Text, Blob, Int, Tuple, Relation, and the Cat.* types.

By contast, the operators specific to the optional data types are
implemented by other files: L<QDRDBMS::Engine::Example::Operators::Num>,
L<QDRDBMS::Engine::Example::Operators::Temporal>,
L<QDRDBMS::Engine::Example::Operators::Spatial>.

=head1 BUGS AND LIMITATIONS

The operators declared in this file assume that any user-defined QDRDBMS D
code which could be invoking them has already been validated by the QDRDBMS
D compiler, in so far as compile time validation can be done, and so the
operators in this file only test for invalid input such that couldn't be
expected to be caught at compile time.  For example, it is usually expected
that the compiler will catch attempts to invoke these operators with the
wrong number of arguments, or arguments with the wrong names or data types.
So if the compiler missed something which the runtime doesn't expect to
have to validate, then the Example Engine could have inelegant failures.

=head1 AUTHOR

Darren Duncan (C<perl@DarrenDuncan.net>)

=head1 LICENCE AND COPYRIGHT

This file is part of the QDRDBMS framework.

QDRDBMS is Copyright © 2002-2007, Darren Duncan.

See the LICENCE AND COPYRIGHT of L<QDRDBMS> for details.

=cut
