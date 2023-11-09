# NAME

Muldis Data Language Core Set - Muldis Data Language Set and Maybe specific operators

# VERSION

This document is Muldis Data Language Core Set version 0.148.1.

# PREFACE

This document is part of the Muldis Data Language language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

This document describes generic operators that are specific to the
`Set` and `Maybe` parameterized relation types, and said operators
are short-hands for more generic relational operators.

*This documentation is pending.*

# FUNCTIONS IMPLEMENTING VIRTUAL COLLECTIVE FUNCTIONS

## sys.std.Core.Set.has_member

`function has_member (Bool <-- coll : Set, value : Universal)
implements sys.std.Core.Collective.has_member {...}`

This function results in `Bool:True` iff its `value` argument matches the
sole attribute of a tuple of its `coll` argument (that is, iff
conceptually `value` is a member of `coll`), and `Bool:False` otherwise.
This function will warn if its 2 arguments are incompatible as per
`sys.std.Core.Relation.is_subset`.

## sys.std.Core.Set.has_not_member

`function has_not_member (Bool <-- coll : Set, value : Universal)
implements sys.std.Core.Collective.has_not_member {...}`

This function is exactly the same as `sys.std.Core.Set.has_member` except
that it results in the opposite boolean value when given the same
arguments.

## sys.std.Core.Set.value_is_member

`function value_is_member (Bool <-- value : Universal, coll : Set)
implements sys.std.Core.Collective.value_is_member {...}`

This function is an alias for `sys.std.Core.Set.has_member`.  This
function results in `Bool:True` iff its `value` argument matches the
sole attribute of a tuple of its `coll` argument (that is, iff
conceptually `value` is a member of `coll`), and `Bool:False`
otherwise.

## sys.std.Core.Set.value_is_not_member

`function value_is_not_member (Bool <-- value : Universal, coll : Set)
implements sys.std.Core.Collective.value_is_not_member {...}`

This function is an alias for `sys.std.Core.Set.has_not_member`.  This
function is exactly the same as `sys.std.Core.Set.value_is_member` except
that it results in the opposite boolean value when given the same
arguments.

# GENERIC RELATIONAL FUNCTIONS FOR SETS

## sys.std.Core.Set.insertion

`function insertion (Set <-- set : Set, value : Universal) {...}`

This function results in a `Set` that is the relational union of `set`
and a Set whose sole tuple has the sole attribute value of `value`;
that is, conceptually the result is `value` inserted into `set`.  As a
trivial case, if `value` already exists in `set`, then the result is just
`set`.

## sys.std.Core.Set.disjoint_ins

`function disjoint_ins (Set <-- set : Set, value : Universal) {...}`

This function is exactly the same as `sys.std.Core.Set.insertion` except
that it will fail if `value` already exists in `set`.

## sys.std.Core.Set.deletion

`function deletion (Set <-- set : Set, value : Universal) {...}`

This function results in a `Set` that is the relational difference from
`set` of a Set whose sole tuple has the sole attribute value of
`value`; that is, conceptually the result is `value` deleted from `set`.
As a trivial case, if `value` already doesn't exist in `set`, then the
result is just `set`.

## sys.std.Core.Set.reduction

`function reduction (Universal <-- topic : Set,
func : ValRedPFuncNC, identity : Universal) {...}`

This function is a generic reduction operator that recursively takes each
pair of input values in `topic` and applies an argument-specified scalar
or nonscalar value-resulting `value-reduction` function (which is both
commutative and associative) to the pair until just one input value is
left, which is the result.  The `value-reduction` function to apply is
named in the `func` argument, and that
function must have 2 parameters named `v1` and `v2`, which take
the 2 input scalar or nonscalar values for an
invocation.  If `topic` has zero values, then `reduction` results in the
value given in `identity`.  *Note that `identity` may be changed to take
a function name rather than a value, for consistency with `func`.*  This
function will fail|warn if the |declared type of `identity` isn't a
subtype of the |declared type of the sole attribute of `topic`.

## sys.std.Core.Set.Set_from_wrap

`function Set_from_wrap (set_of.Tuple <-- topic : Relation) {...}`

This function results in a `Set` whose sole attribute is tuple-typed
and the attribute values are all the tuples of `topic`; is a short-hand
for a relational wrap of all attributes of `topic` such that the new
tuple-valued attribute is named `value`.

## sys.std.Core.Set.Set_from_attr

`function Set_from_attr (Set <-- topic : Relation, name : Name) {...}`

This function results in a `Set` consisting of all the values of the
attribute of `topic` named by `name`.  It is a short-hand for a unary
projection of just the named attribute plus its renaming to `value`.

# GENERIC RELATIONAL FUNCTIONS FOR MAYBES

## sys.std.Core.Set.Maybe.Nothing

`function Nothing (Maybe <--) {...}`

This `named-value` selector function results in the only zero-tuple Maybe
value, which is known by the special name `Maybe:Nothing`, aka `Nothing`,
aka *empty set* aka `∅`.

## sys.std.Core.Set.Maybe.just

`function just (Just <-- value : Universal) {...}`

This selector function results in the Maybe value with a single tuple
whose `value` attribute's value is the `value` argument.

## sys.std.Core.Set.Maybe.attr

`function attr (Universal <-- topic : Just) {...}`

This function results in the scalar or nonscalar value of the sole
attribute of the sole tuple of its argument, which always exists when the
argument is a `Just`.  Note that this operation is also known as `.{*}`.

## sys.std.Core.Set.Maybe.attr_or_default

`function attr_or_default (Universal <--
topic? : array_of.Maybe, default : APTypeNC) {...}`

This function results in the scalar or nonscalar value of the sole
attribute of the sole tuple of the lowest-indexed of its N `topic` input
element values where said element isn't equal to `Nothing`, if there is
such an element; otherwise, it results in the default value of the scalar
or nonscalar data type whose name is given in the `default` argument.
This function is a short-hand for invoking `attr_or_value` with the result
from invoking `sys.std.Core.Universal.default`.

## sys.std.Core.Set.Maybe.attr_or_value

`function attr_or_value (Universal <--
topic? : array_of.Maybe, value : Universal) {...}`

This function results in the scalar or nonscalar value of the sole
attribute of the sole tuple of the lowest-indexed of its N `topic` input
element values where said element isn't equal to `Nothing`, if there is
such an element, and otherwise it results in `value`.  This function will
warn if the declared type of `value` isn't a subtype of the declared type
of the attribute.  Note that this operation is also known as `//`.  In
situations where a `Maybe` is used analogously to a SQL nullable value,
this function is analogous to the N-adic SQL COALESCE function.

## sys.std.Core.Set.Maybe.order

`function order (Order <-- topic : Maybe,
other : Maybe, J_ord_func? : OrdDetPFuncNC, J_is_reverse_order? : Bool,
N_is_after_all_J : Bool, is_reverse_order? : Bool) {...}`

This function is a generic (total) `order-determination` function for
`Maybe` values.  Iff both of its `topic` and `other` arguments are
identical, this function results in `Order:Same`.  Otherwise, iff both of
those 2 arguments are `Just` values, then the result of this function
is the result of applying to those 2 arguments the (total)
`order-determination` function given in its `J_ord_func` argument, as
primed by its `J_is_reverse_order` argument; to be specific, the
`order-determination` function takes the attribute values of `topic` and
`other`, not the whole `Just` values.  Otherwise, iff `topic` is
`Nothing`, this function results in `Order:Less` or `Order:More`
respectively when `N_is_after_all_J` is `Bool:False` (the default) or
`Bool:True`.  Otherwise (iff `other` is `Nothing`), this function
results in the reverse of when only `topic` is `Nothing`.  The
`is_reverse_order` argument is applied to the result of this function
*after* all of the other arguments are applied; if it is `Bool:False`, it
does not change the result; if it is `Bool:True`, then it reverses the
result.  In situations where a `Maybe` is used analogously to a SQL
nullable value and this function is analogous to the dyadic comparison
underlying a SQL "ORDER BY", then `J_is_reverse_order` designates SQL's
"ASC|DESC" and `N_is_after_all_J` designates SQL's "NULLS FIRST|LAST".

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Data Language** (**MDL**).

MDL is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
