# NAME

Muldis Data Language (MDL) - Relational database application programming language

# VERSION

This document is Muldis Data Language version 0.300.0.

# DESCRIPTION

This document aggregate is the human readable authoritative
formal specification of the **Muldis Data Language**, and of the virtual
environment in which it executes.  If there's a conflict between any other
document and this one, then either the other document is in error, or the
developers were negligent in updating it before this one.

The fully-qualified name of this document aggregate and the language
specification it contains (as a single composition) is
`Muldis_Data_Language https://muldis.com 0.300.0`.  It is the
official/original (not embraced and extended) Muldis Data Language
specification by the authority Muldis Data Systems (`https://muldis.com`),
version number `0.300.0` (this number matches the VERSION in this file).

The **Muldis Data Language** aggregate specification assumes that Muldis Data Language,
similar to some common programming languages, can be effectively defined
in terms of 3 individual specifications covering in turn its semantics
(architecture, behaviour, and type system), its syntax (grammar), and its
vocabulary (standard library).  These 3 specifications are mostly
independent and each one can evolve on its own and have many versions over
time, some of those under the original author's control, and some under the
control of other parties.

For the official Muldis Data Language by authority `https://muldis.com`, the default 3
component specifications are named, respectively:

* **Muldis Data Language Foundation** (**MDF**) -
`Muldis_Data_Language_Foundation https://muldis.com 0.300.0`.

* **Muldis Data Language Plain Text** (**MDPT**) -
`Muldis_Data_Language_Plain_Text https://muldis.com 0.300.0`.

* **Muldis Data Language Standard Library** (**MDSL**) -
`Muldis_Data_Language_Standard_Library https://muldis.com 0.300.0`.

In this context, the **Muldis Data Language** aggregate specification is mostly
just a top-level catalogue pointing to those 3 primary components, as well
as to some other things in the ecosystem.

The **Muldis Data Language Foundation** specification defines the fundamental
architecture, behaviour, and type system of Muldis Data Language.  For all intents and
purposes, it is the entire official Muldis Data Language specification except
for any candidate syntaxes and any candidate standard libraries.  So it is
generally useful to read this specification first and consider any others
subservient to it.  While many alternative syntaxes and standard libraries
are likely and expected to exist in a combination called **Muldis Data Language**,
substituting out **Muldis Data Language Foundation** for something with a large degree
of changes would likely yield a combination that is best to name something
other than **Muldis Data Language**.  **Muldis Data Language Foundation** defines the *native* form
of Muldis Data Language source code, which is homoiconic data structures composed
largely in terms of function calls, and is expressly agnostic to any
concrete language syntax.  It defines the user-facing behaviour/API of the
small number of foundational / low-level system-defined types and
operators and other features which are canonically written in one or more
third-party languages which are *hosting* Muldis Data Language; formally their
implementation or internals are expected to be hidden from the Muldis Data Language
user, and differ in arbitrarily large ways between hosts, so to take
advantage of the strengths of each host.
See [Foundation](Muldis_Data_Language_Foundation.md) for the **Muldis Data Language Foundation** specification.

The **Muldis Data Language Plain Text** specification defines the grammar of the official
concrete Muldis Data Language syntax that every Muldis Data Language implementation
is expected to support as an option.  It is intended to be a standard format
of interchange of both code and data between all Muldis Data Language implementations.
It is also expected to be the syntax of choice for users to write Muldis Data Language
applications or database schemas in, having the most direct correspondance
to the *native* homoiconic Muldis Data Language defined by **Muldis Data Language Foundation**, and
is designed to have a similar level of conciseness and readability as what
users get in both typical general purpose application programming languages
as well as SQL.
That being said, Muldis Data Language is designed to empower a variety of alternate
language syntaxes to be used in different areas of a program, either in
support of user tastes, or for better host/peer language integration
(including their ORMs), or as a method of emulating other programming
language environments or SQL DBMSs.
See [Plain_Text](Muldis_Data_Language_Plain_Text.md) for the **Muldis Data Language Plain Text** specification.

The **Muldis Data Language Standard Library** specification comprises a documented
library written entirely in Muldis Data Language which provides its common core
vocabulary, the system-defined data types and operators that regular users
of the language would employ directly in their applications and schemas.
It corresponds to the "standard library" that is intrinsic to or bundled
with typical general purpose application programming languages or SQL
DBMSs.  It is the bulk portion of Muldis Data Language that is self-hosted and can be
shared by all Muldis Data Language implementations, though the latter can choose to
internally substitute behaviour-maintaining host-native versions for
performance.  It comprises a set of Muldis Data Language *packages* (compilation
units) that users can choose from as dependencies of their applications and
schemas.  None are mandatory, and users can choose alternatives, but they
are recommended as the default options for their functionality.
See [Standard_Library](Muldis_Data_Language_Standard_Library.md) for the
**Muldis Data Language Standard Library** specification.

The **VERSIONING** section in this file presents a formal and future-proofed
method for specifying the fully-qualified names of each versioned entity.

All code written in Muldis Data Language should begin by specifying the fully-qualified
name of a concrete grammar it conforms to (either a **MDPT** version or an
alternative), except that this concept doesn't apply to the **MDF**
homoiconic native form.  Every Muldis Data Language *package* should both specify the
fully-qualified name of a foundation (a **MDF** version typically) that it
is known to work with, as well as specify the fully-qualified names of all
other packages that satisfy its direct requirements, whether system-defined
(typically one or more `MDSL`) or user-defined.  Doing all of this should
make the code
unambiguous to both human and machine (eg, implementing) readers of the code.

# VERSIONING

Every Muldis Data Language *package* (compilation unit) is expected to declare a
fully-qualified name, or *identity*, so that it can easily be referred to
and be distinguished from every other package that does or might exist.
One main reason for referring is when one package *X* is defined partly in
terms of another *Y*, that is when *Y uses X*, so this dependency can be
clearly stated.  A second main reason is in order to fetch a package from,
or store a package into, a *compilation unit repository*, or otherwise
index a package loaded for execution.  This *identity* requirement applies
both to every individual package of the **MDSL** as well as to every other
package regardless of origin.

In addition, every Muldis Data Language component specification document is
similarly expected to declare its own fully-qualified name, so that it can
at the very least be referred to by other documentation or users.  In the
case of the **MDF**, its name is also referred to by each package as a
fundamental dependency of its own kind.  In the case of the **MDPT**, its
name is also referred to by each source code written in that syntax, so it
is explicitly clear on how to parse that code.

The expected format and meaning of a Muldis Data Language fully-qualified name varies
depending on the specific kind of entity being named:

* The expected fully-qualified name of each Muldis Data Language package version is the
same format and meaning for both declaration and reference.  It has 3 main
parts: *package base name*, *authority*, and *version number*.  The
combination of these 3 parts is the identity of a package, and a program
can typically (but not necessarily always) use multiple versions of any
given package at once.  A *package base name* is an ordered sequence of 1
or more nonempty character strings; while Muldis Data Language itself places no other
restrictions on a package base name, it is expected that the community at
large should self-regulate reasonable names as is common for libraries or
modules for other programming languages.

* The expected fully-qualified name of a **Muldis Data Language Foundation** version as
referenced as a dependency by a package has 2 main parts: *authority*, and
*version number*.

* The expected fully-qualified name of a **Muldis Data Language Plain Text** version as
referenced by source code, where the latter declares the former to be its
format, has 4 main parts: *family name*, *syntax name*, *authority*, and
*version number*.  The *family name* and *syntax name* are simply the 2
character strings `Muldis_Data_Language` and `Plain_Text` respectively, for **MDPT**;
alternative (non-legacy) concrete syntaxes can and are encouraged to use
the same format, albeit using some other distinguishing *syntax name*.
Implementations of other arbitrary programming language or data formats in
terms of treating them as a Muldis Data Language dialect can be arbitrarily complicated
as far as knowing how to distinguish said alternatives from each other,
depending on whether they have reliable simple format declarations or not.
Note that a leading MDPT declaration in source code should be effective as
a "magic number" for identifying it as being MDPT source code.

* The expected fully-qualified name of a Muldis Data Language specification
document (component or aggregate) as declared in said document has 3 main
parts: *document base name*, *authority*, and *version number*.  The
*document base name* is a character string, officially used examples being
`Muldis_Data_Language`, `Muldis_Data_Language_Foundation`, `Muldis_Data_Language_Plain_Text`, and
`Muldis_Data_Language_Standard_Library`.

The expected format and meaning of an *authority* and a *version number*
is the same for all of the above-mentioned kinds of entities, and so their
common definitions follow.

An *authority* is some nonempty character string whose value uniquely
identifies the authority or author of the versioned entity.  Generally
speaking, the community at large should self-regulate authority identifier
strings so they are reasonable formats and so each prospective
authority/author has one of their own that everyone recognizes as theirs.
Note that an authority/author doesn't have to be an individual person; it
could be some corporate entity instead.

Examples of recommended *authority* naming schemes include a qualified
base HTTP url belonging to the authority (example `https://muldis.com`) or
a qualified user identifier at some well-known compilation unit repository
(example `https://github.com/muldis` or `cpan:DUNCAND`).

For all official/original works by Muldis Data Systems, Inc., the
*authority* has always been `https://muldis.com` and is expected to remain
so during the foreseeable future.

If someone else wants to *embrace and extend* Muldis Data Language, then they must use
their own (not `https://muldis.com`) base authority identifier, to prevent
ambiguity, assist quality control, and give due credit.

In this context, *embrace and extend* means for someone to do any of the
following:

* Releasing a modified version of this current multi-document or any
component thereof where the original of the modified version was released
by someone else (the original typically being the official release), as
opposed to just releasing a delta document that references the current one
as a foundation.  This applies both for unofficial modifications and for
official modifications following a change of who is the official maintainer.

* Releasing a delta document for a version of this current multi-document or
any component thereof where the referenced original is released by someone
else, and where the delta either makes incompatible semantic or syntax
changes or makes changes to the `System` package.

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
scheme compatible with another.  The only thing Muldis Data Language requires is that
every distinct version of an entity has a distinct fully-qualified name.

For each official/original work by Muldis Data Systems related to Muldis Data Language
and released after 2016 April 1, except where otherwise stated, it uses
*semantic versioning* for each *version number*, as described below.
Others are encouraged to follow the same format, but are not required to.

The *semantic versioning* described below is intended to be the same as
that defined by the public standard **Semantic Versioning 2.0.0** as
published at <https://semver.org> but it is reworded here so that the
current document can be understood if the external standard disappears.

A *version number* for authority `https://muldis.com` is an ordered
sequence of integers, the order of these being from most significant to
least, with 3 positions [MAJOR,MINOR,PATCH] and further ones
possible.  The version sequence may have have as few as 1
most significant position.  Any omitted trailing position is treated as if
it were zero.  Each of {MAJOR,MINOR,PATCH} must be a non-negative integer.
MAJOR is always (except when
it is zero) incremented when a change is made which breaks
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

Currently this document does not specify matters such as how to indicate
maturity, for example production vs pre-production/beta/etc, so explicit
markers of such can either be omitted or be based on other standards.

*This is all subject to change.*

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Data Language** (**MDL**).

MDL is Copyright © 2002-2018, Muldis Data Systems, Inc.

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
