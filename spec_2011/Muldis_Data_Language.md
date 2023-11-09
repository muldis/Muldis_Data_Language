# NAME

Muldis Data Language (MDL) - Relational database application programming language

# VERSION

This document is Muldis Data Language version 0.148.1.

# PREFACE

This is the root document of the Muldis D language specification; the
documents that comprise the remaining parts of the specification, in their
suggested reading order (but that all follow the root), are:
[Muldis_Data_Language_Basics](Muldis_Data_Language_Basics.md), [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md) (which has its own tree of parts
to follow), [Muldis_Data_Language_Dialect_PTMD_STD](Muldis_Data_Language_Dialect_PTMD_STD.md),
[Muldis_Data_Language_Dialect_HDMD_Raku_STD](Muldis_Data_Language_Dialect_HDMD_Raku_STD.md),
[Muldis_Data_Language_Dialect_HDMD_Perl_STD](Muldis_Data_Language_Dialect_HDMD_Perl_STD.md), [Muldis_Data_Language_Conventions](Muldis_Data_Language_Conventions.md),
[Muldis_Data_Language_Ext_Counted](Muldis_Data_Language_Ext_Counted.md), [Muldis_Data_Language_Ext_Temporal](Muldis_Data_Language_Ext_Temporal.md),
[Muldis_Data_Language_Ext_Spatial](Muldis_Data_Language_Ext_Spatial.md).

# DESCRIPTION

This distribution / multi-part document is the human readable authoritative
formal specification of the B<Muldis D> language, and of the virtual
environment in which it executes.  If there's a conflict between any other
document and this one, then either the other document is in error, or the
developers were negligent in updating it before this one.

The fully-qualified name of this multi-part document and the language
specification it contains (as a single composition) is
C<Muldis_D:"https://muldis.com":0.148.1>.  It is the official/original (not
embraced and extended) Muldis D language specification by the authority
Muldis Data Systems (C<https://muldis.com>), version C<0.148.1> (this number
matches the VERSION pod in this file).  This multi-part document is named
and organized with the expectation that many dialects, extensions, and core
versions of it will exist over time, some of those under the original
author's control, and some under the control of other parties.  The
**VERSIONING** pod section in this file presents a formal method for
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
management systems, written by Chris Date (C.J. Date) and Hugh Darwen; see
<http://www.aw-bc.com/catalog/academic/product/0,1144,0321399420,00.html>
for a publishers link to the book that formally publishes I<TTM>.  See
<http://www.thethirdmanifesto.com/> for some references to what I<TTM> is,
and also copies of some documents that were used in writing Muldis D.

It should be noted that Muldis D, being quite new, may omit some features
that are mandatory for a "B<D>" language initially, to speed the way to a
useable partial solution, but any omissions will be corrected later.  Also,
it contains some features that go beyond the scope of a "B<D>" language, so
Muldis D is technically a "B<D> plus extra"; examples of this are
constructs for creating the databases themselves and managing connections
to them.

Muldis D also incorporates design aspects and constructs that are taken
from or influenced by Raku, other general-purpose languages (particularly
functional ones like Haskell), B<Tutorial D>, various B<D> implementations,
and various SQL implementations (see the [Muldis_Data_Language_SeeAlso](Muldis_Data_Language_SeeAlso.md)
file).  It also appears in retrospect that Muldis D has some designs in
common with FoxPro or xBase, and with the Ada and Lua languages.  The
newer [C'Dent](http://cdent.org) language has some similarities as well.
Most recently Lisp became a larger influence.

In any event, the Muldis D documentation will be focusing mainly on how
Muldis D itself works, and will spend little time in providing rationale;
you can read the aforementioned external documentation for much of that.

Continue reading the language spec in [Muldis_Data_Language_Basics](Muldis_Data_Language_Basics.md).

Muldis D is an [Acmeist](http://acmeism.org) programming language for
writing portable database modules, that work with any DBMS and with any
other programming language, for superior database interoperability.

# VERSIONING

All code written in any variant of Muldis D should begin with metadata
that explicitly states that it is written in Muldis D, and that fully
identifies what variant of Muldis D it is, so that the code is completely
unambiguous to both human and machine (eg, implementing) readers of the
code.  This pod section explains how this metadata should be formatted,
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

While not mandatory for Muldis D variants in general, it is strongly
recommended that all elements of a Muldis D language name would, when
expressed in terms of character strings, be expressly limited to comprising
just non-control characters in the ASCII repertoire, and not include any
other characters such as Unicode has.  The primary reason for this is to
make it as simple as possible to interpret a language name on all
architectures, especially so that any explicit hints in the name on how to
interpret the rest of the Muldis D code, including hints as to what
character repertoire it is written in, can be understood without ambiguity.
For all official Muldis D variants, ASCII-only names is actually mandatory.

## Foundation

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
the name is metadata for.

With all hosted data variants, the Muldis D code is represented by
collection-typed values that are of some native type of some other
programming language (eg, Perl) which is the host of Muldis D, so the
actual format (of the language name defining sequence and its elements) is
simply a sequence-typed value of the host programming language.  The Muldis
D code is written here by way of writing code in the host language.

## Base Name

The first element of the Muldis D language name is simply the character
string C<Muldis_D>.  Any language which wants to claim to be a variant of
Muldis D should have this exact first element; only have some other value
if you don't want to claim a connection to Muldis D at all, and in that
case feel free to just ignore everything else in this multi-document.

## Base Authority

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
of Raku packages, such as a CPAN identifier or an http url.

For the official/original Muldis D language spec by Muldis Data Systems,
Inc., that string is always C<https://muldis.com> during the foreseeable
future.

If someone else wants to I<embrace and extend> Muldis D, then they must use
their own (not C<https://muldis.com>) base authority identifier, to prevent
ambiguity, assist quality control, and give due credit.

In this context, I<embrace and extend> means for someone to do any of the
following:

* Releasing a modified version of this current multi-document where the
original of the modified version was released by someone else (the original
typically being the official release), as opposed to just releasing a delta
document that references the current multi-document as a foundation.  This
applies both for unofficial modifications and for official modifications
following a change of who is the official maintainer.

* Releasing a delta document for a version of this current multi-document
where the referenced original is released by someone else, and where the
delta either makes incompatible changes or adds DBMS entities in the
C<sys.std> top-level namespace (as opposed to in C<sys.imp>).

## Base Version Number

The third element of the Muldis D language name, at the very least when the
base authority is C<https://muldis.com>, is a multi-part base version
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

## Dialect

The fourth element of the Muldis D language name, at the very least when
the base authority is C<https://muldis.com>, uniquely identifies which
Muldis D language primary dialect the Muldis D code (that this
fully-qualified language name is metadata for) is formatted in; for
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
[Muldis_Data_Language_Dialect_PTMD_STD](Muldis_Data_Language_Dialect_PTMD_STD.md), [Muldis_Data_Language_Dialect_HDMD_Raku_STD](Muldis_Data_Language_Dialect_HDMD_Raku_STD.md),
[Muldis_Data_Language_Dialect_HDMD_Perl_STD](Muldis_Data_Language_Dialect_HDMD_Perl_STD.md).

## Extensions

Whether or not the Muldis D language name has a fifth or further elements
depends on the dialect.  See the documentation for each individual dialect
to see what it supports or requires.

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Data Language** (**MDL**).

MDL is Copyright © 2002-2011, Muldis Data Systems, Inc.

<https://muldis.com>

MDL is free documentation for software;
you can redistribute it and/or modify it under the terms of the Apache
License, Version 2.0 (AL2) as published by the Apache Software Foundation
(<https://apache.org>).  You should have received a copy of the
AL2 as part of the MDL distribution, in the file
[LICENSE/Apache-2.0.txt](../LICENSE/Apache-2.0.txt); if not, see
<https://apache.org/licenses/LICENSE-2.0>.

Any versions of MDL that you modify and distribute must carry prominent
notices stating that you changed the files and the date of any changes, in
addition to preserving this original copyright notice and other credits.

While it is by no means required, the copyright holder of MDL
would appreciate being informed any time you create a modified version of
MDL that you are willing to distribute, because that is a
practical way of suggesting improvements to the standard version.

# TRADEMARK POLICY

**MULDIS** and **MULDIS MULTIVERSE OF DISCOURSE** are trademarks of Muldis
Data Systems, Inc. (<https://muldis.com>).
The trademarks apply to computer database software and related services.
See <https://muldis.com/trademark_policy.html> for the full written details
of Muldis Data Systems' trademark policy.

# ACKNOWLEDGEMENTS

None yet.
