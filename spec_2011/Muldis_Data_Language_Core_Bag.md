=pod

=encoding utf8

=head1 NAME

Muldis::D::Core::Bag - Muldis D Bag specific operators

=head1 VERSION

This document is Muldis::D::Core::Bag version 0.148.1.

=head1 PREFACE

This document is part of the Muldis D language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

=head1 DESCRIPTION

This document describes generic operators that are specific to the
C<Bag> parameterized relation type, and said operators
are short-hands for more generic relational operators.

I<This documentation is pending.>

=head1 FUNCTIONS IMPLEMENTING VIRTUAL COLLECTIVE FUNCTIONS

=head2 sys.std.Core.Bag.has_member

C<< function has_member (Bool <-- coll : Bag, value : Universal)
implements sys.std.Core.Collective.has_member {...} >>

This function is the same as C<sys.std.Core.Set.has_member>, including that
matching of C<value> is done against the C<value> attribute, except that it
works with a C<Bag> rather than a C<Set>.

=head2 sys.std.Core.Bag.has_not_member

C<< function has_not_member (Bool <-- coll : Bag, value : Universal)
implements sys.std.Core.Collective.has_not_member {...} >>

This function is exactly the same as C<sys.std.Core.Bag.has_member> except
that it results in the opposite boolean value when given the same
arguments.

=head2 sys.std.Core.Bag.value_is_member

C<< function value_is_member (Bool <-- value : Universal, coll : Bag)
implements sys.std.Core.Collective.value_is_member {...} >>

This function is an alias for C<sys.std.Core.Bag.has_member>.  This
function is the same as C<sys.std.Core.Set.value_is_member>, including that
matching of C<value> is done against the C<value> attribute, except that it
works with a C<Bag> rather than a C<Set>.

=head2 sys.std.Core.Bag.value_is_not_member

C<< function value_is_not_member (Bool <-- value : Universal, coll : Bag)
implements sys.std.Core.Collective.value_is_not_member {...} >>

This function is an alias for C<sys.std.Core.Bag.has_not_member>.  This
function
is exactly the same as C<sys.std.Core.Bag.value_is_member> except that it
results in the opposite boolean value when given the same arguments.

=head1 GENERIC RELATIONAL FUNCTIONS FOR BAGS

=head2 sys.std.Core.Bag.cardinality

C<< function cardinality (NNInt <-- topic : Bag) {...} >>

This function is like C<sys.std.Core.Relation.cardinality> but that it
accounts for the greater-than-one multiplicity of values in its argument;
it results in the sum of the C<count> attribute of its argument.  Note that
this operation is also known as C<#+>.

=head2 sys.std.Core.Bag.count

C<< function count (NNInt <-- bag : Bag, value : Universal) {...} >>

This function results in the multiplicity / count of occurrances of
C<value> in C<bag>; if a tuple exists in C<bag> whose C<value> attribute
is C<value>, then the result is its C<count> attribute; otherwise the
result is zero.

=head2 sys.std.Core.Bag.insertion

C<< function insertion (Bag <-- bag : Bag, value : Universal) {...} >>

This function is the same as C<sys.std.Core.Set.insertion> as per
C<has_member> but that its result differs depending on whether C<value>
already exists in C<bag>; if it does, then no new tuple is added, but the
C<count> attribute for the matching tuple is incremented by 1; if it does
not, then a new tuple is added where its C<value> is C<value> and its
C<count> is 1.  Actually this function differs in another way, such that it
is semantically the single-tuple case of C<sys.std.Core.Bag.union_sum>, and
is not the single-tuple case of C<sys.std.Core.Bag.union> (which is the
direct analogy to set union).

=head2 sys.std.Core.Bag.deletion

C<< function deletion (Bag <-- bag : Bag, value : Universal) {...} >>

This function is the same as C<sys.std.Core.Set.deletion> as per
C<has_member> but that its result differs depending on what the C<count>
for any tuple matching C<value> that already exists in C<bag> is; if the
C<count> is greater than 1, then it is decremented by 1; if it is equal to
1, then the tuple whose C<value> attribute is C<value> is deleted.

=head2 sys.std.Core.Bag.reduction

C<< function reduction (Universal <-- topic : Bag,
func : ValRedPFuncNC, identity : Universal) {...} >>

This function is the same as C<sys.std.Core.Set.reduction>, including that
input values for the reduction come from the C<value> attribute of
C<topic>, except that it works with a C<Bag> rather than a C<Set>;
C<func> is invoked extra times, where both its C<v1> and C<v2> arguments
might be different instances of the same value having >= 2 multiplicity.

=head2 sys.std.Core.Bag.Bag_from_wrap

C<< function Bag_from_wrap (bag_of.Tuple <-- topic : Relation) {...} >>

This function results in a C<Bag> whose C<value> attribute is tuple-typed
and that attribute's values are all the tuples of C<topic>; it is a
short-hand for a relational wrap of all attributes of C<topic> such that
the new tuple-valued attribute is named C<value>, and then that result is
extended with a C<count> attribute whose value for every tuple is 1.

=head2 sys.std.Core.Bag.Bag_from_cmpl_group

C<< function Bag_from_cmpl_group (bag_of.Tuple <--
topic : Relation, group_per : set_of.Name) {...} >>

This function is like C<sys.std.Core.Relation.cardinality_per_group> but
that the C<count_attr_name> is C<count> and all the other attributes that
would have been in the result are wrapped in a single tuple-valued
attribute named C<value>.  This function is to C<cardinality_per_group>
what C<sys.std.Core.Array.Array_from_wrap> is to
C<sys.std.Core.Relation.rank>.

=head2 sys.std.Core.Bag.Bag_from_attr

C<< function Bag_from_attr (Bag <-- topic : Relation, name : Name) {...} >>

This function results in a C<Bag> consisting of all the values of the
attribute of C<topic> named by C<name>.  It is a short-hand for first doing
a relational group on all attributes of C<topic> besides C<name> to produce
a new relation-typed attribute, and then extending the result of the
group with a new positive integer attribute whose values are the
cardinality of the relation-valued attribute's values, and then doing a
binary projection of the named attribute and the new integer attribute plus
their renaming to C<value> and C<count> respectively.

=head2 sys.std.Core.Bag.is_subset

C<< function is_subset (Bool <-- topic : Bag, other : Bag) {...} >>

This function is like C<sys.std.Core.Relation.is_subset> but that it
accounts for the greater-than-one multiplicity of values in its arguments;
this function returns C<Bool:True> iff the multiplicity of each C<topic>
value is less than or equal to the multiplicity of its counterpart
C<other> value.  Note that this operation is also known as C<⊆+> or
C<< {<=}+ >>.

=head2 sys.std.Core.Bag.is_not_subset

C<< function is_not_subset (Bool <-- topic : Bag, other : Bag) {...} >>

This function is like C<sys.std.Core.Relation.is_not_subset> as per
C<is_subset>.  Note that this operation is also known as C<⊈+> or
C<< {!<=}+ >>.

=head2 sys.std.Core.Bag.is_superset

C<< function is_superset (Bool <-- topic : Bag, other : Bag) {...} >>

This function is an alias for C<sys.std.Core.Bag.is_subset> except that it
transposes the C<topic> and C<other> arguments.  This function is like
C<sys.std.Core.Relation.is_superset> but that it accounts for the
greater-than-one multiplicity of values in its arguments; this function
returns C<Bool:True> iff the multiplicity of each C<topic> value is greater
than or equal to the multiplicity of its counterpart C<other> value.
Note that this operation is also known as C<⊇+> or C<< {>=}+ >>.

=head2 sys.std.Core.Bag.is_not_superset

C<< function is_not_superset (Bool <-- topic : Bag, other : Bag) {...} >>

This function is an alias for C<sys.std.Core.Bag.is_not_subset> except that
it transposes the C<topic> and C<other> arguments.  This function is like
C<sys.std.Core.Relation.is_not_superset> as per C<is_superset>.
Note that this operation is also known as C<⊉+> or C<< {!>=}+ >>.

=head2 sys.std.Core.Bag.is_proper_subset

C<< function is_proper_subset (Bool <-- topic : Bag, other : Bag) {...} >>

This function is like C<sys.std.Core.Relation.is_proper_subset> as per
C<is_subset>.  I<TODO: What is its definition?>
Note that this operation is also known as C<⊂+> or C<< {<}+ >>.

=head2 sys.std.Core.Bag.is_not_proper_subset

C<< function is_not_proper_subset (Bool <-- topic : Bag,
other : Bag) {...} >>

This function is like C<sys.std.Core.Relation.is_not_proper_subset> as per
C<is_subset>.  I<TODO: What is its definition?>
Note that this operation is also known as C<⊄+> or C<< {!<}+ >>.

=head2 sys.std.Core.Bag.is_proper_superset

C<< function is_proper_superset (Bool <-- topic : Bag,
other : Bag) {...} >>

This function is an alias for C<sys.std.Core.Bag.is_proper_subset> except
that it transposes the C<topic> and C<other> arguments.  This function is
like C<sys.std.Core.Relation.is_proper_superset> as per C<is_superset>.
Note that this operation is also known as C<⊃+> or C<< {>}+ >>.

=head2 sys.std.Core.Bag.is_not_proper_superset

C<< function is_not_proper_superset (Bool <--
topic : Bag, other : Bag) {...} >>

This function is an alias for C<sys.std.Core.Bag.is_not_proper_subset>
except that it transposes the C<topic> and C<other> arguments.  This
function is like C<sys.std.Core.Relation.is_not_proper_superset> as per
C<is_superset>.  Note that this operation is also known as C<⊅+> or
C<< {!>}+ >>.

=head2 sys.std.Core.Bag.union

C<< function union (Bag <-- topic : set_of.Bag) {...} >>

This function is like C<sys.std.Core.Relation.union> but that it just
looks at the C<value> attribute of its argument elements when determining
what element tuples correspond; then for each tuple in the result, its
C<count> attribute value is the maximum of the C<count> attribute values of
its corresponding input element tuples.  Note that this operation is
also known as C<∪+> or C<union+>.

=head2 sys.std.Core.Bag.union_sum

C<< function union_sum (Bag <-- topic : bag_of.Bag) {...} >>

This function is like C<sys.std.Core.Bag.union> but that for each pair of
argument elements being unioned, the output C<count> value is the sum of
the input C<count> values rather than being the maximum of the inputs.
Note that this operation is also known as C<∪++> or C<union++>.

=head2 sys.std.Core.Bag.intersection

C<< function intersection (Bag <-- topic : set_of.Bag) {...} >>

This function is like C<sys.std.Core.Relation.intersection> as C<union> is
like C<sys.std.Core.Relation.union>; the minimum of C<count> attribute
values is used rather than the maximum.  Note that this
operation is also known as C<∩+> or C<intersect+>.

=head2 sys.std.Core.Bag.diff

C<< function diff (Bag <-- source : Bag, filter : Bag) {...} >>

This function is like C<sys.std.Core.Relation.diff> as C<union> is
like C<sys.std.Core.Relation.union>; for corresponding input tuples, the
result only has a tuple with the same C<value> if the C<count> of the
C<source> tuple is greater than the C<count> of the C<filter> tuple,
and the C<count> of the result tuple is the difference of those two.
Note that this operation is also known as C<minus+> or C<except+> or C<∖+>.

=head1 AUTHOR

Darren Duncan (C<darren@DarrenDuncan.net>)

=head1 LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.

=cut
