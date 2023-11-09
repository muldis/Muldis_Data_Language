# NAME

Muldis Data Language Ext Counted - Muldis Data Language extension for count-sensitive relational operators

# VERSION

This document is Muldis Data Language Ext Counted version 0.148.1.

# PREFACE

This document is part of the Muldis Data Language language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document
before you read this one, which provides subservient details.

# DESCRIPTION

Muldis Data Language has a mandatory core set of system-defined (eternally available)
entities, which is referred to as the *Muldis Data Language core* or the *core*; they
are the minimal entities that all Muldis Data Language implementations need to provide;
they are mutually self-describing and are either used to bootstrap the
language or they constitute a reasonable minimum level of functionality for
a practically useable industrial-strength (and fully *TTM*-conforming)
programming language; any entities outside the core, called *Muldis Data Language
extensions*, are non-mandatory and are defined in terms of the core or each
other, but the reverse isn't true.

This current `Counted` document describes the system-defined *Muldis Data Language
Counted Extension*, which consists of relational operators that are
sensitive to special relation attributes that store count metadata as if
the relation conceptually was a bag of tuples rather than a set of
tuples.  This extension doesn't introduce any new data types, and its
operators all range over ordinary relations.  The operators do not assume
that their argument relations have attributes of any particular names,
including that count-containing attributes have any particular names;
rather, each operator is told what attributes to treat as special by taking
extra explicit parameters specifying their names.  The operators are all
short-hands for generic relational operators either in the language core or
in other language extensions.  The *Muldis Data Language Counted Extension* differs
from the *Muldis Data Language Bag Extension* in that the latter deals just with
`Bag` binary relations with specific attribute names while the former
works with any relations at all.

This current document does not describe the polymorphic operators that all
types, or some types including core types, have defined over them; said
operators are defined once for all types in [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md).

*This documentation is pending.*

# GENERIC RELATIONAL FUNCTIONS THAT MAINTAIN COUNT ATTRIBUTES

Every one of these functions that takes a `count_attr_name` argument is
expecting that each of any other applicable arguments will have an
attribute whose name matches that given in `count_attr_name` and that the
type of this attribute is `PInt`; said functions will fail if these
conditions aren't met.  For brevity, this documentation will hereafter
refer to the attribute named in `count_attr_name` as `tcount`, and
moreafter it will refer to the collection of all attributes except
`tcount` as `tattrs`.

## sys.std.Counted.add_count_attr

`function add_count_attr (Relation <--
topic : Relation, count_attr_name : Name) {...}`

This function is a shorthand for `sys.std.Core.Relation.static_exten`
that adds to `topic` a single `tcount` attribute whose value for all
tuples is 1.  This function conceptually converts a set of tuples into a
bag of tuples, of multiplicity 1 per tuple.

## sys.std.Counted.remove_count_attr

`function remove_count_attr (Relation <--
topic : Relation, count_attr_name : Name) {...}`

This function is a shorthand for `sys.std.Core.Relation.cmpl_proj`
that removes from `topic` the single `tcount` attribute.  This function
conceptually converts a bag of tuples into a set of tuples, elimimating all
duplicates.

## sys.std.Counted.counted_cardinality

`function counted_cardinality (NNInt <--
topic : Relation, count_attr_name : Name) {...}`

This function is like `sys.std.Core.Relation.cardinality` but that it
accounts for the greater-than-one conceptual multiplicity of tuples in
its `topic` argument; it results in the sum of the `tcount` attribute of
its `topic` argument.

## sys.std.Counted.counted_has_member

`function counted_has_member (Bool <-- r : Relation,
t : Tuple, count_attr_name : Name) {...}`

This function is the same as `sys.std.Core.Relation.has_member` except
that `t` must have one fewer attribute than `r` does, specifically
`tcount` (and otherwise they must have the same headings).

## sys.std.Counted.counted_has_not_member

`function counted_has_not_member (Bool <--
r : Relation, t : Tuple, count_attr_name : Name) {...}`

This function is exactly the same as `sys.std.Counted.counted_has_member`
except that it results in the opposite boolean value when given the same
arguments.

## sys.std.Counted.counted_insertion

`function counted_insertion (Relation <-- r : Relation,
t : Tuple, count_attr_name : Name) {...}`

This function is the same as `sys.std.Core.Relation.insertion` as per
`counted_has_member` but that its result differs depending on whether `t`
already exists in `r`; if it does, then no new tuple is added, but the
`tcount` attribute for the matching tuple is incremented by 1; if it
does not, then a new tuple is added where its `tattrs` is `t` and its
`tcount` is 1.  Actually this function differs in another way, such that
it is semantically the single-tuple case of
`sys.std.Counted.counted_union_sum`, and is not the single-tuple case of
`sys.std.Counted.counted_union` (which is the direct analogy to set
union).

## sys.std.Counted.counted_deletion

`function counted_deletion (Relation <-- r : Relation,
t : Tuple, count_attr_name : Name) {...}`

This function is the same as `sys.std.Core.Relation.deletion` as per
`counted_has_member` but that its result differs depending on what the
`tcount` for any tuple matching `t` that already exists in `r` is; if
the `tcount` is greater than 1, then it is decremented by 1; if it is
equal to 1, then the tuple whose `tattrs` is `t` is deleted.

## sys.std.Counted.counted_projection

`function counted_projection (Relation <-- topic : Relation,
attr_names : set_of.Name, count_attr_name : Name) {...}`

This function is the same as `sys.std.Core.Relation.projection` except
that the `counted_cardinality` of the result is guaranteed to be the same
as that of `topic` rather than possibly less.  The `topic` argument must
have a `tcount` attribute and `attr_names` must not specify that
attribute; the result has the just attributes of `topic` named by
`attr_names` plus the `tcount` attribute.

## sys.std.Counted.counted_cmpl_proj

`function counted_cmpl_proj (Relation <-- topic : Relation,
attr_names : set_of.Name, count_attr_name : Name) {...}`

This function is the same as `sys.std.Core.Relation.cmpl_proj`
except that the `counted_cardinality` of the result is guaranteed to be
the same as that of `topic` rather than possibly less.  The `topic`
argument must have a `tcount` attribute and `attr_names` must not specify
that attribute; the result has the just the attributes of `topic` not
named by `attr_names` including the `tcount` attribute.

## sys.std.Counted.counted_reduction

`function counted_reduction (Tuple <-- topic : Relation,
func : ValRedPFuncNC, identity : Tuple, count_attr_name : Name) {...}`

This function is the same as `sys.std.Core.Relation.reduction` except that
`func` is invoked extra times, where both its `v1` and `v2` arguments
might be different instances of the same `tattrs` tuple having >= 2
multiplicity.  This function's `topic` argument has a `tcount` attribute
while its `identity` argument does not, and both the result tuple of
`func` and its `v1` and `v2` arguments don't have the `tcount`
attribute either.

## sys.std.Counted.counted_map

`function counted_map (Relation <-- topic : Relation,
result_attr_names : set_of.Name, func : ValMapPFuncNC,
count_attr_name : Name) {...}`

This function is the same as `sys.std.Core.Relation.map` except that the
`counted_cardinality` of the result is guaranteed to be the same as that
of `topic` rather than possibly less.  The `topic` argument must have a
`tcount` attribute and `result_attr_names` must not specify that
attribute; the result has the attributes named in `result_attr_names` plus
the `tcount` attribute.  Both the result tuple of `func` and its
`topic` argument don't have the `tcount` attribute.

## sys.std.Counted.counted_is_subset

`function counted_is_subset (Bool <--
topic : Relation, other : Relation, count_attr_name : Name) {...}`

This function is like `sys.std.Core.Relation.is_subset` but that it
accounts for the greater-than-one multiplicity of `tattrs` in its
`topic` and `other` arguments, both of which have a `tcount`
attribute; this function returns `Bool:True` iff the multiplicity of each
`topic` value is less than or equal to the multiplicity of its
counterpart `other` value.

## sys.std.Counted.counted_is_not_subset

`function counted_is_not_subset (Bool <--
topic : Relation, other : Relation, count_attr_name : Name) {...}`

This function is like `sys.std.Core.Relation.is_not_subset` as per
`counted_is_subset`.

## sys.std.Counted.counted_is_superset

`function counted_is_superset (Bool <--
topic : Relation, other : Relation, count_attr_name : Name) {...}`

This function is an alias for `sys.std.Counted.counted_is_subset` except
that it transposes the `topic` and `other` arguments.  This function is
like `sys.std.Core.Relation.is_superset` but that it accounts for the
greater-than-one multiplicity of `tattrs` in its `topic` and `other`
arguments, both of which have a `tcount` attribute; this function returns
`Bool:True` iff the multiplicity of each `topic` value is greater than or
equal to the multiplicity of its counterpart `other` value.

## sys.std.Counted.counted_is_not_superset

`function counted_is_not_superset (Bool <--
topic : Relation, other : Relation, count_attr_name : Name) {...}`

This function is an alias for `sys.std.Counted.counted_is_not_subset`
except that it transposes the `topic` and `other` arguments.  This
function is like `sys.std.Core.Relation.is_not_superset` as per
`counted_is_superset`.

## sys.std.Counted.counted_is_proper_subset

`function counted_is_proper_subset (Bool <--
topic : Relation, other : Relation, count_attr_name : Name) {...}`

This function is like `sys.std.Core.Relation.is_proper_subset` as per
`counted_is_subset`.  *What is its definition?*

## sys.std.Counted.counted_is_not_proper_subset

`function counted_is_not_proper_subset (Bool <--
topic : Relation, other : Relation, count_attr_name : Name) {...}`

This function is like `sys.std.Core.Relation.is_not_proper_subset` as per
`counted_is_subset`.  *What is its definition?*

## sys.std.Counted.counted_is_proper_superset

`function counted_is_proper_superset (Bool <--
topic : Relation, other : Relation, count_attr_name : Name) {...}`

This function is an alias for `sys.std.Counted.counted_is_proper_subset`
except that it transposes the `topic` and `other` arguments.  This
function is like `sys.std.Core.Relation.is_proper_superset` as per
`counted_is_superset`.

## sys.std.Counted.counted_is_not_proper_superset

`function counted_is_not_proper_superset (Bool <--
topic : Relation, other : Relation, count_attr_name : Name) {...}`

This function is an alias for
`sys.std.Counted.counted_is_not_proper_subset` except that it transposes
the `topic` and `other` arguments.  This function is like
`sys.std.Core.Relation.is_not_proper_superset` as per
`counted_is_superset`.

## sys.std.Counted.counted_union

`function counted_union (Relation <--
topic : set_of.Relation, count_attr_name : Name) {...}`

This function is like `sys.std.Core.Relation.union` but that it just
looks at the `tattrs` attributes of its argument elements when determining
what element tuples correspond; then for each tuple in the result, its
`tcount` attribute value is the maximum of the `tcount` attribute values
of its corresponding input element tuples.

## sys.std.Counted.counted_union_sum

`function counted_union_sum (Relation <--
topic : bag_of.Relation, count_attr_name : Name) {...}`

This function is like `sys.std.Counted.counted_union` but that for each
pair of argument elements being unioned, the output `tcount` value is the
sum of the input `tcount` values rather than being the maximum of the
inputs.  This function is the nearest Muldis Data Language analogy to the SQL "UNION
ALL" operation, versus `sys.std.Core.Relation.union` which is the nearest
analogy to "UNION DISTINCT".

## sys.std.Counted.counted_intersection

`function counted_intersection (Relation <--
topic : set_of.Relation, count_attr_name : Name) {...}`

This function is like `sys.std.Core.Relation.intersection` as
`counted_union` is like `sys.std.Core.Relation.union`; the minimum of
`tcount` attribute values is used rather than the maximum.

## sys.std.Counted.counted_diff

`function counted_diff (Relation <--
source : Relation, filter : Relation, count_attr_name : Name) {...}`

This function is like `sys.std.Core.Relation.diff` as `counted_union` is
like `sys.std.Core.Relation.union`; for corresponding input tuples, the
result only has a tuple with the same `tattrs` if the `tcount` of the
`source` tuple is greater than the `tcount` of the `filter` tuple, and
the `tcount` of the result tuple is the difference of those two.

## sys.std.Counted.counted_substitution

`function counted_substitution (Relation <--
topic : Relation, attr_names : set_of.Name, func : ValMapPFuncNC,
count_attr_name : Name) {...}`

This function is the same as `sys.std.Core.Relation.substitution` except
that the `counted_cardinality` of the result is guaranteed to be the same
as that of `topic` rather than possibly less.  The `topic` argument must
have a `tcount` attribute and `attr_names` must not specify that
attribute.

## sys.std.Counted.counted_static_subst

`function counted_static_subst (Relation <--
topic : Relation, attrs : Tuple, count_attr_name : Name) {...}`

This function is the same as `sys.std.Core.Relation.static_subst`
except that the `counted_cardinality` of the result is guaranteed to be
the same as that of `topic` rather than possibly less.  The `topic`
argument must have a `tcount` attribute and `attrs` must not have that
attribute.

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Data Language** (**MDL**).

MDL is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
