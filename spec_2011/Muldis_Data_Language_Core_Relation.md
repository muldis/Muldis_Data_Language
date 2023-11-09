# NAME

Muldis Data Language Core Relation - Muldis Data Language generic relational operators

# VERSION

This document is Muldis Data Language Core Relation version 0.148.1.

# PREFACE

This document is part of the Muldis Data Language language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

This document describes essentially all of the core Muldis Data Language generic
relational operators (for generic relations).

*This documentation is pending.*

# FUNCTIONS IMPLEMENTING VIRTUAL ATTRIBUTIVE FUNCTIONS

## sys.std.Core.Relation.degree

`function degree (NNInt <-- topic : Relation)
implements sys.std.Core.Attributive.degree {...}`

This function results in the degree of its argument (that is, the count of
attributes it has).

## sys.std.Core.Relation.is_nullary

`function is_nullary (Bool <-- topic : Relation)
implements sys.std.Core.Attributive.is_nullary {...}`

This function results in `Bool:True` iff its argument has a degree of zero
(that is, it has zero attributes), and `Bool:False` otherwise.  By
definition, the only 2 relation values for which this function would
result in `Bool:True` are the values `Relation:D0C[0|1]`.

## sys.std.Core.Relation.is_not_nullary

`function is_not_nullary (Bool <-- topic : Relation)
implements sys.std.Core.Attributive.is_not_nullary {...}`

This function is exactly the same as `sys.std.Core.Relation.is_nullary`
except
that it results in the opposite boolean value when given the same argument.

## sys.std.Core.Relation.has_attrs

`function has_attrs (Bool <-- topic : Relation,
attr_names : set_of.Name)
implements sys.std.Core.Attributive.has_attrs {...}`

This function results in `Bool:True` iff, for every one of the attribute
names specified by its `attr_names` argument, its `topic` argument has an
attribute with that name; otherwise it results in `Bool:False`.  As a
trivial case, this function's result is `Bool:True` if `attr_names` is
empty.

## sys.std.Core.Relation.attr_names

`function attr_names (set_of.Name <-- topic : Relation)
implements sys.std.Core.Attributive.attr_names {...}`

This function results in the set of the names of the attributes of its
argument.

## sys.std.Core.Relation.rename

`function rename (Relation <-- topic : Relation, map : AttrRenameMap)
implements sys.std.Core.Attributive.rename {...}`

This function is the same as `sys.std.Core.Tuple.rename` but that it
operates on and results in a `Relation` rather than a `Tuple`.

## sys.std.Core.Relation.projection

`function projection (Relation <--
topic : Relation, attr_names : set_of.Name)
implements sys.std.Core.Attributive.projection {...}`

This function is the same as `sys.std.Core.Tuple.projection` but that it
operates on and results in a `Relation` rather than a `Tuple`.  But
note that the result relation will have fewer tuples than `topic` if
any `topic` tuples were non-distinct for just the projected attributes.

## sys.std.Core.Relation.cmpl_proj

`function cmpl_proj (Relation <--
topic : Relation, attr_names : set_of.Name)
implements sys.std.Core.Attributive.cmpl_proj {...}`

This function is the same as `sys.std.Core.Tuple.cmpl_proj` but
that it operates on and results in a `Relation` rather than a `Tuple`.

## sys.std.Core.Relation.static_exten

`function static_exten (Relation <-- topic : Relation, attrs : Tuple)
implements sys.std.Core.Attributive.static_exten {...}`

This function is a simpler-syntax alternative to both
`sys.std.Core.Relation.extension` and `sys.std.Core.Relation.product`
in the typical scenario of extending a relation, given in the `topic`
argument, such that every tuple has mutually identical values for each of
the new attributes; the new attribute names and common values are given in
the `attrs` argument.

## sys.std.Core.Relation.wrap

`function wrap (Relation <-- topic : Relation, outer : Name,
inner : set_of.Name) implements sys.std.Core.Attributive.wrap {...}`

This function is the same as `sys.std.Core.Tuple.wrap` but that it
operates on and results in a `Relation` rather than a `Tuple`, where
each of its member tuples was transformed as per
`sys.std.Core.Tuple.wrap`.  The result relation has the same cardinality
as `topic`.

## sys.std.Core.Relation.cmpl_wrap

`function cmpl_wrap (Relation <--
topic : Relation, outer : Name, cmpl_inner : set_of.Name)
implements sys.std.Core.Attributive.cmpl_wrap {...}`

This function is the same as `sys.std.Core.Tuple.cmpl_wrap` but that it
operates on and results in a `Relation` rather than a `Tuple`, where
each of its member tuples was transformed as per
`sys.std.Core.Tuple.cmpl_wrap`.

## sys.std.Core.Relation.unwrap

`function unwrap (Relation <-- topic : Relation, inner : set_of.Name,
outer : Name) implements sys.std.Core.Attributive.unwrap {...}`

This function is the inverse of `sys.std.Core.Relation.wrap` as
`sys.std.Core.Tuple.unwrap` is to `sys.std.Core.Tuple.wrap`.  But
unlike the simplest concept of a
`Tuple` variant of `unwrap`, this current function requires
the extra `inner` argument to prevent ambiguity in the general case where
`topic` might have zero tuples, because in that situation the
most-specific-type of `topic{outer}` would be `Empty`, and the names of
the attributes to add to `topic` in place of `topic{outer}` are not
known.  This function will fail if `topic` has at least 1 tuple and
`inner` does not match the names of the attributes of `topic{outer}`.
This function will fail with a non-`DHRelation` valued `topic` unless,
for every tuple of `topic`, the attribute specified by `outer` is valued
with a tuple of the same degree and heading (attribute names); this
failure is because there would be no consistent set of attribute names to
extend `topic` with (a problem that would never happen by definition with
a deeply homogeneous relation `topic`).

# GENERIC RELATIONAL FUNCTIONS WITH SINGLE INPUT RELATION

These functions are applicable to mainly relation types, but are generic
in that they typically work with any relation types.

## sys.std.Core.Relation.D0C0

`function D0C0 (Relation <--) {...}`

This `named-value` selector function results in the only zero-attribute,
zero-tuple Relation value, which is known by the special name
`Relation:D0C0`, aka `D0C0`.  Note that *The Third Manifesto* also
refers to this value by the special shorthand name *TABLE_DUM*.

## sys.std.Core.Relation.D0C1

`function D0C1 (Relation <--) {...}`

This `named-value` selector function results in the only zero-attribute,
single-tuple Relation value, which is known by the special name
`Relation:D0C1`, aka `D0C1`.  Note that *The Third Manifesto* also
refers to this value by the special shorthand name *TABLE_DEE*.

## sys.std.Core.Relation.cardinality

`function cardinality (NNInt <-- topic : Relation) {...}`

This function results in the cardinality of its argument (that is, the
count of tuples its body has).  Note that this operation is also known as
*count* or `#`.

## sys.std.Core.Relation.count

`function count (NNInt <-- topic : Relation) {...}`

This function is an alias for `sys.std.Core.Relation.cardinality`.

## sys.std.Core.Relation.is_empty

`function is_empty (Bool <-- topic : Relation) {...}`

This function results in `Bool:True` iff its argument has a cardinality of
zero (that is, it has zero tuples), and `Bool:False` otherwise.  Note
that if you are using a `Maybe` to represent a sparse data item,
analogously to a SQL nullable context, then testing the `Maybe` with
`is_empty` is analogous to testing a SQL nullable with `is null`.

## sys.std.Core.Relation.is_not_empty

`function is_not_empty (Bool <-- topic : Relation) {...}`

This function is exactly the same as `sys.std.Core.Relation.is_empty`
except that it results in the opposite boolean value when given the same
argument.  And following the analogy with `is_empty`, `is_not_empty` is
analogous to SQL's `is not null`.

## sys.std.Core.Relation.has_member

`function has_member (Bool <-- r : Relation, t : Tuple) {...}`

This function results in `Bool:True` iff its `t` argument matches a
tuple of its `r` argument (that is, iff conceptually `t` is a member of
`r`), and `Bool:False` otherwise.  This function will warn if its 2
arguments' common-named attributes have declared types that are
incompatible as per `is_same`.  Note that this operation is also
known as `@∋` or `holds`.

## sys.std.Core.Relation.has_not_member

`function has_not_member (Bool <-- r : Relation, t : Tuple) {...}`

This function is exactly the same as `sys.std.Core.Relation.has_member`
except that it results in the opposite boolean value when given the same
arguments.  Note that this operation is also known as `@∌` or `!holds` or
`not-holds`.

## sys.std.Core.Relation.tuple_is_member

`function tuple_is_member (Bool <--
t : Tuple, r : Relation) {...}`

This function is an alias for `sys.std.Core.Relation.has_member`.  This
function results in `Bool:True` iff its `t` argument matches a tuple of
its `r` argument (that is, iff conceptually `t` is a member of `r`), and
`Bool:False` otherwise.  Note that this operation is also known as `∈@`
or `inside`.

## sys.std.Core.Relation.tuple_is_not_member

`function tuple_is_not_member (Bool <--
t : Tuple, r : Relation) {...}`

This function is an alias for `sys.std.Core.Relation.has_not_member`.
This function is exactly the same as
`sys.std.Core.Relation.tuple_is_member` except that it results in the
opposite boolean value when given the same arguments.  Note that this
operation is also known as `∉@` or `!inside` or `not-inside`.

## sys.std.Core.Relation.has_key

`function has_key (Bool <-- topic : Relation,
attr_names : set_of.Name) {...}`

This function results in `Bool:True` iff its `topic` argument has a
(unique) key over the subset of its attributes whose names are specified by
its `attr_names` argument; otherwise it results in `Bool:False`.  This
function will fail if `topic` does not have all of the attributes named by
`attr_names`.  As a trivial case, this function's result is `Bool:True`
if `topic` is empty.

## sys.std.Core.Relation.empty

`function empty (Relation <-- topic : Relation) {...}`

This function results in the empty relation of the same heading of its
argument, that is having the same degree and attribute names; it has zero
tuples.

## sys.std.Core.Relation.insertion

`function insertion (Relation <-- r : Relation, t : Tuple) {...}`

This function results in a `Relation` that is the relational union of
`r` and a relation whose sole tuple is `t`; that is, conceptually the
result is `t` inserted into `r`.  As a trivial case, if `t` already
exists in `r`, then the result is just `r`.

## sys.std.Core.Relation.disjoint_ins

`function disjoint_ins (Relation <-- r : Relation, t : Tuple) {...}`

This function is exactly the same as `sys.std.Core.Relation.insertion`
except that it will fail if `t` already exists in `r`.

## sys.std.Core.Relation.deletion

`function deletion (Relation <-- r : Relation, t : Tuple) {...}`

This function results in a `Relation` that is the relational difference
from `r` of a relation whose sole tuple is `t`; that is, conceptually
the result is `t` deleted from `r`.  As a trivial case, if `t` already
doesn't exist in `r`, then the result is just `r`.

## sys.std.Core.Relation.group

`function group (Relation <-- topic : Relation,
outer : Name, inner : set_of.Name) {...}`

This function is similar to `sys.std.Core.Relation.wrap` but that the
`topic` attribute-wrapping transformations result in new
`Relation`-typed attributes rather than new `Tuple`-typed attributes,
and moreover multiple `topic` tuples may be combined into fewer tuples
whose new `Relation`-typed attributes have multiple tuples.  This
function takes a relation of N tuples and divides the tuples into M
groups where all the tuples in a group have the same values in the
attributes which aren't being grouped (and distinct values in the
attributes that are being grouped); it then results in a new relation of
M tuples where the new relation-valued attribute of the result has the
tuples of the M groups.  A grouped relation contains all of the
information in the original relation, but it has less redundancy due to
redundant non-grouped attributes now just being represented in one tuple
per the multiple tuples whose grouped attributes had them in common.  A
relation having relation-valued attributes like this is a common way to
group so-called child tuples under their parents.  As a trivial case, if
`inner` is empty, then the result has all the same tuples and attributes
as before plus a new relation-typed attribute of degree zero whose value
per tuple is of cardinality one; or, if `inner` lists all attributes of
`topic`, then the result has a single tuple of a single attribute whose
value is the same as `topic` (except that the result has zero tuples when
`topic` does).  This function supports the new attribute having the same
name as an old one being grouped into it.  This function will fail if
`inner` specifies any attribute names that `topic` doesn't have, or if
`outer` is the same as `topic` attributes that aren't being grouped.
Note that this operation is also known as *nest* or `{@<-}`.

## sys.std.Core.Relation.cmpl_group

`function cmpl_group (Relation <--
topic : Relation, outer : Name, group_per : set_of.Name) {...}`

This function is the same as `group` but that it groups the complementary
subset of attributes of `topic` to those specified by `group_per`.  Note
that this operation is also known as `{@<-!}`.

## sys.std.Core.Relation.ungroup

`function ungroup (Relation <--
topic : Relation, inner : set_of.Name, outer : Name) {...}`

This function is the inverse of `sys.std.Core.Relation.group` as
`sys.std.Core.Relation.unwrap` is to `sys.std.Core.Relation.wrap`; it
will ungroup a `Relation`-type attribute into its member attributes and
tuples.  A relation can be first grouped and then that result ungrouped to
produce the original relation, with no data loss.  However, the ungroup of
a relation on a relation-valued attribute will lose the information in any
outer relation tuples whose inner relation value has zero tuples; a group
on this result won't bring them back.  This function will fail if `outer`
specifies any attribute name that `topic` doesn't have, or if an attribute
of `topic{outer}` has the same name as another `topic` attribute.  This
function will fail with a non-`DHRelation` valued `topic` unless, for
every tuple of `topic`, the attribute specified by `outer` is valued with
a relation of the same degree and heading (attribute names); this failure
is because there would be no consistent set of attribute names to extend
`topic` with (a problem that would never happen by definition with a
deeply homogeneous relation `topic`).  Note that this operation is also
known as *unnest* or `{<-@}`.

## sys.std.Core.Relation.power_set

`function power_set (set_of.Relation <-- topic : Relation) {...}`

This function results in the power set of its argument.  The result is a
`Set` whose sole attribute is `Relation`-typed (its type is nominally
the same as that of the argument) and which has a tuple for every
distinct subset of tuples in the argument.  The cardinality of the result
is equal to 2 raised to the power of the cardinality of the argument (which
may easily lead to a very large result, so use this function with care).
Note that the N-adic relational union of the power set of some relation
is that relation; the N-adic intersection of any power set is the empty
relation.

## sys.std.Core.Relation.tclose

`function tclose (Relation <-- topic : Relation) {...}`

This function results in the transitive closure of its argument.  The
argument must be a binary relation whose attributes are both of the same
type, and the result is a relation having the same heading and a body
which is a superset of the argument's tuples.  Assuming that the argument
represents all of the node pairs in a directed graph that have an arc
between them, and so each argument tuple represents an arc, `tclose`
will determine all of the node pairs in that graph which have a path
between them (a recursive operation), so each tuple of the result
represents a path.  The result is a superset since all arcs are also
complete paths.  The `tclose` function is intended to support recursive
queries, such as in connection with the "part explosion problem" (the
problem of finding all components, at all levels, of some specified part).

## sys.std.Core.Relation.restriction

`function restriction (Relation <--
topic : Relation, func : ValFiltPFuncNC) {...}`

This function results in the relational restriction of its `topic`
argument as determined by applying the `value-filter` function named in
its `func` argument.  The result relation has the same heading as
`topic`, and its body contains the subset of `topic` tuples where, for
each tuple, the function named by `func` results in `Bool:True` when
passed the tuple as its `topic` argument.  As a trivial case, if `func`
is defined to unconditionally result in `Bool:True`, then this function
results simply in `topic`; or, for an unconditional `Bool:False`, this
function results in the empty relation with the same heading.  Note that
this operation is also known as `where`.  See also the
`sys.std.Core.Relation.semijoin` function, which is a simpler-syntax
alternative for `sys.std.Core.Relation.restriction` in its typical usage
where restrictions are composed simply of anded or ored tests for attribute
value equality.

## sys.std.Core.Relation.restr_and_cmpl

`function restr_and_cmpl (Tuple <--
topic : Relation, func : ValFiltPFuncNC) {...}`

This function performs a 2-way partitioning of all the tuples of `topic`
and results in a binary tuple whose attribute values are each relations
that have the same heading as `topic` and complementary subsets of its
tuples; the 2 result attributes have the names `pass` and `fail`, and
their values are what `sys.std.Core.Relation.restriction` and
`sys.std.Core.Relation.cmpl_restr`, respectively, would result in
when given the same arguments.

## sys.std.Core.Relation.cmpl_restr

`function cmpl_restr (Relation <--
topic : Relation, func : ValFiltPFuncNC) {...}`

This function is the same as `restriction` but that it results in the
complementary subset of tuples of `topic` when given the same arguments.
See also the `sys.std.Core.Relation.semidiff` function.  Note that this
operation is also known as `!where` or `not-where`.

## sys.std.Core.Relation.classification

`function classification (Relation <--
topic : Relation, func : ValMapPFuncNC, class_attr_name : Name,
group_attr_name : Name) {...}`

This function conceptually is to `sys.std.Core.Relation.restriction` what
`sys.std.Core.Relation.group` is to `sys.std.Core.Relation.semijoin`.
It classifies the tuples of `topic` into N groups using the `value-map`
function named by `func`, such that any distinct tuples are in a common
group if the function named by `func` results in the same value when given
either of those tuples as its `topic`
argument.  This function conceptually is a short-hand for first
extending `topic` with a new attribute whose name is given in
`class_attr_name`, whose value per tuple is determined from `topic` using
`func`, and then grouping that result relation on all of
its original attributes, with the post-group RVA having the name given in
`group_attr_name`; the result of `classification` is a binary relation
whose 2 attributes have the names given in `class_attr_name` and
`group_attr_name`.  This function is intended for use when you want to
partition a relation's tuples into an arbitrary number of groups using
arbitrary criteria, in contrast with `restriction` where you are dividing
into exactly 2 groups (and returning one) using arbitrary criteria.

## sys.std.Core.Relation.extension

`function extension (Relation <--
topic : Relation, attr_names : set_of.Name, func : ValMapPFuncNC) {...}`

This function results in the relational extension of its `topic` argument
as determined by applying the `Tuple`-resulting `value-map` function
named in its `func`
argument.  The result relation has a heading that is a superset of that
of `topic`, and its body contains the same number of tuples, with all
attribute values of `topic` retained, and possibly extra present,
determined as follows; for each `topic` tuple, the function named by
`func` results in a second tuple when passed the first tuple as its
`topic` argument; the first
and second tuples must have no attribute names in common, and the result
tuple is derived by joining (cross-product) the tuples together.  As a
trivial case, if `func` is defined to unconditionally result in the
degree-zero tuple, then this function results simply in `topic`.  Now,
`extension` requires the extra `attr_names` argument to prevent ambiguity
in the general case where `topic` might have zero tuples, because in
that situation, `func` would never be invoked, and the names of the
attributes to add to `topic` are not known (we don't generally assume that
`extension` can reverse-engineer `func` to see what attributes it would
have resulted in).  This function will fail if `topic` has at least 1
tuple and the result of `func` does not have matching attribute names to
those named by `attr_names`.

## sys.std.Core.Relation.map

`function map (Relation <-- topic : Relation,
result_attr_names : set_of.Name, func : ValMapPFuncNC) {...}`

This function provides a convenient one-place generalization of per-tuple
transformations that otherwise might require the chaining of up to a
half-dozen other operators like projection, extension, and rename.  This
function results in a relation each of whose tuples is the result of
applying, to each of the tuples of its `topic` argument, the
`Tuple`-resulting `value-map` function named in its `func`
argument.  There is no restriction
on what attributes the result tuple of `func` may have (except that all
tuples from `func` must have compatible headings); this tuple from
`func` would completely replace the original tuple from `topic`.  The
result relation has a cardinality that is the same as that of `topic`,
unless the result of `func` was redundant tuples, in which case the
result has appropriately fewer tuples.  As a trivial case, if `func` is
defined to unconditionally result in the same tuple as its own `topic`
argument, then this function results simply in `topic`; or, if `func` is
defined to have a static result, then this function's result will have just
0..1 tuples.  Now, `map` requires the extra `result_attr_names`
argument to prevent ambiguity in the general case where `topic` might have
zero tuples, because in that situation, `func` would never be invoked,
and the names of the attributes of the result are not known (we don't
generally assume that `map` can reverse-engineer `func` to see what
attributes it would have resulted in).  This function will fail if `topic`
has at least 1 tuple and the result of `func` does not have matching
attribute names to those named by `result_attr_names`.

## sys.std.Core.Relation.summary

`function summary (Relation <--
topic : Relation, group_per : set_of.Name,
summ_attr_names : set_of.Name, summ_func : ValMapPFuncNC) {...}`

This function provides a convenient context for using aggregate functions
to derive a per-group summary relation, which is its result, from another
relation, which is its `topic` argument.  This function first performs a
`cmpl_group` on `topic` using `group_per` to specify which attributes
get grouped into a new relation-valued attribute and which don't; those
that don't instead get wrapped into a tuple-valued attribute.  Then, per
binary tuple in the main relation, this function applies the
`Tuple`-resulting `value-map` function named in its `summ_func`
argument; for each post-group main relation
tuple, the function named in `summ_func` results in a second tuple when
the first tuple is its `topic` argument; the `topic` argument has the 2
attribute names `summarize` and `per`, which are valued with the
relation-valued attribute and
tuple-valued attribute, respectively.  As per a function that
`extension` applies, the function named by `summ_func` effectively takes
a whole post-grouping input tuple and results in a partial tuple that
would be joined by `summary` with the `per` tuple to get the result
tuple; the applied
function would directly invoke any N-adic/aggregate operators, and extract
their inputs from (or calculate) `summarize` as it sees fit.  Note that
`summary` is not intended to be used to summarize an entire `topic`
relation at once (except by chance of it resolving to 1 group); you
should instead invoke your summarize-all `summ_func` directly, or inline
it, rather than by way of `summary`, especially if you want a
single-tuple result on an empty `topic` (which `summary`) won't do.
Now, `summary` requires the extra `summ_attr_names` argument to prevent
ambiguity in the general case where `topic` might have zero tuples,
because in that situation, `summ_func` would never be invoked, and the
names of the attributes to add to `per` are not known (we don't generally
assume that `summary` can reverse-engineer `summ_func` to see what
attributes it would have resulted in).  This function will fail if `topic`
has at least 1 tuple and the result of `summ_func` does not have
matching attribute names to those named by `summ_attr_names`.

## sys.std.Core.Relation.cardinality_per_group

`function cardinality_per_group (Relation <--
topic : Relation, count_attr_name : Name, group_per : set_of.Name) {...}`

This function is a convenient shorthand for the common use of `summary`
that is just counting the tuples of each group.  This function is like
`cmpl_group` but that the single added attribute, rather than an RVA of
the grouped `topic` attributes, has the cardinality that said RVA would
have had.  The result's heading consists of the attributes named in
`group_per` plus the attribute named in `count_attr_name` (a `PInt`).
Note that this operation is also known as `{#@<-!}`.

## sys.std.Core.Relation.count_per_group

`function count_per_group (Relation <--
topic : Relation, count_attr_name : Name, group_per : set_of.Name) {...}`

This function is an alias for
`sys.std.Core.Relation.cardinality_per_group`.

## sys.std.Core.Relation.reduction

`function reduction (Tuple <-- topic : Relation,
func : ValRedPFuncNC, identity : Tuple) {...}`

This function is a generic reduction operator that recursively takes each
pair of tuples in `topic` and applies an argument-specified tuple
value-resulting `value-reduction` function (which is both commutative and
associative) to the pair until just one input tuple is left, which is the
result.  The `value-reduction` function to apply is named in the `func`
argument, and that function must have 2 parameters named `v1` and `v2`,
which take the 2 input tuples for an invocation.  If `topic` has zero
tuples, then `reduction` results in the tuple given in `identity`.
*Note that `identity` may be changed to take a function name rather than
a value, for consistency with `func`.*  This function will fail|warn if
the |declared headings of `identity` and `topic` aren't compatible.

# GENERIC RELATIONAL FUNCTIONS WITH MULTIPLE INPUT RELATIONS

These functions are applicable to mainly relation types, but are generic
in that they typically work with any relation types.

## sys.std.Core.Relation.is_subset

`function is_subset (Bool <--
topic : Relation, other : Relation) {...}`

This function results in `Bool:True` iff the set of tuples comprising
`topic` is a subset of the set of tuples comprising `other`, and
`Bool:False` otherwise.  This function will warn if the input relations
common-named attributes have declared types that are incompatible as per
`is_same`.  Note that this operation is also known as `⊆` or `{<=}`.

## sys.std.Core.Relation.is_not_subset

`function is_not_subset (Bool <--
topic : Relation, other : Relation) {...}`

This function is exactly the same as `sys.std.Core.Relation.is_subset`
except that it results in the opposite boolean value when given the same
arguments.  Note that this operation is also known as `⊈` or `{!<=}`.

## sys.std.Core.Relation.is_superset

`function is_superset (Bool <--
topic : Relation, other : Relation) {...}`

This function is an alias for `sys.std.Core.Relation.is_subset` except
that it transposes the `topic` and `other` arguments.  This function
results in `Bool:True` iff the set of tuples comprising `topic` is a
superset of the set of tuples comprising `other`, and `Bool:False`
otherwise.  Note that this operation is also known as `⊇` or `{>=}`.

## sys.std.Core.Relation.is_not_superset

`function is_not_superset (Bool <--
topic : Relation, other : Relation) {...}`

This function is an alias for `sys.std.Core.Relation.is_not_subset`
except that it transposes the `topic` and `other` arguments.  This
function is exactly the same as `sys.std.Core.Relation.is_superset`
except that it results in the opposite boolean value when given the same
arguments.  Note that this operation is also known as `⊉` or `{!>=}`.

## sys.std.Core.Relation.is_proper_subset

`function is_proper_subset (Bool <--
topic : Relation, other : Relation) {...}`

This function is exactly the same as `sys.std.Core.Relation.is_subset`
except that it results in `Bool:False` if its 2 arguments are identical.
Note that this operation is also known as `⊂` or `{<}`.

## sys.std.Core.Relation.is_not_proper_subset

`function is_not_proper_subset (Bool <--
topic : Relation, other : Relation) {...}`

This function is exactly the same as
`sys.std.Core.Relation.is_proper_subset`
except that it results in the opposite boolean value when given the same
arguments.  Note that this operation is also known as `⊄` or `{!<}`.

## sys.std.Core.Relation.is_proper_superset

`function is_proper_superset (Bool <--
topic : Relation, other : Relation) {...}`

This function is an alias for `sys.std.Core.Relation.is_proper_subset`
except
that it transposes the `topic` and `other` arguments.  This function
is exactly the same as `sys.std.Core.Relation.is_superset` except that it
results in `Bool:False` if its 2 arguments are identical.  Note that this
operation is also known as `⊃` or `{>}`.

## sys.std.Core.Relation.is_not_proper_superset

`function is_not_proper_superset (Bool <--
topic : Relation, other : Relation) {...}`

This function is an alias for `sys.std.Core.Relation.is_not_proper_subset`
except that it transposes the `topic` and `other` arguments.  This
function is exactly the same as `sys.std.Core.Relation.is_proper_superset`
except that it results in the opposite boolean value when given the same
arguments.  Note that this operation is also known as `⊅` or `{!>}`.

## sys.std.Core.Relation.is_disjoint

`function is_disjoint (Bool <-- topic : Relation,
other : Relation) {...}`

This symmetric function results in `Bool:True` iff the set of tuples
comprising each of its 2 arguments are mutually disjoint, that is, iff the
intersection of the 2 arguments is empty; it results in `Bool:False`
otherwise.

## sys.std.Core.Relation.is_not_disjoint

`function is_not_disjoint (Bool <--
topic : Relation, other : Relation) {...}`

This symmetric function is exactly the same as
`sys.std.Core.Relation.is_disjoint` except that it results in the opposite
boolean value when given the same arguments.

## sys.std.Core.Relation.union

`function union (Relation <-- topic : set_of.Relation) {...}`

This function results in the relational union/inclusive-or of the N element
values of its argument; it is a reduction operator that recursively takes
each pair of input values and relationally unions (which is commutative,
associative, and idempotent) them together until just one is left, which is
the result.  The result relation has the same heading as all of its
inputs, and its body contains every tuple that is in any of the input
relations.  If `topic` has zero values, then this function will fail.
Note that, conceptually `union` *does* have an identity value which could
be this function's result when `topic` has zero values, which is the empty
relation with the same heading, which is the per-distinct-heading identity
value for relational union; however, since a `topic` with zero values
wouldn't know the heading / attribute names for the result relation in
question, it seems the best alternative is to require invoking code to work
around the limitation somehow, which might mean it will supply the identity
value explicitly as an extra `topic` element.  Note that this operation is
also known as `∪`.

## sys.std.Core.Relation.disjoint_union

`function disjoint_union (Relation <-- topic : set_of.Relation) {...}`

This function is exactly the same as `sys.std.Core.Relation.union` except
that it will fail if any 2 input values have a tuple in common.

## sys.std.Core.Relation.exclusion

`function exclusion (Relation <-- topic : bag_of.Relation) {...}`

This function results in the relational exclusion/exclusive-or of the N
element values of its argument; it is a reduction operator that recursively
takes each pair of input values and relationally excludes (which is both
commutative and associative) them together until just one is left, which is
the result.  The result relation has the same heading as all of its
inputs, and its body contains every tuple that is in just an odd number
of the input relations.  Matters concerning a `topic` with zero values
are as per `sys.std.Core.Relation.union`; this function will fail when
given such, and the per-distinct-heading identity value for relational
exclusion is the same as for relational union.  Note that this operation is
also known as *symmetric difference* or `∆`.

## sys.std.Core.Relation.symmetric_diff

`function symmetric_diff (Relation <-- topic : bag_of.Relation) {...}`

This function is an alias for `sys.std.Core.Relation.exclusion`.

## sys.std.Core.Relation.intersection

`function intersection (Relation <-- topic : set_of.Relation) {...}`

This function results in the relational intersection/and of the N element
values of its argument; it is a reduction operator that recursively takes
each pair of input values and relationally intersects (which is
commutative, associative, and idempotent) them together until just one is
left, which is
the result.  The result relation has the same heading as all of its
inputs, and its body contains only the tuples that are in every one of
the input relations.  If `topic` has zero values, then this function
will fail.  Note that, conceptually `intersection` *does* have an
identity value which could be this function's result when `topic` has zero
values, which is the universal relation with the same heading (that is,
the relation having all the tuples that could ever exist in a
relation with that heading), which is the per-distinct-heading identity
value for relational intersection; however, since a `topic` with zero
values wouldn't know the heading / attribute names for the result
relation in question (and even if they were, more information on
attribute types would be needed to produce said universal relation, and
even then it might be infinite or impossibly large), it seems the best
alternative is to require invoking code to work around the limitation
somehow, which might mean it will supply the identity value explicitly as
an extra `topic` element.  Note that this *intersection* operator is
conceptually a special case of `join`, applicable when the headings of the
inputs are the same, and the other will produce the same result as this
when given the same inputs, but with the exception that *intersection* has
a different identity value when given zero inputs.  Note that this
operation is also known as `∩`.

## sys.std.Core.Relation.diff

`function diff (Relation <--
source : Relation, filter : Relation) {...}`

This function results in the relational difference when its `filter`
argument is subtracted from its `source` argument.  The result relation
has the same heading as both of its arguments, and its body contains only
the tuples that are in `source` and are not in `filter`.  This function
will warn if the input relations common-named attributes have declared
types that are incompatible as per `is_same`.  Note that this
*difference* operator is conceptually a special case of *semidiff*,
applicable when the headings of the inputs are the same.  Note that this
operation is also known as `minus` or `except` or `∖`.

## sys.std.Core.Relation.semidiff

`function semidiff (Relation <--
source : Relation, filter : Relation) {...}`

This function is the same as `semijoin` but that it results in the
complementary subset of tuples of `source` when given the same arguments.
Note that this operation is also known as `antijoin` or *anti-semijoin*
or `semiminus` or `!matching` or `not-matching` or `⊿`.

## sys.std.Core.Relation.antijoin

`function antijoin (Relation <--
source : Relation, filter : Relation) {...}`

This function is an alias for `sys.std.Core.Relation.semidiff`.

## sys.std.Core.Relation.semijoin_and_diff

`function semijoin_and_diff (Tuple <--
source : Relation, filter : Relation) {...}`

This function performs a 2-way partitioning of all the tuples of
`source` and results in a binary tuple whose attribute values are each
relations that have the same heading as `source` and complementary
subsets of its tuples; the 2 result attributes have the names `pass` and
`fail`, and their values are what `sys.std.Core.Relation.semijoin` and
`sys.std.Core.Relation.semidiff`, respectively, would result in
when given the same arguments.

## sys.std.Core.Relation.semijoin

`function semijoin (Relation <--
source : Relation, filter : Relation) {...}`

This function results in the relational semijoin of its `source` and
`filter` arguments.  The result relation has the same heading as
`source`, and its body contains the subset of `source` tuples that
match those of `filter` as per `join`.  Note that relational semijoin is
conceptually a short-hand for first doing an ordinary relational join
between its 2 arguments, and then performing a relational projection on all
of the attributes that just `source` has.  This function will fail|warn
any time that `join` would fail|warn on the same 2 input relations.
Note that this operation is also known as `matching` or `⋉`.

## sys.std.Core.Relation.join

`function join (Relation <-- topic? : set_of.Relation) {...}`

This function results in the relational join of the N element values of its
argument; it is a reduction operator that recursively takes each pair of
input values and relationally joins (which is commutative, associative, and
idempotent) them together until just one is left, which is the result.
The result relation has a heading that is a union of all of the headings
of its inputs, and its body is the result of first pairwise-matching every
tuple of each input relation with every tuple of each other input
relation, then where each member of a tuple pair has attribute names in
common, eliminating pairs where the values of those attributes differ and
unioning the remaining said tuple pairs, then eliminating any result
tuples that duplicate others.  If `topic` has zero values, then `join`
results in the nullary relation with one tuple, which is the identity
value for relational join.  As a trivial case, if any input relation has
zero tuples, then the function's result will too; or, if any input is the
nullary relation with one tuple, that input can be ignored (see
identity value); or, if any 2 inputs have no attribute names in common,
then the join of just those 2 is a cartesian product; or, if any 2 inputs
have all attribute names in common, then the join of just those 2 is an
intersection; or, if for 2 inputs, one's set of attribute names is a proper
subset of another's, then the join of just those two is a semijoin with the
former filtering the latter.  This function will warn if any input
relations have attributes with common names where their declared types
are incompatible as per `is_same`.  Note that this operation is also
known as *natural inner join* or `⋈`.

## sys.std.Core.Relation.product

`function product (Relation <-- topic? : set_of.Relation) {...}`

This function results in the relational cartesian/cross product of the N
element values of its argument; it is conceptually a special case of
`join` where all input relations have mutually distinct attribute names;
unlike `join`, `product` will fail if any inputs have attribute names in
common.  Note that this operation is also known as *cartesian join* or
`cross-join` or `×`.

## sys.std.Core.Relation.quotient

`function quotient (Relation <--
dividend : Relation, divisor : Relation) {...}`

This function results in the quotient when its `dividend` argument is
divided by its `divisor` argument using relational division.  Speaking
informally, say the relations `dividend` and `divisor` are called `A`
and `B`, and their attribute sets are respectively named `{X,Y}` and
`{Y}`, then the result relation has a heading composed of attributes
`{X}` (so the result and `divisor` headings are both complementary
subsets of the `dividend` heading); the result has all tuples `{X}`
such that a tuple `{X,Y}` appears in `A` for all tuples `{Y}`
appearing in `B`; that is, `(A ÷ B)` is shorthand for `(A{X} ∖
((A{X} × B) ∖ A){X})`.  Note that this operation is also known as
*divideby* or `÷`.

## sys.std.Core.Relation.composition

`function composition (Relation <--
topic : Relation, other : Relation) {...}`

This symmetric function results in the relational composition of its
2 arguments.  It is conceptually a short-hand for first doing
an ordinary relational join between its 2 arguments, and then performing a
relational projection on all of the attributes that only one of the
arguments has; that is, the result has all of and just the attributes that
were not involved in matching the tuples of the 2 arguments.  This
function will fail|warn any time that `join` would fail|warn on the same 2
input relations.

## sys.std.Core.Relation.join_with_group

`function join_with_group (Relation <--
primary : Relation, secondary : Relation, group_attr : Name) {...}`

This function is a short-hand for first taking a (natural inner) `join` of
its `primary` and `secondary` arguments, and then taking a `group` on
all of the attributes that only the `secondary` argument had, such that
the attribute resulting from the group has the name `group_attr`.  The
result has 1 tuple for every tuple of `primary` where at least 1
matching tuple exists in `secondary`.  This function will fail if
`group_attr` is the same name as any source attribute that wasn't grouped.
This function is a convenient tool for gathering both parent and child
records from a database using a single query while avoiding duplication of
the parent record values.

# FUNCTIONS FOR RELATIONAL RANKING AND QUOTAS

These additional functions are specific to supporting ranking and quotas.

## sys.std.Core.Relation.rank

`function rank (Relation <-- topic : Relation,
name : Name, ord_func : OrdDetPFuncNC, is_reverse_order? : Bool,
first_rank? : NNInt) {...}`

This function results in the relational extension of its `topic` argument
by a single `NNInt`-typed attribute whose name is provided by the `name`
argument, where the value of the new attribute for each tuple is the rank
of that tuple as determined by the (total) `order-determination`
function named in the `ord_func` argument when the latter function is
primed by the `is_reverse_order` argument.  The `order-determination`
function compares tuples, with each invocation of it getting a `topic`
tuple as each its `topic` and `other` arguments.  The new attribute of
`rank`'s result has the value of the `first_rank` argument (that defaults
to zero if not explicitly given) for its ranked-first tuple, and each
further consecutive ranked tuple has the next larger integer value.  Note
that `rank` provides the functionality of SQL's "RANK" feature but that
the result of `rank` is always a total ordering (as per a (total)
`order-determination` function) and so there is no "dense" / "not dense"
distinction (however a partial ordering can be implemented over it).  See
also the `sys.std.Core.Array.Array_from_wrap` function, which is the same
as `sys.std.Core.Relation.rank` but that it wraps the source tuples rather
than just adding an attribute to them.  The main purpose of the
`first_rank` parameter is to support `rank` being used as a sequence
generator to attach non-descriptive id attributes to a set of tuples that
are about to be added to a database, where we want to start the sequence
larger than the largest id value already in use there; granted, for that
purpose the new ids don't have to be ordered, just distinct, but ordering
is necessary for this setwise operation to remain deterministic.

## sys.std.Core.Relation.rank_by_attr_names

`function rank_by_attr_names (Relation <--
topic : Relation, name : Name, order_by : array_of.OrderByName,
is_reverse_order? : Bool, first_rank? : NNInt) {...}`

This function is a short-hand for invoking `rank` with the function
`sys.std.Core.Tuple.order_by_attr_names` as its `ord_func` argument after
the latter is primed with this function's `order_by` argument.

## sys.std.Core.Relation.limit

`function limit (Relation <-- topic : Relation,
ord_func : OrdDetPFuncNC, is_reverse_order? : Bool,
rank_interval : sp_interval_of.NNInt) {...}`

This function results in the relational restriction of its `topic`
argument as determined by first ranking its tuples as per the `rank`
function (using `ord_func` and `is_reverse_order`) and then keeping just
those tuples whose rank is included within the interval specified by the
`rank_interval` argument (`rank`'s extra attribute is not kept).  The
`limit` function implements a certain kind of quota query where all the
result tuples are consecutive in their ranks.  It is valid for the lowest
and highest rank specified by `rank_interval` to be greater than the
maximum rank of the source tuples; in the first case, the result has zero
tuples; in the second case, the result has all remaining tuples starting at
the lowest rank, if any.  Note that `limit` provides the functionality of
SQL's "LIMIT/OFFSET" feature in combination with "ORDER BY" but that the
result tuples of `limit` do not remain ordered (but see
`sys.std.Core.Array.limit_of_Array_from_wrap` for an alternative).

## sys.std.Core.Relation.limit_by_attr_names

`function limit_by_attr_names (Relation <--
topic : Relation, order_by : array_of.OrderByName,
is_reverse_order? : Bool, rank_interval : sp_interval_of.NNInt) {...}`

This function is to `limit` what `rank_by_attr_names` is to `rank`.

# FUNCTIONS FOR RELATIONAL ATTRIBUTE VALUE SUBSTITUTIONS

These additional functions are specific to supporting substitutions.

## sys.std.Core.Relation.substitution

`function substitution (Relation <--
topic : Relation, attr_names : set_of.Name, func : ValMapPFuncNC) {...}`

This function is similar to `extension` except that it substitutes values
of existing relation attributes rather than adding new attributes.  The
result relation has the same heading as `topic`.  The result tuple of
the `value-map` function named in `func` must have a heading that is a
subset of the
heading of `topic`; corresponding values resulting from the function named
in `func` will replace the values of the tuples of `topic`.  The result
relation has a cardinality that is the same as that of `topic`, unless
the result of any substitutions was redundant tuples, in which case the
result has appropriately fewer tuples.  As a trivial case, if `func` is
defined to unconditionally result in either the degree-zero tuple or in the
same tuple as its own `topic` argument, then this function results
simply in `topic`; or, if `func` is defined to have a static result and
it replaces all attributes, then this function's result will have just 0..1
tuples.  Now, strictly speaking, `substitution` could conceivably be
implemented such that each result from `func` is allowed to specify
replacement values for different subsets of `topic` attributes; however,
to improve the function's predictability and ease of implementation over
disparate foundations, `substitution` requires the extra `attr_names`
argument so that users can specify a consistent subset that `func` will
update (possibly to itself).  This function will fail if `topic` has at
least 1 tuple and the result of `func` does not have matching attribute
names to those named by `attr_names`.

## sys.std.Core.Relation.static_subst

`function static_subst (Relation <--
topic : Relation, attrs : Tuple) {...}`

This function is a simpler-syntax alternative to
`sys.std.Core.Relation.substitution` in the typical scenario where every
tuple of a relation, given in the `topic` argument, is updated with
identical values for the same attributes; the new attribute values are
given in the `attrs` argument.

## sys.std.Core.Relation.subst_in_restr

`function subst_in_restr (Relation <--
topic : Relation, restr_func : ValFiltPFuncNC,
subst_attr_names : set_of.Name, subst_func : ValMapPFuncNC) {...}`

This function is like `substitution` except that it only transforms a
subset of the tuples of `topic` rather than all of them.  It is a
short-hand for first separating the tuples of `topic` into 2 groups
where those passed by a relational restriction (defined by `restr_func`)
are then transformed (defined by
`subst_attr_names` and `subst_func`), then the result
of the substitution is unioned with the un-transformed group.  See also the
`subst_in_semijoin` function, which is a simpler-syntax alternative for
`subst_in_restr` in its typical usage where restrictions are composed
simply of anded or ored tests for attribute value equality.

## sys.std.Core.Relation.static_subst_in_restr

`function static_subst_in_restr (Relation <--
topic : Relation, restr_func : ValFiltPFuncNC, subst : Tuple) {...}`

This function is to `sys.std.Core.Relation.subst_in_restr` what
`sys.std.Core.Relation.static_subst` is to
`sys.std.Core.Relation.substitution`.  See also the
`static_subst_in_semijoin` function.

## sys.std.Core.Relation.subst_in_semijoin

`function subst_in_semijoin (Relation <--
topic : Relation, restr : Relation, subst_attr_names : set_of.Name,
subst_func : ValMapPFuncNC) {...}`

This function is like `subst_in_restr` except that the subset of the
tuples of `topic` to be transformed is determined by those matched by a
semijoin with `restr` rather than those that pass a generic relational
restriction.

## sys.std.Core.Relation.static_subst_in_semijoin

`function static_subst_in_semijoin (Relation <--
topic : Relation, restr : Relation, subst : Tuple) {...}`

This function is to `sys.std.Core.Relation.subst_in_semijoin` what
`sys.std.Core.Relation.static_subst` is to
`sys.std.Core.Relation.substitution`.

# FUNCTIONS FOR RELATIONAL OUTER-JOINS

These additional functions are specific to supporting outer-joins.

## sys.std.Core.Relation.outer_join_with_group

`function outer_join_with_group (Relation <--
primary : Relation, secondary : Relation, group_attr : Name) {...}`

This function is the same as `sys.std.Core.Relation.join_with_group`
except that it results in a half-outer natural join rather than an inner
natural join; every tuple of `primary` has exactly 1 corresponding tuple
in the result, but where there were no matching `secondary` tuples, the
result attribute named by `group_attr` contains zero tuples rather than
1+.

## sys.std.Core.Relation.outer_join_with_maybes

`function outer_join_with_maybes (Relation <--
primary : Relation, secondary : Relation) {...}`

This function results in a plain half-outer natural join of its `primary`
and `secondary` arguments where all the result attributes that come from
just `secondary` are `Maybe`-typed; for result tuples from matched
source tuples, each `secondary` attribute value is a `Just`; for
result tuples from non-matched `primary` tuples, each `secondary`
attribute value is `Nothing`.  The `outer_join_with_maybes` function is
Muldis Data Language's answer to the SQL LEFT OUTER JOIN where SQL NULL is implicitly
used in result rows that were a non-match.

## sys.std.Core.Relation.outer_join_with_defaults

`function outer_join_with_defaults (Relation <--
primary : Relation, secondary : Relation, filler : APTypeNC) {...}`

This function is the same as
`sys.std.Core.Relation.outer_join_with_static_exten` but that the filler
tuple is the default value of the tuple data type whose name is given
in the `filler` argument.  This function is a short-hand for invoking
`outer_join_with_static_exten` with the result from invoking
`sys.std.Core.Universal.default`.

## sys.std.Core.Relation.outer_join_with_static_exten

`function outer_join_with_static_exten (Relation <-- primary : Relation,
secondary : Relation, filler : Tuple) {...}`

This function is the same as
`sys.std.Core.Relation.outer_join_with_maybes`
but that `secondary`-sourced result attributes are not converted to
`Maybe`; rather, for result tuples from non-matches, the missing values
are provided explicitly from the `filler` argument, which is a tuple
whose heading matches the projection of `secondary`'s attributes that
aren't in common with `primary`, and whose body is the specific values to
use for those missing attribute values.

## sys.std.Core.Relation.outer_join_with_exten

`function outer_join_with_exten (Relation <-- primary : Relation,
secondary : Relation, exten_func : ValMapPFuncNC) {...}`

This function is the same as
`sys.std.Core.Relation.outer_join_with_static_exten` but that the result
tuples from non-matches are the result of performing a relational
extension on the un-matched `primary` tuples such that each said result
tuple is determined by applying the function named in `exten_func` to
each said `primary` tuple.

# UPDATERS IMPLEMENTING VIRTUAL ATTRIBUTIVE UPDATERS

# Updaters That Rename Attributes

## sys.std.Core.Relation.assign_rename

`updater assign_rename (&topic : Relation, map : AttrRenameMap)
implements sys.std.Core.Attributive.assign_rename {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Relation.rename` function with the same arguments, and then
assigning the result of that function to `topic`.  This procedure is
analogous to the data-manipulation phase of a SQL ALTER TABLE|VIEW RENAME
COLUMN statement; each tuple of `map` corresponds to a renamed SQL table
column.

# Updaters That Add Attributes

## sys.std.Core.Relation.assign_static_exten

`updater assign_static_exten (&topic : Relation, attrs : Tuple)
implements sys.std.Core.Attributive.assign_static_exten {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Relation.static_exten` function with the same
arguments, and then assigning the result of that function to `topic`.
This procedure is analogous to the data-manipulation phase of a SQL ALTER
TABLE|VIEW ADD COLUMN statement; each attribute of `attrs` corresponds to
an added SQL table column.

# Updaters That Remove Attributes

## sys.std.Core.Relation.assign_projection

`updater assign_projection (&topic : Relation, attr_names : set_of.Name)
implements sys.std.Core.Attributive.assign_projection {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Relation.projection` function with the same arguments, and
then assigning the result of that function to `topic`.

## sys.std.Core.Relation.assign_cmpl_proj

`updater assign_cmpl_proj (&topic : Relation, attr_names : set_of.Name)
implements sys.std.Core.Attributive.assign_cmpl_proj {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Relation.cmpl_proj` function with the same arguments,
and then assigning the result of that function to `topic`.  This procedure
is analogous to the data-manipulation phase of a SQL ALTER TABLE|VIEW DROP
COLUMN statement; each attribute named by `attr_names` corresponds to a
dropped SQL table column.

# GENERIC UPDATERS FOR RELATION VARIABLES

# More Updaters That Add Attributes

## sys.std.Core.Relation.assign_extension

`updater assign_extension (&topic : Relation,
attr_names : set_of.Name, func : ValMapPFuncNC) {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Relation.extension` function with the same arguments, and
then assigning the result of that function to `topic`.

# Updaters That Add Tuples

## sys.std.Core.Relation.assign_insertion

`updater assign_insertion (&r : Relation, t : Tuple) {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Relation.insertion` function with the same arguments, and
then assigning the result of that function to `r`.  This updater is
analogous to the general case of the single-row SQL "INSERT" statement.

## sys.std.Core.Relation.assign_disjoint_ins

`updater assign_disjoint_ins (&r : Relation, t : Tuple) {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Relation.disjoint_ins` function with the same
arguments, and then assigning the result of that function to `r`.

## sys.std.Core.Relation.assign_union

`updater assign_union (&topic : Relation, other : Relation) {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Relation.union` function such that it has 2 input
relations from `assign_union`'s 2 arguments, and then assigning the
result of that function to `topic`.  Note that this operation is
also known as `:=union` or `:=∪`.  This updater is analogous to the
general case of the multiple-row SQL "INSERT" statement.

## sys.std.Core.Relation.assign_disjoint_union

`updater assign_disjoint_union (&topic : Relation,
other : Relation) {...}`

This update operator is to `sys.std.Core.Relation.disjoint_union` what
the function `sys.std.Core.Relation.assign_union` is to
`sys.std.Core.Relation.union`.

# Updaters That Remove Tuples

## sys.std.Core.Relation.assign_empty

`updater assign_empty (&topic : Relation) {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Relation.empty` function with the same argument, and then
assigning the result of that function to `topic`.  This updater is
analogous to the SQL "TRUNCATE" statement.

## sys.std.Core.Relation.assign_deletion

`updater assign_deletion (&r : Relation, t : Tuple) {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Relation.deletion` function with the same arguments, and
then assigning the result of that function to `r`.

## sys.std.Core.Relation.assign_restriction

`updater assign_restriction (&topic : Relation,
func : ValFiltPFuncNC) {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Relation.restriction` function with the same arguments, and
then assigning the result of that function to `topic`.  Note that
this operation is also known as `:=where`.

## sys.std.Core.Relation.assign_cmpl_restr

`updater assign_cmpl_restr
(&topic : Relation, func : ValFiltPFuncNC) {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Relation.cmpl_restr` function with the same arguments, and
then assigning the result of that function to `topic`.  Note that this
operation is also known as `:=!where` or `:=not-where`.  This updater is
analogous to the general case of the SQL "DELETE" statement.

## sys.std.Core.Relation.assign_intersection

`updater assign_intersection (&topic : Relation, other : Relation) {...}`

This update operator is to `sys.std.Core.Relation.intersection` what the
function `sys.std.Core.Relation.assign_union` is to
`sys.std.Core.Relation.union`.  Note that this operation is
also known as `:=intersect` or `:=∩`.

## sys.std.Core.Relation.assign_diff

`updater assign_diff (&source : Relation, filter : Relation) {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Relation.diff` function with the same arguments, and
then assigning the result of that function to `source`.  Note that this
operation is also known as `:=minus` or `:=except` or `:=∖`.

## sys.std.Core.Relation.assign_semidiff

`updater assign_semidiff (&source : Relation, filter : Relation) {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Relation.semidiff` function with the same arguments,
and then assigning the result of that function to `source`.  Note that
this operation is also known as `:=antijoin` or `:=semiminus` or
`:=!matching` or `:=not-matching` or `:=⊿`.  This updater
is analogous to the common case of the SQL "DELETE" statement where the
criteria is simply a set of and-ed and or-ed value equality tests.

## sys.std.Core.Relation.assign_antijoin

`updater assign_antijoin (&source : Relation, filter : Relation) {...}`

This update operator is an alias for
`sys.std.Core.Relation.assign_semidiff`.

## sys.std.Core.Relation.assign_semijoin

`updater assign_semijoin (&source : Relation, filter : Relation) {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Relation.semijoin` function with the same arguments, and
then assigning the result of that function to `source`.  Note that this
operation is also known as `:=semijoin` or `:=matching` or `:=⋉`.

# Updaters That Add and Remove Tuples

## sys.std.Core.Relation.assign_exclusion

`updater assign_exclusion (&topic : Relation, other : Relation) {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Relation.exclusion` function such that it has 2 input
relations from `assign_exclusion`'s 2 arguments, and then assigning the
result of that function to `topic`.  Note that this operation is
also known as `:=exclude` or `:=symdiff` or `:=∆`.

# Updaters That Substitute Tuple Attribute Values

## sys.std.Core.Relation.assign_substitution

`updater assign_substitution (&topic : Relation,
attr_names : set_of.Name, func : ValMapPFuncNC) {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Relation.substitution` function with the same arguments,
and then assigning the result of that function to `topic`.  This updater
is analogous to the general case of the unconditional SQL "UPDATE"
statement.

## sys.std.Core.Relation.assign_static_subst

`updater assign_static_subst (&topic : Relation, attrs : Tuple) {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Relation.static_subst` function with the same
arguments, and then assigning the result of that function to `topic`.

## sys.std.Core.Relation.assign_subst_in_restr

`updater assign_subst_in_restr (&topic : Relation,
restr_func : ValFiltPFuncNC, subst_attr_names : set_of.Name,
subst_func : ValMapPFuncNC) {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Relation.subst_in_restr` function with the same arguments,
and then assigning the result of that function to `topic`.  This updater
is analogous to the general case of the conditional SQL "UPDATE" statement.

## sys.std.Core.Relation.assign_static_subst_in_restr

`updater assign_static_subst_in_restr
(&topic : Relation, restr_func : ValFiltPFuncNC, subst : Tuple) {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Relation.static_subst_in_restr` function with the same
arguments, and then assigning the result of that function to `topic`.

## sys.std.Core.Relation.assign_subst_in_semijoin

`updater assign_subst_in_semijoin (&topic : Relation, restr : Relation,
subst_attr_names : set_of.Name, subst_func : ValMapPFuncNC) {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Relation.subst_in_semijoin` function with the same
arguments, and then assigning the result of that function to `topic`.
This updater is analogous to the common case of the conditional SQL
"UPDATE" statement where the criteria is simply a set of and-ed and or-ed
value equality tests.

## sys.std.Core.Relation.assign_static_subst_in_semijoin

`updater assign_static_subst_in_semijoin
(&topic : Relation, restr : Relation, subst : Tuple) {...}`

This update operator is a short-hand for first invoking the
`sys.std.Core.Relation.static_subst_in_semijoin` function with the same
arguments, and then assigning the result of that function to `topic`.

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Data Language** (**MDL**).

MDL is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
