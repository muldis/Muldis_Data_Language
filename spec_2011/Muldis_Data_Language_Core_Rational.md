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
are specific to the core data type `Rat`, essentially all the generic ones
that a typical programming language should have.

*This documentation is pending.*

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

*This documentation is pending.*

# DATA TYPES THAT SUBTYPE RATIONALS

## sys.std.Core.Type.Rational.BRat

`BRat` (binary rational) is a proper
subtype of `Rat` where the `radix` is 2; it is the best option to exactly
represent rational numbers that are conceptually binary or octal or
hexadecimal, such as most IEEE-754 floating point numbers.

## sys.std.Core.Type.Rational.DRat

`DRat` (decimal rational) is a proper
subtype of `Rat` where the `radix` is 10 (or if it could be without the
`float` possrep normalization constraint); it is the best option to
exactly represent rational numbers that are conceptually the decimal
numbers that humans typically work with.

# FUNCTIONS IMPLEMENTING VIRTUAL ORDERED FUNCTIONS

## sys.std.Core.Rational.order

`function order (Order <-- topic : Rat,
other : Rat, misc_args? : Tuple, is_reverse_order? : Bool)
implements sys.std.Core.Ordered.order {...}`

This is a (total) `order-determination` function specific to `Rat`.  Its
only valid `misc_args` argument is `Tuple:D0`.

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
just one is left, which is the result.  If `topic` has zero values, then
`sum` results in the rational zero, which is the identity value for
addition.

## sys.std.Core.Rational.diff

`function diff (Rat <-- minuend : Rat,
subtrahend : Rat) implements sys.std.Core.Numeric.diff {...}`

This function results in the difference when its `subtrahend` argument is
subtracted from its `minuend` argument.

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
them together until just one is left, which is the result.  If `topic`
has zero values, then `product` results in the rational 1, which is the
identity value for multiplication.

## sys.std.Core.Rational.frac_quotient

`function frac_quotient (Rat <-- dividend : Rat,
divisor : Rat) implements sys.std.Core.Numeric.frac_quotient {...}`

This function results in the rational quotient when its `dividend`
argument is divided by its `divisor` argument using the semantics of real
number division.  This function will fail if `divisor` is zero.

## sys.std.Core.Rational.whole_quotient

`function whole_quotient (Int <--
dividend : Rat, divisor : Rat, round_meth : RoundMeth)
implements sys.std.Core.Numeric.whole_quotient {...}`

This function results in the integer quotient when its `dividend` argument
is divided by its `divisor` argument using the semantics of real number
division, and then the latter's result is rounded to the same or nearest
integer, where the nearest is determined by the rounding method specified
by the `round_meth` argument.  This function will fail if `divisor` is
zero.  I<TODO: Consider making the result a whole-number `Rat` instead.>

## sys.std.Core.Rational.remainder

`function remainder (Rat <--
dividend : Rat, divisor : Rat, round_meth : RoundMeth)
implements sys.std.Core.Numeric.remainder {...}`

This function results in the rational remainder when its `dividend`
argument is divided by its `divisor` argument using the semantics of real
number division, and then the latter's result is rounded to the same or
nearest integer.  The semantics of this function preserve the identity
C<x mod y = x - y * (x div y)> (read `x` as `dividend` and `y`
as `divisor`) where the division has the same semantics as
`sys.std.Core.Rational.whole_quotient` (rounding guided by `round_meth`);
the sign of this function's result always matches the sign of the dividend
or the divisor if `round_meth` is `ToZero` (aka *truncate*) or `Down`
(aka *floor*), respectively.  This function will fail if `divisor` is
zero.

## sys.std.Core.Rational.quot_and_rem

`function quot_and_rem (Tuple <--
dividend : Rat, divisor : Rat, round_meth : RoundMeth)
implements sys.std.Core.Numeric.quot_and_rem {...}`

This function results in a binary tuple whose attribute names are
`quotient` and `remainder` and whose respective attribute values are what
`sys.std.Core.Rational.whole_quotient` and
`sys.std.Core.Rational.remainder` would result in when given the same
arguments.  This function will fail if `divisor` is zero.

## sys.std.Core.Rational.range

`function range (Rat <-- topic : set_of.Rat)
implements sys.std.Core.Numeric.range {...}`

This function results in the difference between the lowest and highest
element values of its argument.  If `topic` has zero values, then
this function will fail.

## sys.std.Core.Rational.frac_mean

`function frac_mean (Rat <-- topic : bag_of.Rat)
implements sys.std.Core.Numeric.frac_mean {...}`

This function results in the rational mean or arithmetic average of the N
element values of its argument.  It is equivalent to first taking the sum
of the input values, and dividing that sum by the count of the input values
using the semantics of real number division.  If `topic` has zero values,
then this function will fail.

## sys.std.Core.Rational.median

`function median (set_of.Rat <--
topic : bag_of.Rat) implements sys.std.Core.Numeric.median {...}`

This function results in the 1 or 2 median values of the N element values
of its argument; they are returned as a set.  It is equivalent to first
arranging the input values from least to greatest, and then taking the
single middle value, if the count of input values is odd, or taking the 2
middle values, if the count of input values is even (but if the 2 middle
values are the same value, the output has one element).  If `topic` has
zero values, then the result set is empty.

## sys.std.Core.Rational.frac_mean_of_median

`function frac_mean_of_median (Rat <-- topic : bag_of.Rat)
implements sys.std.Core.Numeric.frac_mean_of_median {...}`

This function is a wrapper over `sys.std.Core.Rational.median` that will
result in the rational mean of its result elements; it will fail if there
are zero elements.

## sys.std.Core.Rational.mode

`function mode (set_of.Rat <--
topic : bag_of.Rat) implements sys.std.Core.Numeric.mode {...}`

This function results in the mode of the N element values of its argument;
it is the set of values that appear the most often as input elements, and
all have the same count of occurrances.  As a trivial case, if all input
elements have the same count of occurrances, then they will all be in the
output.  If `topic` has zero values, then the result set is empty.

## sys.std.Core.Rational.power_with_whole_exp

`function power_with_whole_exp (Rat <--
radix : Rat, exponent : Int)
implements sys.std.Core.Numeric.power_with_whole_exp {...}`

This function results in a rational number that is the result of its
`radix` argument taken to the power of its integer `exponent` argument.
This function will result in 1 if `radix` and `exponent` are both zero
(rather than failing).

# FUNCTIONS FOR RATIONAL MATH

These functions implement commonly used rational numeric operations.

## sys.std.Core.Rational.round

`function round (Rat <-- topic : Rat,
round_rule : RatRoundRule) {...}`

This function results in the rational that is equal to or otherwise nearest
to its `topic` argument, where the nearest is determined by the rational
rounding rule specified by the `round_rule` argument.

## sys.std.Core.Rational.power

`function power (PRat <-- radix : PRat,
exponent : Rat, round_rule : RatRoundRule) {...}`

This function results in its (positive rational) `radix` argument taken to
the power of its `exponent` argument.  Since the result would be an
irrational number in the general case, the `round_rule` argument specifies
how to coerce the conceptual result into a rational number that is the
actual result.  Note that, while this function might conceptually have
multiple real number results for some fractional `exponent`, it will
always only result in the one that is positive.  Note that this operation
is also known as *exponentiation* or `**`.

## sys.std.Core.Rational.log

`function log (Rat <-- topic : PRat,
radix : PRat, round_rule : RatRoundRule) {...}`

This function results in the logarithm of its `topic` argument to the base
given in its (positive rational) `radix` argument.  The `round_rule`
parameter is as per `power`.

## sys.std.Core.Rational.natural_power

`function natural_power (PRat <-- exponent : Rat,
round_rule : RatRoundRule) {...}`

This function results in the special mathematical constant *e* (which is
the base of the natural logarithm) taken to the power of its `exponent`
argument.  The `round_rule` parameter is as per `power`.  Note that this
operation is also known as `e**`.

## sys.std.Core.Rational.natural_log

`function natural_log (Rat <-- topic : PRat,
round_rule : RatRoundRule) {...}`

This function results in the natural logarithm of its `topic` argument.
The `round_rule` parameter is as per `power`.  Note that this operation
is also known as `log-e`.

# SYSTEM-SERVICES FOR RANDOM NUMBER GENERATORS

These system-service routines provide ways to get random numbers from the
system.  Where the results are in the range between truly random and
pseudo-random is, for the moment, an implementation detail, but the details
of these functions is subject to become more formalized later.

## sys.std.Core.Rational.fetch_random

C<system-service fetch_random (&target : Rat,
radix : PInt2_N, max_denom : PInt, interval : sp_interval_of.Rat) [...]>

This system-service routine will update the variable supplied as its
`target` argument so that it holds a randomly generated rational value
that is included within the interval defined by its `interval` argument.
The denominator attribute of the generated value will be a non-negative
power of `radix` that is not larger than `max_denom`.  This function will
fail if `interval` represents an empty interval.

# AUTHOR

Darren Duncan (`darren@DarrenDuncan.net`)

# LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
