=pod

=encoding utf8

=head1 NAME

Muldis::D::Core::Collective - Muldis D generic collective operators

=head1 VERSION

This document is Muldis::D::Core::Collective version 0.148.1.

=head1 PREFACE

This document is part of the Muldis D language specification, whose root
document is L<Muldis::D>; you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the L<Muldis::D::Core> document before this current
document, as that forms its own tree beneath a root document branch.

=head1 DESCRIPTION

This document describes essentially all of the core Muldis D generic
operators that simple homogeneous collection types, that are more specific
than relations in general, would have.

I<This documentation is pending.>

=head1 VIRTUAL FUNCTIONS FOR THE COLLECTIVE MIXIN TYPE

=head2 sys.std.Core.Collective.has_member

C<< function has_member (Bool <--
coll@ : Collective, value : Universal) {...} >>

This function results in C<Bool:True> iff its C<value> argument matches a
member of the simple homogeneous collection value that is its C<coll>
argument, and C<Bool:False> otherwise.  Note that this operation is also
known as C<∋> or C<has>.

=head2 sys.std.Core.Collective.has_not_member

C<< function has_not_member (Bool <--
coll@ : Collective, value : Universal) {...} >>

This function is exactly the same as C<sys.std.Core.Collective.has_member>
except that it results in the opposite boolean value when given the same
arguments.  Note that this operation is also known as C<∌> or C<!has> or
C<not-has>.

=head2 sys.std.Core.Collective.value_is_member

C<< function value_is_member (Bool <--
value : Universal, coll@ : Collective) {...} >>

This function is an alias for C<sys.std.Core.Collective.has_member>.  This
function results in C<Bool:True> iff its C<value> argument matches a member
of the simple homogeneous collection value that is its C<coll> argument,
and C<Bool:False> otherwise.  Note that this operation is also known as
C<∈> or C<in>.

=head2 sys.std.Core.Collective.value_is_not_member

C<< function value_is_not_member (Bool <--
value : Universal, coll@ : Collective) {...} >>

This function is an alias for C<sys.std.Core.Collective.has_not_member>.
This function is exactly the same as
C<sys.std.Core.Collective.value_is_member> except that it results in the
opposite boolean value when given the same arguments.  Note that this
operation is also known as C<∉> or C<!in> or C<not-in>.

=head1 AUTHOR

Darren Duncan (C<darren@DarrenDuncan.net>)

=head1 LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of L<Muldis::D> for details.

=cut
