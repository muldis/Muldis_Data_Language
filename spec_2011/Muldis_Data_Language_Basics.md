# NAME

Muldis::D::Basics - 10,000 Mile View of Muldis D

# VERSION

This document is Muldis::D::Basics version 0.148.1.

# PREFACE

This document is part of the Muldis D language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document
before you read this one, which provides subservient details.

# DESCRIPTION

This document provides a 10,000 mile view of the Muldis D language.  It
provides the basics of how the language is designed and works, as a
foundation upon which to understand the other parts of the language spec.

# NOTES ON TERMINOLOGY

There are a few terms that the Muldis D documentation uses which may have
different meanings than what you may be used to, so here are a few notes to
clarify what they mean in this document.  Similarly, there are some terms
used in the industry that are expressly not used here so to help avoid
confusion given what meaning is often attributed to them.

=over

=item type / data type

The term I<type> as a noun always refers to a I<data type>; the term is not
used to indicate classifications of other things; eg, I<kind> or other
terms will be used for such instead, to avoid confusion.  The terms
I<class> and I<domain> are not used in this documentation to mean I<type>.

=item value, variable, constant

A I<value> is unique, eternal, immutable, and is not fixed in time or space
(it has no address).  A I<variable> is fixed in time and space (it does
have an address); it holds an appearance of a value; it is neither unique
nor eternal nor immutable in the general case.  A I<constant> is a variable
which is defined to not mutate after initially being set, or alternately is
a niladic function (that always results in the same value).  Terms like
I<object> are not used in this documentation for any aspects of Muldis D
since their meaning in practice is both ambiguous and wide-reaching, and
could refer to both values and variables depending on usage context.

=item universal

The term I<universal> refers to the common superset of all allowable sets,
and is specifically non-recursive.  While philosophy in general might allow
it (or might not due to certain paradoxes that might result), Muldis D
specifically does not allow any set to be a member of itself.  No Muldis D
data type may be defined in terms of itself, either directly or indirectly;
any data type must be completely defined in isolation before some other
type may be defined in terms of it.  Therefore, I<universal> in this
documentation only refers to values or types whose definitions follow those
non-recursion rules.

=item text, character

A I<text> is a string composed of Unicode abstract I<characters> which is
formatted as a sequence of Unicode abstract I<code points> in canonical
decomposed normal form (NFD).  Two character strings will generally match
at the grapheme abstraction level.  Of course, a Muldis D implementation
doesn't actually have to store character data in NFD; but default matching
semantics need to be as if it did.

=item tuple

A I<tuple> is an unordered heterogeneous collection of 0..N elements that
are keyed by the element's name; each element is a name-value pair, and all
names in the tuple are distinct.  While I<tuple> legitimately refers to the
same thing as the Muldis D term I<sequence> in other contexts, it does
not in this documentation.  Terms like I<record> or I<row> are not used in
this documentation, the latter in particular because it implies ordered.

=item relation, relvar, relcon

A I<relation> is like an unordered homogeneous set of I<tuple> where all
member tuples have identical degree and name-sets, but that a relation data
type knows what its allowed names are even if it has no tuples.  Like with
I<tuple>, the term I<relation> legitimately refers to a set or "ordered
tuple" in other contexts, but it does not in this documentation.  Terms
like I<record set> or I<row set> or I<table> are not used in this
documentation, the last 2 in particular because they imply a significance
to the order of tuples, where there is none in a relation.  Moreover, the
term I<domain> does not mean the same thing as I<relation>, and neither
does the term I<function>; those terms have distinct meanings here.  Note
that the term I<relvar> is short hand for I<relation-typed variable>, and
I<relcon> is short hand for I<relation-typed constant>.  Note also that a
I<relational database> is called that I<because> it is composed of
relations, and I<not> just because its relations can be joined or be
associated through subset (foreign key) constraints.

=item function

A I<function> is a routine whose invocation is used as a value expression,
and it conceptually serves as a map between the domains of its parameters
and its result value.  A I<function> is not the same as a I<relation>,
though both can be used as maps between values.  Besides their conceptual
difference in Muldis D as a routine vs a value, a selected I<relation>
value in Muldis D is always finite, and hence so is the cardinality of
the map it can provide; whereas, a function can have an infinite map size.

=item database / relational database, dbvar, dbcon

Within this documentation, the actually more generic term I<database> will
be used to refer exclusively to a I<relational database>, so you should
read the former as if it were the latter.  A I<database> is a tuple, all of
whose (distinctly named) attributes are each relation-typed or
database-typed (a recursion whose leaves are all relations); one holds all
user data that is being maintained as an interconnected unit.  A
database-typed variable, aka a I<dbvar>, is managed by a DBMS/RDBMS, and
such is what is more informally referred to outside this documentation as a
"database".  Whenever a user is "using a database", they are reading or
updating a dbvar.  Examples of databases are genealogy records, financial
records, and a CMS' data.  A I<database> is I<not> a program.  A
database-typed constant is a I<dbcon>.

=item catalog

A I<catalog> is a special kind of dbvar or dbcon whose relations hold
metadata about the normal databases that hold user data (and about
themselves too); updating a catalog dbvar has the side-effect of changing
the structure of the associated normal database.  This metadata describes
all user-defined data types and operators, plus base and viewed relations,
stored with and used with the database.

=item depot / repository

A I<depot> or I<repository> is a local abstraction of a typically external
storage system which holds 1 database variable and 1 associated catalog,
plus perhaps other details that assist the mapping of the abstraction to
the actuality.  All user-defined non-lexical code and data lives in one or
more depots, and those are generally persisted.  A depot can also have just
code, in which case it is essentially a dynamically loaded library.

=item DBMS / RDBMS

Within this documentation, the actually more generic term I<DBMS> will be
used to refer exclusively to a I<RDBMS> (Relational Database Management
System), so you should read the former as if it were the latter.  A
I<RDBMS> is a computer program that manages relational database variables,
associated catalogs, and depots in general.  Muldis D aspires to or does
define one, and likewise are various other I<TTM>-inspired programs like
Rel and Duro; most other DBMS-like programs are technically non-relational,
including all SQL DBMSs such as Oracle, PostgreSQL and SQLite, though they
usually give lip-service to the relational data model and approximate a
RDBMS to varying degrees.

=item module

A I<module> is an analogy of a I<depot> that is for system-defined DBMS
entities rather than user-defined ones.  The two are similar in that they
both define a library of materials organized in a public namespace
hierarchy.  The two differ in that a I<depot> is defined entirely in pure
Muldis D, such as a DBMS user can do, while a I<module> is defined at least
partially in some other language, such as that of the DBMS' own source
code.  Alternately, they differ in that all I<depot> are visible in the
DBMS under the public namespace for user-defined entities while all
I<module> are treated specially by the DBMS and are visible under the
public namespace for system-defined entities.

=item package

A I<package> is the common generalization of a I<module> and a I<depot>;
within this documentation, the term I<package> is typically used as a
shorthand where it would otherwise say I<module or depot>.

=item sequence / array, sequence generator

Within this documentation, a I<sequence> or I<array> generically refers to
an ordered collection of 0..N elements.  While I<array> legitimately has
more broad meanings in other contexts, and includes both matrices plus
unordered but indexed collections of name-value pairs, it does not in this
documentation.  Note that a sequence may be used simply to maintain a
simple collection in order, though the actual order of its elements may not
always be significant.  Sometimes I<sequence> or I<array> also refer
specifically to the C<Array> data type, which is a particular binary
relation.  The term I<sequence> by itself never refers to the concept of a
I<sequence generator>; in this documentation, the latter concept is only
referred to by the longer term I<sequence generator>.

=item selector

A I<selector> is a routine that captures an appearance of a value for use
in a variable or expression.  A I<value literal> is also a common special
case of a selector.  The term I<constructor> is not used in this
documentation because all values in Muldis D are conceptually eternal and
immutable, so it does not make sense to say that we are "building" one; we
are "selecting" one.

=item fail

Within this documentation, if a routine is said to I<fail> under some
circumstance, such as with certain arguments, that can mean either or both
of the routine throwing an exception at runtime, or failing to compile in
the first place (which is a thrown exception at compile time); the latter
is more likely to happen if the compiler can detect that certain arguments
will always be unacceptable, and the former usually happens just if a
problem can likely not be caught at compile time.  Other terms like
I<requires> or I<must> may be used as well to indicate that a failure would
occur if they aren't satisfied.  A I<fail> is a fatal error.

=item warn

Within this documentation, if a routine is said to I<warn> under some
circumstance, such as with certain arguments, that means that the system
doesn't recognize any fatal problem, but it detects that the programmer may
have done something they didn't intend, such as an equality test between
two variables whose declared types are numeric and character data, which
would always have a false result.

=item atomic

Within this documentation, an I<atomic> DBMS operation is an operation that
is completely indivisible from the perspective of I<every> DBMS user,
I<including> the user performing that operation.  From every user's
perspective, the database/dbvar-federation transitions directly from the
consistent state before the operation had an effect to the consistent state
where the operation's effect is complete, and there does not exist any
intermediate state.  If an atomic operation fails, such as because it would
have resulted in an inconsistent state, then the after-state is identical
to the before-state, the operation then being a no-op.

=item transaction, nested/child transaction

Within this documentation, a I<transaction> generally I<is> divisible from
the perspective of I<just> the user performing that transaction, where they
see it as a sequence of distinct I<atomic> operations with distinct
intermediate consistent database states between them, where one or more of
the latest operations in the sequence may optionally be undone / rolled
back, and the remainder committed to end the transaction.  A I<transaction>
is indivisible from the perspective of every DBMS user besides the one
performing the transaction.  A I<nested/child transaction> is a
sub-sequence of the atomic operations comprising its parent transaction
that has been identified for greater ease of managing the parent or
outermost transaction.

=back

# NOTES ON TEXT CHARACTER LITERALS

The text of the Muldis D documentation includes a variety of characters
from the Unicode character repertoire that are not in the character ASCII
repertoire, almost all of them in the sections describing the concrete
syntaxes of the Muldis D language.  The documentation files are also
canonically stored in the Unicode UTF-8 character encoding.  This
documentation section enumerates the characters used literally anywhere in
the Muldis D spec along with their Unicode character names and a brief
description of their use.  This is so that it is easier to recognize said
characters when they are seen, especially since the Unicode standard
includes many cases of distinct characters that visually are nearly
identical, so you know unambiguously what characters the Muldis D spec is
actually referring to.

This first set of characters are all in the 7-bit ASCII repertoire, and are
the minimum set of characters you actually need to be able to write, in
order to use all Muldis D features:

    Chr | Unic | Unicode                | Concrete Muldis D
    Lit | Cdpt | Character Name         | Mainly Uses for
    ----+------+------------------------+----------------------------------
        | 0x20 | SPACE                  | Uni char name lit, delim Comm lit
    !   | 0x21 | EXCLAMATION MARK       | logical not, factorial, other ops
    "   | 0x22 | QUOTATION MARK         | double-quot; delim quot Name lits
    #   | 0x23 | NUMBER SIGN            | num lits/cnts, delim code commnts
    $   | 0x24 | DOLLAR SIGN            | sigil rep scalars
    %   | 0x25 | PERCENT SIGN           | sigil rep tuples
    &   | 0x26 | AMPERSAND              | sigil for subj-to-upd params/args
    '   | 0x27 | APOSTROPHE             | single-quot; delim Text|Blob lits
    (   | 0x28 | LEFT PARENTHESIS       | delim param/arg list
    )   | 0x29 | RIGHT PARENTHESIS      | delim param/arg list
    *   | 0x2A | ASTERISK               | numeric multiply op, Rat literals
    +   | 0x2B | PLUS SIGN              | numeric sum op
    ,   | 0x2C | COMMA                  | list elem separator
    -   | 0x2D | HYPHEN-MINUS           | num litrls, num diff op, keywords
    .   | 0x2E | FULL STOP              | entity name chains, Rat literals
    /   | 0x2F | SOLIDUS                | numeric division op, Rat literals
    0   | 0x30 | DIGIT ZERO             | numeric literals, entity names
    ... | ...  | ...                    | ...
    9   | 0x39 | DIGIT NINE             | numeric literals, entity names
    :   | 0x3A | COLON                  | value literal elem sep, bind ops
    ;   | 0x3B | SEMICOLON              | stmt/expr separator
    <   | 0x3C | LESS-THAN SIGN         | is-less-than op, deli material rf
    =   | 0x3D | EQUALS SIGN            | is-identical op, other ops
    >   | 0x3E | GREATER-THAN SIGN      | i-greatr-thn op, deli material rf
    ?   | 0x3F | QUESTION MARK          | optional param indicator
    @   | 0x40 | COMMERCIAL AT          | sigil rep rela, dispat param indc
    A   | 0x41 | LATIN CAPITAL LETTER A | entity names, keywords
    ... | ...  | ...                    | ...
    Z   | 0x5A | LATIN CAPITAL LETTER Z | entity names, keywords
    [   | 0x5B | LEFT SQUARE BRACKET    | delim ordered value list
    \   | 0x5C | REVERSE SOLIDUS        | backslash; str char esc, unspace
    ]   | 0x5D | RIGHT SQUARE BRACKET   | delim ordered value list
    ^   | 0x5E | CIRCUMFLEX ACCENT      | exponentiation op, Rat literals
    _   | 0x5F | LOW LINE               | underscore; entity names, keywrds
    `   | 0x60 | GRAVE ACCENT           | backtick; delim code comments
    a   | 0x61 | LATIN SMALL LETTER A   | entity names, keywords
    ... | ...  | ...                    | ...
    z   | 0x7A | LATIN SMALL LETTER Z   | entity names, keywords
    {   | 0x7B | LEFT CURLY BRACKET     | delim nonordered value list
    |   | 0x7C | VERTICAL LINE          | absolute-difference op
    }   | 0x7D | RIGHT CURLY BRACKET    | delim nonordered value list
    ~   | 0x7E | TILDE                  | string catenation op

This second set of characters are all outside the 7-bit ASCII repertoire,
and are provided so that Muldis D code can be easier to write in a visually
concise and attractive way, but any context which allows for their use in a
significant way also provides a means to accomplish the same task using
just the 7-bit ASCII repertoire:

    Chr | Unicod | Unicode                    | Concrete Muldis D
    Lit | Codept | Character Name             | Mainly Uses for
    ----+--------+----------------------------+----------------------------
    ¬   | 0xAC   | NOT SIGN                   | logical not
    ×   | 0xD7   | MULTIPLICATION SIGN        | relational cross-product op
    ÷   | 0xF7   | DIVISION SIGN              | relational divide
    ←   | 0x2190 | LEFTWARDS ARROW            | logical if op
    ↑   | 0x2191 | UPWARDS ARROW              | logical nand/not-and op
    →   | 0x2192 | RIGHTWARDS ARROW           | logical imp/implies op
    ↓   | 0x2193 | DOWNWARDS ARROW            | logical nor/not-or op
    ↔   | 0x2194 | LEFT RIGHT ARROW           | logical xnor/iff op
    ↚   | 0x219A | LEFTWARDS ARROW WITH       | logical nif/not-if op
        |        |   STROKE                   |
    ↛   | 0x219B | RIGHTWARDS ARROW WITH      | logic nimp/not-implies op
        |        |   STROKE                   |
    ↮   | 0x21AE | LEFT RIGHT ARROW WITH      | logical xor/exclusive-or op
        |        |   STROKE                   |
    ∅   | 0x2205 | EMPTY SET                  | alias Nothing/empty-set lit
    ∆   | 0x2206 | INCREMENT                  | symmetric-diff/exclusion op
    ∈   | 0x2208 | ELEMENT OF                 | is-member op
    ∉   | 0x2209 | NOT AN ELEMENT OF          | is-not-member op
    ∋   | 0x220B | CONTAINS AS MEMBER         | has-member op
    ∌   | 0x220C | DOES NOT CONTAIN AS MEMBER | has-not-member op
    ∖   | 0x2216 | SET MINUS                  | rel diff op (not backslash)
    ∞   | 0x221E | INFINITY                   | alias infinity lits
    ∧   | 0x2227 | LOGICAL AND                | logical and op
    ∨   | 0x2228 | LOGICAL OR                 | logical inclusive-or op
    ∩   | 0x2229 | INTERSECTION               | intersection op
    ∪   | 0x222A | UNION                      | union op
    ≠   | 0x2260 | NOT EQUAL TO               | is-not-identical op
    ≤   | 0x2264 | LESS-THAN OR EQUAL TO      | is-before-or-same op
    ≥   | 0x2265 | GREATER-THAN OR EQUAL TO   | is-after-or-same op
    ⊂   | 0x2282 | SUBSET OF                  | is-proper-subset op
    ⊃   | 0x2283 | SUPERSET OF                | is-proper-superset op
    ⊄   | 0x2284 | NOT A SUBSET OF            | is-not-proper-subset op
    ⊅   | 0x2285 | NOT A SUPERSET OF          | is-not-proper-superset op
    ⊆   | 0x2286 | SUBSET OF OR EQUAL TO      | is-subset op
    ⊇   | 0x2287 | SUPERSET OF OR EQUAL TO    | is-superset op
    ⊈   | 0x2288 | NEITHER A SUBSET OF NOR    | is-not-subset op
        |        |   EQUAL TO                 |
    ⊉   | 0x2289 | NEITHER A SUPERSET OF NOR  | is-not-superset op
        |        |   EQUAL TO                 |
    ⊤   | 0x22A4 | DOWN TACK                  | alias True/tautology lit
    ⊥   | 0x22A5 | UP TACK                    | alias Fls/contradiction lit
    ⊻   | 0x22BB | XOR                        | logical xor/exclusive-or op
    ⊼   | 0x22BC | NAND                       | logical nand/not-and op
    ⊽   | 0x22BD | NOR                        | logical nor/not-or op
    ⊿   | 0x22BF | RIGHT TRIANGLE             | antijoin/semidiff op
    ⋈   | 0x22C8 | BOWTIE                     | (natural inner) join op
    ⋉   | 0x22C9 | LEFT NORMAL FACTOR         | semijoin op
        |        |   SEMIDIRECT PRODUCT       |

This third set of characters have no specific planned use right now, but
are of interest for various reasons, either because they might be used for
something in the future, or because for now they have been specifically
rejected in favor of some other alternatives for now:

    Chr | Unicod | Unicode                 | Possible Future Use
    Lit | Codept | Character Name          | or Reason To Reject
    ----+--------+-------------------------+-------------------------------
    ±   | 0xB1   | PLUS-MINUS SIGN         | use still to determine
    ∀   | 0x2200 | FOR ALL                 | use still to determine
    ∃   | 0x2203 | THERE EXISTS            | use still to determine
    ∄   | 0x2204 | THERE DOES NOT EXIST    | use still to determine
    ⋊   | 0x22CA | RIGHT NORMAL FACTOR     | possible alias for semijoin
        |        |   SEMIDIRECT PRODUCT    |
    ▷   | 0x25B7 | WHITE RIGHT-POINTING    | antijoin; is geom char
        |        |   TRIANGLE              |
    ⟕   | 0x27D5 | LEFT OUTER JOIN         | half-outer-join op; no render
    ⟖   | 0x27D6 | RIGHT OUTER JOIN        | some fonts don't render
    ⟗   | 0x27D7 | FULL OUTER JOIN         | some fonts don't render
    ⨝   | 0x2A1D | JOIN                    | some fon no rend, alt exists
    ⨯   | 0x2A2F | VECTOR OR CROSS PRODUCT | some fon no rend, alt exists

Note regarding font rendering.  Under Mac OS X 10.9.2 Mavericks, every
application tried will properly display C<JOIN> except for Mozilla
applications (Firefox and Thunderbird).  Examples that I<do> work include:
Safari, Chrome, BBEdit, Terminal, MS Word 2011, Adium.
Some other user with Thunderbird didn't have the randering problem though.
UPDATE:  Under Mac OS X 10.9.5, C<JOIN> I<was> displayed correctly by
Firefox (46.0.1) and Thunderbird (31.7.0).

Note that only various concrete Muldis D syntaxes use trans-ASCII
characters, and the central abstract Muldis D syntax which those all
distill to uses only ASCII characters for all system-defined entities.

# INTERPRETATION OF THE RELATIONAL MODEL

The relational model of data is based on predicate logic and set theory.

The model assumes that all data is represented as mathematical N-ary
I<relations>, an N-ary relation being a subset of the cartesian product of
N I<data types>.  Reasoning about such data is done in two-valued predicate
logic, meaning there are 2 possible evaluations for each proposition,
either I<true> or I<false>.

The basic relational building block is the data type, which can consist of
either scalar values or values of more complex types.  A I<tuple> is an
unordered set of I<attributes>, each of which has a name and a declared
data type; an attribute value is a specific valid value for the type of the
attribute.  An N-relation is defined as an unordered set of N-tuples, and
the tuples comprise the I<body> of the relation; the relation has a
I<heading>, which is a set of attribute definitions (their names and
types); this heading is also the heading of each of its tuples.

A heading represents a predicate, and there is a one-to-one correspondence
between the free variables of the predicate and the attribute names of the
heading.  The body of a relation represents the set of true propositions
that can be formed from the predicate represented by the relation's
heading.  The body of a tuple with the same heading provides attribute
values to instantiate the predicate into a proposition by substituting each
of its free variables.  When a tuple appears in a relation body, the
proposition it represents is deemed to be true.  Contrariwise, for every
tuple whose heading is the same as the relation's but does not appear in
the relation body, its proposition is deemed to be false.  This assumption
is known as the I<closed world assumption>.

The relational model specifies that data is operated on by means of a
relational calculus or a relational algebra.  These 2 are logically
equivalent; for any expression in the relational calculus, there is an
equivalent one in the relational algebra, and vice versa.  Relational
algebra, an offshoot of first-order logic, is a set of relations closed
under operators; each operator takes N relations as arguments and results
in a relation.  While the relational algebra provides a more procedural way
for specifying database queries, in contrast the relational calculus
provides a more declarative way for specifying queries.

## Mechanics of Some Relational Operations

This documentation section takes a very informal (and possibly blatantly
incorrect) alternate approach to describing the nature of relations,
tuples, and attributes, within the context of explaining the mechanics of
how some relational operations work in practice.

Herein, we shall conceptualize a relation as a long boolean expression,
consisting of a string of basic boolean-valued expressions that are
selectively anded or ored together.  A basic boolean-valued expression, C<<
<attr> >>, takes the form C<< attribute <name> is <value> >>.  Each tuple
body, C<< <tuple> >>, in the relation takes the form of a chained C<and>
that connects N C<< <attr> >>, one per each attribute in the relation, and
each having a distinct C<< <name> >>.  The relation body takes the form of
a chained C<or> that connects N C<< <tuple> >>, one per each tuple in the
relation, and each C<< <tuple> >> has the same set of C<< <name> >> as the
others, but the set of C<< <value> >> that each C<< <tuple> >> has is
distinct.

Take, for example, a relation having some details about people, where each
attribute is a type of detail and each tuple has details for one person:

       name is John  and age is 32 and city is Vancouver
    or name is Andy  and age is 46 and city is Toronto
    or name is Julia and age is 27 and city is Halifax
    etc...

Or a multi-relation example involving suppliers, foods, and shipments:

       farm is Hodgesons and country is Canada
    or farm is Beckers   and country is England
    or farm is Wickets   and country is Canada

       food is Bananas and colour is yellow
    or food is Carrots and colour is orange
    or food is Oranges and colour is orange
    or food is Kiwis   and colour is green
    or food is Lemons  and colour is yellow

       farm is Hodgesons and food is Kiwis   and qty is 100
    or farm is Hodgesons and food is Lemons  and qty is 130
    or farm is Hodgesons and food is Oranges and qty is 10
    or farm is Hodgesons and food is Carrots and qty is 50
    or farm is Beckers   and food is Carrots and qty is 90
    or farm is Beckers   and food is Bananas and qty is 120
    or farm is Wickets   and food is Lemons  and qty is 30

Now a very simple pair of relations:

       x is 4 and y is 7
    or x is 3 and y is 2

       y is 5 and z is 6
    or y is 2 and z is 1
    or y is 2 and z is 4

So now will be briefly introduced a few common fundamental relational
operations, that are projection, join, union.

A projection of a relation derives a relation that has a subset of the
original's attributes, and all of its tuples.  Continuing the boolean
expression analogy, the projected relation contains fewer C<< and <attr> >>
than the original.  For example, lets take the projection of the C<food>
column from the shipments relation, to get, initially:

       food is Kiwis
    or food is Lemons
    or food is Oranges
    or food is Carrots
    or food is Carrots
    or food is Bananas
    or food is Lemons

Now, the above expression can be simplified because it now contains
redundancies, and the simplified version is logically identical:

       food is Kiwis
    or food is Lemons
    or food is Oranges
    or food is Carrots
    or food is Bananas

So this projected relation has 5 tuples rather than the original 7, and
saving logical redundancy is why relations never have duplicate tuples.

A join of 2 relations derives a relation that has all of the originals'
attributes, and its set of tuples is fundamentally the cartesian product of
those of the originals.  Following our boolean analogy, we start off by
pairwise connecting instances of every C<< <tuple> >> of the first relation
with instances of every C<< <tuple> >> of the second one, with the members
of each pair then being chained together with C<and> to form a single,
longer chain of C<and>.  Note that join is commutative, so it doesn't
matter which of the source relations is first or second, the result is the
same, as much as C<foo and bar> is the same as C<bar and foo>.  For
example, lets do a join of our 2 simplest relations:

       x is 4 and y is 7 and y is 5 and z is 6
    or x is 4 and y is 7 and y is 2 and z is 1
    or x is 4 and y is 7 and y is 2 and z is 4
    or x is 3 and y is 2 and y is 5 and z is 6
    or x is 3 and y is 2 and y is 2 and z is 1
    or x is 3 and y is 2 and y is 2 and z is 4

Now, when multiple relations are connected into one such as with a join,
the relational model assumes that if either of the sources have attributes
with the same names as each other, then they are both describing the same
things.  In this case, the references to attribute C<y> from both relations
are talking about the same C<y>.  And so, any result tuples that contradict
themselves, saying that C<y> equals both one value and equals a different
one, can't ever be true and are eliminated; only the tuples where the C<y>
value is identical are kept:

       x is 3 and y is 2 and y is 2 and z is 1
    or x is 3 and y is 2 and y is 2 and z is 4

Moreover, this expression can be simplified by removing the redundant C<y>
attribute:

       x is 3 and y is 2 and z is 1
    or x is 3 and y is 2 and z is 4

All attributes in a relation have distinct names.  And if there were any
identical tuples, the redundant ones would be eliminated.

A join operation has several trivializing scenarios.  If the 2 source
relations have no attribute names in common, the result is simply the
cartesian product.  If the 2 sources have all their attribute names in
common, the result is the common subset or intersection of their existing
sets of tuples.  If one source has all the attributes of the other, but the
reverse isn't true, then the result is a subset of tuples from the relation
that has more attributes; this is a semijoin.

A union of 2 relations, which requires that the 2 relations have the same
headings, derives another relation with the same heading, and a union of
the two's set of tuples as its body, with any duplicates eliminated.  In
terms of our boolean analogy, a union is simply chaining together the
entirety of each relation's boolean expression with an C<or>, and then
eliminating redundancies from the result.

A full list of all the relational operators having more formal (but Muldis
D specific) descriptions occurs in the [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md)
document; that list does I<not> use the aforementioned boolean analogies.

# MULDIS D

Muldis D is a computationally and Turing complete (and industrial strength)
high-level programming language with fully integrated database
functionality; you can use it to define, query, and update relational
databases.  The language's paradigm is a mixture of declarative,
homoiconic, functional, imperative, and object-oriented.  It is primarily
focused on providing reliability, consistency, portability, and ease of use
and extension.  (Logically, speed of execution can not be declared as a
Muldis D quality because such a quality belongs to an implementation alone;
however, the language should lend itself to making fast implementations.)

The language is rigorously defined and requires users to be explicit, which
leaves little room for ambiguity and related bugs.  When something is
specified in Muldis D, its semantics should be well known and fully
portable (not implementation dependent).  If a conforming implementation
(such as **Muldis Data Engine Reference**) can't provide a specified
behaviour, code using it will refuse to run at all, rather than silently
changing its semantics; this also helps users to avoid bugs.  Moreover,
Muldis D generally disallows any details of an implementation's "physical
representation" or other internals to leak through into the language; eg,
there is no "varchar" vs "char", simply "text".  Users should not have to
know about this level of detail, and implementers should be free to
adaptively pick optimum ways to satisfy user requests, and change later.

Muldis D, being first and foremost a data processing language, provides a
thorough means to both introspect and define all DBMS entities using just
data processing operators, which is called the DBMS "catalog".  The catalog
is a set of system-defined relvars (relation-typed variables) which reflect
the definitions of DBMS entities; users can generally update these to
create, alter, or drop DBMS entities.  In fact, updating the catalog
relvars is the fundamental way to do data-definition tasks in Muldis D, and
any other provisions for data-definition are conceptually abstractions of
this.  Generally speaking, users can do absolutely everything in the DBMS
with just data querying and updating operations.  (Technically speaking,
any global-scope relvars are actually pseudo-variables which reflect
components of dbvars, the actual variables.)

The design and various features of Muldis D go a long way to help both its
users and implementers alike.  A lot of flexibility is afforded to
implementers of the language to be adaptive to changing constraints of
their environment and deliver efficient solutions.  This also makes things
a lot easier for users of the language because they can focus on the
meaning of their data rather than worrying about implementation details;
users can focus on defining what needs to be accomplished rather than how
to accomplish that, which relieves burdens on their creativity, and saves
them time.  In short, this system improves everyone's lives.

What users fundamentally write are Muldis D "routines", each consisting of
one or more "statements", and in executing these, all work is done.

A fundamental quality of Muldis D's design, unlike with most
general-purpose languages but like with SQL, is that applications written
in it are empowered to dynamically mutate their own source code at runtime
in arbitrarily large and complex ways.  This means that a single
application process / DBMS written in Muldis D can run completely
uninterrupted for months or years at a time (24x7x365), during which its
users/programmers are free to change or supplement its running source code
(permanently or temporarily) so that the application keeps up with their
evolving needs without going offline during an upgrade.  This is in
contrast with a typical programming language, where the whole process would
have to be quit and restarted for each code change, since its compile time
is wholly separate from its runtime.  But this is consistent with a typical
DBMS or SQL environment, that keeps its code in the database as stored
routines.  This always-on update-anything feature underlies some of the
design decisions of Muldis D, such as that users are able to create, store,
read values of ostensibly user-defined types where the definitions of said
types don't always exist, or use a database lacking a user-defined schema.

## Representation

Muldis D has multiple official representation formats, each of which is
referred to by this multi-part document as a I<dialect>.  Each official
Muldis D dialect has its own syntax rules, but all of them are capable of
representing the same code; that is, they can all represent code that has
the same behaviour, and Muldis D code can be translated between any 2 of
these dialects without changing its behaviour.

Some dialects maintain more non-critical explicit metadata than others, so
translating code from a dialect with more to a dialect with less will lose
explicit information, and translating the other way will require automatic
generation of that information, so round tripping code starting and ending
at the 'more' end will likely change it; however the changes won't be
behaviour-changing ones.  An example of non-critical metadata is the names
of intermediate values in multi-part value-determining expressions; some
dialects require you to explicitly name these intermediate values, and
others don't always have names for them at all.  Another example of
non-critical is code comments.  By contrast, some given pairs of dialects
maintain all of the same non-critical metadata, and simply have different
syntaxes; round-tripping code between these is guaranteed to result in
everything that was started with, non-criticals included.

Generally speaking, every Muldis D dialect belongs to one of just 2 groups,
which are I<non-hosted plain-text> and I<hosted data>; any Muldis D dialect
will go by the abstract names I<Plain Text Muldis D> (I<PTMD>), and
I<Hosted Data Muldis D> (I<HDMD>), respectively.  With all Plain Text
dialects, the Muldis D code is represented by an (ordered) string/sequence
of characters like with most normal programming languages.  With all Hosted
Data dialects, the Muldis D code is represented by collection-typed values
that are of some native type of some other programming language (eg, Perl)
which is the host of Muldis D.  The Muldis D code is written here by way of
writing code in the host language.

Some official Muldis D dialects have their specifications bundled with the
current multi-document: [Muldis_Data_Language_Dialect_PTMD_STD](Muldis_Data_Language_Dialect_PTMD_STD.md),
[Muldis_Data_Language_Dialect_HDMD_Raku_STD](Muldis_Data_Language_Dialect_HDMD_Raku_STD.md),
[Muldis_Data_Language_Dialect_HDMD_Perl_STD](Muldis_Data_Language_Dialect_HDMD_Perl_STD.md).  Other, unofficial Muldis D dialects
may be made by third parties in the future, but none are currently known.

The other parts of the current multi-document generally focus on the
behaviours and semantic features of Muldis D, rather than its syntax, and
what they describe is generally common to all Muldis D dialects.  The most
important of those parts are the current B<Basics> file and the
[Muldis_Data_Language_Core](Muldis_Data_Language_Core.md) file.

See also **SOURCE CODE METADATA** for more details on Muldis D's standard
support for non-critical Muldis D code metadata.

# TYPE SYSTEM

The Muldis D type system is a formal type system, at least in intent, and
works conceptually in the following manner.

There is a single universal value set/domain, named C<Universal>, whose
members are all the values that can possibly exist; C<Universal> is the
maximal data type of the entire type system.  Also there is a single
nullary value set/domain, named C<Empty>, which has zero members; C<Empty>
is the minimal data type.

All Muldis D data values as individuals are eternal and immutable.  All
values are logically distinct, and each value occurs exactly once, and is
not fixed within time or space (so doesn't have an "address").  It does not
make sense to say that you are creating or destroying or copying or
mutating a I<value>.  However, an eternal immutable value can make an
I<appearance> within a I<variable>, as a variable I<is> a named/addressable
container that is fixed within time and space, and it can be created,
destroyed, mutated, and multiple variables can hold appearances of the same
value.  So when one appears to be testing 2 values for equality, they are
actually testing whether 2 value appearances are in fact the same value.

Given that all data values in Muldis D are fundamentally immutable, the
term "selector" is used to describe a routine that captures an appearance
of a value into a variable (or for use in a value expression); this is
analogous to the task that a "constructor" routine does in a typical
object-oriented language, but that the former is conceptually "selecting"
an eternally existing value rather than conceptually "creating" a new one.

In the Muldis D type system, a I<data type> is a set of values, and as with
individual values, a data type is eternal and immutable.  Each data type
can also have type-specific metadata where what metadata is possible
depends on how the type is defined; an example of metadata is a default
value ordering algorithm.  Ignoring for a moment the existence of type
aliases, every data type is distinct from all other data types in that no 2
data types encompass exactly the same set of values.  Still ignoring type
aliases, every data type other than C<Universal> and C<Empty> has at least
1 member value, and at most 1 less value than the universal set.  If 2 data
types have no values in common, they are said to be I<disjoint>.

Given 2 arbitrary data types, I<T1> and I<T2>, I<T1> is called a
I<supertype> of I<T2> if its value set is a superset of that of I<T2>, and
in that situation, I<T2> is a I<subtype> of I<T1>, as its value set is a
subset of that of I<T1>.  Note that every type includes itself as its own
supertype and subtype, in which case, the I<T1> and I<T2> of the previous
example are the same type.  By contrast, if I<T1> and I<T2> are explicitly
different types but otherwise have that relationship, then I<T1> has at
least 1 value that I<T2> doesn't have, in which case I<T1> is also called a
I<proper supertype> of I<T2>, and I<T2> is also called a I<proper subtype>
of I<T1>.  Given those last examples, I<T1> is a I<more general> type, and
I<T2> is a I<more specific> type.  In this way, the system-defined
C<Universal> type is a proper supertype of all other types, and the
system-defined C<Empty> type is a proper subtype of all other types.  Now,
if no data type, I<T3> exists which is both a proper subtype of I<T1> and a
proper supertype of I<T2>, then I<T1> is an I<immediate supertype> of
I<T2>, and I<T2> is an I<immediate subtype> of I<T1>.  Note that the
Muldis D type system supports multiple inheritance, so types can form a
lattice rather than a tree.

Subtyping in Muldis D, as in any B<D> language, takes the form of
I<specialization by constraint>, not I<specialization by extension>.  So
conceptually speaking, a "circle" value is an "ellipse" value, but a
"coloured circle" is neither a "circle" value nor a "colour" value; the
type "circle" is a subtype of "ellipse", and "coloured circle" is neither a
subtype of "circle" nor of "colour".  Rather, for example, a "coloured
circle" is a multi-component type which has components of type "circle" and
"colour", but composition like this does not a subtype make.

However, Muldis D's I<mixin types> feature allows one to fake
I<specialization by extension>; it aids in code reuse between disjoint
types having common components, such as is a main benefit of
I<specialization by extension>; any 2 types that independently compose the
same mixin would not have values in common due to that common mixin.
I<Actually, the mixin types feature is only partially developed and doesn't
yet include attribute definitions; TODO: complete it so that it does.>

Every value conceptually has exactly one I<most specific type> (or I<MST>),
which is cited as the general answer to the question "what is this value's
type".  The MST of a value is the data type containing that value which has
no proper subtypes that also contain that value.  A value will conceptually
always implicitly assume the most specific type that exists which contains
it, even if a selector for a less specific type was explicitly used to
select it (although some use of explicit C<treated> may be required in code
to assist its compilation).  With a generic B<D> language, to enforce the
"exactly one" requirement, which keeps answering the question a simple
affair, it would be mandatory that when any 2 data types have values in
common, there must exist a data type which contains only the values that
they have in common, and hence is a subtype of both; the main intent of
that B<D> requirement is to support polymorphism where multiple distinct
operators that have the same name but different semantics can dispatch
correctly based on the MST of their operands.  However, in practice, such a
requirement would place a gratuitous large and error-prone burden on users,
if mandated universally.  Instead, Muldis D only enforces single MSTs in
the limited contexts where that is actually necessary, if any.

A I<union type> is a data type that has at least 2 immediate subtypes, and
every one of its values is also a value of an immediate subtype; that is,
the MST of every value in a union type is not that type.  An I<intersection
type> is a data type that has at least 2 immediate supertypes.  In this
way, C<Universal> is a union type of all other types, and C<Empty> is an
intersection type of all other types.

A I<difference type> is a data type that has exactly 1 immediate supertype,
and that supertype is a union type such that the difference type and
another peer subtype of that union type are complementary with respect to
the union type; every union type value is in either the difference type or
its complement, but not both.  An I<exclusion type> is like a I<union> type
except that it only consists of the values that are members of exactly an
odd number of its immediate subtypes.  A I<negation type> is a type that
consists of only the values that aren't members of a single other type; it
is like a difference type where the common supertype is C<Universal>.

Every data type is one of these 2 main kinds, depending on how the type is
defined: I<declaration type>, I<enumeration type>.  A declaration type
definition will just introduce new values into the type system while an
enumeration type will just reuse values that the type system already has.
Every declaration type is disjoint from every other declaration type, and
every value in the type system belongs to exactly one declaration type;
each value conceptually has metadata naming the declaration type that it
is a member of.  One quality of a declaration type is that a single
selector exists which can select all of the values of that type.  Generally
speaking, declaration types are the implementational foundation over which
all operators and all other types are built.

A declaration type can only be system-defined, not user-defined; users can
only define enumeration types.  A declaration type is either an atomic
type, which is conceptually opaque and not composed of other types, or a
nonatomic type, which is conceptually a composition of other types, either
atomic or nonatomic, along with an optional constraint that restricts
the values of the nonatomic data type to be a subset of the permutations of
possible element values.  An enumeration type is defined in terms of a
union or subset of the values of one or more other data types.  In the case
of a scalar subset enumeration type, typically it will define extra scalar
possreps or selectors.  There are just 2 declaration types: C<Int> and
C<List>; only C<Int> is an atomic type and only C<List> is a nonatomic
type.  All other system-defined types, and all user-defined types, are
enumeration types.  Some of the more significant system-defined enumeration
types are: C<Universal>, C<Empty>, C<Structure>, C<String>, C<Scalar>,
C<Tuple>, C<Relation>, C<External>, C<Bool>, C<Rat>, C<Text>, C<Blob>,
C<Set>, C<Maybe>, C<Array>, C<Bag>.

The fundamental reason for this design, where all values are introduced
into the type system by just system-defined types, is so that Muldis D can
support doing data definition plus data manipulation as a single atomic
operation.  This is because there is an effective way to represent and
interpret all Muldis D values in the complete absence of any user-defined
types, so there is no chicken-and-egg problem that prevents DD+DM from
being done together in the general case, where one needs to have
non-mutating definitions of user-defined types in order to do manipulation
of data having those types.

Another consequence of this design is that users actually don't ever have
to define any data types if they don't want to.  All empowering features of
Muldis D are provided just by the ability to make user-defined routines.
Generally speaking, the only primary purpose of having user-defined data
types is is to effectively provide constraints that restrict users from
doing things, and they are in no way necessary for enabling users to do
things.  This said, being restrictive is one of the primary reasons to use
a relational database, and types serve as a strong safeguard against users
doing bad things, particularly by accident, and any database intended to be
used in production should exploit user-defined types and constraints.  Also
user-defined types are very useful as metadata to explain the intended
interpretation of particular data and code working with it.

One might say that Muldis D is using I<progressive nominal typing>, where
values in databases move between structural and nominal typing as
user-defined types whose names match their declared types come in and out
of existence or mutate.

B<TODO: REWRITE THIS SINGLE PARAGRAPH:>  A data type that is an atomic or
structure or external type is also called a I<root type>; a data type that
is an enumeration is also called a I<nonroot type>.  A I<leaf type> is a
data type that has no proper subtypes save for C<Empty>.

Muldis D provides 2 generic polar-opposite methods to define an enumeration
type in terms of a union, and types defined in the 2 methods can be
referred to as I<domain types> or I<mixin types>, respectively.  With a
I<domain type>, it is the union type itself whose definition includes a
list of all the other types from which it draws its values, and those other
types generally don't know anything about the domain type.  With a I<mixin
type>, the union type doesn't know anything about what types it
draws its values from, and it is instead those other types whose
definitions explicitly name that their values are all included in the union
type, which they declare by explicitly I<composing> the mixin type.  Note
that, just as multiple domain types can take values from the same other
types, the same other type can compose multiple mixin types.  The primary
determinant for whether you would declare a union type using a domain type
or a mixin type is whether you want the union type's definition to be
closed, or open, respectively.  If you use a domain type, then assuming you
have control over all the types it unions (or they are system-defined), you
are fairly guaranteed that your union type will remain static and continue
to contain exactly the same values indefinitely, or in other words that the
type will continue to mean exactly what you intended no matter what anyone
else does with types outside your control.  If you use a mixin type, in
contrast, you are expressly empowering others to alter the meaning of that
type by adding new values to it from their own new types, and so your union
type is flexible to accommodate new uses automatically, at the cost that
you can't always assume when you ask for a value of that type that you'll
know in advance all the possible values you might get.  So, for example,
the system-defined C<Bool> type is a domain type, while the system-defined
C<Numeric> type is a mixin type.  A particularly important use of mixin
types is doing operator overloading between disjoint types,
which would be considerably more difficult without them.

## Type Identification

All values in the Muldis D type system are broadly categorized into 5
complementary sets called I<scalar values>, I<tuple values>, I<relation
values>, I<external values>, and I<nonstructure values>; tuple and relation
values are collectively known as I<nonscalar values>.  The type system has
the system-defined data types named C<Scalar>, C<Tuple>, C<Relation>,
C<External>, and C<Nonstructure>, which serve as maximal data types for
each category, respectively.  The 5 types are all mutually disjoint, and
C<Universal> is a union type over all of them.

Most data types each consist exclusively of values from
exactly one of the above 5 categories, and each such type does not
include values from several of them.  Therefore, every such data type is
said to be either a I<scalar type>, a I<tuple type>, a I<relation type>,
an I<external type>, or a I<nonstructure type>,
depending which category all of its values come from.  In similar fashion,
a I<nonscalar type> is frequently any type that is not a scalar type,
meaning it is either a tuple type or a relation type.

A I<remnant type> is any type having at least 2 values, but that lacks at
least one value of C<Universal>, where at least 2 of
the values it has are not in the same one of the 5 categories.  The remnant
category is the complement category to all the others in that every
possible proper subset of the values of C<Universal> can now be represented
by a type that fits in one of the 6 categories, save C<Empty> itself.

The most important values of the Muldis D type system (because those are
the only ones that can be stored in a I<database>) are broadly categorized
into 3 complementary sets called I<deeply homogeneous scalar values>,
I<deeply homogeneous tuple values>, and I<deeply homogeneous relation
values>; deeply homogeneous tuple and deeply homogeneous relation values
are collectively known as I<deeply homogeneous nonscalar values>.  The type
system has the system-defined data types named C<DHScalar>, C<DHTuple>, and
C<DHRelation>, which serve as maximal data types for each category,
respectively.  Each of these 3 types is a proper subtype of the previously
mentioned type whose name is the same but for lacking a 'DH' prefix.  The
most important data types each consist exclusively of values from exactly
one of the most important 3 categories, and every such data type is said to
be either a I<deeply homogeneous scalar type>, a I<deeply homogeneous tuple
type>, or a I<deeply homogeneous relation type>, depending which category
all of its values come from.  In similar fashion, a I<deeply homogeneous
nonscalar type> is generally any deeply homogeneous type that is not a
deeply homogeneous scalar type, if we ignored non-deeply-homogeneous types,
meaning it is either a deeply homogeneous tuple type or a deeply
homogeneous relation type.  This said, the definition of a deeply
homogeneous tuple|relation type is restricted further than just being a set
of deeply homogeneous tuple|relation values, and so C<DHTuple> and
C<DHRelation> aren't actually deeply homogeneous types (they are both
non-deeply-homogeneous types); see **Distinction of Non-Homogeneous Types
from Homogeneous Types** for more details.

The identity of every scalar type is defined by its name alone, and every
scalar type must have a distinct name that is explicitly defined, either
by the system or by the user as is applicable.  Every value of a scalar
type is conceptually opaque and atomic, and its components are not known to
users of that type; but even when the components are known (because they
are user-defined structured types), two independently defined scalar
types are completely disjoint even if their components look the same, by
definition.  The only way for 2 scalar types to have values in common is
if one is explicitly defined, directly or indirectly, as a subtype of, or
as a union type encompassing a subtype of, the other.

Every value of a nonscalar type (either a tuple type I<or> a relation
type, respectively) is conceptually transparent, and its component
structure is known to all.  The identity of every nonscalar type is
defined by its component structure alone, and every nonscalar type must
have a distinct component structure.  Any two nonscalar types that have
the same component structure are in fact the same type, by definition,
regardless of whether they were defined independently of each other or not.

A remnant type is always defined in terms of one or more other types, and
it can never be a root type with defined components.  The identity of every
remnant type is defined only in terms of it being, directly or indirectly,
a union or negation of other non-remnant types.  As per with nonscalars,
several independently defined remnant types can be considered the same one.

To keep things simpler, every data type in Muldis D has a name by which it
is referenced, even nonscalar types; however, the names of types that are
not scalar types are simply convenient aliases for their true identities,
which are their structures (the convenience allows various Muldis D catalog
features to be designed and implemented more easily).

An external type is a special opaque type.
A value of an external type can not be stored in a database and
it only is ever stored in routine lexical variables or arguments.  The
use purpose is provided by Muldis D's special C<External>
type, the values of which will represent any arbitrary values of any
arbitrary, often user-defined and mutable, types of a peer or host language
to Muldis D in the context of a common program.  Each C<External> value is
a black box to Muldis D code, which other parts of a wider program can give
to Muldis D routines to manage, such as store in a relation value for
organization and processing with relational operators.  The mutual identity
of C<External> values is implementation-defined, and by default each one is
conceptually a memory address meaningful to the external language.  But
regardless, C<External> values are disjoint from all native Muldis D
values, so their proprietary identity schemes have no bearing on natives.

## Scalar Types

Scalar types are the only conceptually (non-external) encapsulated types
in Muldis D, and are like other languages' concepts of object classes where
all their attributes are private, and only accessible indirectly.  The
definition of a scalar type comprises usually one or more named
I<possreps> or I<possible representations>, and for each of those, at least
one I<selector> operator and usually at least one I<accessor> or I<the>
operator.

A I<possrep> of a type is an exhaustively complete means for users to
conceptualize the structure of the type; it is like a "role" or "interface"
definition.  A possrep has the appearance of a complete collection of (zero
or more) named object attributes (of any scalar or nonscalar type) that
the type could logically be implemented as, and users can use it as if it
actually was implemented that way, but without the requirement that the
type actually is implemented that way.  If a type has multiple possreps,
said possreps can differ from each other in arbitrarily large ways, but
every one is individually capable of representing all of the type's values;
any possrep could be used exclusively by a user when they work with its
type, without diminishing what they can do.  A single possrep is specific
to one and only one type.

Taking for example a conceptual integer data type, one of its possreps
could represent an integer value as a string of binary digits, while
another possrep could represent an integer value as a string of decimal
digits.  Or taking for example a conceptual temporal data type, one of its
possreps could represent a date as an ISO 8601 formatted character string
in the Gregorian calendar, and another possrep could represent it as a
number of seconds since the UNIX epoch.  Or taking for example a spatial
data type that is a rectangle, one possrep could specify the 4 vertices as
4 (or 3) point values, and another possrep could specify 2 vertices and
also specify the rectangle's width and height as numeric values.

A possrep additionally has a defined boolean-valued constraint expression
(which is simply I<true> in the trivial case), that restricts what values
the possrep components can have within the context of their fellows.
Taking for example a "medium polygon" data type, there could be a
constraint that the area of the polygon is between 5 and 10 units.

Generic system-defined selector and possrep attribute accessor operators
exist that automatically work with all scalar types (that have possreps,
which all scalar root types except C<Int> and C<String> do), so such do not
need to be explicitly defined per such type.  They are all in the
C<sys.std.Core.Scalar.\w+> namespace.  These generic operators take
advantage of the fact that each scalar possrep looks like a tuple, and
they look like basic tuple operators but for taking an extra argument to
say which possrep we're dealing with, and possibly a second extra attribute
to say what type, in the case of the generic scalar value selector.

No data type has any operators built-in to its definition except for
certain implicitly system-defined operators that are automatically
generated from their structure/etc definitions, such as the aforementioned
implicitly system-defined selectors and accessors (or certain other
explicitly defined operators whose public interfaces are still implicitly
system-defined).  All other operators that are used with a data type are
expressly I<not> built-in to the type (even if they are system-defined);
the other operators do not have any access to the data type's internals,
and must be defined (directly or indirectly) in terms of (that is, layered
on top of) the few that are built-in, though the built-ins from any or all
possreps of the type can be utilized.

With a user-defined scalar type, if the type has multiple possreps, then
each distinct pair of possreps for the type has a mapping function plus its
inverse function defined, permitting every value of the type which is first
expressed using one possrep to be translated for expression in the other.
The entire complement of possreps of a type must be linked together by
explicit mapping functions, but not every pair has to be; if the possreps
are arranged as nodes on a directed graph, with an explicit mapping
function being a side, there just needs to be a path from every possrep to
every other one; every path then has at least an implicit mapping function.

The Muldis D implementation can choose for itself as to how the scalar
type is physically represented behind the scenes, either picking between
any of the user-provided possreps or using yet another one or several of
its own; the implementation can work how it knows best to achieve an
efficient system, and this is all hidden away from the users, who simply
perceive in it what they requested.

In the context of scalar subtype/supertype relationships, the definition
of a subtype can add additional possreps that are only valid for the
subtype, such that users of the subtype can use both possreps defined for
the subtype and the supertype, but users of the supertype can only use the
possreps for the supertype, and not the subtype.  Taking for example the
data types of rectangle and square, the latter is a subtype of the former;
a possrep for a rectangle in general comprises its center point as well as
its width and its height, which also works for a square; an additional
possrep that just works for a square rather than a rectangle in general
comprises a center point plus its length.

As a corollary to this, all union types have none of the possreps defined
by their proper subtypes.  So the system-defined C<Scalar> type has no
possreps at all, and hence has no selectors or accessors defined for it.

Note that, to keep things simple and deterministic under the possibility of
diamond subtype/supertype relationships (such that the generic
system-defined scalar possrep attribute accessors can work), Muldis D
requires all of the possreps of all scalar types having a common scalar
root type to have mutually distinct names, regardless of whether any
subtypes have values in common; this can be enforced at
type-definition-in-catalog time since all types that can interact are in
the same depot.

Note that, if a scalar root type's possreps' attributes are all just deeply
homogeneous typed, or there aren't any possrep attributes, then that root
type is a deeply homogeneous scalar type, and any subtype of this is
forbidden from declaring any possreps having attributes that are not of
deeply homogeneous types.

## Tuple Types and Relation Types

Tuple types are the fundamental heterogeneous conceptually
non-encapsulated collection types in Muldis D, and are like the Pascal
language's concept of a record, or the C language's concept of a struct.
The definition of a tuple type comprises a set of zero or more named
I<attributes> of any scalar or nonscalar type.  This set definition is
called the tuple's I<heading>, and the count of attributes is called the
tuple's I<degree>.

Relation types are the fundamental homogeneous conceptually
non-encapsulated collection types in Muldis D, and are like other
languages' concepts of sets (or arrays where all elements are distinct),
but restricted in that all elements are tuples (whose degrees and attribute
names are identical); the count of tuples in a relation is called the
relation's I<cardinality>.  The definition of a relation type looks exactly
like the definition of a tuple type (such that a relation has attributes
even if it has no tuples), but that the definition defines every tuple in
the relation, and also but that relation types can additionally have
I<keys> defined which indicate that a subset of its attributes' values are
distinct between all tuples in the relation.

Generic system-defined selector and accessor operators exist that
automatically work with all tuple and relation types, so they do not
need to be defined per such type.

The system-defined types C<Tuple> and C<Relation> (and their
system-defined subtypes) are technically generic factory types, such that
they themselves do not define any attribute sets, and are supertypes of all
tuple and relation types that do.

A pair of tuple or relation types can only have a subtype/supertype
relationship if they have compatible headings, which means the attribute
sets are of the same degree, the attribute names are identical, and the
name-wise corresponding attributes in each heading have a valid
subtype/supertype relationship; each attribute of a tuple or relation
subtype is a subtype of the same-named attribute of the tuple or relation
supertype.  I<TODO:  Update this as you can have sub/super in other ways.>

The explicit heading of a tuple or relation value only defines the
names of its attributes, not their types; the types of tuple or
relation attributes are simply derived from the values of those
attributes, specifically their MSTs, recursively in the case of TVAs and
RVAs.  Declared tuple or relation attribute types are only applicable
to explicit tuple or relation type definitions, and the variables or
routine parameters etc that compose them.

The most specific type (MST) of a tuple value is determined by the MSTs
of all of its attributes' values; what the heading of that tuple says for
each of its attributes is that its data type is the MST of the value of
that attribute in the tuple's body.

The MST of a relation value is similarly based on the attribute values in
its member tuples; for each relation attribute, its MST is the most
specific common supertype of the MSTs of the tuple values for that
attribute.  If a relation value has zero tuples, then the MST of every
one of its attributes is simply C<Empty>, regardless of whether that
attribute would otherwise be scalar or tuple or relation valued.  A
consequence of this is that 2 relation values with zero tuples are
always identical if just their degree and the names of their attributes
match, and regardless of the declared types of the attributes.  A corollary
to this is that if the declared type of an attribute of a relation type
is C<Empty>, then that type can only consist of exactly 1 value, which is
the zero-tuple relation having those attribute names (and their types are
all C<Empty>).

Declaring a type in terms of a typed attribute list has different effects
for scalar and tuple types versus relation types when an attribute of said
is given the type C<Empty>.  While for a relation type this means that the
type has exactly 1 value, for a scalar or tuple type this means that the
type has exactly zero values, and so the latter is in fact an alias for
C<Empty> itself, since no tuple value can lack a value for an attribute and
no scalar value can lack a value for a possrep attribute.

A consequence of these identity matters is that a Muldis D implementation
can choose to keep all the actual type information of a nonscalar value's
attributes in the body, leaving the heading to keep nothing but the names
of the attributes.  An empty relation body does not mean that any
important metadata is lost.

## Distinction of Non-Homogeneous Types from Homogeneous Types

A relation value can have any combination of values of C<Universal> as the
values of the same attribute across its constituent tuples.  All generic
relational operators will work with every relation value except for
C<unwrap> and C<ungroup> (or other operators defined over them), which will
only work with a subset of relation values.

You can only unwrap a host relation's attribute into an extension of that
host if for every tuple of the host, that attribute is a tuple with the
same degree and attribute names, or otherwise there is no consistent set of
attribute names to extend the host with.  Likewise, you can only ungroup a
host relation's attribute if for every tuple of the host, that attribute is
a relation with the same degree and attribute names.

A I<deeply homogeneous relation value> is, by definition, any host relation
value for which you can take any of the host's attributes that is not
deeply homogeneous scalar, and validly either unwrap or ungroup that
attribute, recursively, until your host relation has just deeply
homogeneous scalar-valued attributes.

A I<deeply homogeneous tuple value> is, by definition, any tuple value such
that any relation-valued attributes it has, directly or indirectly, are
also just deeply homogeneous relation-valued.

As trivial cases, all 3 of the nonscalar values with zero attributes are
just deeply homogeneous nonscalar values, and all relation values with zero
tuples are just deeply homogeneous relation values.  (Hence the
system-defined nonscalar values with additional special names, which are
C<D0>, C<D0C[0|1]>, and C<Nothing>, don't each come in 2 flavors.)

A I<deeply homogeneous scalar value> is, by definition, any scalar value
that either has no possreps (it is an C<Int> or a C<String>) or all of its
possreps are
such that any relation-valued attributes it has, directly or indirectly,
are also just deeply homogeneous relation-valued.

The above deeply homogeneous value definitions further assume that every
deeply homogeneous relation or tuple or scalar possrep attribute is a
scalar or tuple or relation value; in particular, no such attribute is
allowed to be either an external or a nonstructure value.

A I<deeply homogeneous relation type> is, by definition, any type
consisting of just deeply homogeneous relation values, such that if the
declared type of a unary relation attribute was that deeply homogeneous
relation type, then every value of said unary relation would also be just a
deeply homogeneous relation.  Likewise, a tuple type is a I<deeply
homogeneous tuple type> if said unary relation could have said deeply
homogeneous tuple type as its attribute's declared type and be a deeply
homogeneous relation type.  A I<deeply homogeneous scalar type> is a
I<scalar type> whose values are all deeply homogeneous scalar values.

And so, the 10 system-defined enumeration types [C<DHTuple>, C<Database>,
C<DHRelation>, C<DHSet>, C<DHMaybe>, C<DHJust>, C<DHArray>, C<DHBag>,
C<DH[S|M]PInterval>] are
actually not deeply homogeneous nonscalar types like their namesakes at
all, but they are all nonscalar types; no deeply homogeneous types could
use those as declared types of any attributes.

The distinction between deeply homogeneous types and other types is very
important to make.  Muldis D only permits a I<database> typed variable,
which are the only kinds of variables that can be global and persist, to
consist of deeply homogeneous relations and deeply homogeneous tuples and
deeply homogeneous scalars.

The other types are just intended for use with fringe kinds of transient
data in lexical variables or to pass to routine parameters or return from
functions, which is where they are expected to be useful; but even there,
it is not expected that you would need to use non-deeply-homogeneous types
very often; Muldis D is designed such that you generally need just the
deeply homogeneous types to do anything important.

The non-deeply-homogeneous types serve partly as a convenience for
programmers integrating Muldis D with another host language, and want
Muldis D to work with their transients more like the host language itself
does, for example to hold a "relation of anything to anything" or a "list
of anything" in memory.  Or likewise, to help programmers more easily
emulate another arbitrary language in Muldis D.

As an exception to the general rule of nothing important needing
non-deeply-homogeneous nonscalar types, the definition of Muldis D's
relational join and cross-product operators require a relation main
argument because they are N-adic operators and N-adic Muldis D operators
take a conceptual multiplicity of arguments as a single collection
argument, and the conceptual arguments to relational join usually have
different headings, and so this single actual argument can't be just a
deeply homogeneous relation in the general case (if it was, then the join
will happen to be the special case that is a relational intersection).  But
this exception is just an artifact of Muldis D having exclusively named
parameters plus N-adic by default where possible, and the actual join
operation is still relational model abiding.

Sometimes this documentation may use the term I<complete type> or
I<incomplete type> to refer to a nonscalar type; every complete type has
its full list of attributes defined, and every incomplete type (or
I<parameterized type>) doesn't.  Most system-defined nonscalar types are
complete; the only ones that aren't are the various maximal types
C<[|DH][Tuple|Relation]> and C<Database>, and none of those define any
attributes at all.  (All nonscalar values have a full list of attributes
defined, of course.)

## Finite Types and Infinite Types

A I<finite type> is a data type whose cardinality (count of member values)
is known to be finite, and this cardinality can be deterministically
computed; moreover, every value of a finite type can be represented somehow
using a finite amount of memory.  This doesn't exclude the possibility that
either the cardinality or individual values are larger than present-day
computing hardware can handle, but even if so, they could be handled by
sufficiently larger but finite resources.  An I<infinite type> is a data
type that is not a finite type; its cardinality is either known to be
infinity, or it is unknown.

Generally speaking, all finite types are defined either as an explicit
enumeration of values (for example, the boolean type, which has exactly 2
values), or they are scalar types whose possreps have zero attributes (each
one is a singleton, having exactly 1 value), or they are the tuple or
relation type that has zero attributes (which has exactly 1 or 2 values,
respectively), or their values are all discrete and fall into a closed
range (for example, a type comprising the range of integers between 1 and
100, or a type comprising all real numbers in the same range that have a
granularity of 0.001, or any IEEE floating point number of a specific bit
length), or their values are length-constrained strings of
finite-cardinality elements (for example, a character string that is not
longer than 250 characters), or they are composite scalar or nonscalar
types whose attributes are all of finite types themselves (for example, a
type whose attributes are all C<Bool>).

Generally speaking, all infinite types are defined either as being some
open-ended natural domain (for example, the type having all integers, or
the type having all prime numbers), or they are some continuous domain,
whether open-ended or not (for example, the type having all real or complex
numbers between 1 and 100), or they are non-length-constrained strings (for
example, the set of all possible text strings), or they are composite
scalar or nonscalar types which have at least one attribute which is
itself infinite (for example, a type that has an C<Int> attribute).

The system-defined root type C<Bool> is finite (2 values), as is the
C<Empty> type (zero values), while all of the other important
system-defined root types (C<Int>, C<Rat>, C<Blob>, C<Text>,
C<Tuple>, C<Relation>, etc) are infinite, as are
the C<Universal>, C<Scalar>, C<External> types.

All proper subtypes of finite types are themselves finite types.  Proper
subtypes of infinite types can be either finite or infinite depending on
how they are defined.  For example, a subtype of C<Int> whose numbers are
all simply greater than 10 is infinite, but a subtype whose numbers are
additionally all less than 1000 is finite.  I<The documentation for
individual system-defined data types specifies whether each of which is
finite or infinite, and in the latter case, it states a most generic means
to specify a finite subtype.>

Note that, while it is not mandated by the language, some Muldis D
implementations may legitimately choose to impose restrictions on their
users such that the declared types of all persisting variables must be of
finite types only.

For example that all persisting C<Text> types must have a maximum allowed
length in characters specified, or that all persisting C<Int> types must
have a least and greatest allowed value specified.  This would typically
happen if the implementation needs to use fixed-size fields internally,
such as 32-bit integers, and it is not practical to support the possibility
that a value could be of any size at all (this is often the case with SQL
databases implemented in C).

On the other hand, some implementations may natively support unlimited size
values, such as those written in Perl, and so these can allow persisting
the plain C<Text> or C<Int> types, which can make things less complicated
for their users.

Of course, even with implementations that require finite types, this isn't
to say that the declared type can't be a very large finite type, but then
the implementation can choose to use, for example, either a machine native
integer or a string of digits behind the scenes for all values of the type,
and can do this deterministically, depending what constraint the type
defining user chose.

## Universal Implicit Operators

Muldis D is universally polymorphic to at least a small degree, such that
every data type without exception has both an C<assign> update operator
(for assigning a value of that type to a variable of that type) and an
C<is_same> function for testing that 2 values of that type are identical or
equal or substitutable (and C<is_not_same>, for the opposite).  Moreover,
these operators exist implicitly, so when one defines the initial possrep
of a new type, they get those operators for the type at no extra cost.

But really, the only kind of polymorphism that Muldis D has is related to
subtypes inheriting the operators of their supertypes.  Besides this, all
Muldis D operators have different fully-qualified names from each other, so
there isn't a case of incompatible operators having the same names, which
then must be differentiated by their argument types.  So in that respect,
maybe Muldis D isn't so polymorphic after all, depending on whether the
latter behaviour would be needed to call a language I<polymorphic>.

## Numeric Types

Conceptually speaking, Muldis D has just a single most-important numeric
data type, which consists of every possible real rational number.  This
data type is a "bignum", and will exactly represent a rational number with
any arbitrary magnitude and precision, limited only by the amount of
available system memory.  This type does not include multiple zeros, nor
any special non-numeric values such as NaNs, infinities, over|underflows,
nor any symbolic irrationals or complex/imaginary numbers etc; any core
language operation that might have produced such will either fail or
(explicitly) round to a nearby rational as is applicable.

This numeric type is exact, not approximate, and every figure
(bit|digit|etc) is significant; no 2 distinct values will ever compare as
equal as there is never any implicit rounding; there is no tracking of
significant figures, and there is no fuzzy logic.  Every one of this type's
member values can be described in terms of 3 integers; the value is the
result of multiplying a I<mantissa> (any integer) by the result of a
I<radix> (any integer greater than one) raised to the power of an
I<exponent> (any integer).  Or alternately, every value can be described
using 2 integers; the value is the result of dividing a I<numerator> by a
I<denominator>.  This numeric type is truly radix-independent; although it
is most common for the radix to be 2 or 10, any other radix can be used
instead, such as to represent the value four-thirds exactly.

If you want to represent any numeric or numeric-related value in Muldis D
other than the aforementioned core-supported ones, you will need to do it
with some less-important non-core language type, either some system-defined
extension or some user-defined type.  For example, if you want division by
zero to produce a special infinity value rather than fail / throw an
exception, you'll need a non-core type.  Or likewise if you want your math
to process approximate/measured numbers with proper significant figure
handling.

On the other hand, if you want to have something that's just like either a
traditional 32-bit integer or 64-bit IEEE-754 float sans special values,
you can have that as a simple proper subtype of the most-important numeric
type.

Now, the Muldis D language actually has 2 most-important numeric data types
which are disjoint, C<Int> and C<Rat>, both of which are in the language
core.  The second one is equal to the conceptual single numeric type as to
what numeric values it can represent; the first one by contrast is
conceptually a proper subtype which just contains all the integers, that is
the values where the conceptual I<exponent> is zero (or I<denominator> is
1) and so the I<mantissa> (or I<numerator>) by itself is the value.  The
reason that Muldis D has these 2 types disjoint is to assist ease of use
and implementation; moreover, C<Int> is conceptually a lot simpler, and
C<Rat> is conceptually defined in terms of C<Int>.  And C<Rat> isn't needed
for bootstrapping a minimal Muldis D implementation or the system catalog,
whereas C<Int> is.  I<Note: The latter, system catalog, will no longer be
the case if the system catalog definition expands to include time-stamps.>

## Ordered Types

Data types in Muldis D are fundamentally unordered sets of values, and so
in the general case, it does not make sense to use them in a context that
requires some conception of values being mutually ordered.  However,
potentially any type can externally have ordering algorithms (as defined by
functions) applied to it in particular contexts, and so fake the type being
ordered, in either one or multiple ways.  Moreover, many of the common use
cases here have system-defined functionality to support them.

To maximize code reuse and polymorphism in Muldis D, you should only need
to define a single order-determination function per data type whose values
you want to sort, in the general case.  If such a function is declared in
the appropriate format and in the appropriate place, then the multiplicity
of system-defined type-generic order-sensitive operators should be able to
wrap this function and work with the data type.

Examples of generic order-sensitive operators include tests of the relative
order of 2 values, tests of whether a value is inside or outside of the
range between 2 other values, querying the minimum or maximum value from a
set of values, ranking a set of values based on their relative order, or
sorting a set of values into a sequence that reflects such a ranking.

A system-compatible fundamental order-determination function (fulfilled by
the routine kind C<order-determination>) must have at least 3 parameters,
where those 3 are named [C<topic>, C<other>, C<is_reverse_order>], where
the declared types of the two main parameters C<topic> and C<other> are the
same as the type whose values the function is to determine the order of,
and it would be invoked with 2 of those values as its arguments; the result
type of the function is an C<Order>.  Any additional parameters besides the
above-named 3 are hereby collectively
referred to as I<misc params>.  This function by default results in
C<Order:Same> iff its 2 arguments are exactly the same value, and otherwise
it results in C<Order:Less> if the value of the C<other> argument is
considered to be an increase (as defined by the function's algorithm) over
the value of the C<topic> argument, and otherwise it results in
C<Order:More> as the reverse of the last condition would be true.  The
function's I<misc params> carry
optional customization details for the algorithm; this permits the function
to implement a choice between multiple (typically similar) ordering
algorithms rather than just one, which reduces the number of functions
needed for supporting that choice; if the algorithm is not customizable,
then there are no I<misc params>.  The function's third
parameter, C<is_reverse_order>, is C<Bool>-typed; a C<Bool:False> argument
means the function's algorithm operates as normal when given any particular
other arguments (meaning a sorting operation based on it will place
elements in ascending order), while a C<Bool:True> argument means the
function's algorithm operates in reverse, so the function results in the
reverse C<Order> value it would have otherwise when given the same other
arguments (meaning a sorting operation based on it will place elements in
descending order).  The function's C<topic> and C<other> parameters always
require arguments, the C<is_reverse_order> parameter always doesn't require
an argument and defaults to C<Bool:False>.

In the general case, any context which wants to use a system-defined
type-generic order-sensitive operator will specify the fully-qualified name
of a system-compatible fundamental order-determination function to
implement it over, by supplying the name of the latter function as an
additional argument to the former.  However, as an option allowed for
scalar root types, a default fundamental order-determination function can
be included as part of the definition of that type, which is automatically
applied when using values of that type with versions of order-sensitive
operators that don't have the additional function-name-specifying
parameter.  All ordered system-defined scalar root types have this
type-default ordering function defined for them, especially the
system-defined C<Int> type which is opaque, so you don't
need to define any yourself for these most-common cases.  Note that a
nonscalar type can't have a default ordering function, and a subtype of a
scalar type can't supply or replace one either, with the reasoning for
this that any resulting behaviour from supporting such would be difficult
to predict and easily introduce bugs, due for example to "action at a
distance" or knowing what function applies to what values by default in the
case of subtyping; by contrast, it is easy to predict behaviour when a
type-default sorting function is attached to a scalar root type.

Note that, for the present at least, a system-compatible fundamental
order-determination function may only be totally ordered; that is, no 2
distinct values of a type it is applied to may compare as C<Same>.  In the
future, Muldis D may have privileged support for partial ordering
functions, which when applied to sort a set of values would result in a
sequence of sets of compares-as-same values, rather than a straight
sequence of values.  But in the meantime you can make a non-privileged
partial sort function by combining a set folding function with a totally
ordered order-determination function, and a relational group if applicable.

## Type Safety

Muldis D should qualify as a I<type-safe> language by many, if not all,
definitions of the term I<type-safe>.

The Muldis D type system is used to prevent certain erroneous or
undesirable program behaviour.  Type errors are usually those that result
from attempts to perform an operation on some values, that is not
appropriate to their data types; or any contravention of the programmer's
intent (as communicated via typing annotations) are erroneous and to be
prevented by the system.

Every value is of a type.  Every literal, expression, function result,
routine parameter, type component, and variable has a declared type; the
system ensures that a variable will only ever hold a value of its declared
type, that a routine parameter will only take an argument of its declared
type, and a function will only ever result in a value of its declared type.
There are no implicit type conversions, only explicit type mapping.  For
example, it is invalid for a numeric value to appear where a character
string value is expected, or vice-versa, but an expression or function that
explicitly maps a numeric to a string is valid to use there.  Muldis D
follows the I<principle of cautious design>.

Muldis D is a hybrid dynamic and static language, and where on the spectrum
it is varies by implementation.  At the very least, all imminent type
errors would be prevented by the system at run time.  But the more
potential type errors are caught at compile time, the better for users.

Fundamentally, Muldis D is a dynamic language, associating type information
with values at run time and consulting them as needed to detect imminent
errors; the system prevents run time imminent type errors by throwing an
exception.  However, it is possible in many cases for Muldis D to be
treated as a static language, where type errors are found and prevented at
compile time, such that the compilation process throws an exception.
Ideally, all type errors would be found at compile time, and more
intelligent compilers will be closer to that goal, but in the general case
it is not possible to go all the way.  In order to increase type error
detection at compile time, a wider scope needs to be analysed than
otherwise; in practice, the widest practical scope is to analyse the entire
I<depot> that would contain the code being compiled.

By design, all Muldis D user-defined variables and routines must live in
the same depot as all the user-defined types (and constraints) they are
defined in terms of, and the same depot as all the functions that they
invoke.  Only procedures may invoke things in depots other than their own,
and only procedures may be what is thusly invoked.  Both
depots would have their own copies of data types and constraints of the
invoked procedure's parameters.  So it is in fact possible for an
entire depot to be proven internally free of type errors at the time of
compilation for any entity living within it.  As for inter-depot type
checking, that could be done at depot mount time.

But that is assuming no Muldis D code in a depot will update its own system
catalog, in which case that assumption can be thrown out the window.  While
a depot's code doesn't have to update its own system catalog, because all
such updates could typically be done either in advance
or later on by other utility depots' code, it is a fundamental Muldis
D feature that code in a depot can update its own system catalog.  A
depot's system catalog update constitutes recompiling the then-changed code
in that depot, and so what types and routines and variables exist would
have changed.  It is valid for a Muldis D procedure to define a new type or
routine in one statement, and then invoke it in the next; that is how the
Muldis D analogy of SQL's "prepared statements" works.  I<Note
that this whole matter may be subject to revisiting, such that Muldis D
code can never update the system catalog of its own depot to alter types or
routines or variables; but other system catalog updates such as affecting
database user privileges in the same depot may be retained.>

Now, the Muldis D language spec is currently somewhat hazy in respect to
how declared types are enforced as constraints with respect to generic
operators, and the spec currently doesn't fully formalize behaviour for
implementations in some regards, or different parts may seem to contradict
each other.  These details still need to be worked out, and in the
mean-time, following are some pointers.

Generally speaking, there are two categories of type errors.  The first is
where the system simply can't function in a reasonable or deterministic
manner if they are violated; this is the kind that must always be detected
and prevented by the system.  The second is where the type error is more
just an error concerning the programmer's intent, and this is not fatal by
any means; the system will still produce a reasonable and deterministic
result if those were not treated as errors and be allowed to resume.  An
example of the first is divide by zero with the system standard integer and
rational types.  An example of the second is an identity/equality
comparison between 2 values from variables of different declared types; it
is valid to compare an integer to a character string for equality; the
result would always be false, but it is still logical; however the user
might want the system to detect such occurrences.

Therefore, Muldis D officially defines for now that the latter category is
not fatal and would just generate a warning by default.  Warnings can be
either enabled as warnings, disabled to not display, or be promoted to
fatal errors automatically, using a compile-time option or lexically scoped
pragma or something.

All warnings are issued at compile-time only, which includes any time when
a system catalog is being updated.

Generally speaking, a Muldis D implementation can not expect at run time to
remember matters related to declared types of contexts that values are
coming from.  Rather, only the most specific type of the value itself can
be known or computable at runtime in order to enforce say the constraint
from the declared type of a variable it is being assigned to.  However, the
declared type of a variable used as an argument to a subject-to-update
parameter I<would> be known at runtime, if it is more specific than the
declared type of the parameter.

The declared type of an operator argument's source generally can not be
seen or used by a logical decision in the routine, so for example, if a
generic operator is going to return the default value of its argument's
declared type and not the default value of its corresponding parameter's
declared type, then this can't be done.  What must happen is for the
operator to take an extra argument where the name of the type whose default
we want is spelled out, or alternately just the default value itself.

## Low Level Type System

At the lowest, most primitive levels of Muldis D, everything is integers or
sequences of integers; data types in general are just abstractions of this.

The fundamental Muldis D type system has 3 compositional abstraction
levels, which are, from lowest to highest: I<atomic value>,
I<nonnamed-element collection>, I<named-element collection>.

An I<atomic value> is named in accordance with the original meaning of
I<atom>, which is I<indivisible>; an I<atomic value> is not conceptually a
collection of any kind, but rather is conceptually opaque.  Muldis D has
exactly 1 atomic value type, which is C<Int>.  An C<Int> is a single exact
integral number of any magnitude; while it can be unbounded in size, by far
most of the C<Int> values actually used are quite small, and would fit in a
single hardware CPU register in their entirety.  Two C<Int> are considered
identical iff they both represent the same integer.

A I<nonnamed-element collection> is conceptually a transparent sequence of
0..N elements where each element is either an I<atomic value> or a
I<nonnamed-element collection>.  Muldis D has exactly 1 nonnamed-element
collection type, which is C<List>.  A C<List> is a transparent dense
sequence of 0..N elements where each element is identified by ordinal
position and the first element has position zero, and where each element is
either an C<Int> or a C<List>; in the general case, this can be an
arbitrarily complex hierarchical structure of unlimited size, where the
leaves of this hierarchy are each C<Int>.  C<Int> and C<List> are mutually
disjoint and complementary proper subtypes of C<Universal>; the latter has
no values that are not each of one of the first 2 types.

A I<named-element collection> is conceptually a collection of 0..N elements
where each element is identified by a name rather than by an ordinal
position.  Muldis D has 6 primary named-element collection types, which are
C<Structure>, C<String>, C<Tuple>, C<Relation>, C<ScalarWP>, C<External>.
C<Structure> is a proper subtype of C<List> consisting of every C<List>
value that matches one of 5 specific formats; each of those formats is
represented by exactly one of 5 mutually disjoint proper subtypes of
C<Structure>, which are the other 5 of the 6; C<Structure> is a union type
over all 5 of those types, and C<Structure> has no values which are not
each of one of those 5 types.  A C<Structure> is a C<List> having at least
2 elements, where the first element is designated the I<structure kind> and
indicates how to interpret the remainder of the C<Structure> elements; the
I<structure kind> is an C<Int>; all of the remaining elements are
collectively called the I<payload elements>.

This table says which I<structure kind> values indicate which of the 5
types:

    1 | String
    2 | Tuple
    3 | Relation
    4 | ScalarWP
    5 | External

Rules for determining whether two C<List> are identical are defined
separately per each of the 5 C<Structure> subtypes; but two C<List> are
certainly not identical when they are of 2 different types of the 5, or one
is a C<Structure> and the other is not.  As an exception to the
defined-separately situation, if a simple comparison of two values simply
as a C<List>-hierarchy of C<Int> determines them to be identical, then this
is the result; a defined-separately is only allowed to differ when the
simple comparison determines them to be non-identical.

A C<String> is a C<Structure> having exactly 1 payload element that is
designated I<elements>.  The I<elements> is a C<List> of 0..N C<Int> where
the intended interpretation of I<elements> is provided by the element
repertoire of the larger context in which the C<String> exists.
For example, if a C<String> is the primary component of a bit/octet string
type, then each string element is interpreted as a single bit/octet.  Or,
if a C<String> is the primary component of a character string type, then
each string element is interpreted as a single code point of the character
repertoire of the character string type.  Or, if a C<String> is used in the
I<heading> of a C<Tuple>/etc, then it is like with a character string but
that the character repertoire is defined by the package in which it is
defined by way of that all C<Name> in a package must have the same
character repertoire.
Two C<String> are only considered identical if they have the same element
repertoire applied to them, and for two C<String> with the same repertoire,
the rules for determining equality vary per repertoire.  It is often useful
to fold two C<String> to the same repertoire, but that will never happen
automatically for generic comparisons.  But it will happen automatically
where possible when comparing DBMS entity names in C<Tuple>/etc headings,
so that addressing DBMS entities would just work across package boundaries.

A C<Tuple> is a C<Structure> having either of 2 formats, designated
I<row-oriented tuple> and I<column-oriented tuple>; the first has exactly 2
payload elements and the second has exactly 1.  The 2 payload elements of a
I<row-oriented tuple> are designated, in order: I<heading>, I<tuple body>.
The I<heading> is a C<List> of 0..N mutually distinct elements where each
element is designated an I<attribute name>; each I<attribute name> is a
C<String>.  The I<tuple body> is a C<List> of 0..N elements where each
element is designated an I<attribute value>; each I<attribute value> is a
C<Universal>.  The I<heading> and I<tuple body> must each have the same
number of elements, and the pair of corresponding element values
collectively define a named tuple attribute.  The payload element of a
I<column-oriented tuple> is designated I<tuple attributes>.  The I<tuple
attributes> is a C<List> of 0..N elements where each element is designated
a I<tuple attribute>; a I<tuple attribute> is a C<List> of exactly 2
elements, that are designated in order: I<attribute name>, I<attribute
value>.  The 2 formats of C<Tuple> are interchangeable, such that every
possible tuple value is representable by either format.  When determining a
C<Tuple>'s identity, its row vs column format is not significant, and the
mutual order of its attributes are not significant, but the pairings of
attribute names and values are significant; two C<Tuple> are considered
identical iff they have the same count of attributes and the same attribute
names and identical attribute values for corresponding names.

A C<Relation> is a C<Structure> having either of 2 formats, designated
I<row-oriented relation> and I<column-oriented relation>; the first has
exactly 2 payload elements and the second has exactly 1.  The 2 payload
elements of a I<row-oriented relation> are designated, in order:
I<heading>, I<relation body>.  The I<heading> is the same as that of a
I<row-oriented tuple>.  The I<relation body> is a C<List> of 0..N mutually
distinct elements where each element is designated a I<tuple body>.  Each
I<tuple body> is the same as that of a I<row-oriented tuple>.  For each
I<tuple body> of a I<relation body>, its relationship and associated
constraints with I<heading> are as per a I<row-oriented tuple>.  The
payload element of a I<column-oriented relation> is designated I<relation
attributes>.  The I<relation attributes> is a C<List> of 0..N elements
where each element is designated a I<relation attribute>; a I<relation
attribute> is a C<List> of exactly 2 elements, that are designated in
order: I<attribute name>, I<tuple attribute values>; a I<tuple attribute
values> is a C<List> of 0..N elements where each element is designated
I<attribute value>.  The 2 formats of C<Relation> are interchangeable, such
that every possible relation value is representable by either format.  When
determining a C<Relation>'s identity, its row vs column format is not
significant, and the mutual order of its attributes are not significant,
and the mutual order of its tuples are not significant, but the pairings of
attribute names and values per tuple are significant, and the mutual
association of attribute values in each same tuple is significant; two
C<Relation> are considered identical iff they have the same count of
attributes and the same attribute names and identical attribute values for
corresponding names for every corresponding tuple.

A C<ScalarWP> (scalar with possreps) is a C<Structure> having exactly 3
ordered payload elements, that are designated in order: I<type name>,
I<possrep name>, I<possrep attributes>.  The I<type name> is a C<List> of
0..N C<String> that is restricted as per an C<APTypeNC>.  The I<possrep
name> is a C<String>.  The I<possrep attributes> is a C<Tuple> where the
intended interpretation of I<possrep attributes> is indicated by the
combination of I<type name> and I<possrep name>.  Generally speaking, the
I<type name> and I<possrep name> of a C<ScalarWP> are partially
context-independent.  For two C<ScalarWP> with the same I<type name>, iff
there is no user-defined type known to the DBMS matching that I<type name>,
then interpretation is as per naive C<List> comparison semantics; iff there
is a matching user-defined type, then identity semantics are determined by
that type's definition, including the ability to compare two C<ScalarWP>
with different I<possrep name> as being the same value.  When user-defined
types are in scope that "claim" particular values, they can provide possrep
mapping, as well as canonicalization (such as making a C<Rat>'s
C<numerator> and C<denominator> coprime), so effectively acting as
restrictions, and overriding what equality tests on those values result in.

An C<External> is a C<Structure> having exactly 1 payload element, that is
designated I<payload>.  The I<payload> is an C<Int> or a C<List> that the
DBMS externally maps to a value of a type of a peer or host language to
Muldis D, as if the payload were conceptually a memory address meaningful
to the external language.  For two C<External>, they are considered
identical if their I<payload> are the same C<Int> or C<List>; otherwise the
determination of identity is left to the other language.  Note that the
C<List> payload provision is provided so that it is possible to have some
degree of external value structure visible in Muldis D, such as for the
purposes of easily defining C<External> proper subtypes in Muldis D.

# ENVIRONMENT

The Muldis D DBMS / virtual machine, which by definition is the
environment in which Muldis D executes, conceptually resembles a hardware
PC, having command processors (CPUs), standard user input and output
channels, persistent read-only memory (ROM), volatile read-write memory
(RAM), and persistent read-write disk or network storage.

When a new virtual machine is activated, the virtual machine has a default
state where the CPUs are ready to accept user-input commands to process,
and there is a built-in (to the ROM) set of system-defined entities (data
types, operators, variables, etc) which are ready to be used to define or
be invoked by said user-input commands; the RAM starts out effectively
empty and the persistent disk or network storage is ignored.

Following this activation, the virtual machine is mostly idle except when
executing Muldis D commands that it receives via the standard inputs.  The
virtual machine effectively has multiple concurrent processes, where each
process effectively handles just one (possibly complex) command at a time,
and executes each separately and in the order received; any results or
side-effects of each command provide a context for the next command, both
in the current process and, where applicable, in other processes.

At some point in time, as the result of appropriate commands, data
repositories, or "depots" (either newly created or previously existing)
that live in the persistent disk or network storage, or volatile memory,
will be mounted within the virtual machine, at which point subsequent
commands can read or update them, then later unmount them when done.
Speaking in the terms of a typical database access solution like the Perl
DBI, this mounting and unmounting of a repository usually corresponds to
connecting to and disconnecting from a database.  Speaking in the terms of
a typical disk file system, this is mounting or unmounting a logical
volume.

Any mounted depot is home to all user-defined data variables, data types,
operators, constraints, and routines; they collectively are the
database that the Muldis D DBMS is managing.  Most commands against the
DBMS would typically involve reading and updating the data variables, which
in typical database terms is performing queries and data manipulation.
Much less frequently, you would also see "data definition" changes, namely
what user-defined variables, types, etceteras exist, done fundamentally by
data-updating special system-defined "catalog" variables.  Any updates to a
persistent depot will usually last between multiple activations of the
virtual machine, while any updates to a temporary depot are lost when the
machine deactivates.

All virtual machine commands are subject to a collection of both
system-defined and user-defined constraints (also known as business rules),
which are always active over the period that they are defined.  The
constraints restrict what state the database can be in, and any commands
which would cause the constraints to be violated will fail; this mechanism
is a large part of what makes the Muldis D DBMS a reliable modeler of
anything in reality, since it only stores values that are reasonable.

Note that in practice, the aforementioned concept of "commands" is realized
by "statements" or "routines".

# ROUTINES

B<WARNING: All statements in this documentation that mention atomicity or
transactions or concurrency are considered out of date and partly untrue,
and will need to be rewritten or excised.>

Muldis D is designed such that, to nearly the maximum degree possible, the
built-in language syntax is expressed just in terms of generic-syntax
routine invocations, meaning that wherever possible the language features
are defined in terms of being just routines.  This allows the fundamental
Muldis D grammar to be as simple as possible and it empowers users to
define additional features that can mimic nearly any built-in ones in both
functionality and syntax.  There are only a few exceptions to this rule,
where doing so has a large net benefit to the language design.

## Functions and Procedures

Every Muldis D routine is exactly one of 2 main routine kinds,
C<function> and C<procedure>, where the 2 kinds are mutually exclusive.
Each of these 2 kinds is very distinct with regards to what
it conceptually represents or where it may be used, and Muldis D has
disjoint catalog data types for defining routines of each of the 2 kinds,
which are C<Function> and C<Procedure>.

Functions and procedures have many aspects in common.  Every routine,
regardless of kind, is a distinct material of a library, either built-in or
user-defined, which has its own explicitly defined (name-space qualified)
name and it is explicitly invokable using that name.  Any routine may be
arbitrarily complicated and may either invoke other routines or be invoked
by other routines, and such invocations may be recursive; any routine may
be subdivided into other routines of its own main kind to aid management or
documentation of code (and sometimes subdividing of a conceptually single
routine may be mandatory for technical reasons).  Any routine may have
explicit parameters which take corresponding arguments when the routine is
invoked; every parameter has a declared type and the declared type may be
any type at all.  All routine parameters are named, not positional (but
positional parameters can be faked using sequential integer names); in the
case of N-adic routines, the N similar argument values come by way of a
single nonscalar typed parameter.  Any routine's body may have arbitrarily
complex value-expression trees, which consist of named nodes whose use by
name can ease program writing like lexical variables would have.  Also,
every routine's parameters, and any procedure's lexical variables, are
effectively either value-expression nodes or lexical variables, even if the
routine otherwise has none of those.  Any routine may directly invoke
functions.

Functions and procedures have a strict ordered proper subset/superset
relationship with regard to what they can be used to I<do> from a user's
perspective.  A procedure is all-powerful, and anything that can be done in
Muldis D at all can be done by invoking a procedure.  A function's
capabilities are a proper subset of a procedure's; the most that can be
accomplished just by invoking a function is any set of operations that can
be accomplished just with values supplied as its explicit arguments, and
that is completely deterministic.  A procedure may directly invoke both
procedures and functions, while a function may only directly invoke
functions.

Functions differ from procedures
primarily in regards to how they are invoked and to how they return their
outputs.  A function, also known as a I<read-only operator>, is the only
routine kind whose invocation both results in and represents a value of a
specific data type (that is the function's I<result type> or I<declared
type>).  A function's invocation can only exist as part of a
value-expression of another routine, not as its own statement.  The body of
a function is also itself a single value-expression (though its parts can
be named for internal reuse).  All of a function's 0..N parameters are
read-only / not subject to update.  And so, a function takes all of its
inputs from its arguments and it returns all of its outputs as as a single
function result value.  In contrast, a procedure exchanges data
directly with its invoking routine by exclusive means of its parameters,
or through shared global variables (the database),
and a procedure's invocation does I<not> result in or represent a
value.  A procedure is invoked as the root part of a statement of
a procedure, and never within a value-expression.  Each of a
procedure's 0..N parameters may be either read-only or subject to update;
the procedure may take input from both kinds of parameters but it may
return output directly to its invoker just by means of updating its subject
to update parameters, or shared global variables.

Sometimes a function is composed as part of the definition of another
material.  Conceptually speaking, the function is part of the definition of
the body of the parent material (like a value expression in general), but
is isolated into a named function-like entity for technical / language
design reasons.  For example, it is used to implement what would
conceptually be an anonymous function defined within its parent routine for
use as a function-valued argument of some other routine call; or to
implement what is conceptually a self-referencing/cyclic expression.

A procedure may directly see and update global variables (both catalog and
data), and is the only kind of routine that can; every call chain that is
meant to work with a persisting (global) dbvar must include a procedure.  A
function can I<not> directly see any global variables.

A procedure is allowed to be nondeterministic, meaning that its behaviour
can be different between multiple executions where all have the same
arguments and global (database) variable preconditions, and it is the only
kind of routine that can; every call chain that is meant to do something
nondeterministic must include a procedure.  In every interactive
application consisting only of Muldis D code, the "main program" that
starts a call chain is always a procedure.  Assuming that the
current in-DBMS process has exclusive access to all of its mounted depots,
a procedure is nondeterministic iff it invokes, directly or indirectly, a
system-defined procedure that does something nondeterministic, such as
initiating I/O of various kinds or fetching the current date and time or
generating a random number, or deriving an array from a set simply without
sorting the elements into a total order (because the result is
fundamentally random and non-repeatable); such an exclusive-access
procedure is instead deterministic if it does none of these things.  If a
procedure does not have exclusive access to all of its mounted depots, then
even a procedure that does none of these things may be nondeterministic
because other processes could modify global variables it is using during
the course of its execution, and the actual postconditions could vary
simply due to matters of timing.  A function is always deterministic
because it is forbidden from invoking any nondeterministic routine, which
all happen to be procedures, and because a function's execution is
entirely contained within a single transaction of the highest possible
isolation level, "serializable".  A procedure that does not have exclusive
access to its depots can optionally gain back a measure of the determinism
it would lose just due to that purpose by either being declared as its own
transaction, or by being invoked within a larger transaction.  A procedure
that is neither itself a transaction nor is invoked in one will only be
guaranteed consistency separately within each recipe that it invokes.

A procedure's body may have 0..N lexical variables while a function's
body may not have any lexical variables.

A C<recipe> is a special case of a procedure, such that it consists of a
single multi-update statement whose components execute all at once, rather
than a series of statements that execute sequentially at different times,
and a recipe does not have any lexical variables besides its parameters.

A recipe invocation is implicitly atomic, and a failure in the middle of
one will at least rollback any partial update that it may conceptually have
done.  A function invocation is trivially atomic, since it doesn't
conceptually update anything.  A procedure invocation is I<not> implicitly
atomic in its general case; unless a wider-scope explicit transaction is
active, an aborted general case
procedure will leave an incomplete update (though not one that violates any
constraints or leaves the system in an inconsistant state), because each of
its statements had conceptually auto-committed; so Muldis D does support
batch operations where partial completion or interruptability is
acceptable.  A procedure can optionally constitute an explicit (lexically
scoped) transaction; this is the case iff its defining C<Procedure>'s
C<is_transaction> attribute is C<Bool:True>.

An C<updater>, also known as an I<update operator>, is a special case of a
recipe, such that it does not directly see or update any global variables
(as implicit parameters), and it must have at least one subject-to-update
explicit parameter, and it may directly invoke only updaters or functions.

An updater is exactly the same as a
function, except that where a function returns its result as the conceptual
value of the function invocation itself (and all of its parameters are
read-only), an updater returns its result by way of at least one subject to
update parameter (and the updater invocation has no conceptual value).  In
some respects this is little more than a difference of syntax; either way,
both an updater and a function are I<pure> in the functional language
sense, and can't see any data except from their own definition or their
arguments, and they have no side-effects except via their result values.

The body of an updater is a single multi-update statement
(plus any support expressions)
that invokes one or more updaters (recursively down to some system-defined
variable assignment operator); if invoking several, it is a multi-update
statement.  Unlike either functions or other procedures, which may
have zero
parameters, an updater must have at least one parameter which is subject to
update (because the only way it can return any output at all is by updating
said parameters).  The execution of an updater has 3 distinct phases in
concept; the first phase analyses any chains of calls to other updaters and
yields a new conceptualization of the first updater where it consists
simply of a multi-update statement entirely of calls to the system-defined
C<assign> updater (typically if the updater is just updating one or more
parts of the global database, the new-concept consists of a single
C<assign> to the dbvar as a whole); the second phase reads the values of
all the updater's parameters (including the pre-invocation dbvar's value)
and evaluates all the new-concept value-expression trees in the updater to
determine the new values to assign to the subject to update parameters (or
the dbvar); the updater's final/only action is just assigning the
expression values to the parameters simultaneously.  There is never any
situation in an updater execution where a subject to update parameter is
updated by one of its statements before another one of its statements reads
from said parameter, so the order of evaluation for statements of a
multi-update statement of an updater doesn't matter.  Further to the
updater's final/only conceptual phase, when both a depot's catalog and data
dbvars have been simultaneously updated, the only database constraints that
apply to the new value of the data dbvar are those defined by the new value
of the corresponding catalog dbvar; neither do the old constraints apply to
the new data nor do the new constraints apply to the old data.

A recipe is exactly the same as an updater (its body being composed of a
single possibly multi-update statement), except that it can directly see
and update global variables, as if the latter were implicit parameters, and
it also isn't required to have a subject-to-update explicit parameter, but
instead must have either a subject-to-update explicit parameter I<or> a
lexical alias for a global variable, through which it yields its output.
Both updaters and recipes can do data definition plus data manipulation,
but it is likely that users will prefer to use recipes in the general case
for their primary database-using codebase because they can potentially
encode each entire database query or manipulation as a single routine,
which is what they are likely already used to.  This would leave updaters
and functions for more generic toolkit or type-connected routines, and
procedures for just nonatomic or nondeterministic activities.  A recipe or
updater is not allowed to update both a depot mount control catalog and
either a depot catalog or data dbvar at once; only a single procedure can
do this, utilizing multiple sequential/non-concurrent statements.

The body of a procedure consists of 0..N statements which conceptually run
in sequence (not concurrently).  The database and any procedure lexical
variables do have a distinct (and consistent) state between each of the
procedure's statements.  Generally speaking, another process may also
update the database between 2 successive statements of a procedure, and so
a procedure won't necessarily see the same database over its run unless it
explicitly either uses a transaction (all of which are serializable), or it
explicitly employs resource locks, around the relevant block of its
statements.  See **TRANSACTIONS AND CONCURRENCY** for
more discussion on this matter.

## Emphasis on Purity

Atomic routines constitute the vast majority of system-defined routines,
and the vast majority of those are functions; non-recipe
procedures constitute a slim
minority of system-defined routines.  System-defined functions include all
value selectors, and the typical numeric, string, and relational operators,
such that you would compose a typical database "select" query out of.
System-defined updaters include mainly just the generic C<assign> operator
plus some relational-assignment short-hands such as C<assign_insertion>.
System-defined recipes include mainly short-hands for updating the system
catalog, such as for creating, dropping, or altering types and routines.
System-defined procedures include mainly just service routines that reach
outside of the more deterministic DBMS environment in order to do
non-deterministic things, such as to initiate
I/O of various kinds, or fetch the current date and time, or generate a
random number.  Similarly to the built-ins, it is highly likely that there
would be many more user-defined routines that are atomic than those that
are not.  The vast majority of recipes or non-recipe procedures that exist
will be user-defined.

Muldis D is generally optimized to prefer stateless immutable-value pure
functional language paradigms over variable-mutating procedural language
paradigms.  A Muldis D program will generally have any state-sensitive or
side-effect-having code confined to as small a portion of it as possible,
generally as close to the "main program" in the call chain as possible.
Similarly, all type definitions are pure, and any database constraints that
could be are built-in to data types rather than variables (which is part of
the reason that "the database" is typically considered a single variable).

There are many benefits to emphasizing functional purity.  For one thing,
Muldis D should be relatively easy to optimize, since a compiler or runtime
environment can be confident that it can make a wide variety of changes to
code behind the scenes to improve its performance or memory usage, such as
changing its execution order, and know that doing so isn't going to change
the semantics of the code.  Because data in general is immutable, neither
users nor the compiler need to worry about making sure data is copied
repeatedly in case some code might want to modify it while other code
doesn't want it modified.  Similarly, Muldis D code can more readily take
advantage of the large degrees of parallelization that computers are
trending towards, with their emphasis on more CPU cores or CPUs or machine
clusters versus having a single CPU and increasing its speed.  A Muldis D
compiler or runtime can automatically use multiple threads and split up
many of its operations over multiple CPUs, running them concurrently
without changing the behaviour versus a single-threaded program, and users
writing Muldis D code don't generally have to worry about the details.  A
Muldis D program should also be easier to analyze statically at compile
time, so it is easier to prove early on whether it is correct or not, and
reduce the burden on runtime tests or chance to discover any bugs.  Muldis
D code should be easier to write, since programmers can focus more on
the real problem they want to solve and less on avoiding various gotchas.
A lot of Muldis D code can also be evaluated lazily, so a compiler or
runtime can recognize that often work doesn't need to be done at all.

Note that when converting some code from another language (such as SQL) to
Muldis D, some reordering may be required.  For example, when you
conceptually want to fetch the current date or a generate a random number
inline of a database query expression, you will actually have to perform
the date or number fetch as a completely separate procedure statement from
the one that performs the database query, and use variables as
intermediaries to include the date or number in the database query.  Or, if
converting a "function" from another language that is allowed to have
side-effects or update its parameters, this will have to at least partially
be rendered as a procedure in Muldis D.  In practice however,
especially if you followed good design practices in the other languages,
such alterations shouldn't be too common.

## More on Parameters

Conceptually speaking, all Muldis D routines actually have exactly 1 or
2 positional parameters behind the scenes, each of which is C<Tuple>-typed,
and it is the named attributes of these positional parameters that
correspond to the official named parameters.  With all functions,
there is exactly 1 positional parameter named C<args>; with all procedures,
there are exactly 2 positional parameters named C<upd_args> and
C<ro_args>.  This conceptual nature is exposed when you use
system-defined routines such as C<sys.std.Core.Cat.func_invo>, where
you actually are supplying a set of argument values for the routine to
invoke as a C<Tuple> value.  Now this all being said, for the purposes of
the rest of the Muldis D documentation, the term I<parameter> always refers
to a named parameter, and the term I<argument> is a value passed to said.

Some subject-to-update or read-only parameters of routines may be optional,
that is, do not need to be supplied explicit arguments when the routine is
invoked; the other routine parameters would be non-optional and must be
supplied explicit arguments.  The optionality of each routine parameter is
part of the definition of that routine.  Routine declarations are
huffman-coded with the assumption that the majority of parameters will be
non-optional, and non-optional also errs on the side of readability and
error avoidance; each parameter is non-optional by default unless it is
explicitly marked as optional.  When a routine executes, any of its
parameters marked as optional which is not given an explicit argument will
implicitly default to the default value of its declared type; any
subject-to-update parameter marked as optional which is not given an
explicit argument will implicitly bind to a new anonymous variable (with
the aforementioned default value) which is discarded after the routine
finishes executing.

## Kinds of Functions by Structure

Various subsets from all the possible functions have special significance
in Muldis D, each of which is intended for particular tasks, and all
functions allowed to be used for each particular task must have a certain
structure.  This documentation sub-section describes a set of 7 function
kinds where each kind is named after either its required structure or its
intended use:  C<named-value>, C<value-map>, C<value-map-unary>,
C<value-filter>, C<value-constraint>,
C<value-reduction>, C<order-determination>.  Taking analogy to the type
system, if functions in general were a maximal type, then each of these
function kinds is a proper subtype of that maximal type.  Similarly, just
as the catalog data type C<Function> will define any function, these proper
subtypes of C<Function> will define functions of just their corresponding
kinds:  C<NamedValFunc>, C<ValMapFunc>, C<ValMapUFunc>, C<ValFiltFunc>,
C<ValConstrFunc>, C<ValRedFunc>, C<OrdDetFunc>.

A C<named-value> is a function that is nullary / has exactly zero
parameters and unconditionally results in the same single value.  This kind
of function is also called a I<thunk>.

A C<value-map> is a function that has at least 1 parameter, and that 1 is
named C<topic>.  A C<value-map-unary> is a C<value-map> that is unary / has
exactly one parameter (just the C<topic> parameter).  A C<value-filter> is
a C<value-map> whose result's declared type is C<Bool>.  A
C<value-constraint> is any function that is both a C<value-filter> and a
C<value-map-unary>.

A C<value-reduction> is a function that has at least 2 parameters, and
those 2 are named C<v1> and C<v2>, and the declared types of those 2
parameters are identical, and the declared type of the function's result is
identical to that of either of those 2 parameters.

An C<order-determination> is a function that has at least 3 parameters, and
those 3 are named C<topic>, C<other> and C<is_reverse_order>, and the
declared types of C<topic> and C<other> are identical, and the declared
type of C<is_reverse_order> is C<Bool>, and the declared type of the
function's result is C<Order>.

## Constraint Function Kinds by Purpose

There are 2 main kinds of constraint functions when considered in terms of
their purpose of place of usage:  C<type-constraint>, C<state-constraint>.

A C<type-constraint> is a C<value-constraint> that is
part of the definition of a data type (every data type composes 0..N
explicit ones of these, plus an implicit one that always results in
C<Bool:True>) rather than being intended for explicit invocation by
a routine, and it is invoked automatically by the
DBMS when a value of that type is being selected.  The parameters
of a C<type-constraint> carry information about
the value selection attempt, and the C<type-constraint> results in either
C<Bool:True> if the described value would be a member of the data type, or
C<Bool:False> if not; in the latter case, the DBMS would then throw a
type-constraint-violation exception (resulting in a transaction rollback
where applicable), or in the former case, it would consider the selection a
success.  If the data type being selected is a scalar type or subtype
with possreps, then each possrep has its own C<type-constraint>, and the
declared type of the C<topic> parameter for each is a tuple where the
attributes of the tuple match those of the possrep; such a tuple
argument provides the candidate components of the scalar value being
selected.  Or, if the data type being selected of is defined as a
subset of one other data type, then the declared type of the C<topic>
parameter is that other data type.  Or, if the data type being selected of
is defined over a union of multiple other data types, then the declared
type of the C<topic> parameter is C<Universal>.  Note that a type with a
C<type-constraint> that unconditionally results in C<Bool:False> is an
alias for C<Empty>.  Note that, because Muldis D requires dbvars to be
defined over named data types, all I<state constraints> for a database,
including uniqueness keys or subset constraints or other state-constraining
business rules, are normally defined as the C<type-constraint> for the type
which that database is.  Conceptually speaking, a C<type-constraint> will
execute as the beginning part of a statement, prior to any attempt to
update any variable's state or affect the environment.

A C<state-constraint> is a C<value-constraint> and it is
the same as a C<type-constraint> except that it is
not part of the definition of a data type, but rather it is associated with
a variable (or pseudo-variable); it is invoked automatically by the DBMS
when that variable is being updated, and it asserts that the variable would
be in a valid state after the update (it results in C<Bool:True> for yes
and C<Bool:False> for no).  The C<topic> parameter of a C<state-constraint>
has a declared type that is the same as that of the variable; its argument
carries the value that the variable would have post-update.  The purpose of
having the distinct C<state-constraint> routine kind when
C<type-constraint> would otherwise do, is to make it easier for users to
independently and externally apply multiple (named) state constraints to
the same variable (typically a dbvar or relvar) rather than having to
update the existing internal explicit type constraint of the declared type
of the variable, and other users of that type aren't affected.  When
multiple C<state-constraint> are applied to the same variable, then a
I<total state constraint> is in effect on the variable equivalent to the
logical C<and> of the individual constraints.  Conceptually speaking, a
C<state-constraint> will execute after all C<type-constraint>.

## Other Function Kinds by Purpose

There are 7 other main kinds of functions when considered in terms of their
purpose of place of usage:  C<named-value>, C<value-map>, C<possrep-map>,
C<virtual-attr-map>, C<value-filter>, C<value-reduction>,
C<order-determination>; the 3rd and 4th have the same structure.

A C<named-value> is often used when you want to declare a program constant
value that is easy to reference on a non-lexical scale.  A C<named-value>
is frequently part of the definition of a (not-C<Empty>) data type rather
than a routine, and it is invoked automatically in situations where the
default value of the type whose declaration it is part of is needed, such
as when initializing a variable whose declared type is that type (a
variable must always hold a valid value of its declared type).

A C<value-map> is what would be used in operations like the general case of
relational extension or substitution.  Its C<topic> parameter is usually a
tuple type but doesn't have to be.

A C<possrep-map> is a C<value-map-unary> that is part
of the definition of a scalar data type, and it is used to convert a value
from one of that type's possreps to another.  A C<possrep-map>'s C<topic>
parameter's declared type is a tuple whose
attributes match those of the possrep being converted from, and its result
type is a tuple whose attributes match those of the possrep being converted
to.  Note that every distinct argument (domain) value of this function must
have a distinct result (range) value, as it is a 1:1 mapping function.

A C<virtual-attr-map> is a C<value-map-unary> and it is
the same as a C<possrep-map> except that its range
may be (and typically is) smaller than its domain, it is usually part of
the definition of a nonscalar data type, and it is used such that,
on a per-tuple basis, one subset of that type's attributes is defined to
be generated, by the C<virtual-attr-map> function, purely from a disjoint
subset of that type's attributes.  So a special kind of I<functional
dependency> exists between the first subset, which has the I<dependent>
attributes, and the second subset, which has the I<determinant> attributes.
For example, a dependent attribute could always hold a character string
value that is the same as a determinant attribute but for being folded to
uppercase; or for another example, a dependent attribute may hold the
result of a relational join of multiple determinant attributes, or a
restriction on one (in the latter case, the data type being defined is
probably a database).  A C<virtual-attr-map>'s C<topic>
parameter's declared type is a tuple whose attributes match those of
the determinant attributes of the type being declared, and its result type
is a tuple whose attributes match those of the dependent attributes.  A
consequence of the special functional dependency is that the dependent
attributes can all be virtual; the DBMS can store just the determinant
attributes, and the dependent attributes can be generated when needed (or
they can still be pre-computed and stored for performance).

A C<value-filter> is similar
to a C<type-constraint> in that it evaluates C<topic> for membership in a
particular value domain, resulting in C<Bool:True> if C<topic> is a member
and C<Bool:False> otherwise; but a C<value-filter> differs from a
C<type-constraint> in that it would be explicitly invoked possibly in any
context, and its criteria for evaluating C<topic> can be customized at
runtime by any not-C<topic> arguments it
gets.  A C<value-filter> is what would be used in
operations like the general case of relational restriction.  Its C<topic>
parameter is usually a tuple type but doesn't have to be.

A C<value-reduction> is what would
typically be used in N-ary operations that can be defined in terms of a
repetition of binary operations, such that a C<value-reduction> would
define such a binary operation.

An C<order-determination> is structured to fill the role of a
I<system-compatible fundamental order-determination function>; see the
**Ordered Types** pod section in this file for more details.

## Kinds of Procedures

A C<system-service> is a procedure whose sole purpose is to
directly reach outside of the more deterministic DBMS
environment in order to do non-deterministic things (besides working with
depots), such as to initiate I/O of various kinds, or fetch the current
date and time, or generate a random number.  Invoking a
C<system-service> can have side-effects outside of the DBMS, but it will
not alter anything inside the DBMS aside from any of its subject-to-update
parameters; it can not invoke any recipes.  A C<system-service> is
forbidden from invoking a procedure that isn't also a C<system-service>.
The catalog data type C<SystemService>, a proper subtype of C<Procedure>,
will define any C<system-service>.

A C<transaction> is a procedure that isn't a C<system-service> but
otherwise constitutes its own explicit (lexically scoped) transaction.  As
with any procedure that isn't a C<system-service>, a C<transaction> may
invoke any routine at all.  The catalog data type C<Transaction>,
a proper subtype of C<Procedure>, will define any C<transaction>.

A C<recipe> is a C<transaction> which has no non-parameter lexical
variables and whose root statement is a multi-update statement (or recipe
invocation or assignment statement).  A recipe may only invoke recipes and
functions, and not procedures that aren't recipes.

An C<updater> is a C<recipe> that does not see or update any global
variables (the database) and that has at least one subject-to update
parameter.  An updater may only invoke updaters and functions.

## Overloading With Virtual Routines

Muldis D natively supports routine/operator overloading, in the sense that
a collection can exist of routines that differ only in the declared types
of their parameters, where one can invoke the collection as a whole by a
single collective name, and one of the routines in the collection is
dispatched to automatically based on the types of the invocation arguments.

This overloading feature is utilized by way of I<virtual routines>.  A
Muldis D routine of any kind (function or procedure), that has at
least one parameter, is made I<virtual> by declaring that at least 1 of its
parameters is a I<dispatch parameter>; moreover, said routine definition
would only define its interface or I<heading> and not its implementation or
I<body>.  A I<virtual> routine is intended to be overloaded, and the
virtual routine's name is what one invokes explicitly in order to
implicitly invoke one of any other routines that implement it.  The set of
routines that implements a virtual routine is determined to be all routines
whose definitions explicitly declare that they implement that specific
virtual routine, by specifying the latter by name.  An implementing routine
is allowed to be virtual itself, so a routine collection can look like a
hierarchy.  A virtual routine and all of its implementers must have the
same main routine kind (for example, they must all be functions), and their
parameter lists (parameter count, names, which are updatable or readonly,
which are optional) must be identical save for the declared types of the
parameters; where any declared types of parameters or function result types
differ, the declared type of an implementing routine must be a subtype of
the declared type of its virtual routine.

When a virtual routine is invoked with valid arguments, the types of just
the arguments for its I<dispatch parameters> are examined, and the
implementing routine with the most specific declared types that the
arguments are members of is the routine that is dispatched to.  With
functions, the declared result types of implementers can I<not> be used to
determine which one is dispatched to.  So conceptually a virtual routine is
just a single given-when expression or statement that dispatches on the
types of its arguments; a user could write this explicitly instead of using
a virtual routine, but it is often more elegant to use a virtual, where
that dispatch table is built automatically by the system.

Muldis D requires that the declared types of the corresponding dispatch
parameters for all implementing routines of the same virtual routine to be
mutually disjoint, so that any given dispatch argument would only ever
qualify for exactly one of them.  Theoretically, pairs of types could be
allowed to overlap as long as for every overlap there is an implementing
routine in the set whose declared type is the intersection type of that
pair, so that there is still a single most specific type to pick; however,
Muldis D currently doesn't mandate that feature because it would be onerous
to determine which overlapping option is the most specific one in the
general case.  This being said, Muldis D allows the same routine to
directly claim implementation of multiple virtuals, such as when two
virtuals have essentially the same parameter lists with partially
overlapping types, and the implementer's parameter types are in the
intersection of that pair, should this be useful.

Muldis D supports both system-defined and user-defined virtual routines,
meaning users can define new overloadable operators, and users can add
implementing routines to both system-defined and user-defined virtual
routines, meaning users can overload all virtual routines, both to support
system-defined types and user-defined types.

Now, just because a routine implements a virtual routine doesn't mean that
a piece of code can't invoke the former directly; in fact, it is
recommended to do so when the invoking code knows that all of its possible
arguments will dispatch to the same implementing routine.

There are 2 main use cases for code to invoke a virtual routine.  The first
is to allow invoking code to be open-ended polymorphic, so it can
automatically handle new data types that are added after the invoking code
is written, as long as the operation has the same interface and appropriate
semantics, so repeated invoker code updates aren't needed to expand
explicit dispatch logic with all the choices.  The second is when the
concrete Muldis D grammar you are using has operator syntax that is
overloaded for multiple data types, such as the common mathematical symbols
being overloaded for both C<Int> and C<Rat>, effectively giving multiple
implementing routines the same name, because it would be unpleasant to do
otherwise by invoking each variant with distinct symbols.

Currently, Muldis D restricts the set of interconnected virtual plus
implementing routines to all live in the same depot, or a set may be partly
system-defined as long as all of the user-defined members are in the same
depot.  Or at least that is the case for all implementing functions of a
virtual function that is used in the definition of a data type, all of
which must be in the same depot aside from system-defined members.

# STIMULUS-RESPONSE RULES

Muldis D natively supports the concept of I<stimulus-response rules>,
otherwise known as I<triggered routines>.  The concept involves the
automatic execution of a procedure in response to a particular
defined stimulus.  This is in contrast with the normal way to execute a
routine which is in response to an explicit invocation in code.

The single most important use of a stimulus-response rule is to bootstrap a
pure Muldis D application by causing the application's "main" routine to
execute when the DBMS starts up and mounts the depot containing it, as
there is no other Muldis D routine to invoke the first one in any call
chain.  A Muldis D implementation that doesn't support stimulus-response
rules is one that can only support mixed-language applications, such that
code in some other language has to be the start of any call chain involving
Muldis D routines.

Muldis D is expected to support stimulus-response rules for a wide variety
of stimuli, and so support the general case of any kind of trigger in any
kind of SQL DBMS, or to support event-driven systems like general-purpose
programming languages.

However, for now, Muldis D only supports exactly one kind of
stimulus-response rule, which is the C<after-mount> rule used for
bootstrapping a pure Muldis D application call stack.  With C<after-mount>,
the stimulus is the act of a depot being mounted in the DBMS, and the
response is the execution of a procedure in that depot, such that
the latter occurs at a separate but immediately subsequent point in time
from the point in time than where the depot is mounted.  Said depot is
typically the initial one in the DBMS, and its name plus necessary
credentials are given as DBMS startup parameters, similarly to naming a
source code file as the main parameter to a compiler of a typical
programming language.  Alternately, said depot can be a noninitial one and
be mounted by code in another depot by way of a system-catalog
depot-mount-controls update.  What happens is that once a depot is mounted,
the DBMS scans it for any materials which are C<after-mount> rules and it
executes the routine that each such rule names, which must live in the same
depot as the rule, so everything is self-contained.  Other uses of an
C<after-mount> rule include some kinds of initialization activities that
would best precede other uses of the depot, but these might be rare.

To be clear, stimulus-response rules are I<not> intended to be used to
implement database constraints in general; rather, constraint functions
associated with the types of the database should be used by default, and
only stimulus-response rules be considered for constraints if the
constraints can't be served by the functions, such as because the
constraints are non-deterministic, such as that they compare a date value
to the current system time.

See also
[Muldis_Data_Language_Core_Types_Catalog](Muldis_Data_Language_Core_Types_Catalog.md)
section **sys.std.Core.Type.Cat.MountControlSet**,
specifically the C<allow_auto_run> attribute.  This control empowers users
to decide on a per-depot-mount basis whether the depot mount will permit
any stimulus-response rules defined in the depot to automatically execute
when triggering events occur.  This control is to provide a measure of
security against viruses and other malware that are using Muldis D
databases as a vector.  In the interest of "security-first", you have to
explicitly enable stimulus-response rules; if you don't say anything about
the matter then they won't run.

In a similar manner, a Muldis D DBMS should have command-line parameters
regarding the initial "main program" depot it is mounting that correspond
to each of the C<MountControlSet> attributes; at the very least, the
boolean parameters C<allow_auto_run> and C<we_may_update> must be provided,
in addition to any params for, say, picking the filename/etc of the initial
depot; for security purposes, the booleans are false when not given,
meaning users have to *always* say C<--allow_auto_run> in order to run a
pure Muldis D program, so it is quite clear up front what they are risking.

# USERS AND PRIVILEGES

The Muldis D DBMS / virtual machine itself does not have its own set of
named users where one must authenticate to use it.  Rather, any concept of
such users is associated with individual persistent repositories, such that
you may have to authenticate in order to mount them within the virtual
machine; moreover, there may be user-specific privileges for that
repository that restrict what users can do in regards to its contents.

The Muldis D privilege system is orthogonal to the standard Muldis D
constraint system, though both have the same effect of conditionally
allowing or barring a command from executing.  The constraint system is
strictly charged with maintaining the logical integrity of the database,
and so only comes into affect when an update of a repository or its
contents are attempted; it usually ignores which users were attempting the
changes.  By contrast, the privilege system is strictly user-centric, and
gates a lot of activities which don't involve any updates or threaten
integrity.

The privilege system mainly controls, per user, what individual repository
contents they are allowed to see / read from, what they are allowed to
update, and what routines they are allowed to execute; it also controls
other aspects of their possible activity.  The concerns here are analogous
to privileges on a computer's file system, or a typical SQL database.

# TRANSACTIONS AND CONCURRENCY

B<TODO: REWRITE THIS DOCUMENTATION SECTION!>

## ACID

This official specification of the Muldis D DBMS includes full ACID
compliance as part of the core feature set; moreover, all types of changes
within a repository are subject to transactions and can be rolled back,
including both data manipulation and schema manipulation; moreover, an
interrupted session with a repository must result in an automatic rollback,
not an automatic commit.  (But changes that occur outside the DBMS
environment, such as by a C<system-service>, or by a host language routine,
are generally not affected by transactions at all.)

It is important to point out that any attempt to implement Muldis D (what
**Muldis Data Engine Reference** does) which does not include full ACID compliance,
with all aspects described above, is not a true Muldis D implementation,
but rather is at best a partial implementation, and should be treated with
suspicion concerning reliability.  Of course, such partial implementations
will likely be made and used, such as ones implemented over existing DBMS
products that are themselves not ACID compliant, but you should see them
for what they are and weigh the corruption risks of using them.

I<Note that the best way for an implementation to behave, if for some
reason it is built in such a way and/or over an existing DBMS product that
does implicit commits after, say, data-definition statements, is for it to
throw an exception if data-definition is attempted within an explicit /
multi-statement transaction, such that a user of that Engine can only do
data-definition outside of an explicit transaction; in this way, the
implementation is still following all the Muldis D safety rules, and hence
should be relatively safe to use, even if it lacks Muldis D features.>

## Virtual Machine

Each individual instance of the Muldis D DBMS is conceptually a multiple
concurrent process / multi-threaded virtual machine, and conceptually there
may be several things happening in it simultaneously.  This design helps a
Muldis D implementation use a computer's resources more efficiently when
multiple hardware CPUs are available, or when multiple autonomous tasks
need doing in the DBMS that don't necessarily need doing in a specific
order, nor depend on each other, and either should be able to commit even
if the other doesn't.  Users may explicitly specify distinct processes for
particular high-level statements when appropriate.  Moreover, many
system-defined functions will automatically use multiple threads to do
their work, which is often highly symmetrical and order-independent, as set
based or relational operations often are.  This said, Muldis D has a high
level of isolation between any concurrent processes so to reduce the
complexity of using them and avoid some common pitfalls of concurrency; in
particular, the only data that is generally shared between processes is
the repositories themselves that are mounted by multiple processes.

Within each thread of execution, conceptually only one thing is happening
in it at a time; each individual Muldis D statement executes in sequence,
following the completion or failure of its predecessor.  During the life of
a statement's execution, the state of the virtual machine is constant,
except for any updates (and side-effects of such) that the statement makes.
Breaking this down further, a statement's execution has 2 sequential
phases; all reads from the environment are done in the first phase, and all
writes to the environment are done in the second phase.  Therefore,
regardless of the complexity of the statement, and even if it is a
multi-update statement, the final values of all the expressions to be
assigned are determined prior to any target variables being updated.
Moreover, as all functions may not have side-effects, and in the absence of
any defined stimulus-response rules that can perform updates, we avoid
complicating the issue due to environment updates occurring during their
invoker statement's first phase.  I<Semantics when there are defined
stimulus-response rules that perform updates are still to be defined.>

The rest of this documentation section is written just within the context
of a single in-DBMS process, unless explicitly stated otherwise.

A single multi-update statement may target both catalog and non-catalog
variables, as long as there aren't both writes to depot mount control
variables and either catalog or data variables in a depot.

## Transactions and YYY

B<TODO: Some things that the spec calls "transaction" will instead be
called YYY, in particular "nested transaction".>

Transactions can be nested, by starting a new one before concluding a
previous one, and the parent-most transaction has the final say on whether
all of its committed children actually have a final committed effect or
not.  There are no mutually autonomous transactions within the same process
of a DBMS.

Transactions in Muldis D come in both implicit and explicit varieties, but
the implicit transactions only exist (that is, only have an effect) when
there are no explicit transaction active.

The way to specify an explicit transaction within Muldis D
is to take the statements comprising it and isolate them into their own
C<Procedure> whose C<is_transaction> attribute is C<Bool:True>; such a
procedure is wrapped in a new child transaction that is tied to
its lexical scope.  The transaction will begin when that scope is entered
and end when that scope is exited; if the scope is exited normally, its
transaction commits; if the scope terminates early due to a thrown
exception, its transaction rolls back.  This lexically-scoped mechanism is
the I<only> kind of explicit transaction that Muldis D code can perform
(besides using a C<recipe> rather than a C<procedure> in general).

Sometimes, a transaction-comprising procedure will be invoked by way of an
exception-trapping I<try> control flow statement so that only that
procedure's changes roll back by default when an exception is thrown and
not the prior changes of any further-out transaction, unless an associated
I<catch> procedure then also throws (or re-throws) an exception (that is
not caught by I<catch>).

I<TODO:  How do we specify when to start a new thread or message with
service threads (eg, that log errors, do sequence generation).>

In a mixed-language application, when Muldis D routines are invoked by a
host language, the host language is allowed to specify further parent-most
explicit transactions within the DBMS that are not bound to the lexical
scope of a block, using distinct transaction initiation and termination
statements (suggested names being C<start_trans>, C<commit_trans>,
C<rollback_trans>).  Such open-ended transactions are intended for
transactions which last over multiple DBMS invocations of an application
(whereas Muldis D scope-bound transactions always occur entirely within one
invocation of the DBMS by a host language).  But it is a recommended best
practice that host language code will associate the invocation of said
statements with its own lexical scopes, such as its own I<try-catch>
constructs; host language code could easily implement the scope-tied
paradigm if it wanted to.

An implicit transaction is associated with the lexical scope of every
Muldis D C<recipe> and C<system-service>, and by
extension, every Muldis D statement that is an invocation of said.  Or more
accurately, an update operation (including a multi-update operation) is
implicitly atomic, and will either succeed and commit as a whole, or fail
and rollback as a whole.  Similarly, every functional routine is trivially
a transaction, though since these never update anything, all that really
means is that they see a consistent view of their environment.

By contrast, every C<procedure>
is neither implicitly a transaction nor atomic (except when explicitly
declared as one), so you can use a procedure to define an operation where
you want to keep partial results of a failure.

Since failures are always accompanied by thrown exceptions, a failure will
unwind the call stack and rollback any active transactions one nesting
layer at a time until either a I<try> block is exited, which halts the
unwinding, or the application exits, rolling back all remaining active
transactions.

If no explicit transactions are active at all when a failure occurs, then
each non-procedure-invoking statement in a procedure or host
language routine is the parent-most transaction, and so a failure part-way
through said procedure will result in the prior-completed statements to be
fully committed, and only the failed statement to have left no state
change.  At this point, a pure Muldis D application will have exited, and a
mixed-language application will have either exited or caught an exception
in a host-language I<try> block.

All current repository mounts (persistent and temporary both) by the same
in-DBMS process/thread are joined at the hip with respect to transactions;
a commit or rollback is performed on all of them simultaneously, and a
commit either succeeds for all or fails for all (a repository suddenly
becoming inaccessible counts as a failure).  I<Note that if a Muldis D
implementation can not guarantee such atomicity between multiple
repositories, then it must refuse to mount more than one repository at a
time under the same process (users can still employ multiple depots each
under multiple in-DBMS processes, that are not synchronized); by doing one
of those two actions, a less capable implementation can still be considered
reliable and recommendable.>

Some Muldis D commands can not be executed within the context of a parent
transaction; in other words, they can only be executed directly by a
C<procedure> etc or the host language, the main examples being those that
mount or unmount a persistent repository; this is because such a change in
the environment mid-transaction would result in an inconsistent state.

## Concurrency

Muldis D generally doesn't specify anything related to matters of
multi-process concurrency, such as what other processes see when one
process commits on a commonly mounted repository.  So the language is
officially agnostic to the concurrency model in use by the implementing
DBMS, and so a multiplicity of different models might be considered
conformant.  So, for example, both models based on locks and models using
MVCC may be used with it, as well as other reasonable models.

However, Muldis D does minimally require that only successful commits by a
process will register to other processes on a commonly mounted repository.
In other words a fully-conformant Muldis D implementation will not permit
the "READ UNCOMMITTED" SQL standard isolation level, but all of the other 3
are permitted: "READ COMMITTED", "REPEATABLE READ", "SERIALIZABLE".  This
is required at least because users must always perceive a database to be in
a consistent state, and there are other good reasons besides that.

Muldis D also generally requires that commonly mounted repositories be the
only point of contact between multiple processes.  No other variables can
be shared, though immutable data can of course be shared.  If shared
"application" variables are desired, use a common temporary repository or
a message-passing or listen/notify mechanism.  I<Not yet specified.>

I<Assuming that a DBMS supports multiple concurrency models or levels of
process isolation, then Muldis D would conceivably provide ways for users
to specify which they want to use.  Still to specify, details related to
accessing and exploiting the concurrency models of the DBMS, such as how to
set locks or such things.>

# RESOURCE MODULARITY AND PERSISTENCE

The architecture of Muldis D is based on collections of highly structured
resources, where resources can be executable code (that is, data type and
routine definitions) and/or user data.  Muldis D provides facilities to
introspect all kinds of resources, whether system-defined or user-defined,
and it allows users to update the latter.  Resources typically have names
within the DBMS environment, and are referred to as I<entities>.

## System-Defined Resources

The standard Muldis D language includes a complement of data types and
routines that should be hardwired into every implementation of Muldis D as
globally visible and invokable system-defined entities.  Even if an
implementation can't provide the whole complement, the subset that it does
should carry identical semantics so user entities that just use the
provided subset are still portable.

System-defined types and routines are grouped into multiple dynamically
loadable libraries called I<modules>.  One of these modules, named C<Core>,
is loaded by
default at DBMS startup, and provides the most fundamental resources that
everything else needs.  Other system-defined modules will load
automatically when something in them is referenced by user code; users
never explicitly ask to use a system-defined extension, or at least not
from within Muldis D code.  It is up to each Muldis D implementation to
choose whether any particular system-defined entities are implemented at a
low level using platform-specific primitives, or at a higher level over
other Muldis D types and routines.  Users generally may only introspect the
public interface of system-defined resources, not their implementations, so
they won't know any different.

Each implementation of Muldis D may want to embrace and extend the language
with a further complement of data types and routines, which are
non-standard and fundamentally just useable with that implementation.  They
are implemented in the same way as standard system-defined entities, but
they live under a different DBMS top-level namespace than the standard
entities, so that later enhancements to the standard don't have to worry
about name collisions with unofficial extensions.

## User-Defined Resources

All user-defined resources in Muldis D are actually data, even those that
look like code, and these all exist in one or more I<depots>, which are
the normal means provided by Muldis D for persistence.  A depot is a
completely self-sufficient storage system for normal user data and includes
all the metadata (type definitions) required to understand the structure
of, and the business rules / constraints for, that normal data; the depot
typically also includes all the user-defined routines for querying or
manipulating that data.  All the entities in a single depot must be fully
definable using only system-defined entities and/or user-defined entities
in the same depot; this allows a depot to maintain an independent existence
as far as its interpretability and integrity goes.  Depots are normally
updateable within a DBMS at runtime, but they can alternately be used
read-only.  If a depot doesn't contain normal data, but rather just data
type and/or routine definitions, it is essentially a code library; in fact,
all user-defined Muldis D code libraries are implemented as depots; for
that matter, a pure Muldis D "main program" is a Muldis D code library.

A depot is the native perception by the application / virtual machine
environment of some conceptually external storage system, such as a disk
file or a database server; a depot conceptually will outlast any particular
execution of the application / virtual machine and represents long term
data storage.  That said, the depot doesn't actually have to be persistent;
one could be defined as a temporary space in the computer's working memory,
that will not outlast a DBMS execution.

If the storage mechanism for depots is based on files (eg, SQLite), and
each file can exist separately, but several can optionally be used at the
same time, then each file should be represented in the DBMS environment by
a separate depot.  If the storage mechanism is represented by a SQL
database server (eg, PostgreSQL, Oracle), then probably everything defined
for it within a common SQL catalog should be represented by one depot.  If
a database user authentication is applicable to access the storage system,
then a depot might include everything visible within the context of one
login (in any event, user login/authentication can only be applied at the
per-depot level, unless a more fine-grained approach is reasonable).
Technically, a depot can represent a narrower scope than this, but it
should never represent a wider scope than what is considered a single
independent unit.

At DBMS startup, there is exactly one depot mount, whose mount name is the
empty string, and that depot mount exists continuously until DBMS shutdown.
In a non-hosted Muldis D application (that isn't a no-op), the depot that
this mount corresponds to has at least one procedure that is the "main
program", which has zero parameters, and which is defined to execute
automatically after its host depot is mounted (it is an "after mount"
stimulus-response rule/routine).  In a mixed-language application, when
Muldis D routines are invoked by a host language, the "main program" would
be written in the host language, and this initial depot mount would most
likely correspond to a new transient depot that is empty.

An external storage system may be mounted as multiple distinct depots
within the same DBMS.  This is useful, for example, when the user wants to
connect to the same resource as multiple distinct authenticated users at
once that have different privileges, or where different actions against the
resource ought to be recorded as happening by different database users.  Or
this is useful when the user wants to carry on multiple autonomous
transactions to the same external resource at once, such as to do normal
database activity in one transaction, and to record an audit of failed
update attempts using another autonomous transaction; or alternately, to
increment a sequence generator whose state is persisted in one autonomous
transaction and use sequence values in another, so the sequence generator
doesn't give repeat values if the transaction using it rolls back.

All concurrent depot mounts under the same in-DBMS process are a
I<federation> whose updates must be collectively atomic, and commit or
rollback as one, such as if they are all managed by the same actual DBMS or
DBMS cluster.  Although depots have independent definitions, procedures
defined in them are allowed to invoke or reference resources stored in
others under certain situations.  For example, one might want to perform
cross-database queries or multi-updates, or they may want to migrate an
older depot's schema or data to a newer one.  To assist this, resources of
multiple depots can be mapped to each other on a transient (while both are
mounted) basis, so that the DBMS knows, for example, that their necessarily
redundant data type definitions are supposed to be treated as being the
same data types.

Now, most of the time, the code for a Muldis D application would just be
collected in a single depot, matters of reusability between multiple
database-sharing applications aside.  Each depot is designed to accommodate
its own collections of resources according to various good practices.  A
depot fundamentally consists a collection of types and routines
(under a potentially multi-level namespace).  I<TODO: some types and
routines
are private and others are public.  Each namespace level declares its
own public interface, consisting of the types, routines, and relvars that
are allowed to be directly invoked or referenced from outside of the
namespace, and it can also have more types, routines, and relvars which are
private to the namespace.>  This is analogous to a class definition with
public and private elements, or to C .h vs .c files, or to an Oracle DBMS'
"package".  All non-lexical data variables in a depot may only be database
typed, and the databases are in turn composed of relations, because
relational databases are composed fundamentally of just relations.  To be
more specific, each depot contains exactly 1 dbvar, and each subdepot
in it also contains exactly 1 dbvar, where the latter dbvars are
pseudo-variables which are attributes of their parent depot's dbvar.

When a DBMS starts up, it only contains one auto-started process, which is
the root process; the root process is defined either by the non-hosted
Muldis D "main program" procedure (it runs at DBMS startup, and the DBMS
shuts
down when it ends), or host language routines (the DBMS exists for the life
of some host language object that represents it), as applicable.  This root
process can start other processes, which are its direct child processes,
and other processes can start yet others, thus forming a process hierarchy;
no process may exit until all of its children do.  Generally speaking, a
process can only communicate directly with its own parent or child
processes, through something akin to an inter-process message pipe.  Any
process that wasn't created to autothread a function can communicate with
the DBMS-external user, which includes the root process and/or host
language routines, though typically where there is a host language, all
user interaction is done there.  If a Muldis D DBMS is being used to
implement a multi-client server, then multiple in-DBMS processes may
typically be started directly by the server request listener, so each
client typically is autonomous from others, shared depot contention aside.

# ENTITY NAMES

All entities that exist at some given time within a DBMS environment can be
explicitly referenced in some manner for definition and/or use; there are
no orphans.  At the very least, every kind of DBMS entity is defined in one
or more catalog (pseudo-) relvars or relcons; its interface and/or
implementation can be observed and possibly updated therein.

All entity names are generally context specific, with each context
generally being provided by a routine or other entity; all entity names are
generally relative to the definition location of a routine or other
user-defined DBMS entity.

Since all in-DBMS processes/threads are isolated from each other and
effectively have their own environment, the following namespaces are
generally specific to the context of a single process; so, for example,
each process has only a single depot mount federation.

Note that the following namespaces assume that a program that is written in
Muldis D executes possibly either standalone or a peer-to-peer process
that can have its global variables made visible to other processes, or have
others' made visible to it.  Or in other words, the program can both manage
its own dbvars and be a DBMS client, and the program can either just use
the DBMS itself or be a server of it.  (This is also related to the
concepts of SQL/MED or federated databases.)

I<Note that all entity names in Muldis D are case-sensitive, as with
character strings in general.  Implementations should take special care to
compensate for any case-insensitive storage system they might use.>

This is the hierarchy of invocation namespaces of DBMS entities:

    sys  # system-defined builtin types, routines, and catalogs
        sys.cat  # read-only sys cat db desc entities under sys|mnt, *.cat
        sys.std  # sys-def types and routines defined by standard Muldis D
            sys.std.<module-name>
                sys.std.<module-name>[.<chi-nlx-nsp>]**0..*
                    sys.std.<module-name>[.<chi-nlx-nsp>]**0..*.<material>
        sys.imp  # sys-def types, rtns added by, specif to implementations
            sys.imp.<module-name>
                sys.imp.<module-name>[.<chi-nlx-nsp>]**0..*
                   sys.imp.<module-name>[.<chi-nlx-nsp>]**0..*.<material>
    mnt  # controls for mapping external storage devices etc with depots
        mnt.cat  # updateable sys cat controlling what depot mounts exist
    fed  # the transac-synced federation of curr mounted depots w mount nms
        fed.cat  # updateable sys cat db desc entities under fed.[lib|data]
        fed.lib  # invokable user-def types and routines in this federation
            fed.lib.<depot-mnt-nm>
                fed.lib.<depot-mnt-nm>[.<chi-nlx-nsp>]**0..*
                    fed.lib.<depot-mnt-nm>[.<chi-nlx-nsp>]**0..*.<material>
        fed.data  # updateable db of normal user data in this federation
    nlx  # non-lex s-d,u-d entities ref own immed parent non-lex nsp w this
        nlx[.par]**0..*
            nlx[.par]**0..*.cat  # ro/upd s-c db desc ent under [sys|fed].[lib|data]
            nlx[.par]**0..*.lib  # invokable tps|rtns in this namespace
                nlx[.par]**0..*.lib[.chi-nlx-nsp]**0..*
                    nlx[.par]**0..*.lib[.chi-nlx-nsp]**0..*.<material>
            nlx[.par]**0..*.data  # nothing or upd db of normal user data
    rtn  # entities in a possib-anon-declared rtn can ref that rtn w this

Conceptually speaking, there is also this, but not actually; see
**Lexical Entities** for an explanation:

    lex  # entities in a rtn ref own lexical params|exprs|vars with this
        lex.<param>
        lex.<expr>
        lex.<var>
        lex.<stmt>

Further details of each namespace follow below.

## User Data Variables and System Catalog Variables

All globally visible Muldis D variables are database-typed and can be
grouped into two main kinds, which are system catalog variables (one of
which is actually constant) and user data variables.  The global system
catalog variables all exist as the C<[sys|mnt|fed|nlx].cat>
secondary namespaces (C<sys.cat> is a constant).  The global user data
variables all live as the C<[fed|nlx].data> secondary namespaces.
All non-global variables can be of any types, and conceptually use the
C<lex> primary namespace, of both system and user-defined routines.

The purpose of user data variables is hold user data, and are what gets
read or updated by database users the vast majority of the time; working
with these is termed I<data manipulation>.  These variables are typically
all user-defined.  They are all non-magical, in that updating them has no
side-effects, assuming they are not defined virtual.

The purpose of system catalog variables is to reflect and (where
appropriate) empower modification to the Muldis D I<meta-model>, which is
the active machine readable definition of all DBMS entities in the current
virtual machine, both system-defined (read-only) and user-defined
(updateable); working with these is termed I<data definition>.  They are
all magical, as updating them has immediate side-effects on the visibility
of or existence of or structure of or constraints on some other, typically
user-defined, entities.

Note that magicalness is always associated with variables, not data types,
so users can define their own variables of catalog data types, but updating
those would have no meta-model affecting side effects like with system
catalog variables.

As an exception to the above, users can define virtual variables that alias
one or more other variables (sometimes by way of a function), where
updating the virtual variables is akin to updating the other variables; if
the other variables are system catalog variables, then effectively so are
the user defined virtual ones; this is the only way users can effectively
define magical variables, which otherwise isn't possible; but all such
user-defined magical variables can only be lexical variables.

The system catalog namespaces of Muldis D can be considered analogous to
the "information schema" of SQL, but that the latter is just read-only.

The individual catalog namespaces are described in other sections.

## Standard System-Defined Entities

All system-defined data types and routines are globally visible and
invokable.  Each of these exists in a I<module> (which is a I<package>).

Each standard system-defined type and routine exists under the C<sys.std>
primary namespace, where it is referred to with an absolute path, and its
fully qualified name along this absolute path has at least 2 parts besides
the C<sys.std>.  Beneath C<sys.std>, each secondary namespace is the name
of a module.  The most fundamental standard types and routines, those that
are ideally the least that every Muldis D implementation would provide, are
in the C<Core> module; less fundamental but still standard types and
routines are grouped under various other "extension" modules, with each
module conceptually representing a dynamically loadable plug-in library.
Under each module name is an optional tree of generic namespaces, adding
0..N name parts, each of which we refer to simply as a I<submodule> (which
is a I<subpackage>).  After that, we have the lowest layer, which are
globally addressable type and routine unqualified names.  So the
fully-qualified names of most user-defined entities by way of C<sys.std>
are 4-5 parts.

The catalog namespace C<sys.cat.system> is where all the relcons that
describe, in a machine-readable way, all of the standard system-defined
entities just discussed, as well as themselves, reside; the definitions of
the standard data types of these relcons are also reflected by the same
relcons.  I<Actually, this paragraph is out of date; there is no
C<sys.cat.system> and plain C<sys.cat> currently fills that stated role.>

## Implementation Specific System-Defined Entities

Minimally speaking, the structure and contents of the catalog namespaces
C<sys.cat.[mount|foreign|interp]> are expected to be implementation
specific, and so the (typically named nonscalar) types in terms of which
they are defined would also have to be implementation specific.  While
adhering to that minimum purpose for non-standard additions would be the
best in terms of portability, it is realistic to assume that some
implementations will intend some of their additions to be used for user
data as well.  But even then, ideally such additions would be to serve
specialized niches only, rather than being intended for general use.  Or
ideally these would be deprecated in favor of support of the niche coming
into the standard language as an elegantly designed extension.  I<Actually,
this paragraph is out of date; there is no
C<sys.cat.[mount|foreign|interp]>.>

The C<sys.imp> primary namespace is for the hardwired non-standard /
implementation specific system-defined types and routines in the same way
that C<sys.std> is for the standard system-defined types and routines.
Keeping this separate namespace now allows for implementations to continue
supporting an evolving standard without becoming conflicted with their own
legacy extensions.  Non-standard system-defined entities have fully
qualified names, where they are referred to with an absolute path,
with at least 2 parts besides the C<sys.imp>.  The
secondary namespace is always some authority-like identifier which could
alternately be an implementation name, both of these being referred to
here generically as a module name, which might itself actually use multiple
namespace levels to be fully-qualified.  If some implementation ended up
supporting not only its own extensions, but also the extensions of other
implementations, then the secondary namespace would say who declared the
entity in question; or, that is still useful for external processors of the
extended Muldis D code.  Finally, the depth of the namespace under the
authority-like level is purely implementation specific, and is at least 1
level.

The catalog namespace C<sys.cat.impl> corresponds to C<sys.cat.system>.
The two being separated also results in the value of the C<sys.cat.system>
catalog constant being exactly the same for all implementations.
I<Actually, this paragraph is out of date; there is no
C<sys.cat.[system|impl]>.>

## User-Defined Entities

Users of Muldis D can define their own data types, routines, and variables,
and each of these exists in a I<depot> (which is a I<package>), which is
the means provided by Muldis D for persistence.

The C<fed> primary namespace is for all non-lexical user-defined entities
to be referred to with absolute paths.
Beneath C<fed>, each secondary namespace is the name that a depot is
mounted with by the current process/thread in the virtual machine, and
there is one distinct second-level name per depot mount, and often there is
just one of those at a time.  Under each mount name is an optional tree of
generic namespaces, adding 0..N name parts, each of which we refer to
simply as a I<subdepot> (which is a I<subpackage>).  After that, we have
the lowest layer, which are globally
addressable pseudo-relvar, type, and routine unqualified names.  So the
fully-qualified names of most user-defined entities by way of C<fed> are
3-4 parts.

## Non-Lexical Entities

The C<nlx> primary namespace empowers non-lexical entities declared in the
same [|sub]package to refer to each other using relative paths rather than
using absolute paths which is what C<fed|sys> provides for.  For example,
if 2 functions whose unqualified names are C<f1> and C<f2> live directly in
the same [|sub]package, each one can reference the other, or itself,
using C<nlx.lib.f1> or C<nlx.lib.f2> respectively.  Referring to an entity
in a child namespace of the invoker's own direct parent works as you might
expect, by adding an element per level after the C<lib|data>, for example
C<nlx.lib.mychild.f3>.  Referring to an entity in a parent namespace of the
invoker's own direct parent involves adding a C<par> ("parent") element per
level immediately after the C<nlx>, for example C<nlx.par.lib.f4>.

Using C<nlx> rather than C<fed|sys> allows package entities to be coded in
a portable way, not having to know too much about how they would be used,
such as not knowing what name they are mounted under C<fed> with.  Details
of material definitions as seen in a live in-DBMS mount can remain
invariant and match their actual stored definitions despite where in their
parent namespace tree is actually mounted as a "depot" in some DBMS.  For
example, if some stored database exists with a 2-level namespace, such as
the "schema" namespaces common to a SQL database, then it doesn't matter
whether it is the whole stored database or just a single "schema" which is
mounted in a Muldis D DBMS as a "depot"; when any functions defined in the
same "schema" refer to each other with the relative syntax of
C<nlx.lib.fX>, it will work exactly correctly either way.

In fact, nothing is allowed to directly refer to user-defined entities
using C<fed> except a procedure, or the host language if it
exists.  All user-defined functions and types may only be referenced using
C<nlx> (but that a host language is exempted if it exists).

Note that a C<nlx> may I<not> navigate outside of the referencer's own
package; from its point of view, the root namespace inside its own package
is the root beyond which a relative path can not traverse; attempting this
is an error.

This also means that a namespace of a physical depot may not be mounted in
a DBMS as a "depot" if any of its contents reference outside that namespace
within the physical depot using C<nlx>; in this case a sufficiently larger
portion of the physical depot must be mounted as a "depot" instead so that
all reference targets are visible in the DBMS.  Note that this restriction
applies mainly for references to data types or database constraints, so
that any visible entities defined in terms of such can be fully understood;
it might not have to apply for references to procedures or such things that
C<fed> may be used to reference; in that case the execution of such code
would just fail at runtime if the referenced part of the physical depot
isn't mounted, same as with a non-existing C<fed>-qualified reference.

The C<rtn> primary namespace normally is used entirely by itself as its own
fully-qualified entity name; it refers to the lexically innermost routine,
assuming that the referencer is code within some routine.  The primary
reason for this namespace to exist is to make it easier to write
directly-recursive routines, especially routines that are written as
anonymous routines, where the name of that routine is chosen automatically
by the compiler rather than explicitly by the programmer.  For a routine
whose name, C<foo>, is explicitly chosen by the programmer, saying C<rtn>
in that routine is an alias for saying C<nlx.lib.foo>.

## Lexical Entities

The C<lex> primary namespace refers to entities within
the same private lexical scope as the referencer.  Variables
under C<lex> only are allowed to be of any data type, not just be relvars.

The C<lex> primary namespace is very different in practice from all of the
other primary namespaces, because all contexts where a lexical entity may
be referenced are disjoint from all contexts where a not-lexical entity may
be referenced, and so all references to lexical entities are actually never
qualified with C<lex> because that would be completely redundant, while in
general any references to not-lexical entities must be qualified with their
appropriate primary namespace because they may be ambiguous otherwise as to
which other primary namespace is relevant per context.

To be specific, the prior paragraph reflects the design of the Muldis D
system catalog plus all of the standard dialects.  For code in the system
catalog or in a standard dialect, the syntax for referencing a variable
(read that as parameter or variable or named expression or statement) is
different from that for referencing a routine or type, and all lexical
entities are variables, and the only way a routine can reference a
not-lexical variable is with a third special syntax, which defines an alias
for that not-lexical which is a lexical variable.

But it is possible, in the general case, that a Muldis D dialect might use
common syntax for referencing lexical and not-lexical variables, such as
one that doesn't employ user-visible aliasing of globals to lexicals, in
which case they would probably find explicit C<lex> qualification useful.

Therefore, any documentation that happens to use a C<lex> qualifier just is
being more clear as to what is referred to for the general case.

## Conceptions and Requirements

Practically speaking, the conceptions of some namespaces for user-defined
entities are as follows.

A single virtual machine contains 0..N concurrent processes that are each
autonomous, and generally isolated from each other.  All depot mounts held
by a process are as a whole synchronized with respect to transactions.
(Also, generally speaking, no depot may be mounted or unmounted while an
explicit transaction is active.)  If this is not possible for an
implementation to handle, then only one depot should be allowed to mount at
a time, meaning the implementation is always a non-federated DBMS.  Also,
the virtual machine as a whole represents the application working
environment itself, and there is no database-level user
login/authentication for the virtual machine itself, as it doesn't make
sense for an application to login to its own working state.

The division of a depot into multiple subdepots is optional, and this
construct is provided to allow a perception of the storage system that is
as reasonably unabstracted as possible; the native namespace hierarchy of
the storage system can be exploited with little difficulty.  Assuming the
previously described meaning of a depot is adhered to, there will typically
fundamentally (but see the next paragraph)
be either zero (SQLite) or one (PostgreSQL, Oracle) layers of generic
namespaces; where there is one, it typically corresponds to the storage
system's concept of a I<schema>; where there are two, the second typically
corresponds to Oracle's concept of a I<package>;
but N layers are provided by Muldis D "just in case".

Muldis D supports the concept of I<materials> (routines and types) being
nested within others, like some typical programming languages, but also
necessitated by the
design decision where type and routine definitions are expressly fixed
depth trees (because they are represented by components in a relational
catalog database), rather than N-depth trees like in a typical programming
language.  So when a conceptually N-depth syntax tree of another language
is converted to Muldis D, the nodes in that tree are all given distinct
names and then turned into a flat list, where each list item is, loosely
speaking, a 2-level tree declaring its own name as a root and declaring its
direct children in a set.  Any time a routine or type is conceptually
composed inside another one, such as if the former is a closure, the former
actually has to be composed outside the other one, and be invoked by name.
And so, it is often considered a good practice that when a conceptual type
or routine is split into several actual ones, then these will be grouped
into a subpackage, named after the conceptual main, and the actual main has
the empty string for its name within this subpackage; this grouping means
that the ordinary namespace for conceptual entities is not polluted by
these post-split artifacts.  This presumably common practice would mean
that a package will typically have 1 more subpackage layer than otherwise,
meaning typically 2-3 layers total (corresponding to SQL schema, Oracle
package, each non-trivial SQL stored routine or type, or SQL table with
built-in type definition and constraints).  So the primary namespace C<nlx>
is I<also> used for individual post-split materials to refer to other
post-split materials within the same conceptual larger material.

The primary namespace C<lex> is for entities that would commonly be
considered lexical parameters or variables in a routine; these would
typically map directly to their counterparts for a routine definition
translated to or from some other language.  That said, some kinds of
routines (eg, functions) expressly don't have actual variables, and instead
have pseudo-variables which are named expression nodes; these would
typically either be turned into actual expression trees or actual
variables, or sometimes use native equivalents if the other language is
pure functional.

Each individual depot or subdepot should be interpreted as an integrated
collection of material (type and routine) definitions.  I<TODO: where some
parts of
the collection are private and others are public.>  All entities that are
under a non-C<lex> namespace should all be considered public or
globally referenceable (database user privileges notwithstanding).  I<TODO:
By
default, every material is I<private>, meaning that it can only be directly
referenceable by DBMS entities whose direct parent subdepot (which might be
the depot) is the direct parent of said material, or entities that live in
a subdepot of said parent.  But if a material is explicitly declared
I<public>, then it may I<also> be directly referenceable by DBMS entities
living externally to the direct parent of the target material.  And so,
public materials are the public API of a library, and private ones are
its internals.  By definition, a private material may never be directly
invoked via the C<fed> primary namespace, and presumably not by a host
language either.>  Note that a depot's data/dbvar is always implicitly
public to its full depth, as far as basic API (not user) concerns go; the
only private data is lexicals.

If fine-grained user ownership or privileges are applicable to a depot,
they would typically be applied either at the subdepot level or to other
individual entities under depot, and user-centered privileges can also be
applied to parts of the dbvar such as individual (pseudo-)relvars.

## Terse Pseudo-Variable Syntax

An important feature of a B<D> language is that the components of
variables' current values can be addressed directly as if they were normal
variables, both for reading and for updating.  In support of this feature,
Muldis D's DBMS entity names have a feature extension that allows for
attributes of tuple (but not possrep-having-scalar or relation
in the general case; see below) typed variables to be used as
pseudo-variables, to the Nth degree of recursion, with very terse syntax.

For example, if C<lex.foo> was the name of a tuple-typed variable, and
that tuple type had an attribute named C<bar>, then C<lex.foo.bar> can be
addressed as if it were a normal variable in the same vein as C<lex.foo>.
As a (read-only) value expression, C<lex.foo.bar> would be short-hand for
the result of invoking a tuple attribute extractor function on C<lex.foo>
that extracts C<bar>.  When C<lex.foo.bar> is used as the target of a value
assignment, say the value 42, that is a short-hand for selecting the
tuple value that is equal to what C<lex.foo>'s value is except for its
C<bar> attribute being 42, and assigning that tuple to C<lex.foo>.

With scalars, this kind of terse syntax may also be used in some, though
not all, situations as the syntax may be with tuples;
referencing a possrep attribute requires 2 name elements,
where the first indicates a possrep name and the second an attribute name
of that possrep; for example, C<lex.scalar1.possrep1.attr1>.  Now as you
might expect, you can also just reference a scalar possrep as a whole, as
if it were a tuple-typed pseudo-variable, by using just 1 name element;
for example, C<lex.scalar1.possrep1>.

With relations, this kind of terse syntax may also be used in some, though
not all, situations as the syntax may be with tuples,
since in the general case, addressing a relation attribute is conceptually
referring to a set of 0..N items rather than exactly 1.  So for the
present, relation attributes may only be referred to using this terse
syntax in situations where said attributes of *all* of the tuples in the
relation at once are being referenced.  An example of this is some
canonical terse subset (foreign key) constraint definitions, where one
might want to apply a referential constraint to elements of a TVA or RVA of
a relation, rather than the whole relation attribute.  (For the present,
other parts of the Muldis D documentation ignore for simplicity that an RVA
of a relation can be drilled into, but you in fact can do this where it
makes sense.)

Note that in general, any value expression can denote a pseudo-variable,
but only components of tuples, and sometimes components of scalar possreps
or of relations, get the special short-hand where an extended entity name
can be used as the full expression.

B<Update:>  To be specific, when concerning general contexts such as any
arbitrary Muldis D functional (value expressions) or procedural
(statements) code, I<only> tuples may have their attributes accessed using
this feature extension of DBMS entity names; in general contexts, the
I<only> way to access scalar possrep or relation attributes is by using
normal accessor functions such as C<sys.std.Core.Scalar.attr>.  This
restriction is in place for practical reasons of Muldis D syntax being more
strongly typed, such that it is possible to know at parse-time whether each
attribute access is for a scalar or tuple or relation, and so both it is
easier to implement Muldis D and easier to understand at a glance what
Muldis D code is doing, even if the system catalog representation of the
code is a bit more verbose due to requiring more explicit function calls.

## Empty-String Names

Muldis D empowers users to give the entities they define any character
string at all for their declared names, including strings with
non-alphanumeric characters that some programming languages would consider
illegal in names/identifiers/symbols, and including the empty string, which
some languages don't support.  Besides the pragmatic advantage that such
very simple rules makes for simpler implementations, the empty string is
the most natural value for a string-like data type to use as its default
value, and is the most natural choice for what to name the implicit
"default" entity to be used in some context with respect to alternatives.
Given that Muldis D is intended to be used as an intermediate language when
translating between other languages, the empty string also seems a natural
choice for what to name some artifacts of Muldis D's representation of some
concepts which in other languages don't need to be named at all, so that an
arbitrary import from another language can bring in entities of any names
that the other language supports, and they won't clash with some extra
names that Muldis D might want to use in the same namespaces.

It turns out that Muldis D ascribes special meanings or semantics to
entities in many contexts when they have the empty string as their name,
and in fact requires some entities to have empty string names.  Each of
those meanings or semantics are described in this documentation section.

Within a depot mount federation, the empty string name is reserved for the
single depot mount that exists for the entire lifetime of an in-DBMS
process, which begins to exist as part of the process' startup and that
can't cease to exist except as part of the process' shutdown.  In a pure
Muldis D application, the depot corresponding to this mount would be what
contains the "main program" procedure; the in-DBMS process starts and ends
with the starting and ending of that procedure.  This is the case not only
for the main process but also any other processes in such an application;
if the other is a worker process, then the empty-name depot mount has the
procedure defining the work that said other process exists to perform.  In
a mixed-language application where another language has the main program,
and the lifetime of an in-DBMS process isn't controlled by the lifetime of
a Muldis D procedure's execution, then the empty-name depot mount may
simply be empty at process startup.

Iff a subpackage (or a package) directly contains a material (routine or
type) whose declared name is the empty string, then that entire subpackage
is considered to be a proxy for that material, as if the material had been
declared one level up in place of the subpackage, and so any syntax which
is valid for directly referencing the material may instead (and is
recommended to) directly reference its parent subpackage instead as if it
were the material itself.  So for example, if a material
C<fed.lib.mydb.foo.""> exists,
then C<fed.lib.mydb.foo> will implicitly refer to the same material in any
context that expects the name of a material.  This feature should be
immensely helpful in supporting encapsulation of materials, such that if
one wanted to change the implementation of a material to add support
materials, they can conceptually embed the latter into the former, by
actually replacing the original material with a subpackage holding the
components of the new version, keeping those from messing up the namespace
that the original lived in, and no external code has to know about this
implementation change of the material, and can keep referencing it in the
same way.  Note that this proxying feature I<will> cascade, such as when a
subpackage whose name is the empty string contains a material whose name is
the empty string; so for example, a material C<fed.lib.mydb.foo."".""> can
also be referenced by both C<fed.lib.mydb.foo>
and C<fed.lib.mydb.foo."">.  Note that this
proxying feature can I<not> be used to reference a subpackage or package
itself whose name is the empty string, for hopefully obvious reasons.

Iff a depot or subdepot has a self-local dbvar (specifically, iff the
former's C<fed.cat.mydb.data> is a C<Just>), then the
recommended convention is that the declared type of said dbvar is defined
by a type immediately contained in said depot/subdepot whose declared name
is the empty string.  (This also means that C<fed.lib.mydb> alone will
reference
the type of the depot's C<fed.data.mydb>, when the convention is followed.)

In a function definition, it is mandatory for the root node in the
expression node tree to have the empty string as its declared name.
Similarly, in a procedure definition, it is mandatory for the root node in
the statement node tree to have the empty string as its declared name.

## User Namespace Correspondence

The namespace hierarchies under the C<lib> and C<data> second-level
namespaces of C<fed|nlx> are fully independent in definition, such
that namespaces under C<lib> are defined in terms of child subdepots,
while namespaces under C<data> are defined in terms of tuple
(database) attributes that are themselves tuples (databases) rather than
relations.  However, in order for any given depot|subdepot to
optionally have its own concept of a (pseudo-)dbvar that is local to
itself, or for any (pseudo-)relvar to have the concept of its data type
definition being builtin to it,
these otherwise independent namespace hierarchies are constrained
to resemble each other to a certain degree, when the option to have a
self-local dbvar is exercised (a depot|subdepot can alternately
choose to I<not> have its own dbvar); that also serves to support DBMSs
that have a common namespace hierarchy for both routines and relvars.  This
section details that mutual constraint.

The 2 system-defined user-data variables named C<[fed|nlx].data>
are all of "just" the C<Database> type (which is a C<Tuple> proper
subtype), or are of its proper subtypes.

The C<fed.data> variable's type is determined primarily by the current
value of C<mnt.cat> (which depot mounts exist), and secondarily by the
contents of each mounted depot.  When a new DBMS process starts, there is
exactly one depot mount, whose mount name is the empty string,
and the type of C<fed.data> has either a single database-typed attribute
or zero attributes depending on whether or not the corresponding depot has
a self-local dbvar and C<fed.data>'s default value is determined by the
corresponding depot's default C<nlx.data> value or it is the zero-attribute
tuple/database; mounting a depot adds one corresponding
database-typed attribute to C<fed.data>'s type and value, iff the depot has
a self-local dbvar, and unmounting the depot removes its corresponding
attribute, iff likewise.  For each attribute of the type and value of
C<fed.data>, its type and value is equal to the type and value of the
C<nlx.data> variable seen by entities within the corresponding depot, iff
the depot has a self-local dbvar.

The C<nlx.data> variable's existence and type is determined by the catalog
of the same depot.  When a new depot is created, the default value of its
catalog defines zero types or routines, and defines that the depot does
I<not> have a self-local dbvar; this means by default the depot is just a
repository for code, able to contain only types and routines, and that
depot's C<nlx.data> doesn't exist at all.  Later on, if a depot's catalog
is updated to say that the depot I<does> have a self-local dbvar, which is
accomplished by setting that depot's C<nlx.cat.data> to a C<Just> value
that names the declared database type of that depot's C<nlx.data>;
typically said named type is a material also added to the depot's root
namespace, which typically has the empty string entity declaration name.

In most typical situations, a depot's catalog is updated
to say that the declared type of C<nlx.data> consists only of database
values having specific relation-valued attributes of specific relation
types, and database relations can not be added or removed without
also updating the corresponding database type.  Generally speaking, the
declared type of C<nlx.data> includes everything that SQL would define as
table definitions, table unique key constraints, subset (foreign key)
constraints, and generic database or table state constraints, but state
constraints can also be associated with just variables rather than types.

Conceptually speaking, for the ultimate freedom from constraints, the
declared type of C<nlx.data> can be a simple alias for the C<Database>
type, meaning that users can update C<nlx.data> (or more specifically, C<<
fed.data.<depot-mnt-nm> >>) with any C<Database> value at all, and
(where applicable) have it persist.  In this situation, adding a database
relation is done by extending the database with a new relation-valued
attribute, and removing one is removing its attribute.  But see further
below as, strictly speaking, some database values can't be in C<nlx.data>.

If a depot has any subdepots, then for each subdepot, iff the subdepot has
a self-local dbvar, that is iff the subdepot's C<nlx.cat.data> is a
C<Just>, then the value of C<fed.data.mydb> must have a corresponding
database-typed attribute that matches by name, recursively.  For example,
if a depot mounted as C<mydb> has a root-child subdepot named C<foo> and a
child subdepot of that named C<bar>, and C<bar> expects to have a
self-local dbvar, then the type of C<fed.data.mydb> must have a
database-typed attribute named C<foo> and the type of C<foo> must have a
database-typed attribute named C<bar>.  So then, C<fed.data.mydb.foo> is
the pseudo-dbvar of C<nlx.data> as seen by entities in the C<foo> subdepot
(and they have the same type and value), and C<fed.data.mydb.foo.bar> is
the pseudo-dbvar of C<nlx.data> as seen by entities in the C<bar> subdepot.
The type of C<fed.data.mydb> may have additional attributes besides those
matching subsepots, but it may not lack any corresponding ones with
subdepots that have self-local dbvars.

Now while subdepots in a depot optionally have corresponding
database-typed C<nlx.data> attributes, the opposite is true in regards to
routines and types in a depot; for those, there must I<not> be any
corresponding C<nlx.data> attributes, either database or relation-typed;
depot relvars effectively live in the same namespace hierarchy as types and
routines, and must not have the same fully-qualified names.

What is said above for the relationship between the catalog of a depot and
its C<nlx.data>, goes also for the catalog of a subdepot and
its C<nlx.data>, respectively.  Note that while a depot or
subdepot does not need to have a self-local dbvar in the general
case, if any subdepot wants to have a self-local dbvar, then all
of its direct ancestor namespaces must have one too, because a subdepot
dbvar is always a pseudo-variable defined as an attribute of its
parent depot or subdepot, recursively.

Strictly speaking, the type of a depot's or subdepot's self-local dbvar
can only be "just a database" (the C<Database> type) iff that depot has
no subdepots or materials at all.  Regarding any other child
materials, the type must exclude attributes with the same names.  When
there is a child subdepot C<foo>, the situation depends on
whether C<foo> has a self-local dbvar; if it does, then the parent's type
must have an attribute named C<foo> and that attribute must declare its
type to be the same type as the child subdepot's C<nlx.cat.data> names;
if it doesn't, then the parent's type must
exclude every database value with an attribute C<foo>.

Similar to the subdepot/dbvar duality, Muldis D also supports a
subdepot/relvar duality.  It is allowed for both a depot/subdepot C<foo> to
have a direct child subdepot named C<bar> and also for C<foo>'s self-local
dbvar to have a relation-typed direct child attribute named C<bar>.  In
that situation, C<bar> does I<not> have a self-local dbvar but the
namespace conveniently exists for a type definition to live for use as the
explicitly declared type of the C<bar> attribute, which by convention would
have the empty string as its name (but it isn't required to), and any
further components of that type definition can also be grouped under the
subdepot C<bar>.  So this arrangement is the closest analogy to SQL's
normal behaviour of embedding a table's type into the table's declaration.

## Referencing Data Types

Some data types are explicitly defined as their own distinct named
entities, for the purpose of reuse in multiple places, the same as
explicitly defined routines; these live directly in packages or subpackages
and typically can be directly invoked by
any other entity external to themselves.

Arguably most distinct data types, by contrast, are embedded into the
definitions of other entities like routines or variables or other types,
and are not typically intended to be used except within the context of
using those other entities.  For example, often types that are just defined
as subsets of other types will get embedded into the definitions of
relation types or variables that use them as their attributes' declared
types; or they are embedded into definitions of routine parameters.

To more easily interact with entities that embed the definitions of the
types used for their own external interfaces, which are types that don't
have externally visible names in the normal sense, Muldis D provides an
analogy to its terse pseudo-variable invocation syntax that lets you
directly reference the type used by an entity by way of that entity's
fully-qualified (context-sensitive) name.  To be specific, you take the
entity's name and then attach extra syntax indicating you want to use its
declared type, in the form of 2..3 extra prefixed name chain elements, plus
possibly 1 extra suffixed name chain element.

The extra syntax takes the form of a new primary namespace C<type>, which
has 1..2 special following namespaces, and then the rest of the namespaces
afterwards match the other/normal primary namespaces and what follow them,
but for 1 possible extra element following those.

The grammatically simplest scenario is taking the declared type of a
scalar variable or pseudo-variable, which takes the form C<<
type.var[.<path-elem-to-var>]**1..*[.<path-elem-to-attr>]**0..* >>, for
example C<type.var.nlx.myvar>.  A similar scenario is taking the declared
type of an attribute of a distinct type entity, which takes the form C<<
type.type[.<path-elem-to-type>]**1..*[.<path-elem-to-attr>]**1..* >>, for
example C<type.type.nlx.lib.mytyp.myattr>.  A similar scenario is taking
the declared result type of a function, which takes the form C<<
type.func_result[.<path-elem-to-func>]**1..*[.<path-elem-to-attr>]**0..*
>>, for example C<type.func_result.nlx.lib.myfunc>.

A slightly more complicated scenario is taking the declared type of a
routine parameter, which takes the form C<<
type.param[.<path-elem-to-rtn>]**1..*.<param-name>[.<path-elem-to-attr>]**0
..* >>, for example
C<type.param.sys.std.Core.Integer.whole_quotient.divisor>.

Another scenario is first taking the declared type of something where that
type is a relation type, and then taking the tuple type in terms of which
that relation type was directly partially defined.  And so, the
aforementioned forms of taking types actually have
C<[.[|dh_]tuple_from]**0..1> in their syntax following the
C<type> (or you add the C<type> if you didn't otherwise have one because
you were otherwise referring to a named type directly) and before the
aforementioned remainder; for example
C<type.tuple_from.var.nlx.data.myrelvar>
or C<type.tuple_from.nlx.lib.mytype>.

Muldis D also has an extension to the previously described "taking the
type" feature such that declaring any type, embedded or otherwise, also has
the effect of implicitly declaring simple nonscalar collection
types over that type; but these implicit extra types only appear when you
attempt to use them, in the form of adding yet another syntax element to
all of the aforementioned forms, which is
C<[.[|dh_][set|maybe|just|array|bag|[s|m]p_interval]_of]**0..*>;
this C<of> element takes the same position as the C<from> element in the
syntax, just after the C<type> (which likewise you add if you didn't
already have it); or they can both be used together in which case all the
C<of> would appear first.

This feature extension is intended mainly to save the language from a
proliferation of explicitly defined but very similar nonscalar
types; so rather than having to explicitly declare a type that is a
sequential array of integers (that is, an C<Array> whose C<value> attribute
has the type C<Int>), you can just use it implicitly by saying
C<type.array_of.sys.std.Core.Type.Int>, the same as you would use the
plain integer type by saying C<sys.std.Core.Type.Int>.  Or for the common
scenario of an attribute being optional (like SQL's nullable), you can say
for example C<type.maybe_of.sys.std.Core.Type.Text>.  This feature
extension lets you declare a simple collection of any type, including those
declared by the same feature, for example:
C<type.set_of.set_of.sys.std.Core.Type.Cat.Name>.

B<Update:>  Unlike with the terse pseudo-variable syntax in general use
(where it may only be used with tuple attributes), for the more specific
use of referencing data types, the terse syntax may I<also> be used with
scalar possrep and relation attributes, as described in **Terse
Pseudo-Variable Syntax**.

# SOURCE CODE METADATA

The Muldis D system catalog supports the storage of some explicit metadata
for Muldis D code, which is non-critical in that it has no impact on the
behaviour of the code, but that rather it would be important to a
programmer who wishes to have more control over the visual presentation of
their code, such that said code should be easier for programmers to read
and update when those presentation details are respected.

In this way, a programmer's code has an improved chance of surviving
unscathed in all the aspects that matter to them, when it is translated
between different programming languages by way of Muldis D, or between
multiple Muldis D formats.  At the very least, when code in any given
Muldis D dialect is first parsed into the system catalog, subsequent
generation of code in the same Muldis D dialect from that system catalog
should much more closely resemble the original in every possible manner.

Arguably, the two most important non-behavioural metadata to preserve are
code comments and code element ordinal positions.

## Code Comments

Many tuple and relation catalog data types have a special extra attribute
named C<scm_comment>, a C<Comment> (a character string), which may
optionally be used to associate an arbitrary piece of human-readable
descriptive text with a code element represented by a given tuple.  For
example, the C<Function> catalog type has it, meaning that a general
overview description of a function can be remembered and guide programmers
to understanding the function.

A C<scm_comment> value of the empty string is special and means "no
comment".  It is expected that any complete parser for a standard Muldis D
dialect I<will> preserve any code comments that it encounters as much as is
reasonably possible.

## Visible Element Order

Many fundamental parts of Muldis D will identify code elements by name,
rather than by ordinal position, or all they care about for behaviour's
sake is representing a set of elements, and the ordinal position of any of
these elements in the original source code is not considered significant,
and so any information about that in the natively ordered source code,
would normally be discarded by the parser.

Many tuple and relation catalog data types have a special extra attribute
named C<scm_vis_ord>, a C<NNInt> (non-negative integer), which may
optionally be used to encode the visible ordinal position of the code
element represented by a given tuple relative to its peers in the original
source code.  For example, the C<NameTypeMap> catalog type has it, meaning
that the declared order in a programmer's source code of a list of named
routine parameters, or of a list of named tuple-type attributes, can be
preserved in the system catalog, and be used to guide the presented order
of that list in source code generated from the system catalog.

A C<scm_vis_ord> value of zero is special and means "not applicable"; for
any code elements whose C<scm_vis_ord> are zero, this means that the
programmer doesn't consider it important to preserve their relative order;
only C<scm_vis_ord> values that are C<1> or greater are considered to be
"applicable" for being ordered.  Note that C<scm_vis_ord> is I<not> a key,
so multiple sibling code elements can have the same value, in which case
their relative ordering is implementation-defined or random, and also any
set of associated C<scm_vis_ord> is not dense, so sibling elements don't
need to have immediately consecutive values.

To clarify, it is expected that any complete parser for a standard Muldis D
dialect I<will> set context-distinct non-zero C<scm_vis_ord> values as much
as is reasonably possible, and that zero values will generally come from
either situations where a parser finds ordering non-applicable or from
programmers updating the system catalog at runtime.

# AUTHOR

Darren Duncan (C<darren@DarrenDuncan.net>)

# LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
