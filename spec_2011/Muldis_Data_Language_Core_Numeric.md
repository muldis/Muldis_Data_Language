# NAME

Muldis Data Language Core Numeric - Muldis Data Language generic numeric operators

# VERSION

This document is Muldis Data Language Core Numeric version 0.148.1.

# PREFACE

This document is part of the Muldis Data Language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

This document describes essentially all of the core Muldis Data Language
numeric operators, essentially all the generic ones that a
typical programming language should have.

*This documentation is pending.*

# VIRTUAL FUNCTIONS FOR THE NUMERIC MIXIN TYPE

## sys.std.Core.Numeric.abs

`function abs (Numeric <-- topic@ : Numeric) {...}`

This virtual function results in the absolute value of its argument.  Note
that this operation is also known as *modulus*.

## sys.std.Core.Numeric.sum

`function sum (Numeric <-- topic@ : bag_of.Numeric) {...}`

This virtual function results in the sum of the N element values of its
argument; it is a reduction operator that recursively takes each pair of
input values and adds (which is both commutative and associative) them
together until just one is left, which is the result.  Conceptually, if
`topic` has zero values, then `sum` results in the number zero, which is
the identity value for addition; however, while each implementing function
of `sum` could actually result in a type-specific value of zero, this
virtual function itself will instead fail when `topic` has zero values,
because then it would lack the necessary type information to know which
type-specific implementing function to dispatch to.  Note that this
operation is also known as *addition* or *plus* or `+`.

## sys.std.Core.Numeric.diff

`function diff (Numeric <-- minuend@ : Numeric,
subtrahend@ : Numeric) {...}`

This virtual function results in the difference when its `subtrahend`
argument is subtracted from its `minuend` argument.  Note that this
operation is also known as *subtraction* or *minus* or `-`.

## sys.std.Core.Numeric.abs_diff

`function abs_diff (Numeric <-- topic@ : Numeric,
other@ : Numeric) {...}`

This virtual symmetric function results in the absolute difference between
its 2 arguments.  Note that this operation is also known as `|-|`.

## sys.std.Core.Numeric.product

`function product (Numeric <-- topic@ : bag_of.Numeric) {...}`

This virtual function results in the product of the N element values of its
argument; it is a reduction operator that recursively takes each pair of
input values and multiplies (which is both commutative and associative)
them together until just one is left, which is the result.  Conceptually,
if `topic` has zero values, then `product` results in the number 1, which
is the identity value for multiplication; however, while each implementing
function of `product` could actually result in a type-specific value of 1,
this virtual function itself will instead fail when `topic` has zero
values, because then it would lack the necessary type information to know
which type-specific implementing function to dispatch to.  Note that this
operation is also known as *multiply* or *times* or `*`.

## sys.std.Core.Numeric.frac_quotient

`function frac_quotient (Numeric <--
dividend@ : Numeric, divisor@ : Numeric) {...}`

This virtual function results in the possibly-fractional quotient when its
`dividend` argument is divided by its `divisor` argument using the
semantics of real number division.  This function will fail if `divisor`
is zero.  Note that this operation is also known as *divide* or `/`.

## sys.std.Core.Numeric.whole_quotient

`function whole_quotient (Numeric <--
dividend@ : Numeric, divisor@ : Numeric, round_meth : RoundMeth) {...}`

This virtual function results in the whole-number quotient when its
`dividend` argument is divided by its `divisor` argument using the
semantics of real number division, and then the latter's result is rounded
to the same or nearest whole number, where the nearest is determined by the
rounding method specified by the `round_meth` argument.  This function
will fail if `divisor` is zero.  Note that this operation is also known as
*divide* or `div`.

## sys.std.Core.Numeric.remainder

`function remainder (Numeric <--
dividend@ : Numeric, divisor@ : Numeric, round_meth : RoundMeth) {...}`

This virtual function results in the possibly-fractional remainder when its
`dividend` argument is divided by its `divisor` argument using the
semantics of real number division, and then the latter's result is rounded
to the same or nearest whole number.  The semantics of this function
preserve the identity `x mod y = x - y * (x div y)` (read `x` as
`dividend` and `y` as `divisor`) where the division has the same
semantics as `sys.std.Core.Numeric.whole_quotient` (rounding guided by
`round_meth`); the sign of this function's result always matches the sign
of the dividend or the divisor if `round_meth` is `ToZero` (aka
*truncate*) or `Down` (aka *floor*), respectively.  This function will
fail if `divisor` is zero.  Note that this operation is also known as
*modulo* or `mod`.

## sys.std.Core.Numeric.quot_and_rem

`function quot_and_rem (Tuple <--
dividend@ : Numeric, divisor@ : Numeric, round_meth : RoundMeth) {...}`

This virtual function results in a binary tuple whose attribute names are
`quotient` and `remainder` and whose respective attribute values are what
`sys.std.Core.Numeric.whole_quotient` and
`sys.std.Core.Numeric.remainder` would result in when given the same
arguments.  This function will fail if `divisor` is zero.

## sys.std.Core.Numeric.range

`function range (Numeric <-- topic@ : set_of.Numeric) {...}`

This virtual function results in the difference between the lowest and
highest element values of its argument.  If `topic` has zero values, then
this function will fail.

## sys.std.Core.Numeric.frac_mean

`function frac_mean (Numeric <-- topic@ : bag_of.Numeric) {...}`

This virtual function results in the possibly-fractional mean or arithmetic
average of the N element values of its argument.  It is equivalent to first
taking the sum of the input values, and dividing that sum by the count of
the input values using the semantics of real number division.  If `topic`
has zero values, then this function will fail.

## sys.std.Core.Numeric.median

`function median (set_of.Numeric <-- topic@ : bag_of.Numeric) {...}`

This virtual function results in the 1 or 2 median values of the N element
values of its argument; they are returned as a set.  It is equivalent to
first arranging the input values from least to greatest, and then taking
the single middle value, if the count of input values is odd, or taking the
2 middle values, if the count of input values is even (but if the 2 middle
values are the same value, the output has one element).  If `topic` has
zero values, then the result set is empty.

## sys.std.Core.Numeric.frac_mean_of_median

`function frac_mean_of_median (Numeric <--
topic@ : bag_of.Numeric) {...}`

This virtual function is a wrapper over `sys.std.Core.Numeric.median` that
will result in the possibly-fractional mean of its result elements; it will
fail if there are zero elements.

## sys.std.Core.Numeric.mode

`function mode (set_of.Numeric <-- topic@ : bag_of.Numeric) {...}`

This virtual function results in the mode of the N element values of its
argument; it is the set of values that appear the most often as input
elements, and all have the same count of occurrances.  As a trivial case,
if all input elements have the same count of occurrances, then they will
all be in the output.  If `topic` has zero values, then the result set is
empty.

## sys.std.Core.Numeric.power_with_whole_exp

`function power_with_whole_exp (Numeric <--
radix@ : Numeric, exponent@ : Numeric) {...}`

This virtual function results in a possibly-fractional number that is the
result of its possibly-fractional `radix` argument taken to the power of
its whole-number `exponent` argument.  Because this function constrains
its `exponent` argument to being a whole number, then when its `radix`
argument is any real or rational number at all, this function is guaranteed
to have a naturally real and rational result, even when `radix` is a
negative number.  The only way that this operation could conceivably result
in a naturally complex or irrational number when its `radix` is rational
is if its `exponent` is a fractional number.  This function will result in
1 if `radix` and `exponent` are both zero (rather than failing).  Note
that this operation is also known as *exponentiation* or `^`.

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Data Language** (**MDL**).

MDL is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
