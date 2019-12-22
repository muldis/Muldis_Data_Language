# NAME

Muldis Data Language (Muldis D) - Relational database application programming language

# VERSION

The fully-qualified name of this document is
`Muldis_Data_Language https://muldis.com 0.300.0`.

# SYNOPSIS

*TODO.*

# DESCRIPTION

This document is the human readable authoritative formal specification named
**Muldis Data Language** (**Muldis D**).
The fully-qualified name of this document and specification is
`Muldis_Data_Language https://muldis.com 0.300.0`.
This is the official/original version by the authority Muldis Data Systems
(`https://muldis.com`), version number `0.300.0`.

*TODO.*

# VERSIONING

Every version of this specification document is expected to declare its own
fully-qualified name, or *identity*, so that it can easily be referred to
and be distinguished from every other version that does or might exist.

The expected fully-qualified name of every version of this specification
document, as either declared in said document or as referenced by other
documents or by source code, has 3 main parts: *document base name*,
*authority*, and *version number*.

The *document base name* is the character string `Muldis_Data_Language`.

An *authority* is some nonempty character string whose value uniquely
identifies the authority or author of the versioned entity.  Generally
speaking, the community at large should self-regulate authority identifier
strings so they are reasonable formats and so each prospective
authority/author has one of their own that everyone recognizes as theirs.
Note that an authority/author doesn't have to be an individual person; it
could be some corporate entity instead.

Examples of recommended *authority* naming schemes include a qualified
base HTTP url belonging to the authority (example `https://muldis.com`) or
a qualified user identifier at some well-known asset repository
(example `https://github.com/muldis` or `cpan:DUNCAND`).

For all official/original works by Muldis Data Systems, Inc., the
*authority* has always been `https://muldis.com` and is expected to remain
so during the foreseeable future.

If someone else wants to *embrace and extend* this specification document,
then they must use their own (not `https://muldis.com`) base authority
identifier, to prevent ambiguity, assist quality control, and give due credit.

In this context, *embrace and extend* means for someone to do any of the
following:

- Releasing a modified version of this current document or any
component thereof where the original of the modified version was released
by someone else (the original typically being the official release), as
opposed to just releasing a delta document that references the current one
as a foundation.  This applies both for unofficial modifications and for
official modifications following a change of who is the official maintainer.

- Releasing a delta document for a version of this current document or
any component thereof where the referenced original is released by someone
else, and where the delta either makes significant incompatible changes.

A *version number* is an ordered sequence of 1 or more integers.  A
*version number* is used to distinguish between all of the versions of a
named entity that have a common *authority*, per each kind of versioned
entity; version numbers typically indicate the release order of these
related versions and how easily users can substitute one version for
another.  The actual intended meaning of any given *version number*
regarding for example substitutability is officially dependant on each
*authority* and no implicit assumptions should be made that 2 *version
number* with different *authority* are comparable in any meaningful way,
aside from case-by-case where a particular *authority* declares they use a
scheme compatible with another.  The only thing this document requires is that
every distinct version of an entity has a distinct fully-qualified name.

For each official/original work by Muldis Data Systems related to this
specification document and released after 2016 April 1, except where
otherwise stated, it uses *semantic versioning* for each *version number*,
as described below.  Others are encouraged to follow the same format, but
are not required to.  For all intents and purposes, every *version number*
of an official Muldis work is intended to conform to the external public
standard **Semantic Versioning 2.0.0** as published at
[https://semver.org](https://semver.org), but it is re-explained below for
clarity or in case the external document disappears.

A *version number* for authority `https://muldis.com` is an ordered sequence
of integers, the order of these being from most significant to least, with
3 positions [MAJOR,MINOR,PATCH] and further ones possible.  The version
sequence may have have as few as 1 most significant position.  Any omitted
trailing position is treated as if it were zero.  Each of
{MAJOR,MINOR,PATCH} must be a non-negative integer. MAJOR is always (except
when it is zero) incremented when a change is made which breaks
backwards-compatibility for functioning uses, such as when removing a
feature; it may optionally be incremented at other times, such as for
marketing purposes.  Otherwise, MINOR is always incremented when a change
is made that breaks forwards-compatibility for functioning uses, such as
when adding a feature; it may optionally be incremented at other times,
such as for when a large internals change is made.  Otherwise, PATCH must
be incremented when making any kind or size of change at all, as long as it
doesn't break compatibility; typically this is bug-fixes or performance
improvements or some documentation changes or any test suite changes.  For
fixes to bugs or security holes which users may have come to rely on in
conceptually functioning uses, they should be treated like API changes.
When MAJOR is zero, MINOR is incremented for any kind of breaking change.
There is no requirement that successive versions have adjacent integers,
but they must be increases.

Strictly speaking a *version number* reflects intention of the authority's
release and not necessarily its actuality.  If PATCH is incremented but the
release unknowingly had a breaking change, then once this is discovered
another release should be made which increments PATCH again and undoes that
breaking change, in order to safeguard upgrading users from surprises; an
additional release can be made which instead increments MAJOR or MINOR with
the breaking change if that change was actually desired.

*Currently this document does not specify matters such as how to indicate
maturity, for example production vs pre-production/beta/etc, so explicit
markers of such can either be omitted or be based on other standards.
However, a major version of zero should be considered either pre-production
or that the authority expects frequent upcoming backwards-incompatible changes.*

See also [http://design.raku.org/S11.html#Versioning](
http://design.raku.org/S11.html#Versioning) which was the primary
influence for the versioning scheme described above.

# SEE ALSO

*TODO.*

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Data Language** (**Muldis D**).

Muldis D is Copyright © 2002-2019, Muldis Data Systems, Inc.

[https://muldis.com](https://muldis.com)

Muldis D is free documentation for software;
you can redistribute it and/or modify it under the terms of the Artistic
License version 2 (AL2) as published by the Perl Foundation
([https://www.perlfoundation.org](https://www.perlfoundation.org)).
You should have received a copy of the AL2 as part of the
Muldis D distribution, in the file
[LICENSE/artistic-2_0.txt](../LICENSE/artistic-2_0.txt); if not, see
[https://www.perlfoundation.org/artistic-license-20.html](
https://www.perlfoundation.org/artistic-license-20.html).

Any versions of Muldis D that you modify and distribute must carry prominent
notices stating that you changed the files and the date of any changes, in
addition to preserving this original copyright notice and other credits.

While it is by no means required, the copyright holder of Muldis D would
appreciate being informed any time you create a modified version of Muldis D
that you are willing to distribute, because that is a practical way of
suggesting improvements to the standard version.

# TRADEMARK POLICY

**MULDIS** and **MULDIS MULTIVERSE OF DISCOURSE** are trademarks of Muldis
Data Systems, Inc. ([https://muldis.com](https://muldis.com)).
The trademarks apply to computer database software and related services.
See [https://muldis.com/trademark_policy.html](
https://muldis.com/trademark_policy.html) for the full written details
of Muldis Data Systems' trademark policy.

# ACKNOWLEDGEMENTS

*None yet.*

# FORUMS

*TODO.*
