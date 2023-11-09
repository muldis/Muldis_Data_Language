# NAME

Muldis::D::Core::Bag - Muldis D Bag specific operators

# VERSION

This document is Muldis::D::Core::Bag version 0.148.1.

# PREFACE

This document is part of the Muldis D language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

This document describes generic operators that are specific to the
`Bag` parameterized relation type, and said operators
are short-hands for more generic relational operators.

*This documentation is pending.*

# FUNCTIONS IMPLEMENTING VIRTUAL COLLECTIVE FUNCTIONS

## sys.std.Core.Bag.has_member

`function has_member (Bool <-- coll : Bag, value : Universal)
implements sys.std.Core.Collective.has_member {...}`

This function is the same as `sys.std.Core.Set.has_member`, including that
matching of `value` is done against the `value` attribute, except that it
works with a `Bag` rather than a `Set`.

## sys.std.Core.Bag.has_not_member

`function has_not_member (Bool <-- coll : Bag, value : Universal)
implements sys.std.Core.Collective.has_not_member {...}`

This function is exactly the same as `sys.std.Core.Bag.has_member` except
that it results in the opposite boolean value when given the same
arguments.

## sys.std.Core.Bag.value_is_member

`function value_is_member (Bool <-- value : Universal, coll : Bag)
implements sys.std.Core.Collective.value_is_member {...}`

This function is an alias for `sys.std.Core.Bag.has_member`.  This
function is the same as `sys.std.Core.Set.value_is_member`, including that
matching of `value` is done against the `value` attribute, except that it
works with a `Bag` rather than a `Set`.

## sys.std.Core.Bag.value_is_not_member

`function value_is_not_member (Bool <-- value : Universal, coll : Bag)
implements sys.std.Core.Collective.value_is_not_member {...}`

This function is an alias for `sys.std.Core.Bag.has_not_member`.  This
function
is exactly the same as `sys.std.Core.Bag.value_is_member` except that it
results in the opposite boolean value when given the same arguments.

# GENERIC RELATIONAL FUNCTIONS FOR BAGS

## sys.std.Core.Bag.cardinality

`function cardinality (NNInt <-- topic : Bag) {...}`

This function is like `sys.std.Core.Relation.cardinality` but that it
accounts for the greater-than-one multiplicity of values in its argument;
it results in the sum of the `count` attribute of its argument.  Note that
this operation is also known as `#+`.

## sys.std.Core.Bag.count

`function count (NNInt <-- bag : Bag, value : Universal) {...}`

This function results in the multiplicity / count of occurrances of
`value` in `bag`; if a tuple exists in `bag` whose `value` attribute
is `value`, then the result is its `count` attribute; otherwise the
result is zero.

## sys.std.Core.Bag.insertion

`function insertion (Bag <-- bag : Bag, value : Universal) {...}`

This function is the same as `sys.std.Core.Set.insertion` as per
`has_member` but that its result differs depending on whether `value`
already exists in `bag`; if it does, then no new tuple is added, but the
`count` attribute for the matching tuple is incremented by 1; if it does
not, then a new tuple is added where its `value` is `value` and its
`count` is 1.  Actually this function differs in another way, such that it
is semantically the single-tuple case of `sys.std.Core.Bag.union_sum`, and
is not the single-tuple case of `sys.std.Core.Bag.union` (which is the
direct analogy to set union).

## sys.std.Core.Bag.deletion

`function deletion (Bag <-- bag : Bag, value : Universal) {...}`

This function is the same as `sys.std.Core.Set.deletion` as per
`has_member` but that its result differs depending on what the `count`
for any tuple matching `value` that already exists in `bag` is; if the
`count` is greater than 1, then it is decremented by 1; if it is equal to
1, then the tuple whose `value` attribute is `value` is deleted.

## sys.std.Core.Bag.reduction

`function reduction (Universal <-- topic : Bag,
func : ValRedPFuncNC, identity : Universal) {...}`

This function is the same as `sys.std.Core.Set.reduction`, including that
input values for the reduction come from the `value` attribute of
`topic`, except that it works with a `Bag` rather than a `Set`;
`func` is invoked extra times, where both its `v1` and `v2` arguments
might be different instances of the same value having >= 2 multiplicity.

## sys.std.Core.Bag.Bag_from_wrap

`function Bag_from_wrap (bag_of.Tuple <-- topic : Relation) {...}`

This function results in a `Bag` whose `value` attribute is tuple-typed
and that attribute's values are all the tuples of `topic`; it is a
short-hand for a relational wrap of all attributes of `topic` such that
the new tuple-valued attribute is named `value`, and then that result is
extended with a `count` attribute whose value for every tuple is 1.

## sys.std.Core.Bag.Bag_from_cmpl_group

`function Bag_from_cmpl_group (bag_of.Tuple <--
topic : Relation, group_per : set_of.Name) {...}`

This function is like `sys.std.Core.Relation.cardinality_per_group` but
that the `count_attr_name` is `count` and all the other attributes that
would have been in the result are wrapped in a single tuple-valued
attribute named `value`.  This function is to `cardinality_per_group`
what `sys.std.Core.Array.Array_from_wrap` is to
`sys.std.Core.Relation.rank`.

## sys.std.Core.Bag.Bag_from_attr

`function Bag_from_attr (Bag <-- topic : Relation, name : Name) {...}`

This function results in a `Bag` consisting of all the values of the
attribute of `topic` named by `name`.  It is a short-hand for first doing
a relational group on all attributes of `topic` besides `name` to produce
a new relation-typed attribute, and then extending the result of the
group with a new positive integer attribute whose values are the
cardinality of the relation-valued attribute's values, and then doing a
binary projection of the named attribute and the new integer attribute plus
their renaming to `value` and `count` respectively.

## sys.std.Core.Bag.is_subset

`function is_subset (Bool <-- topic : Bag, other : Bag) {...}`

This function is like `sys.std.Core.Relation.is_subset` but that it
accounts for the greater-than-one multiplicity of values in its arguments;
this function returns `Bool:True` iff the multiplicity of each `topic`
value is less than or equal to the multiplicity of its counterpart
`other` value.  Note that this operation is also known as `⊆+` or
`{<=}+`.

## sys.std.Core.Bag.is_not_subset

`function is_not_subset (Bool <-- topic : Bag, other : Bag) {...}`

This function is like `sys.std.Core.Relation.is_not_subset` as per
`is_subset`.  Note that this operation is also known as `⊈+` or
`{!<=}+`.

## sys.std.Core.Bag.is_superset

`function is_superset (Bool <-- topic : Bag, other : Bag) {...}`

This function is an alias for `sys.std.Core.Bag.is_subset` except that it
transposes the `topic` and `other` arguments.  This function is like
`sys.std.Core.Relation.is_superset` but that it accounts for the
greater-than-one multiplicity of values in its arguments; this function
returns `Bool:True` iff the multiplicity of each `topic` value is greater
than or equal to the multiplicity of its counterpart `other` value.
Note that this operation is also known as `⊇+` or `{>=}+`.

## sys.std.Core.Bag.is_not_superset

`function is_not_superset (Bool <-- topic : Bag, other : Bag) {...}`

This function is an alias for `sys.std.Core.Bag.is_not_subset` except that
it transposes the `topic` and `other` arguments.  This function is like
`sys.std.Core.Relation.is_not_superset` as per `is_superset`.
Note that this operation is also known as `⊉+` or `{!>=}+`.

## sys.std.Core.Bag.is_proper_subset

`function is_proper_subset (Bool <-- topic : Bag, other : Bag) {...}`

This function is like `sys.std.Core.Relation.is_proper_subset` as per
`is_subset`.  *What is its definition?*
Note that this operation is also known as `⊂+` or `{<}+`.

## sys.std.Core.Bag.is_not_proper_subset

`function is_not_proper_subset (Bool <-- topic : Bag,
other : Bag) {...}`

This function is like `sys.std.Core.Relation.is_not_proper_subset` as per
`is_subset`.  *What is its definition?*
Note that this operation is also known as `⊄+` or `{!<}+`.

## sys.std.Core.Bag.is_proper_superset

`function is_proper_superset (Bool <-- topic : Bag,
other : Bag) {...}`

This function is an alias for `sys.std.Core.Bag.is_proper_subset` except
that it transposes the `topic` and `other` arguments.  This function is
like `sys.std.Core.Relation.is_proper_superset` as per `is_superset`.
Note that this operation is also known as `⊃+` or `{>}+`.

## sys.std.Core.Bag.is_not_proper_superset

`function is_not_proper_superset (Bool <--
topic : Bag, other : Bag) {...}`

This function is an alias for `sys.std.Core.Bag.is_not_proper_subset`
except that it transposes the `topic` and `other` arguments.  This
function is like `sys.std.Core.Relation.is_not_proper_superset` as per
`is_superset`.  Note that this operation is also known as `⊅+` or
`{!>}+`.

## sys.std.Core.Bag.union

`function union (Bag <-- topic : set_of.Bag) {...}`

This function is like `sys.std.Core.Relation.union` but that it just
looks at the `value` attribute of its argument elements when determining
what element tuples correspond; then for each tuple in the result, its
`count` attribute value is the maximum of the `count` attribute values of
its corresponding input element tuples.  Note that this operation is
also known as `∪+` or `union+`.

## sys.std.Core.Bag.union_sum

`function union_sum (Bag <-- topic : bag_of.Bag) {...}`

This function is like `sys.std.Core.Bag.union` but that for each pair of
argument elements being unioned, the output `count` value is the sum of
the input `count` values rather than being the maximum of the inputs.
Note that this operation is also known as `∪++` or `union++`.

## sys.std.Core.Bag.intersection

`function intersection (Bag <-- topic : set_of.Bag) {...}`

This function is like `sys.std.Core.Relation.intersection` as `union` is
like `sys.std.Core.Relation.union`; the minimum of `count` attribute
values is used rather than the maximum.  Note that this
operation is also known as `∩+` or `intersect+`.

## sys.std.Core.Bag.diff

`function diff (Bag <-- source : Bag, filter : Bag) {...}`

This function is like `sys.std.Core.Relation.diff` as `union` is
like `sys.std.Core.Relation.union`; for corresponding input tuples, the
result only has a tuple with the same `value` if the `count` of the
`source` tuple is greater than the `count` of the `filter` tuple,
and the `count` of the result tuple is the difference of those two.
Note that this operation is also known as `minus+` or `except+` or `∖+`.

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
