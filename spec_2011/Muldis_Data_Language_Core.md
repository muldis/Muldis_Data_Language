=pod

=encoding utf8

=head1 NAME

Muldis::D::Core - Muldis D core data types and operators

=head1 VERSION

This document is Muldis::D::Core version 0.148.1.

=head1 PREFACE

This document is part of the Muldis D language specification, whose root
document is L<Muldis::D>; you should read that root document
before you read this one, which provides subservient details.

That said, because this C<Core> document is otherwise too large to
comfortably fit in one file, it has been split into pieces and therefore
has its own tree of parts to follow, which it is the root of:
L<Muldis::D::Core::Types>, L<Muldis::D::Core::Types_Catalog>,
L<Muldis::D::Core::Universal>, L<Muldis::D::Core::Ordered>,
L<Muldis::D::Core::Scalar>, L<Muldis::D::Core::Boolean>,
L<Muldis::D::Core::Numeric>, L<Muldis::D::Core::Integer>,
L<Muldis::D::Core::Rational>, L<Muldis::D::Core::Stringy>,
L<Muldis::D::Core::Blob>, L<Muldis::D::Core::Text>,
L<Muldis::D::Core::Cast>, L<Muldis::D::Core::Attributive>,
L<Muldis::D::Core::Tuple>, L<Muldis::D::Core::Relation>,
L<Muldis::D::Core::Collective>, L<Muldis::D::Core::Set>,
L<Muldis::D::Core::Array>, L<Muldis::D::Core::Bag>,
L<Muldis::D::Core::Interval>, L<Muldis::D::Core::STDIO>,
L<Muldis::D::Core::Routines_Catalog>.

=head1 DESCRIPTION

Muldis D has a mandatory core set of system-defined (eternally available)
entities, which is referred to as the I<Muldis D core> or the I<core>; they
are the minimal entities that all Muldis D implementations need to provide;
they are mutually self-describing and are either used to bootstrap the
language or they constitute a reasonable minimum level of functionality for
a practically useable industrial-strength (and fully I<TTM>-conforming)
programming language; any entities outside the core, called I<Muldis D
extensions>, are non-mandatory and are defined in terms of the core or each
other, but the reverse isn't true.

This current C<Core> document features the tuple and
relation type constructors and all of the general-purpose
relational operators, plus the type system minimal and maximal types, plus
the special types used to define the system catalog, and the polymorphic
operators that all types, or some types including core types, have defined
over them, such as identity tests or assignment; it also features the
boolean logic, integer and rational numeric, bit and character string
data types and all their operators.

Most of the C<Core> document is actually in these pieces:
L<Muldis::D::Core::Types>, L<Muldis::D::Core::Types_Catalog>,
L<Muldis::D::Core::Universal>, L<Muldis::D::Core::Ordered>,
L<Muldis::D::Core::Scalar>, L<Muldis::D::Core::Boolean>,
L<Muldis::D::Core::Numeric>, L<Muldis::D::Core::Integer>,
L<Muldis::D::Core::Rational>, L<Muldis::D::Core::Stringy>,
L<Muldis::D::Core::Blob>, L<Muldis::D::Core::Text>,
L<Muldis::D::Core::Cast>, L<Muldis::D::Core::Attributive>,
L<Muldis::D::Core::Tuple>, L<Muldis::D::Core::Relation>,
L<Muldis::D::Core::Collective>, L<Muldis::D::Core::Set>,
L<Muldis::D::Core::Array>, L<Muldis::D::Core::Bag>,
L<Muldis::D::Core::Interval>, L<Muldis::D::Core::STDIO>,
L<Muldis::D::Core::Routines_Catalog>.

Extensions are in other documents.

These extensions don't declare any new data types but declare additional
operators for core types: L<Muldis::D::Ext::Counted>.

These extensions mainly define new types plus just operators for those:
L<Muldis::D::Ext::Temporal>, L<Muldis::D::Ext::Spatial>.

=head1 AUTHOR

Darren Duncan (C<darren@DarrenDuncan.net>)

=head1 LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of L<Muldis::D> for details.

=cut
