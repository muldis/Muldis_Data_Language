# NAME

Muldis Data Language Core Tuple - Muldis Data Language generic tuple operators

# VERSION

This document is Muldis Data Language Core Tuple version 0.148.1.

# PREFACE

This document is part of the Muldis Data Language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

This document describes essentially all of the core Muldis Data Language generic
tuple operators (for generic tuples).

*This documentation is pending.*

# FUNCTIONS IMPLEMENTING VIRTUAL ATTRIBUTIVE FUNCTIONS

## sys.std.Core.Tuple.degree

`function degree (NNInt <-- topic : Tuple)
implements sys.std.Core.Attributive.degree {...}`

This function results in the degree of its argument (that is, the count of
attributes it has).

## sys.std.Core.Tuple.is_nullary

`function is_nullary (Bool <-- topic : Tuple)
implements sys.std.Core.Attributive.is_nullary {...}`

This function results in `Bool:True` iff its argument has a degree of zero
(that is, it has zero attributes), and `Bool:False` otherwise.  By
definition, the only 1 tuple value for which this function would result
in `Bool:True` is the value `Tuple:D0`.

## sys.std.Core.Tuple.is_not_nullary

`function is_not_nullary (Bool <-- topic : Tuple)
implements sys.std.Core.Attributive.is_not_nullary {...}`

This function is exactly the same as `sys.std.Core.Tuple.is_nullary`
except
that it results in the opposite boolean value when given the same argument.

## sys.std.Core.Tuple.has_attrs

`function has_attrs (Bool <-- topic : Tuple, attr_names : set_of.Name)
implements sys.std.Core.Attributive.has_attrs {...}`

This function results in `Bool:True` iff, for every one of the attribute
names specified by its `attr_names` argument, its `topic` argument has an
attribute with that name; otherwise it results in `Bool:False`.  As a
trivial case, this function's result is `Bool:True` if `attr_names` is
empty.

## sys.std.Core.Tuple.attr_names

`function attr_names (set_of.Name <-- topic : Tuple)
implements sys.std.Core.Attributive.attr_names {...}`

This function results in the set of the names of the attributes of its
argument.

## sys.std.Core.Tuple.rename

`function rename (Tuple <-- topic : Tuple, map : AttrRenameMap)
implements sys.std.Core.Attributive.rename {...}`

This function results in a `Tuple` value that is the same as its `topic`
argument but that some of its attributes have different names.  Each tuple
of the argument `map` specifies how to rename one `topic` attribute, with
the `after` and `before` attributes of a `map` tuple representing the
new and old names of a `topic` attribute, respectively.  As a trivial
case, this function's result is `topic` if `map` has no tuples.  This
function supports renaming attributes to each others' names.  This function
will fail if `map` specifies any old names that `topic` doesn't have, or
any new names that are the same as `topic` attributes that aren't being
renamed.

## sys.std.Core.Tuple.projection

`function projection (Tuple <-- topic : Tuple, attr_names : set_of.Name)
implements sys.std.Core.Attributive.projection {...}`

This function results in the projection of its `topic` argument that has
just the subset of attributes of `topic` which are named in its
`attr_names` argument.  As a trivial case, this function's result is
`topic` if `attr_names` lists all attributes of `topic`; or, it is the
nullary tuple if `attr_names` is empty.  This function will fail if
`attr_names` specifies any attribute names that `topic` doesn't have.

## sys.std.Core.Tuple.cmpl_proj

`function cmpl_proj (Tuple <-- topic : Tuple, attr_names : set_of.Name)
implements sys.std.Core.Attributive.cmpl_proj {...}`

This function is the same as `projection` but that it results in the
complementary subset of attributes of `topic` when given the same
arguments.

## sys.std.Core.Tuple.static_exten

`function static_exten (Tuple <-- topic : Tuple, attrs : Tuple)
implements sys.std.Core.Attributive.static_exten {...}`

This function results in the extension of its `topic` argument by joining
that with its `attrs` argument; the attribute names of the 2 arguments
must be disjoint.  See also `sys.std.Core.Tuple.product` for an N-adic
version of this.

## sys.std.Core.Tuple.wrap

`function wrap (Tuple <-- topic : Tuple, outer : Name,
inner : set_of.Name) implements sys.std.Core.Attributive.wrap {...}`

This function results in a `Tuple` value that is the same as its `topic`
argument but that some of its attributes have been wrapped up into a new
`Tuple`-typed attribute, which exists in place of the original
attributes.  The `inner` argument specifies which `topic` attributes are
to be removed and wrapped up, and the `outer` argument specifies the name
of their replacement attribute.  As a trivial case, if `inner` is empty,
then the result has all the same attributes as before plus a new
tuple-typed attribute of degree zero; or, if `inner` lists all attributes
of `topic`, then the result has a single attribute whose value is the same
as `topic`. This function supports the new attribute having the same name
as an old one being wrapped into it.  This function will fail if `inner`
specifies any attribute names that `topic` doesn't have, or if `outer` is
the same as a `topic` attribute that isn't being wrapped.

## sys.std.Core.Tuple.cmpl_wrap

`function cmpl_wrap (Tuple <-- topic : Tuple,
outer : Name, cmpl_inner : set_of.Name)
implements sys.std.Core.Attributive.cmpl_wrap {...}`

This function is the same as `wrap` but that it wraps the complementary
subset of attributes of `topic` to those specified by `cmpl_inner`.

## sys.std.Core.Tuple.unwrap

`function unwrap (Tuple <-- topic : Tuple, inner : set_of.Name,
outer : Name) implements sys.std.Core.Attributive.unwrap {...}`

This function is the inverse of `sys.std.Core.Tuple.wrap`, such that it
will unwrap a `Tuple`-type attribute into its member attributes.  This
function will fail if `outer` specifies any attribute name that `topic`
doesn't have, or if an attribute of `topic{outer}` has the same name as
another `topic` attribute.  Now conceptually speaking, the `inner`
parameter is completely superfluous for this `Tuple` variant of `unwrap`;
however, it is provided anyway so that this function has complete API
parity with the `Relation` variant of `unwrap`, where `inner` *is*
necessary in the general case, and so Muldis Data Language code using this function is
also forced to be more self-documenting or strongly typed.  This function
will fail if `inner` does not match the names of the attributes of
`topic{outer}`.

# GENERIC RELATIONAL FUNCTIONS FOR TUPLES

These functions are applicable to mainly tuple types, but are generic
in that they typically work with any tuple types.

## sys.std.Core.Tuple.D0

`function D0 (Tuple <--) {...}`

This `named-value` selector function results in the only zero-attribute
Tuple value, which is known by the special name `Tuple:D0`, aka `D0`.

## sys.std.Core.Tuple.attr

`function attr (Universal <-- topic : Tuple, name : Name) {...}`

This function results in the scalar or nonscalar value of the attribute
of `topic` whose name is given by `name`.  This function will fail if
`name` specifies an attribute name that `topic` doesn't have.  Note that
this operation is also known as `.{}`.

## sys.std.Core.Tuple.update_attr

`function update_attr (Tuple <-- topic : Tuple,
name : Name, value : Universal) {...}`

This function results in its `topic` argument but that its attribute whose
name is `name` has been updated with a new scalar or nonscalar value
given by `value`.  This function will fail if `name` specifies an
attribute name that `topic` doesn't have; this function will otherwise
warn if the declared type of `value` isn't a subtype of the declared type
of the attribute.

## sys.std.Core.Tuple.multi_update

`function multi_update (Tuple <-- topic : Tuple, attrs : Tuple) {...}`

This function is like `sys.std.Core.Tuple.update_attr` except that it
handles N tuple attributes at once rather than just 1.  The heading of
the `attrs` argument must be a subset of the heading of the `topic`
argument; this function's result is `topic` with all the attribute values
of `attrs` substituted into it.  This function could alternately be named
*sys.std.Core.Tuple.static_subst*.

## sys.std.Core.Tuple.product

`function product (Tuple <-- topic : set_of.Tuple) {...}`

This function is similar to `sys.std.Core.Relation.product` but that it
works with tuples rather than relations.  This function is mainly
intended for use in connecting tuples that have all disjoint headings,
such as for extending one tuple with additional attributes.

## sys.std.Core.Tuple.attr_from_Tuple

`function attr_from_Tuple (Universal <-- topic : Tuple) {...}`

This function results in the scalar or nonscalar value of the sole
attribute of its argument.  This function will fail if its argument is not
of degree 1.

## sys.std.Core.Tuple.Tuple_from_attr

`function Tuple_from_attr (Tuple <-- name : Name,
value : Universal) {...}`

This function results in the `Tuple` value which has just one attribute
whose name is given by `name` and whose value is given by `value`.

## sys.std.Core.Tuple.order_by_attr_names

`function order_by_attr_names (Order <-- topic : Tuple, other : Tuple,
order_by : array_of.OrderByName, is_reverse_order? : Bool) {...}`

This `order-determination` function provides convenient short-hand for the
common case of ordering tuples of a relation on a sequential list of
its named attributes, and the type of each of those attributes is a subtype
of a single scalar root type having a non-customizable (using `misc_args`)
type-default `order-determination` function, which is used to order on
that attribute.  This function is a short-hand for invoking
`sys.std.Core.Cat.Order.reduction` on an `Array` each of whose `Order`
elements is the result of invoking `sys.std.Core.Ordered.order` on the
corresponding attributes of `topic` and `other` whose names are given in
`order_by`; the `Array` given to `Order.reduction` has the same number
of elements as `order_by` has.  For each element value in `order_by`, the
`name` attribute specifies the attribute name of each of `topic` and
`other` to be compared, and the comparison operator's `is_reverse_order`
argument is supplied by the `is_reverse_order` attribute.  This function
will fail if `topic` and `other` don't have an identical degree and
attribute names, or if `order_by` specifies any attribute names that
`topic|other` doesn't have, or if for any attribute named to be ordered
by, that attribute's value for either of `topic` and `other` isn't a
member of a scalar root type having a type-default ordering function, or
if said root type isn't identical for both `topic` and `other`.  The
`order_by_attr_names` function's `is_reverse_order` argument is optional
and defaults to `Bool:False`, meaning it has no further effect on the
function's behaviour; but if this argument is `Bool:True`, then this
function will result in the opposite `Order` value that it otherwise would
have when given all the same other argument values.  It is expected that
for any relation whose tuples are to be ordered using
`order_by_attr_names`, the `order_by` constitutes a key or superkey.

## sys.std.Core.Tuple.subst_in_default

`function subst_in_default (Tuple <-- of : APTypeNC,
subst : Tuple) {...}`

This function results in the tuple value that is the default value of the
tuple data type whose name is given in the `of` argument, but that zero
or more of its attribute values have been substituted by values given in
the `subst` argument.  This function is a short-hand for
`sys.std.Core.Tuple.multi_update` on the result of
`sys.std.Core.Universal.default`.  This function will fail if either
`default` would fail for the same `of` argument, or if its result isn't a
tuple type, or if the heading of `subst` isn't a subset of the heading
of the default.  The purpose of this function is to support greater brevity
in Muldis Data Language coding such that users can define just part of a desired
tuple value and have the remainder filled in from defaults for them;
particularly useful with tuples that conceptually have some optional
attributes.

# UPDATERS IMPLEMENTING VIRTUAL ATTRIBUTIVE UPDATERS

# Updaters That Rename Attributes

## sys.std.Core.Tuple.assign_rename

`updater assign_rename (&topic : Tuple, map : AttrRenameMap)
implements sys.std.Core.Attributive.assign_rename {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Tuple.rename` function with the same arguments, and then
assigning the result of that function to `topic`.  This procedure is
analogous to the data-manipulation phase of a SQL RENAME TABLE|VIEW or
ALTER TABLE|VIEW RENAME TO statement iff `topic` is `Database`-typed;
each tuple of `map` corresponds to a renamed SQL table.

# Updaters That Add Attributes

## sys.std.Core.Tuple.assign_static_exten

`updater assign_static_exten (&topic : Tuple, attrs : Tuple)
implements sys.std.Core.Attributive.assign_static_exten {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Tuple.static_exten` function with the same arguments,
and then assigning the result of that function to `topic`.  This procedure
is analogous to the data-manipulation phase of a SQL CREATE TABLE|VIEW
statement iff both arguments are `Database`-typed; each relation-typed
attribute of `attrs` corresponds to a created SQL table.

# Updaters That Remove Attributes

## sys.std.Core.Tuple.assign_projection

`updater assign_projection (&topic : Tuple, attr_names : set_of.Name)
implements sys.std.Core.Attributive.assign_projection {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Tuple.projection` function with the same arguments, and
then assigning the result of that function to `topic`.

## sys.std.Core.Tuple.assign_cmpl_proj

`updater assign_cmpl_proj (&topic : Tuple, attr_names : set_of.Name)
implements sys.std.Core.Attributive.assign_cmpl_proj {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Tuple.cmpl_proj` function with the same arguments,
and then assigning the result of that function to `topic`.  This procedure
is analogous to the data-manipulation phase of a SQL DROP TABLE|VIEW
statement iff `topic` is `Database`-typed; each relation-typed
attribute named by `attr_names` corresponds to a dropped SQL table.

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Data Language** (**MDL**).

MDL is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
