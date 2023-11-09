# NAME

Muldis Data Language Core Scalar - Muldis Data Language operators for all scalar types

# VERSION

This document is Muldis Data Language Core Scalar version 0.148.1.

# PREFACE

This document is part of the Muldis Data Language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

This document describes essentially all of the core Muldis Data Language generic
scalar operators, applicable to all scalar types.

*This documentation is pending.*

# GENERIC FUNCTIONS FOR SCALARS

These functions are applicable to mainly scalar types, but are generic in
that they typically work with any scalar types.  Now some of these
functions (those with a parameter named `possrep`) work only with scalar
values that have possreps, and not with values of the 2 system-defined
scalar types lacking any possreps: `Int`, `String`; other functions are
not limited in that way, but may be limited in other ways.  Note that the
terminology used to describe these functions is taking advantage of the
fact that a scalar possrep looks just like a tuple.  Each `possrep`
and `name` parameter is optional and each defaults to the empty string if
no explicit argument is given to it.

## sys.std.Core.Scalar.attr

`function attr (Universal <-- topic : ScalarWP,
possrep? : Name, name? : Name) {...}`

This function results in the scalar or nonscalar value of the possrep
attribute of `topic` where the possrep name is given by `possrep` and the
attribute name is given by `name`.  This function will fail if `possrep`
specifies a possrep name that `topic` doesn't have or `name` specifies an
attribute name that the named possrep of `topic` doesn't have.  Note that
this operation is also known as `.{:}`.

## sys.std.Core.Scalar.update_attr

`function update_attr (ScalarWP <-- topic : ScalarWP, possrep? : Name,
name? : Name, value : Universal) {...}`

This function results in its `topic` argument but that its possrep
attribute whose possrep name is `possrep` and whose attribute name is
`name` has been updated with a new scalar or nonscalar value given by
`value`.  This function will fail if `possrep` specifies a possrep name
that `topic` doesn't have or `name` specifies an attribute name that the
named possrep of `topic` doesn't have, or if `value` isn't of the
declared type of the attribute; this function will otherwise warn if the
declared type of `value` isn't a subtype of the declared type of the
attribute.

## sys.std.Core.Scalar.multi_update

`function multi_update (ScalarWP <--
topic : ScalarWP, possrep? : Name, attrs : Tuple) {...}`

This function is like `sys.std.Core.Scalar.update_attr` except that it
handles N scalar possrep attributes at once rather than just 1.  The
heading of the `attrs` argument must be a subset of the heading of the
`topic` argument's possrep named by `possrep`; this function's result is
`topic` with all the possrep attribute values of `attrs` substituted into
it.  This function could alternately be named
*sys.std.Core.Scalar.static_subst*.

## sys.std.Core.Scalar.projection

`function projection (Tuple <-- topic : ScalarWP,
possrep? : Name, attr_names : set_of.Name) {...}`

This function results in the `Tuple` that is the projection of the
possrep (whose name is given in the `possrep` argument) of its `topic`
argument that has just the subset of attributes of `topic` which are named
in its `attr_names` argument.  As a trivial case, this function's result
is the entire named possrep of `topic` if `attr_names` lists all
attributes of that possrep; or, it is the nullary tuple if `attr_names` is
empty.  This function will fail if `possrep` specifies a possrep name that
`topic` doesn't have or `attr_names` specifies any attribute names that
`topic` doesn't have.  Note that this operation is also known as `{:}`.

## sys.std.Core.Scalar.cmpl_proj

`function cmpl_proj (Tuple <--
topic : ScalarWP, possrep? : Name, attr_names : set_of.Name) {...}`

This function is the same as `projection` but that it results in the
complementary subset of possrep attributes of `topic` when given the same
arguments.  Note that this operation is also known as `{:!}`.

## sys.std.Core.Scalar.Tuple_from_Scalar

`function Tuple_from_Scalar (Tuple <--
topic : ScalarWP, possrep? : Name) {...}`

This function results in the `Tuple` that has all the same attributes of
the possrep of `topic` whose name is given in `possrep`; in other words,
the function results in the externalization of one of a scalar value's
possreps.  This function will fail if `possrep` specifies a possrep name
that `topic` doesn't have.

## sys.std.Core.Scalar.Scalar_from_Tuple

`function Scalar_from_Tuple (ScalarWP <--
topic : Tuple, type : APTypeNC, possrep? : Name) {...}`

This function results in the `ScalarWP` value whose scalar root
[|sub]type is named by `type`, which has a possrep whose name matches
`possrep`, and whose complete set of attributes of that named possrep
match the attributes of `topic`.  This function can be used to select any
scalar value at all that has a possrep.

## sys.std.Core.Scalar.has_possrep

`function has_possrep (Bool <-- topic : ScalarWP,
possrep? : Name) {...}`

This function results in `Bool:True` iff its `topic` argument has a
possrep whose name is given by `possrep`; otherwise it results in
`Bool:False`.

## sys.std.Core.Scalar.possrep_names

`function possrep_names (set_of.Name <-- topic : ScalarWP) {...}`

This function results in the set of the names of the possreps of its
argument.

## sys.std.Core.Scalar.degree

`function degree (NNInt <-- topic : ScalarWP, possrep? : Name) {...}`

This function results in the degree of its `topic` argument's possrep
whose name is given by `possrep` (that is, the count of attributes the
possrep has).

## sys.std.Core.Scalar.has_attrs

`function has_attrs (Bool <-- topic : ScalarWP,
possrep? : Name, attr_names : set_of.Name) {...}`

This function results in `Bool:True` iff, for every one of the attribute
names specified by its `attr_names` argument, its `topic` argument's
possrep whose name is given by `possrep` has an attribute with that name;
otherwise it results in `Bool:False`.  As a trivial case, this function's
result is `Bool:True` if `attr_names` is empty.

## sys.std.Core.Scalar.attr_names

`function attr_names (set_of.Name <--
topic : ScalarWP, possrep? : Name) {...}`

This function results in the set of the names of the attributes of its
`topic` argument's possrep whose name is given by `possrep`.

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Data Language** (**MDL**).

MDL is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
