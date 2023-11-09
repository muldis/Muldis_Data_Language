# NAME

Muldis Data Language Core Attributive - Muldis Data Language generic attributive operators

# VERSION

This document is Muldis Data Language Core Attributive version 0.148.1.

# PREFACE

This document is part of the Muldis Data Language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

This document describes essentially all of the core Muldis Data Language generic
operators that types composed of named attributes would have.  In
particular, all the virtual operators that tuples and relations implement.

*This documentation is pending.*

# VIRTUAL FUNCTIONS FOR THE ATTRIBUTIVE MIXIN TYPE

## sys.std.Core.Attributive.degree

`function degree (NNInt <-- topic@ : Attributive) {...}`

This virtual function results in the degree of its argument (that is, the
count of attributes it has).

## sys.std.Core.Attributive.is_nullary

`function is_nullary (Bool <-- topic@ : Attributive) {...}`

This virtual function results in `Bool:True` iff its argument has a degree
of zero (that is, it has zero attributes), and `Bool:False` otherwise.

## sys.std.Core.Attributive.is_not_nullary

`function is_not_nullary (Bool <-- topic@ : Attributive) {...}`

This virtual function is exactly the same as
`sys.std.Core.Attributive.is_nullary` except
that it results in the opposite boolean value when given the same argument.

## sys.std.Core.Attributive.has_attrs

`function has_attrs (Bool <-- topic@ : Attributive,
attr_names : set_of.Name) {...}`

This virtual function results in `Bool:True` iff, for every one of the
attribute names specified by its `attr_names` argument, its `topic`
argument has an attribute with that name; otherwise it results in
`Bool:False`.  As a trivial case, this function's result is `Bool:True`
if `attr_names` is empty.

## sys.std.Core.Attributive.attr_names

`function attr_names (set_of.Name <-- topic@ : Attributive) {...}`

This virtual function results in the set of the names of the attributes of
its argument.

## sys.std.Core.Attributive.rename

`function rename (Attributive <-- topic@ : Attributive,
map : AttrRenameMap) {...}`

*TODO: This description; meanwhile, see the implementers' descriptions.*
Note that this operation is also known as `{<-}`.

## sys.std.Core.Attributive.projection

`function projection (Attributive <-- topic@ : Attributive,
attr_names : set_of.Name) {...}`

*TODO: This description; meanwhile, see the implementers' descriptions.*
Note that this operation is also known as `{}`.

## sys.std.Core.Attributive.cmpl_proj

`function cmpl_proj (Attributive <-- topic@ : Attributive,
attr_names : set_of.Name) {...}`

*TODO: This description; meanwhile, see the implementers' descriptions.*
Note that this operation is also known as `{!}`.

## sys.std.Core.Attributive.static_exten

`function static_exten (Attributive <--
topic@ : Attributive, attrs : Tuple) {...}`

*TODO: This description; meanwhile, see the implementers' descriptions.*

## sys.std.Core.Attributive.wrap

`function wrap (Attributive <-- topic@ : Attributive,
outer : Name, inner : set_of.Name) {...}`

*TODO: This description; meanwhile, see the implementers' descriptions.*
Note that this operation is also known as `{%<-}`.

## sys.std.Core.Attributive.cmpl_wrap

`function cmpl_wrap (Attributive <-- topic@ : Attributive,
outer : Name, cmpl_inner : set_of.Name) {...}`

*TODO: This description; meanwhile, see the implementers' descriptions.*
Note that this operation is also known as `{%<-!}`.

## sys.std.Core.Attributive.unwrap

`function unwrap (Attributive <-- topic@ : Attributive,
inner : set_of.Name, outer : Name) {...}`

*TODO: This description; meanwhile, see the implementers' descriptions.*
Note that this operation is also known as `{<-%}`.

# VIRTUAL UPDATERS FOR THE ATTRIBUTIVE MIXIN TYPE

# Updaters That Rename Attributes

## sys.std.Core.Attributive.assign_rename

`updater assign_rename (&topic@ : Attributive, map : AttrRenameMap) {...}`

This virtual update operator is a short-hand for first invoking the
`sys.std.Core.Attributive.rename` function with the same arguments, and
then assigning the result of that function to `topic`.

# Updaters That Add Attributes

## sys.std.Core.Attributive.assign_static_exten

`updater assign_static_exten (&topic@ : Attributive, attrs : Tuple) {...}`

This virtual update operator is a short-hand for first invoking the
`sys.std.Core.Attributive.static_exten` function with the same arguments,
and then assigning the result of that function to `topic`.

# Updaters That Remove Attributes

## sys.std.Core.Attributive.assign_projection

`updater assign_projection (&topic@ : Attributive,
attr_names : set_of.Name) {...}`

This virtual update operator is a short-hand for first invoking the
`sys.std.Core.Attributive.projection` function with the same arguments,
and then assigning the result of that function to `topic`.

## sys.std.Core.Attributive.assign_cmpl_proj

`updater assign_cmpl_proj (&topic@ : Attributive,
attr_names : set_of.Name) {...}`

This virtual update operator is a short-hand for first invoking the
`sys.std.Core.Attributive.cmpl_proj` function with the same arguments,
and then assigning the result of that function to `topic`.

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Data Language** (**MDL**).

MDL is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
