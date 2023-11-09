# NAME

Muldis::D::Core::Types - Muldis D general purpose data types

# VERSION

This document is Muldis::D::Core::Types version 0.148.1.

# PREFACE

This document is part of the Muldis D language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

These core data types are general-purpose in nature and are intended
for use in defining or working with normal user data.

# TYPE SUMMARY

This section shows all the data types and data type factories described in
this document, arranged in a type graph according to their proper
sub|supertype relationships.  Since there are a number of types with
multiple parents, those types may appear multiple times in the graph;
moreover, the graph is displayed in multiple slices, some of which are
different views of the same type relationships.  As a notable exception,
`sys.std.Core.Type.Empty` is a proper subtype of *all* of the other types
in this graph, but it is only shown once.

This graph slice shows all of the top-level types as is relevant from the
user's point of view:

    sys.std.Core.Type.Universal
        sys.std.Core.Type.Empty
        sys.std.Core.Type.Scalar
            sys.std.Core.Type.DHScalar
                sys.std.Core.Type.Bool
                sys.std.Core.Type.Int
                sys.std.Core.Type.Rat
                sys.std.Core.Type.Blob
                sys.std.Core.Type.Text
        sys.std.Core.Type.Tuple
            sys.std.Core.Type.DHTuple
                sys.std.Core.Type.Database
        sys.std.Core.Type.Relation
            sys.std.Core.Type.DHRelation
        sys.std.Core.Type.External

This arrangement is user-significant for 2 main reasons.  The first reason
is that general semantics and intended interpretations of values and types
fall into 4 main lines, represented by `Scalar|Tuple|Relation|External`.
The second reason is that only values of the 3 deeply-homogeneous types
shown above (`DH[Scalar|Tuple|Relation]`) may be used in a database; all
values not of those types may only be used transiently.  The fact that
`Int` is atomic while the other scalar types aren't is not relevant to
users in the general case.

This graph slice shows all of those same top-level types, plus a few more,
as is relevant from the implementer's point of view:

    sys.std.Core.Type.Universal
        sys.std.Core.Type.Int
        sys.std.Core.Type.Cat.List
            sys.std.Core.Type.Cat.Structure
                sys.std.Core.Type.Cat.String
                sys.std.Core.Type.Tuple
                    sys.std.Core.Type.DHTuple
                        sys.std.Core.Type.Database
                sys.std.Core.Type.Relation
                    sys.std.Core.Type.DHRelation
                sys.std.Core.Type.Cat.ScalarWP
                    sys.std.Core.Type.Cat.DHScalarWP
                        sys.std.Core.Type.Bool
                        sys.std.Core.Type.Rat
                        sys.std.Core.Type.Blob
                        sys.std.Core.Type.Text
                sys.std.Core.Type.External
            sys.std.Core.Type.Cat.Nonstructure

This arrangement is implementer-significant because it best illustrates the
conceptual implementation of the types; `Int` and `List` are the only 2
types that actually introduce values into the type system, and all other
types are subset and/or union types composing their values; so, *every*
Muldis D value either *is* an `Int` or *is* a `List`.  The fact that
`Scalar` composes both `Int` and `List` values while
`Tuple|Relation|External` compose only `List` values is less important.

This graph slice shows all of the general-purpose system-defined scalar
types:

    sys.std.Core.Type.Universal
        sys.std.Core.Type.Scalar
            sys.std.Core.Type.Cat.ScalarWP
                sys.std.Core.Type.Cat.DHScalarWP
            sys.std.Core.Type.DHScalar
                sys.std.Core.Type.Int
                    sys.std.Core.Type.NNInt
                        sys.std.Core.Type.PInt
                            sys.std.Core.Type.PInt2_N
                sys.std.Core.Type.Cat.String
                sys.std.Core.Type.Cat.DHScalarWP
                    sys.std.Core.Type.Bool
                        sys.std.Core.Type.Bool.*
                    sys.std.Core.Type.Rat
                        sys.std.Core.Type.NNRat
                            sys.std.Core.Type.PRat
                    sys.std.Core.Type.Blob
                        sys.std.Core.Type.OctetBlob
                    sys.std.Core.Type.Text
                        sys.std.Core.Type.Text.Unicode
                            sys.std.Core.Type.Text.Unicode.Canon
                                sys.std.Core.Type.Text.Unicode.Compat
                            sys.std.Core.Type.Text.ASCII
                            sys.std.Core.Type.Text.Latin1

To be clear, `ScalarWP` is the intersection type of `List` and `Scalar`,
and `DHScalarWP` is the intersection type of `ScalarWP` and `DHScalar`;
or, `Scalar` is the union type of just `Int`, `String` and `ScalarWP`,
and `DHScalar` is the union type of just `Int`, `String` and
`DHScalarWP`.

This graph slice shows all of the general-purpose system-defined nonscalar
type factories:

    sys.std.Core.Type.Universal
        sys.std.Core.Type.Cat.List
            sys.std.Core.Type.Cat.Structure

                sys.std.Core.Type.Tuple
                    sys.std.Core.Type.DHTuple
                        sys.std.Core.Type.Database
                    sys.std.Core.Type.Set.T
                        sys.std.Core.Type.DHSet.T
                    sys.std.Core.Type.Array.T
                        sys.std.Core.Type.DHArray.T
                    sys.std.Core.Type.Bag.T
                        sys.std.Core.Type.DHBag.T
                    sys.std.Core.Type.SPInterval
                        sys.std.Core.Type.DHSPInterval

                sys.std.Core.Type.Relation
                    sys.std.Core.Type.DHRelation
                    sys.std.Core.Type.Set
                        sys.std.Core.Type.DHSet
                        sys.std.Core.Type.Maybe
                            sys.std.Core.Type.DHMaybe
                            sys.std.Core.Type.Just
                                sys.std.Core.Type.DHJust
                    sys.std.Core.Type.Array
                        sys.std.Core.Type.DHArray
                    sys.std.Core.Type.Bag
                        sys.std.Core.Type.DHBag
                    sys.std.Core.Type.MPInterval
                        sys.std.Core.Type.DHMPInterval

This graph slice shows all of those same nonscalar types, with a different
view of their relationships:

    sys.std.Core.Type.Universal
        sys.std.Core.Type.Cat.List
            sys.std.Core.Type.Cat.Structure

                sys.std.Core.Type.Tuple
                    sys.std.Core.Type.DHTuple
                        sys.std.Core.Type.Database
                        sys.std.Core.Type.DHSet.T
                        sys.std.Core.Type.DHArray.T
                        sys.std.Core.Type.DHBag.T
                        sys.std.Core.Type.DHSPInterval
                    sys.std.Core.Type.Set.T
                    sys.std.Core.Type.Array.T
                    sys.std.Core.Type.Bag.T
                    sys.std.Core.Type.SPInterval

                sys.std.Core.Type.Relation
                    sys.std.Core.Type.DHRelation
                        sys.std.Core.Type.DHSet
                            sys.std.Core.Type.DHMaybe
                                sys.std.Core.Type.DHJust
                        sys.std.Core.Type.DHArray
                        sys.std.Core.Type.DHBag
                        sys.std.Core.Type.DHMPInterval
                    sys.std.Core.Type.Set
                        sys.std.Core.Type.Maybe
                            sys.std.Core.Type.Just
                    sys.std.Core.Type.Array
                    sys.std.Core.Type.Bag
                    sys.std.Core.Type.MPInterval

To be clear, all of the nonscalar `DH`-prefixed types except for
`DH[Tuple|Relation]` are intersection types of one of the latter two plus
the same-named types sans the prefix.

This graph slice shows all of the general-purpose system-defined types that
compose any mixin types, shown grouped under the mixin types that they
compose:

    sys.std.Core.Type.Universal

        sys.std.Core.Type.Ordered

            sys.std.Core.Type.Rat
            sys.std.Core.Type.Blob
            sys.std.Core.Type.Text

            sys.std.Core.Type.Ordinal

                sys.std.Core.Type.Bool
                sys.std.Core.Type.Int

        sys.std.Core.Type.Numeric

            sys.std.Core.Type.Int
            sys.std.Core.Type.Rat

        sys.std.Core.Type.Stringy

            sys.std.Core.Type.Blob
            sys.std.Core.Type.Array

            sys.std.Core.Type.Textual

                sys.std.Core.Type.Text

        sys.std.Core.Type.Attributive

            sys.std.Core.Type.Tuple
            sys.std.Core.Type.Relation

        sys.std.Core.Type.Collective

            sys.std.Core.Type.Set
            sys.std.Core.Type.Array
            sys.std.Core.Type.Bag
            sys.std.Core.Type.SPInterval
            sys.std.Core.Type.MPInterval

# MAXIMAL AND MINIMAL DATA TYPES

These core data types are special and are the only Muldis D types (except
for `sys.std.Core.Type.Cat.[List|Structure]`) that are neither just scalar
nor nonscalar nor external nor nonstructure types.  They are all
system-defined and it is impossible for users to define more types of this
nature.

## sys.std.Core.Type.Universal

The `Universal` type is the maximal
type of the entire Muldis D type system, and contains every value that can
possibly exist.  Every other (non-aliased) type is implicitly a proper
subtype of `Universal`, and `Universal` is implicitly a union type over
all other types.  Its default value is `Bool:False`.  The cardinality of
this type is infinity.  `Universal` is the nullary-domain-intersection
type.  Considering the low-level type system, `Universal` is the
domain-union type of just the 2 types `Int` and `List`.

## sys.std.Core.Type.Empty

The `Empty` type is the minimal type of
the entire Muldis D type system, and is the only type that contains exactly
zero values.  Every other (non-aliased) type is implicitly a proper
supertype of `Empty` and `Empty` is implicitly an intersection type over
all other types.  It has no default value.  The cardinality of this type is
zero.  `Empty` is the nullary-domain-union type.  Considering the
low-level type system, `Empty` is the domain-intersection type of just the
2 types `Int` and `List`.

# GENERIC MIXIN DATA TYPES

## sys.std.Core.Type.Ordered

The `Ordered` type is a mixin (union) type that is intended to be
explicitly composed by all other types that are considered *ordered*.  An
ordered type is a type for which one can take all of its values and place
them on a line such that each value is definatively considered *before*
all of the values one one side and *after* all of the values on the other
side.  A typical ordered type is a scalar type, but not-scalar types can
also be ordered.  Almost all system-defined scalar types are also ordered
types, including: `Bool`, `Int`, `Rat`, `Blob`, `Text`.  The
cardinality of `Ordered` is infinity.  The default value of `Ordered` is
`Bool:False`.  The minimum and maximum values of `Ordered` are `-Inf`
and `Inf`, respectively; these 2 values are special singleton scalar types
that are canonically considered to be before and after, respectively,
*every* other value of the Muldis D type system, regardless of whether
those values are composed into an ordered type.

## sys.std.Core.Type.Ordinal

The `Ordinal` type is a mixin (union) type that is intended to be
explicitly composed by all other types that are considered *ordinal*.  An
ordinal type is an ordered type for which one can take any one of its
values and derive a definitive predecessor or successor value, iff the
initial value isn't the first or last value on the line.  Similarly, one
can take any two values of an ordinal type and produce an ordered list of
all of that value's types which are on the line between those two values.
The `Ordinal` type explicitly composes the `Ordered` mixin type, and so
every type which explicitly composes `Ordinal` also implicitly composes
`Ordered`.  Just a few system-defined ordered types are also ordinal
types, including: `Bool`, `Int`.  A primary quality of a type that is
ordered but not ordinal is that you can take any two values of that type
and then find a third value of that type which lies between the first two
on the line; by definition for an ordinal type, there is no third value
between one of its values and that value's predecessor or successor value.
The cardinality of `Ordinal` is infinity; its default and minimum and
maximum values are the same as those of `Ordered`.

For some ordinal types, there is the concept of a *quantum* or *step
size*, where every consecutive pair of values on that type's value line are
conceptually spaced apart at equal distances; this distance would be the
quantum, and all steps along the value line are at exact multiples of that
quantum.  However, ordinal types in general don't need to be like this, and
there can be different amounts of conceivable distance between consecutive
values; an ordinal type is just required to know where all the values are.

## sys.std.Core.Type.Numeric

The `Numeric` type is a mixin (union) type that is intended to be
explicitly composed by all other types that are considered *numeric*.  A
numeric type is a type with whose values it would be reasonable to apply
all of the common mathematical operators like `+`, `-`, `*`, `/`.  Just
a few primary system-defined types are numeric types, including `Int` and
`Rat`.  The cardinality of `Numeric` is infinity.  The default value of
`Numeric` is the `Int` value zero.  The `Numeric` type is not itself
ordered, but often a type which is numeric is also ordered.  Muldis D does
not currently have any system-defined complex number types, but if it did,
they conceivably would also compose `Numeric`; but in that case, it may
prove useful to split the `Numeric` mixin into itself and a `Real` mixin.

## sys.std.Core.Type.Stringy

The `Stringy` type is a mixin (union) type that is intended to be
explicitly composed by all other types that are considered *stringy*,
which for the moment also includes any types whose values are an ordered
collection of elements, such as arrays.  A stringy type is a type with
whose values it would be reasonable to apply all of the common string or
array operators like `~` or `~#`.  Just a few primary system-defined
types are stringy types, including `Blob`, `Text`, and `Array`.  The
cardinality of `Stringy` is infinity.  The default value of `Stringy` is
the `Text` value empty string.  The `Stringy` type is not itself
ordered, but often a type which is stringy is also ordered.

## sys.std.Core.Type.Textual

The `Textual` type is a mixin (union) type that is intended to be
explicitly composed by all other types that are considered *textual*, that
is those types whose values are strings of characters.  The `Textual` type
explicitly composes the `Stringy` mixin type, and so every type which
explicitly composes `Textual` also implicitly composes `Stringy`.  Most
existing or likely system-defined stringy types are also textual types,
including `Text`.  The cardinality of `Textual` is infinity.  The default
value of `Textual` is the `Text` value empty string.  The `Textual` type
is not itself ordered, but often a type which is textual is also ordered.

## sys.std.Core.Type.Attributive

The `Attributive` type is a mixin (union) type that is intended to be
explicitly composed by other types that are considered to be collections of
named attributes, such as generic tuples and relations.  Just a few primary
system-defined types are attributive types, namely `Tuple` and
`Relation`.  The cardinality of `Attributive` is infinity.  The default
value of `Attributive` is `Tuple:D0`.  I<The `ScalarWP` type could
conceivably compose `Attributive` as well, but for now it doesn't, because
it still differs from `Tuple` and `Relation` in several ways such that
virtual routines composed for `Tuple` and `Relation` would be impractical
to compose for `ScalarWP` in general, but that might change later.>

## sys.std.Core.Type.Collective

The `Collective` type is a mixin (union) type that is intended to be
explicitly composed by other types that are effectively simple homogeneous
collections of values, and something more specific than relations in
general.  Just a few primary system-defined types are collective types,
including `Set`, `Array`, `Bag`, `SPInterval`, and `MPInterval`.  The
cardinality of `Collective` is infinity.  The default value of
`Collective` is `Nothing`.

# GENERIC SCALAR DATA TYPES

These core scalar data types are the most fundamental Muldis D types.
Plain Text Muldis D provides a specific syntax per type to select a value
of every one of these types (or of their super/subtypes), which does not
look like a routine invocation, but rather like a scalar literal in a
typical programming language; details of that syntax are not given here,
but in [Muldis_Data_Language_Dialect_PTMD_STD](Muldis_Data_Language_Dialect_PTMD_STD.md).  Hosted Data Muldis D as hosted in
another language will essentially use literals of corresponding host
language types, whatever they use for eg booleans and integers and
character strings, but tagged with extra metadata if the host language is
more weakly typed or lacks one-to-one type correspondence; see
[Muldis_Data_Language_Dialect_HDMD_Raku_STD](Muldis_Data_Language_Dialect_HDMD_Raku_STD.md) or
[Muldis_Data_Language_Dialect_HDMD_Perl_STD](Muldis_Data_Language_Dialect_HDMD_Perl_STD.md) for a Raku|Perl-based example.  These
types, except for `Scalar` and `DHScalar`, are all ordered.

## sys.std.Core.Type.Scalar

The `Scalar` type is the maximal type of all Muldis D scalar types, and
contains every scalar value that can possibly exist.  Every other
(non-aliased) scalar type is implicitly a proper subtype of `Scalar`, and
`Scalar` is implicitly a union type over all other scalar types.  Its
default value is `Bool:False`.  The cardinality of this type is infinity.
Considering the low-level type system, `Scalar` is just the union type of
these 3 types: `Int`, `String`, `ScalarWP`.

## sys.std.Core.Type.DHScalar

`DHScalar` is a proper subtype of
`Scalar` where every one of its possreps' attributes is restricted to be
of just certain categories of data types, rather than allowing any data
types at all; related to this restriction, any dh-scalar value is allowed
to be stored in a global/persisting relational database but any other
scalar value may only be used for transient data.  The `DHScalar` type is
the maximal type of all Muldis D dh-scalar types, and contains every
dh-scalar value that can possibly exist.  Every other (non-aliased)
dh-scalar type is implicitly a proper subtype of `DHScalar`, and
`DHScalar` is implicitly a union type over all other dh-scalar types.  Its
default value is `Bool:False`.  The cardinality of this type is infinity.
Considering the low-level type system, `Scalar` is just the union type of
these 3 types: `Int`, `String`, `DHScalarWP`.

## sys.std.Core.Type.Bool

The `Bool` type is explicitly defined
as a union type over just these 2 singleton types having
`sys.std.Core.Type.Bool.*`-format names:
`False` and `True`.  A `Bool` represents a truth value, and is the
result type of any `is_same` or `is_not_same` routine; it is
the only essential general-purpose scalar data type of a generic B<D>
language, although not the only essential one in Muldis D.
The default and minimum value of `Bool` is
`False`; its maximum value is `True`.  The cardinality of this type is 2.
The `Bool` type explicitly composes the `Ordinal` mixin type, and by
extension also implicitly composes the `Ordered` mixin type.
The `Bool` type has a default ordering algorithm that corresponds directly
to the sequence in which its values are documented here; `False` is
ordered before `True`.

The value `Bool:False` is also known as `False` and *contradiction* and
`⊥`.  The value `Bool:True` is also known as `True` and *tautology* and
`⊤`.

## sys.std.Core.Type.Bool.*

There are exactly 2 types having `sys.std.Core.Type.Bool.*`-format names;
for the rest of this description,
the type name `Bool.Value` will be used as a proxy for each and every one
of them.  A `Bool.Value` has 1 system-defined possrep whose name is the
empty string and which has zero attributes.  The cardinality of this type
is 1, and its only value is its default and minimum and maximum value.

## sys.std.Core.Type.Int

An `Int` is a single exact integral number
of any magnitude.  The `Int` type explicitly composes the `Numeric` mixin
type.  Its default value is zero; its minimum and maximum
values are conceptually infinities and practically impossible.  `Int` is
one of just two scalar root types (the other is `String`) that do *not*
have any possreps.  `Int` is also
the only atomic type in the Muldis D type system.  The cardinality of
this type is infinity; to define a most-generalized finite `Int` subtype,
you must specify the 2 integer end-points of the inclusive range that all
its values are in.  The `Int` type explicitly composes the `Ordinal`
mixin type, and by extension also implicitly composes the `Ordered` mixin
type.  The `Int` type has a default ordering algorithm; for 2
distinct `Int` values, the value closer to negative infinity is ordered
before the value closer to positive infinity.

## sys.std.Core.Type.NNInt

`NNInt` (non-negative integer) is a
proper subtype of `Int` where all member values are greater than or equal
to zero.  Its minimum value is zero.

## sys.std.Core.Type.PInt

`PInt` (positive integer) is a proper
subtype of `NNInt` where all member values are greater than zero.  Its
default and minimum value is 1.

## sys.std.Core.Type.PInt2_N

`PInt2_N` is a proper subtype of
`PInt` where all member values are greater than 1.  Its default and
minimum value is 2.

## sys.std.Core.Type.Rat

A `Rat` (scalar) is a single exact
rational number of any magnitude and precision.  The `Rat` type explicitly
composes the `Numeric` mixin type.  It is conceptually a
composite type with 2 main system-defined possreps, called `ratio` and
`float`, both of which are defined over several `Int`.

The `ratio` possrep consists of 2 attributes: `numerator` (an `Int`),
`denominator` (a `PInt`); the conceptual value of a `Rat` is the result
of rational-dividing its `numerator` by its `denominator`.  Because in
the general case there are an infinite set of [`numerator`,`denominator`]
integer pairs that denote the same rational value, the `ratio` possrep
carries the normalization constraint that `numerator` and `denominator`
must be coprime, that is, they have no common integer factors other than 1.

The `float` possrep consists of 3 attributes: `mantissa` (an `Int`),
`radix` (a `PInt2_N`), `exponent` (an `Int`); the conceptual value
of a `Rat` is the result of multiplying its `mantissa` by the result of
taking its `radix` to the power of its `exponent`.  The `float` possrep
carries the normalization constraint that among all the
[`mantissa`,`radix`,`exponent`] triples which would denote the same
rational value, the only allowed triple is the one having both the `radix`
with the lowest value (that is closest to or equal to 2) and the
`exponent` with the highest value (that is closest to positive infinity).
*Note: this constraint could stand to be rephrased for simplification or
correction, eg if somehow the sets of candidate triples sharing the lowest
radix and sharing the highest exponent have an empty intersection.*

The default value of `Rat` is zero; its minimum and maximum values are
conceptually infinities and practically impossible.  The cardinality of
this type is infinity; to define a most-generalized finite `Rat` subtype,
you must specify the greatest magnitude value denominator, plus the 2
integer end-points of the inclusive range of the value numerator; or
alternately you must specify the greatest magnitude value mantissa (the
*maximum precision* of the number), and specify the greatest magnitude
value radix, plus the 2 integer end-points of the inclusive range of
the value exponent (the *maximum scale* of the number).  Common subtypes
specify that the normalized radixes of all their values are either 2 or 10;
types such as these will easily map exactly to common human or physical
numeric representations, so they tend to perform better.

The `Rat` type explicitly composes the `Ordered` mixin type.
The `Rat` type has a default ordering algorithm which is conceptually the
same as for `Int`; for 2 distinct `Rat` values, the value closer to
negative infinity is ordered before the value closer to positive infinity.

The `Rat` type has an implementation hint for less intelligent Muldis D
implementations, that suggests using the `float` possrep as the basis for
the physical representation.

## sys.std.Core.Type.NNRat

`NNRat` (non-negative rational) is a
proper subtype of `Rat` where all member values are greater than or equal
to zero (that is, the `numerator`|`mantissa` is greater than or equal to
zero).  Its minimum value is zero.

## sys.std.Core.Type.PRat

`PRat` (positive rational) is a
proper subtype of `NNRat` where all member values are greater than zero
(that is, the `numerator`|`mantissa` is greater than zero).  Its default
and minimum value is 1.

## sys.std.Core.Type.Blob

A `Blob` is an undifferentiated string of
bits.  The `Blob` type explicitly composes the `Stringy` mixin
type.  A `Blob` has 1 system-defined possrep named `bits` which consists
of 1 `BString`-typed attribute whose name is the empty string; each
element of `bits` is either `0` to represent a low bit or `1` to
represent a high bit.  The `Blob` type explicitly composes the `Ordered`
mixin type.  A `Blob` is a simple wrapper for a `BString` and
all of its other details such as default and minimum and maximum values and
cardinality and default ordering algorithm all correspond directly.  But
`Blob` is explicitly disjoint from `BString` due to having a different
intended interpretation.

## sys.std.Core.Type.OctetBlob

`OctetBlob` is a proper subtype of
`Blob` where all member values have a length in bits that is an even
multiple of 8 (or is zero).  `OctetBlob` adds 1 system-defined possrep
named `octets` which consists of 1 `OString`-typed attribute whose name
is the empty string.  The `octets` and `bits` possreps correspond as you
might expect, such that each element of the sole attribute of `octets`
maps to 8 consecutive elements of the sole attribute of `bits`; with each
8 bits corresponding to an octet, the lowest-element-indexed bit
corresponds to the highest bit of the octet when the latter is encoded as a
standard two's complement binary unsigned integer, and the
highest-element-indeed bit corresponds to the lowest bit of the octet.  The
reason the `OctetBlob` type is system-defined as distinct from `Blob` is
for convenience of users since it is likely the vast majority of `Blob`
values consist of whole octets and users would want to work with them in
those terms.

## sys.std.Core.Type.Text

A `Text` is a string of abstract characters.  The `Text` type explicitly
composes the `Textual` mixin type, and by extension also implicitly
composes the `Stringy` mixin type.  A `Text` has 1 system-defined possrep
named `maximal_chars` which consists of 1 `String`-typed attribute whose
name is the empty string; each element of `maximal_chars` is an integer
representing an abstract character code point of an infinite-size
proprietary abstract character repertoire, with each unique integer
corresponding to a unique character.  The `Text` type explicitly composes
the `Ordered` mixin type.  A `Text` is a simple wrapper for a `String`
and all of its other details such as default and minimum and maximum values
and cardinality and default ordering algorithm (matching and sorting is
numeric by code point integer) all correspond directly.  But `Text` is
explicitly disjoint from `String` due to having a different intended
interpretation.  The formal definition of the `Text` type does not define
any abstract characters itself.  Rather, the actual abstract characters in
`Text`'s repertoire are all defined by the proper subtypes of `Text` that
each formally declare a character set, and the union of these is the
repertoire of `Text`; how such a said proper subtype declares a character
set is by adding at least one possrep capable of representing strings of
characters of that set.  The set of such subtypes of `Text` would
collectively define mappings between their own possreps and
`maximal_chars`, either directly or indirectly.  The `Text` type is
officially compatible with the Unicode standard version 6.2.0, and so all
proper subtypes of `Text` may only define character sets whose common
characters with Unicode would cleanly map bidirectionally with the latter;
most well known character sets do this, but for any others, they would be
defined as some `Textual`-composing type that is disjoint from `Text`.
*TODO: Investigate on what side of the fence Unicode alternatives such as
ISO/IEC 2022 or Mojikyo or HKSCS would fall.*
Officially the actual integer strings used by `maximal_chars` for abstract
characters is both implementation-defined and unstable, so user code should
typically never reference this possrep directly; similarly, the natural
ordering of `Text` is officially implementation-defined and unstable.  The
official way to have character string types that naturally sort in a way
that is correct for some particular nationality is by having a disjoint
`Textual`-composing type with a `Text`-typed possrep attribute and the
wrapper type would define the desired ordering algorithm itself.
Similarly, any concept of nationality-specific graphemes is best expressed
in a wrapper.  `Text` is more agnostic and generic in these matters.
It is likely each implementation will make `maximal_chars` resemble the
largest well known character set that it knows about, typically Unicode.
I<TODO: Consider making `maximal_chars` formally identical to Unicode for
all element integers in 0..2^21, and to ASCII for all in 0..127, and then
the subtypes could be defined in a normal and independent/portable way.
Maybe we need to formally define what higher ranges HKSCS/etc map to.>

## sys.std.Core.Type.Text.Unicode

`Text.Unicode` is a proper subtype of `Text` where all member values have
just the abstract characters in the character repertoire of the Unicode
standard version 6.2.0; the integer code point space that Unicode reserves
for itself is 0..0x10FFFF, of which it currently has about 10% allocated.
`Text.Unicode` adds the 1 system-defined possrep named `unicode_codes`
which consists of 1 `String`-typed attribute whose name is the empty
string; each element of `unicode_codes` represents a Unicode standard
version 6.2.0 character abstract code point number.  `Text.Unicode` values
in general do not conform to any Unicode normal form, so the same string
can contain graphemes in both composed and decomposed formats, and two
strings with the same graphemes in different such formats will compare as
unequal.  `Text.Unicode` also adds the 1 system-defined possrep named
`unicode_utf8_octets` which consists of 1 `OString`-typed attribute whose
name is the empty string; `unicode_utf8_octets` represents each code point
as a sequence of 1..4 octets in the UTF-8 encoding; the number of octets
used varies by code point as follows: 1 for 0x0..0x7F, 2 for 0x80..0x7FF,
3 for 0x800..0xFFFF, 4 for 0x10000..0x10FFFF.

## sys.std.Core.Type.Text.Unicode.Canon

`Text.Unicode.Canon` is a proper subtype of `Text.Unicode` where all
member values are semantically in canonical decomposed normal form (NFD)
and whose `Text.Unicode`-defined possreps are properly formatted NFD.
Two `Text.Unicode.Canon` will generally match at the grapheme abstraction
level.  Of course, a Muldis D implementation doesn't actually have to store
character data in NFD; but default matching semantics need to be as if it
did, and NFD is what the aforementioned possreps would format it in.

## sys.std.Core.Type.Text.Unicode.Compat

`Text.Unicode.Compat` is a proper subtype of `Text.Unicode.Canon` where
all member values are semantically in compatibility decomposed normal form
(NFKD) and whose `Text.Unicode`-defined possreps are properly formatted
NFKD.  While typical applications would likely prefer `Canon`, more
security-conscious applications may likely prefer `Compat`.

## sys.std.Core.Type.Text.ASCII

`Text.ASCII` is a proper subtype of `Text.Unicode` (and of
`Text.Unicode.Compat`) where all member values have just the abstract
characters in the 128-character repertoire of 7-bit ASCII.  For these
values, the `unicode_codes` and `unicode_utf8_octets` possreps have
identical (`OString`) attribute values, each element in which is in the
range 0..127 inclusive.  `Text.ASCII` adds 1 system-defined possrep named
`ascii_chars` which consists of 1 `OString`-typed attribute whose name is
the empty string and whose value is identical to said other two possrep
attribute values.

## sys.std.Core.Type.Text.Latin1

`Text.Latin1` is a proper subtype of `Text.Unicode` (and a proper
supertype of `Text.ASCII`) where all member values have just the abstract
characters in the 256-character repertoire of 8-bit ISO Latin 1 /
ISO-8859-1.  `Text.Latin1` adds 1 system-defined possrep named
`latin1_chars` which consists of 1 `OString`-typed attribute whose name
is the empty string and each of whose elements is a code point in the range
0..255 inclusive, and also doubles as the octet format of said code point in
the Latin 1 encoding.  The `latin1_chars` and `unicode_codes` possreps
correspond as you might expect, such that both represent the same abstract
characters using the appropriate code points of their repertoires.

# GENERIC NONSCALAR DATA TYPES

These core nonscalar data types permit transparent/user-visible
compositions of multiple values into other conceptual values.  For all
nonscalar types, their cardinality is mainly or wholly dependent on the
data types they are composed of.

## sys.std.Core.Type.Tuple

The `Tuple` type is the maximal type of
all Muldis D tuple (nonscalar) types, and contains every
tuple value that could possibly exist.  The `Tuple` type explicitly
composes the `Attributive` mixin type.  A `Tuple` is an unordered
heterogeneous collection of 0..N named attributes (the count of attributes
being its *degree*), where all attribute names are mutually distinct, and
each attribute may be of distinct types; the mapping of a tuple's
attribute names and their declared data types is called the tuple's
*heading*.  Its default value is the sole tuple value
that has zero attributes.  The cardinality of a *complete* `Tuple`
type (if it has no type constraints other than those of its constituent
attribute types) is equal to the product of the N-adic multiplication where
there is an input to that multiplication for each attribute of the
tuple and the value of the input is the cardinality of the declared
type of the attribute; for a `Tuple` subtype to be finite, all of its
attribute types must be.  Considering the low-level type system, `Tuple`
is just a proper subtype of `Structure` consisting of
every `Structure` value whose first element is the `Int` value `2`.

## sys.std.Core.Type.DHTuple

`DHTuple` is a proper subtype of
`Tuple` where every one of its attributes is restricted to be of just
certain categories of data types, rather than allowing any data types at
all; related to this restriction, any dh-tuple value is allowed to be
stored in a global/persisting relational database but any other tuple value
may only be used for transient data.  The `DHTuple` type is the maximal
type of all Muldis D dh-tuple (dh-nonscalar) types, and contains every
dh-tuple value that could possibly exist.  Its default value is the same as
that of `Tuple` and matters of its cardinality are determined likewise.

The only member value of `DHTuple` that has exactly zero attributes is
also known by the special name `Tuple:D0` aka `D0`, which serves as the
default value of the 3 types `[|DH]Tuple` and `Database`.

## sys.std.Core.Type.Database

`Database` is a proper subtype of
`DHTuple` where all of its attributes are each of dh-relation types or of
database types (the leaves of this recursion are all dh-relation types); it
is otherwise the same.  The 2 system-defined user-data variables named
`[fed|nlx].data` are all of "just" the `Database` type, or are of
its proper subtypes.

## sys.std.Core.Type.Set.T

`Set.T` is a proper subtype of
`Tuple`, and it exists in order for the relation type
`Set` (and `Maybe` and `Just`) to be defined partly in terms of it.  A
`Set.T` has 1 attribute, `value` (a `Universal`).  Its default value a
`value` of `Bool:False`.

## sys.std.Core.Type.DHSet.T

`DHSet.T` is the intersection type of
`Set.T` and `DHTuple`, and it exists in order for the dh-relation type
`DHSet` (and `DHMaybe`, `DHJust`) to be defined partly in terms of it.

## sys.std.Core.Type.Array.T

`Array.T` is a proper subtype of
`Tuple`, and it exists in order for the relation type
`Array` to be defined partly in terms of it.  An `Array.T`
has 2 attributes, `index` (a `NNInt`) and `value` (a `Universal`).  Its
default value has an `index` of zero and a `value` of `Bool:False`.

## sys.std.Core.Type.DHArray.T

`DHArray.T` is the intersection type of
`Array.T` and `DHTuple`, and it exists in order for the dh-relation type
`DHArray` to be defined partly in terms of it.

## sys.std.Core.Type.Bag.T

`Bag.T` is a proper subtype of
`Tuple`, and it exists in order for the relation type
`Bag` to be defined partly in terms of it.  A `Bag.T`
has 2 attributes, `value` (a `Universal`) and `count` (a `PInt`).  Its
default value has a `value` of `Bool:False` and a `count` of 1.

## sys.std.Core.Type.DHBag.T

`DHBag.T` is the intersection type of
`Bag.T` and `DHTuple`, and it exists in order for the dh-relation type
`DHBag` to be defined partly in terms of it.

## sys.std.Core.Type.SPInterval

An `SPInterval` (single-piece interval) is a `Tuple`.  The `SPInterval`
type explicitly composes the `Collective` mixin type.  It typically
defines a single *bounded interval*/*finite interval* in terms of 2
*endpoint* values plus an indicator of whether either, both, or none of
the endpoint values are included in the interval.  It can also define an
*unbounded interval*/*infinite interval*, which is accomplished by
using an infinity for either or both endpoint values.

An `SPInterval` has these 4 attributes:

* `min|max` - `Universal`

These are the interval endpoint values; `min` defines the
I<left|start|from> endpoint and `max` defines the I<right|end|to>
endpoint.  The endpoint values conceptually must be of the same,
totally-ordered type (typically one of `Int`, `Rat`, `Text`,
`TAIInstant`, etc), although strictly speaking they may be of any types at
all; in the latter case, to actually make practical use of such intervals,
an `order-determination` function must explicitly be employed.

* `excludes_[min|max]` - `Bool`

If `excludes_min` or `excludes_max` are `Bool:True`, then `min` or
`max` *is not* considered to be included within the interval,
respectively; otherwise, it *is* considered to be included within the
interval.  If both endpoints are within the interval (the use case which
Muldis D optimizes its syntax for), the interval is *closed*; otherwise if
both endpoints are not in the interval, the interval is *open*.

The `SPInterval` type supports empty intervals (which include no values at
all) at least as a matter of simplicity in that it doesn't place any
restrictions on the combination of attribute values an `SPInterval` value
may have, such as that `max` can't be before `min`.  This liberal design
is also necessary to support the general case where the relative order of
the `min` and `max` values is situation-dependent on what
`order-determination` function is used with the interval; that function
also determines what type's concept of order is being applied, and so it
also determines whether or not a given interval is considered empty or not.
With respect to each compatible `order-determination` function, an
`SPInterval` is considered empty iff at least one of the following is
true:  1. Its `min` is greater than its `max`.  2. Its `min` is equal to
its `max` *and* at least one of `excludes_min` or `excludes_max` is
true.  3. Both `excludes_min` and `excludes_max` are true *and* `min`
and `max` are consecutive values.  And so, there are many distinct
`SPInterval` values that are conceptually empty intervals, and the
`is_same` function should not be used to test an `SPInterval` for
being empty or not.

The `SPInterval` type supports *unbounded*/*infinite* or *half-bounded*
intervals that are orthogonal to data type.  This feature is implemented
using the 2 special singleton types `-Inf` and `Inf`.  Iff `min` is
`-Inf` then the interval is left-unbounded; iff `max` is `Inf` then the
interval is right-unbounded.  An interval that is unbounded on both ends is
the maximal interval, in that all Muldis D values are members of it, at
least in the general context lacking any `order-determination` function.

The default value of `SPInterval` represents an empty interval where its
`min` and `max` attributes are `Inf` and `-Inf`, respectively, and its
other 2 attributes are `Bool:False`.

See also the `sys.std.Core.Type.MPInterval` type, which is the
canonical means that Muldis D provides of representing the result of
set-unioning 2 `SPInterval` where the latter do not touch or overlap,
and provides the single *canonical* empty interval value.

## sys.std.Core.Type.DHSPInterval

`DHSPInterval` is a proper subtype of
`SPInterval` where every one of its values is also a `DHTuple`.  In
general practice, all `SPInterval` values are `DHSPInterval` values,
because their endpoints would all be `DHScalar` values.  The default value
of `DHSPInterval` is the same as that of `SPInterval`.

## sys.std.Core.Type.Relation

The `Relation` type is the maximal type
of all Muldis D relation (nonscalar) types, and contains every
relation value that could possibly exist.  The `Relation` type explicitly
composes the `Attributive` mixin type.  A `Relation` is
analogous to a set of 0..N tuples where all tuples have the
same heading (the degrees match and all attribute names, and typically
corresponding declared data types, match), but that a `Relation` data
type still has its own corresponding heading (attribute names and declared
data types) even when it consists of zero tuples.  Its default value
is the sole relation value that has zero tuples and zero
attributes.  The cardinality of a *complete* `Relation` type (if it has
no type constraints other than those of its constituent attribute types) is
equal to 2 raised to the power of the cardinality of the *complete*
`Tuple` type with the same heading.  A relation data type can also
have (unique) keys each defined over a subset of its attributes, which
constrain its set of values relative to there being no explicit keys, but
having the keys won't turn an infinite relation type into a finite one.
Considering the low-level type system, `Relation` is just a proper subtype
of `Structure` consisting of every `Structure` value whose first element
is the `Int` value `3`.

## sys.std.Core.Type.DHRelation

`DHRelation` is a proper subtype of
`Relation` where every one of its attributes is restricted to be of just
certain categories of data types, rather than allowing any data types at
all; related to this restriction, any dh-relation value is allowed to be
stored in a global/persisting relational database but any other relation
value may only be used for transient data.  The main difference from its
supertype is that a dh-relation's dh-tuples' headings all have matching
declared data types for corresponding attributes, while with relations they
don't have to.  The `DHRelation` type is the maximal type of all Muldis D
dh-relation (dh-nonscalar) types, and contains every dh-relation value that
could possibly exist.  Its default value is the same as that of `Relation`
and matters of its cardinality are determined likewise.

The only member value of `DHRelation` that has exactly zero attributes and
exactly zero tuples is also known by the special name `Relation:D0C0` aka
`D0C0`, which serves as the default value of the 2 types `[|DH]Relation`.
The only member value of `DHRelation` that has exactly zero attributes and
exactly one tuple is also known by the special name `Relation:D0C1` aka
`D0C1`.  Note that *The Third Manifesto* also refers to these 2 values by
the special shorthand names *TABLE_DUM* and *TABLE_DEE*, respectively.

## sys.std.Core.Type.Set

`Set` is a proper subtype of
`Relation` that has 1 attribute, and its name is `value`; it can be of
any declared type.  The `Set` type explicitly composes the `Collective`
mixin type.  A `Set` subtype is normally used by any
system-defined N-adic operators where the order of their argument elements
or result is not significant, and that duplicate values are not
significant.  Its default value has zero tuples.  Note that, for any
given `Set` subtype, `Foo`, where its `value` attribute has a declared
type of `Bar`, the type `Foo` can be considered the *power set* of the
type `Bar`.

## sys.std.Core.Type.DHSet

`DHSet` is the intersection type of
`Set` and `DHRelation`.  The cardinality of this type is infinite.

## sys.std.Core.Type.Maybe

`Maybe` is a proper subtype of `Set`
where all member values may have at most one element; that is, it is a
unary `Relation` with a nullary key.  Operators that work specifically
with `Maybe` subtypes can provide a syntactic shorthand for working with
sparse data; so Muldis D has something which is conceptually close to SQL's
nullable types without actually having 3-valued logic; it would probably be
convenient for code that round-trips SQL by way of Muldis D to use the
`Maybe` type.  Its default value has zero tuples.

## sys.std.Core.Type.DHMaybe

`DHMaybe` is the intersection type of
`Maybe` and `DHSet`.  The cardinality of this type is infinite.

The only member value of `DHMaybe` that has exactly zero elements is also
known by the special name `Maybe:Nothing`, aka `Nothing`,
aka *empty set*, aka `∅`, which serves as
the default value of the 4 types `[|DH]Maybe` and `[|DH]Set`.  The single
`Nothing` value, which is a relation with zero tuples and a single
attribute named `value`, is Muldis D's answer to the SQL NULL and is
intended to be used for the same purposes; that is, a special marker for
missing or inapplicable information, that does not typically equal any
normal/scalar value; however, in Muldis D, `Nothing` *is a value*, and it
*is* equal to itself.  To be more specific, the SQL NULL is very limited
in what it actually can do, and can not be used to say anything other than
"this isn't a normal value", similar to what Perl's "undef" says; if you
want to actually indicate a reason why we don't have a normal value when
more than one reason could possibly apply in the context, then using simply
`Nothing` or SQL's NULL can't do it, and instead you'll have to use other
normal values such as status flags to keep the appropriate metadata.

## sys.std.Core.Type.Just

`Just` is a proper subtype of
`Maybe` where all member values have exactly 1 element.  Its default
value's only tuple's only attribute has the value `Bool:False`.  The
`Just` type consists of all of `Maybe`'s values except `Nothing`.

## sys.std.Core.Type.DHJust

`DHJust` is the intersection type of
`Just` and `DHMaybe`.  Subtypes of `DHJust` are also used to
implement data-carrying database objects that are conceptually scalars
rather than relations; for example, the current state of a sequence
generator might typically be one.  The cardinality of this type is
infinite.

## sys.std.Core.Type.Array

`Array` is a proper subtype of
`Relation` that has 2 attributes, and their names are `index` and
`value`, where `index` is a unary primary key and its declared type is a
`NNInt` subtype (`value` can be non-unique and of any declared type).
The `Array` type explicitly composes the `Collective` mixin type.  An
`Array` is considered dense, and all `index` values in one are numbered
consecutively from 0 to 1 less than the count of tuples, like array
indices in typical programming languages.  An `Array` subtype is normally
used by any system-defined N-adic operators where the order of their
argument elements or result is significant (and duplicate values are
significant); specifically, `index` defines an explicit ordering for
`value`.  Its default value has zero tuples.  The `Array` type explicitly
composes the `Stringy` mixin type.

## sys.std.Core.Type.DHArray

`DHArray` is the intersection type of
`Array` and `DHRelation`.  The cardinality of this type is infinite.

## sys.std.Core.Type.Bag

`Bag` (or *multiset*) is a
proper subtype of `Relation` that has 2 attributes, and their names are
`value` and `count`, where `value` is a unary primary key (that can have
any declared type) and `count` is a `PInt` subtype.  The `Bag` type
explicitly composes the `Collective` mixin type.  A `Bag` subtype is
normally used by any system-defined N-adic operators where the order of
their argument elements or result is not significant, but that duplicate
values are significant; specifically, `count` defines an explicit count of
occurrences for `value`, also known as that value's *multiplicity*.  Its
default value has zero tuples.

## sys.std.Core.Type.DHBag

`DHBag` is the intersection type of
`Bag` and `DHRelation`.  The cardinality of this type is infinite.

## sys.std.Core.Type.MPInterval

`MPInterval` (multi-piece interval) is a proper subtype of
`Relation` that is defined directly partly in terms of the tuple type
`SPInterval`, thereby sharing its *heading*, but defines no further
constraints of its own.  The `MPInterval` type explicitly composes the
`Collective` mixin type.  It defines a single *multi-piece interval*,
which is conceptually either a set of 0..N intervals or a single larger
interval that had 0..N sub-intervals sliced out.  An `MPInterval` is the
canonical means that Muldis D provides of representing the result of
set-unioning 2 `SPInterval` where the latter do not touch or overlap.
Moreover, an `MPInterval` also empowers Muldis D to have a single
*canonical* empty interval value, which is the only `MPInterval` with
zero tuples; this value is also the default value of `MPInterval`.  The
cardinality of this type is infinite.

## sys.std.Core.Type.DHMPInterval

`DHMPInterval` is the intersection type of `MPInterval` and
`DHRelation`.  The cardinality of this type is infinite.

# GENERIC EXTERNAL DATA TYPES

## sys.std.Core.Type.External

An `External` is a reference within the
Muldis D virtual machine to a value managed not by the Muldis D
implementation but rather by a peer or host language in the wider program
that includes the VM.  All `External` values are treated as black boxes by
Muldis D itself.  The cardinality of this type is
infinity.  The default value of this type is implementation-defined.
Considering the low-level type system, `External` is just a proper subtype
of `Structure` consisting of every `Structure` value whose first element
is the `Int` value `5`.

# AUTHOR

Darren Duncan (`darren@DarrenDuncan.net`)

# LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
