# NAME

Muldis::D::Core::Blob - Muldis D bit string operators

# VERSION

This document is Muldis::D::Core::Blob version 0.148.1.

# PREFACE

This document is part of the Muldis D language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

This document describes essentially all of the core Muldis D operators that
are specific to the core data type `Blob`, essentially all the generic
ones that a typical programming language should have.

*This documentation is pending.*

# FUNCTIONS IMPLEMENTING VIRTUAL ORDERED FUNCTIONS

## sys.std.Core.Blob.order

`function order (Order <-- topic : Blob,
other : Blob, misc_args? : Tuple, is_reverse_order? : Bool)
implements sys.std.Core.Ordered.order {...}`

This is a (total) `order-determination` function specific to `Blob`.  Its
only valid `misc_args` argument is `Tuple:D0`.

# FUNCTIONS IMPLEMENTING VIRTUAL STRINGY FUNCTIONS

## sys.std.Core.Blob.catenation

`function catenation (Blob <--
topic? : array_of.Blob) implements sys.std.Core.Stringy.catenation {...}`

This function results in the catenation of the N element values of its
argument; it is a reduction operator that recursively takes each
consecutive pair of input values and catenates (which is associative) them
together until just one is left, which is the result.  If `topic` has zero
values, then `catenation` results in the empty string value, which is the
identity value for catenation.

## sys.std.Core.Blob.replication

`function replication (Blob <-- topic : Blob,
count : NNInt) implements sys.std.Core.Stringy.replication {...}`

This function results in the catenation of `count` instances of `topic`.

# GENERIC FUNCTIONS FOR BLOBS

These functions implement commonly used binary string operations.

## sys.std.Core.Blob.len_in_bits

`function len_in_bits (NNInt <-- topic : Blob) {...}`

This function results in the length of its argument in bits.

## sys.std.Core.Blob.len_in_octets

`function len_in_octets (NNInt <-- topic : OctetBlob) {...}`

This function results in the length of its argument in octets.

## sys.std.Core.Blob.has_substr_bits

`function has_substr_bits (Bool <-- look_in : Blob,
look_for : Blob, fixed_start? : Bool, fixed_end? : Bool) {...}`

This function results in `Bool:True` iff its `look_for` argument is a
substring of its `look_in` argument as per the optional `fixed_start` and
`fixed_end` constraints, and `Bool:False` otherwise.  If `fixed_start`
or `fixed_end` are `Bool:True`, then `look_for` must occur right at the
start or end, respectively, of `look_in` in order for `contains` to
results in `Bool:True`; if either flag is `Bool:False`, its additional
constraint doesn't apply.  Each of the `fixed_[start|end]` parameters is
optional and defaults to `Bool:False` if no explicit argument is given to
it.

## sys.std.Core.Blob.has_not_substr_bits

`function has_not_substr_bits (Bool <-- look_in : Blob,
look_for : Blob, fixed_start? : Bool, fixed_end? : Bool) {...}`

This function is exactly the same as `sys.std.Core.Blob.has_substr_bits`
except that it results in the opposite boolean value when given the same
arguments.

## sys.std.Core.Blob.has_substr_octets

`function has_substr_octets (Bool <-- look_in : OctetBlob,
look_for : OctetBlob, fixed_start? : Bool, fixed_end? : Bool) {...}`

This function is exactly the same as `sys.std.Core.Blob.has_substr_bits`
except that its main arguments are `OctetBlob` and it only looks for
substring matches on whole-octet boundaries of the `look_in` bit string.

## sys.std.Core.Blob.has_not_substr_octets

`function has_not_substr_octets (Bool <-- look_in : OctetBlob,
look_for : OctetBlob, fixed_start? : Bool, fixed_end? : Bool) {...}`

This function is to `has_substr_octets` as `has_not_substr_bits` is to
`has_substr_bits`.

## sys.std.Core.Blob.not

`function not (Blob <-- topic : Blob) {...}`

This function results in the bitwise *not* of its argument.

## sys.std.Core.Blob.and

`function and (Blob <-- topic : set_of.Blob) {...}`

This function is a reduction operator that recursively takes each pair of
its N input element values and does a bitwise *and* (which is commutative,
associative, and idempotent) on them until just one is left, which is the
function's result.  This function's argument values must all be of the same
length in bits, that length being part of the argument's declared type
(that is, `Blob` subtype) definition, and that is also the length in bits
of the function's result.  If `topic` has zero values, then this function
will fail.  Note that, conceptually `and` *does* have an identity value
which could be this function's result when `topic` has zero values, which
is an appropriate-length string of identity/1 valued bits; however, since a
`topic` with zero values wouldn't know the length in question, it seems
the best alternative is to require invoking code to work around the
limitation somehow, which might mean it will supply the identity value
explicitly as an extra `topic` element.

## sys.std.Core.Blob.or

`function or (Blob <-- topic : set_of.Blob) {...}`

This function is the same as `sys.std.Core.Blob.and` but that it
recursively does a bitwise inclusive-or rather than a bitwise *and*, and
its conceptual identity value is composed of zero valued bits.

## sys.std.Core.Blob.xor

`function xor (Blob <-- topic : bag_of.Blob) {...}`

This function is the same as `sys.std.Core.Blob.or` but that it
recursively does a bitwise exclusive-or rather than a bitwise inclusive-or.

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
