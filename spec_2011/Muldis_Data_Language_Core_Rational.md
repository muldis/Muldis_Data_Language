# NAME

Muldis::D::Core::Rational - Muldis D rational numeric operators

# VERSION

This document is Muldis::D::Core::Rational version 0.148.1.

# PREFACE

This document is part of the Muldis D language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

This document describes essentially all of the core Muldis D operators that
are specific to the core data type C<Rat>, essentially all the generic ones
that a typical programming language should have.

I<This documentation is pending.>

# TYPE SUMMARY

Following are all the data types described in this document, arranged in a
type graph according to their proper sub|supertype relationships:

    sys.std.Core.Type.Universal
        sys.std.Core.Type.Scalar
            sys.std.Core.Type.DHScalar
                sys.std.Core.Type.Cat.DHScalarWP

                    # The following are all regular ordered scalar types.

                    sys.std.Core.Type.Rat
                        sys.std.Core.Type.Rational.BRat
                        sys.std.Core.Type.Rational.DRat

I<This documentation is pending.>

# DATA TYPES THAT SUBTYPE RATIONALS

## sys.std.Core.Type.Rational.BRat

C<BRat> (binary rational) is a proper
subtype of C<Rat> where the C<radix> is 2; it is the best option to exactly
represent rational numbers that are conceptually binary or octal or
hexadecimal, such as most IEEE-754 floating point numbers.

## sys.std.Core.Type.Rational.DRat

C<DRat> (decimal rational) is a proper
subtype of C<Rat> where the C<radix> is 10 (or if it could be without the
C<float> possrep normalization constraint); it is the best option to
exactly represent rational numbers that are conceptually the decimal
numbers that humans typically work with.

# FUNCTIONS IMPLEMENTING VIRTUAL ORDERED FUNCTIONS

## sys.std.Core.Rational.order

`function order (Order <-- topic : Rat,
other : Rat, misc_args? : Tuple, is_reverse_order? : Bool)
implements sys.std.Core.Ordered.order {...}`

This is a (total) C<order-determination> function specific to C<Rat>.  Its
only valid C<misc_args> argument is C<Tuple:D0>.

# FUNCTIONS IMPLEMENTING VIRTUAL NUMERIC FUNCTIONS

## sys.std.Core.Rational.abs

`function abs (NNRat <-- topic : Rat)
implements sys.std.Core.Numeric.abs {...}`

This function results in the absolute value of its argument.

## sys.std.Core.Rational.sum

`function sum (Rat <-- topic? : bag_of.Rat)
implements sys.std.Core.Numeric.sum {...}`

This function results in the sum of the N element values of its argument;
it is a reduction operator that recursively takes each pair of input values
and adds (which is both commutative and associative) them together until
just one is left, which is the result.  If C<topic> has zero values, then
C<sum> results in the rational zero, which is the identity value for
addition.

## sys.std.Core.Rational.diff

`function diff (Rat <-- minuend : Rat,
subtrahend : Rat) implements sys.std.Core.Numeric.diff {...}`

This function results in the difference when its C<subtrahend> argument is
subtracted from its C<minuend> argument.

## sys.std.Core.Rational.abs_diff

`function abs_diff (Rat <-- topic : Rat,
other : Rat) implements sys.std.Core.Numeric.abs_diff {...}`

This symmetric function results in the absolute difference between its 2
arguments.

## sys.std.Core.Rational.product

`function product (Rat <-- topic? : bag_of.Rat)
implements sys.std.Core.Numeric.product {...}`

This function results in the product of the N element values of its
argument; it is a reduction operator that recursively takes each pair of
input values and multiplies (which is both commutative and associative)
them together until just one is left, which is the result.  If C<topic>
has zero values, then C<product> results in the rational 1, which is the
identity value for multiplication.

## sys.std.Core.Rational.frac_quotient

`function frac_quotient (Rat <-- dividend : Rat,
divisor : Rat) implements sys.std.Core.Numeric.frac_quotient {...}`

This function results in the rational quotient when its C<dividend>
argument is divided by its C<divisor> argument using the semantics of real
number division.  This function will fail if C<divisor> is zero.

## sys.std.Core.Rational.whole_quotient

`function whole_quotient (Int <--
dividend : Rat, divisor : Rat, round_meth : RoundMeth)
implements sys.std.Core.Numeric.whole_quotient {...}`

This function results in the integer quotient when its C<dividend> argument
is divided by its C<divisor> argument using the semantics of real number
division, and then the latter's result is rounded to the same or nearest
integer, where the nearest is determined by the rounding method specified
by the C<round_meth> argument.  This function will fail if C<divisor> is
zero.  I<TODO: Consider making the result a whole-number C<Rat> instead.>

## sys.std.Core.Rational.remainder

`function remainder (Rat <--
dividend : Rat, divisor : Rat, round_meth : RoundMeth)
implements sys.std.Core.Numeric.remainder {...}`

This function results in the rational remainder when its C<dividend>
argument is divided by its C<divisor> argument using the semantics of real
number division, and then the latter's result is rounded to the same or
nearest integer.  The semantics of this function preserve the identity
C<x mod y = x - y * (x div y)> (read C<x> as C<dividend> and C<y>
as C<divisor>) where the division has the same semantics as
C<sys.std.Core.Rational.whole_quotient> (rounding guided by C<round_meth>);
the sign of this function's result always matches the sign of the dividend
or the divisor if C<round_meth> is C<ToZero> (aka I<truncate>) or C<Down>
(aka I<floor>), respectively.  This function will fail if C<divisor> is
zero.

## sys.std.Core.Rational.quot_and_rem

`function quot_and_rem (Tuple <--
dividend : Rat, divisor : Rat, round_meth : RoundMeth)
implements sys.std.Core.Numeric.quot_and_rem {...}`

This function results in a binary tuple whose attribute names are
C<quotient> and C<remainder> and whose respective attribute values are what
C<sys.std.Core.Rational.whole_quotient> and
C<sys.std.Core.Rational.remainder> would result in when given the same
arguments.  This function will fail if C<divisor> is zero.

## sys.std.Core.Rational.range

`function range (Rat <-- topic : set_of.Rat)
implements sys.std.Core.Numeric.range {...}`

This function results in the difference between the lowest and highest
element values of its argument.  If C<topic> has zero values, then
this function will fail.

## sys.std.Core.Rational.frac_mean

`function frac_mean (Rat <-- topic : bag_of.Rat)
implements sys.std.Core.Numeric.frac_mean {...}`

This function results in the rational mean or arithmetic average of the N
element values of its argument.  It is equivalent to first taking the sum
of the input values, and dividing that sum by the count of the input values
using the semantics of real number division.  If C<topic> has zero values,
then this function will fail.

## sys.std.Core.Rational.median

`function median (set_of.Rat <--
topic : bag_of.Rat) implements sys.std.Core.Numeric.median {...}`

This function results in the 1 or 2 median values of the N element values
of its argument; they are returned as a set.  It is equivalent to first
arranging the input values from least to greatest, and then taking the
single middle value, if the count of input values is odd, or taking the 2
middle values, if the count of input values is even (but if the 2 middle
values are the same value, the output has one element).  If C<topic> has
zero values, then the result set is empty.

## sys.std.Core.Rational.frac_mean_of_median

`function frac_mean_of_median (Rat <-- topic : bag_of.Rat)
implements sys.std.Core.Numeric.frac_mean_of_median {...}`

This function is a wrapper over C<sys.std.Core.Rational.median> that will
result in the rational mean of its result elements; it will fail if there
are zero elements.

## sys.std.Core.Rational.mode

`function mode (set_of.Rat <--
topic : bag_of.Rat) implements sys.std.Core.Numeric.mode {...}`

This function results in the mode of the N element values of its argument;
it is the set of values that appear the most often as input elements, and
all have the same count of occurrances.  As a trivial case, if all input
elements have the same count of occurrances, then they will all be in the
output.  If C<topic> has zero values, then the result set is empty.

## sys.std.Core.Rational.power_with_whole_exp

`function power_with_whole_exp (Rat <--
radix : Rat, exponent : Int)
implements sys.std.Core.Numeric.power_with_whole_exp {...}`

This function results in a rational number that is the result of its
C<radix> argument taken to the power of its integer C<exponent> argument.
This function will result in 1 if C<radix> and C<exponent> are both zero
(rather than failing).

# FUNCTIONS FOR RATIONAL MATH

These functions implement commonly used rational numeric operations.

## sys.std.Core.Rational.round

`function round (Rat <-- topic : Rat,
round_rule : RatRoundRule) {...}`

This function results in the rational that is equal to or otherwise nearest
to its C<topic> argument, where the nearest is determined by the rational
rounding rule specified by the C<round_rule> argument.

## sys.std.Core.Rational.power

`function power (PRat <-- radix : PRat,
exponent : Rat, round_rule : RatRoundRule) {...}`

This function results in its (positive rational) C<radix> argument taken to
the power of its C<exponent> argument.  Since the result would be an
irrational number in the general case, the C<round_rule> argument specifies
how to coerce the conceptual result into a rational number that is the
actual result.  Note that, while this function might conceptually have
multiple real number results for some fractional C<exponent>, it will
always only result in the one that is positive.  Note that this operation
is also known as I<exponentiation> or C<**>.

## sys.std.Core.Rational.log

`function log (Rat <-- topic : PRat,
radix : PRat, round_rule : RatRoundRule) {...}`

This function results in the logarithm of its C<topic> argument to the base
given in its (positive rational) C<radix> argument.  The C<round_rule>
parameter is as per C<power>.

## sys.std.Core.Rational.natural_power

`function natural_power (PRat <-- exponent : Rat,
round_rule : RatRoundRule) {...}`

This function results in the special mathematical constant I<e> (which is
the base of the natural logarithm) taken to the power of its C<exponent>
argument.  The C<round_rule> parameter is as per C<power>.  Note that this
operation is also known as C<e**>.

## sys.std.Core.Rational.natural_log

`function natural_log (Rat <-- topic : PRat,
round_rule : RatRoundRule) {...}`

This function results in the natural logarithm of its C<topic> argument.
The C<round_rule> parameter is as per C<power>.  Note that this operation
is also known as C<log-e>.

# SYSTEM-SERVICES FOR RANDOM NUMBER GENERATORS

These system-service routines provide ways to get random numbers from the
system.  Where the results are in the range between truly random and
pseudo-random is, for the moment, an implementation detail, but the details
of these functions is subject to become more formalized later.

## sys.std.Core.Rational.fetch_random

C<system-service fetch_random (&target : Rat,
radix : PInt2_N, max_denom : PInt, interval : sp_interval_of.Rat) [...]>

This system-service routine will update the variable supplied as its
C<target> argument so that it holds a randomly generated rational value
that is included within the interval defined by its C<interval> argument.
The denominator attribute of the generated value will be a non-negative
power of C<radix> that is not larger than C<max_denom>.  This function will
fail if C<interval> represents an empty interval.

# AUTHOR

Darren Duncan (C<darren@DarrenDuncan.net>)

# LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
