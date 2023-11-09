# NAME

Muldis Data Language Core Interval - Muldis Data Language generic interval operators

# VERSION

This document is Muldis Data Language Core Interval version 0.148.1.

# PREFACE

This document is part of the Muldis Data Language language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

This document describes essentially all of the core Muldis Data Language generic
interval operators, for the canonical interval types that are tuple or
relation types with specific nonscalar headings.  They can potentially be
used with values of any data type as long as said data type has a (total)
`order-determination` function defined for it, and all system-defined
conceptually-ordered Muldis Data Language scalar root types do.

*This documentation is pending.*

*Most functions that should be in this document are pending.*

Each of these functions is a wrapper over the `order-determination`
function named `sys.std.Core.Ordered.order` when the latter function is
primed by a `misc_args` argument of `Tuple:D0` and by
an `is_reverse_order` argument of `Bool:False`.

These functions' `SPInterval`-typed arguments' `min` and `max` attribute
values must be of compatible declared types with the wrapped functions'
`topic` and `other` parameters; otherwise these functions will fail|warn
when the wrapped function would.  Likewise, any other argument values would
be compared to an interval's endpoints must be compatible with them.
Likewise, said attributes of any multiplicity of `SPInterval`-typed
arguments must be mutually compatible.

# FUNCTIONS IMPLEMENTING VIRTUAL COLLECTIVE FUNCTIONS

## sys.std.Core.Interval.SP.has_member

`function has_member (Bool <-- coll : SPInterval, value : Ordered)
implements sys.std.Core.Collective.has_member {...}`

This function results in `Bool:True` iff its `value` argument is included
within the interval defined by its `coll` argument, and `Bool:False`
otherwise.  That is, if conceptually the interval represents a set of
values, this function tests if `value` is a member of `coll`.

## sys.std.Core.Interval.SP.has_not_member

`function has_not_member (Bool <-- coll : SPInterval, value : Ordered)
implements sys.std.Core.Collective.has_not_member {...}`

This function is exactly the same as `sys.std.Core.Interval.has_member`
except that it results in the opposite boolean value when given the same
arguments.

## sys.std.Core.Interval.SP.value_is_member

`function value_is_member (Bool <-- value : Ordered, coll : SPInterval)
implements sys.std.Core.Collective.value_is_member {...}`

This function is an alias for `sys.std.Core.Interval.SP.has_member`.  This
function results in `Bool:True` iff its `value` argument is included
within the interval defined by its `coll` argument, and `Bool:False`
otherwise.  That is, if conceptually the interval represents a set of
values, this function tests if `value` is a member of `coll`.

## sys.std.Core.Interval.SP.value_is_not_member

`function value_is_not_member (Bool <--
value : Ordered, coll : SPInterval)
implements sys.std.Core.Collective.value_is_not_member {...}`

This function is an alias for `sys.std.Core.Interval.SP.has_not_member`.
This function is exactly the same as
`sys.std.Core.Interval.SP.value_is_member` except that it
results in the opposite boolean value when given the same arguments.

## sys.std.Core.Interval.MP.has_member

`function has_member (Bool <-- coll : MPInterval, value : Ordered)
implements sys.std.Core.Collective.has_member {...}`

This function results in `Bool:True` iff its `value` argument is included
within the interval defined by its `coll` argument, and `Bool:False`
otherwise.  That is, if conceptually the interval represents a set of
values, this function tests if `value` is a member of `coll`.

## sys.std.Core.Interval.MP.has_not_member

`function has_not_member (Bool <-- coll : MPInterval, value : Ordered)
implements sys.std.Core.Collective.has_not_member {...}`

This function is exactly the same as `sys.std.Core.Interval.has_member`
except that it results in the opposite boolean value when given the same
arguments.

## sys.std.Core.Interval.MP.value_is_member

`function value_is_member (Bool <-- value : Ordered, coll : MPInterval)
implements sys.std.Core.Collective.value_is_member {...}`

This function is an alias for `sys.std.Core.Interval.MP.has_member`.  This
function results in `Bool:True` iff its `value` argument is included
within the interval defined by its `coll` argument, and `Bool:False`
otherwise.  That is, if conceptually the interval represents a set of
values, this function tests if `value` is a member of `coll`.

## sys.std.Core.Interval.MP.value_is_not_member

`function value_is_not_member (Bool <--
value : Ordered, coll : MPInterval)
implements sys.std.Core.Collective.value_is_not_member {...}`

This function is an alias for `sys.std.Core.Interval.MP.has_not_member`.
This function is exactly the same as
`sys.std.Core.Interval.MP.value_is_member` except that it
results in the opposite boolean value when given the same arguments.

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Data Language** (**MDL**).

MDL is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
