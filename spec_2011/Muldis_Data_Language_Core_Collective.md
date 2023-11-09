# NAME

Muldis Data Language Core Collective - Muldis Data Language generic collective operators

# VERSION

This document is Muldis Data Language Core Collective version 0.148.1.

# PREFACE

This document is part of the Muldis Data Language language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

This document describes essentially all of the core Muldis Data Language generic
operators that simple homogeneous collection types, that are more specific
than relations in general, would have.

*This documentation is pending.*

# VIRTUAL FUNCTIONS FOR THE COLLECTIVE MIXIN TYPE

## sys.std.Core.Collective.has_member

`function has_member (Bool <--
coll@ : Collective, value : Universal) {...}`

This function results in `Bool:True` iff its `value` argument matches a
member of the simple homogeneous collection value that is its `coll`
argument, and `Bool:False` otherwise.  Note that this operation is also
known as `∋` or `has`.

## sys.std.Core.Collective.has_not_member

`function has_not_member (Bool <--
coll@ : Collective, value : Universal) {...}`

This function is exactly the same as `sys.std.Core.Collective.has_member`
except that it results in the opposite boolean value when given the same
arguments.  Note that this operation is also known as `∌` or `!has` or
`not-has`.

## sys.std.Core.Collective.value_is_member

`function value_is_member (Bool <--
value : Universal, coll@ : Collective) {...}`

This function is an alias for `sys.std.Core.Collective.has_member`.  This
function results in `Bool:True` iff its `value` argument matches a member
of the simple homogeneous collection value that is its `coll` argument,
and `Bool:False` otherwise.  Note that this operation is also known as
`∈` or `in`.

## sys.std.Core.Collective.value_is_not_member

`function value_is_not_member (Bool <--
value : Universal, coll@ : Collective) {...}`

This function is an alias for `sys.std.Core.Collective.has_not_member`.
This function is exactly the same as
`sys.std.Core.Collective.value_is_member` except that it results in the
opposite boolean value when given the same arguments.  Note that this
operation is also known as `∉` or `!in` or `not-in`.

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Data Language** (**MDL**).

MDL is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
