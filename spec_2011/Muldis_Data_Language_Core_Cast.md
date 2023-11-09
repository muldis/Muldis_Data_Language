# NAME

Muldis::D::Core::Cast - Muldis D explicit type-casting operators

# VERSION

This document is Muldis::D::Core::Cast version 0.148.1.

# PREFACE

This document is part of the Muldis D language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

This document's purpose is to consolidate all the core Muldis D
type-casting routines that are conceptually monadic functions between 2
core types.  It also declares a few special data types that support them.

*This documentation is pending.*

# TYPE SUMMARY

Following are all the data types described in this document, arranged in a
type graph according to their proper sub|supertype relationships:

    sys.std.Core.Type.Universal
        sys.std.Core.Type.Scalar
            sys.std.Core.Type.DHScalar
                sys.std.Core.Type.Int
                    sys.std.Core.Type.NNInt
                        sys.std.Core.Type.PInt

                            # These are all finite integer types.

                            sys.std.Core.Type.Cast.PInt1_4
                            sys.std.Core.Type.Cast.PInt2_36

*This documentation is pending.*

# DATA TYPES FOR ENCODING SCALARS AS TEXTS

## sys.std.Core.Type.Cast.PInt1_4

`PInt1_4` is a proper subtype of
`PInt` where all member values are between 1 and 4.  Its maximum value is
4.  The cardinality of this type is 4.

## sys.std.Core.Type.Cast.PInt2_36

`PInt2_36` is a proper subtype of
`PInt` where all member values are between 2 and 36.  (The significance of
the number 36 is 10 digits plus 26 letters.)  Its default value is 10 (to
correspond to base-10 being the default base for numeric literals in the
STD dialects when no explicit base is given); its minimum and maximum
values are 2 and 36, respectively.  The cardinality of this type is 35.

# FUNCTIONS FOR CASTING BETWEEN TUPLES AND SINGLE-TUPLE RELATIONS

## sys.std.Core.Cast.Tuple_from_Relation

`function Tuple_from_Relation (Tuple <-- topic : Relation) {...}`

This function results in the `Tuple` that is the sole member tuple of
its argument.  This function will fail if its argument does not have
exactly one tuple.  Note that this operation is also known as `%`.

## sys.std.Core.Cast.Relation_from_Tuple

`function Relation_from_Tuple (Relation <-- topic : Tuple) {...}`

This function results in the `Relation` value those body has just the one
`Tuple` that is its argument.  Note that this operation is also known as
`@`.

# FUNCTIONS FOR CASTING BETWEEN CANONICAL SETS AND BAGS

## sys.std.Core.Cast.Set_from_Bag

`function Set_from_Bag (Set <-- topic : Bag) {...}`

This function results in the `Set` that is the projection of the `value`
attribute of its `Bag` argument.

## sys.std.Core.Cast.Bag_from_Set

`function Bag_from_Set (Bag <-- topic : Set) {...}`

This function results in the `Bag` that is the extension of its `Set`
argument with a new `count` attribute whose value for every tuple is 1.

# FUNCTIONS FOR CASTING BETWEEN INTEGERS AND RATIONALS

These functions convert between `Rat` values and equal or nearly equal
`Int` values.

## sys.std.Core.Cast.Int_from_Rat

`function Int_from_Rat (Int <-- rat : Rat,
round_meth : RoundMeth) {...}`

This selector function results in the `Int` value that is conceptually
equal to or otherwise nearest to its `rat` argument, where the nearest is
determined by the rounding method specified by the `round_meth` argument.

## sys.std.Core.Cast.Rat_from_Int

`function Rat_from_Int (Rat <-- int : Int) {...}`

This selector function results in the `Rat` value that is conceptually
equal to its `Int` argument.

# FUNCTIONS FOR ENCODING INTEGERS AS TEXTS

These functions convert between `Int` values and canonically formatted
representations of integers as character strings.

## sys.std.Core.Cast.Int_from_Text

`function Int_from_Text (Int <-- text : Text,
radix? : PInt2_36) {...}`

This selector function results in the `Int` value that its (not-empty)
`text` argument maps to when the whole character string is evaluated as a
base-`radix` integer.  Extending the typical formats of [base-2, base-8,
base-10, base-16], this function supports base-2 through base-36; to get
the latter, the characters 0-9 and A-Z represent values in 0-35.  This
function will fail if `text` can't be mapped as specified.

## sys.std.Core.Cast.Text_from_Int

`function Text_from_Int (Text <-- int : Int, radix? : PInt2_36) {...}`

This selector function results in the (not-empty) `Text` value where its
`int` argument is formatted as a base-`radix` integer.

# FUNCTIONS FOR ENCODING RATIONALS AS TEXTS

These functions convert between `Rat` values and canonically formatted
representations of rationals as character strings.

## sys.std.Core.Cast.Rat_from_Text

`function Rat_from_Text (Rat <-- text : Text,
radix? : PInt2_36) {...}`

This selector function results in the `Rat` value that its (not-empty)
`text` argument maps to when the whole character string is evaluated as a
base-`radix` rational.  Extending the typical formats of [base-2, base-8,
base-10, base-16], this function supports base-2 through base-36; to get
the latter, the characters 0-9 and A-Z represent values in 0-35.  This
function will fail if `text` can't be mapped as specified.

## sys.std.Core.Cast.Text_from_Rat

`function Text_from_Rat (Text <-- rat : Rat, radix? : PInt2_36) {...}`

This selector function results in the (not-empty) `Text` value where its
`rat` argument is formatted as a base-`radix` rational.

# FUNCTIONS FOR ENCODING BLOBS AS TEXTS

These functions convert between `Blob` values and canonically formatted
representations of binary strings as character strings.

## sys.std.Core.Cast.Blob_from_Text

`function Blob_from_Text (Blob <-- text : Text, size : PInt1_4) {...}`

This selector function results in the `Blob` value that its `text`
argument maps to when each input character represents a sequence of 1-4
bits, the number of bits per character being determined by the `size`
argument; for example, if `size` is 1, then each input character is a
[0..1] and represents a bit; or, if `size` is 4, then each input character
is a [0..9A..Fa..f] and represents 4 bits.  This function will fail if
`text` can't be mapped as specified.

## sys.std.Core.Cast.Text_from_Blob

`function Text_from_Blob (Text <-- blob : Blob, size : PInt1_4) {...}`

This selector function results in the `Text` value where its argument is
encoded using a character for each sequence of 1-4 bits, the number of bits
per character being determined by the `size` argument.  This function will
fail if `blob` doesn't have a length in bits which is a multiple of
`size`.  Any alpha characters in the result are in uppercase.

# FUNCTIONS FOR ENCODING INTEGERS AS BLOBS

These functions convert between `Int` values and canonically formatted
representations of integers as binary strings.  *Conjecture: These may not
actually be useful, and perhaps only operators that take an argument
specifying a fixed-length field size, with big and little endian versions,
would be appropriate instead.  Or maybe both kinds are necessary.*

## sys.std.Core.Cast.Int_from_Blob_S_VBE

`function Int_from_Blob_S_VBE (Int <-- blob : Blob) {...}`

This selector function results in the `Int` value that its `blob`
argument maps to when the whole bit string is treated literally as a
variable-length binary (two's complement) signed integer of 1 or more bits
in length.  The first bit is taken as the sign bit, and any other bits
provide greater precision than the -1 thru 0 range.  The bit string is
assumed to be big-endian, since it may not be possible to use little-endian
in situations where the bit length isn't a multiple of 8.

## sys.std.Core.Cast.Blob_S_VBE_from_Int

`function Blob_S_VBE_from_Int (Blob <-- int : Int) {...}`

This selector function results in the `Blob` value where its `int`
argument is formatted as a variable-length binary (two's complement) signed
integer of 1 or more bits in length; the smallest number of bits necessary
to store `int` is used.

## sys.std.Core.Cast.Int_from_Blob_U_VBE

`function Int_from_Blob_U_VBE (NNInt <-- blob : Blob) {...}`

This function is the same as `sys.std.Core.Cast.Int_from_Blob_S_VBE` but
that it does unsigned integers.

## sys.std.Core.Cast.Blob_U_VBE_from_Int

`function Blob_U_VBE_from_Int (NNInt <-- blob : Blob) {...}`

This function is the same as `sys.std.Core.Cast.Blob_S_VBE_from_Int` but
that it does unsigned integers.

# AUTHOR

Darren Duncan (`darren@DarrenDuncan.net`)

# LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
