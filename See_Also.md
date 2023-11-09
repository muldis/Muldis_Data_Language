# Muldis Data Language - See Also

This document is a central location within the Muldis Data Language
distribution where any important recommendations of or links to external
resources go.  This includes both resources that were helpful in making
Muldis Data Language, as well as resources that are or could be related to
Muldis Data Language.

*This document is substantially out of date and will be improved later.*

## IMPLEMENTATIONS OF MULDIS DATA LANGUAGE

These externally distributed projects are in progress or partial implementations
of Muldis Data Language.

* **Muldis Data Engine Reference**

This is intended to be a full implementation of Muldis Data Language meant for
production use, with versions written in a variety of host languages by
Muldis Data Systems, Inc., and
licensed under the Apache License version 2.  It is a full-fledged
language implementation intended to be used in the same manner as a typical
other language, where a "muldisder" binary exists that is used to compile or run
Muldis Data Language Plain Text source code ("foo.mdpt" files).  Alternately, its bulk
is a host language module that lets Muldis Data Language be used directly by
host language programs
as a sub-language in the same manner as the Perl DBI module; moreover,
users would typically specify Muldis Data Language code in a Hosted Data format
consisting of native host language data structures.

* **Set::Relation for Perl** - <https://metacpan.org/dist/Set-Relation>

Set::Relation provides a simple Perl-native facility for an application to
organize and process information using the relational model of data,
without having to employ a separate DBMS, and without having to employ a
whole separate language (such as **Muldis Data Engine Reference** does).  Rather, it is
integrated a lot more into the Perl way of doing things, and you use it
much like a Perl array or hash, or like some other third-party Set::
modules available for Perl.  This is a standalone Perl object class that
represents a Muldis Data Language relation value, and its methods implement all
the Muldis Data Language relational operators.  It is intended for production use, is
written by Muldis Data Systems, Inc., and is licensed under the
Apache License version 2.

## INFORMATION SOURCES

While making Muldis Data Language, the following resources were found to
be particularly useful:

* <http://www.thethirdmanifesto.com>

This is the Hugh Darwen's and Chris Date (C.J. Date)'s home on the web for
"*The Third Manifesto*" (*TTM*), their formal proposal for a solid
foundation for data and database management systems (DBMSs); like Edgar
Codd (E.F. Codd)'s original papers, *TTM* can be seen as an abstract
blueprint for the design of a DBMS and the language interface to such a
DBMS.  It consists in essence of a rigorous set of principles, stated in
the form of a series of prescriptions and proscriptions, that the authors
require adherence to on the part of a hypothetical database programming
language that they call **D**.

The proposal would avoid 'Object-Relational Impedance Mismatch' between
object-oriented programming languages and RDBMSs by fully supporting all
the capabilities of the relational model.  The main objective of The Third
Manifesto, besides being theoretically sound and avoiding arbitrary
restrictions and pragmatic debasement of the relational model, is to make a
simple, restricted and precise definition of the role of object orientation
in database management systems emphasizing the few valid ideas from object
modeling that are orthogonal to relational modeling.

Muldis Data Language has officially incorporated this blueprint into its own design,
and implements its principles without compromise, and so it is a concrete
language that qualifies as a **D**.  The *TTM* web site contains various
useful documents and links on the subject, some being specified further
below.

* **Databases, Types, and The Relational Model: The Third Manifesto**

Chris Date (C.J. Date), Hugh Darwen - "*Databases, Types, and The
Relational Model: The Third Manifesto*, 3rd edition, Addison-Wesley, 2006
(ISBN: 0-321-39942-0)"; see
<http://www.aw-bc.com/catalog/academic/product/0,1144,0321399420,00.html>.

This is the thicker, college level textbook about *The Third Manifesto*,
and it is the most central of the authors' publications, able to stand
alone and present nearly everything important.  It includes an informal
overview of both the relational model and a theory of types, a reference
section with the 15-page Manifesto proper and a grammar for a teaching
language
based on its principles called **Tutorial D**, a larger section which
explains and rationalizes the parts of the Manifesto, and sections that do
likewise for type inheritance what the earlier sections do with the
Manifesto proper.

* **Database Explorations: Essays on The Third Manifesto and Related Topics**

Chris Date (C.J. Date), Hugh Darwen - "*Database Explorations: Essays on
The Third Manifesto and Related Topics*, 1st edition, Trafford, 2010 July
(ISBN: 9781426937231)"; see
<http://bookstore.trafford.com/Products/SKU-000177853/Database-Explorations.aspx>.

This book is a followup to the prior-mentioned 2006 one and contains both
an updated version of the *Manifesto* itself and also a collection of both
new and updated writings by the authors that are related.

Of particular interest for Muldis Data Language, *Database Explorations* cites by name
the DBMS prototype Muldis Rosetta, and its user language Muldis Data Language, and
their author Darren Duncan; chapter 26, "An Approach Using Relation Valued
Attributes", is all about discussing Muldis Data Language's canonical means to
represent missing information, which is with empty RVAs.  This is the very
first time that Muldis Data Language or its author or related projects have ever been
recognized in an actual printed-on-paper book.

Note that the web site for *The Third Manifesto*, mentioned above, has
reproduced several chapters and appendices from this book.  Chapter 1
(<http://www.dcs.warwick.ac.uk/~hugh/TTM/DBE-Chapter01.pdf>) is the
15-page Manifesto proper; chapter 19
(<http://www.dcs.warwick.ac.uk/~hugh/TTM/DBE-Chapter19.pdf>) is the 9-page
"Inheritance Model" which extends the former.  Chapter 11
(<http://www.dcs.warwick.ac.uk/~hugh/TTM/DBE-Chapter11.pdf>) gives the
complete grammar of "**Tutorial D**".

* **Database in Depth: Relational Theory for Practitioners**

Chris Date (C.J. Date) - "Database in Depth: Relational Theory for
Practitioners, 1st edition, Oreilly, 2005 (ISBN: 0-596-10012-4)"; see
<http://www.oreilly.com/catalog/databaseid>.

This is the first printed book that Muldis Data Language's author had read fully, which
is related to *The Third Manifesto*, and it was their main introduction.
It explains in an easy to follow matter just what the relational data model
really is, a solid and provable logical system, and partially contrasts
with SQL's distorted view of it.  While being easy to follow, the book is
written towards people that are already database professionals, and doesn't
go into the basics that we should already know.

* <http://www.acm.org/classics/nov95/toc.html>

Edgar Codd (E.F. Codd) - "A Relational Model of Data for Large Shared Data
Banks"

Reprinted from *Communications of the ACM*, Vol. 13, No. 6, June 1970, pp.
377-387.  Copyright © 1970, Association for Computing Machinery, Inc.

This is the second famous 1969/1970 publication that first presented a
relational model of data to the world, which is the basis for the modern
database industry.

* <http://www.wiscorp.com/SQLStandards.html>

This web page of Whitemarsh Information Systems Corporation, run by one of
the people on the SQL standard drafting community, has copies of the
official SQL:2008, SQL:2003 and SQL:1999 specification documents, and other
related helpful documents about SQL, in PDF format.  For example,
<http://www.wiscorp.com/sql200n.zip> (warning, large file) has "documents
which will likely be the documents that represent the SQL 2008 Standard".

**TODO: Newest is <http://www.wiscorp.com/sql20nn.zip** for 2011 Dec 21.>

* <http://www.unicode.org/standard/standard.html>

Unicode Standard official documentation.

* <http://en.wikipedia.org/wiki/Relational_model>

The Wikipedia article on the relational data model, and related topics.

* <http://en.wikipedia.org/wiki/Tuple_calculus>

The Wikipedia article on Tuple calculus, a basis of the relational model.

* <http://en.wikipedia.org/wiki/Logical_connective>

The Wikipedia article on logical connectives, which explains the 16 dyadic
boolean logic operations and symbols.

* <http://www.rbjones.com/rbjpub/logic/log048.htm>

Another explanation of the 16 dyadic boolean logic operations and symbols.

Also, the vendor documentation for various relational and/or SQL databases
such as MySQL and SQLite were regularly consulted, and various other sites.

## SOME FULLY TTM/D RELATED DBMS PROJECTS

Besides **Muldis Data Engine Reference**, other projects exist which attempt
to implement *The Third Manifesto* fully and without compromise (that lack
anti-*TTM* features), though their current implementations may be
incomplete and/or in development.  None of these use 'SQL' as their native
language.

*This project list is out of date and some related projects are missing.*

### Free and Open Source Software

These software projects are released under a free and open source license,
as **Muldis Data Engine Reference** is, so you have the freedom to use the software for any
purpose, to examine the project source code, change it, and redistribute
it:

* **Rel** - <http://reldb.org>

Rel is a relational database server, written by Dave Voorhis
(`d.voorhis@derby.ac.uk`), that implements Date and Darwen's "**Tutorial D**"
language mainly "by the book".  It is written in Java (version 1.5) and
is operating-system independent.  It is licensed under the GNU GPL.

* **DuroDBMS** - <http://duro.sourceforge.net>

DuroDBMS is a relational database library, written by René Hartmann
(`rhartmann@users.sourceforge.net`).  It is written in C (with a Tcl
interface), is implemented on top of the Berkeley DB database library, and
runs on all POSIX/UNIX-like and 32-bit Windows operating systems.  It is
licensed under the GNU GPL.

* **Dee** - <http://www.quicksort.co.uk>

Dee is an implementation of **D** (built on the relational algebra
operators) as an extension to Python, written by Greg Gaughan
(`gjgaughan@users.sourceforge.net`).  It is written in Python and is
operating-system independent.  It is licensed under the GNU GPL.

### Shared Source Software

These software projects are released with access to the project source code
but lack permissions on use, modification, or redistribution that are
essential to qualify as free and open source software; some are available
at zero cost:

* **FlipDB** - <http://www.flipdb.com>

FlipDB is a relational database management system written by Paul Mansour
(`paul@carlislegroup.com`).  Pending a full implementation of the
relational algebra, FlipDB uses a simple but powerful query technique that
simulates relation-valued attributes and obviates the need for outer join
(or any explicit join).  The author is using Date's and Darwen's work as a
guide, and his intention is to not violate any of the principles set forth
in *TTM*, if not to implement all of **Tutorial D**.  It is written in
Dyalog APL, in a functional style with no loops or control structures, and
runs only on 32-bit Windows operating systems.  It is available under a
shared source agreement for personal use and study.

### Closed Source Software

These software projects are released without access to the project source
code or permission to change them, though some are available at zero cost:

* **Opus**

Opus is a command-line relational database development system, written by
David Cauz (`dcauz@rogers.com`) and Paul Church, that implements its own
"Opus" language (that has the syntactic style of C).  It is written in C
and only runs on Windows.  (Link no longer available.)

### Academic Design Projects

These project designs were made for academic purposes and don't include
implementations:

* **Db ("D flat")** -
<http://web.onetel.com/~hughdarwen/TheThirdManifesto/REAL.pdf>

This is a final year project by UMIST student Peter Nicol.

## SOME PARTIALLY TTM/D RELATED DBMS PROJECTS

Some DBMS exist which desire to support *TTM* principles but still justify
themselves to provide features that are anti-*TTM*.  They may or may not
use a SQL dialect as their command language.

### Free and Open Source Software

* **Dataphor** - <http://www.alphora.com>

Dataphor is a *TTM*-inspired commercial database application development
tool set, owned by Alphora (a trade name of Database Consulting Group LLC),
that implements its own **D4** language.  While *TTM* conformant in many
other respects, Alphora embraced the use of 3-valued-logic.  Dataphor is
written to the Microsoft .NET platform principally in C#.  It runs fully on
MS Windows, and some parts also on other platforms.  It is implemented
using a federated server; while it has a native database engine, it
emphasizes the use of various other database engines for storage.  Dataphor
is licensed under a modified BSD license.

* **Genezzo** - <http://www.genezzo.com>

Genezzo is a micro kernel style enterprise-strength SQL database server,
written mainly by Jeffrey Cohen (`jcohen@cpan.org`), currently under
construction.  It is written in a hybrid of C and Perl, and runs on any
operating system.  It is licensed under the GNU GPL.

### Closed Source Software

* **Teradata** - <http://www.teradata.com>

Teradata is a commercial DBMS that, as far as the developers know, is the
only SQL-DBMS that supports and/or defaults to set semantics.  They also
support, but don't encourage the use of, a mode that supports bag
semantics.  Bindings for many programming languages exist, including for
Perl.

## SOME SQL-BASED DBMS PROJECTS

Many DBMS exist which do not expressly support *TTM* principles and/or
actively embrace anti-*TTM* features.  Many of those use a SQL dialect as
their primary or only interface; a relative few are listed here.

### Free and Open Source Software

* **SQLite** - <http://www.sqlite.org>

SQLite is a small library that implements a fully transactional file-based
SQL database engine, written mainly by D. Richard Hipp (Hwaci - Applied
Software Research).  It is written in C (with creator-bundled Tcl bindings)
and runs on any operating system, being particularly suited for embedded
devices.  It is committed to the public domain and can be used in any other
license of program.  Bindings for many programming languages exist,
including for Perl.

* **PostgreSQL** - <http://www.postgresql.org>

PostgreSQL is a powerful SQL database server, owned by the PostgreSQL
Global Development Group.  It is written in C and runs on any operating
system.  It is licensed under a BSD-like license, specifically the license
of the University of California.  Bindings for many programming languages
exist, including for Perl.

* **MySQL** - <http://www.mysql.com>

MySQL is a multi-engine SQL database server, owned by MySQL AB.  It is
written in C and runs on any operating system.  It is dual-licensed under
the GNU GPL (at no cost) and under a proprietary license (for a fee).
Bindings for many programming languages exist, including for Perl.

* **Firebird** - <http://www.firebirdsql.org>

Firebird is a mature SQL database server, forked from the open sources of
InterBase by Inprise/Borland; portions are owned by Inprise/Borland and
members of the Firbird Foundation.  It is written in C++ (newer version)
and runs on any operating system.  Portions are licensed under various
Mozilla-Public-like licenses, specifically the Interbase Public License and
the Initial Developer's Public License.  Bindings for many programming
languages exist, including for Perl.

### Closed Source Software

* **Oracle** - <http://www.oracle.com/database>

* **Sybase** - <http://www.sybase.com>

* **SQL Server** - <http://www.microsoft.com/sql>

* **Informix** - <http://www.ibm.com/software/data/informix>

* **DB2** - <http://www.ibm.com/software/data/db2>

* **OpenBase** - <http://www.openbase.com>

* **FrontBase** - <http://www.frontbase.com>

## SOME OTHER DBMS PROJECTS

Many DBMS exist that are neither *TTM*/**D**-based nor primarily SQL based;
a relative few are listed here.

### Free and Open Source Software

* **Berkeley DB** - <http://www.sleepycat.com>

### Closed Source Software

* **FileMaker Pro** - <http://www.filemaker.com>

* **Valentina** - <http://www.paradigmasoft.com>

## MORE INFORMATION

Muldis Data Language is an [Acmeist](http://www.acmeism.org/) programming language for
writing portable database modules, that work with any DBMS and with any
other programming language, for superior database interoperability.
