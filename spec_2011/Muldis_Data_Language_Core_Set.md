=pod

=encoding utf8

=head1 NAME

Muldis::D::Core::Set - Muldis D Set and Maybe specific operators

=head1 VERSION

This document is Muldis::D::Core::Set version 0.148.1.

=head1 PREFACE

This document is part of the Muldis D language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

=head1 DESCRIPTION

This document describes generic operators that are specific to the
C<Set> and C<Maybe> parameterized relation types, and said operators
are short-hands for more generic relational operators.

I<This documentation is pending.>

=head1 FUNCTIONS IMPLEMENTING VIRTUAL COLLECTIVE FUNCTIONS

=head2 sys.std.Core.Set.has_member

C<< function has_member (Bool <-- coll : Set, value : Universal)
implements sys.std.Core.Collective.has_member {...} >>

This function results in C<Bool:True> iff its C<value> argument matches the
sole attribute of a tuple of its C<coll> argument (that is, iff
conceptually C<value> is a member of C<coll>), and C<Bool:False> otherwise.
This function will warn if its 2 arguments are incompatible as per
C<sys.std.Core.Relation.is_subset>.

=head2 sys.std.Core.Set.has_not_member

C<< function has_not_member (Bool <-- coll : Set, value : Universal)
implements sys.std.Core.Collective.has_not_member {...} >>

This function is exactly the same as C<sys.std.Core.Set.has_member> except
that it results in the opposite boolean value when given the same
arguments.

=head2 sys.std.Core.Set.value_is_member

C<< function value_is_member (Bool <-- value : Universal, coll : Set)
implements sys.std.Core.Collective.value_is_member {...} >>

This function is an alias for C<sys.std.Core.Set.has_member>.  This
function results in C<Bool:True> iff its C<value> argument matches the
sole attribute of a tuple of its C<coll> argument (that is, iff
conceptually C<value> is a member of C<coll>), and C<Bool:False>
otherwise.

=head2 sys.std.Core.Set.value_is_not_member

C<< function value_is_not_member (Bool <-- value : Universal, coll : Set)
implements sys.std.Core.Collective.value_is_not_member {...} >>

This function is an alias for C<sys.std.Core.Set.has_not_member>.  This
function is exactly the same as C<sys.std.Core.Set.value_is_member> except
that it results in the opposite boolean value when given the same
arguments.

=head1 GENERIC RELATIONAL FUNCTIONS FOR SETS

=head2 sys.std.Core.Set.insertion

C<< function insertion (Set <-- set : Set, value : Universal) {...} >>

This function results in a C<Set> that is the relational union of C<set>
and a Set whose sole tuple has the sole attribute value of C<value>;
that is, conceptually the result is C<value> inserted into C<set>.  As a
trivial case, if C<value> already exists in C<set>, then the result is just
C<set>.

=head2 sys.std.Core.Set.disjoint_ins

C<< function disjoint_ins (Set <-- set : Set, value : Universal) {...} >>

This function is exactly the same as C<sys.std.Core.Set.insertion> except
that it will fail if C<value> already exists in C<set>.

=head2 sys.std.Core.Set.deletion

C<< function deletion (Set <-- set : Set, value : Universal) {...} >>

This function results in a C<Set> that is the relational difference from
C<set> of a Set whose sole tuple has the sole attribute value of
C<value>; that is, conceptually the result is C<value> deleted from C<set>.
As a trivial case, if C<value> already doesn't exist in C<set>, then the
result is just C<set>.

=head2 sys.std.Core.Set.reduction

C<< function reduction (Universal <-- topic : Set,
func : ValRedPFuncNC, identity : Universal) {...} >>

This function is a generic reduction operator that recursively takes each
pair of input values in C<topic> and applies an argument-specified scalar
or nonscalar value-resulting C<value-reduction> function (which is both
commutative and associative) to the pair until just one input value is
left, which is the result.  The C<value-reduction> function to apply is
named in the C<func> argument, and that
function must have 2 parameters named C<v1> and C<v2>, which take
the 2 input scalar or nonscalar values for an
invocation.  If C<topic> has zero values, then C<reduction> results in the
value given in C<identity>.  I<Note that C<identity> may be changed to take
a function name rather than a value, for consistency with C<func>.>  This
function will fail|warn if the |declared type of C<identity> isn't a
subtype of the |declared type of the sole attribute of C<topic>.

=head2 sys.std.Core.Set.Set_from_wrap

C<< function Set_from_wrap (set_of.Tuple <-- topic : Relation) {...} >>

This function results in a C<Set> whose sole attribute is tuple-typed
and the attribute values are all the tuples of C<topic>; is a short-hand
for a relational wrap of all attributes of C<topic> such that the new
tuple-valued attribute is named C<value>.

=head2 sys.std.Core.Set.Set_from_attr

C<< function Set_from_attr (Set <-- topic : Relation, name : Name) {...} >>

This function results in a C<Set> consisting of all the values of the
attribute of C<topic> named by C<name>.  It is a short-hand for a unary
projection of just the named attribute plus its renaming to C<value>.

=head1 GENERIC RELATIONAL FUNCTIONS FOR MAYBES

=head2 sys.std.Core.Set.Maybe.Nothing

C<< function Nothing (Maybe <--) {...} >>

This C<named-value> selector function results in the only zero-tuple Maybe
value, which is known by the special name C<Maybe:Nothing>, aka C<Nothing>,
aka I<empty set> aka C<∅>.

=head2 sys.std.Core.Set.Maybe.just

C<< function just (Just <-- value : Universal) {...} >>

This selector function results in the Maybe value with a single tuple
whose C<value> attribute's value is the C<value> argument.

=head2 sys.std.Core.Set.Maybe.attr

C<< function attr (Universal <-- topic : Just) {...} >>

This function results in the scalar or nonscalar value of the sole
attribute of the sole tuple of its argument, which always exists when the
argument is a C<Just>.  Note that this operation is also known as C<.{*}>.

=head2 sys.std.Core.Set.Maybe.attr_or_default

C<< function attr_or_default (Universal <--
topic? : array_of.Maybe, default : APTypeNC) {...} >>

This function results in the scalar or nonscalar value of the sole
attribute of the sole tuple of the lowest-indexed of its N C<topic> input
element values where said element isn't equal to C<Nothing>, if there is
such an element; otherwise, it results in the default value of the scalar
or nonscalar data type whose name is given in the C<default> argument.
This function is a short-hand for invoking C<attr_or_value> with the result
from invoking C<sys.std.Core.Universal.default>.

=head2 sys.std.Core.Set.Maybe.attr_or_value

C<< function attr_or_value (Universal <--
topic? : array_of.Maybe, value : Universal) {...} >>

This function results in the scalar or nonscalar value of the sole
attribute of the sole tuple of the lowest-indexed of its N C<topic> input
element values where said element isn't equal to C<Nothing>, if there is
such an element, and otherwise it results in C<value>.  This function will
warn if the declared type of C<value> isn't a subtype of the declared type
of the attribute.  Note that this operation is also known as C<//>.  In
situations where a C<Maybe> is used analogously to a SQL nullable value,
this function is analogous to the N-adic SQL COALESCE function.

=head2 sys.std.Core.Set.Maybe.order

C<< function order (Order <-- topic : Maybe,
other : Maybe, J_ord_func? : OrdDetPFuncNC, J_is_reverse_order? : Bool,
N_is_after_all_J : Bool, is_reverse_order? : Bool) {...} >>

This function is a generic (total) C<order-determination> function for
C<Maybe> values.  Iff both of its C<topic> and C<other> arguments are
identical, this function results in C<Order:Same>.  Otherwise, iff both of
those 2 arguments are C<Just> values, then the result of this function
is the result of applying to those 2 arguments the (total)
C<order-determination> function given in its C<J_ord_func> argument, as
primed by its C<J_is_reverse_order> argument; to be specific, the
C<order-determination> function takes the attribute values of C<topic> and
C<other>, not the whole C<Just> values.  Otherwise, iff C<topic> is
C<Nothing>, this function results in C<Order:Less> or C<Order:More>
respectively when C<N_is_after_all_J> is C<Bool:False> (the default) or
C<Bool:True>.  Otherwise (iff C<other> is C<Nothing>), this function
results in the reverse of when only C<topic> is C<Nothing>.  The
C<is_reverse_order> argument is applied to the result of this function
I<after> all of the other arguments are applied; if it is C<Bool:False>, it
does not change the result; if it is C<Bool:True>, then it reverses the
result.  In situations where a C<Maybe> is used analogously to a SQL
nullable value and this function is analogous to the dyadic comparison
underlying a SQL "ORDER BY", then C<J_is_reverse_order> designates SQL's
"ASC|DESC" and C<N_is_after_all_J> designates SQL's "NULLS FIRST|LAST".

=head1 AUTHOR

Darren Duncan (C<darren@DarrenDuncan.net>)

=head1 LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.

=cut
