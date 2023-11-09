# NAME

Muldis::D::Ext::Counted - Muldis D extension for count-sensitive relational operators

# VERSION

This document is Muldis::D::Ext::Counted version 0.148.1.

# PREFACE

This document is part of the Muldis D language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document
before you read this one, which provides subservient details.

# DESCRIPTION

Muldis D has a mandatory core set of system-defined (eternally available)
entities, which is referred to as the I<Muldis D core> or the I<core>; they
are the minimal entities that all Muldis D implementations need to provide;
they are mutually self-describing and are either used to bootstrap the
language or they constitute a reasonable minimum level of functionality for
a practically useable industrial-strength (and fully I<TTM>-conforming)
programming language; any entities outside the core, called I<Muldis D
extensions>, are non-mandatory and are defined in terms of the core or each
other, but the reverse isn't true.

This current C<Counted> document describes the system-defined I<Muldis D
Counted Extension>, which consists of relational operators that are
sensitive to special relation attributes that store count metadata as if
the relation conceptually was a bag of tuples rather than a set of
tuples.  This extension doesn't introduce any new data types, and its
operators all range over ordinary relations.  The operators do not assume
that their argument relations have attributes of any particular names,
including that count-containing attributes have any particular names;
rather, each operator is told what attributes to treat as special by taking
extra explicit parameters specifying their names.  The operators are all
short-hands for generic relational operators either in the language core or
in other language extensions.  The I<Muldis D Counted Extension> differs
from the I<Muldis D Bag Extension> in that the latter deals just with
C<Bag> binary relations with specific attribute names while the former
works with any relations at all.

This current document does not describe the polymorphic operators that all
types, or some types including core types, have defined over them; said
operators are defined once for all types in [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md).

I<This documentation is pending.>

# GENERIC RELATIONAL FUNCTIONS THAT MAINTAIN COUNT ATTRIBUTES

Every one of these functions that takes a C<count_attr_name> argument is
expecting that each of any other applicable arguments will have an
attribute whose name matches that given in C<count_attr_name> and that the
type of this attribute is C<PInt>; said functions will fail if these
conditions aren't met.  For brevity, this documentation will hereafter
refer to the attribute named in C<count_attr_name> as C<tcount>, and
moreafter it will refer to the collection of all attributes except
C<tcount> as C<tattrs>.

## sys.std.Counted.add_count_attr

C<< function add_count_attr (Relation <--
topic : Relation, count_attr_name : Name) {...} >>

This function is a shorthand for C<sys.std.Core.Relation.static_exten>
that adds to C<topic> a single C<tcount> attribute whose value for all
tuples is 1.  This function conceptually converts a set of tuples into a
bag of tuples, of multiplicity 1 per tuple.

## sys.std.Counted.remove_count_attr

C<< function remove_count_attr (Relation <--
topic : Relation, count_attr_name : Name) {...} >>

This function is a shorthand for C<sys.std.Core.Relation.cmpl_proj>
that removes from C<topic> the single C<tcount> attribute.  This function
conceptually converts a bag of tuples into a set of tuples, elimimating all
duplicates.

## sys.std.Counted.counted_cardinality

C<< function counted_cardinality (NNInt <--
topic : Relation, count_attr_name : Name) {...} >>

This function is like C<sys.std.Core.Relation.cardinality> but that it
accounts for the greater-than-one conceptual multiplicity of tuples in
its C<topic> argument; it results in the sum of the C<tcount> attribute of
its C<topic> argument.

## sys.std.Counted.counted_has_member

C<< function counted_has_member (Bool <-- r : Relation,
t : Tuple, count_attr_name : Name) {...} >>

This function is the same as C<sys.std.Core.Relation.has_member> except
that C<t> must have one fewer attribute than C<r> does, specifically
C<tcount> (and otherwise they must have the same headings).

## sys.std.Counted.counted_has_not_member

C<< function counted_has_not_member (Bool <--
r : Relation, t : Tuple, count_attr_name : Name) {...} >>

This function is exactly the same as C<sys.std.Counted.counted_has_member>
except that it results in the opposite boolean value when given the same
arguments.

## sys.std.Counted.counted_insertion

C<< function counted_insertion (Relation <-- r : Relation,
t : Tuple, count_attr_name : Name) {...} >>

This function is the same as C<sys.std.Core.Relation.insertion> as per
C<counted_has_member> but that its result differs depending on whether C<t>
already exists in C<r>; if it does, then no new tuple is added, but the
C<tcount> attribute for the matching tuple is incremented by 1; if it
does not, then a new tuple is added where its C<tattrs> is C<t> and its
C<tcount> is 1.  Actually this function differs in another way, such that
it is semantically the single-tuple case of
C<sys.std.Counted.counted_union_sum>, and is not the single-tuple case of
C<sys.std.Counted.counted_union> (which is the direct analogy to set
union).

## sys.std.Counted.counted_deletion

C<< function counted_deletion (Relation <-- r : Relation,
t : Tuple, count_attr_name : Name) {...} >>

This function is the same as C<sys.std.Core.Relation.deletion> as per
C<counted_has_member> but that its result differs depending on what the
C<tcount> for any tuple matching C<t> that already exists in C<r> is; if
the C<tcount> is greater than 1, then it is decremented by 1; if it is
equal to 1, then the tuple whose C<tattrs> is C<t> is deleted.

## sys.std.Counted.counted_projection

C<< function counted_projection (Relation <-- topic : Relation,
attr_names : set_of.Name, count_attr_name : Name) {...} >>

This function is the same as C<sys.std.Core.Relation.projection> except
that the C<counted_cardinality> of the result is guaranteed to be the same
as that of C<topic> rather than possibly less.  The C<topic> argument must
have a C<tcount> attribute and C<attr_names> must not specify that
attribute; the result has the just attributes of C<topic> named by
C<attr_names> plus the C<tcount> attribute.

## sys.std.Counted.counted_cmpl_proj

C<< function counted_cmpl_proj (Relation <-- topic : Relation,
attr_names : set_of.Name, count_attr_name : Name) {...} >>

This function is the same as C<sys.std.Core.Relation.cmpl_proj>
except that the C<counted_cardinality> of the result is guaranteed to be
the same as that of C<topic> rather than possibly less.  The C<topic>
argument must have a C<tcount> attribute and C<attr_names> must not specify
that attribute; the result has the just the attributes of C<topic> not
named by C<attr_names> including the C<tcount> attribute.

## sys.std.Counted.counted_reduction

C<< function counted_reduction (Tuple <-- topic : Relation,
func : ValRedPFuncNC, identity : Tuple, count_attr_name : Name) {...} >>

This function is the same as C<sys.std.Core.Relation.reduction> except that
C<func> is invoked extra times, where both its C<v1> and C<v2> arguments
might be different instances of the same C<tattrs> tuple having >= 2
multiplicity.  This function's C<topic> argument has a C<tcount> attribute
while its C<identity> argument does not, and both the result tuple of
C<func> and its C<v1> and C<v2> arguments don't have the C<tcount>
attribute either.

## sys.std.Counted.counted_map

C<< function counted_map (Relation <-- topic : Relation,
result_attr_names : set_of.Name, func : ValMapPFuncNC,
count_attr_name : Name) {...} >>

This function is the same as C<sys.std.Core.Relation.map> except that the
C<counted_cardinality> of the result is guaranteed to be the same as that
of C<topic> rather than possibly less.  The C<topic> argument must have a
C<tcount> attribute and C<result_attr_names> must not specify that
attribute; the result has the attributes named in C<result_attr_names> plus
the C<tcount> attribute.  Both the result tuple of C<func> and its
C<topic> argument don't have the C<tcount> attribute.

## sys.std.Counted.counted_is_subset

C<< function counted_is_subset (Bool <--
topic : Relation, other : Relation, count_attr_name : Name) {...} >>

This function is like C<sys.std.Core.Relation.is_subset> but that it
accounts for the greater-than-one multiplicity of C<tattrs> in its
C<topic> and C<other> arguments, both of which have a C<tcount>
attribute; this function returns C<Bool:True> iff the multiplicity of each
C<topic> value is less than or equal to the multiplicity of its
counterpart C<other> value.

## sys.std.Counted.counted_is_not_subset

C<< function counted_is_not_subset (Bool <--
topic : Relation, other : Relation, count_attr_name : Name) {...} >>

This function is like C<sys.std.Core.Relation.is_not_subset> as per
C<counted_is_subset>.

## sys.std.Counted.counted_is_superset

C<< function counted_is_superset (Bool <--
topic : Relation, other : Relation, count_attr_name : Name) {...} >>

This function is an alias for C<sys.std.Counted.counted_is_subset> except
that it transposes the C<topic> and C<other> arguments.  This function is
like C<sys.std.Core.Relation.is_superset> but that it accounts for the
greater-than-one multiplicity of C<tattrs> in its C<topic> and C<other>
arguments, both of which have a C<tcount> attribute; this function returns
C<Bool:True> iff the multiplicity of each C<topic> value is greater than or
equal to the multiplicity of its counterpart C<other> value.

## sys.std.Counted.counted_is_not_superset

C<< function counted_is_not_superset (Bool <--
topic : Relation, other : Relation, count_attr_name : Name) {...} >>

This function is an alias for C<sys.std.Counted.counted_is_not_subset>
except that it transposes the C<topic> and C<other> arguments.  This
function is like C<sys.std.Core.Relation.is_not_superset> as per
C<counted_is_superset>.

## sys.std.Counted.counted_is_proper_subset

C<< function counted_is_proper_subset (Bool <--
topic : Relation, other : Relation, count_attr_name : Name) {...} >>

This function is like C<sys.std.Core.Relation.is_proper_subset> as per
C<counted_is_subset>.  I<TODO: What is its definition?>

## sys.std.Counted.counted_is_not_proper_subset

C<< function counted_is_not_proper_subset (Bool <--
topic : Relation, other : Relation, count_attr_name : Name) {...} >>

This function is like C<sys.std.Core.Relation.is_not_proper_subset> as per
C<counted_is_subset>.  I<TODO: What is its definition?>

## sys.std.Counted.counted_is_proper_superset

C<< function counted_is_proper_superset (Bool <--
topic : Relation, other : Relation, count_attr_name : Name) {...} >>

This function is an alias for C<sys.std.Counted.counted_is_proper_subset>
except that it transposes the C<topic> and C<other> arguments.  This
function is like C<sys.std.Core.Relation.is_proper_superset> as per
C<counted_is_superset>.

## sys.std.Counted.counted_is_not_proper_superset

C<< function counted_is_not_proper_superset (Bool <--
topic : Relation, other : Relation, count_attr_name : Name) {...} >>

This function is an alias for
C<sys.std.Counted.counted_is_not_proper_subset> except that it transposes
the C<topic> and C<other> arguments.  This function is like
C<sys.std.Core.Relation.is_not_proper_superset> as per
C<counted_is_superset>.

## sys.std.Counted.counted_union

C<< function counted_union (Relation <--
topic : set_of.Relation, count_attr_name : Name) {...} >>

This function is like C<sys.std.Core.Relation.union> but that it just
looks at the C<tattrs> attributes of its argument elements when determining
what element tuples correspond; then for each tuple in the result, its
C<tcount> attribute value is the maximum of the C<tcount> attribute values
of its corresponding input element tuples.

## sys.std.Counted.counted_union_sum

C<< function counted_union_sum (Relation <--
topic : bag_of.Relation, count_attr_name : Name) {...} >>

This function is like C<sys.std.Counted.counted_union> but that for each
pair of argument elements being unioned, the output C<tcount> value is the
sum of the input C<tcount> values rather than being the maximum of the
inputs.  This function is the nearest Muldis D analogy to the SQL "UNION
ALL" operation, versus C<sys.std.Core.Relation.union> which is the nearest
analogy to "UNION DISTINCT".

## sys.std.Counted.counted_intersection

C<< function counted_intersection (Relation <--
topic : set_of.Relation, count_attr_name : Name) {...} >>

This function is like C<sys.std.Core.Relation.intersection> as
C<counted_union> is like C<sys.std.Core.Relation.union>; the minimum of
C<tcount> attribute values is used rather than the maximum.

## sys.std.Counted.counted_diff

C<< function counted_diff (Relation <--
source : Relation, filter : Relation, count_attr_name : Name) {...} >>

This function is like C<sys.std.Core.Relation.diff> as C<counted_union> is
like C<sys.std.Core.Relation.union>; for corresponding input tuples, the
result only has a tuple with the same C<tattrs> if the C<tcount> of the
C<source> tuple is greater than the C<tcount> of the C<filter> tuple, and
the C<tcount> of the result tuple is the difference of those two.

## sys.std.Counted.counted_substitution

C<< function counted_substitution (Relation <--
topic : Relation, attr_names : set_of.Name, func : ValMapPFuncNC,
count_attr_name : Name) {...} >>

This function is the same as C<sys.std.Core.Relation.substitution> except
that the C<counted_cardinality> of the result is guaranteed to be the same
as that of C<topic> rather than possibly less.  The C<topic> argument must
have a C<tcount> attribute and C<attr_names> must not specify that
attribute.

## sys.std.Counted.counted_static_subst

C<< function counted_static_subst (Relation <--
topic : Relation, attrs : Tuple, count_attr_name : Name) {...} >>

This function is the same as C<sys.std.Core.Relation.static_subst>
except that the C<counted_cardinality> of the result is guaranteed to be
the same as that of C<topic> rather than possibly less.  The C<topic>
argument must have a C<tcount> attribute and C<attrs> must not have that
attribute.

# AUTHOR

Darren Duncan (C<darren@DarrenDuncan.net>)

# LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
