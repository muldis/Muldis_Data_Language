# NAME

Muldis::D::Core::Tuple - Muldis D generic tuple operators

# VERSION

This document is Muldis::D::Core::Tuple version 0.148.1.

# PREFACE

This document is part of the Muldis D language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

This document describes essentially all of the core Muldis D generic
tuple operators (for generic tuples).

I<This documentation is pending.>

# FUNCTIONS IMPLEMENTING VIRTUAL ATTRIBUTIVE FUNCTIONS

## sys.std.Core.Tuple.degree

C<< function degree (NNInt <-- topic : Tuple)
implements sys.std.Core.Attributive.degree {...} >>

This function results in the degree of its argument (that is, the count of
attributes it has).

## sys.std.Core.Tuple.is_nullary

C<< function is_nullary (Bool <-- topic : Tuple)
implements sys.std.Core.Attributive.is_nullary {...} >>

This function results in C<Bool:True> iff its argument has a degree of zero
(that is, it has zero attributes), and C<Bool:False> otherwise.  By
definition, the only 1 tuple value for which this function would result
in C<Bool:True> is the value C<Tuple:D0>.

## sys.std.Core.Tuple.is_not_nullary

C<< function is_not_nullary (Bool <-- topic : Tuple)
implements sys.std.Core.Attributive.is_not_nullary {...} >>

This function is exactly the same as C<sys.std.Core.Tuple.is_nullary>
except
that it results in the opposite boolean value when given the same argument.

## sys.std.Core.Tuple.has_attrs

C<< function has_attrs (Bool <-- topic : Tuple, attr_names : set_of.Name)
implements sys.std.Core.Attributive.has_attrs {...} >>

This function results in C<Bool:True> iff, for every one of the attribute
names specified by its C<attr_names> argument, its C<topic> argument has an
attribute with that name; otherwise it results in C<Bool:False>.  As a
trivial case, this function's result is C<Bool:True> if C<attr_names> is
empty.

## sys.std.Core.Tuple.attr_names

C<< function attr_names (set_of.Name <-- topic : Tuple)
implements sys.std.Core.Attributive.attr_names {...} >>

This function results in the set of the names of the attributes of its
argument.

## sys.std.Core.Tuple.rename

C<< function rename (Tuple <-- topic : Tuple, map : AttrRenameMap)
implements sys.std.Core.Attributive.rename {...} >>

This function results in a C<Tuple> value that is the same as its C<topic>
argument but that some of its attributes have different names.  Each tuple
of the argument C<map> specifies how to rename one C<topic> attribute, with
the C<after> and C<before> attributes of a C<map> tuple representing the
new and old names of a C<topic> attribute, respectively.  As a trivial
case, this function's result is C<topic> if C<map> has no tuples.  This
function supports renaming attributes to each others' names.  This function
will fail if C<map> specifies any old names that C<topic> doesn't have, or
any new names that are the same as C<topic> attributes that aren't being
renamed.

## sys.std.Core.Tuple.projection

C<< function projection (Tuple <-- topic : Tuple, attr_names : set_of.Name)
implements sys.std.Core.Attributive.projection {...} >>

This function results in the projection of its C<topic> argument that has
just the subset of attributes of C<topic> which are named in its
C<attr_names> argument.  As a trivial case, this function's result is
C<topic> if C<attr_names> lists all attributes of C<topic>; or, it is the
nullary tuple if C<attr_names> is empty.  This function will fail if
C<attr_names> specifies any attribute names that C<topic> doesn't have.

## sys.std.Core.Tuple.cmpl_proj

C<< function cmpl_proj (Tuple <-- topic : Tuple, attr_names : set_of.Name)
implements sys.std.Core.Attributive.cmpl_proj {...} >>

This function is the same as C<projection> but that it results in the
complementary subset of attributes of C<topic> when given the same
arguments.

## sys.std.Core.Tuple.static_exten

C<< function static_exten (Tuple <-- topic : Tuple, attrs : Tuple)
implements sys.std.Core.Attributive.static_exten {...} >>

This function results in the extension of its C<topic> argument by joining
that with its C<attrs> argument; the attribute names of the 2 arguments
must be disjoint.  See also C<sys.std.Core.Tuple.product> for an N-adic
version of this.

## sys.std.Core.Tuple.wrap

C<< function wrap (Tuple <-- topic : Tuple, outer : Name,
inner : set_of.Name) implements sys.std.Core.Attributive.wrap {...} >>

This function results in a C<Tuple> value that is the same as its C<topic>
argument but that some of its attributes have been wrapped up into a new
C<Tuple>-typed attribute, which exists in place of the original
attributes.  The C<inner> argument specifies which C<topic> attributes are
to be removed and wrapped up, and the C<outer> argument specifies the name
of their replacement attribute.  As a trivial case, if C<inner> is empty,
then the result has all the same attributes as before plus a new
tuple-typed attribute of degree zero; or, if C<inner> lists all attributes
of C<topic>, then the result has a single attribute whose value is the same
as C<topic>. This function supports the new attribute having the same name
as an old one being wrapped into it.  This function will fail if C<inner>
specifies any attribute names that C<topic> doesn't have, or if C<outer> is
the same as a C<topic> attribute that isn't being wrapped.

## sys.std.Core.Tuple.cmpl_wrap

C<< function cmpl_wrap (Tuple <-- topic : Tuple,
outer : Name, cmpl_inner : set_of.Name)
implements sys.std.Core.Attributive.cmpl_wrap {...} >>

This function is the same as C<wrap> but that it wraps the complementary
subset of attributes of C<topic> to those specified by C<cmpl_inner>.

## sys.std.Core.Tuple.unwrap

C<< function unwrap (Tuple <-- topic : Tuple, inner : set_of.Name,
outer : Name) implements sys.std.Core.Attributive.unwrap {...} >>

This function is the inverse of C<sys.std.Core.Tuple.wrap>, such that it
will unwrap a C<Tuple>-type attribute into its member attributes.  This
function will fail if C<outer> specifies any attribute name that C<topic>
doesn't have, or if an attribute of C<topic{outer}> has the same name as
another C<topic> attribute.  Now conceptually speaking, the C<inner>
parameter is completely superfluous for this C<Tuple> variant of C<unwrap>;
however, it is provided anyway so that this function has complete API
parity with the C<Relation> variant of C<unwrap>, where C<inner> I<is>
necessary in the general case, and so Muldis D code using this function is
also forced to be more self-documenting or strongly typed.  This function
will fail if C<inner> does not match the names of the attributes of
C<topic{outer}>.

# GENERIC RELATIONAL FUNCTIONS FOR TUPLES

These functions are applicable to mainly tuple types, but are generic
in that they typically work with any tuple types.

## sys.std.Core.Tuple.D0

C<< function D0 (Tuple <--) {...} >>

This C<named-value> selector function results in the only zero-attribute
Tuple value, which is known by the special name C<Tuple:D0>, aka C<D0>.

## sys.std.Core.Tuple.attr

C<< function attr (Universal <-- topic : Tuple, name : Name) {...} >>

This function results in the scalar or nonscalar value of the attribute
of C<topic> whose name is given by C<name>.  This function will fail if
C<name> specifies an attribute name that C<topic> doesn't have.  Note that
this operation is also known as C<.{}>.

## sys.std.Core.Tuple.update_attr

C<< function update_attr (Tuple <-- topic : Tuple,
name : Name, value : Universal) {...} >>

This function results in its C<topic> argument but that its attribute whose
name is C<name> has been updated with a new scalar or nonscalar value
given by C<value>.  This function will fail if C<name> specifies an
attribute name that C<topic> doesn't have; this function will otherwise
warn if the declared type of C<value> isn't a subtype of the declared type
of the attribute.

## sys.std.Core.Tuple.multi_update

C<< function multi_update (Tuple <-- topic : Tuple, attrs : Tuple) {...} >>

This function is like C<sys.std.Core.Tuple.update_attr> except that it
handles N tuple attributes at once rather than just 1.  The heading of
the C<attrs> argument must be a subset of the heading of the C<topic>
argument; this function's result is C<topic> with all the attribute values
of C<attrs> substituted into it.  This function could alternately be named
I<sys.std.Core.Tuple.static_subst>.

## sys.std.Core.Tuple.product

C<< function product (Tuple <-- topic : set_of.Tuple) {...} >>

This function is similar to C<sys.std.Core.Relation.product> but that it
works with tuples rather than relations.  This function is mainly
intended for use in connecting tuples that have all disjoint headings,
such as for extending one tuple with additional attributes.

## sys.std.Core.Tuple.attr_from_Tuple

C<< function attr_from_Tuple (Universal <-- topic : Tuple) {...} >>

This function results in the scalar or nonscalar value of the sole
attribute of its argument.  This function will fail if its argument is not
of degree 1.

## sys.std.Core.Tuple.Tuple_from_attr

C<< function Tuple_from_attr (Tuple <-- name : Name,
value : Universal) {...} >>

This function results in the C<Tuple> value which has just one attribute
whose name is given by C<name> and whose value is given by C<value>.

## sys.std.Core.Tuple.order_by_attr_names

C<< function order_by_attr_names (Order <-- topic : Tuple, other : Tuple,
order_by : array_of.OrderByName, is_reverse_order? : Bool) {...} >>

This C<order-determination> function provides convenient short-hand for the
common case of ordering tuples of a relation on a sequential list of
its named attributes, and the type of each of those attributes is a subtype
of a single scalar root type having a non-customizable (using C<misc_args>)
type-default C<order-determination> function, which is used to order on
that attribute.  This function is a short-hand for invoking
C<sys.std.Core.Cat.Order.reduction> on an C<Array> each of whose C<Order>
elements is the result of invoking C<sys.std.Core.Ordered.order> on the
corresponding attributes of C<topic> and C<other> whose names are given in
C<order_by>; the C<Array> given to C<Order.reduction> has the same number
of elements as C<order_by> has.  For each element value in C<order_by>, the
C<name> attribute specifies the attribute name of each of C<topic> and
C<other> to be compared, and the comparison operator's C<is_reverse_order>
argument is supplied by the C<is_reverse_order> attribute.  This function
will fail if C<topic> and C<other> don't have an identical degree and
attribute names, or if C<order_by> specifies any attribute names that
C<topic|other> doesn't have, or if for any attribute named to be ordered
by, that attribute's value for either of C<topic> and C<other> isn't a
member of a scalar root type having a type-default ordering function, or
if said root type isn't identical for both C<topic> and C<other>.  The
C<order_by_attr_names> function's C<is_reverse_order> argument is optional
and defaults to C<Bool:False>, meaning it has no further effect on the
function's behaviour; but if this argument is C<Bool:True>, then this
function will result in the opposite C<Order> value that it otherwise would
have when given all the same other argument values.  It is expected that
for any relation whose tuples are to be ordered using
C<order_by_attr_names>, the C<order_by> constitutes a key or superkey.

## sys.std.Core.Tuple.subst_in_default

C<< function subst_in_default (Tuple <-- of : APTypeNC,
subst : Tuple) {...} >>

This function results in the tuple value that is the default value of the
tuple data type whose name is given in the C<of> argument, but that zero
or more of its attribute values have been substituted by values given in
the C<subst> argument.  This function is a short-hand for
C<sys.std.Core.Tuple.multi_update> on the result of
C<sys.std.Core.Universal.default>.  This function will fail if either
C<default> would fail for the same C<of> argument, or if its result isn't a
tuple type, or if the heading of C<subst> isn't a subset of the heading
of the default.  The purpose of this function is to support greater brevity
in Muldis D coding such that users can define just part of a desired
tuple value and have the remainder filled in from defaults for them;
particularly useful with tuples that conceptually have some optional
attributes.

# UPDATERS IMPLEMENTING VIRTUAL ATTRIBUTIVE UPDATERS

# Updaters That Rename Attributes

## sys.std.Core.Tuple.assign_rename

C<updater assign_rename (&topic : Tuple, map : AttrRenameMap)
implements sys.std.Core.Attributive.assign_rename {...}>

This update operator is a short-hand for first invoking the
C<sys.std.Core.Tuple.rename> function with the same arguments, and then
assigning the result of that function to C<topic>.  This procedure is
analogous to the data-manipulation phase of a SQL RENAME TABLE|VIEW or
ALTER TABLE|VIEW RENAME TO statement iff C<topic> is C<Database>-typed;
each tuple of C<map> corresponds to a renamed SQL table.

# Updaters That Add Attributes

## sys.std.Core.Tuple.assign_static_exten

C<updater assign_static_exten (&topic : Tuple, attrs : Tuple)
implements sys.std.Core.Attributive.assign_static_exten {...}>

This update operator is a short-hand for first invoking the
C<sys.std.Core.Tuple.static_exten> function with the same arguments,
and then assigning the result of that function to C<topic>.  This procedure
is analogous to the data-manipulation phase of a SQL CREATE TABLE|VIEW
statement iff both arguments are C<Database>-typed; each relation-typed
attribute of C<attrs> corresponds to a created SQL table.

# Updaters That Remove Attributes

## sys.std.Core.Tuple.assign_projection

C<updater assign_projection (&topic : Tuple, attr_names : set_of.Name)
implements sys.std.Core.Attributive.assign_projection {...}>

This update operator is a short-hand for first invoking the
C<sys.std.Core.Tuple.projection> function with the same arguments, and
then assigning the result of that function to C<topic>.

## sys.std.Core.Tuple.assign_cmpl_proj

C<updater assign_cmpl_proj (&topic : Tuple, attr_names : set_of.Name)
implements sys.std.Core.Attributive.assign_cmpl_proj {...}>

This update operator is a short-hand for first invoking the
C<sys.std.Core.Tuple.cmpl_proj> function with the same arguments,
and then assigning the result of that function to C<topic>.  This procedure
is analogous to the data-manipulation phase of a SQL DROP TABLE|VIEW
statement iff C<topic> is C<Database>-typed; each relation-typed
attribute named by C<attr_names> corresponds to a dropped SQL table.

# AUTHOR

Darren Duncan (C<darren@DarrenDuncan.net>)

# LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
