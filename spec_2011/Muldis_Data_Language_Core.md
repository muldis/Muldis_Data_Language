# NAME

Muldis Data Language Core - Muldis Data Language core data types and operators

# VERSION

This document is Muldis Data Language Core version 0.148.1.

# PREFACE

This document is part of the Muldis Data Language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md);
you should read that root document
before you read this one, which provides subservient details.

That said, because this `Core` document is otherwise too large to
comfortably fit in one file, it has been split into pieces and therefore
has its own tree of parts to follow, which it is the root of:
[Core_Types](Muldis_Data_Language_Core_Types.md),
[Core_Types_Catalog](Muldis_Data_Language_Core_Types_Catalog.md),
[Core_Universal](Muldis_Data_Language_Core_Universal.md),
[Core_Ordered](Muldis_Data_Language_Core_Ordered.md),
[Core_Scalar](Muldis_Data_Language_Core_Scalar.md),
[Core_Boolean](Muldis_Data_Language_Core_Boolean.md),
[Core_Numeric](Muldis_Data_Language_Core_Numeric.md),
[Core_Integer](Muldis_Data_Language_Core_Integer.md),
[Core_Rational](Muldis_Data_Language_Core_Rational.md),
[Core_Stringy](Muldis_Data_Language_Core_Stringy.md),
[Core_Blob](Muldis_Data_Language_Core_Blob.md),
[Core_Text](Muldis_Data_Language_Core_Text.md),
[Core_Cast](Muldis_Data_Language_Core_Cast.md),
[Core_Attributive](Muldis_Data_Language_Core_Attributive.md),
[Core_Tuple](Muldis_Data_Language_Core_Tuple.md),
[Core_Relation](Muldis_Data_Language_Core_Relation.md),
[Core_Collective](Muldis_Data_Language_Core_Collective.md),
[Core_Set](Muldis_Data_Language_Core_Set.md),
[Core_Array](Muldis_Data_Language_Core_Array.md),
[Core_Bag](Muldis_Data_Language_Core_Bag.md),
[Core_Interval](Muldis_Data_Language_Core_Interval.md),
[Core_STDIO](Muldis_Data_Language_Core_STDIO.md),
[Core_Routines_Catalog](Muldis_Data_Language_Core_Routines_Catalog.md).

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

This current `Core` document features the tuple and
relation type constructors and all of the general-purpose
relational operators, plus the type system minimal and maximal types, plus
the special types used to define the system catalog, and the polymorphic
operators that all types, or some types including core types, have defined
over them, such as identity tests or assignment; it also features the
boolean logic, integer and rational numeric, bit and character string
data types and all their operators.

Most of the `Core` document is actually in these pieces:
[Core_Types](Muldis_Data_Language_Core_Types.md),
[Core_Types_Catalog](Muldis_Data_Language_Core_Types_Catalog.md),
[Core_Universal](Muldis_Data_Language_Core_Universal.md),
[Core_Ordered](Muldis_Data_Language_Core_Ordered.md),
[Core_Scalar](Muldis_Data_Language_Core_Scalar.md),
[Core_Boolean](Muldis_Data_Language_Core_Boolean.md),
[Core_Numeric](Muldis_Data_Language_Core_Numeric.md),
[Core_Integer](Muldis_Data_Language_Core_Integer.md),
[Core_Rational](Muldis_Data_Language_Core_Rational.md),
[Core_Stringy](Muldis_Data_Language_Core_Stringy.md),
[Core_Blob](Muldis_Data_Language_Core_Blob.md),
[Core_Text](Muldis_Data_Language_Core_Text.md),
[Core_Cast](Muldis_Data_Language_Core_Cast.md),
[Core_Attributive](Muldis_Data_Language_Core_Attributive.md),
[Core_Tuple](Muldis_Data_Language_Core_Tuple.md),
[Core_Relation](Muldis_Data_Language_Core_Relation.md),
[Core_Collective](Muldis_Data_Language_Core_Collective.md),
[Core_Set](Muldis_Data_Language_Core_Set.md),
[Core_Array](Muldis_Data_Language_Core_Array.md),
[Core_Bag](Muldis_Data_Language_Core_Bag.md),
[Core_Interval](Muldis_Data_Language_Core_Interval.md),
[Core_STDIO](Muldis_Data_Language_Core_STDIO.md),
[Core_Routines_Catalog](Muldis_Data_Language_Core_Routines_Catalog.md).

Extensions are in other documents.

These extensions don't declare any new data types but declare additional
operators for core types: [Ext_Counted](Muldis_Data_Language_Ext_Counted.md).

These extensions mainly define new types plus just operators for those:
[Ext_Temporal](Muldis_Data_Language_Ext_Temporal.md), [Ext_Spatial](Muldis_Data_Language_Ext_Spatial.md).

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Data Language** (**MDL**).

MDL is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of
[Muldis_Data_Language](Muldis_Data_Language.md) for details.
