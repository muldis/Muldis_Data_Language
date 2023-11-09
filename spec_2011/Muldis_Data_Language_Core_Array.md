# NAME

Muldis Data Language Core Array - Muldis Data Language Array specific operators

# VERSION

This document is Muldis Data Language Core Array version 0.148.1.

# PREFACE

This document is part of the Muldis Data Language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

This document describes generic operators that are specific to the
`Array` parameterized relation type, and said operators
are short-hands for more generic relational operators.

*This documentation is pending.*

# FUNCTIONS IMPLEMENTING VIRTUAL STRINGY FUNCTIONS

## sys.std.Core.Array.catenation

`function catenation (Array <-- topic? : array_of.Array)
implements sys.std.Core.Stringy.catenation {...}`

This function results in the catenation of the N element values of its
argument; it is a reduction operator that recursively takes each
consecutive pair of input values and catenates (which is associative) them
together until just one is left, which is the result.  To catenate 2
`Array` means to union their tuples after first increasing all the
`index` values of the second one by the cardinality of the first one.  If
`topic` has zero values, then `catenation` results in the empty sequence
value, which is the identity value for catenation.

## sys.std.Core.Array.replication

`function replication (Array <-- topic : Array,
count : NNInt) implements sys.std.Core.Stringy.replication {...}`

This function results in the catenation of `count` instances of `topic`.

# FUNCTIONS IMPLEMENTING VIRTUAL COLLECTIVE FUNCTIONS

## sys.std.Core.Array.has_elem

`function has_elem (Bool <-- coll : Array, value : Universal)
implements sys.std.Core.Collective.has_member {...}`

This function results in `Bool:True` iff its `value` argument matches the
`value` attribute of at least one tuple of its `coll` argument (that
is, iff conceptually `value` is an element of `coll`), and `Bool:False`
otherwise.  This function will warn if `coll.value` and `value` are
incompatible as per `update_value`.

## sys.std.Core.Array.has_not_elem

`function has_not_elem (Bool <-- coll : Array, value : Universal)
implements sys.std.Core.Collective.has_not_member {...}`

This function is exactly the same as `sys.std.Core.Array.has_elem` except
that
it results in the opposite boolean value when given the same arguments.

## sys.std.Core.Array.value_is_elem

`function value_is_elem (Bool <-- value : Universal, coll : Array)
implements sys.std.Core.Collective.value_is_member {...}`

This function is an alias for `sys.std.Core.Array.has_elem`.  This
function results in `Bool:True` iff its `value` argument matches the
`value` attribute of at least one tuple of its `coll` argument (that is,
iff conceptually `value` is an element of `coll`), and `Bool:False`
otherwise.

## sys.std.Core.Array.value_is_not_elem

`function value_is_not_elem (Bool <-- value : Universal, coll : Array)
implements sys.std.Core.Collective.value_is_not_member {...}`

This function is an alias for `sys.std.Core.Array.has_elem`.  This
function is exactly the same as `sys.std.Core.Array.value_is_elem` except
that it results in the opposite boolean value when given the same
arguments.

# GENERIC RELATIONAL FUNCTIONS FOR ARRAYS

## sys.std.Core.Array.value

`function value (Universal <-- topic : Array, index : NNInt) {...}`

This function results in the scalar or nonscalar `value` attribute of the
tuple of `topic` whose `index` attribute is `index`.  This function will
fail if no tuple exists in `topic` with the specified index.  Note that
this operation is also known as `.[]`.

## sys.std.Core.Array.update_value

`function update_value (Array <-- topic : Array,
index : NNInt, value : Universal) {...}`

This function results in its `topic` argument but that the `value`
attribute of the tuple of `topic` whose `index` attribute is `index`
has been updated with a new scalar or nonscalar value given by
`value`.  This function will fail if no tuple exists in `topic` with
the specified index.  This function will warn if the most specific types of
the `value` argument and the `value` attribute of `topic` are
incompatible as per `is_same`, or otherwise if the declared type of
`value` isn't a subtype of the declared type of the `value` attribute.

## sys.std.Core.Array.insertion

`function insertion (Array <-- topic : Array,
index : NNInt, value : Universal) {...}`

This function results in its `topic` argument but that a new tuple has
been inserted whose `index` is `index` and whose `value` is `value`;
any existing tuples with `index` values greater than or equal to
`index` had theirs incremented by 1.  As a trivial case, if `index` is
equal to zero or is equal to the cardinality of `topic`, then `value` has
become the new first or last (or only) element, respectively.  This
function will fail if `index` is greater than the cardinality of `topic`,
or it will warn if `topic.value` and `value` are incompatible as per
`update_value`.

## sys.std.Core.Array.deletion

`function deletion (Array <-- topic : Array, index : NNInt) {...}`

This function results in its `topic` argument but that a tuple has been
deleted whose `index` is `index`; any existing tuples with `index`
values greater than or equal to `index` had theirs decremented by 1.  This
function will fail if no tuple exists in `topic` with the specified index.

## sys.std.Core.Array.reduction

`function reduction (Universal <-- topic : Array,
func : ValRedPFuncNC, identity : Universal) {...}`

This function is the same as `sys.std.Core.Set.reduction`, including that
input values for the reduction come from the `value` attribute of
`topic`, except that it works with an `Array` rather than a `Set`.
Also, the `value-reduction` function named in `func` is only associative,
and *not* commutative; the arguments to `v1` and `v2` of `func` are
guaranteed to be consecutive input elements, with the result returning to
their place in sequence beween the other input elements.

## sys.std.Core.Array.slice

`function slice (Array <-- topic : Array,
index_interval : sp_interval_of.NNInt) {...}`

This function results in the sub-sequence of its `topic` argument that is
specified by its `index_interval` argument, which specifies the
source-`index` interval of the elements of the result.  It is valid for
the lowest and highest source-`index` specified by `index_interval` to be
greater than the last index of `topic`; in the first case, the result has
zero elements; in the second case, the result has all remaining elements
starting at the lowest source-`index`, if any.  Note that this operation
is also known as `[]`.

## sys.std.Core.Array.reverse

`function reverse (Array <-- topic : Array) {...}`

This function results in its argument but that the order of its elements
has been reversed.  For example, the input `{ 0=>'a', 1=>'b', 2=>'c',
3=>'d'}` results in `{ 0=>'d', 1=>'c', 2=>'b', 3=>'a' }`.

## sys.std.Core.Array.has_subarray

`function has_subarray (Bool <-- look_in : Array,
look_for : Array) {...}`

This function results in `Bool:True` iff the sequence of values comprising
`look_for` is a sub-sequence of the sequence of values `look_in`, and
`Bool:False` otherwise.  This function will fail|warn if the 2 arguments
don't have a compatible or same heading.

## sys.std.Core.Array.has_not_subarray

`function has_not_subarray (Bool <--
look_in : Array, look_for : Array) {...}`

This function is exactly the same as `sys.std.Core.Array.has_subarray`
except that it results in the opposite boolean value when given the same
arguments.

## sys.std.Core.Array.order

`function order (Order <-- topic : Array,
other : Array, elem_ord_func? : OrdDetPFuncNC,
elem_is_reverse_order? : Bool, is_reverse_order? : Bool) {...}`

This function is a generic (total) `order-determination` function for
`Array` values, especially for homogeneous ones.  Iff
both of its `topic` and `other` arguments are identical, this function
results in `Order:Same`.  Otherwise, iff one of those 2 arguments is a
subarray of the other where the latter is matched by its leading elements,
meaning that the former's tuples are a proper subset of the latter's, then
the shorter argument is ordered before the longer one.  Otherwise, the
order of the `topic` and `other` arguments is determined by the
comparison of the lowest-index distinct element values of those arguments,
as follows:  The result of this function is the result of applying to those
2 elements the (total) `order-determination` function given in its
`elem_ord_func` argument, as primed by its `elem_is_reverse_order`
argument.  Iff `topic` is ordered before `other`, this function results
in `Order:Less`; otherwise, iff `other` is ordered before `topic`,
this function results in `Order:More`.  The `is_reverse_order`
argument is applied to the result of this function *after* all of the
other arguments are applied; if it is `Bool:False`, it does not change the
result; if it is `Bool:True`, then it reverses the result.

## sys.std.Core.Array.Array_from_wrap

`function Array_from_wrap (array_of.Tuple <-- topic : Relation,
ord_func : OrdDetPFuncNC, is_reverse_order? : Bool) {...}`

This function results in an `Array` whose `value` attribute is
tuple-typed and that attribute's values are all the tuples of `topic`;
is a short-hand for a relational wrap of all attributes of `topic` such
that the new tuple-valued attribute is named `value`, and then that
result is extended with an `index` attribute whose values result from a
rank of the tuples, where the ranked-first tuple has an `index` of
zero, and so on.  This function is a wrapper over the (total)
`order-determination` function named in its `ord_func` argument when the
latter function is primed by its `is_reverse_order`
argument; this wrapped function is used to rank the tuples, with each
invocation getting a `topic` tuple as each its `topic` and `other`
arguments.  See also the `sys.std.Core.Relation.rank` function, which is
the same as `sys.std.Core.Array.Array_from_wrap` but that it just adds an
attribute to the source tuples and does not wrap them.

## sys.std.Core.Array.Array_from_wrap_by_attr_names

`function Array_from_wrap_by_attr_names
(array_of.Tuple <-- topic : Relation,
order_by : array_of.OrderByName, is_reverse_order? : Bool) {...}`

This function is to `Array_from_wrap` what
`sys.std.Core.Relation.rank_by_attr_names` is to
`sys.std.Core.Relation.rank`.
Note that this function is the most direct analogy to the common case of
SQL's "ORDER BY" where a simple list of attribute names is given to sort on
(and the tuples remain sorted), which is in contrast with
`Array_from_wrap` that is the analogy to the general case of "ORDER BY"
that may contain any arbitrary value expression.

## sys.std.Core.Array.limit_of_Array_from_wrap

`function limit_of_Array_from_wrap
(array_of.Tuple <-- topic : Relation, ord_func : OrdDetPFuncNC,
is_reverse_order? : Bool, index_interval : sp_interval_of.NNInt) {...}`

This function is a short-hand for invoking first
`sys.std.Core.Array.Array_from_wrap` and then `sys.std.Core.Array.slice`
on its result.  This function is to `sys.std.Core.Array.Array_from_wrap`
what the `sys.std.Core.Relation.limit` function is to
`sys.std.Core.Relation.rank`.

## sys.std.Core.Array.limit_of_Array_from_wrap_by_attr_names

`function limit_of_Array_from_wrap_by_attr_names
(array_of.Tuple <-- topic : Relation, order_by : array_of.OrderByName,
is_reverse_order? : Bool, index_interval : sp_interval_of.NNInt) {...}`

This function is to `limit_of_Array_from_wrap` what
`Array_from_wrap_by_attr_names` is to `Array_from_wrap`.

## sys.std.Core.Array.Array_from_attr

`function Array_from_attr (Array <-- topic : Relation, name : Name,
ord_func? : OrdDetPFuncNC, is_reverse_order? : Bool) {...}`

This function results in an `Array` consisting of all the values of the
attribute of `topic` named by `name`.  It is a short-hand for a unary
projection of just the named attribute plus its renaming to `value`, and
then that result is extended with an `index` attribute whose values result
from a rank of the source attribute values, where the ranked-first source
value has an `index` of zero, and so on.  This function is otherwise the
same as `sys.std.Core.Array.Array_from_wrap`.  Each of the `ord_func` and
`is_reverse_order` parameters is optional and defaults
to `sys.std.Core.Ordered.order` or
`Bool:False`, respectively, if no explicit argument is given to it.

## sys.std.Core.Array.Array_from_Set

`function Array_from_Set (Array <-- topic : Set,
ord_func? : OrdDetPFuncNC, is_reverse_order? : Bool) {...}`

This function results in an `Array` consisting of all the values of
`topic`.  It is a short-hand for a `sys.std.Core.Array.Array_from_attr`
invocation with a `name` argument of `value`, and `topic` is a `Set`.

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Data Language** (**MDL**).

MDL is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
