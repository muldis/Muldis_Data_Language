# NAME

Muldis Data Language Core Integer - Muldis Data Language integer numeric operators

# VERSION

This document is Muldis Data Language Core Integer version 0.148.1.

# PREFACE

This document is part of the Muldis Data Language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md);
you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

This document describes essentially all of the core Muldis Data Language operators that
are specific to the core data type `Int`, essentially all the generic ones
that a typical programming language should have.

*This documentation is pending.*

# FUNCTIONS IMPLEMENTING VIRTUAL ORDERED FUNCTIONS

## sys.std.Core.Integer.order

`function order (Order <-- topic : Int,
other : Int, misc_args? : Tuple, is_reverse_order? : Bool)
implements sys.std.Core.Ordered.order {...}`

This is a (total) `order-determination` function specific to `Int`.  Its
only valid `misc_args` argument is `Tuple:D0`.

# FUNCTIONS IMPLEMENTING VIRTUAL ORDINAL FUNCTIONS

## sys.std.Core.Integer.pred

`function pred (Int <-- topic : Int)
implements sys.std.Core.Ordered.Ordinal.pred {...}`

This function results in the value that precedes its argument.  It is a
shorthand for adding 1 to its argument.

## sys.std.Core.Integer.succ

`function succ (Int <-- topic : Int)
implements sys.std.Core.Ordered.Ordinal.succ {...}`

This function results in the value that succeeds its argument.  It is a
shorthand for subtracting 1 from its argument.

# FUNCTIONS IMPLEMENTING VIRTUAL NUMERIC FUNCTIONS

## sys.std.Core.Integer.abs

`function abs (NNInt <-- topic : Int)
implements sys.std.Core.Numeric.abs {...}`

This function results in the absolute value of its argument.

## sys.std.Core.Integer.sum

`function sum (Int <-- topic? : bag_of.Int)
implements sys.std.Core.Numeric.sum {...}`

This function results in the sum of the N element values of its argument;
it is a reduction operator that recursively takes each pair of input values
and adds (which is both commutative and associative) them together until
just one is left, which is the result.  If `topic` has zero values, then
`sum` results in the integer zero, which is the identity value for
addition.

## sys.std.Core.Integer.diff

`function diff (Int <-- minuend : Int, subtrahend : Int)
implements sys.std.Core.Numeric.diff {...}`

This function results in the difference when its `subtrahend` argument is
subtracted from its `minuend` argument.

## sys.std.Core.Integer.abs_diff

`function abs_diff (Int <-- topic : Int, other : Int)
implements sys.std.Core.Numeric.abs_diff {...}`

This symmetric function results in the absolute difference between its 2
arguments.

## sys.std.Core.Integer.product

`function product (Int <-- topic? : bag_of.Int)
implements sys.std.Core.Numeric.product {...}`

This function results in the product of the N element values of its
argument; it is a reduction operator that recursively takes each pair of
input values and multiplies (which is both commutative and associative)
them together until just one is left, which is the result.  If `topic`
has zero values, then `product` results in the integer 1, which is the
identity value for multiplication.

## sys.std.Core.Integer.frac_quotient

`function frac_quotient (Rat <-- dividend : Int, divisor : Int)
implements sys.std.Core.Numeric.frac_quotient {...}`

This function results in the rational quotient when its `dividend`
argument is divided by its `divisor` argument using the semantics of real
number division.  This function will fail if `divisor` is zero.  It is an
alternate way to construct a `Rat` literal at runtime in terms of 2 `Int`
that are its `numerator` and `denominator` possrep attributes.

## sys.std.Core.Integer.whole_quotient

`function whole_quotient (Int <--
dividend : Int, divisor : Int, round_meth : RoundMeth)
implements sys.std.Core.Numeric.whole_quotient {...}`

This function results in the integer quotient when its `dividend` argument
is divided by its `divisor` argument using the semantics of real number
division, and then the latter's result is rounded to the same or nearest
integer, where the nearest is determined by the rounding method specified
by the `round_meth` argument.  This function will fail if `divisor` is
zero.

## sys.std.Core.Integer.remainder

`function remainder (Int <--
dividend : Int, divisor : Int, round_meth : RoundMeth)
implements sys.std.Core.Numeric.remainder {...}`

This function results in the integer remainder when its `dividend`
argument is divided by its `divisor` argument using the semantics of real
number division, and then the latter's result is rounded to the same or
nearest integer.  The semantics of this function preserve the identity
`x mod y = x - y * (x div y)` (read `x` as `dividend` and `y`
as `divisor`) where the division has the same semantics as
`sys.std.Core.Integer.whole_quotient` (rounding guided by `round_meth`);
the sign of this function's result always matches the sign of the dividend
or the divisor if `round_meth` is `ToZero` (aka *truncate*) or `Down`
(aka *floor*), respectively.  This function will fail if `divisor` is
zero.

## sys.std.Core.Integer.quot_and_rem

`function quot_and_rem (Tuple <--
dividend : Int, divisor : Int, round_meth : RoundMeth)
implements sys.std.Core.Numeric.quot_and_rem {...}`

This function results in a binary tuple whose attribute names are
`quotient` and `remainder` and whose respective attribute values are what
`sys.std.Core.Integer.whole_quotient` and
`sys.std.Core.Integer.remainder` would result in when given the same
arguments.  This function will fail if `divisor` is zero.

## sys.std.Core.Integer.range

`function range (Int <-- topic : set_of.Int)
implements sys.std.Core.Numeric.range {...}`

This function results in the difference between the lowest and highest
element values of its argument.  If `topic` has zero values, then
this function will fail.

## sys.std.Core.Integer.frac_mean

`function frac_mean (Rat <-- topic : bag_of.Int)
implements sys.std.Core.Numeric.frac_mean {...}`

This function results in the rational mean or arithmetic average of the N
element values of its argument.  It is equivalent to first taking the sum
of the input values, and dividing that sum by the count of the input values
using the semantics of real number division.  If `topic` has zero values,
then this function will fail.

## sys.std.Core.Integer.median

`function median (set_of.Int <-- topic : bag_of.Int)
implements sys.std.Core.Numeric.median {...}`

This function results in the 1 or 2 median values of the N element values
of its argument; they are returned as a set.  It is equivalent to first
arranging the input values from least to greatest, and then taking the
single middle value, if the count of input values is odd, or taking the 2
middle values, if the count of input values is even (but if the 2 middle
values are the same value, the output has one element).  If `topic` has
zero values, then the result set is empty.

## sys.std.Core.Integer.frac_mean_of_median

`function frac_mean_of_median (Rat <-- topic : bag_of.Int)
implements sys.std.Core.Numeric.frac_mean_of_median {...}`

This function is a wrapper over `sys.std.Core.Integer.median` that will
result in the rational mean of its result elements; it will fail if there
are zero elements.

## sys.std.Core.Integer.mode

`function mode (set_of.Int <-- topic : bag_of.Int)
implements sys.std.Core.Numeric.mode {...}`

This function results in the mode of the N element values of its argument;
it is the set of values that appear the most often as input elements, and
all have the same count of occurrances.  As a trivial case, if all input
elements have the same count of occurrances, then they will all be in the
output.  If `topic` has zero values, then the result set is empty.

## sys.std.Core.Integer.power_with_whole_exp

`function power_with_whole_exp (Rat <--
radix : Int, exponent : Int)
implements sys.std.Core.Numeric.power_with_whole_exp {...}`

This function results in a rational number that is the result of its
`radix` argument taken to the power of its integer `exponent` argument.
This function will result in 1 if `radix` and `exponent` are both zero
(rather than failing).

# FUNCTIONS FOR INTEGER MATH

These functions implement commonly used integer numeric operations.

## sys.std.Core.Integer.whole_mean

`function whole_mean (Int <-- topic : bag_of.Int,
round_meth : RoundMeth) {...}`

This function results in the integer mean or arithmetic average of the N
element values of its argument.  It is equivalent to first taking the sum
of the input values, and dividing that sum by the count of the input
values, where the semantics of the division are the same as those of
`sys.std.Core.Integer.whole_quotient` (rounding the result of a real
number division as per `round_meth`).  If `topic` has zero values, then
this function will fail.

## sys.std.Core.Integer.whole_mean_of_median

`function whole_mean_of_median (Int <--
topic : bag_of.Int, round_meth : RoundMeth) {...}`

This function is a wrapper over `sys.std.Core.Integer.median` that will
result in the integer mean of its result elements; it will fail if there
are zero elements.

## sys.std.Core.Integer.power

`function power (Int <-- radix : Int, exponent : NNInt) {...}`

This function results in its `radix` argument taken to the power of its
(non-negative integer) `exponent` argument.  This function will result in
1 if `radix` and `exponent` are both zero (rather than failing), which
seems reasonable given that the `Integer.power` function strictly has no
numeric continuity (unlike `Rational.power`) and that this is by far the
most common practice in both pure integer math contexts and computer
languages, including SQL.  Note that this operation is also known as
*exponentiation* or `exp`.

## sys.std.Core.Integer.factorial

`function factorial (PInt <-- topic : NNInt) {...}`

This function results in the factorial of its argument (it is defined for
an argument of zero to result in 1, as per the identity value for
multiplication of an empty set).  Note that this operation is also known as
(postfix) `!`.

# UPDATERS IMPLEMENTING VIRTUAL ORDINAL FUNCTIONS

## sys.std.Core.Integer.assign_pred

`updater assign_pred (&topic : Int)
implements sys.std.Core.Ordered.Ordinal.assign_pred {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Integer.pred` function with the same argument, and
then assigning the result of that function to its argument.

## sys.std.Core.Integer.assign_succ

`updater assign_succ (&topic : Int)
implements sys.std.Core.Ordered.Ordinal.assign_succ {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Integer.succ` function with the same argument, and
then assigning the result of that function to its argument.

# SYSTEM-SERVICES FOR RANDOM NUMBER GENERATORS

These system-service routines provide ways to get random numbers from the
system.  Where the results are in the range between truly random and
pseudo-random is, for the moment, an implementation detail, but the details
of these functions is subject to become more formalized later.

## sys.std.Core.Integer.fetch_random

`system-service fetch_random (&target : Int,
interval : sp_interval_of.Int) [...]`

This system-service routine will update the variable supplied as its
`target` argument so that it holds a randomly generated integer value that
is included within the interval defined by its `interval` argument.  This
function will fail if `interval` represents an empty interval.

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Data Language** (**MDL**).

MDL is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of
[Muldis_Data_Language](Muldis_Data_Language.md) for details.
