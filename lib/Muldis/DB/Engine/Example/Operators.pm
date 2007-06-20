use 5.008001;
use utf8;
use strict;
use warnings FATAL => 'all';

###########################################################################
###########################################################################

{ package Muldis::DB::Engine::Example::Operators; # module
    our $VERSION = 0.000000;

    use bigint; # this is experimental

    use Carp;

    use Muldis::DB::Engine::Example::PhysType qw(ptBool ptText ptBlob ptInt
        ptTuple ptQuasiTuple ptRelation ptQuasiRelation ptTypeInvoNQ
        ptTypeInvoAQ ptTypeDictNQ ptTypeDictAQ ptValueDictNQ ptTypeDictAQ);

    my $OPS = { # Hash

###########################################################################

## sys.type.Bool ##


## sys.type.Text ##


## sys.type.Blob ##


## sys.type.Int ##

'sys.rtn.Int.equal' => sub {
    my ($dbms, $ro_args) = @_;
    my ($v1, $v2) = @{$ro_args}{'v1', 'v2'};
    return ptBool({ 'v' => $v1->equal( $v2 ) });
},

'sys.rtn.Int.not_equal' => sub {
    my ($dbms, $ro_args) = @_;
    my ($v1, $v2) = @{$ro_args}{'v1', 'v2'};
    return ptBool({ 'v' => !$v1->equal( $v2 ) });
},

'sys.rtn.Int.assign' => sub {
    my ($dbms, $upd_args, $ro_args) = @_;
    my ($target) = @{$upd_args}{'target'};
    my ($v) = @{$ro_args}{'v'};
    $target->store( $v );
    return;
},

'sys.rtn.Int.sum' => sub {
    my ($dbms, $ro_args) = @_;
    my ($addends) = @{$ro_args}{'addends'};
    my $sum = 0;
    for my $addend (@{$addends->array_from_value_attr()}) {
        $sum += $addend->v();
    }
    return ptInt({ 'v' => $sum });
},

'sys.rtn.Int.difference' => sub {
    my ($dbms, $ro_args) = @_;
    my ($minuend, $subtrahend) = @{$ro_args}{'minuend', 'subtrahend'};
    return ptInt({ 'v' => $minuend->v() - $subtrahend->v() });
},

'sys.rtn.Int.product' => sub {
    my ($dbms, $ro_args) = @_;
    my ($factors) = @{$ro_args}{'factors'};
    my $product = 1;
    for my $factor (@{$factors->array_from_value_attr()}) {
        $product *= $factor->v();
    }
    return ptInt({ 'v' => $product });
},

'sys.rtn.Int.quotient' => sub {
    my ($dbms, $ro_args) = @_;
    my ($dividend, $divisor) = @{$ro_args}{'dividend', 'divisor'};
    my $divisor_v = $divisor->v();
    confess q{sys.rtn.Int.quotient(): Arg :$divisor is zero.}
        if $divisor_v == 0;
    my $p5_num = $dividend->v() / $divisor_v;
    my $p5_int
        = int $p5_num == $p5_num ? $p5_num # includes $p5_num == 0
        : $p5_num > 0            ? int $p5_num     # floor(2.3)  ->  2
        :                          int $p5_num - 1 # floor(-2.3) -> -3
        ;
    return ptInt({ 'v' => $p5_int });
},

'sys.rtn.Int.remainder' => sub {
    my ($dbms, $ro_args) = @_;
    my ($dividend, $divisor) = @{$ro_args}{'dividend', 'divisor'};
    my $divisor_v = $divisor->v();
    confess q{sys.rtn.Int.remainder(): Arg :$divisor is zero.}
        if $divisor_v == 0;
    return ptInt({ 'v' => $dividend->v() % $divisor_v });
},

'sys.rtn.Int.abs' => sub {
    my ($dbms, $ro_args) = @_;
    my ($v) = @{$ro_args}{'v'};
    return ptInt({ 'v' => abs $v->v() });
},

'sys.rtn.Int.power' => sub {
    my ($dbms, $ro_args) = @_;
    my ($radix, $exponent) = @{$ro_args}{'radix', 'exponent'};
    return ptInt({ 'v' => $radix->v() ** $exponent->v() });
},

## sys.type.Tuple ##


## sys.type.Relation ##


###########################################################################

    }; # my Hash $OPS

    sub get_ops {
        return $OPS;
    }

} # module Muldis::DB::Engine::Example::Operators

###########################################################################
###########################################################################

1; # Magic true value required at end of a reusable file's code.
__END__

=pod

=encoding utf8

=head1 NAME

Muldis::DB::Engine::Example::Operators -
Implementations of all core Muldis D system-defined operators

=head1 VERSION

This document describes Muldis::DB::Engine::Example::Operators version
0.0.0 for Perl 5.

=head1 DESCRIPTION

This file is used internally by L<Muldis::DB::Engine::Example>; it is not
intended to be used directly in user code.

It provides implementations of all core Muldis D system-defined operators,
and their API is designed to exactly match the operator definitions in
L<Muldis::DB::Language>.

Specifically, this file implements the core system-defined operators that
all Muldis D implementations must have, which is the selectors for and
general purpose functions and update operators for these data types: Bool,
Text, Blob, Int, Tuple, Relation, and the Cat.* types.

By contrast, the operators specific to the optional data types are
implemented by other files: L<Muldis::DB::Engine::Example::Operators::Num>,
L<Muldis::DB::Engine::Example::Operators::Temporal>,
L<Muldis::DB::Engine::Example::Operators::Spatial>.

=head1 BUGS AND LIMITATIONS

The operators declared in this file assume that any user-defined Muldis D
code which could be invoking them has already been validated by the Muldis
D compiler, in so far as compile time validation can be done, and so the
operators in this file only test for invalid input such that couldn't be
expected to be caught at compile time.  For example, it is usually expected
that the compiler will catch attempts to invoke these operators with the
wrong number of arguments, or arguments with the wrong names or data types.
So if the compiler missed something which the runtime doesn't expect to
have to validate, then the Example Engine could have inelegant failures.

=head1 AUTHOR

Darren Duncan (C<perl@DarrenDuncan.net>)

=head1 LICENSE AND COPYRIGHT

This file is part of the Muldis::DB framework.

Muldis::DB is Copyright © 2002-2007, Darren Duncan.

See the LICENSE AND COPYRIGHT of L<Muldis::DB> for details.

=cut
