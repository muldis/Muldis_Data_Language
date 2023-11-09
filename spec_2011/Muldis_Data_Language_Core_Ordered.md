# NAME

Muldis::D::Core::Ordered - Muldis D generic ordered-sensitive operators

# VERSION

This document is Muldis::D::Core::Ordered version 0.148.1.

# PREFACE

This document is part of the Muldis D language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

This document describes essentially all of the core Muldis D
ordered-sensitive operators, essentially all the generic ones that a
typical programming language should have.

I<This documentation is pending.>

# VIRTUAL FUNCTIONS FOR THE ORDERED MIXIN TYPE

Rather than having a whole set of virtual functions for the C<Ordered>
mixin, such as before/after/min/max/between/etc, we have just the one
C<order> for each ordered type to implement, and then all the other
ordered-sensitive routines (before/etc) just wrap the virtual C<order>.

## sys.std.Core.Ordered.order

C<< function order (Order <-- topic@ : Ordered,
other@ : Ordered, misc_args? : Tuple, is_reverse_order? : Bool) {...} >>

This virtual (total) C<order-determination> function results in
C<Order:Same> iff its C<topic> and C<other> arguments are exactly the same
value, and otherwise it results in C<Order:Less> if the value of the
C<other> argument is considered to be an increase (as defined by the
implementing function) over the value of the C<topic> argument, and
otherwise it results in C<Order:More> as the reverse of the last
condition would be true.  This function will fail if its C<topic> and
C<other> arguments are not values of a common ordered type for which an
C<order-determination> function is defined that explicitly implements this
function.  Note that C<order-determination> functions are considered the
only fundamental order-sensitive operators, and all others are defined over
them.  This function also has a C<Tuple>-typed third parameter, named
C<misc_args>, which carries optional customization details for the
order-determination algorithm; this permits the function to implement a
choice between multiple (typically similar) ordering algorithms rather than
just one, which reduces the number of functions needed for supporting that
choice; if the algorithm is not customizable, then a tuple argument would
be of degree zero.  This function also has a C<Bool>-typed fourth
parameter, named C<is_reverse_order>; a C<Bool:False> argument means the
function's algorithm operates as normal when given any particular 3 other
arguments (meaning a sorting operation based on it will place elements in
ascending order), while a C<Bool:True> argument means the function's
algorithm operates in reverse, so the function results in the reverse
C<Order> value it would have otherwise when given the same 3 other
arguments (meaning a sorting operation based on it will place elements in
descending order).  The C<misc_args> and C<is_reverse_order> parameters are
optional and default to the zero-attribute tuple and C<Bool:False>,
respectively, if no explicit arguments are given to them.

# VIRTUAL FUNCTIONS FOR THE ORDINAL MIXIN TYPE

Conceivably, the C<Ordinal> mixin could come with functions like I<first>
or I<last>, since such are common practice for ordinal types in other
languages or contexts, to complement the C<pred> and C<succ> functions,
providing the basis to take an C<Ordinal> type and enumerate all of its
values.  However, that common practice is generally based in contexts where
all ordinal types are finite, such as a "32 bit integer" type.  In Muldis
D, there is no requirement for an C<Ordinal>-composing type to be finite,
and at least 1 system-defined ordinal type, C<Int>, is instead unlimited,
and there is no concept of a first or last C<Int> that can be counted from.
Therefore, C<Ordinal> has no I<first> or I<last>, and if you want to
enumerate an ordinal type's values, the canonical means to do so is to
start with that type's I<default> value instead, which the system-defined
C<default> function provides; starting with the default value, you can
reach all values of any ordinal Muldis D type eventually, enumerating your
way to them in sequence using either C<pred> to go earlier and C<succ> to
go later, for any arbitrary distance along the ordinal type's value line.
I<In the future, if a finite-ordinal mixin type is deemed useful and is
created, then actual "first" and "last" functions could be made for it.>

## sys.std.Core.Ordered.Ordinal.pred

C<< function pred (Ordinal <-- topic@ : Ordinal) {...} >>

This virtual function results in the value that precedes its argument, iff
the argument has a preceding value according to the C<Ordinal>-composing
type of the argument; otherwise, this virtual function results in the
singleton value C<-Inf> (negative infinity), which can be tested for to
know you've run out of values.  Note that this operation is also known as
C<-->.

## sys.std.Core.Ordered.Ordinal.succ

C<< function succ (Ordinal <-- topic@ : Ordinal) {...} >>

This virtual function results in the value that succeeds its argument, iff
the argument has a succeeding value according to the C<Ordinal>-composing
type of the argument; otherwise, this virtual function results in the
singleton value C<Inf> (positive infinity), which can be tested for to know
you've run out of values.  Note that this operation is also known as C<++>.

# GENERIC ORDERED-SENSITIVE FUNCTIONS FOR ALL DATA TYPES

These are generic operators that are sensitive
to an ordering of a type's values, and are used for such things as list
sorting or quota queries or determining before/after/min/max/between/etc.
They can potentially be used with values of any data type as long as said
data type has a (total) C<order-determination> function defined for it,
and all system-defined conceptually-ordered Muldis D scalar root types do.

Each of these functions is a wrapper over the C<order-determination>
function named C<sys.std.Core.Ordered.order> when the latter function is
primed by a C<misc_args> argument of C<Tuple:D0> and by
a calling-function-specific C<is_reverse_order> argument value.

## sys.std.Core.Ordered.is_before

C<< function is_before (Bool <-- topic : Ordered, other : Ordered) {...} >>

This function results in C<Bool:True> iff C<sys.std.Core.Ordered.order>
would result
in C<Order:Less> when given the same corresponding 2 arguments plus an
C<is_reverse_order> argument of C<Bool:False>, and C<Bool:False> otherwise.
Note that this operation is also known as I<less than> or C<< < >>.

## sys.std.Core.Ordered.is_after

C<< function is_after (Bool <-- topic : Ordered, other : Ordered) {...} >>

This function is an alias for C<sys.std.Core.Ordered.is_before> except
that it transposes the C<topic> and C<other> arguments.  This function
results in C<Bool:True> iff C<sys.std.Core.Ordered.order> would result in
C<Order:More> when given the same corresponding 2 arguments plus an
C<is_reverse_order> argument of C<Bool:False>, and C<Bool:False> otherwise.
Note that this operation is also known as I<greater than> or C<< > >>.

## sys.std.Core.Ordered.is_before_or_same

C<< function is_before_or_same (Bool <--
topic : Ordered, other : Ordered) {...} >>

This function is exactly the same as C<sys.std.Core.Ordered.is_before>
except that it results in C<Bool:True> if its 2 primary arguments are
identical.  Note that this operation is also known as I<less than or equal
to> or C<≤>.

## sys.std.Core.Ordered.is_after_or_same

C<< function is_after_or_same (Bool <--
topic : Ordered, other : Ordered) {...} >>

This function is an alias for C<sys.std.Core.Ordered.is_before_or_same>
except that it transposes the C<topic> and C<other> arguments.  This
function is exactly the same as C<sys.std.Core.Ordered.is_after> except
that it results in C<Bool:True> if its 2 primary arguments are identical.
Note that this operation is also known as I<greater than or equal to> or
C<≥>.

## sys.std.Core.Ordered.min

C<< function min (Ordered <-- topic : set_of.Ordered) {...} >>

This function is a reduction operator that recursively takes each pair of
its N input element values and picks the minimum of the 2 (which is
commutative, associative, and idempotent) until just one is left, which is
the function's result.  If C<topic> has zero values, then C<min> results in
the singleton value C<Inf> (positive infinity), which is the identity value
for C<min>.

## sys.std.Core.Ordered.max

C<< function max (Ordered <-- topic : set_of.Ordered) {...} >>

This function is exactly the same as C<sys.std.Core.Ordered.min> except
that it results in the maximum input element value rather than the minimum
one, and that C<max>'s identity value is C<-Inf> (negative infinity).

## sys.std.Core.Ordered.minmax

C<< function minmax (Tuple <-- topic : set_of.Ordered) {...} >>

This function results in a binary tuple whose attribute names are C<min>
and C<max> and whose respective attribute values are what
C<sys.std.Core.Ordered.min> and C<sys.std.Core.Ordered.max> would
result in when given the same arguments.

# VIRTUAL UPDATERS FOR THE ORDINAL MIXIN TYPE

## sys.std.Core.Ordered.Ordinal.assign_pred

C<updater assign_pred (&topic@ : Ordinal) {...}>

This update operator is a short-hand for first invoking the
C<sys.std.Core.Ordered.Ordinal.pred> function with the same argument, and
then assigning the result of that function to its argument.  Note that this
operation is also known as C<:=-->.

## sys.std.Core.Ordered.Ordinal.assign_succ

C<updater assign_succ (&topic@ : Ordinal) {...}>

This update operator is a short-hand for first invoking the
C<sys.std.Core.Ordered.Ordinal.succ> function with the same argument, and
then assigning the result of that function to its argument.  Note that this
operation is also known as C<:=++>.

# AUTHOR

Darren Duncan (C<darren@DarrenDuncan.net>)

# LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
