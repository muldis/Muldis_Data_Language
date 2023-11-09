# NAME

Muldis::D::Core - Muldis D core data types and operators

# VERSION

This document is Muldis::D::Core version 0.148.1.

# PREFACE

This document is part of the Muldis D language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document
before you read this one, which provides subservient details.

That said, because this `Core` document is otherwise too large to
comfortably fit in one file, it has been split into pieces and therefore
has its own tree of parts to follow, which it is the root of:
[Muldis_Data_Language_Core_Types](Muldis_Data_Language_Core_Types.md), [Muldis_Data_Language_Core_Types_Catalog](Muldis_Data_Language_Core_Types_Catalog.md),
[Muldis_Data_Language_Core_Universal](Muldis_Data_Language_Core_Universal.md), [Muldis_Data_Language_Core_Ordered](Muldis_Data_Language_Core_Ordered.md),
[Muldis_Data_Language_Core_Scalar](Muldis_Data_Language_Core_Scalar.md), [Muldis_Data_Language_Core_Boolean](Muldis_Data_Language_Core_Boolean.md),
[Muldis_Data_Language_Core_Numeric](Muldis_Data_Language_Core_Numeric.md), [Muldis_Data_Language_Core_Integer](Muldis_Data_Language_Core_Integer.md),
[Muldis_Data_Language_Core_Rational](Muldis_Data_Language_Core_Rational.md), [Muldis_Data_Language_Core_Stringy](Muldis_Data_Language_Core_Stringy.md),
[Muldis_Data_Language_Core_Blob](Muldis_Data_Language_Core_Blob.md), [Muldis_Data_Language_Core_Text](Muldis_Data_Language_Core_Text.md),
[Muldis_Data_Language_Core_Cast](Muldis_Data_Language_Core_Cast.md), [Muldis_Data_Language_Core_Attributive](Muldis_Data_Language_Core_Attributive.md),
[Muldis_Data_Language_Core_Tuple](Muldis_Data_Language_Core_Tuple.md), [Muldis_Data_Language_Core_Relation](Muldis_Data_Language_Core_Relation.md),
[Muldis_Data_Language_Core_Collective](Muldis_Data_Language_Core_Collective.md), [Muldis_Data_Language_Core_Set](Muldis_Data_Language_Core_Set.md),
[Muldis_Data_Language_Core_Array](Muldis_Data_Language_Core_Array.md), [Muldis_Data_Language_Core_Bag](Muldis_Data_Language_Core_Bag.md),
[Muldis_Data_Language_Core_Interval](Muldis_Data_Language_Core_Interval.md), [Muldis_Data_Language_Core_STDIO](Muldis_Data_Language_Core_STDIO.md),
[Muldis_Data_Language_Core_Routines_Catalog](Muldis_Data_Language_Core_Routines_Catalog.md).

# DESCRIPTION

Muldis D has a mandatory core set of system-defined (eternally available)
entities, which is referred to as the *Muldis D core* or the *core*; they
are the minimal entities that all Muldis D implementations need to provide;
they are mutually self-describing and are either used to bootstrap the
language or they constitute a reasonable minimum level of functionality for
a practically useable industrial-strength (and fully *TTM*-conforming)
programming language; any entities outside the core, called *Muldis D
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
[Muldis_Data_Language_Core_Types](Muldis_Data_Language_Core_Types.md), [Muldis_Data_Language_Core_Types_Catalog](Muldis_Data_Language_Core_Types_Catalog.md),
[Muldis_Data_Language_Core_Universal](Muldis_Data_Language_Core_Universal.md), [Muldis_Data_Language_Core_Ordered](Muldis_Data_Language_Core_Ordered.md),
[Muldis_Data_Language_Core_Scalar](Muldis_Data_Language_Core_Scalar.md), [Muldis_Data_Language_Core_Boolean](Muldis_Data_Language_Core_Boolean.md),
[Muldis_Data_Language_Core_Numeric](Muldis_Data_Language_Core_Numeric.md), [Muldis_Data_Language_Core_Integer](Muldis_Data_Language_Core_Integer.md),
[Muldis_Data_Language_Core_Rational](Muldis_Data_Language_Core_Rational.md), [Muldis_Data_Language_Core_Stringy](Muldis_Data_Language_Core_Stringy.md),
[Muldis_Data_Language_Core_Blob](Muldis_Data_Language_Core_Blob.md), [Muldis_Data_Language_Core_Text](Muldis_Data_Language_Core_Text.md),
[Muldis_Data_Language_Core_Cast](Muldis_Data_Language_Core_Cast.md), [Muldis_Data_Language_Core_Attributive](Muldis_Data_Language_Core_Attributive.md),
[Muldis_Data_Language_Core_Tuple](Muldis_Data_Language_Core_Tuple.md), [Muldis_Data_Language_Core_Relation](Muldis_Data_Language_Core_Relation.md),
[Muldis_Data_Language_Core_Collective](Muldis_Data_Language_Core_Collective.md), [Muldis_Data_Language_Core_Set](Muldis_Data_Language_Core_Set.md),
[Muldis_Data_Language_Core_Array](Muldis_Data_Language_Core_Array.md), [Muldis_Data_Language_Core_Bag](Muldis_Data_Language_Core_Bag.md),
[Muldis_Data_Language_Core_Interval](Muldis_Data_Language_Core_Interval.md), [Muldis_Data_Language_Core_STDIO](Muldis_Data_Language_Core_STDIO.md),
[Muldis_Data_Language_Core_Routines_Catalog](Muldis_Data_Language_Core_Routines_Catalog.md).

Extensions are in other documents.

These extensions don't declare any new data types but declare additional
operators for core types: [Muldis_Data_Language_Ext_Counted](Muldis_Data_Language_Ext_Counted.md).

These extensions mainly define new types plus just operators for those:
[Muldis_Data_Language_Ext_Temporal](Muldis_Data_Language_Ext_Temporal.md), [Muldis_Data_Language_Ext_Spatial](Muldis_Data_Language_Ext_Spatial.md).

# AUTHOR

Darren Duncan (`darren@DarrenDuncan.net`)

# LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
