use 5.008001;
use utf8;
use strict;
use warnings FATAL => 'all';

###########################################################################
###########################################################################

{ package Language::MuldisD; # package
    use version; our $VERSION = qv('0.15.0');
    # Note that Perl code only exists at all in this file in order to help
    # the CPAN indexer handle the distribution properly.
} # package Language::MuldisD

###########################################################################
###########################################################################

1; # Magic true value required at end of a reusable file's code.
__END__

=pod

=encoding utf8

=head1 NAME

Language::MuldisD -
Formal spec of Muldis D relational DBMS lang

=head1 VERSION

This document is Language::MuldisD version 0.15.0.

=head1 PREFACE

This is the root document of the Muldis D language specification; the
documents that comprise the remaining parts of the specification, in their
suggested reading order (but that all follow the root), are:
L<Language::MuldisD::Basics>, L<Language::MuldisD::Core>,
L<Language::MuldisD::Grammar>, L<Language::MuldisD::PerlHosted>,
L<Language::MuldisD::Ext::Temporal>, L<Language::MuldisD::Ext::Spatial>.

=head1 DESCRIPTION

This distribution / multi-part document is the human readable authoritative
formal specification of the B<Muldis D> language, and of the virtual
environment in which it executes.  If there's a conflict between any other
document and this one, then either the other document is in error, or the
developers were negligent in updating it before this one, so you can yell
at them.

The fully-qualified name of this multi-part document and the language
specification it contains is C<MuldisD:'cpan:DUNCAND':'0.15.0'>.  It is the
official/original (not embraced and extended) Muldis D language
specification by the authority Darren Duncan (C<cpan:DUNCAND>), version
C<0.15.0> (this number matches the VERSION pod in this file).  Any modified
versions of this Muldis D language specification that are released by
someone else must have a long name with at least a different authority
(middle) portion, to assist users and maintainers in distinguishing them
from official releases.  Furthermore, all code written in any
representation format of Muldis D should specify the long name of the
language specification that it is written in, to make it unambiguous to
both human and machine (eg, implementing) readers of the code.  (The
L<Language::MuldisD::Grammar> and L<Language::MuldisD::PerlHosted>
documents say how to do this for their language representation formats.)

Muldis D is a computationally / Turing complete (and industrial strength)
high-level programming language with fully integrated database
functionality; you can use it to define, query, and update relational
databases.  The language's paradigm is a mixture of declarative,
functional, imperative, and object-oriented.  It is primarily focused on
providing reliability, consistency, portability, and ease of use and
extension.  (Logically, speed of execution can not be declared as a Muldis
D quality because such a quality belongs to an implementation alone;
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
and various SQL implementations (see the L<Language::MuldisD::SeeAlso>
file).  It also appears in retrospect that Muldis D has some designs in
common with FoxPro or xBase, and with the Ada and Lua languages.

In any event, the Muldis D documentation will be focusing mainly on how
Muldis D itself works, and will spend little time in providing rationale;
you can read the aforementioned external documentation for much of that.

Continue reading the language spec in L<Language::MuldisD::Basics>.

Also look at the separately distributed L<Muldis::DB>, which is the first
main implementation of Muldis D.

=head1 SEE ALSO

Go to the L<Language::MuldisD::SeeAlso> file for the majority of external
references.

=head1 AUTHOR

Darren Duncan (C<perl@DarrenDuncan.net>)

=head1 LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2007, Darren Duncan.  All rights reserved.

Muldis D is free documentation for software; you can redistribute it and/or
modify it under the terms of the GNU General Public License (GPL) as
published by the Free Software Foundation (L<http://www.fsf.org/>); either
version 3 of the License, or (at your option) any later version.  You
should have received copies of the GPL as part of the Language::MuldisD
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

=head1 ACKNOWLEDGEMENTS

None yet.

=head1 FORUMS

Several public email-based forums exist whose main topic is all
implementations of the L<Muldis D|Language::MuldisD> language, especially
the L<Muldis DB|Muldis::DB> project, which they are named for.  All of
these you can reach via L<http://mm.DarrenDuncan.net/mailman/listinfo>; go
there to manage your subscriptions to, or view the archives of, the
following:

=over

=item C<muldis-db-announce@mm.DarrenDuncan.net>

This low-volume list is mainly for official announcements from the Muldis
DB developers, though developers of Muldis DB extensions can also post
their announcements here.  This is not a discussion list.

=item C<muldis-db-users@mm.DarrenDuncan.net>

This list is for general discussion among people who are using Muldis DB,
which is not concerned with the implementation of Muldis DB itself.  This
is the best place to ask for basic help in getting Muldis DB installed on
your machine or to make it do what you want.  You could also submit feature
requests or report perceived bugs here, if you don't want to use CPAN's RT
system.

=item C<muldis-db-devel@mm.DarrenDuncan.net>

This list is for discussion among people who are designing or implementing
the Muldis DB core API (including Muldis D language design), or who are
implementing Muldis DB Engines, or who are writing core documentation,
tests, or examples.  It is not the place for non-implementers to get help
in using said.

=back

An official IRC channel for Muldis DB is also intended, but not yet
started.

Alternately, you can purchase more advanced commercial support for various
Muldis D implementations, particularly Muldis DB, from its author; contact
C<perl@DarrenDuncan.net> for details.

=cut
