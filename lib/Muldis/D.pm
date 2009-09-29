use 5.008001;
use utf8;
use strict;
use warnings FATAL => 'all';

###########################################################################
###########################################################################

{ package Muldis::D; # package
    our $VERSION = '0.092000';
    $VERSION = eval $VERSION;
    # Note that Perl code only exists at all in this file in order to help
    # the CPAN indexer handle the distribution properly.
} # package Muldis::D

###########################################################################
###########################################################################

1; # Magic true value required at end of a reusable file's code.
__END__

=pod

=encoding utf8

=head1 NAME

Muldis::D -
Formal spec of Muldis D relational DBMS lang

=head1 VERSION

This document is Muldis::D version 0.93.0.

=head1 PREFACE

This is the root document of the Muldis D language specification; the
documents that comprise the remaining parts of the specification, in their
suggested reading order (but that all follow the root), are:
L<Muldis::D::Basics>, L<Muldis::D::Core> (which has its own tree of parts
to follow), L<Muldis::D::Dialect::PTMD_STD>,
L<Muldis::D::Dialect::HDMD_Perl6_STD>,
L<Muldis::D::Dialect::HDMD_Perl5_STD>, L<Muldis::D::Conventions>,
L<Muldis::D::Ext::Ordered>, L<Muldis::D::Ext::Bool>,
L<Muldis::D::Ext::Integer>, L<Muldis::D::Ext::Blob>,
L<Muldis::D::Ext::Text>, L<Muldis::D::Ext::Rational>,
L<Muldis::D::Ext::Tuple>, L<Muldis::D::Ext::Relation>,
L<Muldis::D::Ext::Set>, L<Muldis::D::Ext::Array>, L<Muldis::D::Ext::Bag>,
L<Muldis::D::Ext::Counted>, L<Muldis::D::Ext::Temporal>,
L<Muldis::D::Ext::Spatial>.

=head1 DESCRIPTION

This distribution / multi-part document is the human readable authoritative
formal specification of the B<Muldis D> language, and of the virtual
environment in which it executes.  If there's a conflict between any other
document and this one, then either the other document is in error, or the
developers were negligent in updating it before this one, so you can yell
at them.

The fully-qualified name of this multi-part document and the language
specification it contains (as a single composition) is
C<Muldis_D:"http://muldis.com":"0.93.0">.  It is the official/original (not
embraced and extended) Muldis D language specification by the authority
Darren Duncan (C<http://muldis.com>), version C<0.93.0> (this number
matches the VERSION pod in this file).  This multi-part document is named
and organized with the expectation that many dialects, extensions, and core
versions of it will exist over time, some of those under the original
author's control, and some under the control of other parties.  The
L</VERSIONING> pod section in this file presents a formal method for
specifying the fully-qualified name of a complete language derived from
Muldis D, including any common base plus any dialects and extensions.  All
code written in any dialect or derivation of Muldis D should begin by
specifying the fully-qualified name of the language that it is written in,
the format of the name as defined by said method, to make the code
unambiguous to both human and machine (eg, implementing) readers of the
code.  The method should be very future-proof.

Muldis D is a computationally / Turing complete (and industrial strength)
high-level programming language with fully integrated database
functionality; you can use it to define, query, and update relational
databases.  The language's paradigm is a mixture of declarative,
homoiconic, functional, imperative, and object-oriented.  It is primarily
focused on providing reliability, consistency, portability, and ease of use
and extension.  (Logically, speed of execution can not be declared as a
Muldis D quality because such a quality belongs to an implementation alone;
however, the language should lend itself to making fast implementations.)

Muldis D is intended to qualify as a "B<D>" language as defined by
"I<Databases, Types, and The Relational Model: The Third Manifesto>"
(I<TTM>), a formal proposal for a solid foundation for data and database
management systems, written by Christopher J. Date and Hugh Darwen; see
L<http://www.aw-bc.com/catalog/academic/product/0,1144,0321399420,00.html>
for a publishers link to the book that formally publishes I<TTM>.  See
L<http://www.thethirdmanifesto.com/> for some references to what I<TTM> is,
and also copies of some documents that were used in writing Muldis D.

It should be noted that Muldis D, being quite new, may omit some features
that are mandatory for a "B<D>" language initially, to speed the way to a
useable partial solution, but any omissions will be corrected later.  Also,
it contains some features that go beyond the scope of a "B<D>" language, so
Muldis D is technically a "B<D> plus extra"; examples of this are
constructs for creating the databases themselves and managing connections
to them.

Muldis D also incorporates design aspects and constructs that are taken
from or influenced by Perl 6, other general-purpose languages (particularly
functional ones like Haskell), B<Tutorial D>, various B<D> implementations,
and various SQL implementations (see the L<Muldis::D::SeeAlso>
file).  It also appears in retrospect that Muldis D has some designs in
common with FoxPro or xBase, and with the Ada and Lua languages.

In any event, the Muldis D documentation will be focusing mainly on how
Muldis D itself works, and will spend little time in providing rationale;
you can read the aforementioned external documentation for much of that.

Continue reading the language spec in L<Muldis::D::Basics>.

Also look at the separately distributed L<Muldis::Rosetta>, which is the
first main implementation of Muldis D.

=head1 VERSIONING

All code written in any variant of Muldis D should begin with meta-data
that explicitly states that it is written in Muldis D, and that fully
identifies what variant of Muldis D it is, so that the code is completely
unambiguous to both human and machine (eg, implementing) readers of the
code.  This pod section explains how this meta-data should be formatted,
and it is intended to be as future-proofed as possible in the face of a
wide variety of both anticipated and unforeseen language variants, both by
the original author and by other parties.

At the highest level, a fully-qualified Muldis D language name is a
(ordered) sequence of values having a minimum of 2 elements, and typically
about 4-6 elements.  The elements are read one at a time, starting with the
first; the value of each element, combined with those before it, determine
what number and kind of elements are valid to follow it in the sequence.
So all Muldis D variants are organized into a single hierarchy where each
child node represents a language derived from or extending the language
represented by its parent node.

In documentation, it is typical to use a Muldis D language name involving
just a sub-sequence of the allowed elements that is missing child-most
allowed elements; in that case, this language name implicitly refers to the
entire language sub-tree having the specified elements in common; an
example of this is the 3-element name mentioned in this file's DESCRIPTION
section.  Even in code, sometimes certain child-most elements are optional.

=head2 Foundation

The actual formatting of a "sequence" used as this language name is
dependent on the language variant itself, but it should be kept as simple
to write and use as is possible for the medium of that variant.

Generally speaking, every Muldis D variant belongs to one of just 2
groups, which are I<non-hosted plain-text> and I<hosted data>.

With all non-hosted plain-text variants, the Muldis D code is represented
by an (ordered) string/sequence of characters like with most normal
programming languages, and so the actual format (of the language name
defining sequence and its elements) is defined in terms of an ordered
series of character sub-strings, each sub-string being a name sequence
element; the sub-strings are often bounded by delimiting characters, and
separated by separating characters.  The string of characters comprising
this name string would be the first characters in the file, and only
following them would be the characters for the actual Muldis D code that
the name is meta-data for.

With all hosted data variants, the Muldis D code is represented by
collection-typed values that are of some native type of some other
programming language (eg, Perl) which is the host of Muldis D, so the
actual format (of the language name defining sequence and its elements) is
simply a sequence-typed value of the host programming language.  The Muldis
D code is written here by way of writing code in the host language.

=head2 Base Name

The first element of the Muldis D language name is simply the character
string C<Muldis_D>.  Any language which wants to claim to be a variant of
Muldis D should have this exact first element; only have some other value
if you don't want to claim a connection to Muldis D at all, and in that
case feel free to just ignore everything else in this multi-document.

=head2 Base Authority

The second element of the Muldis D language name is some character string
whose value uniquely identifies the authority or author of the variant's
base language specification.  Generally speaking, the community at large
should self-regulate authority identifier strings so they are reasonable
formats and so each prospective authority/author has one of their own that
everyone recognizes as theirs.  Note that an authority/author doesn't have
to be an individual person; it could be some corporate entity instead.

While technically this string could be any distinct value at all, it is
strongly recommended for Muldis D variant names that authority strings
follow the formats that are valid as authority strings for the long names
of Perl 6 packages, such as a CPAN identifier or an http url.

For the official/original Muldis D language spec by Muldis Data Systems,
Inc., that string is always C<http://muldis.com> during the foreseeable
future.

If someone else wants to I<embrace and extend> Muldis D, then they must use
their own (not C<http://muldis.com>) base authority identifier, to prevent
ambiguity, assist quality control, and give due credit.

In this context, I<embrace and extend> means for someone to do any of the
following:

=over

=item *

Releasing a modified version of this current multi-document where the
original of the modified version was released by someone else (the original
typically being the official release), as opposed to just releasing a delta
document that references the current multi-document as a foundation.  This
applies both for unofficial modifications and for official modifications
following a change of who is the official maintainer.

=item *

Releasing a delta document for a version of this current multi-document
where the referenced original is released by someone else, and where the
delta either makes incompatible changes or adds DBMS entities in the
C<sys.std> top-level namespace (as opposed to in C<sys.imp>).

=back

=head2 Base Version Number

The third element of the Muldis D language name, at the very least when the
base authority is C<http://muldis.com>, is a multi-part base version
number, which identifies the base language spec version between all those
by the same authority, typically indicating the relative ages of the
versions, the relative sizes of their deltas, and perhaps which development
branches the versions are on.  The base version number is a sequence of
non-negative integers that consists of at least 1 element, and either 3 or
4 elements is recommended (the official base version number has 3
elements); elements are ordered from most significant to least (eg, [major,
minor, bug-fix]).  At the present time, the official spec version number to
use is shown in the VERSION and DESCRIPTION pod of the current file, when
corresponding to the spec containing that file.

=head2 Dialect

The fourth element of the Muldis D language name, at the very least when
the base authority is C<http://muldis.com>, uniquely identifies which
Muldis D language primary dialect the Muldis D code (that this
fully-qualified language name is meta-data for) is formatted in; for
example this may be one of several non-hosted plain-text variants, or one
of several hosted data variants (each host language has its own ones).
This fourth element can either be some character string or be a sequence of
3+ elements.  In the first case, the character string is interpreted as the
name of one of the several dialects included in the current multi-document,
and the specific variant of said dialect is assumed to be whichever one is
bundled with the already named base language authority+version.  In the
second case, the sequence of elements is a dialect name plus authority plus
version plus whatever, for some spec definition not bundled with the
current multi-document.  Note that a dialect specification can appear to
provide features not in the underlying main spec, but code written in any
dialect needs to be translatable to a standard dialect without changing the
code's behavior.

See the following parts of the current multi-document for descriptions of
bundled dialects (names subject to change):
L<Muldis::D::Dialect::PTMD_STD>, L<Muldis::D::Dialect::HDMD_Perl6_STD>,
L<Muldis::D::Dialect::HDMD_Perl5_STD>.

=head2 Extensions

Whether or not the Muldis D language name has a fifth or further elements
depends on the dialect.  See the documentation for each individual dialect
to see what it supports or requires.

=head1 SEE ALSO

Go to the L<Muldis::D::SeeAlso> file for the majority of external
references.

=head1 AUTHOR

Darren Duncan (C<perl@DarrenDuncan.net>)

=head1 LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2009, Muldis Data Systems, Inc.

L<http://www.muldis.com/>

Muldis D is free documentation for software; you can redistribute it and/or
modify it under the terms of the GNU General Public License (GPL) as
published by the Free Software Foundation (L<http://www.fsf.org/>); either
version 3 of the License, or (at your option) any later version.  You
should have received copies of the GPL as part of the Muldis::D
distribution, in the file named "LICENSE/GPL"; if not, see
L<http://www.gnu.org/licenses/>.

Any versions of Muldis D that you modify and distribute must carry
prominent notices stating that you changed the files and the date of any
changes, in addition to preserving this original copyright notice and other
credits.

While it is by no means required, the copyright holder of Muldis D would
appreciate being informed any time you create a modified version of Muldis
D that you are willing to distribute, because that is a practical way of
suggesting improvements to the standard version.

=head1 TRADEMARK POLICY

MULDIS and MULDIS MULTIVERSE OF DISCOURSE are trademarks of Muldis Data
Systems, Inc. (L<http://www.muldis.com/>).  The trademarks apply to
computer database software and related services.  See
L<http://www.muldis.com/trademark_policy.html> for the full written details
of Muldis Data Systems' trademark policy.

The word MULDIS is intended to be used as the distinguishing brand name for
all the products and services of Muldis Data Systems.  So we would greatly
appreciate it if in general you do not incorporate the word MULDIS into the
name or logo of your website, business, product or service, but rather use
your own distinct name (exceptions appear below).  It is, however, always
okay to use the word MULDIS only in descriptions of your website, business,
product or service to provide accurate information to the public about
yourself.

If you do incorporate the word MULDIS into your names anyway, either
because you have permission from us or you have some other good reason,
then:  You must make clear that you are not Muldis Data Systems and that
you do not represent Muldis Data Systems.  A simple or conspicuous
disclaimer on your home page and product or service documentation is an
excellent way of doing that.

Please respect the conventions of the Perl community by not using the
namespace C<Muldis::> at all for your own works, unless you have explicit
permission to do so from Muldis Data Systems; that namespace is mainly just
for our official works.  You can always use either the C<MuldisX::>
namespace for related unofficial works, or some other namespace that is
completely different.  Also as per conventions, its fine to use C<Muldis>
within a Perl package name where that word is nested under some other
project-specific namespace (for example, C<Foo::Storage::Muldis_Rosetta> or
C<Bar::Interface::Muldis_Rosetta>), and the package serves to interact with
a Muldis Data Systems work or service.

If you have made a language variant or extension based on the B<Muldis D>
language, then please follow the naming conventions described in the
VERSIONING (L<Muldis::D/VERSIONING>) documentation of the official
B<Muldis D> language spec.

If you would like to use (or have already used) the word MULDIS for any use
that ought to require permission, please contact Muldis Data Systems and
we'll discuss a way to make that happen.

=head1 ACKNOWLEDGEMENTS

None yet.

=head1 FORUMS

Several public email-based forums exist whose main topic is all
implementations of the L<Muldis D|Muldis::D> language, especially the
L<Muldis Rosetta|Muldis::Rosetta> reference implementation, but also the
L<Set::Relation> module.  All of these you can reach via
L<http://mm.DarrenDuncan.net/mailman/listinfo>; go there to manage your
subscriptions to, or view the archives of, the following:

=over

=item C<muldis-db-announce@mm.DarrenDuncan.net>

This low-volume list is mainly for official announcements from the Muldis
Rosetta developers, though developers of Muldis Rosetta extensions can also
post their announcements here.  This is not a discussion list.

=item C<muldis-db-users@mm.DarrenDuncan.net>

This list is for general discussion among people who are using Muldis
Rosetta, which is not concerned with the implementation of Muldis Rosetta
itself.  This is the best place to ask for basic help in getting Muldis
Rosetta installed on your machine or to make it do what you want.  You
could also submit feature requests or report perceived bugs here, if you
don't want to use CPAN's RT system.

=item C<muldis-db-devel@mm.DarrenDuncan.net>

This list is for discussion among people who are designing or implementing
the Muldis Rosetta core API (including Muldis D language design), or who
are implementing Muldis Rosetta Engines, or who are writing core
documentation, tests, or examples.  It is not the place for
non-implementers to get help in using said.

=back

An official IRC channel for Muldis D and its implementations is also
intended, but not yet started.

Alternately, you can purchase more advanced commercial support for various
Muldis D implementations, particularly Muldis Rosetta, from its author by
way of Muldis Data Systems; see (L<http://www.muldis.com/>) for details.

=cut
