# NAME

Muldis Data Language Core Boolean - Muldis Data Language boolean logic operators

# VERSION

This document is Muldis Data Language Core Boolean version 0.148.1.

# PREFACE

This document is part of the Muldis Data Language language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

This document describes essentially all of the core Muldis Data Language operators that
are specific to the core data type `Bool`, a superset of all the generic
ones that a typical programming language should have.

*This documentation is pending.*

# FUNCTIONS IMPLEMENTING VIRTUAL ORDERED FUNCTIONS

## sys.std.Core.Boolean.order

`function order (Order <-- topic : Bool,
other : Bool, misc_args? : Tuple, is_reverse_order? : Bool)
implements sys.std.Core.Ordered.order {...}`

This is a (total) `order-determination` function specific to `Bool`.  Its
only valid `misc_args` argument is `Tuple:D0`.

# FUNCTIONS IMPLEMENTING VIRTUAL ORDINAL FUNCTIONS

## sys.std.Core.Boolean.pred

`function pred (Bool <-- topic : Bool)
implements sys.std.Core.Ordered.Ordinal.pred {...}`

This function results in the value that precedes its argument.  It results
in `Bool:False` iff its argument is `Bool:True`, and `-Inf` otherwise.

## sys.std.Core.Boolean.succ

`function succ (Bool <-- topic : Bool)
implements sys.std.Core.Ordered.Ordinal.succ {...}`

This function results in the value that succeeds its argument.  It results
in `Bool:True` iff its argument is `Bool:False`, and `Inf` otherwise.

# FUNCTIONS FOR BOOLEAN LOGIC

These functions implement commonly used boolean logic operations.

## sys.std.Core.Boolean.not

`function not (Bool <-- topic : Bool) {...}`

This function results in the logical *not* of its argument.  This function
results in `Bool:True` iff its argument is `Bool:False`, and
`Bool:False` otherwise.  Note that this operation is also known as
*negation* or `¬` or (prefix) `!`.

There also exists conceptually the logical monadic operation called *so*
or *proposition* which results simply in its argument; this is the
complement operation of *not* or *negation*.  Now in practice any value
expression that is an invocation of *so* can simply be replaced with its
argument, so there is no reason for *so* to exist as an actual function.

## sys.std.Core.Boolean.and

`function and (Bool <-- topic? : set_of.Bool) {...}`

This function is a reduction operator that recursively takes each pair of
its N input element values and does a logical *and* (which is commutative,
associative, and idempotent) on them until just one is left, which is the
function's result.  For each pair of input values, the *and* of that pair
is `Bool:True` iff both input values are `Bool:True`, and `Bool:False`
otherwise.  If `topic` has zero values, then `and` results in
`Bool:True`, which is the identity value for logical *and*.  Note that
this operation is also known as *all* or *every* or *conjunction* or
`∧`.

## sys.std.Core.Boolean.all

`function all (Bool <-- topic? : set_of.Bool) {...}`

This function is an alias for `sys.std.Core.Boolean.and`.  This function
results in `Bool:True` iff all of its input element values are
`Bool:True` (or it has no input values), and `Bool:False` otherwise (when
it has at least one input value that is `Bool:False`).

## sys.std.Core.Boolean.nand

`function nand (Bool <-- topic : Bool, other : Bool) {...}`

This symmetric function results in `Bool:False` iff its 2
arguments are both `Bool:True`, and `Bool:True` otherwise.  Note that
this operation is also known as *not and* or *not both* or *alternative
denial* or `⊼` or `↑`.

## sys.std.Core.Boolean.or

`function or (Bool <-- topic? : set_of.Bool) {...}`

This function is a reduction operator that recursively takes each pair of
its N input element values and does a logical inclusive-or (which is
commutative, associative, and idempotent) on them until just one is left,
which is the function's result.  For each pair of input values, the *or*
of that pair is `Bool:False` iff both input values are `Bool:False`, and
`Bool:True` otherwise.  If `topic` has zero values, then `or` results in
`Bool:False`, which is the identity value for logical inclusive-or.  Note
that this operation is also known as *any* or *some* or *disjunction* or
`∨`.

## sys.std.Core.Boolean.any

`function any (Bool <-- topic? : set_of.Bool) {...}`

This function is an alias for `sys.std.Core.Boolean.or`.  This function
results in `Bool:True` iff any of its input element values are
`Bool:True`, and `Bool:False` otherwise (when all of its input values are
`Bool:False` or if it has no input values).

## sys.std.Core.Boolean.nor

`function nor (Bool <-- topic : Bool, other : Bool) {...}`

This symmetric function results in `Bool:True` iff its 2
arguments are both `Bool:False`, and `Bool:False` otherwise.  Note that
this operation is also known as *not or* or *neither ... nor* or *joint
denial* or `⊽` or `↓`.

## sys.std.Core.Boolean.xnor

`function xnor (Bool <-- topic? : bag_of.Bool) {...}`

This function is a reduction operator that recursively takes each pair of
its N input element values and does a logical xnor (which is both
commutative and associative) on them until just one is left, which is the
function's result.  For each pair of input values, the *xnor* of that pair
is `Bool:True` iff both input values are exactly the same value, and
`Bool:False` otherwise.  If `topic` has zero values, then `xnor` results
in `Bool:True`, which is the identity value for logical xnor.  Note that
this operation is also known as *not xor* or *iff* (*if and only if*) or
*material equivalence* or *biconditional* or *equivalent* (dyadic usage)
or *even parity* or `↔`.  Note that a dyadic (2 input value) invocation
of `xnor` is exactly the same operation as a
`sys.std.Core.Universal.is_same` invocation whose arguments are both
`Bool`-typed.

## sys.std.Core.Boolean.iff

`function iff (Bool <-- topic? : bag_of.Bool) {...}`

This function is an alias for `sys.std.Core.Boolean.xnor`.

## sys.std.Core.Boolean.xor

`function xor (Bool <-- topic? : bag_of.Bool) {...}`

This function is a reduction operator that recursively takes each pair of
its N input element values and does a logical exclusive-or (which is both
commutative and associative) on them until just one is left, which is the
function's result.  For each pair of input values, the *xor* of that pair
is `Bool:False` iff both input values are exactly the same value, and
`Bool:True` otherwise.  If `topic` has zero values, then `xor` results
in `Bool:False`, which is the identity value for logical exclusive-or.
Note that this operation is also known as *exclusive disjunction* or
*not equivalent* (dyadic usage) or *odd parity* or `⊻` or `↮`.  Note
that a dyadic (2 input value) invocation of `xor` is exactly the same
operation as a `sys.std.Core.Universal.is_not_same` invocation whose
arguments are both `Bool`-typed.

## sys.std.Core.Boolean.imp

`function imp (Bool <-- topic : Bool, other : Bool) {...}`

This function results in `Bool:False` iff its `topic` argument is
`Bool:True` and its `other` argument is `Bool:False`, and `Bool:True`
otherwise.  Note that this operation is also known as *implies* or
*material implication* or `→`.

## sys.std.Core.Boolean.implies

`function implies (Bool <-- topic : Bool, other : Bool) {...}`

This function is an alias for `sys.std.Core.Boolean.imp`.

## sys.std.Core.Boolean.nimp

`function nimp (Bool <-- topic : Bool, other : Bool) {...}`

This function is exactly the same as `sys.std.Core.Boolean.imp` except
that it results in the opposite boolean value when given the same
arguments.  Note that this operation is also known as *not implies* or
*material nonimplication* or `↛`.

## sys.std.Core.Boolean.if

`function if (Bool <-- topic : Bool, other : Bool) {...}`

This function is an alias for `sys.std.Core.Boolean.imp` except that it
transposes the `topic` and `other` arguments.  This function results in
`Bool:False` iff its `topic` argument is `Bool:False` and its `other`
argument is `Bool:True`, and `Bool:True` otherwise.  Note that this
operation is also known as *converse implication* or *reverse material
implication* or `←`.

## sys.std.Core.Boolean.nif

`function nif (Bool <-- topic : Bool, other : Bool) {...}`

This function is exactly the same as `sys.std.Core.Boolean.if` except that
it results in the opposite boolean value when given the same arguments.
Note that this operation is also known as *not if* or *converse
nonimplication* or `↚`.

## sys.std.Core.Boolean.not_all

`function not_all (Bool <-- topic? : set_of.Bool) {...}`

This function is exactly the same as `sys.std.Core.Boolean.all` except
that it results in the opposite boolean value when given the same argument.
This function results in `Bool:True` iff not all of its input element
values are `Bool:True`, and `Bool:False` otherwise (when all of its input
values are `Bool:True` or if it has no input values).

## sys.std.Core.Boolean.none

`function none (Bool <-- topic? : set_of.Bool) {...}`

This function is exactly the same as `sys.std.Core.Boolean.any` except
that it results in the opposite boolean value when given the same argument.
This function results in `Bool:True` iff none of its input element values
are `Bool:True` (or it has no input values), and `Bool:False` otherwise
(when it has at least one input value that is `Bool:True`).  Note that
this operation is also known as *not any*.

## sys.std.Core.Boolean.not_any

`function not_any (Bool <-- topic? : set_of.Bool) {...}`

This function is an alias for `sys.std.Core.Boolean.none`.

## sys.std.Core.Boolean.one

`function one (Bool <-- topic? : bag_of.Bool) {...}`

This function results in `Bool:True` iff exactly one of its input element
values is `Bool:True`, and `Bool:False` otherwise.  Note that in some
contexts, this operation would alternately be known as *xor*, but in
Muldis Data Language it is not.

## sys.std.Core.Boolean.not_one

`function not_one (Bool <-- topic? : bag_of.Bool) {...}`

This function is exactly the same as `sys.std.Core.Boolean.one` except
that it results in the opposite boolean value when given the same argument.

## sys.std.Core.Boolean.exactly

`function exactly (Bool <-- topic? : bag_of.Bool, count : NNInt) {...}`

This function results in `Bool:True` iff the count of its input element
values that are `Bool:True` matches the `count` argument, and
`Bool:False` otherwise.

## sys.std.Core.Boolean.not_exactly

`function not_exactly (Bool <--
topic? : bag_of.Bool, count : NNInt) {...}`

This function is exactly the same as `sys.std.Core.Boolean.exactly` except
that it results in the opposite boolean value when given the same argument.

## sys.std.Core.Boolean.true

`function true (NNInt <-- topic? : bag_of.Bool) {...}`

This function results in the count of its input element values that are
`Bool:True`.

## sys.std.Core.Boolean.false

`function false (NNInt <-- topic? : bag_of.Bool) {...}`

This function results in the count of its input element values that are
`Bool:False`.

# UPDATERS IMPLEMENTING VIRTUAL ORDINAL FUNCTIONS

## sys.std.Core.Boolean.assign_pred

`updater assign_pred (&topic : Bool)
implements sys.std.Core.Ordered.Ordinal.assign_pred {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Boolean.pred` function with the same argument, and
then assigning the result of that function to its argument.

## sys.std.Core.Boolean.assign_succ

`updater assign_succ (&topic : Bool)
implements sys.std.Core.Ordered.Ordinal.assign_succ {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Boolean.succ` function with the same argument, and
then assigning the result of that function to its argument.

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Data Language** (**MDL**).

MDL is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
