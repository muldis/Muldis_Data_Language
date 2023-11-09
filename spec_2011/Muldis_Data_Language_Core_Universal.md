=pod

=encoding utf8

=head1 NAME

Muldis::D::Core::Universal - Muldis D generic operators for all data types

=head1 VERSION

This document is Muldis::D::Core::Universal version 0.148.1.

=head1 PREFACE

This document is part of the Muldis D language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

=head1 DESCRIPTION

This document describes essentially all of the core Muldis D generic
universal operators, applicable to all data types.

=head1 GENERIC FUNCTIONS FOR ALL DATA TYPES

These functions are applicable to values of any data type at all.

=head2 sys.std.Core.Universal.is_same

C<< function is_same (Bool <--
topic : Universal, other : Universal) {...} >>

This symmetric function results in C<Bool:True> iff its 2
arguments are exactly the same value, and C<Bool:False> otherwise.  When
this function results in C<Bool:True>, its 2 arguments might actually
differ in their internals, but the DBMS considers them alike in all of the
ways that truly matter, such that nothing of significance would be lost if
the DBMS were to replace any occurrance of one argument known to it with
the other argument, and said replacement would be useable in all of the
same ways by any code expecting the original.  This
function will warn if, in regards to the declared types of its arguments,
none of the following are true: 1. they are both subtypes of a common
scalar root type; 2. they are both subtypes of a common complete tuple
or relation type, that is they essentially have the same headings; 3. at
least one type is a generic (eg-C<Universal>) or incomplete
(eg-C<Relation>) type, and it is a supertype of the other.  Note that
this operation is also known as I<is equal> or C<=>.

=head2 sys.std.Core.Universal.is_not_same

C<< function is_not_same (Bool <--
topic : Universal, other : Universal) {...} >>

This symmetric function is exactly the same as
C<sys.std.Core.Universal.is_same> except that it results in the
opposite boolean value when given the same arguments.  Note that this
operation is also known as I<is not equal> or C<≠> or C<!=>.

=head2 sys.std.Core.Universal.is_value_of_type

C<< function is_value_of_type (Bool <--
topic : Universal, type : APTypeNC) {...} >>

This function results in C<Bool:True> iff the value of its C<topic>
argument is a member of the data type whose name is given in the C<type>
argument, and C<Bool:False> otherwise.  As trivial cases, this function
always results in C<Bool:True> if the named type is C<Universal>, and
C<Bool:False> if it is C<Empty>.  This function will fail if the named type
doesn't exist in the virtual machine.  Note that this operation is also
known as C<isa>.

=head2 sys.std.Core.Universal.is_not_value_of_type

C<< function is_not_value_of_type (Bool <--
topic : Universal, type : APTypeNC) {...} >>

This function is exactly the same as
C<sys.std.Core.Universal.is_value_of_type> except that it results in the
opposite boolean value when given the same arguments.  Note that this
operation is also known as C<!isa> or C<not-isa>.

=head2 sys.std.Core.Universal.treated

C<< function treated (Universal <--
topic : Universal, as : APTypeNC) {...} >>

This function results in the value of its C<topic> argument, but that the
declared type of the result is the not-C<Empty> data type whose name is
given in the C<as> argument.  This function will fail if the named type
doesn't exist in the virtual machine, or if C<topic> isn't a member of the
named type.  The purpose of C<treated> is to permit taking values from a
context having a more generic declared type, and using them in a context
having a more specific declared type; such an action would otherwise be
blocked at compile time due to a type-mismatch error; C<treated> causes the
type-mismatch validation, and possible failure, to happen at runtime
instead, on the actual value rather than declared value.  For example, if
you are storing an C<Int> value in a C<Scalar>-typed variable, using
C<treated> will cause the compiler to let you use that variable as an
argument to C<sys.std.Core.Integer.diff>, which it otherwise wouldn't.
Note that this operation is also known as C<as>.

=head2 sys.std.Core.Universal.default

C<< function default (Universal <-- of : APTypeNC) {...} >>

This function is the externalization of a not-C<Empty> data type's I<type
default> C<named-value> function.  This function results in the default
value of the not-C<Empty> data type whose name is given in the C<of>
argument, and the declared type of the result is that same type.  This
function will fail if the named type doesn't exist in the virtual machine,
either at compile or runtime depending whether the type is in the system or
user namespace. This function is conceptually implicitly used to provide
default values for variables, so they always hold valid values of their
declared type.

=head2 sys.std.Core.Universal.assertion

C<< function assertion (Universal <--
result : Universal, is_true : Bool) {...} >>

This function results in the value of its C<result> argument, when its
C<is_true> argument is C<Bool:True>.  This function will fail if its
C<is_true> argument is C<Bool:False>.  The purpose of C<assertion> is to
perform condition assertions in a pure functional context that may be
better done without the overhead of creating a new constrained data type,
especially when the assertion is on some fact that is only known after
performing calculations from multiple function arguments; this can
potentially be done at compile time as per type constraints.  Note that
this operation is also known as C<asserting>.

=head1 GENERIC UPDATERS FOR ALL DATA TYPES

These update operators are applicable to values of any data type at all.

=head2 sys.std.Core.Universal.assign

C<updater assign (&target : Universal, v : Universal) {...}>

This update operator will update the variable supplied as its C<target>
argument so that it holds the value supplied as its C<v> argument.  This
updater will fail if C<v> isn't of the declared type of the variable behind
C<target>; this function will otherwise warn if the declared type of C<v>
isn't a subtype of the declared type of the variable behind C<target>.
Note that this operation is also known as C<:=>.

=head1 AUTHOR

Darren Duncan (C<darren@DarrenDuncan.net>)

=head1 LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.

=cut
