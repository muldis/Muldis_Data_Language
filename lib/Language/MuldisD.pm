use 5.008001;
use utf8;
use strict;
use warnings FATAL => 'all';

###########################################################################
###########################################################################

{ package Language::MuldisD; # package
    our $VERSION = 0.003000;
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

This document is Language::MuldisD version 0.3.0.

=head1 DESCRIPTION

This distribution is the formal specification of the Muldis D language.

I<This documentation is pending.>

For one manner of introduction to it, see the included
L<Language::MuldisD::Basics> file, which has the start of the
specification itself.

For another manner of introduction, see the separately distributed
L<Muldis::DB> file, which is the first main implementation of Muldis D.

=head1 SEE ALSO

I<This documentation is pending.>

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
implementations of the Muldis D language, especially the L<Muldis::DB>
project, which they are named for.  All of these you can reach via
L<http://mm.DarrenDuncan.net/mailman/listinfo>; go there to manage your
subscriptions to, or view the archives of, the following:

=over

=item C<muldis-db-announce@mm.DarrenDuncan.net>

This low-volume list is mainly for official announcements from the
Muldis::DB developers, though developers of Muldis::DB extensions can also
post their announcements here.  This is not a discussion list.

=item C<muldis-db-users@mm.DarrenDuncan.net>

This list is for general discussion among people who are using Muldis::DB,
which is not concerned with the implementation of Muldis::DB itself.  This
is the best place to ask for basic help in getting Muldis::DB installed on
your machine or to make it do what you want.  You could also submit feature
requests or report perceived bugs here, if you don't want to use CPAN's RT
system.

=item C<muldis-db-devel@mm.DarrenDuncan.net>

This list is for discussion among people who are designing or implementing
the Muldis::DB core API (including Muldis D language design), or who are
implementing Muldis::DB Engines, or who are writing core documentation,
tests, or examples.  It is not the place for non-implementers to get help
in using said.

=back

An official IRC channel for Muldis::DB is also intended, but not yet
started.

Alternately, you can purchase more advanced commercial support for various
Muldis D implementations, particularly Muldis::DB, from its author; contact
C<perl@DarrenDuncan.net> for details.

=cut
