=pod

=encoding utf8

=head1 NAME

Muldis::D::Core::Scalar - Muldis D operators for all scalar types

=head1 VERSION

This document is Muldis::D::Core::Scalar version 0.148.1.

=head1 PREFACE

This document is part of the Muldis D language specification, whose root
document is L<Muldis::D>; you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the L<Muldis::D::Core> document before this current
document, as that forms its own tree beneath a root document branch.

=head1 DESCRIPTION

This document describes essentially all of the core Muldis D generic
scalar operators, applicable to all scalar types.

I<This documentation is pending.>

=head1 GENERIC FUNCTIONS FOR SCALARS

These functions are applicable to mainly scalar types, but are generic in
that they typically work with any scalar types.  Now some of these
functions (those with a parameter named C<possrep>) work only with scalar
values that have possreps, and not with values of the 2 system-defined
scalar types lacking any possreps: C<Int>, C<String>; other functions are
not limited in that way, but may be limited in other ways.  Note that the
terminology used to describe these functions is taking advantage of the
fact that a scalar possrep looks just like a tuple.  Each C<possrep>
and C<name> parameter is optional and each defaults to the empty string if
no explicit argument is given to it.

=head2 sys.std.Core.Scalar.attr

C<< function attr (Universal <-- topic : ScalarWP,
possrep? : Name, name? : Name) {...} >>

This function results in the scalar or nonscalar value of the possrep
attribute of C<topic> where the possrep name is given by C<possrep> and the
attribute name is given by C<name>.  This function will fail if C<possrep>
specifies a possrep name that C<topic> doesn't have or C<name> specifies an
attribute name that the named possrep of C<topic> doesn't have.  Note that
this operation is also known as C<.{:}>.

=head2 sys.std.Core.Scalar.update_attr

C<< function update_attr (ScalarWP <-- topic : ScalarWP, possrep? : Name,
name? : Name, value : Universal) {...} >>

This function results in its C<topic> argument but that its possrep
attribute whose possrep name is C<possrep> and whose attribute name is
C<name> has been updated with a new scalar or nonscalar value given by
C<value>.  This function will fail if C<possrep> specifies a possrep name
that C<topic> doesn't have or C<name> specifies an attribute name that the
named possrep of C<topic> doesn't have, or if C<value> isn't of the
declared type of the attribute; this function will otherwise warn if the
declared type of C<value> isn't a subtype of the declared type of the
attribute.

=head2 sys.std.Core.Scalar.multi_update

C<< function multi_update (ScalarWP <--
topic : ScalarWP, possrep? : Name, attrs : Tuple) {...} >>

This function is like C<sys.std.Core.Scalar.update_attr> except that it
handles N scalar possrep attributes at once rather than just 1.  The
heading of the C<attrs> argument must be a subset of the heading of the
C<topic> argument's possrep named by C<possrep>; this function's result is
C<topic> with all the possrep attribute values of C<attrs> substituted into
it.  This function could alternately be named
I<sys.std.Core.Scalar.static_subst>.

=head2 sys.std.Core.Scalar.projection

C<< function projection (Tuple <-- topic : ScalarWP,
possrep? : Name, attr_names : set_of.Name) {...} >>

This function results in the C<Tuple> that is the projection of the
possrep (whose name is given in the C<possrep> argument) of its C<topic>
argument that has just the subset of attributes of C<topic> which are named
in its C<attr_names> argument.  As a trivial case, this function's result
is the entire named possrep of C<topic> if C<attr_names> lists all
attributes of that possrep; or, it is the nullary tuple if C<attr_names> is
empty.  This function will fail if C<possrep> specifies a possrep name that
C<topic> doesn't have or C<attr_names> specifies any attribute names that
C<topic> doesn't have.  Note that this operation is also known as C<{:}>.

=head2 sys.std.Core.Scalar.cmpl_proj

C<< function cmpl_proj (Tuple <--
topic : ScalarWP, possrep? : Name, attr_names : set_of.Name) {...} >>

This function is the same as C<projection> but that it results in the
complementary subset of possrep attributes of C<topic> when given the same
arguments.  Note that this operation is also known as C<{:!}>.

=head2 sys.std.Core.Scalar.Tuple_from_Scalar

C<< function Tuple_from_Scalar (Tuple <--
topic : ScalarWP, possrep? : Name) {...} >>

This function results in the C<Tuple> that has all the same attributes of
the possrep of C<topic> whose name is given in C<possrep>; in other words,
the function results in the externalization of one of a scalar value's
possreps.  This function will fail if C<possrep> specifies a possrep name
that C<topic> doesn't have.

=head2 sys.std.Core.Scalar.Scalar_from_Tuple

C<< function Scalar_from_Tuple (ScalarWP <--
topic : Tuple, type : APTypeNC, possrep? : Name) {...} >>

This function results in the C<ScalarWP> value whose scalar root
[|sub]type is named by C<type>, which has a possrep whose name matches
C<possrep>, and whose complete set of attributes of that named possrep
match the attributes of C<topic>.  This function can be used to select any
scalar value at all that has a possrep.

=head2 sys.std.Core.Scalar.has_possrep

C<< function has_possrep (Bool <-- topic : ScalarWP,
possrep? : Name) {...} >>

This function results in C<Bool:True> iff its C<topic> argument has a
possrep whose name is given by C<possrep>; otherwise it results in
C<Bool:False>.

=head2 sys.std.Core.Scalar.possrep_names

C<< function possrep_names (set_of.Name <-- topic : ScalarWP) {...} >>

This function results in the set of the names of the possreps of its
argument.

=head2 sys.std.Core.Scalar.degree

C<< function degree (NNInt <-- topic : ScalarWP, possrep? : Name) {...} >>

This function results in the degree of its C<topic> argument's possrep
whose name is given by C<possrep> (that is, the count of attributes the
possrep has).

=head2 sys.std.Core.Scalar.has_attrs

C<< function has_attrs (Bool <-- topic : ScalarWP,
possrep? : Name, attr_names : set_of.Name) {...} >>

This function results in C<Bool:True> iff, for every one of the attribute
names specified by its C<attr_names> argument, its C<topic> argument's
possrep whose name is given by C<possrep> has an attribute with that name;
otherwise it results in C<Bool:False>.  As a trivial case, this function's
result is C<Bool:True> if C<attr_names> is empty.

=head2 sys.std.Core.Scalar.attr_names

C<< function attr_names (set_of.Name <--
topic : ScalarWP, possrep? : Name) {...} >>

This function results in the set of the names of the attributes of its
C<topic> argument's possrep whose name is given by C<possrep>.

=head1 AUTHOR

Darren Duncan (C<darren@DarrenDuncan.net>)

=head1 LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of L<Muldis::D> for details.

=cut
