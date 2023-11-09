# NAME

Muldis Data Language Core Types_Catalog - Muldis Data Language catalog-defining data types

# VERSION

This document is Muldis Data Language Core Types_Catalog version 0.148.1.

# PREFACE

This document is part of the Muldis Data Language language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

These core data types are more special-purpose in nature and are intended
for use in defining or working with the system catalog.

Note that whenever an attribute of one of the nonscalar types isn't
significant, given the context (determined by other attributes of the same
type), and should be ignored, its value is the default for its type.

Note that many of the tuple types might conceptually have `name`
attributes, but those would actually be provided by any larger types in
which they are embedded, rather than by these types themselves.

*Note that for every relation type defined in this file, there also exists
a corresponding tuple type in terms of which the relation type is partly
defined; that tuple type is not yet explicitly defined in this file but a
future spec update should change this.*

*To keep things simpler for now, most constraint definitions for these
types are missing, or just defined informally.*

# TYPE SUMMARY

This section shows all the data types and data type factories described in
this document, which are specific to defining the system catalog, more or
less.  Since there are a number of types with multiple parents, those types
may appear multiple times in the graph; moreover, the graph is displayed in
multiple slices, some of which are different views of the same type
relationships.  See [Muldis_Data_Language_Core_Types](Muldis_Data_Language_Core_Types.md) section **TYPE SUMMARY** for context.

This graph slice shows all of the top-level catalog types, plus some
non-catalog core types for context:

    sys.std.Core.Type.Universal
        sys.std.Core.Type.Cat.List
            sys.std.Core.Type.Cat.Structure
                sys.std.Core.Type.Cat.String
                sys.std.Core.Type.Tuple
                sys.std.Core.Type.Relation
                sys.std.Core.Type.Cat.ScalarWP
                sys.std.Core.Type.External
            sys.std.Core.Type.Cat.Nonstructure
        sys.std.Core.Type.Scalar
            sys.std.Core.Type.Cat.ScalarWP
                sys.std.Core.Type.Cat.DHScalarWP
            sys.std.Core.Type.DHScalar
                sys.std.Core.Type.Int
                sys.std.Core.Type.Cat.String
                sys.std.Core.Type.Cat.DHScalarWP
                sys.std.Core.Type.Cat.SysScalar

This graph slice shows all of the catalog scalar types:

    sys.std.Core.Type.Universal
        sys.std.Core.Type.Scalar
            sys.std.Core.Type.DHScalar

                # The following are all regular ordered scalar types.

                sys.std.Core.Type.Cat.String
                    sys.std.Core.Type.Cat.BString
                    sys.std.Core.Type.Cat.OString

                sys.std.Core.Type.Cat.DHScalarWP

                    sys.std.Core.Type.Text

                        # The following are all regular ord scalar types.

                        sys.std.Core.Type.Cat.CoreText

                    # The following are all regular ordered scalar types.

                    sys.std.Core.Type.Cat.Name
                    sys.std.Core.Type.Cat.NameChain
                        sys.std.Core.Type.Cat.PNSQNameChain
                            sys.std.Core.Type.Cat.MaterialNC
                                sys.std.Core.Type.Cat.AbsPathMaterialNC
                                    sys.std.Core.Type.Cat.APFunctionNC
                                    sys.std.Core.Type.Cat.APProcedureNC
                                    sys.std.Core.Type.Cat.APTypeNC
                                sys.std.Core.Type.Cat.RelPathMaterialNC
                                    sys.std.Core.Type.Cat.RPFunctionNC
                                    sys.std.Core.Type.Cat.RPProcedureNC
                                    sys.std.Core.Type.Cat.RPTypeNC
                            sys.std.Core.Type.Cat.DataNC
                    sys.std.Core.Type.Cat.Comment
                    sys.std.Core.Type.Cat.Order
                        sys.std.Core.Type.Cat.Order.*

                    # The following are all regular non-ord scalar types.

                    sys.std.Core.Type.Cat.RoundMeth
                        sys.std.Core.Type.Cat.RoundMeth.*
                    sys.std.Core.Type.Cat.RatRoundRule

                    # The following are other singleton types plus a union.

                    sys.std.Core.Type.Cat.Singleton
                        sys.std.Core.Type.Cat."-Inf"
                        sys.std.Core.Type.Cat.Inf

                    sys.std.Core.Type.Cat.Exception

This graph slice shows all of the catalog nonscalar types:

    sys.std.Core.Type.Universal

        sys.std.Core.Type.Tuple
            sys.std.Core.Type.DHTuple

                # The following are all regular tuple types.

                sys.std.Core.Type.Cat.Function
                    sys.std.Core.Type.Cat.NamedValFunc
                    sys.std.Core.Type.Cat.ValMapFunc
                        sys.std.Core.Type.Cat.ValMapUFunc
                        sys.std.Core.Type.Cat.ValFiltFunc
                            sys.std.Core.Type.Cat.ValConstrFunc
                    sys.std.Core.Type.Cat.ValRedFunc
                    sys.std.Core.Type.Cat.OrdDetFunc
                sys.std.Core.Type.Cat.Procedure
                    sys.std.Core.Type.Cat.SystemService
                    sys.std.Core.Type.Cat.Transaction
                        sys.std.Core.Type.Cat.Recipe
                            sys.std.Core.Type.Cat.Updater
                sys.std.Core.Type.Cat.ScalarType
                sys.std.Core.Type.Cat.TupleType
                sys.std.Core.Type.Cat.RelationType
                sys.std.Core.Type.Cat.DomainType
                sys.std.Core.Type.Cat.SubsetType
                sys.std.Core.Type.Cat.MixinType
                sys.std.Core.Type.Cat.KeyConstr
                sys.std.Core.Type.Cat.DistribKeyConstr
                sys.std.Core.Type.Cat.SubsetConstr
                sys.std.Core.Type.Cat.DistribSubsetConstr
                sys.std.Core.Type.Cat.StimRespRule
                sys.std.Core.Type.Cat.OrderByName

                sys.std.Core.Type.Database

                    # The following are all regular database types.

                    sys.std.Core.Type.Cat.System
                    sys.std.Core.Type.Cat.MountControlCat
                    sys.std.Core.Type.Cat.Federation
                    sys.std.Core.Type.Cat.Package
                        sys.std.Core.Type.Cat.Module
                        sys.std.Core.Type.Cat.Depot
                    sys.std.Core.Type.Cat.ExprNodeSet
                    sys.std.Core.Type.Cat.StmtNodeSet
                    sys.std.Core.Type.Cat.D0

        sys.std.Core.Type.Relation
            sys.std.Core.Type.DHRelation

                # The following are all regular relation types.

                sys.std.Core.Type.Cat.SpecialNspSet
                sys.std.Core.Type.Cat.ModuleSet
                sys.std.Core.Type.Cat.CatalogSet
                sys.std.Core.Type.Cat.MountControlSet
                sys.std.Core.Type.Cat.DepotMountSet
                sys.std.Core.Type.Cat.FedTypeMapSet
                sys.std.Core.Type.Cat.SubpackageSet
                sys.std.Core.Type.Cat.[Function|Procedure]Set
                sys.std.Core.Type.Cat.SpecialTypeSet
                sys.std.Core.Type.Cat.[Scalar|Tuple|Relation]TypeSet
                sys.std.Core.Type.Cat.[Domain|Subset|Mixin]TypeSet
                sys.std.Core.Type.Cat.[|Distrib][Key|Subset]ConstrSet
                sys.std.Core.Type.Cat.StimRespRuleSet
                sys.std.Core.Type.Cat.SysScaValExprNodeSet
                sys.std.Core.Type.Cat.ScaSelExprNodeSet
                sys.std.Core.Type.Cat.TupSelExprNodeSet
                sys.std.Core.Type.Cat.RelSelExprNodeSet
                sys.std.Core.Type.Cat.SetSelExprNodeSet
                sys.std.Core.Type.Cat.ArySelExprNodeSet
                sys.std.Core.Type.Cat.BagSelExprNodeSet
                sys.std.Core.Type.Cat.SPIvlSelExprNodeSet
                sys.std.Core.Type.Cat.MPIvlSelExprNodeSet
                sys.std.Core.Type.Cat.ListSelExprNodeSet
                sys.std.Core.Type.Cat.AccExprNodeSet
                sys.std.Core.Type.Cat.FuncInvoExprNodeSet
                sys.std.Core.Type.Cat.IfElseExprNodeSet
                sys.std.Core.Type.Cat.GivenWhenDefExprNodeSet
                sys.std.Core.Type.Cat.WhenThenExprMap
                sys.std.Core.Type.Cat.APMaterialNCSelExprNodeSet
                sys.std.Core.Type.Cat.ProcGlobalVarAliasMap
                sys.std.Core.Type.Cat.LeaveStmtNodeSet
                sys.std.Core.Type.Cat.CompoundStmtNodeSet
                sys.std.Core.Type.Cat.MultiUpdStmtNodeSet
                sys.std.Core.Type.Cat.ProcInvoStmtNodeSet
                sys.std.Core.Type.Cat.TryCatchStmtNodeSet
                sys.std.Core.Type.Cat.IfElseStmtNodeSet
                sys.std.Core.Type.Cat.GivenWhenDefStmtNodeSet
                sys.std.Core.Type.Cat.WhenThenExprStmtMap
                sys.std.Core.Type.Cat.IterateStmtNodeSet
                sys.std.Core.Type.Cat.LoopStmtNodeSet
                sys.std.Core.Type.Cat.PossrepSet
                sys.std.Core.Type.Cat.PossrepMapSet
                sys.std.Core.Type.Cat.VirtualAttrMapSet
                sys.std.Core.Type.Cat.ComposedMixinSet
                sys.std.Core.Type.Cat.DKMemRelAttrMap
                sys.std.Core.Type.Cat.DKRelAttrKeyAttrMap
                sys.std.Core.Type.Cat.SCChildAttrParentAttrMap
                sys.std.Core.Type.Cat.NameTypeMap
                sys.std.Core.Type.Cat.NameExprMap
                sys.std.Core.Type.Cat.NameNCMap
                sys.std.Core.Type.Cat.AttrRenameMap

This graph slice shows additional nonscalar types that can not in general
be used as components of a system catalog, or any database, but they may be
used temporarily at runtime:

    sys.std.Core.Type.Universal
        sys.std.Core.Type.Tuple

            # The following are all regular tuple types.

            sys.std.Core.Type.Cat.PrimedFuncNC
                sys.std.Core.Type.Cat.ValMapPFuncNC
                    sys.std.Core.Type.Cat.ValFiltPFuncNC
                sys.std.Core.Type.Cat.ValRedPFuncNC
                sys.std.Core.Type.Cat.OrdDetPFuncNC

This graph slice shows all of the catalog types that compose any mixin
types, shown grouped under the mixin types that they compose:

    sys.std.Core.Type.Universal

        sys.std.Core.Type.Ordered

            sys.std.Core.Type.Cat.String
            sys.std.Core.Type.Cat.Name
            sys.std.Core.Type.Cat.NameChain
            sys.std.Core.Type.Cat.Comment

            sys.std.Core.Type.Ordinal

                sys.std.Core.Type.Cat.Order
                sys.std.Core.Type.Cat."-Inf"
                sys.std.Core.Type.Cat.Inf

        sys.std.Core.Type.Stringy

            sys.std.Core.Type.Cat.String
            sys.std.Core.Type.Cat.NameChain

            sys.std.Core.Type.Textual

                sys.std.Core.Type.Cat.Name
                sys.std.Core.Type.Cat.Comment

# LOW-LEVEL STRUCTURE TYPES

These types only exist in the low-level type system, and should not be used
directly by users to define their ordinary data types or variables or
parameters; rather they should use the conceptually higher-level types
declared in [Muldis_Data_Language_Core_Types](Muldis_Data_Language_Core_Types.md) instead as their tools.  See also
[Muldis_Data_Language_Basics](Muldis_Data_Language_Basics.md) section **Low Level Type System** for details of these types'
structures, how their common 5 main subtypes are defined in terms of them.

## sys.std.Core.Type.Cat.List

The `List` type is the sub-maximal type of the entire Muldis Data Language type
system, and contains every non-`Int` value that can possibly exist.  Every
value in the Muldis Data Language type system is declared by just one of two types,
where `Int` is one and `List` is the other; therefore, `Int` and `List`
are each other's *negation type*, and the union of just those 2 types is
`Universal`.  A `List` is a transparent dense sequence of 0..N elements
where each element is identified by ordinal position and the first element
has position zero, and where each element is either an `Int` or a `List`;
in the general case, this can be an arbitrarily complex hierarchical
structure of unlimited size, where the leaves of this hierarchy are each
`Int`.  The `List` type is neither scalar nor nonscalar et al, same as
with `Universal`, and it contains values from all main value categories.
The default value of `List` is `Bool:False`.  The cardinality of this
type is infinity.

## sys.std.Core.Type.Cat.Structure

`Structure` is a proper subtype of `List` consisting of every `List`
value that matches one of 5 specific formats; each of those formats is
represented by exactly one of 5 mutually disjoint proper subtypes of
`Structure`, which are: `String`, `Tuple`, `Relation`, `ScalarWP`,
`External`; `Structure` is a union type over all 5 of those types, and
`Structure` has no values which are not each of one of those 5 types.  A
`Structure` is a `List` having at least 2 elements, where the first
element is an `Int` in the range `1..5` (one per each of the 5 subtypes)
that indicates how to interpret the remainder of the `Structure` elements.
The default value of `Structure` is `Bool:False`.  The cardinality of
this type is infinity.

## sys.std.Core.Type.Cat.Nonstructure

`Nonstructure` is the difference type when `Structure` is subtracted from
`List`.  The only main reason why `Nonstructure` exists as a named type
is to round out the 5 main broad value categories of the Muldis Data Language type
system, where each category has its own maximal type; a nonstructure value
is any value which is neither a scalar nor a tuple nor a relation nor an
external.  The default value of `Nonstructure` is the sole `List` value
with zero elements.  The cardinality of this type is infinity.

# SIMPLE GENERIC SCALAR TYPES

## sys.std.Core.Type.Cat.ScalarWP

`ScalarWP` (scalar with possreps) is a proper subtype of `Scalar` where
every one of its values has at least one possrep.  `ScalarWP` is just the
difference type where both `Int` and `String` are subtracted from
`Scalar`.  Its default value is `Bool:False`.  The cardinality of this
type is infinity.  Considering the low-level type system, `ScalarWP` is
just a proper subtype of `Structure` consisting of every
`Structure` value whose first element is the `Int` value `4`.

## sys.std.Core.Type.Cat.DHScalarWP

`DHScalarWP` is the intersection type of `ScalarWP` and `DHScalar`.  Its
default value is `Bool:False`, same as both of its parent types.  The
cardinality of this type is infinity.  All Muldis Data Language scalar values that are
allowed to be stored in a global/persisting relational database, besides
`Int` and `String` values, are `DHScalarWP` values.

## sys.std.Core.Type.Cat.SysScalar

The `SysScalar` type is explicitly defined as a domain-union type over all
system-defined `DHScalar` root types, which typically corresponds to
those types for whose values all of the Muldis Data Language standard dialects provide
"opaque value literal" syntax for:  `Bool`, `Int`, `Rat`, `Blob`,
`Text`, `Name`, `NameChain`, `Comment`, `Order`,
`RoundMeth`, `RatRoundRule`, `Singleton`.  The `SysScalar` type is
mainly intended to be used as the declared type of some attributes of some
other system-defined catalog types, as a compact or hard-coded way to
represent scalar values that are *not* being specified explicitly in terms
of possrep attributes.  The `SysScalar` type is *not* intended to be used
as the declared type of any user type attributes, generally speaking; if
they would even consider it, they should be using `DHScalar` instead.  Its
default value is `Bool:False`.  The cardinality of this type is infinity.

## sys.std.Core.Type.Cat.String

A `String` is a string of integers, or more specifically it is a dense
sequence of 0..N elements (*not* defined over `Relation`) where each
element is an `Int`.  The `String` type explicitly composes the
`Stringy` mixin type.  A `String` subtype is normally composed into any
system-defined type that is conceptually a string of integers or bits or
characters, such as `Blob` or `Text`.  The `String` type's default and
canonical minimum value is the empty sequence; its canonical maximum value
is an infinite-length sequence and practically impossible.  `String` is
one of just two scalar root types (the other is `Int`) that do *not* have
any possreps.  The cardinality of this type is infinity; to define a
most-generalized finite `String` subtype, you must specify a maximum
length in elements that the subtype's values can have, and you must specify
the 2 integer end-points of the inclusive range that all its values' `Int`
element values are in.  The `String` type explicitly composes the
`Ordered` mixin type.  The `String` type has a default ordering
algorithm; for 2 distinct `String` values, their order is determined as
follows:  First eliminate any identical leading element sequences from both
strings as those alone would make the strings compare as same (if the
remainder of both strings was the empty string, then the strings are
identical).  Then, iff the remainder of just one string is the empty
string, then that string is ordered before the non-empty one; otherwise,
compare the first element of each of the string remainders according to the
default ordering algorithm of `Int` to get the order of their respective
strings.  Considering the low-level type system, `String` is just a proper
subtype of `Structure` consisting of every `Structure` value whose first
element is the `Int` value `1`.

## sys.std.Core.Type.Cat.BString

`BString` (bit string) is a proper subtype of `String` where all member
value elements are between zero and 1 inclusive.  One can be used to
represent a string of bits.

## sys.std.Core.Type.Cat.OString

`OString` (octet string) is a proper subtype of `String` where all member
value elements are between zero and 255 inclusive.  One can be used to
represent a string of octets.

## sys.std.Core.Type.Cat.CoreText

`CoreText` is a proper subtype of `Text` (and of `Text.ASCII`) where all
member values have just the abstract characters in the 95-character
repertoire of 7-bit ASCII which are its 94 printable characters or its 1
space character but are not its 33 control characters.  `CoreText` adds 1
system-defined possrep named `coretext_chars` which consists of 1
`OString`-typed attribute whose name is the empty string and whose element
values are all in the range 32..126 inclusive, each element being a
code point representing the same abstract character as the same code point of
7-bit ASCII.  The purpose of `CoreText` is to provide a reasonable minimum
of support for character strings in the Muldis Data Language language core.  All
system-defined entity names in the core and in most official modules use
only the `CoreText` repertoire, and this type's primary purpose is to be
used for entity names.  It can also be employed for user data though.

## sys.std.Core.Type.Cat.Name

A `Name` (scalar) is a canonical short
name for any kind of DBMS entity (or named component) when declaring it;
this short name is sufficient to identify the entity within its immediate
namespace.  Similarly, a DBMS entity can often be invoked or referred to
using just its `Name`, depending on the context; other times, a
`NameChain` must be used instead to also qualify the reference with a
namespace.  The `Name` type explicitly composes the `Textual` mixin
type, and by extension also implicitly composes the `Stringy` mixin
type.  A `Name` has 1 system-defined possrep whose name is the empty
string, which has 1 `Text`-typed attribute whose name is the empty
string.  The `Name` type explicitly composes the `Ordered` mixin type.
A `Name` is a simple wrapper for a `Text` and all of its other
details such as default and minimum and maximum values and cardinality and
default ordering algorithm all correspond directly.  But `Name` is
explicitly disjoint from `Text` due to having a different intended
interpretation; it is specifically intended for use in naming DBMS entities
rather than being for general-purpose user data.

## sys.std.Core.Type.Cat.NameChain

A `NameChain` (scalar) is a canonical long
name for invoking or referring to a DBMS entity, when its name needs to be
qualified with a namespace.  A `NameChain` is used in declaring system
catalogs where DBMS entities live under a potentially N-depth namespace,
such as package entities grouped in a
subpackage hierarchy.  The `NameChain` type explicitly composes the
`Stringy` mixin type.  A `NameChain` is conceptually a sequence of
0..N `Name`, the 0..N elements being ordered from parent-most to
child-most component name.  A `NameChain` has 1 system-defined possrep
named `array` which directly matches the conception of the type; it
consists of 1 attribute whose name is the empty string; the attribute is an
`Array` whose `value` attribute has a declared type of `Name`.  The
default and minimum value of
`NameChain` is a zero element sequence; its maximum value is an infinite
sequence where each element is the maximum value of `Name` (an
infinite-length string) and practically impossible.  The cardinality of
this type is infinity; to define a most-generalized finite `NameChain`
subtype, you must specify a maximum number of sequence elements of its
values, and each element must be of a finite `Name` subtype.  The
`NameChain` type explicitly composes the `Ordered` mixin type.  The
`NameChain` type has a default ordering algorithm; for 2 distinct
`NameChain` values, their order is determined as follows:  First eliminate
any identical parent-most elements from both chains as those alone would
make the chains compare as same (if the remainder of both chains was the
empty chain, then the chains are identical).  Then, iff the remainder of
just one chain is the empty chain, then that chain is ordered before the
non-empty one; otherwise, compare the first element of each of the chain
remainders according to the default ordering algorithm of `Name` to get
the order of their respective chains.

## sys.std.Core.Type.Cat.PNSQNameChain

`PNSQNameChain` (primary namespace
qualified name chain) is a proper subtype of `NameChain` where every
member value's chain starts with one of the following element sequences:
`sys.[cat|std|imp]`, `mnt.cat`, `fed.[cat|lib|data]`,
`nlx[.par]**0..*.[cat|lib|data]`, `rtn`, `type`.  *The
definition of the type is actually more restrictive than this, as per the
balance of the invariant rules of the primary namespaces in question, but
those aren't detailed here for brevity.*  One can be used to reference a
material (routine or type or etc) for invocation, either system-defined or
user-defined, or one can be used to reference a variable (or
pseudo-variable or parameter or named expression or statement), either a
system-catalog or normal data variable.  Its default value is a reference
to the `sys.std.Core.Type.Universal` type.

## sys.std.Core.Type.Cat.MaterialNC

`MaterialNC` is a proper subtype of
`PNSQNameChain` where every member value's chain starts with one of the
following element sequences: `sys.[std|imp]`, `fed.lib`,
`nlx[.par]**0..*.lib`, `rtn`, `type`.  One can be used to reference a
material (routine or type or etc) for invocation, either system-defined or
user-defined.  Its default value is a reference to the
`sys.std.Core.Type.Universal` type.

## sys.std.Core.Type.Cat.AbsPathMaterialNC

`AbsPathMaterialNC` is a proper subtype
of `MaterialNC` where every member value's chain starts with either `sys`
or `fed` (or a `type`-prefix followed by those) but not `nlx` or `rtn`.
One is used when conceptually a routine or type is being passed as an
argument to a routine, such as because it is a higher-order function or
closure, and it is in fact the name of the invocant being passed; only an
absolute path can be used in this situation for the general case because
the target is being invoked from a different context than where the
reference to the target is being selected; a relative path doesn't work
because `nlx` or `rtn` means something different on each side of the
NC-argument-taking-routine.  Conceptually speaking, an `AbsPathMaterialNC`
that points to a routine *is* a closure, or a higher-order function if it
points to a function.

## sys.std.Core.Type.Cat.APFunctionNC

`APFunctionNC` is a proper subtype of
`AbsPathMaterialNC` that excludes the `type`-prefix values and a subset
of the `sys`-prefix values.  Its default value is a reference to the
`sys.std.Core.Universal.is_same` function.

## sys.std.Core.Type.Cat.APProcedureNC

`APProcedureNC` is a proper subtype of
`AbsPathMaterialNC` that excludes the `type`-prefix values and a subset
of the `sys`-prefix values.  Its default
value is a reference to the `sys.std.Core.Universal.assign` updater.

## sys.std.Core.Type.Cat.APTypeNC

`APTypeNC` is a proper subtype of `AbsPathMaterialNC` that excludes a
subset of the `sys`-prefix values.  Its default value is a reference to
the `sys.std.Core.Type.Universal` data type.

## sys.std.Core.Type.Cat.RelPathMaterialNC

`RelPathMaterialNC` is a proper subtype
of `MaterialNC` where every member value's chain starts with either `sys`
or `nlx` or `rtn` (or a `type`-prefix followed by those) but not `fed`.
One is used in a context where a user-defined routine or type may only be
invoked directly when both the invoker and invoked are in the same package.

## sys.std.Core.Type.Cat.RPFunctionNC

`RPFunctionNC` is a proper subtype of `RelPathMaterialNC` that excludes
the `type`-prefix values and a subset of the `sys`-prefix values.  Its
default value is a reference to the `sys.std.Core.Universal.is_same`
function.

## sys.std.Core.Type.Cat.RPProcedureNC

`RPProcedureNC` is a proper subtype of `RelPathMaterialNC` that excludes
the `type`-prefix values and a subset of the `sys`-prefix values.  Its
default value is a reference to the `sys.std.Core.Universal.assign`
updater.

## sys.std.Core.Type.Cat.RPTypeNC

`RPTypeNC` is a proper subtype of `RelPathMaterialNC` that excludes the
`rtn` value and a subset of the `sys`-prefix values.  Its default value
is a reference to the `sys.std.Core.Type.Universal` data type.

## sys.std.Core.Type.Cat.DataNC

`DataNC` is a proper subtype of
`PNSQNameChain` where every member value's chain starts with one of the
following element sequences: `sys.cat`, `mnt.cat`, `fed.[cat|data]`,
`nlx[.par]**0..*.[cat|data]`.  One can be used to reference a
variable (or pseudo-variable or parameter or named expression or
statement), either a system-catalog or normal data variable.  Its default
value is a reference to the `sys.cat` catalog relcon.
*Conjecture:  Subtypes like `[Abs|Rel]PathDataNC` might also be defined
later if we have some situation where such a restriction might be useful.*

## sys.std.Core.Type.Cat.Comment

A `Comment` (scalar) is the text of a
Muldis Data Language code comment, which programmers can populate as an attribute of
several catalog data types, such as whole routines or statements or
expression nodes.  The `Comment` type explicitly composes the `Textual`
mixin type, and by extension also implicitly composes the `Stringy`
mixin type.  The `Comment` type explicitly composes the
`Ordered` mixin type.  Every detail of `Comment`'s representation (its 1
possrep, default value and ordering algorithm, etc) is the same as `Name`
but it is explicitly disjoint due to having a different intended
interpretation; it is intended just for commenting Muldis Data Language code.  One main
intended use of this type is to help preserve comments in code translated
to or from other languages; though only a subset of those (FoxPro?) keep
comments in the AST rather than discarding them.

## sys.std.Core.Type.Cat.Order

The `Order` (order determination) type
is explicitly defined as a union type over just these 3 singleton types
having `sys.std.Core.Type.Cat.Order.*`-format names:
`Less`, `Same`, `More`.  When some context
(such as within a list sort or range check operation) needs to know the
relative order of 2 values according to some criteria, it can invoke a
function that applies that criteria to those 2 values, which are its
main/only arguments, and that function results in an `Order` value for the
context to make use of.  The
default value of `Order` is `Same`; its minimum and maximum values are,
respectively, `Less` and `More`.  The cardinality of this type is
3.  The `Order` type explicitly composes the `Ordinal` mixin type, and by
extension also implicitly composes the `Ordered` mixin type.
The `Order` type has a default ordering algorithm that corresponds
directly to the sequence in which its values are documented here;
`Less` is ordered before `Same`, and `Same` before `More`.

## sys.std.Core.Type.Cat.Order.*

There are exactly 3 types having `sys.std.Core.Type.Cat.Order.*`-format;
for the rest of this
description, the type name `Order.Value` will be used as a proxy for each
and every one of them.  A `Order.Value` has 1 system-defined possrep whose
name is the empty string and which has zero attributes.  The cardinality of
this type is 1, and its only value is its default and minimum and maximum
value.

## sys.std.Core.Type.Cat.RoundMeth

The `RoundMeth` (rounding method)
type is explicitly defined as a union type over just these 9 singleton
types having `sys.std.Core.Type.Cat.RoundMeth.*`-format names:
`Down`, `Up`, `ToZero`, `ToInf`, `HalfDown`, `HalfUp`, `HalfToZero`,
`HalfToInf`, `HalfEven`.  When a value
of some ordered type needs to be mapped into a proper subtype that doesn't
contain that value, such as when mapping an arbitrary number to one with
less precision, some rounding method is applied to determine which value of
the subtype is to be mapped to while most accurately reflecting the
original value.  The `RoundMeth` type enumerates the rounding methods
that Muldis Data Language operators can typically apply.  With `Down` (aka *floor*),
`Up` (aka *ceiling*), `ToZero` (aka *truncate*), and `ToInf`, the
original value will always be mapped to the single adjacent value that is
lower than it, or higher than it, or towards "zero" from it, or towards the
nearer infinity from it, respectively.  With `HalfDown`,
`HalfUp`, `HalfToZero`, `HalfToInf`,
and `HalfEven` (aka *unbiased rounding*, *convergent
rounding*, *statistician's rounding*, or *bankers' rounding*), the
original value will be mapped to the single target value that it is closest
to, if there is one; otherwise, if it is exactly half-way between 2
adjacent target values, then `HalfDown` will round towards negative
infinity, `HalfUp` will round towards positive infinity,
`HalfToZero` will round towards "zero", `HalfToInf` will round towards
the nearer infinity, and `HalfEven` will round towards the nearest "even"
target.  The default value of `RoundMeth` is `HalfEven`, since in general
that should be the most likely to minimize the rounding error from a
sequence of operations that each round, which is especially useful in
contexts where a rounding method is implicit.  The
`RoundMeth` type does *not* have a default ordering algorithm.

## sys.std.Core.Type.Cat.RoundMeth.*

There are exactly 9 types having
`sys.std.Core.Type.Cat.RoundMeth.*`-format names;
for the rest of this description, the type name
`RoundMeth.Value` will be used as a proxy for each and every one of
them.  A `RoundMeth.Value` has 1 system-defined possrep whose name is
the empty string and which has zero attributes.  The cardinality of this
type is 1, and its only value is its default and minimum and maximum value.

## sys.std.Core.Type.Cat.RatRoundRule

A `RatRoundRule` (scalar) specifies a
controlled (and typically degrading) coercion of a real number into a
rational number having a specific radix and precision.  It is mainly used
to deterministically massage an operation, whose conceptual result is
generally an irrational number, so that its actual result is a best
approximating rational number.  It is also used to define a generic
rounding operation on a rational number that derives a typically less
precise rational.  A `RatRoundRule` has 1 system-defined possrep whose
name is the empty string, which has these 3 attributes: `radix` (a
`PInt2_N`), `min_exp` (an `Int`), and `round_meth` (a `RoundMeth`).
The rational resulting from the operation is as close as possible to the
conceptual result but that it is an exact multiple of the rational value
resulting from `radix` taken to the power of `min_exp`; if rounding is
needed, then `round_meth` dictates the rounding method.  The default value
of `RatRoundRule` specifies a coersion to a whole number using the
`HalfEven` rounding method (its radix is 2 and its min exp is 0).  The
`RatRoundRule` type does *not* have a default ordering algorithm.

## sys.std.Core.Type.Cat.Singleton

The `Singleton` type is explicitly defined as a union type over just the
system-defined core singleton types which aren't otherwise included in
another union type specific to a group of singleton types.  `Singleton`
only exists as a convenience for concrete Muldis Data Language grammars that want to
have a group type name for every system-defined opaque value.  `Singleton`
currently unions just these 2 types: `-Inf`, `Inf`.

## sys.std.Core.Type.Cat."-Inf"

`-Inf` is a singleton scalar type whose only value represents negative
infinity.  It is intended for use as a special value in contexts that are
sensitive to the ordering of a type's values, wherein it can be the
canonical minimum-most value, and so would be ordered before every other
possible value of `Universal` that it might be compared with.  A `-Inf`
has 1 system-defined possrep whose name is the empty string and which has
zero attributes.  The cardinality of this type is 1, and its only value is
its default and minimum and maximum value.  The only value of `-Inf` is
also known as `-∞`.  `-Inf` explicitly composes `Ordinal`.

## sys.std.Core.Type.Cat.Inf

`Inf` is a singleton scalar type whose only value represents positive
infinity.  It is the same as `-Inf` in every way except it is the
canonical maximum-most value rather than minimum-most.  The only value of
`Inf` is also known as `∞`.  `Inf` explicitly composes `Ordinal`.

# TYPES FOR DEFINING SYSTEM-DEFINED ENTITIES

## sys.std.Core.Type.Cat.System

A `System` is a `Database`.  It specifies the public interfaces of
system-defined entities, specifically all the system-defined types,
routines, and catalogs.  Both standard system-defined entities and
implementation-specific system-defined entities are specified here,
specifically all the relcons and relvars with the names
`[sys|mnt|fed|nlx].cat`.  The system catalog constant named
`sys.cat` is of the `System` type.

A `System` has these 4 attributes:

* `scm_comment` - `just_of.Comment`

This is an optional programmer comment about the collection of
system-defined entities as a whole.

* `special_namespaces` - `SpecialNspSet`

These are all the special system-defined namespaces where not-lexical DBMS
entities may live, or that otherwise always exist due to being
system-defined, which are not defined like users can define namespaces;
all non-special system namespaces are defined by modules instead.
Specifically, it declares these 15 standard language namespaces:
`[sys|mnt|fed|nlx|rtn]` (which have the nameless global
root namespace as their parent, spelled as the empty `NameChain`
value, that isn't also declared here), `sys.[cat|std|imp]`,
`mnt.cat`, `[fed|nlx].[cat|lib|data]`; it also declares,
where applicable, implementation-specific extensions (none are yet known).

* `modules` - `ModuleSet`

These are all the system-defined modules, which have all the system-defined
routines and types.  This always contains at least the single standard
`Core` module and optionally contains other standard or
implementation-specific modules, as the current DBMS provides.

* `catalogs` - `CatalogSet`

These are the interfaces of all the catalog relcons and relvars.
Specifically, it declares these 4 standard catalogs:
`[sys|mnt|fed|nlx].cat`; the first is a relcon, the others not.

The default value of `System` defines a system with zero builtins.

## sys.std.Core.Type.Cat.SpecialNspSet

A `SpecialNspSet` is a `DHRelation` that specifies the set of special
system namespaces that exist for organizing all other DBMS public entities;
these special system namespaces are organized into a tree whose root has no
name.  A `SpecialNspSet` only specifies that a special system namespace
exists, not which public entities it contains; see the `System` which
contains it for that.

A `SpecialNspSet` has these 4 attributes:

* `parent` - `NameChain`

This is the fully-qualified name, in the nameless global root namespace, of
the special system namespace's parent special system namespace.

* `name` - `Name`

This is the declared name of the special system namespace within the
special namespace defined by `parent`; other Muldis Data Language code would reference
it with the combination of `parent` and `name`.

* `scm_comment` - `Comment`

This is an optional programmer comment about this specific special system
namespace.

* `scm_vis_ord` - `NNInt`

This is the visible order of this namespace's declaration relative to all
of the named entities directly within the namespace defined by `parent`.

A `SpecialNspSet` has a binary primary key on the `parent` plus
`name` attributes.  Its default value is empty.

## sys.std.Core.Type.Cat.ModuleSet

A `ModuleSet` is a `DHRelation` that specifies a set of system-defined
modules, such that each tuple is a single module.

A `ModuleSet` has these 5 attributes:

* `parent` - `NameChain`

This is the fully-qualified name, in the nameless global root namespace, of
the module's parent special system namespace.  This is always either
`sys.std` or `sys.imp`.

* `name` - `Name`

This is the declared name of the module within the
special namespace defined by `parent`; other Muldis Data Language code would reference
it with the combination of `parent` and `name`.

* `scm_comment` - `Comment`

This is an optional programmer comment about this specific module.

* `scm_vis_ord` - `NNInt`

This is the visible order of this module's declaration relative to all
of the named entities directly within the namespace defined by `parent`.

* `module` - `Module`

This defines the entire system catalog of the module.

A `ModuleSet` has a unary primary key on the `name` attribute.
Its default value is empty.

## sys.std.Core.Type.Cat.CatalogSet

A `CatalogSet` is a `DHRelation` that specifies a set of system-defined
catalog dbvars; each tuple specifies one catalog dbvar.

A `CatalogSet` has these 5 attributes:

* `name` - `DataNC`

This is the fully-qualified name of the catalog dbvar.

* `scm_comment` - `Comment`

This is an optional programmer comment about the catalog dbvar as a whole.

* `scm_vis_ord` - `NNInt`

This is the visible order of this catalog's declaration relative to all of
the other catalogs.

* `is_readonly` - `Bool`

This is `Bool:True` if a catalog relcon is being described; it is
`Bool:False` if a catalog relvar is being described.

* `catalog` - `MaterialNC`

This is the declared data type of the catalog dbvar.

A `CatalogSet` has a unary primary key on the `name` attribute.  Its
default value is empty.

# TYPES FOR DEFINING MOUNT CONTROLS

## sys.std.Core.Type.Cat.MountControlCat

A `MountControlCat` is a `Database`.  It specifies the control
interface for mounting and unmounting (and creating and deleting) depots
within the current in-DBMS process.  The scope of these controls includes
specifying what name the depot is mounted with, whether the mount is
readonly vs updateable, or is temporary vs persistant, and implementation
specific details like storage file names or network login credentials.
Updates to this catalog have side-effects in what other user-updateable
catalogs exist, making them appear or disappear.  This catalog may only be
updated when the current process has no active transaction.  The system
catalog variable named `mnt.cat` is of the `MountControlCat` type.

A `MountControlCat` has these 2 attributes:

* `scm_comment` - `just_of.Comment`

This is an optional programmer comment about the depot mount control
catalog as a whole.

* `mounts` - `MountControlSet`

These are the controls for the current depot mounts.

The default value of `MountControlCat` has zero depot mount controls.

## sys.std.Core.Type.Cat.MountControlSet

A `MountControlSet` is a `DHRelation` that specifies a set of controls
per depot mounts, such that each tuple is a single control for a depot
mount, and each depot mount has 1 mount control.  Inserting a tuple will
result in either an existing depot being mounted or a new depot being
created (if possible) and mounted; updating a tuple will change some
details of that depot mount's status, such as making it readonly or
updateable; deleting a tuple will result in a mounted depot being either
unmounted or unmounted plus deleted (if possible).

A `MountControlSet` has these 8 attributes:

* `name` - `Name`

This is the declared name of the depot mount; other Muldis Data Language code would
reference it with this name.

* `scm_comment` - `Comment`

This is an optional programmer comment about this specific mount of the
depot.

* `is_temporary` - `Bool`

This is `Bool:True` if the depot mount is for a transient depot that would
automatically be created when mounted *and* automatically be deleted when
unmounted, because it is only intended for use as the application's current
working memory, and its maximum lifetime is the lifetime of the in-DBMS
process.  This is `Bool:False` (the default) if the depot mount is for a
depot that either should already exist before being mounted, *or* that
should continue to exist after being unmounted, because it is intended for
persistent data.  Note that the `is_temporary` status is orthogonal to
whether the depot's storage is in volatile memory (eg, RAM) or in stable
memory (eg, on disk); a *not-temporary* depot is simply one that is meant
to be reusable by multiple depot mounts or processes.  The `is_temporary`
status may not be updated on an existing depot mount control.  *These
details are subject to revision.*

* `create_on_mount` - `Bool`

This is `Bool:True` if the depot mount must represent a depot that was
newly created at the time the depot mount was created, where the depot
creation is a direct side-effect of the mount operation.  This is
`Bool:False` (the default) if the depot being mounted must already exist
without the mounting process having any hand in creating it.  Note that
there is no option provided to conditionally create a depot depending on
whether it already exists, as a perceived safety feature (this detail is
subject to change); to get that behaviour, first try creating the depot
mount control with this attribute `Bool:False`, and if that fails due to
nonexistence, then try again with it set to `Bool:True`.  This attribute
is ignored / not applicable when `is_temporary` is true.

* `delete_on_unmount` - `Bool`

This is `Bool:True` if the depot should be deleted at the same time it is
unmounted, that is, when this depot mount control tuple is deleted.  This
is `Bool:False` (the default) if the depot should not be deleted as part
of the unmount process.  This attribute is ignored / not applicable when
`is_temporary` is true.

* `we_may_update` - `Bool`

This is `Bool:True` if the depot mount will permit the current in-DBMS
process to make any kind of update to the depot, such as data manipulation,
data definition, or creating/deleting it.  This is `Bool:False` (the
default) if the depot mount is only providing readonly access to the depot.
When a depot mount is readonly, any attempt to update the depot through it
will throw a runtime exception.  The `we_may_update` attribute may be set
to `Bool:False` at any time (when there is no active transaction), but it
may only be set to `Bool:True` at the time the depot is mounted; this is
for safety, such that if a depot mount won't let you update the depot now,
there's no way it will let you update it later, save by unmounting and
remounting the depot (the result of which is a different depot mount).
Note that the `we_may_update` status is orthogonal to the depot locking
mechanism; it won't block any other process from reading or updating that
depot, so unless you have locks on the depot using some other means, it may
still be updated by others while mounted readonly for you, so consistent
reads between distinct statements outside of transactions are not
guaranteed.  *These details are subject to revision, such as in regards to
what autonomous child processes of the current process may do.*

* `allow_auto_run` - `Bool`

This is `Bool:True` if the depot mount will permit any stimulus-response
rules defined in the depot to automatically execute when triggering events
occur; those events could be nearly anything, including the very act of
mounting (or unmounting) that depot.  This is `Bool:False` (the default)
if the depot mount will prohibit all stimulus-response rules defined in the
depot from automatically executing.  The primary purpose of the
`allow_auto_run` attribute is to provide a measure of security against
viruses and other malware that are using Muldis Data Language databases as a vector,
especially where the malicious code is setup to run automatically as soon
as its host depot is mounted, which is insidious because in general users
have to mount a depot in order to even examine it to see if its contents
are safe, at which point it is too late.  When you have a depot with a
dubious history, mounting it initially with a false `allow_auto_run` will
allow you to examine the depot for malware without giving the latter any
opportunity to run; moreover, you will be able to clean out a virus
infection from a depot that you otherwise wish to preserve (it is just
data, after all); and then you can remount the depot with a true
`allow_auto_run` once you know it is clean, in order for benign
auto-running code to work.  If a depot is "the main program" in a pure
Muldis Data Language application, then `allow_auto_run` must be `Bool:True` in order
for it to work properly since auto-running is how the initial Muldis Data Language
routine of a call chain is invoked, and otherwise the program will
immediately exit on launch without doing anything.  When `allow_auto_run`
is `Bool:False` (and `we_may_update` is `Bool:True`), then the depot's
catalog dbvar is updateable, so that you can purge any viruses, but the
depot's data dbvar is read-only, because in the general case there may be
some database constraints or benign side-effects of data manipulation that
would be prevented from doing their jobs because they are defined as
stimulus-response rules, and allowing data manipulation then could lead to
violations of otherwise-enforced business rules.  Note that a false
`allow_auto_run` will not prohibit you from manually invoking code in the
depot, so be careful not to invoke something unsafe.  Note that having a
false `we_may_update` status alone isn't adequate protection against
malware because even in that situation any stimulus-response rules whose
triggers aren't data manipulation events will still automatically run, and
the malware can still do all sorts of harm, since stimulus-response rules
in general can do anything a `procedure` can, including various I/O or
manipulating other depots.

* `details` - `SysScaValExprNodeSet`

These are the 0..N other miscellaneous details that define this depot mount
control.  Each tuple in `details` specifies an implementation-specific
attribute name and (scalar) value.  Example such implementation-specific
details include the name of a local file that the depot is stored as, or
the name of a DBMS server on the network plus authentication credentials to
connect to it with.  See each Muldis Data Language implementation for details.  Note
that `details` generally corresponds to the Perl DBI's concept of a data
source name or connection string.  But `details` can also have other
details like customizations on how to map a foreign DBMS' concepts to
native Muldis Data Language equivalents, or maybe information on where to find extra
metadata that has such info, or info to instruct a Muldis Data Language interface to
fill in functionality missing in the actual depot of a less capable DBMS,
like constraints or stored invokable routines.

A `MountControlSet` has a unary primary key on the `name` attribute.  Its
default value is empty.  `mnt.cat` also has a transition constraint that
prevents changing some attributes of a depot mount control once set.  Note
that the 3 attributes [`is_temporary`, `create_on_mount`,
`delete_on_unmount`] may be merged into a single enumerated-typed
attribute or otherwise be reorganized.

# TYPES FOR DEFINING FEDERATIONS

## sys.std.Core.Type.Cat.Federation

A `Federation` is a `Database`.  It specifies a federation of depot
mounts, that is, all the depot mounts that an in-DBMS process can see or
update, and that defines the scope of an active transaction.  There is
exactly one of these per process and it doesn't have a name.  The system
catalog variable named `fed.cat` is of the `Federation` type.

A `Federation` has these 3 attributes:

* `scm_comment` - `just_of.Comment`

This is an optional programmer comment about the federation as a whole.

* `mounts` - `DepotMountSet`

These are the depot mounts that comprise the federation.

* `type_maps` - `FedTypeMapSet`

When this federation has more than one depot mount, and the depots have
copies of the same data types, then `type_maps` is used to specify which
types in each depot correspond to types in others, so that during the time
period of common mounting, those data types can be treated as aliases and
so be used interchangeably.  Mainly this is used when either a procedure in
one depot wants to access or update a dbvar of another depot, or when a
procedure in one depot wants to invoke a routine in another depot, that
have parameters/etc of some user-defined data type.  The expected most
common use case would be when there are 2 depot mounts, one being a
persistent database and the other being transient application-specific code
that creates or otherwise works with that persistent database.

The default value of `Federation` has zero depot mounts.

## sys.std.Core.Type.Cat.DepotMountSet

A `DepotMountSet` is a `DHRelation` that specifies a set of depot
mounts, such that each tuple is a single depot mount.  A depot mount is a
named in-DBMS context by which a depot is referenced from either other
depots or by the main application, and it also specifies the catalog
content of the depot itself.

A `DepotMountSet` has these 3 attributes:

* `name` - `Name`

This is the declared name of the depot mount; other Muldis Data Language code would
reference it with this name.

* `scm_comment` - `Comment`

This is an optional programmer comment about this specific mount of the
depot.

* `depot` - `Depot`

This defines the entire system catalog of the depot that this mount has
made visible to the DBMS.

A `DepotMountSet` has a unary primary key on the `name` attribute.
Its default value is empty.

## sys.std.Core.Type.Cat.FedTypeMapSet

A `FedTypeMapSet` is a `DHRelation` such that each tuple in it
specifies which of multiple depots have a copy of the same data type, for
the purpose of treating all the copies as being interchangeable, so to
support cross-depot interaction.

A `FedTypeMapSet` has these 2 attributes:

* `scm_comment` - `Comment`

This is an optional programmer comment about this type mapping.

* `types` - `set_of.APTypeNC`

This lists the `fed.`-qualified names of 0..N data types that are all
considered to be copies of the same 1 type, and should be treated
interchangeably by the DBMS.

A `FedTypeMapSet` has a primary key on the `map` attribute.  Its
default value is empty.

# TYPES FOR DEFINING PACKAGES AND SUBPACKAGES

## sys.std.Core.Type.Cat.Package

A `Package` is a `Database`.  It specifies the entire system catalog of a
single package, that is, the widest scope within which all entities must be
fully defined in terms of just user-defined entities within the same scope
or of system-defined entities.  It also doubles to specify the system
catalog of a subpackage, which is an arbitrary subset of a package's
entities that internally looks like a package; a package can have 0..N
subpackages, and any that exist are arranged in a hierarchy with the
package as the root.  The system catalog variable named `nlx.cat` is of
the `Package` type.

A `Package` has these 17 attributes:

* `scm_comment` - `just_of.Comment`

This is an optional programmer comment about the [|sub]package as a whole.

* `subpackages` - `SubpackageSet`

These are all the subpackages that this system catalog contains (which
might be none).

* `functions|procedures` - `[Function|Procedure]Set`

These are all the definitions that this [|sub]package contains of
functions, procedures.

* `special_types` - `SpecialTypeSet`

These are the few central system-defined data types that have special
hard-coded meanings and are not defined like any other types; these are
declarations of all of the native Muldis Data Language types that can't be defined like
user-defined types.  Specifically, it declares all 2 Muldis Data Language declaration
types in the `Core` module, and only declaration types: in the `Type`
namespace: `Int`; in the `Type.Cat` namespace: `List`.
**Only the `Core` module has a nonempty `special_types`; all other
packages must have an empty one.**

* `[scalar|tuple|relation|domain|subset|mixin]_types` -
`[Scalar|Tuple|Relation|Domain|Subset|Mixin]TypeSet`

These are all the definitions that this [|sub]package contains of scalar
types with possreps, complete tuple and relation types, domain types, and
subset types, and mixin types.  This includes the 2 Muldis Data Language type system
maximal and minimal (enumeration) types, `Universal` and `Empty`, which
are declared as domain types.  This includes all enumeration types, period.

* `[|distrib_][key|subset]_constrs` -
`[|Distrib][Key|Subset]ConstrSet`

These are all the definitions that this [|sub]package contains of
|distributed key|subset constraints.

* `stim_resp_rules` - `StimRespRuleSet`

These are all the definitions that this [|sub]package contains of
stimulus-response rules.  *For any system-defined package,
`stim_resp_rules` is probably always empty.*

* `data` - `maybe_of.RPTypeNC`

This is the declared data type of the self-local dbvar that this
[|sub]package contains, iff `data` is a `Just`; if `data` is `Nothing`
(the default), then this [|sub]package does not have a self-local dbvar.
*For any system-defined package, `data` is probably always `Nothing`.*

There is a distributed binary primary key over the `parent` plus `name`
attributes of all 8 of a `Package`'s main `DHRelation`-typed attributes.

A `Package` is constrained such that all of its `Name`-typed components
must have possrep attribute values of the same system-defined
possrep-adding `Text` subtype (such as `CoreText` or `Text.Unicode`),
and hence are all directly comparable.  Similarly, a `Package` is
constrained such that all of its `Comment`-typed components must have
possrep attribute values of the same possrep-adding `Text` subtype.

The default value of `Package` defines an empty [|sub]package
that does not have any self-local dbvar.

## sys.std.Core.Type.Cat.Module

A `Module` specifies the entire system catalog of a single module (or
submodule), which is a kind of package (or subpackage).  `Module` is a
proper subtype of `Package` where for every member value its
`stim_resp_rules` and `data` attributes are empty.  *It is possible in
the future that `Module` may change to a non-proper subtype of `Package`
should system-defined stimulus-response rules or data dbcons be useful.*

## sys.std.Core.Type.Cat.Depot

A `Depot` specifies the entire system catalog of a single depot (or
subdepot), which is a kind of package (or subpackage).  `Depot` is a
proper subtype of `Package` where for every member value its
`special_types` attribute is empty.

## sys.std.Core.Type.Cat.SubpackageSet

A `SubpackageSet` is a `DHRelation` that specifies the set of subpackages
that a package might optionally have for organizing its entities;
these subpackages are organized into a tree whose root is the package.  A
`SubpackageSet` only specifies that a subpackage exists, not which package
entities it contains; see the `Package` which contains it for that.

A `SubpackageSet` has these 4 attributes:

* `parent` - `NameChain`

This is the fully-qualified name, in the `nlx.[cat|lib|data]` namespace,
of any hypothetical immediate child namespace of the package, of the
subpackage's parent subpackage, which is often just the package itself.

* `name` - `Name`

This is the declared name of the subpackage within the namespace defined by
`parent`; other Muldis Data Language code would reference it with the combination of
`parent` and `name`.

* `scm_comment` - `Comment`

This is an optional programmer comment about this specific subpackage as
associated with this subpackage name.

* `scm_vis_ord` - `NNInt`

This is the visible order of this subpackage's declaration relative to all
of the named entities directly within the namespace defined by `parent`.

A `SubpackageSet` has a binary primary key on the `parent` plus
`name` attributes.  Its default value is empty.

## sys.std.Core.Type.Cat.[Function|Procedure]Set

A `[Function|Procedure]Set` is a `DHRelation` that
specifies a set of functions|procedures
that a [|sub]package might directly contain.  *each routine may be
either public for the DBMS as a whole or private to the subpackage.*

A `[Function|Procedure]Set` has these 5 attributes:

* `parent` - `NameChain`

This is the fully-qualified name, in the `nlx.[cat|lib|data]` namespace,
of any hypothetical immediate child namespace of the package, of the
function|procedure's parent [|sub]package.

* `name` - `Name`

This is the declared name of the function|procedure within
the namespace defined by `parent`; other Muldis Data Language code would reference it
with the combination of `parent` and `name`.

* `scm_comment` - `Comment`

This is an optional programmer comment about the
function|procedure as a whole.

* `scm_vis_ord` - `NNInt`

This is the visible order of this routine's declaration relative to all of
the named entities directly within the namespace defined by `parent`.

* `material` - `Function|Procedure`

This defines the entire function|procedure sans its name.
Note that it is not mandatory for a system-defined routine to have a
specified *body* (just a specified *heading* is mandatory), and often it
won't; but often it will, especially if it is a function used in the
definition of a system-defined data type.

A `[Function|Procedure]Set` has a binary primary key on the
`parent` plus `name` attributes.  Its default value is empty.

## sys.std.Core.Type.Cat.SpecialTypeSet

A `SpecialTypeSet` is a `DHRelation` that specifies a set of
system-defined types which are particularly special and unlike other types;
it is used for declaring all system types that can't be defined like user
types.  It is only nonempty for the `Core` module.

A `SpecialTypeSet` has these 4 attributes:

* `parent` - `NameChain`

This is the fully-qualified name, in the `nlx.[cat|lib|data]` namespace,
of any hypothetical immediate child namespace of the package, of the
special type's parent [|sub]package.

* `name` - `Name`

This is the declared name of the special type within the namespace defined
by `parent`; other Muldis Data Language code would reference it with the combination
of `parent` and `name`.

* `scm_comment` - `Comment`

This is an optional programmer comment about the special type as a whole.

* `scm_vis_ord` - `NNInt`

This is the visible order of this type's declaration relative to all of
the named entities directly within the namespace defined by `parent`.

A `SpecialTypeSet` has a binary primary key on the `parent` plus
`name` attributes.  Its default value is empty.

## sys.std.Core.Type.Cat.[Scalar|Tuple|Relation|Domain|Subset|Mixin]TypeSet

A `[Scalar|Tuple|Relation|Domain|Subset|Mixin]TypeSet` is a `DHRelation`
that specifies a set of scalar|tuple|relation|domain|subset|mixin types
that a [|sub]package might directly contain.  *each type may be
either public for the DBMS as a whole or private to the subpackage.*

A `[Scalar|Tuple|Relation|Domain|Subset|Mixin]TypeSet` has these 5
attributes:

* `parent` - `NameChain`

This is the fully-qualified name, in the `nlx.[cat|lib|data]` namespace,
of any hypothetical immediate child namespace of the package, of the
scalar|tuple|relation|domain|subset|mixin type's parent [|sub]package.

* `name` - `Name`

This is the declared name of the scalar|tuple|relation|domain|subset|mixin
type within the namespace defined by `parent`; other Muldis Data Language code would
reference it with the combination of `parent` and `name`.

* `scm_comment` - `Comment`

This is an optional programmer comment about the
scalar|tuple|relation|domain|subset|mixin type as a whole.

* `scm_vis_ord` - `NNInt`

This is the visible order of this type's declaration relative to all of
the named entities directly within the namespace defined by `parent`.

* `material` - `[Scalar|Tuple|Relation|Domain|Subset|Mixin]Type`

This defines the entire scalar|tuple|relation|domain|subset|mixin type sans
its name.

A `[Scalar|Tuple|Relation|Domain|Subset|Mixin]TypeSet` has a binary
primary key on the `parent` plus `name` attributes.  Its default value is
empty.

## sys.std.Core.Type.Cat.[|Distrib][Key|Subset]ConstrSet

A `[|Distrib][Key|Subset]ConstrSet` is a `DHRelation` that specifies a
set of |distributed key|subset constraints that a [|sub]package might
directly contain.

A `[|Distrib][Key|Subset]ConstrSet` has these 5 attributes:

* `parent` - `NameChain`

This is the fully-qualified name, in the `nlx.[cat|lib|data]` namespace,
of any hypothetical immediate child namespace of the package, of the
|distributed key|subset constraint's parent [|sub]package.

* `name` - `Name`

This is the declared name of the |distributed key|subset constraint within
the namespace defined by `parent`; other Muldis Data Language code would reference it
with the combination of `parent` and `name`.

* `scm_comment` - `Comment`

This is an optional programmer comment about the |distributed key|subset
constraint as a whole.

* `scm_vis_ord` - `NNInt`

This is the visible order of this constraint's declaration relative to all
of the named entities directly within the namespace defined by `parent`.

* `material` - `[|Distrib][Key|Subset]Constr`

This defines the entire |distributed key|subset constraint sans its name.

A `[|Distrib][Key|Subset]ConstrSet` has a binary primary key on the
`parent` plus `name` attributes.  Its default value is empty.

## sys.std.Core.Type.Cat.StimRespRuleSet

A `StimRespRuleSet` is a `DHRelation` that specifies a set of
stimulus-response rules that a [|sub]package might directly contain.

A `StimRespRuleSet` has these 5 attributes:

* `parent` - `NameChain`

This is the fully-qualified name, in the `nlx.[cat|lib|data]` namespace,
of any hypothetical immediate child namespace of the package, of the
stimulus-response rule's parent [|sub]package.

* `name` - `Name`

This is the declared name of the stimulus-response rule within the
namespace defined by `parent`; other Muldis Data Language code would reference it with
the combination of `parent` and `name`.

* `scm_comment` - `Comment`

This is an optional programmer comment about the stimulus-response rule as
a whole.

* `scm_vis_ord` - `NNInt`

This is the visible order of this rule's declaration relative to all of
the named entities directly within the namespace defined by `parent`.

* `material` - `StimRespRule`

This defines the entire stimulus-response rule sans its name.

A `StimRespRuleSet` has a binary primary key on the `parent` plus `name`
attributes.  Its default value is empty.

# TYPES FOR DEFINING ROUTINES

## sys.std.Core.Type.Cat.Function

A `Function` is a `DHTuple`.  It defines a new function, which has 2
main parts, called *heading* and *body*:  The *heading* defines the
function's entire public interface, which is all the details of how to use
it, except for its name, and no more detail than
necessary about how it is implemented.  The *body* defines the function's
entire implementation (or the main body of a function), besides its
name/etc and what the *heading* defines.  The function's name is
provided by the larger context that embeds the
`Function`, which is either a `Package` or `System`.  Every `Function`
must have a specified *heading*, but having a specified *body* is
optional iff the `Function` is embedded in a `System`, because often the
implementations of system-defined routines are not defined in terms of
other Muldis Data Language routines, but that the *body* must not be specified if the
`Function` is virtual.

A `Function` has these 7 attributes, of which the 5 `result_type`,
`params`, `opt_params`, `dispatch_params`, `implements` define the
*heading* and the 1 `expr` defines the *body*:

* `scm_comment` - `Comment`

This is an optional programmer comment about the function as a whole.

* `result_type` - `RPTypeNC`

This is the declared result data type of the function as a whole.

* `params` - `NameTypeMap`

This is the declared parameter list of the function, which has 0..N named
and typed parameters.

* `opt_params` - `set_of.Name`

This indicates the subset of the function's parameters that are optional,
that is, do not need to be supplied explicit arguments when the function is
invoked; any function parameters not named here must be supplied explicit
arguments.  Any parameter marked as optional which is not given an explicit
argument will implicitly default to the default value of its declared type.
Each element of `opt_params` must match a parameter name in `params`.

* `dispatch_params` - `set_of.Name`

Iff `dispatch_params` is nonempty then this function is a virtual
function; otherwise, empty means not virtual.  A virtual function must
have no *body* specified.  This attribute indicates the subset of the
function's parameters whose invocation arguments' types are consulted to
determine which other function, that explicitly implements this virtual
one, is automatically dispatched to.  Each element of `dispatch_params`
must match a parameter name in `params`.  Any given parameter can not be
both a dispatch parameter and an optional parameter.

* `implements` - `set_of.RPFunctionNC`

Iff `implements` is nonempty then this function is explicitly declaring
that it implements the other (typically just one), virtual functions named
by its elements; otherwise, empty means not implementing any virtuals.  An
implementing function must have the same parameter list as its virtuals,
save that the implementer's parameters' and result's declared types must be
subtypes of the corresponding ones of the virtuals.

* `expr` - `ExprNodeSet`

This defines the value expression tree that comprises the entire
function body.

Iff a `Function` has no specified *body*, then `expr` must have zero
member nodes; otherwise, `expr` must have at least 1 member node.

A `Function` with a specified *body*
specifies a simple value expression tree of named
expression nodes, each of which is a tuple of one of its `expr.\w+_exprs`
attributes.  It must have at least 1 member node, and
all member nodes must define a
simple expression node tree, such that every member except one (which is
the root node) has one of its peers as a parent node, and no direct cycles
between members are permitted (only indirect cycles based on
function invocations are allowed); the name of the root node must be the
empty string.  Note that the composed-into function's parameters
are also implicitly tree nodes, and are referenced by name into the
expression the same way as any other named expression node is.  The
tree must denote a value
expression whose result type is of the result type of the function
it is composed into, and which references all of the function's parameters.

`Function` has a distributed primary key over the `name` attributes of
`params` and the `name` attributes of all the attributes of `expr`.  Its
default value has zero parameters, a result type of `Bool`, and has no
specified *body*.

## sys.std.Core.Type.Cat.NamedValFunc

A `NamedValFunc` defines a `named-value`, which is a kind of function.
`NamedValFunc` is a proper subtype of `Function` where all member values
declare a function that is nullary / has exactly zero parameters.  Its
default value is a function whose invocation unconditionally results in
`Bool:False`.

## sys.std.Core.Type.Cat.ValMapFunc

A `ValMapFunc` defines a `value-map`, which is a kind of function.
`ValMapFunc` is a proper subtype of `Function` where all member values
declare a function that has at least 1 parameter, and that 1 is named
`topic`.  Its default value is the same as that of its `ValMapUFunc`
subtype.

## sys.std.Core.Type.Cat.ValMapUFunc

A `ValMapUFunc` defines a `value-map-unary`, which is a kind of
`value-map`.  `ValMapUFunc` is a proper subtype of `ValMapFunc` where
all member values declare a function that is unary / has exactly one
parameter (just the `topic` parameter).  Its default value is a function
whose invocation unconditionally results in its `topic` argument and whose
only parameter has a declared type of `Universal`.

## sys.std.Core.Type.Cat.ValFiltFunc

A `ValFiltFunc` defines a `value-filter`, which is a kind of
`value-map`.  `ValFiltFunc` is a proper subtype of `ValMapFunc` where
all member values declare a function whose result's declared type is
`Bool`.  Its default value is the same as that of its `ValConstrFunc`
subtype.

## sys.std.Core.Type.Cat.ValConstrFunc

A `ValConstrFunc` defines a `value-constraint`, which is a kind of
`value-filter` *and* a kind of `value-map-unary`.  `ValConstrFunc` is
the intersection type of `ValFiltFunc` and `ValMapUFunc`.  Its default
value is a function whose invocation unconditionally results in
`Bool:True` and whose only parameter has a declared type of `Universal`.

## sys.std.Core.Type.Cat.ValRedFunc

A `ValRedFunc` defines a `value-reduction`, which is a kind of function.
`ValRedFunc` is a proper subtype of `Function` where all member values
declare a function that has at least 2 parameters, and those 2 are named
`v1` and `v2`, and the declared types of those 2 parameters are
identical, and the declared type of the function's result is identical to
that of either of those 2 parameters.  Its default value is a function,
whose invocation unconditionally results in its `v1` argument, and that
has exactly 2 parameters, and all 3 of its declared types are `Universal`.

## sys.std.Core.Type.Cat.OrdDetFunc

An `OrdDetFunc` defines an `order-determination`, which is a kind of
function.  `OrdDetFunc` is a proper subtype of `Function` where all
member values declare a function that has at least 3 parameters, and those
3 are named `topic`, `other` and `is_reverse_order`, and the declared
types of `topic` and `other` are identical, and the declared type of
`is_reverse_order` is `Bool`, and the declared type of the function's
result is `Order`.  Its default value is a function, whose `topic` and
`other` parameters both have the declared type of `Bool`, which orders
`Bool:False` before `Bool:True`.

## sys.std.Core.Type.Cat.ExprNodeSet

An `ExprNodeSet` is a `Database` that specifies a set of named value
expression nodes.  It is typically composed into a
function or procedure.  Each tuple of an `ExprNodeSet` attribute is a
named expression node, which is the majority component of functional Muldis Data Language
code.  All arbitrarily complex Muldis Data Language expression trees, including
relational queries, are composed of just expression nodes, either directly,
or indirectly by way of function invocations, as each function body is
itself composed entirely of a single expression tree (of at least 1 node).
Note that, while the
general case has expression trees simply denoting a value, in some cases
they may instead define a pseudo-variable / virtual variable; that only
happens with procedures where the expression is used as an argument
for a subject-to-update parameter of a procedure call, or in the target
position of a generic assignment statement; in that case the leaf nodes /
only node of the expression must map to a subject-to-update parameter or
variable of the expression-containing procedure.

An `ExprNodeSet` has these 15 attributes:

* `sys_sca_val_exprs` - `SysScaValExprNodeSet`

These are expression nodes that represent scalar values of types such that
all of the standard Muldis Data Language dialects provide special "opaque value
literal" syntax specific to the type.  These are expression nodes that
represent scalar value literals that are *not* specified simply in terms
of possrep attributes.

* `sca_sel_exprs` - `ScaSelExprNodeSet`

These are expression nodes that represent generic scalar value
selections specified just in terms of possrep attributes.

* `tup_sel_exprs` - `TupSelExprNodeSet`

These are expression nodes that represent tuple value selections.

* `rel_sel_exprs` - `RelSelExprNodeSet`

These are expression nodes that represent generic relation value
selections.

* `set_sel_exprs` - `SetSelExprNodeSet`

These are expression nodes that represent set value selections.

* `ary_sel_exprs` - `ArySelExprNodeSet`

These are expression nodes that represent array value selections.

* `bag_sel_exprs` - `BagSelExprNodeSet`

These are expression nodes that represent bag value selections.

* `sp_ivl_sel_exprs` - `SPIvlSelExprNodeSet`

These are expression nodes that represent single-piece interval value
selections.

* `mp_ivl_sel_exprs` - `MPIvlSelExprNodeSet`

These are expression nodes that represent multi-piece interval value
selections.

* `list_sel_exprs` - `ListSelExprNodeSet`

These are expression nodes that represent low-level list value selections.

* `acc_exprs` - `AccExprNodeSet`

These are expression nodes that represent accessors of attributes of other,
tuple-valued expression nodes, or aliases of other expression nodes.

* `func_invo_exprs` - `FuncInvoExprNodeSet`

These are expression nodes that represent function invocations.

* `if_else_exprs` - `IfElseExprNodeSet`

These are expression nodes that represent if-else control flow expressions.

* `given_when_def_exprs` - `GivenWhenDefExprNodeSet`

These are expression nodes that represent given-when-default control flow
expressions.

* `ap_material_nc_sel_exprs` - `APMaterialNCSelExprNodeSet`

These are expression nodes that define routine or type reference literals.

There is a distributed primary key over the `name` attributes of all of an
`ExprNodeSet`'s attributes.  Its default value is empty.

Note that, for each expression node in an `ExprNodeSet`, iff the
expression node is declared directly within its host routine's body,
then its `scm_vis_ord` attribute is non-zero, and the latter gives the
node's visible order relative to all other such expression nodes, and all
update statements if applicable, of the host routine, and all update
statements of said host routine; otherwise, iff the expression node is
nested beneath another expression node or a statement node, then the
`scm_vis_ord` attribute isn't applicable, and is zero.  In other words,
when generating concrete Muldis Data Language code from a `Function` or `Procedure`,
the sole determinant of whether to nest any given expression node under
another expression or statement node, or not, is based on whether its
`scm_vis_ord` is zero or not; zero means nested, non-zero means otherwise.

## sys.std.Core.Type.Cat.SysScaValExprNodeSet

An `SysScaValExprNodeSet` is a `DHRelation` that specifies a set of value
expression nodes where each node is a hard-coded scalar literal that is
*not* being specified explicitly in terms of possrep attributes, but
rather is specified using special "opaque value literal" syntax that all
of the Muldis Data Language standard dialects provide.

An `SysScaValExprNodeSet` has these 4 attributes:

* `name` - `Name`

This is the declared name of the expression node.

* `scm_comment` - `Comment`

This is an optional programmer comment about the expression (leaf) node.

* `scm_vis_ord` - `NNInt`

This is the visible order, if applicable, of this non-nested expression
node relative to all of its sibling such expression nodes, or statements.

* `value` - `SysScalar`

This is the actual scalar value that the expression node represents.

An `SysScaValExprNodeSet` has a unary primary key on the `name`
attribute.  Its default value is empty.

## sys.std.Core.Type.Cat.ScaSelExprNodeSet

A `ScaSelExprNodeSet` is a `DHRelation` that specifies a set of value
expression nodes where each node represents a scalar value
selection that is specified explicitly in terms of possrep attributes.
This node kind may be used for values of absolutely any scalar type at all,
including all system-defined types, except for values of `Int`
and `String`, although
optimized Muldis Data Language code will likely use `SysScaValExprNodeSet` where it
can do so instead of `ScaSelExprNodeSet`.

A `ScaSelExprNodeSet` has these 6 attributes:

* `name` - `Name`

This is the declared name of the expression node.

* `scm_comment` - `Comment`

This is an optional programmer comment about either the expression node or
the expression node (sub-)tree it is the root of.

* `scm_vis_ord` - `NNInt`

This is the visible order, if applicable, of this non-nested expression
node relative to all of its sibling such expression nodes, or statements.

* `type_name` - `RPTypeNC`

This is the name of the type that the scalar value belongs to.

* `possrep_name` - `Name`

This is the name of the possrep, of the type named by `type_name`, in
terms of whose attributes the scalar value is being selected.

* `possrep_attrs` - `NameExprMap`

These represent the attributes (names and values) of the `possrep_name`
possrep of the scalar value being selected.

A `ScaSelExprNodeSet` has a unary primary key on the `name`
attribute.  Its default value is empty.

## sys.std.Core.Type.Cat.TupSelExprNodeSet

A `TupSelExprNodeSet` is a `DHRelation` that specifies a set of value
expression nodes where each node represents a tuple value selection.

A `TupSelExprNodeSet` has these 4 attributes:

* `name` - `Name`

This is the declared name of the expression node.

* `scm_comment` - `Comment`

This is an optional programmer comment about either the expression node or
the expression node (sub-)tree it is the root of.

* `scm_vis_ord` - `NNInt`

This is the visible order, if applicable, of this non-nested expression
node relative to all of its sibling such expression nodes, or statements.

* `attrs` - `NameExprMap`

These represent the attributes (names and values) of the tuple
value being selected.

A `TupSelExprNodeSet` has a unary primary key on the `name`
attribute.  Its default value is empty.

## sys.std.Core.Type.Cat.RelSelExprNodeSet

A `RelSelExprNodeSet` is a `DHRelation` that specifies a set of value
expression nodes where each node represents a relation value selection.

A `RelSelExprNodeSet` has these 5 attributes:

* `name` - `Name`

This is the declared name of the expression node.

* `scm_comment` - `Comment`

This is an optional programmer comment about either the expression node or
the expression node (sub-)tree it is the root of.

* `scm_vis_ord` - `NNInt`

This is the visible order, if applicable, of this non-nested expression
node relative to all of its sibling such expression nodes, or statements.

* `head` - `set_of.Name`

These are the names of all of this relation value's attributes.

* `body` - `set_of.NameExprMap`

These represent the tuples of the relation value being
selected.  When this value expression is evaluated, if any child expression
nodes are such that any duplicate tuples might be input to this
`RelSelExprNodeSet` selector, the duplicates are silently eliminated and
do not constitute a failure condition.

A `RelSelExprNodeSet` has a unary primary key on the `name`
attribute.  Its default value is empty.

## sys.std.Core.Type.Cat.SetSelExprNodeSet

A `SetSelExprNodeSet` is a `DHRelation` that specifies a set of value
expression nodes where each node represents a set value selection.

A `SetSelExprNodeSet` has these 4 attributes:

* `name` - `Name`

This is the declared name of the expression node.

* `scm_comment` - `Comment`

This is an optional programmer comment about either the expression node or
the expression node (sub-)tree it is the root of.

* `scm_vis_ord` - `NNInt`

This is the visible order, if applicable, of this non-nested expression
node relative to all of its sibling such expression nodes, or statements.

* `elems` - `set_of.Name`

These represent the elements of the set value being selected.
When this value expression is evaluated, if any child expression nodes are
such that any duplicate tuples might be input to this `SetSelExprNodeSet`
selector, the duplicates are silently eliminated and do not constitute a
failure condition.

A `SetSelExprNodeSet` has a unary primary key on the `name`
attribute.  Its default value is empty.

## sys.std.Core.Type.Cat.ArySelExprNodeSet

An `ArySelExprNodeSet` is a `DHRelation` that specifies a set of value
expression nodes where each node represents an array value selection.

An `ArySelExprNodeSet` has these 4 attributes:

* `name` - `Name`

This is the declared name of the expression node.

* `scm_comment` - `Comment`

This is an optional programmer comment about either the expression node or
the expression node (sub-)tree it is the root of.

* `scm_vis_ord` - `NNInt`

This is the visible order, if applicable, of this non-nested expression
node relative to all of its sibling such expression nodes, or statements.

* `elems` - `array_of.Name`

These represent the elements of the array value being selected.

An `ArySelExprNodeSet` has a unary primary key on the `name`
attribute.  Its default value is empty.

## sys.std.Core.Type.Cat.BagSelExprNodeSet

A `BagSelExprNodeSet` is a `DHRelation` that specifies a set of value
expression nodes where each node represents a bag value selection.

A `BagSelExprNodeSet` has these 4 attributes:

* `name` - `Name`

This is the declared name of the expression node.

* `scm_comment` - `Comment`

This is an optional programmer comment about either the expression node or
the expression node (sub-)tree it is the root of.

* `scm_vis_ord` - `NNInt`

This is the visible order, if applicable, of this non-nested expression
node relative to all of its sibling such expression nodes, or statements.

* `elems` - `bag_of.Name`

These represent the elements of the bag value being selected.
When this value expression is evaluated, if any child expression nodes are
such that any tuple pairs with duplicate `value` attribute values might be
input to this `BagSelExprNodeSet` selector, the tuple pairs are silently
merged as per the semantics of bag union; the replacement tuple for such a
pair has a `count` attribute that is the sum of that attribute of each of
the originals in said pair; any duplicate `value` do not constitute a
failure condition.

Note that, because of how `BagSelExprNodeSet` is defined, the `count`
attribute value of each `elems` tuple is a compile time constant, since an
integer is stored in the system catalog rather than the name of an
expression node like with `value`; if you actually want the bag value
being selected at runtime to have runtime-determined `count` values, then
you must use a `RelSelExprNodeSet` rather than a `BagSelExprNodeSet`.

A `BagSelExprNodeSet` has a unary primary key on the `name`
attribute.  Its default value is empty.

## sys.std.Core.Type.Cat.SPIvlSelExprNodeSet

An `SPIvlSelExprNodeSet` is a `DHRelation` that specifies a set of value
expression nodes where each node represents a single-piece interval value
selection.

An `SPIvlSelExprNodeSet` has these 4 attributes:

* `name` - `Name`

This is the declared name of the expression node.

* `scm_comment` - `Comment`

This is an optional programmer comment about either the expression node or
the expression node (sub-)tree it is the root of.

* `scm_vis_ord` - `NNInt`

This is the visible order, if applicable, of this non-nested expression
node relative to all of its sibling such expression nodes, or statements.

* `interval` - `sp_interval_of.Name`

These represent the attributes of the single-piece interval value being
selected.

Note that, because of how `SPIvlSelExprNodeSet` is defined, the
`excludes_[min|max]` attribute values of the single-piece interval are
compile time constants, since a boolean is stored in the system catalog for
each rather than the name of an expression node like with the `min` and
`max` attributes; if you actually want the single-piece interval value
being selected at runtime to have runtime-determined `excludes_[min|max]`
attribute values, then you must use a `TupSelExprNodeSet` rather than an
`SPIvlSelExprNodeSet`.

An `SPIvlSelExprNodeSet` has a unary primary key on the `name` attribute.
Its default value is empty.

## sys.std.Core.Type.Cat.MPIvlSelExprNodeSet

An `MPIvlSelExprNodeSet` is a `DHRelation` that specifies a set of value
expression nodes where each node represents a multi-piece interval value
selection.

An `MPIvlSelExprNodeSet` has these 4 attributes:

* `name` - `Name`

This is the declared name of the expression node.

* `scm_comment` - `Comment`

This is an optional programmer comment about either the expression node or
the expression node (sub-)tree it is the root of.

* `scm_vis_ord` - `NNInt`

This is the visible order, if applicable, of this non-nested expression
node relative to all of its sibling such expression nodes, or statements.

* `elems` - `mp_interval_of.Name`

These represent the elements, each of which is a single-piece interval, of
the multi-piece interval value being selected.  When this value expression
is evaluated, if any child expression nodes are such that any duplicate
tuples might be input to this `MPIvlSelExprNodeSet` selector, the
duplicates are silently eliminated and do not constitute a failure
condition.

Note that, because of how `MPIvlSelExprNodeSet` is defined, the
`excludes_[min|max]` attribute values of the multi-piece interval are
compile time constants, since a boolean is stored in the system catalog for
each rather than the name of an expression node like with the `min` and
`max` attributes; if you actually want the multi-piece interval value
being selected at runtime to have runtime-determined `excludes_[min|max]`
attribute values, then you must use a `RelSelExprNodeSet` rather than an
`MPIvlSelExprNodeSet`.

An `MPIvlSelExprNodeSet` has a unary primary key on the `name` attribute.
Its default value is empty.

## sys.std.Core.Type.Cat.ListSelExprNodeSet

An `ListSelExprNodeSet` is a `DHRelation` that specifies a set of value
expression nodes where each node represents a low-level list value
selection.

An `ListSelExprNodeSet` has these 4 attributes:

* `name` - `Name`

This is the declared name of the expression node.

* `scm_comment` - `Comment`

This is an optional programmer comment about either the expression node or
the expression node (sub-)tree it is the root of.

* `scm_vis_ord` - `NNInt`

This is the visible order, if applicable, of this non-nested expression
node relative to all of its sibling such expression nodes, or statements.

* `elems` - `array_of.Name`

These represent the elements of the low-level list value being selected.

An `ListSelExprNodeSet` has a unary primary key on the `name`
attribute.  Its default value is empty.

## sys.std.Core.Type.Cat.AccExprNodeSet

An `AccExprNodeSet` is a `DHRelation` that specifies a set of value
expression nodes where each node is an accessor or alias for an attribute
of another, tuple-valued expression node, or is simply an alias for another
expression node, defined in terms of a `NameChain`.

An `AccExprNodeSet` has these 4 attributes:

* `name` - `Name`

This is the declared name of the expression node.

* `scm_comment` - `Comment`

This is an optional programmer comment about the expression (leaf) node.

* `scm_vis_ord` - `NNInt`

This is the visible order, if applicable, of this non-nested expression
node relative to all of its sibling such expression nodes, or statements.

* `target` - `NameChain`

This is the fully-qualified invocation name of the expression node, or
attribute thereof if it is tuple-valued, being accessed or aliased.

An `AccExprNodeSet` has a unary primary key on the `name`
attribute.  Its default value is empty.

## sys.std.Core.Type.Cat.FuncInvoExprNodeSet

A `FuncInvoExprNodeSet` is a `DHRelation` that specifies a set of value
expression nodes where each node represents the result of invoking a named
function with specific arguments.

A `FuncInvoExprNodeSet` has these 5 attributes:

* `name` - `Name`

This is the declared name of the expression node.

* `scm_comment` - `Comment`

This is an optional programmer comment about either the expression node or
the expression node (sub-)tree it is the root of.

* `scm_vis_ord` - `NNInt`

This is the visible order, if applicable, of this non-nested expression
node relative to all of its sibling such expression nodes, or statements.

* `function` - `MaterialNC`

This is the name of the function being invoked.

* `args` - `NameExprMap`

These are the arguments for the function invocation.  Each element
defines one argument value, with the element `name` matching the invoked
function's parameter name, and the element `expr` naming another
local expression node (or parameter) which defines the value.

A `FuncInvoExprNodeSet` has a unary primary key on the `name`
attribute.  Its default value is empty.

## sys.std.Core.Type.Cat.IfElseExprNodeSet

An `IfElseExprNodeSet` is a `DHRelation` that specifies a set of value
expression nodes where each node represents a ternary if-then-else control
flow expression.  An if-then-else node has 3 child expression nodes (which
may just be named references to expressions or parameters or variables)
here designated `if`, `then`, and `else`; the `if` node is the
condition to evaluate and must result in a `Bool`; iff the result of that
condition is `Bool:True` then the `then` node is evaluated and its result
is the result of the whole if-then-else expression; otherwise, the `else`
node is evaluated and its result is the whole if-then-else's result.

The reason that the `IfElseExprNodeSet` expression node kind exists,
rather than this functionality being provided by an ordinary function
invocation, is because the semantics of an if-else expression require its
sub-expressions to be evaluated in a specific sequence and that later
elements in the sequence are evaluated only conditionally based on the
results of earlier elements in the sequence, whereas with ordinary
functions the operands are all independent of each other, can be done in
any order, and can all be evaluated prior to the function.  The main
scenario that requires the special semantics is when an earlier conditional
part of the sequence is testing whether it is even logically possible to
evaluate a later part of the sequence; for example, the first condition may
test if a value is a member of a certain data type, and a later part of the
sequence may want to use some operator on the value that is only defined
for the certain data type (invoking it on something else would result in a
failure/exception); so only known-safe/appropriate expressions then get
evaluated.

An `IfElseExprNodeSet` has these 6 attributes:

* `name` - `Name`

This is the declared name of the expression node.

* `scm_comment` - `Comment`

This is an optional programmer comment about either the expression node or
the expression node (sub-)tree it is the root of.

* `scm_vis_ord` - `NNInt`

This is the visible order, if applicable, of this non-nested expression
node relative to all of its sibling such expression nodes, or statements.

* `if` - `Name`

This is the name of the local `Bool`-resulting conditional expression node
that is unconditionally evaluated first.

* `then` - `Name`

This is the name of the local expression node whose evaluation provides the
result of the whole if-then-else expression iff `if` is `Bool:True`.

* `else` - `Name`

This is the name of the local expression node whose evaluation provides the
result of the whole if-then-else expression iff `if` is `Bool:False`.

An `IfElseExprNodeSet` has a unary primary key on the `name`
attribute.  Its default value is empty.

## sys.std.Core.Type.Cat.GivenWhenDefExprNodeSet

A `GivenWhenDefExprNodeSet` is a `DHRelation` that specifies a set of
value expression nodes where each node represents an N-way
given-when-then-default switch control flow expression that dispatches
based on matching a single value with several options.

A given-when-then-default is essentially a more specialized version of a
chain of if-then-else expressions where every condition expression is a
simple value equality test and one of the operands is the same for all the
conditions in the set; also, with a given-when-then-default it doesn't
matter what order the conditionals are tested to find a true resulting one.

A `GivenWhenDefExprNodeSet` has these 6 attributes:

* `name` - `Name`

This is the declared name of the expression node.

* `scm_comment` - `Comment`

This is an optional programmer comment about either the expression node or
the expression node (sub-)tree it is the root of.

* `scm_vis_ord` - `NNInt`

This is the visible order, if applicable, of this non-nested expression
node relative to all of its sibling such expression nodes, or statements.

* `given` - `Name`

This is the single operand value that is common to all the conditions; it
is the control value for the expression.

* `when_then` - `WhenThenExprMap`

This is a set of distinct condition operand values, each of which has an
associated result expression.  If a condition operand matches the value of
`given`, its associated result expression will evaluate and be the result
of the larger if-else sequence; no result expressions will be evaluated
except the one with the matching conditional operand.

* `default` - `Name`

Iff none of the condition operand values in `when_then` matches the value
of `given` (or as a trivial case, if `when_then` has no tuples), then the
result expression represented by the local expression node (or parameter)
named by `default` will be evaluated, and be the result of the larger
given-when-default.

A `GivenWhenDefExprNodeSet` has a unary primary key on the `name`
attribute.  Its default value is empty.

## sys.std.Core.Type.Cat.WhenThenExprMap

A `WhenThenExprMap` is a `DHRelation`.  It defines a set of dispatch
options for a given-when-default expression.  A `WhenThenExprMap` has 2
attributes, `when` and `then`, each of which is a `Name`; `when` has
the name of a local expression node (or parameter), and `then` has
likewise.  The `when` node is the not-common / distinct operand for each
condition.  If a `when` value is matched, then the `then` node is
evaluated and its result is the result of the whole g-w-d expression;
otherwise, `then` is not evaluated.  Its default value has zero tuples.

## sys.std.Core.Type.Cat.APMaterialNCSelExprNodeSet

An `APMaterialNCSelExprNodeSet` is a `DHRelation` that specifies a set of
expression nodes where each node represents a value of the
`sys.std.Core.Type.Cat.AbsPathMaterialNC` type, which is selected in terms
of a value of the `sys.std.Core.Type.Cat.RelPathMaterialNC` type.

The reason that the `APMaterialNCSelExprNodeSet` expression node kind
exists, rather than the functionality of mapping relative paths to absolute
paths being provided by an ordinary unary function invocation, is because
the semantics of the operation depend on the location of the referencing
code, not just on the explicit parameters of the operation.  Moreover,
conceptually this mapping operation can be performed at compile time (of
the system catalog of a depot mount into native machine code) so at normal
runtime it is as if the absolute-path value was what was originally a value
literal in the source code.

An `APMaterialNCSelExprNodeSet` has these 4 attributes:

* `name` - `Name`

This is the declared name of the expression node.

* `scm_comment` - `Comment`

This is an optional programmer comment about the expression (leaf) node.

* `scm_vis_ord` - `NNInt`

This is the visible order, if applicable, of this non-nested expression
node relative to all of its sibling such expression nodes, or statements.

* `referencing` - `RelPathMaterialNC`

This is the name, from the point of view of the routine embedding this
expression node, of the routine or type that the new `AbsPathMaterialNC`
value is supposed to facilitate portable invoking of.

An `APMaterialNCSelExprNodeSet` has a unary (unique) key on the `name`
attribute, plus another such key on the `referencing` attribute.  Its
default value is empty.

## sys.std.Core.Type.Cat.Procedure

A `Procedure` is a `DHTuple`.  It defines a new procedure, which has 2
main parts, called *heading* and *body*:  The *heading* defines the
procedure's entire public interface, which is all the details of how to use
it, except for its name, and no more detail than
necessary about how it is implemented.  The *body* defines the procedure's
entire implementation (or the main body of a procedure), besides its
name/etc and what the *heading* defines.  The procedure's name is
provided by the larger context that embeds the `Procedure`,
which is either a `Package` or `System`.  Every `Procedure`
must have a specified *heading*, but having a specified *body* is
optional iff the `Procedure` is embedded in a `System`, because often the
implementations of system-defined routines are not defined in terms of
other Muldis Data Language routines, but that the *body* must not be specified if the
`Procedure` is virtual.

A `Procedure` has these 13 attributes, of which the 9 `upd_params`,
`ro_params`, `opt_params`, `upd_global_params`, `ro_global_params`,
`dispatch_params`, `implements`, `is_system_service`, `is_transaction`
define the *heading* and the 3 `vars`, `exprs`, `stmt` define the
*body*:

* `scm_comment` - `Comment`

This is an optional programmer comment about the procedure as a whole.

* `upd_params` - `NameTypeMap`

This is the declared subject-to-update parameter list of the procedure,
which has 0..N named and typed such parameters.

* `ro_params` - `NameTypeMap`

This is the declared read-only parameter list of the procedure, which has
0..N named and typed such parameters.

* `opt_params` - `set_of.Name`

This indicates the subset of the procedure's subject-to-update or read-only
parameters that are optional, that is, do not need to be supplied explicit
arguments when the function is invoked; any procedure parameters not named
here must be supplied explicit arguments.  Any parameter marked as optional
which is not given an explicit argument will implicitly default to the
default value of its declared type; any subject-to-update parameter marked
as optional which is not given a explicit argument will implicitly bind to
a new anonymous variable (with the aforementioned default value) which is
discarded after the procedure finishes executing.  Each element of
`opt_params` must match a parameter name in either `upd_params` or
`ro_params`.

* `upd_global_params` - `ProcGlobalVarAliasMap`

This declares 0..N lexical aliases for global variables which will
serve as implicit subject-to-update parameters of the procedure.

* `ro_global_params` - `ProcGlobalVarAliasMap`

This declares 0..N lexical aliases for global variables which will
serve as implicit read-only parameters of the procedure.

* `dispatch_params` - `set_of.Name`

Iff `dispatch_params` is nonempty then this procedure is a virtual
procedure; otherwise, empty means not virtual.  A virtual procedure must
have no *body* specified.  This attribute indicates the subset of the
procedure's parameters whose invocation arguments' types are consulted to
determine which other procedure, that explicitly implements this virtual
one, is automatically dispatched to.  Each element of `dispatch_params`
must match a parameter name in `upd_params` or `ro_params`.  Any given
parameter can not be both a dispatch parameter and an optional parameter.

* `implements` - `set_of.RPProcedureNC`

Iff `implements` is nonempty then this procedure is explicitly declaring
that it implements the other (typically just one), virtual procedures named
by its elements; otherwise, empty means not implementing any virtuals.  An
implementing procedure must have the same parameter list as its virtuals,
save that the implementer's parameters' declared types must be
subtypes of the corresponding ones of the virtuals.

* `is_system_service` - `Bool`

Iff this is `Bool:True` then the procedure is explicitly declared to be a
`system-service`, meaning it will be subject to tighter constraints on its
allowed actions (it may not invoke any globals) and its execution
will automatically be entirely contained within a single transaction of the
highest possible isolation level, "serializable", same as an recipe is;
iff this is `Bool:False` then the procedure is *not* explicitly declared
to be a `system-service`, and the other restrictions or automatic wrapper
transaction won't be present for supporting a `system-service`.

* `is_transaction` - `Bool`

If this is `Bool:True` then the procedure constitutes an explicit (main or
child) transaction of its own; the transaction will commit if the procedure
completes its execution normally and it will roll back if the procedure
completes abnormally by throwing an exception; if this is `Bool:False`
then the procedure does *not* constitute its own transaction.  Note that a
procedure's `is_transaction` must be `Bool:True` if its
`is_system_service` is `Bool:True`; otherwise,
`is_transaction` may be either `Bool:True` or `Bool:False`.

* `vars` - `NameTypeMap`

This defines the 0..N (non-parameter) lexical variables of the
procedure; they initialize to the default values of their declared types.

* `exprs` - `ExprNodeSet`

This defines the expression trees that are composed into the statements
comprising the procedure body.  They may either be defined inline of the
statements or offside; in the latter case they are given explicit names by
the programmers and common expression trees may be reused in multiple
statements, wherein they are semantically like macros.

* `stmt` - `StmtNodeSet`

This defines the statement tree that comprises the entire procedure body.

Iff a `Procedure` has no specified *body*, then `stmt` and
`exprs` must have zero
member nodes and `vars` must have zero member tuples; otherwise, `stmt`
must have at least 1 member node, which is a compound statement node
(having just that 1 node means the procedure is an unconditional no-op).

A `Procedure` with a specified *body*
specifies a simple statement tree of named statement
nodes, each of which is a tuple of one of its `stmt.\w+_stmts` attributes.
It must have at least 1 member node, and
all member nodes must define a simple statement node tree, such
that every member except one (which is the root node) has one of its peers
as a parent node, and no direct cycles between members are permitted (only
indirect cycles based on procedure invocations are allowed); the
name of the root node must be the empty string.  Note that the
composed-into procedure's parameters (regular and global) and lexical
variables are also implicitly expression tree nodes, and are referenced by
name into the statements the same way as any other named expression node
is.  The root node must also be a compound statement node, meaning a tuple
of either the procedure's `stmt.compound_stmts` attribute or its
`stmt.multi_upd_stmts` attribute; while making this requirement isn't
strictly necessary in general, that requirement allows the corresponding
concrete Muldis Data Language grammars to be simpler, and a compound statement node
would end up being the root anyway in 99% of likely real procedures.  The
statement tree should reference all of the parameters and lexical variables
that the procedure has, but this isn't a strict requirement.

`Procedure` has a distributed primary key over the `name` attributes of
`upd_params` and `ro_params` and `upd_global_params` and
`ro_global_params` and `vars` and the `name` attributes of
all the attributes of `stmt`.  Its default value has zero parameters and
has no specified *body*.

## sys.std.Core.Type.Cat.SystemService

A `SystemService` defines a `system-service`, which is a kind of
procedure.  `SystemService` is a proper subtype of `Procedure` where for
every member value its `is_system_service` attribute is `Bool:True`.

## sys.std.Core.Type.Cat.Transaction

A `Transaction` defines a `transaction`, which is a kind of procedure.
`Transaction` is a proper subtype of `Procedure` where for every member
value its `is_transaction` attribute is `Bool:True` and its
`is_system_service` attribute is `Bool:False`.

## sys.std.Core.Type.Cat.Recipe

A `Recipe` defines a `recipe`, which is a kind of `transaction`.
`Recipe` is a proper subtype of `Transaction` where for every member
value its `vars` attribute is empty, and at least one of its `upd_params`
and `upd_global_params` attributes is nonempty, and for its `stmt`
attribute, the root node is a `multi_upd_stmt` node.  Its default value
has 1 subject-to-update, non-optional parameter whose name is `topic` and
whose declared type is `Bool`; it has zero read-only parameters and zero
lexical-alias variables; it has no specified *body*.

## sys.std.Core.Type.Cat.Updater

An `Updater` defines an `updater`, which is a kind of recipe.
`Updater` is a proper subtype of `Recipe` where for every member value
its `upd_global_params` and `ro_global_params` attributes are empty and
its `upd_params` attribute is nonempty.

## sys.std.Core.Type.Cat.ProcGlobalVarAliasMap

A `ProcGlobalVarAliasMap` is a `DHRelation`.  It defines a set of lexical
variable names, with a declared global variable for each.  It is used to
define lexical variables of procedures that are aliases for global
variables, for reading or updating.  A `ProcGlobalVarAliasMap` has 4
attributes, `name` (a `Name`), `global` (a `DataNC`), `scm_comment` (a
`Comment`), and `scm_vis_ord` (a `NNInt`); the `name` is the name of
the lexical alias, and comprises a unary key; the `global` is the
invocation name of the global variable.  Its default value has zero tuples.

## sys.std.Core.Type.Cat.StmtNodeSet

A `StmtNodeSet` is a `Database` that specifies a set of named
statement nodes.  It is typically composed into a procedure.  Each
tuple of a `StmtNodeSet` attribute is a named statement node, from
which procedural Muldis Data Language code is composed.

Note that, regarding Muldis Data Language's feature of a statement node having an
explicit `name` that can be referenced by "leave" and "iterate" control
flow statements to leave or re-iterate the corresponding block, both SQL
and Perl have native counterpart features in the form of block labels.

A `StmtNodeSet` has these 9 attributes:

* `leave_stmts` - `LeaveStmtNodeSet`

These are statement nodes that represent abnormal block exit statements.

* `compound_stmts` - `CompoundStmtNodeSet`

These are statement nodes that each represent a compound statement having a
sequence of 0..N procedure statements that conceptually are executed in
order and at distinct points in time.

* `multi_upd_stmts` - `MultiUpdStmtNodeSet`

These are statement nodes that each represent a multi-update statement,
which is a compound statement having a set of 0..N procedure statements
that conceptually are executed all as one and collectively at a single
point in time, as if the collection were a single statement that did all
the work of the component statements itself.

* `proc_invo_stmts` - `ProcInvoStmtNodeSet`

These are statement nodes that represent procedure invocations.

* `try_catch_stmts` - `TryCatchStmtNodeSet`

These are statement nodes that represent try-catch control flow statements.

* `if_else_stmts` - `IfElseStmtNodeSet`

These are statement nodes that represent if-else control flow statements.

* `given_when_def_stmts` - `GivenWhenDefStmtNodeSet`

These are statement nodes that represent given-when-default control flow
statements.

* `iterate_stmts` - `IterateStmtNodeSet`

These are statement nodes that represent abnormal block restart statements.

* `loop_stmts` - `LoopStmtNodeSet`

These are statement nodes that represent generic looping block statements.

There is a distributed primary key over the `name` attributes of all of a
`StmtNodeSet`'s attributes.  Its default value is empty.

## sys.std.Core.Type.Cat.LeaveStmtNodeSet

A `LeaveStmtNodeSet` is a `DHRelation` that specifies a set of
statement leaf nodes where each node represents an instruction to
abnormally exit the block defined by a parent statement node (a normal exit
is to simply execute to the end of the block).  If the parent node in
question is the root statement node for the statement-containing procedure,
that is, if the parent node has the empty string as its name,
then the latter will be exited; this is how a "return" statement is
represented, but "return" is still easy to recognize because the root node
always has the empty string as its name.  If the parent node in question is
an iterating or looping statement, then any remaining iterations it might
have had are skipped, especially useful if it was an infinite loop.

A `LeaveStmtNodeSet` has these 3 attributes:

* `name` - `Name`

This is the declared name of the statement node.

* `scm_comment` - `Comment`

This is an optional programmer comment about the statement leaf node.

* `leave` - `Name`

This is the name of the parent statement node we wish to abnormally exit;
note that this reference does not count as making the other node a child of
the current one, so this reference does not contribute to a cycle.

A `LeaveStmtNodeSet` has a unary primary key on the `name` attribute,
plus a unary (unique) key on the `leave` attribute.  Its default value is
empty.

## sys.std.Core.Type.Cat.CompoundStmtNodeSet

A `CompoundStmtNodeSet` is a `DHRelation` that specifies a set of
statement nodes where each node is a compound statement composed of a
sequence of 0..N other statements that conceptually are executed in
order and at distinct points in time.

A `CompoundStmtNodeSet` has these 3 attributes:

* `name` - `Name`

This is the declared name of the statement node.

* `scm_comment` - `Comment`

This is an optional programmer comment about either the statement node or
the statement node (sub-)tree it is the root of.

* `stmts` - `array_of.Name`

This is a sequence of names of 0..N other local statement nodes; the
current compound statement consists of having those other statements
execute in this given sequence.

A `CompoundStmtNodeSet` has a unary primary key on the `name`
attribute.  Its default value is empty.

## sys.std.Core.Type.Cat.MultiUpdStmtNodeSet

A `MultiUpdStmtNodeSet` is a `DHRelation` that specifies a set of
statement nodes where each node is a multi-update statement, which is a
compound statement composed of a set of 0..N procedure statements that
conceptually are executed all as one and collectively at a single point in
time, as if the collection were a single statement that did all the work of
the component statements itself.  All arbitrarily complex Muldis Data Language value
assignments, including relational assignments, are composed of just
multi-update statements, either directly, or indirectly by way of recipe
invocations, as each recipe body is itself composed entirely of 1
multi-update statement (plus supporting value expressions).

A `MultiUpdStmtNodeSet` has these 3 attributes:

* `name` - `Name`

This is the declared name of the statement node.

* `scm_comment` - `Comment`

This is an optional programmer comment about either the statement node or
the statement node (sub-)tree it is the root of.

* `stmts` - `set_of.Name`

This is a set of names of 0..N other local statement nodes; the current
multi-update statement consists of having those other statements execute
all as one.  Each of the other statements composed into a multi-update
statement may only be either a `proc_invo_stmt` node that invokes a
recipe or an assignment; it may not be any non-deterministic statement.

A `MultiUpdStmtNodeSet` has a unary primary key on the `name` attribute.
Its default value is empty.

## sys.std.Core.Type.Cat.ProcInvoStmtNodeSet

A `ProcInvoStmtNodeSet` is a `DHRelation` that specifies a set of
statement nodes where each node is an invocation of a named procedure
with specific arguments.

A `ProcInvoStmtNodeSet` has these 5 attributes:

* `name` - `Name`

This is the declared name of the statement node.

* `scm_comment` - `Comment`

This is an optional programmer comment about either the statement node or
the statement node (sub-)tree it is the root of.

* `procedure` - `MaterialNC`

This is the name of the procedure being invoked.

* `upd_args` - `NameExprMap`

These are the 0..N subject-to-update arguments to the procedure invocation,
as-per `ro_args`; but iff the routine being invoked is an updater, then
there must instead be 1..N subject-to-update arguments, because an updater
must take at least 1 subject-to-update argument.  But since each expression
tree in `upd_args` is binding to a subject-to-update regular/global
parameter or lexical variable, the expression tree actually is defining a
pseudo-variable / virtual-variable over 1..N parameters/variables; in the
most trivial (and common) case, the parameter/variable is referenced
directly.

* `ro_args` - `NameExprMap`

These are the 0..N read-only arguments for the procedure invocation.  Each
element defines one argument value, with the element `name` matching the
invoked procedure's parameter name, and the element `expr` naming another
local expression node (or regular/global parameter or variable) which
defines the value.

A `ProcInvoStmtNodeSet` has a unary primary key on the `name`
attribute.  Its default value is empty.  There is a distributed primary
key over the `name` attributes of `upd_args` and `ro_args`.

## sys.std.Core.Type.Cat.TryCatchStmtNodeSet

A `TryCatchStmtNodeSet` is a `DHRelation` that specifies a set of
statement nodes where each node represents a try-catch control flow
statement.  A try-catch-stmt node is conceptually a wrapper over a pair
of `ProcInvoStmtNodeSet` named *try* and *catch*, where *try* is
unconditionally invoked first and then iff *try* throws an exception then
it will be caught and *catch* will be invoked immediately after to handle
it; if *catch* also throws an exception then it will not be caught.  Each
of the invoked procedures can be either user-defined or system-defined.

A `TryCatchStmtNodeSet` has these 4 attributes:

* `name` - `Name`

This is the declared name of the statement node.

* `scm_comment` - `Comment`

This is an optional programmer comment about either the statement node or
the statement node (sub-)tree it is the root of.

* `try` - `Name`

This is the name of a local routine invocation statement node that will
be invoked first unconditionally; any thrown exception will be caught.

* `catch` - `maybe_of.Name`

Iff `catch` is a `Just`, it is the name of a local routine invocation
statement node that will be invoked second iff the `try` routine throws
an exception, and it will receive that exception for handling via its
single mandatory parameter `topic` (which is `Exception`-typed); iff
`catch` is `Nothing`, then there is no second routine invocation,
meaning any exception thrown by `try` is ignored; any exception thrown by
`catch` will not be caught.

A `TryCatchStmtNodeSet` has a unary primary key on the `name`
attribute.  Its default value is empty.

## sys.std.Core.Type.Cat.IfElseStmtNodeSet

An `IfElseStmtNodeSet` is a `DHRelation` that specifies a set of
statement nodes where each node represents a ternary if-then-else control
flow statement.  An `IfElseStmtNodeSet` is essentially the procedural
version of the functional `IfElseExprNodeSet`.  An if-then-else node has 1
child expression node (which may just be named references to expressions or
parameters or variables) here designated `if`, and 2 child statement nodes
here designated `then` and `else`; the `if` node is the condition to
evaluate and must result in a `Bool`; iff the result of that condition is
`Bool:True` then the `else` node is invoked; otherwise, the `then` node
is invoked.

An `IfElseStmtNodeSet` has these 5 attributes:

* `name` - `Name`

This is the declared name of the statement node.

* `scm_comment` - `Comment`

This is an optional programmer comment about either the statement node or
the statement node (sub-)tree it is the root of.

* `if` - `Name`

This is the name of the local `Bool`-resulting conditional expression node
that is unconditionally evaluated first.

* `then` - `Name`

This is the name of the local statement node that is invoked iff `if` is
`Bool:True`.

* `else` - `maybe_of.Name`

Iff `if` is `Bool:False`, then the statement
represented by the local statement node named by `else` will be invoked
iff `else` is a `Just`; if under the first circumstance `else` is
`Nothing`, then the whole if-else will have been a no-op.

An `IfElseStmtNodeSet` has a unary primary key on the `name`
attribute.  Its default value is empty.

## sys.std.Core.Type.Cat.GivenWhenDefStmtNodeSet

A `GivenWhenDefStmtNodeSet` is a `DHRelation` that specifies a set of
statement nodes where each node represents an N-way given-when-then-default
switch control flow statement that dispatches based on matching a single
value with several options.  A `GivenWhenDefStmtNodeSet` is essentially
the procedural version of the functional `GivenWhenDefExprNodeSet`.

A `GivenWhenDefStmtNodeSet` has these 5 attributes:

* `name` - `Name`

This is the declared name of the statement node.

* `scm_comment` - `Comment`

This is an optional programmer comment about either the statement node or
the statement node (sub-)tree it is the root of.

* `given` - `Name`

This is name of the local expression node that supplies the single
operand value that is common to all the conditions; it is the control value
for the statement.

* `when_then` - `WhenThenExprStmtMap`

This is a set of distinct condition operand values, each of which has an
associated statement.  If a condition operand matches the value of
`given`, its associated statement will be invoked; no statements will be
invoked except the one with the matching conditional operand.

* `default` - `maybe_of.Name`

Iff none of the condition operand values in `when_then` matches the value
of `given` (or as a trivial case, if `when_then` has no tuples), then the
statement represented by the local statement node named by `default` will
be invoked iff `default` is a `Just`; if under the first circumstance
`default` is `Nothing`, then the whole given-when-default will have
been a no-op.

A `GivenWhenDefStmtNodeSet` has a unary primary key on the `name`
attribute.  Its default value is empty.

## sys.std.Core.Type.Cat.WhenThenExprStmtMap

A `WhenThenExprStmtMap` is a `DHRelation`.  It defines a set of dispatch
options for a given-when-default statement.  A `WhenThenExprStmtMap` has 2
attributes, `when` (a `Name`) and `then` (a `Name`); `when` has
the name of a local expression node (or parameter), and `then` has the
name of a statement node.  The `when` node is the not-common / distinct
operand for each condition.  If a `when` value is matched, then the
`then` statement node is invoked; otherwise, `then` is not invoked.  Its
default value has zero tuples.

## sys.std.Core.Type.Cat.IterateStmtNodeSet

An `IterateStmtNodeSet` is a `DHRelation` that specifies a set of
statement leaf nodes where each node represents an instruction to
abnormally end the current iteration of a looping block defined by a parent
statement node, and then start at the beginning of the next iteration of
that loop if there are any left ("normal" is to simply execute to the end
of the block before starting the next iteration).  The same semantics apply
for the beginning of the next loop as if the current block iteration had
executed to the end before repeating.  In fact, a looping block isn't even
required; an iterate node can also be used to "redo" any parent statement.

An `IterateStmtNodeSet` has these 3 attributes:

* `name` - `Name`

This is the declared name of the statement node.

* `scm_comment` - `Comment`

This is an optional programmer comment about the statement leaf node.

* `iterate` - `Name`

This is the name of the parent statement node we wish to abnormally exit
and restart; note that this reference does not count as making the other
node a child of the current one, so this reference does not contribute to a
cycle.

An `IterateStmtNodeSet` has a unary primary key on the `name`
attribute, plus a unary (unique) key on the `iterate` attribute.  Its
default value is empty.

## sys.std.Core.Type.Cat.LoopStmtNodeSet

A `LoopStmtNodeSet` is a `DHRelation` that specifies a set of statement
nodes where each node represents a generic looping statement block which
iterates until a child "leave" statement executes.

A `LoopStmtNodeSet` has these 3 attributes:

* `name` - `Name`

This is the declared name of the statement node.

* `scm_comment` - `Comment`

This is an optional programmer comment about either the statement node or
the statement node (sub-)tree it is the root of.

* `loop` - `Name`

This is the name of the local statement node that will get executed for
each iteration of the loop; typically it has a sub-tree of statement nodes.

A `LoopStmtNodeSet` has a unary primary key on the `name` attribute.
Its default value is empty.

# TYPES FOR DEFINING DATA TYPES

## sys.std.Core.Type.Cat.ScalarType

A `ScalarType` is a `DHTuple`.  It defines either a new
scalar root type with at least 1 possrep, or it defines a subtype
of some other scalar type which also adds at least one possrep to
the other type.  Either way, every possrep defines a candidate
representation that can handle every value of the [|sub]type it is defined
with, and the Muldis Data Language implementation may choose for itself which of these,
or some other alternative, is the actual/physical representation.  Whether
a declared type is scalar or dh-scalar depends only on the declared
types of the attributes its possreps compose, whether any are
non-deeply-homogeneous
or none are.  You can not declare a scalar root type at all except
by using a `ScalarType`, and you can not define a scalar type
with an incompletely defined attribute list at all.

A `ScalarType` has these 7 attributes:

* `scm_comment` - `Comment`

This is an optional programmer comment about the scalar
[|sub]type as a whole.

* `composed_mixins` - `ComposedMixinSet`

These are the names of the 0..N mixin types, if any, that the new scalar
type composes, and therefore the new type is a subtype of all of them.

* `base_type` - `maybe_of.RPTypeNC`

Iff the type being defined is a scalar root type, then
`base_type` is not applicable and is `Nothing`.  Iff the type being
defined is a subtype of some other scalar type, then `base_type`
is a `Just` whose sole element is the name of that other type.  Note
that any type named by `base_type` must itself be a scalar root
type or a subtype of one.

* `subtype_constraint` - `maybe_of.RPFunctionNC`

Iff the type being defined is a scalar root type, or it is a
non-proper subtype of some other type, then `subtype_constraint` is not
applicable and is `Nothing`.  Iff the type being defined is a proper
subtype of some other scalar type, then `subtype_constraint` is a
`Just` whose sole element matches the invocation name of a
`type-constraint` function that determines what base type values are part
of the subtype.  The function that this names must have a
single `topic` parameter whose declared type is that named by
`base_type`, and whose argument is the value to test; the function's
result type must be `Bool`.  This constraint function may only
reference possreps of the base type, and may not reference possreps of the
type being defined.  Note that, strictly speaking, `subtype_constraint`
may actually be less restrictive than the total constraint of the subtype
as a whole, because the total constraint is defined by *and*-ing the
constraints of the base types and the `subtype_constraint` and the
constraints of all the possreps of the subtype; therefore, mainly the
`subtype_constraint` needs to be just restricting enough so that the
inter-possrep mapping functions can handle the base type values that it
accepts, so it is possible to apply the new possreps' constraints.  Now if
`subtype_constraint` were otherwise so simple as to unconditinally result
in `Bool:True`, then simply making it `Nothing` has the same effect.

* `possreps` - `PossrepSet`

These are the 1..N possrep definitions that comprise this type such that
each one fully defines a set of attributes plus restrictions on their
collective values whereby it defines a representation of all values of this
type.  Note that if multiple scalar types are related to each
other such that more than one declares possreps for at least one common
value, then the `name` attribute of the `possreps` attributes of all of
those types' definitions have a distributed primary key over them.  Note
that, to keep things simple and deterministic under the possibility of
diamond subtype/supertype relationships (such that the generic
system-defined scalar possrep attribute accessors can work), Muldis Data Language
requires all of the possreps of all scalar types having a common scalar
root type to have mutually distinct names, regardless of whether any
subtypes have values in common; this can be enforced at
type-definition-in-catalog time since all types that can interact are in
the same package.

* `possrep_maps` - `PossrepMapSet`

When this type has more than one possrep applicable to all of its values,
these are the definitions of mapping functions for deriving the
representation of a value in one possrep directly from the representation
in another possrep, and also directly in the reverse.  Every one of this
type's possreps must be mapped bidirectionally to every other one of its
possreps, either directly or indirectly.  So for `P` total possreps, the
total number of bidirectional maps `M` is in `(P-1) ≤ M ≤ ((P-1)*P/2)`.
When a subtype is adding possreps to an other base type, all of the mapping
functions are defined with the subtype.

* `default` - `maybe_of.RPFunctionNC`

Iff it is a `Just`, then `default`
matches the invocation name of a `named-value` function that
results in the default scalar value of the [|sub]type; it has
zero parameters and its result type is the same as the scalar type
being defined.  Iff `default` is `Nothing` and
`base_type` is `Nothing`, then semantics are as if it were a defined name
that resulted in a value of the type being defined where all of the possrep
attr values were the default values of their declared types; but if the
type being defined has multiple possreps and going the by-attr-defaults
route with all of the possreps doesn't produce the same value of the type
being defined, then a `default` of `Nothing` is invalid and it must be a
`Just`.  Iff `default` is `Nothing` and `base_type` is a `Just`,
then the subtype will use the same default value as its base type; but if
the subtype's value set excludes said value, then a `default` of
`Nothing` is invalid and `default` must be a `Just`.
Overriding the above, `default` must be `Nothing` if the type being
defined is an alias for `Empty`.

The default value of `ScalarType` defines a scalar root type with
a single possrep whose name is the empty string and that has no attributes;
it is a singleton type, whose default value is its only value.

## sys.std.Core.Type.Cat.PossrepSet

A `PossrepSet` is a `DHRelation` that specifies a set of possreps that
a scalar [|sub]type might consist primarily of.

A `PossrepSet` has these 5 attributes:

* `name` - `Name`

This is the declared name of the possrep.

* `scm_comment` - `Comment`

This is an optional programmer comment about the possrep as a whole.

* `scm_vis_ord` - `NNInt`

This is the visible order of this possrep's declaration relative to all of
the other possreps of this scalar type declaration.

* `tuple_type` - `RPTypeNC`

This is the name of the tuple type from which the possrep being defined
composes its list of attributes (`attrs`) and the basic constraints on
those as a collection (`constraints`).  Said tuple type will most likely,
but isn't constrained to, not include any of the more complicated
specifications that typically are just used by tuples of relations or
tuples that are databases, such as virtual attribute maps or subset
constraints.  Note that, strictly speaking, any
constraint defined as part of (the tuple type defining) a possrep (where
there are multiple possreps) may actually be less restrictive than the
total constraint of the possreps' host
scalar [|sub]type as a whole, because the total constraint is
defined by *and*-ing the constraints of all the possreps of the
[|sub]type (and, in the case of defining a subtype, with the
`subtype_constraint` of the subtype and all base type constraints);
therefore, mainly any given possrep's constraints need to be just
restricting enough so that the inter-possrep mapping functions can handle
the arguments that it accepts, so it is possible to apply the other
possreps' constraints.
If this tuple type declares an alias for `Empty` (because it has an
attribute whose declared type is `Empty` or an alias, or because it has a
type constraint that unconditionally results in `Bool:False`), then the
scalar type being defined over it can have no member values, so is an alias
of `Empty`, since this scalar possrep of it can't represent any values.

* `is_base` - `Bool`

This is an optimization hint for Muldis Data Language implementations that are not
intelligent enough to decide on a best physical representation for the
[|sub]type.  At most one of the type's possreps is singled out by having a
`Bool:True` value here, so an implementation doesn't have to think and can
just use that as the basis for the physical representation.  To keep things
simple, only a possrep of a root type may be marked `Bool:True`, so it can
apply consistently to all subtypes as well.  More intelligent
implementations are free to ignore `is_base`, or just use it as a
tie-breaker if applicable.

A `PossrepSet` has a unary primary key on the `name` attribute.  Its
default value is empty.  The default value of a tuple of `PossrepSet`
has a `name` that is the empty string and its `tuple_type` is `D0`; and
so the default is suitable for declaring a singleton scalar type.

## sys.std.Core.Type.Cat.PossrepMapSet

A `PossrepMapSet` is a `DHRelation` such that each tuple in it
specifies a pair of mapping functions to bidirectionally derive a value of
a type between 2 of its possreps.

A `PossrepMapSet` has these 5 attributes:

* `scm_comment` - `Comment`

This is an optional programmer comment about this bidirectional mapping.

* `p1` - `Name`

This is the declared name of one possrep.

* `p2` - `Name`

This is the declared name of a second possrep.  The value of `p2` must be
distinct from that of `p1`, and moreover, the 2 values must be mutually
ordered so that the value of `p1` is before the value of `p2`; the latter
constraint defines a `PossrepMapSet`'s canonical form.

* `p2_from_p1` - `RPFunctionNC`

This matches the invocation name of a `possrep-map` function that
derives the representation of the possrep named by `p2` from that of the
possrep named by `p1`.  The function that this names must have a single
`topic` parameter whose declared type is the tuple type named by the
`tuple_type` attribute of the possrep named by `p1`; the function's
declared result type must be the tuple type named by the `tuple_type`
attribute of the possrep named by `p2`.  Note that every distinct
argument (domain) value of this function must have a distinct result
(range) value.

* `p1_from_p2` - `RPFunctionNC`

This matches the invocation name of an inverse `possrep-map` function
to that of `p2_from_p1`.  *Note that it would often be feasible for a
Muldis Data Language implementation to automatically infer a reverse function, but for
now we still require it to be explicitly stated; the explicitly stated
inverse function could be generated though.  This design is subject to
change.*

A `PossrepMapSet` has a binary primary key on the `p1` plus `p2`
attributes.  Its default value is empty.

## sys.std.Core.Type.Cat.TupleType

A `TupleType` is a `DHTuple`.  It defines either a new tuple heading
(set of attributes) with associated constraints for a tuple type having
that heading, or it defines a subtype of some other tuple type.  Note that
you also declare a database type using `TupleType`, by declaring a tuple
type whose attributes are all relation or database typed.  Note that you
can not use a `TupleType` to declare or subtype an incomplete type, as it
(or its supertype) must specify a complete set of attributes.  Note that a
`TupleType` also typically doubles for defining a relation type (but it
doesn't have to), because a `RelationType` requires one in terms of which
it is partly defined; each tuple of a value of the latter type is a value
of the former type.

A `TupleType` has these 7 attributes:

* `scm_comment` - `Comment`

This is an optional programmer comment about the tuple
[|sub]type as a whole.

* `composed_mixins` - `ComposedMixinSet`

These are the names of the 0..N mixin types, if any, that the new tuple
type composes, and therefore the new type is a subtype of all of them.

* `base_type` - `maybe_of.RPTypeNC`

Iff the type being defined is a tuple root type, then `base_type` is
not applicable and is `Nothing`.  Iff the type being defined is a
subtype of some other tuple type, then `base_type` is a `Just`
whose sole element is the name of that other type.

* `attrs` - `NameTypeMap`

Iff the type being defined is a tuple root type, then `attrs` defines
the 0..N attributes of the type.  Iff the type being defined is a subtype
of some other type, then the parent type's attribute list is used by
default, but `attrs` of the current type may be used to apply additional
constraints by overriding the declared types of a subset of the parent's
attributes with types that are subtypes of the originals; an override is
done using matching `name` attribute values of `attrs`.  It is indeed
valid for a tuple type to have zero attributes (which is then just a
dh-tuple type by definition); in this case, a tuple type consists of
exactly one value, and any relation type defined over it consists of
exactly two values.  The declared type of an attribute may be any type at
all; if that declared type is `Empty` or an alias thereof, then the tuple
type being defined can have no member values, so is an alias of `Empty`.

* `virtual_attr_maps` - `VirtualAttrMapSet`

This defines the proper subset of this type's attributes that are virtual,
and how they are defined in terms of the rest of this type's attributes.
Note that the special functional dependencies between attributes defined
herein mean that some kinds of tuple constraints would be redundant.

* `constraints` - `set_of.RelPathMaterialNC`

This, *tuple constraints*,
matches the invocation names of 0..N tuple-constraint-defining materials
that (when *and*-ed together) determine what combinations of tuple
attribute values denote values of the [|sub]type, besides the restrictions
imposed by the declared types of the attributes individually; they are
tuple type constraints that together validate a tuple as a whole.
Each tuple-constraint-defining material is one of these 4 material kinds:
`value-constraint`, `distrib-key-constraint`, `subset-constraint`,
`distrib-subset-constraint`.

A `value-constraint` is a generalized type constraint function that must
have a single `topic` parameter whose declared type is a tuple whose
attributes match those declared by `attrs` and whose argument denotes the
value to test; the function's result type must be `Bool`.  If the function
unconditionally results in `Bool:True`, then all possible combinations of
attribute-allowable values are collectively allowed.  The function is
invoked either once to test a tuple value of the type being defined, or
multiple times to individually test every tuple in a relation value of a
type defined over the first type.

A `distrib-key-constraint` is a
simple distributed (unique) key constraint that is
applicable to tuple/database values of the type being defined, that range
over specified relation-typed attributes of it.  At most one of a type's
`distrib-key-constraint` may be privileged as the *primary key*.
Note that a `distrib-key-constraint`
is logically an abstraction syntax (the canonical simplest
form) for a particular kind of `value-constraint` of the type being
defined, one that compares the cardinality of the union of the projection
of distributed key attributes of all key-participating relation-valued
attributes, with the sum of cardinalities of the source relation-valued
attributes; the attribute values comprise a distributed key if the
cardinalities are equal.

A `subset-constraint` is a simple (non-distributed) subset constraint
(foreign key) that is applicable to tuple/database values of the type
being defined, that range over and relate tuples of specified
relation-typed attributes of it; they are a kind of referential constraint.
Each tuple of a child attribute must have a corresponding tuple in a
specific single parent attribute, where they correspond on the attributes
of the parent attribute that comprise a (unique) key of the latter.  Note
that a `subset-constraint` is logically an abstraction syntax (the
canonical simplest form) for a particular kind of `value-constraint` of
the type being defined, one that tests if the relational difference, where
a projection of the parent relation is subtracted from a corresponding
projection of the child relation (with attribute renaming if necessary), is
an empty relation; if the difference is an empty relation, then the subset
constraint is satisfied; otherwise, any difference tuples are from child
tuples that violate the subset constraint.

A `distrib-subset-constraint` is a simple distributed subset constraint
(foreign key) that is applicable to tuple/database values of the type being
defined, that range over and relate tuples of specified relation-typed
attributes of it; they are a kind of referential constraint.  Each tuple of
a child attribute must have a corresponding tuple in one member of a
specific set of parent-alternative attributes (that have a distributed key
ranging over them), where they correspond on the attributes of the
parent-alternative attribute that comprise a distributed key on the latter.
Note that a `distrib-subset-constraint` is logically an abstraction syntax
(the canonical simplest form) for a particular kind of `value-constraint`
of the type being defined; it is as per `subset-constraint` except that
the parent relation is the result of unioning appropriately renamed
projections of the member relations of the distributed key.

* `default` - `maybe_of.RPFunctionNC`

Iff it is a `Just`, then `default`
matches the invocation name of a `named-value` function that
results in the default tuple value of the [|sub]type; it has zero
parameters and its result type is the same as the tuple type
being defined.  Iff `default` is `Nothing` and
`base_type` is `Nothing`, then semantics are as if `default` were
a defined name that resulted in a value of the type being defined where all
of the attr values were the default values of their declared types.  Iff
`default` is `Nothing` and `base_type` is a `Just`, then the
subtype will use the same default tuple value as its base type; but if the
subtype's value set excludes said value, then a `default` of
`Nothing` is invalid and `default` must be a `Just`.
Overriding the above, `default` must be `Nothing` if the type being
defined is an alias for `Empty`.

The default value of `TupleType` defines a singleton tuple type that has
zero attributes and whose default value is its only value.

## sys.std.Core.Type.Cat.RelationType

A `RelationType` is a `DHTuple`.  It defines either a new relation
heading (set of attributes) with associated constraints for a relation type
having that heading, or it defines a subtype of some other relation type.
Note that you can not use a `RelationType` to declare or subtype an
incomplete type, as it (or its supertype) must specify a complete set of
attributes.  Note that in order to define a `RelationType` there must
first exist a separate `TupleType` in terms of which it is partly defined
(the reverse isn't true); each tuple of a value of the former type is a
value of the latter type.  Note that a single tuple type definition may be
shared by multiple relation type definitions, or it may be system-defined.

A `RelationType` has these 6 attributes:

* `scm_comment` - `Comment`

This is an optional programmer comment about the relation
[|sub]type as a whole.

* `composed_mixins` - `ComposedMixinSet`

These are the names of the 0..N mixin types, if any, that the new relation
type composes, and therefore the new type is a subtype of all of them.

* `base_type` - `maybe_of.RPTypeNC`

Iff the type being defined is a relation root type, then `base_type` is
not applicable and is `Nothing`.  Iff the type being defined is a
subtype of some other relation type, then `base_type` is a `Just`
whose sole element is the name of that other type.

* `tuple_type` - `RPTypeNC`

This is the name of the tuple type from which the relation type being
defined composes its list of attributes and most of its other details.
If this tuple type declares an alias for `Empty` (because it has an
attribute whose declared type is `Empty` or an alias, or because it has a
type constraint that unconditionally results in `Bool:False`), then the
relation type being defined over it has exactly 1 member value, which is
the only relation value having the same heading plus an empty body, unless
`base_type` defines a type that is `Empty` or an alias.
Note that any other relation type referenced by `base_type` must compose a
`tuple_type` that has a common tuple supertype with the tuple type
referenced by the `tuple_type` of the type being defined; that is, there
must be a diamond relationship (but both `tuple_type` may reference
exactly the same tuple type).

* `constraints` - `set_of.RelPathMaterialNC`

This, *relation constraints*, matches the invocation names of 0..N
relation-constraint-defining materials that (when *and*-ed together)
determine what sets of tuples of the type of `tuple_type` comprise the
bodies of values of the relation [|sub]type; they are relation type
constraints that together validate a relation as a whole.  Each
relation-constraint-defining material is one of these 2 material kinds:
`value-constraint`, `key-constraint`.

A `value-constraint` for a relation type is like
the `value-constraint` of a
`TupleType` but that each function's parameter is
relation-typed rather than tuple-typed; it is a generalized type
constraint that validates a relation as a whole.

A `key-constraint` is an
explicit (unique) key constraint that is applicable to relation
values of the type being defined; it applies either as a candidate key or
as a unique key constraint, depending on context.  If there are no explicit
key constraints, then there is an implicit (unique) key over all attributes
of the relation type being defined, meaning that every possible tuple that
may individually be an element of a relation value of the type being
defined, may be in it at once.  If any explicit key constraints are
defined, then every one must be over a distinct proper subset of the type's
attributes, and moreover no key's attributes may be a subset of any other
key's attributes; if 2 such candidates appear, just use the one that has
the subset.  It is valid for a key to consist of zero attributes; in this
case, that key is the only key of the type, and values of the type may each
consist of no more than one tuple.  At most one one of a type's
`key-constraint` may be privileged
as the *primary key*.  Note that a `key-constraint` is logically an
abstraction syntax (the canonical simplest form) for a particular kind of
`value-constraint` of the type being defined, one that compares the
cardinality of a projection of a relation on its key attributes with the
cardinality of the original relation; the attribute values comprise a key
if the cardinalities are equal.

* `default` - `maybe_of.RPFunctionNC`

Iff it is a `Just`, then `default`
matches the invocation name of a `named-value` function that
results in the default relation value of the [|sub]type; it has
zero parameters and its result type is the same as the relation
type being defined.  Iff `default` is
`Nothing` and `base_type` is `Nothing`, then semantics are as if
`default` were a defined name that resulted in a value of the
type being defined that had zero tuples.  Iff `default` is
`Nothing` and `base_type` is a `Just`, then the subtype will use the
same default relation value as its base type; but if the subtype's value
set excludes said value, then a `default` of `Nothing` is
invalid and `default` must be a `Just`.
Overriding the above, `default` must be `Nothing` if the type being
defined is an alias for `Empty`.

The default value of `RelationType` defines a relation type that has
zero attributes and whose default value is the one with zero tuples.

## sys.std.Core.Type.Cat.VirtualAttrMapSet

A `VirtualAttrMapSet` is a `DHRelation` that defines special functional
dependencies between attributes of a nonscalar data type, such
that, on a per-tuple basis, some attributes can be generated purely from
other attributes, and hence the former attributes may be virtual.  Each
tuple of a `VirtualAttrMapSet` specifies 2 disjoint subsets of the
nonscalar's attributes, which are *determinant* and *dependent*
attributes respectively, where the values of the second set are generated
from the first using a `virtual-attr-map` function.  Whether *dependent*
attributes are computed when needed or pre-computed and stored (a trade-off
of storage space for speed) is implementation dependent, though users may
give hints to govern that performance decision.

The main reason for virtual attributes to exist is to provide a fundamental
feature of a relational database where multiple perceptions of the same
data can exist at once; each user can perceive the same data being
organized according to their own preferences, and even if the actual means
of storing the data changes over time, the users continue to be able to
perceive it in the same ways as before the change.

The most important use case of virtual attributes is when the data type
having them is a database type, all of whose attributes are relations (or
databases); and so these attributes define database relvars, with
non-virtual and virtual attributes being base and virtual relvars,
respectively (which correspond to the SQL concepts of base tables and
views, respectively).  The idea in general is that users can work with any
relvar without knowing whether it is base or virtual, and so if
implementations change later such that real relvars become virtual or
vice-versa, users could continue as if nothing changed.

A less common use case of virtual attributes is in (typically non-database)
nonscalar types when users want to treat non-identical values as being
distinct in some situations and non-distinct in others.  For example they
want to do case-insensitive matching of character data, or alternately they
want a case-insensitive (unique) key constraint on such, but either way
they want the case of the data preserved.  In this situation, a base
attribute can exist with the original case-preserved data, and a dependent
virtual attribute can exist with the first's values folded to uppercase
(eliminating any case differences); so then the key constraint can be
placed on the virtual attribute to get the desired semantics, and the
matching can be done against the same.

All permissable operations on virtual [|pseudo-]variables are such that the
semantics of updating them is the same as for updating base
[|pseudo-]variables, with respect to *The Assignment Principle*: Following
assignment of a value `v` to a variable `V`, the comparison `v = V`
evaluates to TRUE.  Just as an update to determinant variables will have
the cascade effect of updating their dependent variables such that the
functional dependency between them continues to hold, the reverse also must
happen.  Any update to dependent variables must have the side effect of
updating their determinant variables.  Specifically, the implementing code
of an update to dependents must be rewritten behind the scenes to become
instead an update to their determinants, as if the latter was what the
users had actually written, such that following the then-first update of
the determinants, the cascading update to the dependents by the functional
dependency must result in the same dependents' values that they would have
had if the dependents were just base variables being updated by the
original code.  If such a code rewrite can not be done, such as due to
information lost in the functional dependency, then the operation
attempting to update the dependent attributes must fail.  Sometimes the
code rewrite can be done automatically by the DBMS, and sometimes it can
succeed if the map definer gives explicit details on how to accomplish it.

Because Muldis Data Language requires a strong degree of determinism in the whole
system, sometimes users have to provide explicit details on how to
accomplish a reverse mapping, even if it is possible to automatically
generate such, because there may be multiple ways to do a reverse map that
satisfy *The Assignment Principle*, so the explicitness would be to pick
exactly one of those, so that how determinants are updated is predictable
in an implementation-portable manner.  For example, if a virtual relvar
`V` is defined as the simple relational union of 2 other relvars `R1` and
`R2`, then a tuple insertion into `V` could be rewritten at least 3
ways, which are an insertion into just `R1`, or into just `R2`, or into
both `R1` and `R2`; so for predictability's sake, the map should specify
which option to do (which can vary on a case-by-case basis).

*This all being said, for the moment the `VirtualAttrMapSet` type does
not give a way to manually specify a reverse function, so for now all the
virtuals are either read-only or updatable due to an automatically
generated reverse function, which might vary by implementation.  Fixing
this matter is TODO.  Note that the reverse functions might have to be
defined as per-tuple operations, separately for
insert/substitute/delete.*

A `VirtualAttrMapSet` has these 6 attributes:

* `scm_comment` - `Comment`

This is an optional programmer comment about this virtual attribute map.

* `scm_vis_ord` - `NNInt`

This is the visible order of this declaration relative to all of
the other declarations beneath this tuple type declaration.

* `determinant_attrs` - `NameNCMap`

These are the names of the determinant attributes.  Each name is given in 2
forms, called `name` and `nc`; `nc` is the actual name of the
attribute as existing in the host type, and it may actually be a component
attribute of a host type attribute to any recursive depth (a single `nc`
element means it is the actual host type element); `name` is an alias by
which the attribute will be known in the `virtual-attr-map` function; this
mapping exists so to make the determinant attributes look like direct
sibling attributes whereas in reality they can be further-away relatives,
just common components somewhere under the host type.

* `dependent_attrs` - `NameNCMap`

These are the names of the dependent attributes; the structure of
`dependent_attrs` is as per `determinant_attrs`; none of these may be the
same as the names of the determinant attributes, since a virtual attribute
can't be defined in terms of itself.

* `virtual_attr_map` - `RPFunctionNC`

This matches the invocation name of a `virtual-attr-map` function
that derives a tuple of dependent attribute values from a tuple of
determinant attribute values.  The function that this names must
have a single `topic` parameter whose declared type is a tuple whose
attributes match those of `determinant_attrs`; the function's
result type must be a tuple whose attributes match those of
`dependent_attrs`.  Note that the range of this function is typically
smaller than its domain, though it might not be.

* `is_updateable` - `Bool`

This is `Bool:True` if all of the dependent attributes should be treated
as updateable, because they have enough information to map any kinds of
updates (all of tuple insert/substitute/delete) back to their determinant
attributes, and the system should try to support updates against them.
This is `Bool:False` if all of the dependent attributes should not be
considered updateable, either because it is known they don't have enough
information, or because we expect users will never try to update them, so
don't go to the trouble of supporting updates.

A `VirtualAttrMapSet` has a binary primary key on the `determinant_attrs`
plus `dependent_attrs` attributes; it also has a distributed primary key
over the `dependent_attrs` attribute of all tuples.  Its default value is
empty.

## sys.std.Core.Type.Cat.DomainType

A `DomainType` is a `DHTuple`.  It defines a new data type whose
values are all drawn from a list of specified other types (which can be
any types at all), and that generally speaking it is an
arbitrary subset of `Universal` (and it has its own default value).  The
value set of the new data type is determined by taking a set of source
types' values and subtracting from it a set of filter types' values (and
then optionally applying 0..N type constraint functions to the values
remaining).  The likely most common such type definition scenario is
defining a simple explicit union type of 2+ scalar source types.  Less
likely for usage, you can also define simple explicit intersection or
difference or exclusion types.  A domain type does not define any changes
or supplements to the interfaces available for working with its values,
instead simply using those of its declared parent types.  A data type
defined in this way is typically not considered to exist when the system
wants to determine the MST (most specific type) of one of its values.  Note
that if you want to define a possrep-adding scalar subtype whose base is
a union/intersection/etc of other types (eg, to define a "Square" when you
have "Rectangle", "Rhombus"), you have to first define a `DomainType`,
and then use that as the base type of a `ScalarType`.

A `DomainType` has these 8 attributes:

* `scm_comment` - `Comment`

This is an optional programmer comment about the domain type as a whole.

* `composed_mixins` - `ComposedMixinSet`

These are the names of the 0..N mixin types, if any, that the new domain
type composes, and therefore the new type is a subtype of all of them.

* `sources` - `set_of.RPTypeNC`

These are the names of the 0..N other types that all the
values of the new data type are drawn from; the complete set of source
values is determined by either unioning (the default) or intersecting the
values of these types.

* `is_source_intersection` - `Bool`

Iff this is `Bool:True` then the set of source data types will be
intersected to determine the complete set of source values, and if
`sources` has no elements then the source set is just `Universal`; iff
this is `Bool:False` then the set of source data types will be unioned to
determine the complete set of source values, and if `sources` has no
elements then the source set is just `Empty`.

* `filters` - `set_of.RPTypeNC`

These are the names of the 0..N other types (which are generally subtypes
of those of `sources`) that determine values which the new data type will
*not* contain; the complete set of filter values is determined by either
unioning (the default) or intersecting the values of these types.

* `is_filter_intersection` - `Bool`

Iff this is `Bool:True` then the set of filter data types will be
intersected to determine the complete set of filter values, and if
`filters` has no elements then the filter set is just `Universal`; iff
this is `Bool:False` then the set of filter data types will be unioned to
determine the complete set of filter values, and if `filters` has no
elements then the filter set is just `Empty`.

* `constraints` - `set_of.RPFunctionNC`

This matches the invocation names of 0..N `type-constraint` functions
that (when *and*-ed together) determine what filter-type-passing
source-type values are part of the domain type.  The function
that each of these names must have a single `topic` parameter whose
declared type is `Universal`, unless there is exactly 1 `sources` element
whereupon the declared type is the same as the source type, and whose
argument is the value to test; the function's result type must be
`Bool`.  If the functions unconditionally result in `Bool:True`, then all
filter-type-passing values are allowed.

* `default` - `maybe_of.RPFunctionNC`

Iff it is a `Just`, then `default`
matches the invocation name of a `named-value` function that results
in the default value of the domain type; it has zero parameters and its
result type is the same as the domain type being defined.
In contrast, `default` must be `Nothing` if the type being
defined is `Empty` or an alias of that.

The default value of `DomainType` defines the `Empty` type; it has
zero source and filter types, both type lists are unioned, `constraints`
is empty (unconditionally `Bool:True`), and there is no default value.

## sys.std.Core.Type.Cat.SubsetType

A `SubsetType` is a `DHTuple`.  It provides a relatively terse
method to define a simple subset-defined subtype of a single other
type (which can be any type at all), which is a common kind of
type to have.  The new type is either a proper or non-proper subset of the
other type, whose values are determined from applying 0..N type constraint
functions to the parent type; either way, the new type may declare its own
default value.  An alternate common scenario is to define a non-proper
subtype of its parent type that serves just to supply a different default
value for the context in which the new type is used.  A subset type
does not define any changes or supplements to the interfaces available for
working with its values, instead simply using those of its declared parent
type.  A data type defined in this way is typically not considered to exist
when the system wants to determine the MST (most specific type) of one of
its values.  You can only declare a nonscalar type with an incompletely
defined attribute list using a `SubsetType` (or a `DomainType`).

A `SubsetType` has these 5 attributes:

* `scm_comment` - `Comment`

This is an optional programmer comment about the subset type as a whole.

* `composed_mixins` - `ComposedMixinSet`

These are the names of the 0..N mixin types, if any, that the new subset
type composes, and therefore the new type is a subtype of all of them.

* `base_type` - `RPTypeNC`

This is the name of the other type that all the values of the
new data type are drawn from; the new type is being declared as a subtype
of that named by `base_type`.

* `constraints` - `set_of.RPFunctionNC`

This matches the invocation names of 0..N `type-constraint` functions
that (when *and*-ed together) determine what base type values are part of
the subset type.  The function that each of these names
must have a single `topic` parameter whose declared type is that named
by `base_type`, and whose argument is the value to test; the function's
result type must be `Bool`.  If the functions unconditionally result in
`Bool:True`, then the new type is a non-proper subtype of the base type.

* `default` - `maybe_of.RPFunctionNC`

Iff it is a `Just`, then `default`
matches the invocation name of a `named-value` function that
results in the default value of the subset type; it has zero
parameters and its result type is the same as the subset type
being defined.  Iff `default` is `Nothing`, then the
subset type will use the same default value as its base type; but if
the subset type's value set excludes said value, then a `default` of
`Nothing` is invalid and `default` must be a `Just`.
Overriding the above, `default` must be `Nothing` if the type being
defined is an alias for `Empty`.

The default value of `SubsetType` defines an alias for `Universal`,
with the same default value; it has the base type `Universal` and
`constraints` is empty (unconditionally `Bool:True`).

## sys.std.Core.Type.Cat.MixinType

A `MixinType` is a `DHTuple`.  It defines a new data type whose values
are a union of those from the zero or more other types that
specify themselves to be part of that union.  For all practical purposes, a
`MixinType` declares a *mixin* or *interface* or *role* (the last as
Raku uses the term) which is meant to be composed into other types, such
that said other types are then at least labelled as being useable in
particular common ways, and optionally the mixin type may define attributes
or code that can be reused by the types that compose it.  For example,
`Numeric` is a mixin type, and any types composing it such as `Int` or
`Rat` are thereby declaring themselves to support common numeric operators
such as addition and multiplication.  A union type declared by a
`MixinType` is unlike one declared by a `DomainType` in that the former
is *open* and the latter is *closed*; any user-defined type can add
itself to the domain of even a system-defined mixin-type (such as
`Numeric`), whereas no type can add itself to the domain of a
system-defined domain-type (such as `Bool`).  A data type defined by a
`MixinType` is typically not considered to exist when the system wants to
determine the MST (most specific type) of one of its values.

A `MixinType` has these 2 attributes:

* `scm_comment` - `Comment`

This is an optional programmer comment about the mixin type as a whole.

* `composed_mixins` - `ComposedMixinSet`

These are the names of the 0..N other mixin types, if any, that the new
mixin type composes.  Any other type that explicitly composes the new mixin
type will also implicitly compose all of the other mixin types that the new
mixin type composes, recursively; note that a mixin type is forbidden from
composing itself, directly or indirectly.

The default value of `MixinType` defines a mixin type has no comment and
composes no other mixins and that in isolation has no default value.

## sys.std.Core.Type.Cat.ComposedMixinSet

A `ComposedMixinSet` is a `DHRelation`.  It defines a set of names of
declared mixin data types which are being composed by another type, and for
each it indicates whether the composing type is asserting that it will
provide the default value of the mixin type.  A `ComposedMixinSet` has 4
attributes, `type` (a `RPTypeNC`), `provides_its_default` (a `Bool`),
`scm_comment` (a `Comment`), and `scm_vis_ord` (a `NNInt`); the `type`
is the declared name of the mixin type being composed, and comprises a
unary key.  Its default value has zero tuples.

A providing composing type always gives its own default value for the
mixin's default; they can't be different; if you want different, declare a
subtype of the value provider to be what composes the mixin.  No more than
one visible type may declare provision of the default value for a mixin.
If a system-defined type claims to provide a default for a mixin, no
user-defined type ever can (see `Ordered`, `Ordinal`, `Numeric`,
`Stringy`).  If a system-defined mixin exists that no system-defined type
composes (see `Instant`, `Duration`) then exactly one user-defined type
in a mounted depot may claim to provide its default, and that only affects
code in that depot which asks for the default value of said types.  A
user-defined mixin type can only be composed by user-defined types in the
same depot.  Asking a mixin type for its default will fail unless a visible
type claims its default.  Iff exactly one visible type composes a mixin,
that one will provide the mixin's default value implicitly if it doesn't
explicitly claim to.

## sys.std.Core.Type.Cat.KeyConstr

A `KeyConstr` is a `DHTuple`.  It specifies a candidate key or
unique key constraint for a relation type.

A `KeyConstr` has these 3 attributes:

* `scm_comment` - `Comment`

This is an optional programmer comment about the key as a whole.

* `attrs` - `set_of.Name`

This defines the 0..N host relation attributes comprising the key.  If
this set is empty, then we have a nullary key which restricts the host
relation to have a maximum of 1 tuple.

* `is_primary` - `Bool`

This is `Bool:True` if this key has been designated the *primary key* of
the relation (a relation may have at most one, or none, of those); it
is `Bool:False` otherwise.  A primary key is privileged over candidate
keys in general, in that all of the attributes comprising the primary key
are likely to be treated as immutable in practice for the relation's
tuples, and hence are the best candidates for identifying tuples within
a relation over an extended term (if multiple keys conceptually have all
those qualities, then you could choose either as the primary, or perhaps
such a situation may indicate a flaw in your database design).  The common
concept of a tuple having an identity that is distinct from the sum total
of all its attribute values, such that one can say that a tuple is being
"updated" (rather than its host relation being the only thing that is
updated to hold a different set of tuples) is dependent in Muldis Data Language on
the host relation having a primary key; if a tuple in a relation is
replaced by a distinct tuple whose values in the primary key attributes
are identical, it is only in this situation that we can consider that we
still have the same tuple, which was just updated, and that we have not
lost the old tuple and gained a new one.  The relation attributes
comprising a primary key are the best mapping values for automatic new
subset constraints and join conditions if the host relation type has to be
auto-split into several associated ones, for example because the physical
representation of this relation doesn't support RVAs; in fact, some
implementations may require that any relation having an RVA must also
have an explicit primary key, so it is easier for them to choose the key to
automatically relate a split relation on.

The default value of `KeyConstr` defines a nullary key.

## sys.std.Core.Type.Cat.DistribKeyConstr

A `DistribKeyConstr` is a `DHTuple`.  It specifies a candidate
distributed (unique) key constraint over relation-valued attributes of a
tuple/database.

A `DistribKeyConstr` has these 4 attributes:

* `scm_comment` - `Comment`

This is an optional programmer comment about the distributed (unique) key
as a whole.

* `attrs` - `set_of.Name`

This declares the 0..N attributes comprising the distributed (unique) key.
If this set is empty, then we have a nullary key which restricts all of the
relations participating in the distributed key to have a maximum of 1
tuple between them.  Note that the distributed key attribute names don't
have to match the names of any participating relation attributes.

* `relations` - `DKMemRelAttrMap`

This names the 0..N relation-valued attributes of the host
tuple/database type that are participating in the distributed key, and
says which of each of their attributes maps to the attributes of the
distributed key itself.  If this set is empty, then the distributed key has
no effect.  The unary projection of every tuple of the `key_attr`
attribute of `relations` must be identical to `attrs`.

* `is_primary` - `Bool`

This has the same meaning as `is_primary` of `KeyConstr` but for being
distributed as if the relations distributed over were one relation.

The default value of `DistribKeyConstr` has all-empty attributes.

## sys.std.Core.Type.Cat.SubsetConstr

A `SubsetConstr` is a `DHTuple`.  It specifies a (non-distributed) subset
constraint (foreign key constraint) over relation-valued
attributes of a tuple/database; a subset constraint
is a kind of referential constraint, that relates tuples of such
attributes.  Each tuple of a child attribute must have a corresponding
tuple in a specific single parent attribute, where they correspond on the
attributes of the parent attribute that comprise a (unique) key of the
latter.  Note that it is valid to define a subset constraint involving zero
attributes, in which case the constraint is that the parent relation must
have exactly one tuple when the child relation has at least one tuple.

A `SubsetConstr` has these 5 attributes:

* `scm_comment` - `Comment`

This is an optional programmer comment about the subset constraint as a
whole.

* `parent` - `NameChain`

This is the name of the relation-valued attribute that is the parent in the
(non-distributed) subset constraint relationship.  But the attribute named
by `parent` is only a direct attribute of the host type if `parent` has 1
chain element; if it has more, then the host type attribute is a
tuple/database and any further elements serve to make `parent` actually
address a component of said.

* `parent_key` - `RelPathMaterialNC`

This matches the invocation name of the candidate key or unique key
constraint of `parent`, explicitly declared as a `key-constraint`
material, which defines the attributes of `parent` that are
being matched on in the subset constraint.

* `child` - `NameChain`

This is the name of the relation-valued attribute that is the child in the
(non-distributed) subset constraint relationship; its structure is as per
`parent`.  Note that `child` and `parent` are allowed to be one and the
same.

* `attr_map` - `SCChildAttrParentAttrMap`

This maps 0..N attributes of the child relation with the same number of
attributes of the parent relation; the mapped attribute names may or may
not be the same.

The default value of `SubsetConstr` has all-empty attributes.

## sys.std.Core.Type.Cat.DistribSubsetConstr

A `DistribSubsetConstr` is a `DHTuple`.  It specifies a distributed
subset constraint (foreign key constraint) over relation-valued
attributes of a tuple/database; a distributed subset constraint
is a kind of referential constraint, that relates tuples of such
attributes.  Each tuple of a child attribute must have a corresponding
tuple in one member of a specific set of parent-alternative attributes
(that have a distributed key ranging over them), where they correspond on
the attributes of the parent-alternative attribute that comprise a
distributed key on the latter.  Note that it is valid to define a subset
constraint involving zero attributes, in which case the constraint is that
exactly one of the parent relations must have exactly one tuple when the
child relation has at least one tuple.

A `DistribSubsetConstr` has these 4 attributes:

* `scm_comment` - `Comment`

This is an optional programmer comment about the subset constraint as a
whole.

* `parent_distrib_key` - `RelPathMaterialNC`

This matches the invocation name of the distributed (unique) key,
explicitly declared as a `distrib-key-constraint` material, that
is the parent in the distributed subset constraint relationship; it defines
by proxy the attributes that are being matched on in the subset constraint.
But the distributed key named by `parent_distrib_key` may not be directly
declared by the host type of this subset constraint; it might be declared
by the type of an attribute of the host type, if said attribute is a
tuple/database; so the only or last `parent_distrib_key` chain element is
a key name, and any preceeding names are attribute names.

* `child` - `NameChain`

This is the name of the relation-valued attribute that is the child in the
distributed subset constraint relationship.  But the attribute named by
`child` is only a direct attribute of the host type if `child` has 1
chain element; if it has more, then the host type attribute is a
tuple/database and any further elements serve to make `child` actually
address a component of said.

* `attr_map` - `SCChildAttrParentAttrMap`

This maps 0..N attributes of the child relation with the same number of
attributes of the parent distributed key; the mapped attribute names may or
may not be the same.

The default value of `DistribSubsetConstr` has all-empty attributes.

## sys.std.Core.Type.Cat.DKMemRelAttrMap

A `DKMemRelAttrMap` is a `DHRelation` that names the 0..N relation-valued
attributes of a host tuple/database type that are participating in a
distributed key, and says which of each of their attributes maps to the
attributes of the distributed key itself.

A `DKMemRelAttrMap` has these 3 attributes:

* `rel_name` - `NameChain`

This is the name of the relation-valued attribute that is participating
in the distributed key.  But the attribute named by `rel_name` is only a
direct attribute of the host type if `rel_name` has 1 chain element; if it
has more, then the host type attribute is a tuple/database and any
further elements serve to make `rel_name` actually address a component of
said.

* `scm_comment` - `Comment`

This is an optional programmer comment about the participation.

* `attr_map` - `DKRelAttrKeyAttrMap`

This maps 0..N attributes of the relation with the same number of
attributes of the distributed key.  Every tuple of `attr_map` must have an
identical value for the unary projection on its `key_attr` attribute; in
other words, they must all map with the same distributed key attributes.

A `DKMemRelAttrMap` has a unary primary key on the `rel_name` attribute.
Its default value is empty.

## sys.std.Core.Type.Cat.DKRelAttrKeyAttrMap

A `DKRelAttrKeyAttrMap` is a `DHRelation`.  It maps 0..N attributes of a
relation-valued attribute of a host tuple/database type participating
in a distributed key, to the same number of attributes of the distributed
key itself.  A `DKRelAttrKeyAttrMap` has 2 attributes, `rel_attr` and
`key_attr`, each of those being a `Name`, and each of those being a unary
key.  Its default value has zero tuples.

## sys.std.Core.Type.Cat.SCChildAttrParentAttrMap

A `SCChildAttrParentAttrMap` is a `DHRelation`.  It maps 0..N attributes
of a child relation-valued attribute of a host tuple/database type
participating in a non-distributed or distributed subset constraint
(foreign key), to the same number of attributes of a parent such attribute
or a distributed key of the host.  A `SCChildAttrParentAttrMap` has 2
attributes, `child_attr` and `parent_attr`, each of those being a
`Name`, and each of those being a unary key.  Its default value has zero
tuples.

# TYPES FOR DEFINING STIMULUS-RESPONSE RULES

## sys.std.Core.Type.Cat.StimRespRule

A `StimRespRule` is a `DHTuple`.  It defines a new stimulus-response rule
which invokes a procedure automatically in response to some
stimulus; for now just the act of a depot being mounted is supported.

A `StimRespRule` has these 3 attributes:

* `scm_comment` - `Comment`

This is an optional programmer comment about the rule as a whole.

* `stimulus` - `Name`

This is always the value `after-mount` for now.

* `response` - `MaterialNC`

This is the name of the procedure being invoked.

The default value of `StimRespRule` defines a stimulus-response rule whose
stimulus is `after-mount` and whose response is an invocation of the
procedure `sys.std.Core.Cat.fail`.

# SIMPLE GENERIC NONSCALAR TYPES

## sys.std.Core.Type.Cat.D0

A `D0` is a `Database`.  It has exactly zero attributes; it is a
singleton type whose only value is also known as `Tuple:D0`.  This exists
as a data type as a convenience for the definition of scalar singleton
types, which would typically use this as the tuple type which their possrep
is defined partially in terms of.

## sys.std.Core.Type.Cat.NameTypeMap

A `NameTypeMap` is a `DHRelation`.  It defines a basic component list,
meaning a set of names, with a declared data type name for each.  It forms
the foundation for most componentized type definitions, including all
tuple and relation types (for which it is named *heading*), and it is
used also for the components list of a scalar possrep.  It is also used
to define parameter lists for routines.  A `NameTypeMap` has 4 attributes,
`name` (a `Name`), `type` (a `RPTypeNC`), `scm_comment` (a
`Comment`), and `scm_vis_ord` (a `NNInt`); the `name` is the
declared name of the attribute or parameter, and comprises a unary key; the
`type` is the declared data type of the attribute or parameter.  Its
default value has zero tuples.

## sys.std.Core.Type.Cat.NameExprMap

A `NameExprMap` is a `DHRelation`.  It defines a basic component-values
list, meaning a set of names, with a declared local expression node (or
parameter) name for each.  It is used to define collection literals; one
`NameExprMap` defines a whole `Tuple` value.  It is also used to define
argument lists for routine invocations.
A `NameExprMap` has 3 attributes, `name` and `expr`, each of those being
a `Name`, and `scm_vis_ord` (a `NNInt`); the `name` is the name of the
tuple/etc attribute or routine argument, and comprises a unary key; the
`expr` is the declared lexical name of the expression node (or parameter
or variable) which defines the value for the attribute or argument.  Its
default value has zero tuples.

## sys.std.Core.Type.Cat.NameNCMap

A `NameNCMap` is a `DHRelation`.  It defines an association of a short
name with a name chain, to be used for aliasing the latter with the former
in a particular context.  A `NameNCMap` has 3 attributes, `name` (a
`Name`), `nc` (a `NameChain`), and `scm_vis_ord` (a `NNInt`); each of
those is a unary key.  Its default value has zero tuples.

## sys.std.Core.Type.Cat.AttrRenameMap

An `AttrRenameMap` is a `DHRelation`.  It is used as a specification for
how to rename attributes of some collection.  An `AttrRenameMap` has 3
attributes, `after` and `before`, each of those being a `Name`, and each
of those being a unary key; the 3rd attribute is `scm_vis_ord` (a
`NNInt`).  Its default value has zero tuples.

## sys.std.Core.Type.Cat.OrderByName

An `OrderByName` is a `DHTuple`.  It defines an element of an order-by
sequential expression, which is a specification for how to order tuples of
a relation in terms of a list of their attributes to order on.  An
`OrderByName` has 2 attributes, `name` (a `Name`) and
`is_reverse_order` (a `Bool`).  Its default value has the default value
of the `Name` and `Bool` types for their respective attributes.  *Maybe
TODO:  Make `name` a `PNSQNameChain` instead to drill into TVAs or SVAs.*

# TYPES FOR POSSIBLY PRIMED HIGHER-ORDER FUNCTIONS

## sys.std.Core.Type.Cat.PrimedFuncNC

A `PrimedFuncNC` is a (not necessarily deeply homogeneous) `Tuple`.  It
is conceptually a *primed higher-order function*, that is, an
`APFunctionNC` referencing a function plus a set of zero or more arguments
to pre-bind to a same-degree subset of that function's read-only
parameters, such that the effective higher-order-function which this
references has appropriately fewer parameters remaining to bind to when it
is actually invoked.  A `PrimedFuncNC` has 2 attributes, `function` (an
`APFunctionNC`) and `args` (a `Tuple`); `function` names the actual
function to invoke, and `args` names any arguments to pre-bind to its
parameters.  Whether or not its `args` has any attributes that are not
deeply homogeneous is the sole determinant of whether a `PrimedFuncNC` is
a `DHTuple` rather than just a `Tuple`.  Its default value is a reference
to the `sys.std.Core.Universal.is_same` function with no pre-bound
parameters.

## sys.std.Core.Type.Cat.ValMapPFuncNC

`ValMapPFuncNC` is a non-proper subtype of `PrimedFuncNC` that is
conceptually a reference to a `value-map` function.  Its default value is
a reference to the `sys.std.Core.Cat.map_to_topic` function.

## sys.std.Core.Type.Cat.ValFiltPFuncNC

`ValFiltPFuncNC` is a non-proper subtype of `ValMapPFuncNC` that is
conceptually a reference to a `value-filter` function.  Its default value
is a reference to the `sys.std.Core.Cat.pass_topic` function.

## sys.std.Core.Type.Cat.ValRedPFuncNC

`ValRedPFuncNC` is a non-proper subtype of `PrimedFuncNC` that is
conceptually a reference to a `value-reduction` function.  Its default
value is a reference to the `sys.std.Core.Cat.reduce_to_v1` function.

## sys.std.Core.Type.Cat.OrdDetPFuncNC

`OrdDetPFuncNC` is a non-proper subtype of `PrimedFuncNC` that is
conceptually a reference to an `order-determination` function.  Its
default value is a reference to the `sys.std.Core.Ordered.order` function.
This type is conceptually intended for use as the declared type of a
routine parameter that would take the name of an `order-determination`
function, but that parameter is optional and should default to the
system-defined scalar ordering function when no argument is given to it.

# TYPES FOR DEFINING EXCEPTIONS

## sys.std.Core.Type.Cat.Exception

`Exception` is a singleton scalar type whose only value represents a
generic thrown exception.  This type doesn't provide any means for a
*catch* routine to introspect details about the exception, such as what
kind of exception it was, but rather simply says that something happened
which resulted in a Muldis Data Language routine abnormally exiting.  Therefore, the
`Exception` type is subject to be rewritten so it can carry the various
metadata that exceptions of typical programming languages can.  But in the
meantime, this singleton type affords Muldis Data Language with completely functional
basic exception handling in that exceptions can be thrown and can be
caught, so that good program design involving the use of exceptions to draw
immediate attention to problems can be supported now.

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Data Language** (**MDL**).

MDL is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
