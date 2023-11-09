# NAME

Muldis::D::Dialect::PTMD_STD - How to format Plain Text Muldis D

# VERSION

This document is Muldis::D::Dialect::PTMD_STD version 0.148.1.

# PREFACE

This document is part of the Muldis D language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document
before you read this one, which provides subservient details.

# DESCRIPTION

This document outlines the grammar of the I<Plain Text Muldis D> standard
dialect named C<PTMD_STD>.  The fully-qualified name of this Muldis D
standard dialect is C<Muldis_D:"https://muldis.com":0.148.1:PTMD_STD>.

This dialect is designed to exactly match the Muldis D system catalog (the
possible representation of Muldis D code that is visible to or updateable
by Muldis D programs at runtime) as to what non-critical metadata it
explicitly stores; so code in the C<PTMD_STD> dialect should be
round-trippable with the system catalog with the result maintaining all the
details that were started with.  Since it matches the system catalog, this
dialect should be able to exactly represent all possible Muldis D base
language code (and probably all extensions too), rather than a subset of
it.  That said, the C<PTMD_STD> dialect does provide a choice of multiple
syntax options for writing Muldis D value literals and DBMS entity (eg type
and routine) declarations, so several very distinct C<PTMD_STD> code
artifacts may parse into the same system catalog entries.  There is even a
considerable level of abstraction in some cases, so that it is easier for
programmers to write and understand typical C<PTMD_STD> code, and so that
this code isn't absurdly verbose.

This dialect is designed to be as small as possible while meeting the above
criteria, and is designed such that a parser that handles all of this
dialect can be fairly small and simple.  Likewise, a code generator for
this dialect from the system catalog can be fairly small and simple.

A significant quality of the C<PTMD_STD> dialect is that it is designed to
work easily for a single-pass parser, or at least a single-pass lexer; all
the context that one needs to know for how to parse or lex any arbitrary
substring of code is provided by prior code, or any required lookahead is
just by a few characters in general.  Therefore, a C<PTMD_STD> parser can
easily work on a streaming input like a file-handle where you can't go back
earlier in the stream.  Often this means a parser can work with little RAM.

Also the dialect is designed that any amount of whitespace can be added or
omitted next to most non-alphanumeric characters (which happen to be next
to alphanumeric tokens) without that affecting the meaning of the code at
all, except obviously for within character string literals.  And long
binary or character or numeric or identifier strings can be split into
arbitrary-size substrings, without affecting the meaning.  And many
elements are identified by name rather than ordinal position, so to some
degree the order they appear has no effect on the meaning.  So programmers
can easily format (separate, indent, linewrap, order) code how they like,
and making an automated code reformatter shouldn't be difficult.  Often,
named elements can also be omitted entirely for brevity, in which case the
parser would use context to supply default values for those elements.
PTMD_STD has a I<linear syntax>.

Given that plain text is (more or less) universally unambiguously portable
between all general purpose languages that could be used to implement a
DBMS, it is expected that every single Muldis D implementation will
natively accept input in the C<PTMD_STD> dialect, which isn't dependent on
any specific host language and should be easy enough to process, so it
should be considered the safest official Muldis D dialect to write in by
default, when you don't have a specific reason to use some other dialect.

See also the dialects
[HDMD_Raku_STD](Muldis_Data_Language_Dialect_HDMD_Raku_STD) and
[HDMD_Perl_STD](Muldis_Data_Language_Dialect_HDMD_Perl_STD), which are derived
directly from C<PTMD_STD>, and represent possible Raku and Perl concrete
syntax trees for it; in fact, most of the details in common with those
other dialects are described just in the current file, for all 3 dialects.

# GENERAL STRUCTURE

A C<PTMD_STD> Muldis D code file consists just of a Muldis
D depot definition, which begins with a language name
declaration, and then has a C<Database> value literal defining the depot's
catalog, and finally has, optionally, a C<Database> value literal defining
the depot's data.  This is conceptually what a
C<PTMD_STD> file is, and it can even be that literally, but C<PTMD_STD>
provides a canonical further abstraction for defining the depot's catalog,
which should be used when doing
data-definition.  And so you typically use syntax resembling routine and
type declarations in a general purpose programming language, where simply
declaring such an entity will cause it to be part of the system catalog.
Fundamentally every Muldis D depot is akin to a code library, and a Muldis
D "main program" is nothing more than a depot having a procedure that is
designated to execute automatically after a mount event of its host depot.

As a special extension feature, a C<PTMD_STD> Muldis D code file may
alternately consist just of a (language-qualified) Muldis D value literal,
which mainly is intended for use in mixed-language environments as an
interchange format for data values between Muldis D and other languages.

The grammar in this file is formatted as a hybrid between various BNF
flavors and Raku rules (see <http://perlcabal.org/syn/S05.html> for
details on the latter) with further changes.  It is only meant to be
illustrative and human readable, and would need significant changes to
actually be a functional parser, which are different for each parser
toolkit.

The grammar consists mainly of named I<tokens> which define matching rules.
Loosely speaking, each parser match of a token corresponds to a capture
I<node> or node element in the concrete syntax tree resulting from the
parse; in practice, the parser may make various alterations to the match
when generating a node, such as adding guide keywords corresponding to the
token name, or by merging series of trivial tokens or doing escaped
character substitutions.  No explicit capture syntax such as parenthesis is
used in the grammar.

To help understand the grammar in this file, here are a few guidelines:  1.
The grammar is exactly the same as that of a Raku rule except where these
guidelines state otherwise; this includes that square brackets mean
grouping not optionality, and that when multiple sub-pattern alternatives
match, the one that is the longest wins.  2. The grammar portion that
actually declares a token, that is what associates a token name with its
definition body, is formatted like EBNF, as C<< <footok> ::= ... >> rather
than the Raku way like C<token footok { ... }> or C<rule footok { ... }>.
3. All non-quoted whitespace is not significant and just is formatting the
grammar itself; rather, whitespace rules in the grammar are spelled out
explicitly.  4. The meanings of any tokens with the same names as ones
built-in to Raku but that are explicitly defined in this grammar may have
different definitions.

The root grammar token for the entire dialect is C<Muldis_D>.

# START

Grammar:

    <Muldis_D> ::=
        ^ <ws>?
            <language_name> <ws>
            [<value> | <depot>]
        <ws>? $

A C<Muldis_D> node has 2 ordered elements where the first element is a
C<language_name> node and the second element is either a C<value> node or a
C<depot> node.

See the pod sections in this file named **LANGUAGE NAME**, **VALUE
LITERALS AND SELECTORS**, and **DEPOT SPECIFICATION**, for more details
about the aforementioned tokens/nodes.

When Muldis D is being compiled and invoked piecemeal, such as because the
Muldis D implementing virtual machine (VM) is attached to an interactive
user terminal, or the VM is embedded in a host language where code in the
host language invokes Muldis D code at various times, many C<value> may be
fed to the VM directly for inter-language exchange, and not every one
would then have its own C<language_name>.  Usually a C<language_name> would
be supplied to the Muldis D VM just once as a VM configuration step, which
provides a context for further interaction with the VM that just involves
Muldis D code that isn't itself qualified with a C<language_name>.

# LANGUAGE NAME

Grammar:

    <language_name> ::=
        <ln_base_name>
        <unspace> ':' <ln_base_authority>
        <unspace> ':' <ln_base_version_number>
        <unspace> ':' <ln_dialect>
        <unspace> ':' <ln_extensions>

    <ln_base_name> ::=
        Muldis_D

    <ln_base_authority> ::=
        <ln_elem_str>

    <ln_base_version_number> ::=
        <ln_elem_str>

    <ln_dialect> ::=
        PTMD_STD

    <ln_elem_str> ::=
        <nonquoted_ln_elem_str> | <quoted_ln_elem_str>

    <nonquoted_ln_elem_str> ::=
        <[ a..z A..Z 0..9 _ - \. ]>+

    <quoted_ln_elem_str> ::=
        '"'
            [<[\ ..~]-["]> | '\\"']+
        '"'

    <ln_extensions> ::=
        '{' <ws>?
            catalog_abstraction_level <ws>? '=>' <ws>? <cat_abstr_level>
            <ws>? ',' <ws>? op_char_repertoire <ws>? '=>' <ws>? <op_cr>
            [<ws>? ',' <ws>? standard_syntax_extensions
                <ws>? => <ws>? <std_syn_ext_list>]?
            [<ws>? ',']?
        <ws>? '}'

    <cat_abstr_level> ::=
          the_floor
        | code_as_data
        | plain_rtn_inv
        | rtn_inv_alt_syn

    <op_cr> ::=
        basic | extended

    <std_syn_ext_list> ::=
        '{' <ws>?
            [<std_syn_ext_list_item> ** [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'

    <std_syn_ext_list_item> ::=
        ''

I<Please interpret the C<''> under C<< <std_syn_ext_list_item> >> as a
placeholder and that there are currently zero valid list items.>

As per the VERSIONING pod section of [Muldis_Data_Language](Muldis_Data_Language.md), code written in Muldis D
must start by declaring the fully-qualified Muldis D language name it is
written in.  The C<PTMD_STD> dialect formats this name as a
C<language_name> node having 5 ordered elements:

* C<ln_base_name>

This is the Muldis D language base name; it is simply the bareword
character string C<Muldis_D>.

* C<ln_base_authority>

This is the base authority; it is a character string formatted as per a
specific-context C<Name> value literal, except that it must be nonempty and
it is expressly limited to using non-control characters in the ASCII
repertoire, and its nonquoted variant has fewer limitations than C<Name>'s;
it is typically the delimited character string C<https://muldis.com>.

* C<ln_base_version_number>

This is the base version number; it is a character string formatted as per
C<ln_base_authority>; it is typically a character string like C<0.148.1>.

* C<ln_dialect>

This is the dialect name; it is simply the bareword character string
C<PTMD_STD>.

* C<ln_extensions>

This is a set of chosen pragma/parser-config options, which is formatted
similarly to a C<Tuple> SCVL.  The only 2 mandatory pragmas are
C<catalog_abstraction_level> (see the **CATALOG ABSTRACTION LEVELS** pod
section) and C<op_char_repertoire> (see **OPERATOR CHARACTER REPERTOIRE**).
The only optional pragma is C<standard_syntax_extensions> (see the
**STANDARD SYNTAX EXTENSIONS** pod section).  Other pragmas may be added
later, which would likely be optional.

Examples:

    Muldis_D:"https://muldis.com":0.148.1:PTMD_STD:{
        catalog_abstraction_level => rtn_inv_alt_syn,
        op_char_repertoire => extended
    }

    Muldis_D:"https://muldis.com":0.148.1:PTMD_STD:{
        catalog_abstraction_level => rtn_inv_alt_syn,
        op_char_repertoire => extended,
        standard_syntax_extensions => {}
    }

# CATALOG ABSTRACTION LEVELS

The C<catalog_abstraction_level> pragma determines with a broad granularity
how large the effective Muldis D grammar is that a programmer may employ
with their Muldis D code.

The catalog abstraction level of some Muldis D code is a measure of how
much or how little that code would resemble the system catalog data that
the code would parse into.  The lower the abstraction level, the smaller
and simpler the used Muldis D grammar is and the more like data structure
literals it is; the higher the abstraction level, the larger and more
complicated the Muldis D grammar is and the more like
general-purpose-language typical code it is.

There are currently 4 specified catalog abstraction levels, which when
arranged from lowest to highest amount of abstraction, are: C<the_floor>,
C<code_as_data>, C<plain_rtn_inv>, C<rtn_inv_alt_syn>.  Every abstraction
level has a proper superset of the grammar of every other abstraction level
that is lower than itself, so for example any code that is valid
C<code_as_data> is also valid C<plain_rtn_inv>, and so on.

Choosing an abstraction level to write Muldis D code against is all a
matter of trade-offs, perhaps mainly between advantages for Muldis D
implementors and advantages for Muldis D users.  Lower levels have benefits
such as that it takes less programmer effort to create a Muldis D code
parser or generator that just has to support that level, and such a
parser/generator could be made more quickly and occupy a smallar resource
footprint.  On the other side, higher levels have benefits such that any
Muldis D code itself can be immensely more terse and readable (and
writable), as well as have a much stronger resemblence to typical
general-purpose programming languages, which also caries the benefit that a
lot more of a programmer's preconceptions about what they should be able to
write in a language is more likely to just work in Muldis D, and users can
adopt it with less re-training.  Essentially, lower abstraction levels are
more like machine code while higher levels are more like human language.
It may not need to be said that while a lower level may be for a Muldis D
implementer an easier thing to make run, it would conversely tend to be
more difficult for them to write a test suite for, being more verbose.

B<It should be emphasized that all catalog abstration levels are completely
expressive, and everything a user can do with one, they can do with the
others, and code is round-trippable between all of them without loss of
behaviour.  The choice is simply about the syntax to accomplish something.>

Specifying the C<catalog_abstraction_level> pragma in a C<language_name>
node is mandatory, since there is no obvious abstraction level to use
implicitly when one isn't specified.

## the_floor

When the C<catalog_abstraction_level> pragma is C<the_floor>, then the
following grammar definitions are in effect:

    <value> ::=
        <value__the_floor>

    <catalog> ::=
        <catalog__code_as_data>

    <expr> ::=
        <value__the_floor>

This abstraction level exists more as an academic exercise and is not
intended to actually be used.  It is meant to be analogous to those
academic programming languages whose main design goal, in addition to still
being programmatically complete, is to have the absolute smallest grammar
at all costs, also analogous to an extreme-RISC machine.  This level is
like C<code_as_data> except that it has the absolute minimum of value
literal syntaxes rather than all of them, essentially just having a single
node kind apiece to cover all scalars, tuples, relations.  This level is
also so minimal that many representation alternatives of the system catalog
itself are being ignored, such as the more concise alternatives the system
catalog itself provides to represent selectors of set/array/bag values or
any system-defined scalar types not in terms of possreps.

Examples:

    Muldis_D:"https://muldis.com":0.148.1:PTMD_STD:{
        catalog_abstraction_level => the_floor,
        op_char_repertoire => basic
    }
    List:[3,
        List:[
            List:[1,List:[102,111,111,100]],
            List:[1,List:[113,116,121]],
        ],
        List:[
            List:[
                List:[4,
                    List:[
                        List:[1,List:[115,121,115]],
                        List:[1,List:[115,116,100]],
                        List:[1,List:[67,111,114,101]],
                        List:[1,List:[84,121,112,101]],
                        List:[1,List:[84,101,120,116]],
                    ],
                    List:[1,List:[110,102,100,95,99,111,100,101,115]],
                    List:[2,
                        List:[List:[1,List:[]]],
                        List:[List:[1,List:[67,97,114,114,111,116,115]]]
                    ]
                ],
                100
            ],
            List:[
                List:[4,
                    List:[
                        List:[1,List:[115,121,115]],
                        List:[1,List:[115,116,100]],
                        List:[1,List:[67,111,114,101]],
                        List:[1,List:[84,121,112,101]],
                        List:[1,List:[84,101,120,116]],
                    ],
                    List:[1,List:[110,102,100,95,99,111,100,101,115]],
                    List:[2,
                        List:[List:[1,List:[]]],
                        List:[List:[1,List:[75,105,119,105,115]]]
                    ]
                ],
                30
            ]
        ]
    ]

## code_as_data

When the C<catalog_abstraction_level> pragma is C<code_as_data>, then the
following grammar definitions are in effect:

    <value> ::=
        <value__code_as_data>

    <catalog> ::=
        <catalog__code_as_data>

    <expr> ::=
        <value__code_as_data>

This abstraction level is the best one for when you want to write code in
exactly the same form as it would take in the system catalog, and at the
same time use all the relatively consise alternatives the system catalog
itself provides for value literals and selectors.  With this abstraction
level, a depot consists simply of a language name plus one or two database
value literals.  The format for specifying a system catalog is exactly the
same as the format for specifying the user data of a database.  All a
Muldis D parser/generator has to know is how to parse static Muldis D value
literals and its done.  That said, C<code_as_data> includes all of the
special grammar dealing with value literals, including those for many
specific scalar or nonscalar types.  This level is analogous to a
high-level assembly language in a way; what you say in code is exactly what
you get in the system catalog, but your code would be too verbose for the
tastes of someone preferring normal high-level language code.

Code written to the C<code_as_data> level can employ all of the language
grammar constructs described in these main pod sections: **VALUE LITERALS
AND SELECTORS**, **OPAQUE VALUE LITERALS**, **COLLECTION VALUE SELECTORS**.

Examples:

    Muldis_D:"https://muldis.com":0.148.1:PTMD_STD:{
        catalog_abstraction_level => code_as_data,
        op_char_repertoire => basic
    }
    @:{
        { food => 'Carrots', qty => 100 },
        { food => 'Kiwis', qty => 30 }
    }

    Muldis_D:"https://muldis.com":0.148.1:PTMD_STD:{
       catalog_abstraction_level => code_as_data,
       op_char_repertoire => basic
    }
    depot-catalog Database:Depot:{
       functions => @:{
          {
             name => Name:cube,
             material => %:Function:{
                result_type => PNSQNameChain:Int,
                params => @:NameTypeMap:{
                   { name => Name:topic, type => PNSQNameChain:Int }
                },
                expr => Database:ExprNodeSet:{
                   sca_val_exprs => @:{
                      { name => Name:INT_3, value => 3 }
                   },
                   func_invo_exprs => @:{
                      {
                         name => Name:"",
                         function => PNSQNameChain:Integer.power,
                         args => @:NameExprMap:{
                            { name => Name:radix, expr => Name:topic },
                            { name => Name:exponent, expr => Name:INT_3 }
                         }
                      }
                   }
                }
             }
          }
       }
    }

## plain_rtn_inv

When the C<catalog_abstraction_level> pragma is C<plain_rtn_inv>, then the
following grammar definitions are in effect:

    <value> ::=
        <value__code_as_data>

    <catalog> ::=
        <catalog__plain_rtn_inv>

    <expr> ::=
        <expr__plain_rtn_inv>

    <update_stmt> ::=
        <update_stmt__plain_rtn_inv>

    <proc_stmt> ::=
        <proc_stmt__plain_rtn_inv>

This abstraction level is the lowest one that can be recommended for
general use, and every Muldis D implementation that is expected to be
directly used by programmers (in contrast to its main use just being by way
of wrapper APIs or code generators) should support at least this level,
even if that implementation is being touted as "minimal".  This abstraction
level has the simplest grammar that could reasonably be considered as like
that of a general purpose programming language.  Unlike the C<code_as_data>
level, the C<plain_rtn_inv> level makes everything that isn't conceptually
a value literal or selector look like typical routine or type declarations
or value expressions or statements, just as programmers typically expect.

One of Muldis D's primary features is that, as much as possible, the
system-defined language features are defined in terms of ordinary types and
routines.  This means for one thing that users are empowered to create
their own types and routines with all of the capabilities, flexibility, and
syntax as the language's built-in features have.  This also means that it
should be relatively simple to parse Muldis D code because the vast
majority of language features don't have their own special syntax to
account for, and the **Generic Function Invocation Expressions** syntax
covers most of them, in terms of the common prefix/polish notation that in
practice most invocations of user-defined routines are formatted as anyway.

The C<plain_rtn_inv> abstraction level is all about having code that looks
like general purpose programming language code but that everything looks
like user-defined routines and types.  The code is mostly just nested
invocations of functions or procedures in basic polish notation, and both
that code and material declarations have a C-language-like syntax.

It is expected that every Muldis D implementation which supports at least
the C<plain_rtn_inv> level will, as much as is reasonably possible,
preserve all non-behaviour-affecting metadata that is directly supported
for storage by the system catalog itself, as described in
[Muldis_Data_Language_Basics](Muldis_Data_Language_Basics.md) section **SOURCE CODE METADATA**.  Primarily this means preserving
non-value code comments, and preserving the declared relative ordinal
position of code elements.

Code written to the C<plain_rtn_inv> level can employ all of the language
grammar constructs that C<code_as_data> can, plus all of those
described in these main pod sections: **MATERIAL SPECIFICATION**,
**GENERIC VALUE EXPRESSIONS**, **GENERIC PROCEDURE STATEMENTS**.

Examples:

    Muldis_D:"https://muldis.com":0.148.1:PTMD_STD:{
        catalog_abstraction_level => plain_rtn_inv,
        op_char_repertoire => basic
    }
    depot-catalog {
        function cube (Int <-- topic : Int) {
            Integer.power( radix => topic, exponent => 3 )
        }
    }

## DEPRECATED - rtn_inv_alt_syn

B<The C<rtn_inv_alt_syn> catalog abstraction level as it currently exists
is deprecated and will disappear in the near future.  Other pending
enhancements to the language in both the system catalog itself and in the
C<plain_rtn_inv> level will make the latter more capable and suitable by
itself for normal use.  A new highest level or 3 will probably appear in
place of C<rtn_inv_alt_syn> later for their still-unique useful features.>

When the C<catalog_abstraction_level> pragma is C<rtn_inv_alt_syn>, then
the following grammar definitions are in effect:

    <value> ::=
        <value__code_as_data>

    <catalog> ::=
        <catalog__plain_rtn_inv>

    <expr> ::=
        <expr__rtn_inv_alt_syn>

    <update_stmt> ::=
        <update_stmt__rtn_inv_alt_syn>

    <proc_stmt> ::=
        <proc_stmt__rtn_inv_alt_syn>

This abstraction level is the highest one and is the most recommended one
for general use, assuming that all the Muldis D implementations you want to
use support it.  The expectation is that, in general, minimal Muldis D
implementations won't support it but non-minimal ones would, so code
written to it may not be the most universally portable as-is but should be
portable in most common environments.

In practice a huge payoff of improved user code brevity and readability
(and writability) is gained by the C<rtn_inv_alt_syn> abstraction level
over the C<plain_rtn_inv> level by adding special syntax for a lot of
commonly used built-in routines, such as infix syntax for common math
operators or postcircumfix syntax for attribute accessors.  The tradeoff
for this user code brevity is a significant amount of extra complexity in
parsers, due to all the extra special cases, though this complexity can be
mitigated somewhat by standardizing these additions in format where
possible.  These 2 highest levels both look like a general purpose
programming language, but C<rtn_inv_alt_syn> is a lot more concise.

In particular, C<rtn_inv_alt_syn> is probably the I<only> Muldis D dialect
that conceivably can match or beat the conciseness of a majority of general
purpose programming languages, and would probably be the most preferred
abstraction level for developers.  This fact would also help to drive a
majority of implementations to support this greatest complexity level.  And
even then, this most complex of standard Muldis D grammars still generally
has simpler grammar rules than a lot of general languages, even if this
difference is more subtle.  It certainly is simpler and more easier to
parse grammar than SQL in its general case.

Code written to the C<rtn_inv_alt_syn> level can employ all of the language
grammar constructs that C<plain_rtn_inv> can, plus all of those described
in these main pod sections: **DEPRECATED - FUNCTION INVOCATION ALTERNATE SYNTAX
EXPRESSIONS**, **DEPRECATED - PROCEDURE INVOCATION ALTERNATE SYNTAX STATEMENTS**.

Examples:

    Muldis_D:"https://muldis.com":0.148.1:PTMD_STD:{
        catalog_abstraction_level => rtn_inv_alt_syn,
        op_char_repertoire => basic
    }
    depot-catalog {
        function cube (Int <-- topic : Int) {
            topic exp 3
        }
    }

# OPERATOR CHARACTER REPERTOIRE

The C<op_char_repertoire> pragma determines primarily whether or not the
various routine invocation alternate syntaxes, herein called I<operators>,
may be composed of only ASCII characters or also other Unicode characters,
and this pragma determines secondarily whether or not a few special value
literals (effectively nullary operators) composed of non-ASCII Unicode
characters may exist.

The pragma also determines whether or not any nonquoted DBMS entity names
in the general case may contain non-ASCII Unicode alphanumeric characters.
I<TODO:  Consider renaming this pragma.>

There are currently 2 specified operator character repertoires: C<basic>,
C<extended>.  The latter is a proper superset of the former.

The C<op_char_repertoire> pragma is generally orthogonal to the
C<catalog_abstraction_level> pragma, so you can combine any value of the
latter with any value of the former.  However, in practice the operator
character repertoire setting will have no effect at all when the catalog
abstraction level is C<the_floor>, and it will otherwise have very little
effect except when the catalog abstraction level is C<rtn_inv_alt_syn>.  To
be specific, what the C<op_char_repertoire> pragma primarily affects is
special operator call syntaxes provided only by C<rtn_inv_alt_syn>, and
what the former secondarily affects is special value literals provided by
C<code_as_data> plus greater catalog abstraction levels.

Specifying the C<op_char_repertoire> pragma in a C<language_name> node is
mandatory, since there is no obviously best setting to use implicitly when
one isn't specified.

## basic

The C<basic> operator character repertoire is the smallest one, and it only
supports writing the proper subset of defined operator invocations and
special value literals that are composed of just 7-bit ASCII characters.
This repertoire can be recommended for general use, especially since code
written to it should be the most universally portable as-is (with respect
to operator character repertoires), including full support even by minimal
Muldis D implementations and older text editors.

When the C<op_char_repertoire> pragma is C<basic>, then the
following grammar definitions are in effect:

    <Singleton_payload> ::=
        <Singleton_payload__op_cr_basic>

    <Bool_payload> ::=
        <Bool_payload__op_cr_basic>

    <nonquoted_name_str> ::=
        <nonquoted_name_str__op_cr_basic>

    <maybe_Nothing> ::=
        <maybe_Nothing__op_cr_basic>

    <comm_infix_reduce_op> ::=
        <comm_infix_reduce_op__op_cr_basic>

    <sym_dyadic_infix_op> ::=
        <sym_dyadic_infix_op__op_cr_basic>

    <nonsym_dyadic_infix_op> ::=
        <nonsym_dyadic_infix_op__op_cr_basic>

    <monadic_prefix_op> ::=
        <monadic_prefix_op__op_cr_basic>

    <proc_nonsym_dyadic_infix_op> ::=
        <proc_nonsym_dyadic_infix_op__op_cr_basic>

## extended

The C<extended> operator character repertoire is the largest one, and it
supports the entire set of defined operator invocations and special value
literals, many of which are composed of Unicode characters outside the
7-bit ASCII repertoire.  This is the most recommended repertoire for
general use, assuming that all the Muldis D implementations and source code
text editors you want to use support it.  The expectation is that, in
general, minimal Muldis D implementations and older text editors won't
support it but non-minimal ones would, so code written to it may not be the
most universally portable as-is but should be portable in most common and
modern environments.

In practice the main payoff of C<extended> is that user code can exploit
the wide range of symbols that Unicode provides which are the canonical
means of writing various math or logic or relational et al operators in the
wider world, and which programmers would likely have written with all along
if it weren't for the large limitations of legacy computer systems which
practically forced them to use various approximations instead.  While you
can always write with ASCII approximations, using C<extended> means you
often don't have to, and your code can be a lot more readable as a result,
at least to the practitioners of the domains that the symbols come from,
and the code is otherwise more terse and arguably appears more attractive.

When the C<op_char_repertoire> pragma is C<extended>, then the
following grammar definitions are in effect:

    <Singleton_payload> ::=
        <Singleton_payload__op_cr_extended>

    <Bool_payload> ::=
        <Bool_payload__op_cr_extended>

    <nonquoted_name_str> ::=
        <nonquoted_name_str__op_cr_extended>

    <maybe_Nothing> ::=
        <maybe_Nothing__op_cr_extended>

    <comm_infix_reduce_op> ::=
        <comm_infix_reduce_op__op_cr_extended>

    <sym_dyadic_infix_op> ::=
        <sym_dyadic_infix_op__op_cr_extended>

    <nonsym_dyadic_infix_op> ::=
        <nonsym_dyadic_infix_op__op_cr_extended>

    <monadic_prefix_op> ::=
        <monadic_prefix_op__op_cr_extended>

    <proc_nonsym_dyadic_infix_op> ::=
        <proc_nonsym_dyadic_infix_op__op_cr_extended>

# STANDARD SYNTAX EXTENSIONS

The C<standard_syntax_extensions> pragma declares which optional portions
of the Muldis D grammar a programmer may employ with their Muldis D code.

There are currently no specified standard syntax extensions.
These are all mutually independent and any or all may be used at once.

While each I<standard syntax extension> is closely related to a I<Muldis D
language extension>, you can use the latter's types and routines without
declaring the former; you only declare you are using a I<standard syntax
extension> if you want the Muldis D parser to recognize special syntax
specific to those types and routines, and otherwise you just use them using
the generic syntax provided for all types and routines.

The C<standard_syntax_extensions> pragma is generally orthogonal to the
C<catalog_abstraction_level> pragma, so you can combine any value of the
latter with any value-list of the former.  However, in practice all
standard syntax extensions will have no effect when the catalog abstraction
level is C<the_floor>, and some of their features may only take effect when
the catalog abstraction level is C<rtn_inv_alt_syn>, as is appropriate.

Specifying the C<standard_syntax_extensions> pragma in a C<language_name>
node is optional, and when omitted it defaults to the empty set, meaning no
extensions may be used.

# VALUE LITERALS AND SELECTORS

Grammar:

    <value__the_floor> ::=
          <Int>
        | <List>

    <value__code_as_data> ::=
          <opaque_value_literal>
        | <coll_value_selector>

    <opaque_value_literal> ::=
          <Singleton>
        | <Bool>
        | <Order>
        | <RoundMeth>
        | <Int>
        | <Rat>
        | <Blob>
        | <Text>
        | <Name>
        | <NameChain>
        | <PNSQNameChain>
        | <RatRoundRule>

    <coll_value_selector> ::=
          <Scalar>
        | <Tuple>
        | <Database>
        | <Relation>
        | <Set>
        | <Maybe>
        | <Array>
        | <Bag>
        | <SPInterval>
        | <MPInterval>
        | <List>

A C<value> node is a Muldis D value literal, which is a common special case
of a Muldis D value selector.

Unlike value selectors in general, which must be composed beneath a
C<depot> because they actually represent a Muldis D value expression tree
of a routine or type definition, a C<value>
node does I<not> represent an expression tree, but rather a value constant;
by definition, a C<value> can be completely evaluated at compile time.  A
C<Muldis_D> node with a C<value> second element is hence just a serialized
Muldis D value.

The PTMD_STD grammar subsection for value literals (having the root
grammar token C<value>) is completely self-defined and can be used in
isolation from the wider grammar as a Muldis D sub-language; for example, a
hosted-data Muldis D implementation may have an object representing a
Muldis D value, which is initialized using code written in that
sub-language.

Every grammar token, and corresponding capture node, representing a Muldis
D value literal is similarly formatted and has 1-3 elements; the following
pod section **Value Literal Common Elements** describes the similarities
once for all of them, in terms of an alternate C<value> token definition
which is called C<x_value>.  And then the other pod sections specific to
each kind of value literal then just focus on describing their unique
aspects, namely their I<payloads>.

An C<opaque_value_literal> node represents a conceptually opaque Muldis D
value, such that every one of these values is defined with its own literal
syntax that is compact and doesn't look like a collection of other nodes;
this includes the basic numeric and string literals.

A C<coll_value_selector> node represents a conceptually transparent Muldis
D value, such that every one of these values is defined visibly in terms of
a collection of other nodes; this includes the basic tuple and relation
selectors.

## Value Literal Common Elements

A I<generic context value literal> (or I<GCVL>) is a value literal that can
be properly interpreted in a context that is expecting I<a> value but has
no expectation that said value belongs to a specific data type; in the
general case, a GCVL includes explicit I<value kind> metadata (such as,
"this is an C<Int>" or "this is a C<Name>"); but with a few specific data
types (see the C<value_kind> node description for details) that metadata
may be omitted for brevity because the main literal has mutually uniquely
identifying characteristics.  For example, each element of a generic Muldis
D collection value, such as a member of an array or tuple, could
potentially have any type at all.  In contrast, a I<specific context value
literal> (or I<SCVL>) is a value literal that does not include explicit
value kind metadata, even when the main literal doesn't have uniquely
identifying characteristics, because the context of its use supplies said
metadata.  For example, in a tuple value literal it is assumed that a
value literal in an attribute name position must denote a C<Name>.  The
grammar token C<value>|C<x_value> denotes a GCVL, as do most short-named
grammar tokens, like C<Int> or C<Name>; in contrast, a grammar token
containing C<value_payload> denotes a SCVL, like C<Int_payload> or
C<Name_payload>.

Every GCVL has 1-3 elements, illustrated by this grammar:

    <x_value> ::=
        [
            <value_kind> ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <value_payload>

    <value_kind> ::=
          Singleton
        | Bool
        | Order
        | RoundMeth
        | Int | NNInt | PInt
        | Rat | NNRat | PRat
        | Blob | OctetBlob
        | Text
        | Name
        | NameChain
        | PNSQNameChain
        | RatRoundRule
        | DH? Scalar | '$'
        | DH? Tuple | '%'
        | Database
        | DH? Relation | '@'
        | DH? Set
        | DH? [Maybe | Just]
        | DH? Array
        | DH? Bag
        | DH? SPInterval
        | DH? MPInterval
        | List

    <type_name> ::=
        <PNSQNameChain_payload>

    <value_payload> ::=
          <Singleton_payload>
        | <Bool_payload>
        | <Order_payload>
        | <RoundMeth_payload>
        | <Int_payload>
        | <Rat_payload>
        | <Blob_payload>
        | <Text_payload>
        | <Name_payload>
        | <NameChain_payload>
        | <PNSQNameChain_payload>
        | <RatRoundRule_payload>
        | <Scalar_payload>
        | <Tuple_payload>
        | <Database_payload>
        | <Relation_payload>
        | <Set_payload>
        | <Maybe_payload>
        | <Array_payload>
        | <Bag_payload>
        | <SPInterval_payload>
        | <MPInterval_payload>
        | <List_payload>

So a C<x_value>|C<value> node has 1-3 elements in general:

* C<value_kind>

This is a character string of the format C<< <[A..Z]> <[ a..z A..Z ]>+ >>;
it identifies the data type of the value literal in broad terms and is the
only external metadata of C<value_payload> generally necessary to
interpret the latter; what grammars are valid for C<value_payload> depend
just on C<value_kind>.

For all values of just the 10 data types [C<Singleton>, C<Bool>, C<Order>,
C<RoundMeth>, C<Int>, C<Rat>, C<Blob>, C<Text>, C<Set>,
C<Array>], the C<value_kind> portion of a GCVL may be omitted for brevity,
but the code parser should still be able to infer it easily by examining
the first few characters of the C<value_payload>, which for each of said 11
data types has a mutually uniquely identifying format, which is also
distinct from all possible C<value_kind>.  Note that, for the purposes of
this discussion, the C<Maybe> type is subsumed into the C<Set> type.

For many values of the 3 data types [C<Bag>, C<[S|M]PInterval>], the
C<value_kind> portion of a GCVL may be omitted for brevity; specifically,
this may be done just for the [C<Bag>, C<[S|M]PInterval>] GCVL whose
C<value_payload> are not valid C<value_payload> of a C<Set> GCVL.  For a
C<Bag> GCVL, all of those formatted as C<< => >> separated pairs may have
their C<value_kind> omitted, while all of those that are not formatted as
pairs may not.  For a C<SPInterval> GCVL, all of those that are formatted
as a range pair with C<..>/etc may have their C<value_kind> omitted, while
all of those formatted using the single value shorthand with no C<..>/etc
may not.  For a C<MPInterval> GCVL, all of those that are formatted as a
comma-delimited list with at least 2 list elements, where at least one of
those elements is formatted as a range pair with C<..>/etc, may have their
C<value_kind> omitted, while all of those either having 0..1 list elements
or having just single value shorthand elements with no C<..>/etc may not.

Note that omission of C<value_kind> is only allowed when the GCVL doesn't
include a C<type_name> element.

For just these certain special values of other data types, the same option
of omitting the C<value_kind> (and C<type_name>) applies: C<Tuple:D0>,
C<Relation:D0C0>, C<Relation:D0C1>.

* C<type_name>

This is a Muldis D data type name, for example C<sys.std.Core.Type.Int>; it
identifies a specific subtype of the generic type denoted by C<value_kind>,
and serves as an assertion that the Muldis D value denoted by
C<value_payload> is a member of the named subtype.  Iff C<value_kind> is
C<[|DH]Scalar> then C<type_name> is mandatory; otherwise, C<type_name> is
optional for all C<value>, except that C<type_name> must be omitted when
C<value_kind> is one of the 3 [C<Singleton>, C<Bool>, C<Order>]; this isn't
because those 3 types can't be subtyped, but because in practice doing so
isn't useful.

How a Muldis D parser treats a C<value> node with a C<type_name> element
depends on the wider context.  In the general case where the C<value> is an
C<expr> beneath the context of a C<depot> node, the
C<value> is treated as if it had an extra parent C<func_invo> node
that invokes the C<treated> function and whose 2 argument nodes are as
follows: C<topic> gets the C<value> without the C<type_name> element, and
C<as> gets the C<type_name> element.  This means that in general the
C<type_name> assertion is done at runtime.  In the common special case
where both C<value> is an C<opaque_value_literal> and C<type_name> refers
to a system-defined type, then the C<type_name> assertion is done at
compile time, and then the C<type_name> element is simply eliminated, so
the C<value> ends up simply as itself with no new C<func_invo> parent.

In another common special case, iff a C<value> node with a C<type_name>
element is a C<coll_value_selector> and its C<type_name> names a
system-defined tuple type or relation type with a specified set of
attributes, then the parser will automatically generate any missing
attribute values of the C<value> node, where each has the default value of
its declared type as per C<type_name>.  This will be done prior to the
other use of C<type_name> which applies a constraint, so the latter acts as
if the original code had specified the missing attributes.  In the case of
the type being a relation type, the relation value literal doesn't even
need to be well-formed (have the attributes per tuple) in the code, as the
attribute generation is done per tuple.  Since it only works for
system-defined types, this special case is primarily useful for code
involving values that represent code.

* C<value_payload>

This is mandatory for all C<value>.

For GCVL and SCVL examples, see the subsequent documentation sections.

# OPAQUE VALUE LITERALS

See also the definition of the catalog data type
C<sys.std.Core.Type.Cat.SysScaValExprNodeSet>, a tuple of which is what
every kind of C<opaque_value_literal> node distills to when it is beneath
the context of a C<depot> node, as it describes some semantics.

## Singleton Literals

Grammar:

    <Singleton> ::=
        [Singleton ':' <unspace>]?
        <Singleton_payload>

    <Singleton_payload__op_cr_basic> ::=
        '-Inf' | Inf

    <Singleton_payload__op_cr_extended> ::=
          <Singleton_payload__op_cr_basic>
        | '-∞' | '∞'

A C<Singleton> node represents a value of any of the singleton scalar types
that C<sys.std.Core.Type.Cat.Singleton> is a union over.

Some of the keywords are aliases for each other:

    keyword | aliases
    --------+--------
    -Inf    | -∞
    Inf     | ∞

These are the singleton types corresponding to the keywords:

    -Inf -> sys.std.Core.Type.Cat."-Inf"
    Inf  -> sys.std.Core.Type.Cat.Inf

Examples:

    Singleton:-Inf

    ∞

## Boolean Literals

Grammar:

    <Bool> ::=
        [Bool ':' <unspace>]?
        <Bool_payload>

    <Bool_payload__op_cr_basic> ::=
        False | True

    <Bool_payload__op_cr_extended> ::=
          <Bool_payload__op_cr_basic>
        | ⊥ | ⊤

A C<Bool> node represents a logical boolean value.  It is interpreted as a
Muldis D C<sys.std.Core.Type.Bool> value as follows:  The C<Bool_payload>
is a bareword character string formatted as per a C<Name> SCVL, and it maps
directly to the matching unqualified declared name of one of the C<Bool.*>
singleton types that the C<Bool> type is defined as a union over.

Some of the keywords are aliases for each other:

    keyword | aliases
    --------+--------
    False   | ⊥
    True    | ⊤

Examples:

    Bool:True

    False

    ⊤

    ⊥

## Order-Determination Literals

Grammar:

    <Order> ::=
        [Order ':' <unspace>]?
        <Order_payload>

    <Order_payload> ::=
        Less | Same | More

An C<Order> node represents an order-determination.  It is interpreted as a
Muldis D C<sys.std.Core.Type.Cat.Order> value as follows:  The
C<Order_payload> is a bareword character string formatted as per a C<Name>
SCVL, and it maps directly to the matching unqualified declared name of one
of the C<Order.*>
singleton types that the C<Order> type is defined as a union over.

Examples:

    Order:Same

    More

## Rounding Method Literals

Grammar:

    <RoundMeth> ::=
        [
            RoundMeth ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <RoundMeth_payload>

    <RoundMeth_payload> ::=
          Down | Up | ToZero | ToInf
        | HalfDown | HalfUp | HalfToZero | HalfToInf
        | HalfEven

A C<RoundMeth> node represents a rounding method.  It is
interpreted as a Muldis D C<sys.std.Core.Type.Cat.RoundMeth> value as
follows:  The C<RoundMeth_payload> is a bareword character string
formatted as per a C<Name> SCVL, and it maps directly to the matching
unqualified declared name of one of the C<RoundMeth.*>
singleton types that the C<RoundMeth> type is defined as a union over.

Examples:

    RoundMeth:HalfUp

    ToZero

## General Purpose Integer Numeric Literals

Grammar:

    <Int> ::=
        [
            [Int | NNInt | PInt] ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <Int_payload>

    <Int_payload> ::=
          <num_max_col_val> '#' <unspace> <int_body>
        | <num_radix_mark> <unspace> <int_body>
        | <d_int_body>

    <num_max_col_val> ::=
        <pint_head>

    <num_radix_mark> ::=
        0<[bodx]>

    <int_body> ::=
        0 | '-'?<pint_body>

    <nnint_body> ::=
        0 | <pint_body>

    <pint_body> ::=
        <pint_head> <pint_tail>?

    <pint_head> ::=
        <[ 1..9 A..Z a..z ]>

    <pint_tail> ::=
        [[_?<[ 0..9 A..Z a..z ]>+]+] ** <splitter>

    <d_int_body> ::=
        0 | '-'?<d_pint_body>

    <d_nnint_body> ::=
        0 | <d_pint_body>

    <d_pint_body> ::=
        <d_pint_head> <d_pint_tail>?

    <d_pint_head> ::=
        <[ 1..9 ]>

    <d_pint_tail> ::=
        [[_?<[ 0..9 ]>+]+] ** <splitter>

An C<Int> node represents an integer numeric value.  It is interpreted as a
Muldis D C<sys.std.Core.Type.Int> value as follows:

If the C<Int_payload> is composed of a C<num_max_col_val> plus C<int_body>,
then the C<int_body> is interpreted as a base-I<N> integer where I<N> might
be between 2 and 36, and the C<num_max_col_val> says which possible value
of I<N> to use.  Assuming all C<int_body> column values are between zero
and I<N>-minus-one, the C<num_max_col_val> contains that I<N>-minus-one.
So to specify, eg, bases [2,8,10,16], use C<num_max_col_val> of [1,7,9,F].

Using a C<num_radix_mark> is a recommended alternative for using a
C<num_max_col_val> when the former can be used, which is when the
C<num_max_col_val> would be one of [1,7,9,F]; in those cases, [0b,0o,0d,0x]
correspond respectively, and the rules for the C<int_body> are the same.

If the C<Int_payload> is a C<d_int_body>, then it is interpreted as a base
10 integer.

Fundamentally the I<body> part of an C<Int> node consists of a string of
digits and plain uppercased or lowercased letters, where each digit
(C<0..9>) represents its own number and each letter (C<A..Z>) represents a
number in [10..35].  A I<body> may optionally contain underscore characters
(C<_>), which exist just to help with visual formatting, such as for
C<10_000_000>, and these are ignored/stripped by the parser.  A I<body> may
optionally be split into 1..N segments where each pair of consecutive
segments is separated by a I<splitter> token, which is a
pair of backslashes (C<\>) surrounding
a run of whitespace; this segmenting ability is provided to
support code that contains very long numeric literals while still being
well formatted (no extra long lines); the I<splitter> tokens are also
ignored/stripped by the parser, and the I<body> is interpreted as if all
its alphanumeric characters were contiguous.

If the C<value_kind> of a C<value> node is C<NNInt> or C<PInt> rather than
C<Int>, then the C<value> node is interpreted simply as an C<Int> node
whose C<type_name> is C<NNInt> or C<PInt>, and the allowed I<body> is
appropriately further restricted.

Examples:

    Int:0b11001001 #`binary`#

    0o0 #`octal`#

    0o644 #`octal`#

    -34 #`decimal`#

    42 #`decimal`#

    0xDEADBEEF #`hexadecimal`#

    Z#-HELLOWORLD #`base-36`#

    3#301 #`base-4`#

    B#A09B #`base-12`#

## General Purpose Rational Numeric Literals

Grammar:

    <Rat> ::=
        [
            [Rat | NNRat | PRat] ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <Rat_payload>

    <Rat_payload> ::=
          <num_max_col_val> '#' <unspace> <rat_body>
        | <num_radix_mark> <unspace> <rat_body>
        | <d_rat_body>

    <rat_body> ::=
          <int_body> <unspace> '.' <pint_tail>
        | <int_body> <unspace> '/' <pint_body>
        | <int_body> <unspace> '*' <pint_body> <unspace> '^' <int_body>

    <d_rat_body> ::=
          <d_int_body> <unspace> '.' <d_pint_tail>
        | <d_int_body> <unspace> '/' <d_pint_body>
        | <d_int_body> <unspace> '*' <d_pint_body>
            <unspace> '^' <d_int_body>

A C<Rat> node represents a rational numeric value.  It is interpreted as a
Muldis D C<sys.std.Core.Type.Rat> value as follows:

Fundamentally a C<Rat> node is formatted and interpreted like an C<Int>
node, and any similarities won't be repeated here.  The differences of
interpreting a C<Rat_payload> being composed of a C<num_max_col_val>
or C<num_radix_mark> plus
C<rat_body> versus the C<Rat_payload> being a C<d_rat_body> are as per the
corresponding differences of interpreting an C<Int_payload>.  Also
interpreting a C<NNRat> or C<PRat> is as per a C<NNInt> or C<PInt>.

If the I<body> part of a C<Rat> node contains a radix point (C<.>), then it
is interpreted as is usual for a programming language with such a literal.

If the I<body> part of a C<Rat> node contains a solidus (C</>), then the
rational's value is interpreted as the leading integer (a numerator)
divided by the trailing positive integer (a denominator); that is, the two
integers collectively map to the C<ratio> possrep of the C<Rat> type.

If the I<body> part of a C<Rat> node contains a asterisk (C<*>) plus a
circumflex accent (C<^>), then the rational's value is interpreted as the
leading integer (a mantissa) multiplied by the result of the middle
positive integer (a radix) taken to the power of the trailing integer (an
exponent); that is, the three integers collectively map to the C<float>
possrep of the C<Rat> type.

Examples:

    Rat:0b-1.1

    -1.5 #`same val as prev`#

    3.14159

    A#0.0

    0xDEADBEEF.FACE

    Z#0.000AZE

    Rat:6#500001/1000

    B#A09B/A

    Rat:0b1011101101*10^-11011

    45207196*10^37

    1/43

    314159*10^-5

## General Purpose Binary String Literals

Grammar:

    <Blob> ::=
        [
            [Blob | OctetBlob] ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <Blob_payload>

    <Blob_payload> ::=
          <blob_max_col_val> '#' <unspace> <blob_body>
        | <blob_radix_mark> <unspace> <blob_body>

    <blob_max_col_val> ::=
        <[137F]>

    <blob_radix_mark> ::=
        0<[box]>

    <blob_body> ::=
        '\''
            <[ 0..9 A..F a..f _ \s ]>*
        '\''

A C<Blob> node represents a general purpose bit string.  It is interpreted
as a Muldis D C<sys.std.Core.Type.Blob> value as follows:  Fundamentally
the I<body> part of a C<Blob> node consists of a delimited string of digits
and plain uppercased or lowercased letters, where each digit (C<0..9>)
represents its own number and each letter (C<A..F>) represents a number in
[10..15]; this string is qualified with a C<blob_max_col_val> character
(C<[137F]>) or a C<blob_radix_mark> (C<[0b,0o,0x]>),
similarly to how an C<int_body> is qualified by a C<num_max_col_val>
or C<num_radix_mark>.  Each character of the delimited string specifies a
sequence of one of [1,2,3,4] bits, depending on whether C<blob_max_col_val>
is [1|0b,3,7|0o,F|0x].  The I<body> may also contain underscore or
whitespace characters between the delimiters, to aid formatting; these are
ignored/stripped by the parser, and the I<body> is interpreted as if it
just consisted of the rest of the delimited string contiguously.  If the
C<value_kind> of a C<value> node is C<OctetBlob>
rather than C<Blob>, then the C<value> node is interpreted simply as a
C<Blob> node whose C<type_name> is C<OctetBlob>, and the delimited string
is appropriately further restricted.

Examples:

    Blob:0b'00101110100010' #`binary`#

    3#''

    0x'A705E' #`hexadecimal`#

    0o'523504376'

## General Purpose Character String Literals

Grammar:

    <Text> ::=
        [
            Text ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <Text_payload>

    <Text_payload> ::=
        '\''
            [<-[\']> | <escaped_char>]*
        '\''

    <escaped_char> ::=
          '\\\\' | '\\\'' | '\\"' | '\\`'
        | '\\t' | '\\n' | '\\f' | '\\r'
        | '\\c<' [
              [<[ A..Z ]>+] ** ' '
            | [0 | <[ 1..9 ]> <[ 0..9 ]>*]
            | <[ 1..9 A..Z a..z ]> '#'
                [0 | <[ 1..9 A..Z a..z ]> <[ 0..9 A..Z a..z ]>*]
            | 0<[ bodx ]> [0 | <[ 1..9 A..F a..f ]> <[ 0..9 A..F a..f ]>*]
          ] '>'

    <unspace> ::=
        '\\' <ws>? '\\'

    <splitter> ::=
        '\\' \s* '\\'

    <ws> ::=
        \s+ [[<non_value_comment> | <visual_dividing_line>] \s+]*

    <non_value_comment> ::=
        '#' \s*
            '`' \s*
                [<-[\`]> | <escaped_char>]*
            \s* '`'
        \s* '#'

    <visual_dividing_line> ::=
        '#' ** 2..*

A C<Text> node represents a general purpose character string.  It is
interpreted as a Muldis D C<sys.std.Core.Type.Text> value as follows:

The C<Text_payload> is interpreted generally as is usual for a programming
language with such a delimited character string literal.

A C<Text_payload> may contain any literal characters at all, except that
any literal occurrences of a backslash (C<\>) or single-quote (C<'>) must
have a leading backslash.  Every run of 1+ literal whitespace or control
characters, that is not composed just of the C<SPACE> char (C<0x20>), is
substituted for a single C<SPACE> character by the parser, and the
C<Text_payload> is interpreted as if the post-substitution string had been
the original string.  However, if said run of whitespace is immediately
preceded by an escape sequence denoting a whitespace or control character,
then the run is simply stripped rather than a C<SPACE> taking its place.

The main reason for this substitution/stripping feature is to ensure that
the actual values being selected by string literals are not variable per
the kind of linebreaks or indenting used to format the Muldis D source code
itself.  The feature is provided to support code that contains long value
literals while still being well formatted (no extra-long lines).  If you
want to have actual non-C<SPACE> whitespace or control characters in your
strings, then they must be formatted as escape sequences such as C<\n>.  If
you want to end up with multiple C<SPACE> characters at the point where a
line is broken, you have to format some as escape sequences.  If you want
to end up with no C<SPACE> at all where a line is broken, then you'll have
to employ some other workaround, such as catenating several quoted strings.

All Muldis D delimited character string literals (generally the 3 C<Text>,
C<Name>, code comments) may contain some characters denoted with escape
sequences rather than literally.  The Muldis D parser would substitute the
escape sequences with the characters they represent, so the resulting
character string values don't contain those escape sequences.  Currently
there are 2 classes of escape sequences, called I<simple> and I<complex>.

The meanings of the simple escape sequences are:

    Esc | Unicode    | Unicode         | Chr | Literal character used
    Seq | Code Point | Character Name  | Lit | for when not escaped
    ----+------------+-----------------+-----+------------------------------
    \\  | 0x5C       | REVERSE SOLIDUS | \   | esc seq lead (aka backslash)
    \'  | 0x27       | APOSTROPHE      | '   | delim Text literals
    \"  | 0x22       | QUOTATION MARK  | "   | delim quoted Name literals
    \`  | 0x60       | GRAVE ACCENT    | `   | delim for code comments
    \t  | 0x9        | CHAR... TAB...  |     | control char horizontal tab
    \n  | 0xA        | LINE FEED (LF)  |     | ctrl char line feed / newline
    \f  | 0xC        | FORM FEED (FF)  |     | control char form feed
    \r  | 0xD        | CARR. RET. (CR) |     | control char carriage return

There is currently just one complex escape sequence, of the format C<<
\c<...> >>, that supports specifying characters in terms of their Unicode
abstract code point name or number.  If the C<...> consists of just
uppercased (not lowercased) letters and the space character, then the
C<...> is interpreted as a Unicode character name.  If the C<...> looks
like an C<Int_payload>, sans that underscores and unspace aren't
allowed here, then the C<...> is interpreted as a Unicode abstract
code point number.  One reason for this feature is to empower more elegant
passing of Unicode-savvy PTMD_STD source code through a communications
channel that is more limited, such as to 7-bit ASCII.

Examples:

    Text:'Ceres'

    'サンプル'

    ''

    'Perl'

    '\c<LATIN SMALL LETTER OU>\c<0x263A>\c<65>'

A C<non_value_comment> node is strictly not part of the code
proper; Muldis D code can contain these almost anywhere as metadata for
the code, and in large part it is treated as if it were part of the
insignificant whitespace; that all being said, generally speaking any
C<non_value_comment> is retained in the parse tree adjusted to live in the
contextually nearest place where a resulting system catalog node has a
C<scm_comment> attribute.  I<Details of determining the contextually
nearest place for these comments to go is pending.>

Syntactically, a C<non_value_comment> node differs from C<Text_payload>
only in that it is delimited by number-signs/hash-marks in addition to
backticks/grave-accents.

A C<visual_dividing_line> is a run of 2+ C<#> that may be used in all of
the same places as a C<non_value_comment> but it does I<not> denote a
comment and will be stripped out by the parser as if it was insignificant
whitespace.  This feature exists to empower things like making visual
dividing lines in the code just out of hash-marks.

Examples:

    #`This does something.`#

## DBMS Entity Name Literals

Grammar:

    <Name> ::=
        Name ':' <unspace>
        [<type_name> ':' <unspace>]?
        <Name_payload>

    <Name_payload> ::=
        <nonquoted_name_str> | <quoted_name_str>

    <nonquoted_name_str__op_cr_basic> ::=
        [<[ a..z A..Z _ ]> <[ a..z A..Z 0..9 _ ]>*] ** '-'

    <nonquoted_name_str__op_cr_extended> ::=
        [<alpha> \w*] ** '-'

    <quoted_name_str> ::=
        '"'
            [<-[\"]> | <escaped_char>]*
        '"'

    <NameChain> ::=
        NameChain ':' <unspace>
        [<type_name> ':' <unspace>]?
        <NameChain_payload>

    <NameChain_payload> ::=
        <nc_nonempty> | <nc_empty>

    <nc_nonempty> ::=
        <Name_payload> ** [<unspace> '.']

    <nc_empty> ::=
        '[]'

    <PNSQNameChain> ::=
        PNSQNameChain ':' <unspace>
        [<type_name> ':' <unspace>]?
        <PNSQNameChain_payload>

    <PNSQNameChain_payload> ::=
        <nc_nonempty>

A C<Name> node represents a canonical short name for any kind of DBMS
entity when declaring it; it is a character string type, that is disjoint
from C<Text>.  It is interpreted as a Muldis D
C<sys.std.Core.Type.Cat.Name> value as follows:

Fundamentally a C<Name> node is formatted and interpreted like a C<Text>
node, and any similarities won't be repeated here.  Unlike a
C<Text_payload> literal which must always be delimited, a C<Name_payload>
has 2 variants, one delimited (C<quoted_name_str>) and one not
(C<nonquoted_name_str>).  The delimited C<Name_payload> form differs from
C<Text_payload> only in that the string is delimited by
double-quotes rather than apostrophes/single-quotes, meaning also that
literal double-quotes instead of apostrophes must be escaped.

A C<nonquoted_name_str> is composed of an alphabetic character followed by
any sequence of alphanumeric characters.  It can not be segmented, so you
will have to use the C<quoted_name_str> equivalent if you want a segmented
string.  The definitions of alphabetic and alphanumeric in this context
include appropriate Unicode characters, iff the C<op_char_repertoire> is
C<extended>; for C<basic>, they are expressly limited to the ASCII
repertoire.  An underscore is always considered alphabetic.  A
C<nonquoted_name_str> may also contain isolated hyphens provided the next
character is alphabetic.

A C<NameChain> node represents a canonical long name for invoking a DBMS
entity in some contexts; it is conceptually a sequence of entity short
names.  This node is interpreted as a Muldis D
C<sys.std.Core.Type.Cat.NameChain> value as follows:  A
C<NameChain_payload> has 2 variants, one that defines a nonempty chain
(C<nc_nonempty>) and one that defines an empty chain (C<nc_empty>).  A
C<nc_nonempty> consists of a sequence of 1 or more C<Name_payload>
where the elements of the sequence are separated by period (C<.>) tokens;
each element of the sequence, in order, defines an element of the C<array>
possrep's attribute of the result C<NameChain> value.  A C<nc_empty>
consists simply of the special syntax of C<[]>.

Fundamentally a C<PNSQNameChain> node is exactly the same as a C<NameChain>
node in format and interpretation, with the primary difference being that
it may only define C<NameChain> values that are also values of the proper
subtype C<sys.std.Core.Type.Cat.PNSQNameChain>, all of which are nonempty
chains.  Now that distinction alone wouldn't be enough rationale to have
these 2 distinct node kinds, and so the secondary difference between the 2
provides that rationale; the C<PNSQNameChain> node supports a number of
chain value shorthands while the C<NameChain> node supports none.

Strictly speaking, a Muldis D C<PNSQNameChain> value is supposed to have
at least 1 element in its sequence, and the first element of any sequence
must be one of these 5 C<Name> values, which is a top-level namespace:
C<sys>, C<mnt>, C<fed>, C<nlx>, C<rtn>.  (Actually, C<type> is a
6th option, but that will be treated separately in this discussion.)  In
the general case, a C<PNSQNameChain_payload> must be written out in full,
so it is completely unambiguous (and is clearly self-documenting), and it
is always the case that a C<PNSQNameChain> value in the system catalog is
written out in full.  But the PTMD_STD grammar also has a few commonly used
special cases where a C<PNSQNameChain_payload> may be a much shorter
substring of its complete version, such that a simple parser, with no
knowledge of any user-defined entities besides said shorter
C<PNSQNameChain_payload> in isolation, can still unambiguously resolve it
to its complete version; exploiting these typically makes for code that is
a lot less verbose, and much easier to write or read.

The first special case involves any context where a type or routine is
being referenced by name.  In such a context, when the referenced entity is
a standard system-defined type or routine, programmers may omit any number
of consecutive leading chain elements from such a C<PNSQNameChain_payload>,
so long as the remaining unqualified chain is distinct among all standard
system-defined (C<sys.std>-prefix) DBMS entities (but that as an exception,
a non-distinct abbreviation is allowed iff exactly 1 of the candidate
entities is in the language core, C<sys.std.Core>-prefix, in which case
that 1 is unambiguously the entity that is resolved to; or, when more than
1 of the candidate entities is in the language core, and iff exactly 1 of
those in-core candidates is a virtual routine and all of the other in-core
candidates are routines that implement said virtual routine either directly
or indirectly, then a non-distinct abbreviation is allowed and that 1
virtual is unambiguously the entity that is resolved to).  For any
system-defined entities whose names have trailing empty-string chain
elements, those elements are ignored when determining a match for a
C<PNSQNameChain_payload>, similarly to how specifying those elements is not
required in a fully-qualified C<PNSQNameChain> to resolve it.  This feature
has no effect on the namespace prefixes like C<type> or C<tuple_from> or
C<array_of>; one still writes those as normal prepended to the otherwise
shortened chains.  When a C<PNSQNameChain_payload>, whose context indicates
it is a type or routine invocation, is encountered by the parser, and its
existing first chain element isn't one of the other 6 top-level namespaces,
then the parser will assume it is an unqualified chain in the C<sys>
namespace and lookup the best / only match from the known C<sys.std> DBMS
entities, to resolve to.  So for example, one can just write C<Int> rather
than C<sys.std.Core.Type.Int>, C<Array> rather than
C<sys.std.Core.Type.Array."">, C<is_same> rather than
C<sys.std.Core.Universal.is_same>, C<Tuple.attr> rather than
C<sys.std.Core.Tuple.attr>, C<fetch_trans_instant> rather than
C<sys.std.Temporal.Instant.fetch_trans_instant>,
C<array_of.Rat> rather than C<array_of.sys.std.Core.Type.Rat>, and so on.
In fact, the Muldis D spec itself uses such abbreviations frequently.

The second special case involves any context where a type is being
referenced using the C<type> namespace prefix feature described in
[Muldis_Data_Language_Basics](Muldis_Data_Language_Basics.md) section **Referencing Data Types**.  In such a context, when the
namespace prefix contains either of the optional chain elements
C<[|dh_]tuple_from> or
C<[|dh_][set|maybe|just|array|bag|[s|m]p_interval]_of>, programmers may
omit the single prefix-leading C<type> chain element.  So for example, one
can just write C<array_of.Rat> rather than C<type.array_of.Rat>, or
C<tuple_from.var.nlx.myrelvar> rather than
C<type.tuple_from.var.nlx.myrelvar>.  This second special case is
completely orthogonal to which of the 5 normal top-level namespaces is in
use (implicitly or explicitly) by the chain being prefixed, and works for
all 5 of them.

Examples:

    Name:login_pass

    Name:"First Name"

    NameChain:gene.sorted_person_name

    NameChain:stats."samples by order"

    NameChain:[]

    PNSQNameChain:fed.data.the_db.gene.sorted_person_names

    PNSQNameChain:fed.data.the_db.stats."samples by order"

## Rational Rounding Rule Literals

Grammar:

    <RatRoundRule> ::=
        RatRoundRule ':' <unspace>
        [<type_name> ':' <unspace>]?
        <RatRoundRule_payload>

    <RatRoundRule_payload> ::=
        '[' <ws>?
            <radix> <ws>? ',' <ws>? <min_exp> <ws>? ',' <ws>? <round_meth>
        <ws>? ']'

    <radix> ::=
        <Int_payload>

    <min_exp> ::=
        <Int_payload>

    <round_meth> ::=
        <RoundMeth_payload>

A C<RatRoundRule> node represents a rational rounding rule.  It is
interpreted as a Muldis D C<sys.std.Core.Type.Cat.RatRoundRule> value whose
attributes are defined by the C<RatRoundRule_payload>.  A
C<RatRoundRule_payload> consists mainly of a bracket-delimited sequence of
3 comma-separated elements, which correspond in order to the 3 attributes:
C<radix> (a C<PInt2_N>), C<min_exp> (an C<Int>), and C<round_meth> (a
C<RoundMeth>).  Each of C<radix> and C<min_exp> must qualify as a valid
C<Int_payload>, and C<round_meth> must qualify as a valid
C<RoundMeth_payload>.

Examples:

    RatRoundRule:[10,-2,HalfEven]

    RatRoundRule:[2,-7,ToZero]

# COLLECTION VALUE SELECTORS

Note that, with each of the main value selector nodes documented in this
main POD section (members of C<coll_value_selector> etc), any occurrences
of child C<expr> nodes should be read as being C<value> nodes instead in
contexts where instances of the main nodes are being composed beneath
C<value> nodes.  That is, any C<expr> node options beyond what C<value>
options exist are only valid within a C<depot> node.

## Scalar Selectors

Grammar:

    <Scalar> ::=
        [DH? Scalar | '$'] ':' <unspace>
        <type_name> ':' <unspace>
        <Scalar_payload>

    <Scalar_payload> ::=
          <possrep_name> ':' <unspace> <possrep_attrs>
        | <possrep_attrs>

    <possrep_name> ::=
        <Name_payload>

    <possrep_attrs> ::=
        <tuple_list>

A C<Scalar> node represents a literal or selector invocation for a
not-C<Int|String> scalar subtype value.  It is interpreted as a Muldis D
C<sys.std.Core.Type.Scalar> subtype value whose declared type is specified
by the node's (mandatory for C<Scalar>) C<type_name> and whose attributes
are defined by the C<Scalar_payload>.  If the C<Scalar_payload> is just a
C<possrep_attrs>, then it is interpreted as if it also had an explicit
C<possrep_name> that is the empty string.  The C<possrep_attrs> is
interpreted specifically as attributes of the declared type's possrep which
is specified by the C<possrep_name>.  Each name+expr pair of the
C<possrep_attrs> defines a named possrep attribute of the new scalar;
the pair's name and expr specify, respectively, the possrep attribute name,
and the possrep attribute value.  If the C<value_kind> of a C<value> node
is C<DHScalar> rather than C<Scalar>, then the C<value> node is interpreted
simply as a C<Scalar> node that is appropriately further restricted; the
C<type_name> must name a C<DHScalar> subtype, and the C<possrep_attrs> must
specify only deeply homogeneous typed attribute values.  If the
C<value_kind> is C<$> then this is just an alias for C<Scalar>.

See also the definition of the catalog data type
C<sys.std.Core.Type.Cat.ScaSelExprNodeSet>, a tuple of which is what
a C<Scalar> node distills to when it is beneath the context of a
C<depot> node, as it describes some semantics.

Examples:

    Scalar:Name:{ "" => 'the_thing' }

    $:Rat:float:{
        mantissa => 45207196,
        radix    => 10,
        exponent => 37,
    }

    $:fed.lib.the_db.UTCDateTime:datetime:{
        year   => 2003,
        month  => 10,
        day    => 26,
        hour   => 1,
        minute => 30,
        second => 0.0,
    }

    $:fed.lib.the_db.WeekDay:name:{
        "" => "monday",
    }

    $:fed.lib.the_db.WeekDay:number:{
        "" => 5,
    }

## Tuple Selectors

Grammar:

    <Tuple> ::=
        [DH? Tuple | '%'] ':' <unspace>
        [<type_name> ':' <unspace>]?
        <Tuple_payload>

    <Tuple_payload> ::=
        <tuple_list> | <tuple_D0>

    <tuple_list> ::=
        '{' <ws>?
            [[<nonord_atvl> | <same_named_nonord_atvl>]
                ** [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'

    <nonord_atvl> ::=
        <attr_name> <ws>? '=>' <ws>? <expr>

    <attr_name> ::=
        <Name_payload>

    <same_named_nonord_atvl> ::=
        '=>' <attr_name>

    <tuple_D0> ::=
        D0

A C<Tuple> node represents a literal or selector invocation for a tuple
value.  It is interpreted as a Muldis D C<sys.std.Core.Type.Tuple> value
whose attributes are defined by the C<Tuple_payload>.

Iff the C<Tuple_payload> is a C<tuple_list> then each name+expr pair
(C<nonord_atvl>) of the
C<Tuple_payload> defines a named attribute of the new tuple; the pair's
name and expr specify, respectively, the attribute name, and the attribute
value.  If the C<value_kind> of a C<value> node is C<DHTuple> rather than
C<Tuple>, then the C<value> node is interpreted simply as a C<Tuple> node
that is appropriately further restricted; the C<Tuple_payload> must specify
only deeply homogeneous typed attribute values.  If the
C<value_kind> is C<%> then this is just an alias for C<Tuple>.

Iff the C<Tuple_payload> is a C<tuple_D0> then the C<Tuple> node is
interpreted as the special value C<Tuple:D0> aka C<D0>, which is the only
C<Tuple> value with exactly zero attributes.  Note that this is just an
alternative syntax, as C<tuple_list> can select that value too.

A special shorthand for C<nonord_atvl> also exists,
C<same_named_nonord_atvl>, which may be used only if the C<expr> of the
otherwise-C<nonord_atvl> is an C<expr_name> and that C<expr_name> is
identical to the C<attr_name>.  In this situation, the identical name can
be specified just once, which is the shorthand; for example, the attribute
C<< foo => foo >> may alternately be written out as C<< =>foo >>.
This shorthand is to help with
the possibly common situation where attributes of a tuple (or relation or
scalar) selection are being valued from same-named expression nodes / etc.
(This shorthand is like Raku's C<:$a> being short for C<< a => $a >>.)

See also the definition of the catalog data type
C<sys.std.Core.Type.Cat.TupSelExprNodeSet>, a tuple of which is what
a C<Tuple> node distills to when it is beneath the context of a
C<depot> node, as it describes some semantics.

Examples:

    %:{}

    Tuple:D0  #`same as previous`#

    D0  #`same as previous`#

    %:type.tuple_from.var.fed.data.the_db.account.users:{
        login_name => 'hartmark',
        login_pass => 'letmein',
        is_special => True,
    }

    %:{
        name => 'Michelle',
        age  => 17,
    }

    %:{ w => 'foo', =>x, y => 4, =>z }

## Database Selectors

Grammar:

    <Database> ::=
        Database ':' <unspace>
        [<type_name> ':' <unspace>]?
        <Database_payload>

    <Database_payload> ::=
        <Tuple_payload>

A C<Database> node represents a literal or selector invocation for a
'database' value.  It is interpreted as a Muldis D
C<sys.std.Core.Type.Database> value whose attributes are defined by the
C<Database_payload>.  Each name+relation pair of the C<Database_payload>
defines a named attribute of the new 'database'; the pair's name and
relation specify, respectively, the attribute name, and the attribute
value.  While this grammar mentions that C<Database_payload> is a
C<Tuple_payload>, it is in fact significantly further restricted, such
that every attribute value of the C<Database> can only be a C<DHRelation>.

See also the definition of the catalog data type
C<sys.std.Core.Type.Cat.TupSelExprNodeSet>, a tuple of which is what
a C<Database> node distills to same as when C<Tuple> does.

## Relation Selectors

Grammar:

    <Relation> ::=
        [DH? Relation | '@'] ':' <unspace>
        [<type_name> ':' <unspace>]?
        <Relation_payload>

    <Relation_payload> ::=
          <r_empty_body_payload>
        | <r_nonordered_attr_payload>
        | <r_ordered_attr_payload>
        | <relation_D0>

    <r_empty_body_payload> ::=
        '{' <ws>?
            [<attr_name> ** [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'

    <r_nonordered_attr_payload> ::=
        '{' <ws>?
            [<tuple_list> ** [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'

    <r_ordered_attr_payload> ::=
        '[' <ws>?
            [<attr_name> ** [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? ']'
        ':' <unspace>
        '{' <ws>?
            [<ordered_tuple_attrs> ** [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'

    <ordered_tuple_attrs> ::=
        '[' <ws>?
            [<expr> ** [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? ']'

    <relation_D0> ::=
        D0C0 | D0C1

A C<Relation> node represents a literal or selector invocation for a
relation value.  It is interpreted as a Muldis D
C<sys.std.Core.Type.Relation> value whose attributes and tuples are
defined by the C<Relation_payload>, which is interpreted as follows:

Iff the C<Relation_payload> is composed of just a
C<nonord_list_[open|close]> pair with zero elements between them, then it
defines the only relation value having zero attributes and zero tuples.

Iff the C<Relation_payload> is a C<r_empty_body_payload> with at least
one C<attr_name> element, then it defines the attribute names of a
relation having zero tuples.

Iff the C<Relation_payload> is a C<r_nonordered_attr_payload> with at
least one C<tuple_list> element, then each element defines a tuple
of the new relation; every C<tuple_list> must define a tuple
of the same degree and have the same attribute names as its sibling
C<tuple_list>; these are the degree and attribute names of the
relation as a whole, which is its heading for the current purposes.

Iff the C<Relation_payload> is a C<r_ordered_attr_payload>, then:  The
new relation value's attribute names are defined by the
C<attr_name> elements, and the relation body's tuples' attribute values
are defined by the C<ordered_tuple_attrs> elements.  This format is meant
to be the most compact of the generic relation selector formats, as the
attribute names only appear once for the relation rather than repeating for
each tuple.  As a trade-off, the attribute values per tuple from all of the
C<ordered_tuple_attrs> elements must appear in the same order as their
corresponding attribute names appear in the collection of C<attr_name>
elements, as the names and values in the relation literal are matched up by
ordinal position here.

Iff the C<Relation_payload> is a C<relation_D0> then the C<Relation> node
is interpreted as one of the 2 special values C<Relation:d[0|1]> aka
C<d[0|1]>, which are the only C<Relation> values with exactly zero
attributes.  Note that this is just an alternative syntax, as other
C<Relation_payload> formats can select those values too.

If the C<value_kind> of a C<value> node is C<DHRelation> rather than
C<Relation>, then the C<value> node is interpreted simply as a
C<Relation> node that is appropriately further restricted; the
C<Relation_payload> specify only deeply homogeneous typed attribute values.
If the C<value_kind> is C<@> then this is just an alias for C<Relation>.

See also the definition of the catalog data type
C<sys.std.Core.Type.Cat.RelSelExprNodeSet>, a tuple of which is what
a C<Relation> node distills to when it is beneath the context of a
C<depot> node, as it describes some semantics.

Examples:

    @:{}  #`zero attrs + zero tuples`#

    Relation:D0C0  #`same as previous`#

    @:{ x, y, z }  #`3 attrs + zero tuples`#

    @:{ {} }  #`zero attrs + 1 tuple`#

    D0C1  #`same as previous`#

    @:{
        {
            login_name => 'hartmark',
            login_pass => 'letmein',
            is_special => True,
        },
    }  #`3 attrs + 1 tuple`#

    @:fed.lib.the_db.gene.Person:[ name, age ]:{
        [ 'Michelle', 17 ],
    }  #`2 attrs + 1 tuple`#

## Set Selectors

Grammar:

    <Set> ::=
        [
            DH? Set ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <Set_payload>

    <Set_payload> ::=
        '{' <ws>?
            [<expr> ** [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'

A C<Set> node represents a literal or selector invocation for a set
value.  It is interpreted as a Muldis D C<sys.std.Core.Type.Set> value
whose elements are defined by the C<Set_payload>.  Each C<expr> of the
C<Set_payload> defines a unary tuple of the new set; each
C<expr> defines the C<value> attribute of the tuple.  If the
C<value_kind> of a C<value> node is C<DHSet> rather than C<Set>, then the
C<value> node is further restricted.

See also the definition of the catalog data type
C<sys.std.Core.Type.Cat.SetSelExprNodeSet>, a tuple of which is what
a C<Set> node distills to when it is beneath the context of a
C<depot> node, as it describes some semantics.

Examples:

    Set:fed.lib.the_db.account.Country_Names:{
        'Canada',
        'Spain',
        'Jordan',
        'Thailand',
    }

    {
        3,
        16,
        85,
    }

## Maybe Selectors

Grammar:

    <Maybe> ::=
        [
            DH? [Maybe | Just] ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <Maybe_payload>

    <Maybe_payload> ::=
        <maybe_list> | <maybe_Nothing>

    <maybe_list> ::=
        '{' <ws>? <expr> <ws>? '}'

    <maybe_Nothing__op_cr_basic> ::=
        Nothing

    <maybe_Nothing__op_cr_extended> ::=
          <maybe_Nothing__op_cr_basic>
        | '∅'

A C<Maybe> node represents a literal or selector invocation for a maybe
value.  It is interpreted as a Muldis D C<sys.std.Core.Type.Maybe> value
whose elements are defined by the C<Maybe_payload>.

Iff the C<Maybe_payload> is a C<maybe_list> then it defines either zero or
one C<expr>; in the case of one, the C<expr> defines the unary tuple of the
new maybe, which is a 'single'; the C<expr> defines the C<value> attribute
of the tuple.  If the C<value_kind> of a C<value> node is C<DHMaybe> or
C<[|DH]Just> rather than C<Maybe>, then the C<value> node is further
restricted, either to having only deeply homogeneous resulting C<expr> or
to having exactly one C<expr>, as appropriate.

Iff the C<Maybe_payload> is a C<maybe_Nothing> then the C<Maybe> node is
interpreted as the special value C<Maybe:Nothing>, aka C<Nothing>, aka
I<empty set>, aka C<∅>, which is the only C<Maybe> value with zero
elements.  Note that this is just an alternative syntax, as
C<set_expr_list> can select that value too.  As a further restriction, the
C<value_kind> must be just one of C<[|DH]Maybe> when the C<Maybe_payload>
is a C<maybe_Nothing>.

See also the definition of the catalog data type
C<sys.std.Core.Type.Cat.SetSelExprNodeSet>, a tuple of which is what
a C<Maybe> node distills to same as when C<Set> does.

Examples:

    Maybe:{ 'I know this one!' }

    Maybe:Nothing

    Maybe:∅

    Nothing

    ∅

## Array Selectors

Grammar:

    <Array> ::=
        [
            DH? Array ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <Array_payload>

    <Array_payload> ::=
        '[' <ws>?
            [<expr> ** [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? ']'

An C<Array> node represents a literal or selector invocation for an
array value.  It is interpreted as a Muldis D
C<sys.std.Core.Type.Array> value whose elements are defined by the
C<Array_payload>.  Each C<expr> of the C<Array_payload> defines a binary
tuple of the new sequence; the C<expr> defines the C<value> attribute
of the tuple, and the C<index> attribute of the tuple is
generated such that the first C<expr> gets an C<index> of zero and
subsequent ones get consecutive higher integer values.  If the
C<value_kind> of a C<value> node is C<DHArray> rather than C<Array>, then
the C<value> node is further restricted.

See also the definition of the catalog data type
C<sys.std.Core.Type.Cat.ArySelExprNodeSet>, a tuple of which is what
an C<Array> node distills to when it is beneath the context of a
C<depot> node, as it describes some semantics.

Examples:

    [
        'Alphonse',
        'Edward',
        'Winry',
    ]

    Array:fed.lib.the_db.stats.Samples_By_Order:[
        57,
        45,
        63,
        61,
    ]

## Bag Selectors

Grammar:

    <Bag> ::=
        [
            DH? Bag ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <Bag_payload>

    <Bag_payload> ::=
          <bag_payload_counted_values>
        | <bag_payload_repeated_values>

    <bag_payload_counted_values> ::=
        '{' <ws>?
            [[<expr> <ws>? '=>' <ws>? <count>] ** [<ws>? ',' <ws>?]
                [<ws>? ',']?]?
        <ws>? '}'

    <count> ::=
          <num_max_col_val> '#' <unspace> <pint_body>
        | <num_radix_mark> <unspace> <pint_body>
        | <d_pint_body>

    <bag_payload_repeated_values> ::=
        '{' <ws>?
            [<expr> ** [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'

A C<Bag> node represents a literal or selector invocation for a bag
value.  It is interpreted as a Muldis D C<sys.std.Core.Type.Bag> value
whose elements are defined by the C<Bag_payload>, which is interpreted as
follows:

Iff the C<Bag_payload> is composed of just a C<nonord_list_[open|close]>
pair with zero elements between them, then it defines the only bag value
having zero elements.

Iff the C<Bag_payload> is a C<bag_payload_counted_values> with at least
one C<expr>/C<count>-pair element, then each pair defines a binary
tuple of the new bag; the C<expr> defines the C<value>
attribute of the tuple, and the C<count> defines the C<count>
attribute.

Iff the C<Bag_payload> is a C<bag_payload_repeated_values> with at least
one C<expr> element, then each C<expr> contributes to a binary tuple
of the new bag; the C<expr> defines the C<value> attribute of the
tuple.  The bag has 1 tuple for every distinct (after
normalization or evaluation) C<expr> and C<expr>-derived value in the
C<Bag_payload>, and the C<count> attribute of that tuple says how
many instances of said C<value> there were.

See also the definition of the catalog data type
C<sys.std.Core.Type.Cat.BagSelExprNodeSet>, a tuple of which is what
a C<Bag> node distills to when it is beneath the context of a
C<depot> node, as it describes some semantics.

Further concerning C<bag_payload_counted_values>, because of how
C<BagSelExprNodeSet> is defined, a C<count> has to be a compile time
constant, since an integer is stored in the system catalog rather than the
name of an expression node like with C<value>; if you actually want the
bag value being selected at runtime to have runtime-determined C<count>
values, then you must use a C<Relation> node rather than a C<Bag> node.

Examples:

    {
        'Apple'  => 500,
        'Orange' => 300,
        'Banana' => 400,
    }

    Bag:{
        'Foo',
        'Quux',
        'Foo',
        'Bar',
        'Baz',
        'Baz',
    }

## Interval Selectors

Grammar:

    <SPInterval> ::=
        [
            DH? SPInterval ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <SPInterval_payload>

    <SPInterval_payload> ::=
        '{' <ws>?
            <interval>
        <ws>? '}'

    <interval> ::=
        <interval_range> | <interval_single>

    <interval_range> ::=
        <min> <ws>? <interval_boundary_kind> <ws>? <max>

    <min> ::=
        <expr>

    <max> ::=
        <expr>

    <interval_boundary_kind> ::=
        '..' | '..^' | '^..' | '^..^'

    <interval_single> ::=
        <expr>

    <MPInterval> ::=
        [
            DH? MPInterval ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <MPInterval_payload>

    <MPInterval_payload> ::=
        '{' <ws>?
            [<interval> ** [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'

An C<SPInterval> node represents a literal or selector invocation for a
single-piece interval value.  It is interpreted as a Muldis D
C<sys.std.Core.Type.SPInterval> value whose attributes are defined by the
C<SPInterval_payload>.  Each of C<min> and C<max> is an C<expr> node that
defines the C<min> and C<max> attribute value, respectively, of the new
single-piece interval.  Each of the 4 C<interval_boundary_kind> values
C<..>, C<..^>, C<^..>, C<^..^> corresponds to one of the 4 possible
combinations of C<excludes_min> and C<excludes_max> values that the new
single-piece interval can have, which in order are: C<[False,False]>,
C<[False,True]>, C<[True,False]>, C<[True,True]>.

A special shorthand for C<interval_range> also exists, C<interval_single>,
which is to help with the possibly common situation where an interval is a
singleton, meaning the interval has exactly 1 value; the shorthand empowers
that value to be specified just once rather than twice.  Iff the
C<interval> is an C<interval_single>, then the C<interval> is treated as if
it was instead an C<interval_range> whose C<min> and C<max> are both
identical to the C<interval_single> and whose C<interval_boundary_kind> is
C<..>.  For example, the interval C<6> is shorthand for C<6..6>.

An C<MPInterval> node represents a literal or selector invocation for a
multi-piece interval value.  It is interpreted as a Muldis D
C<sys.std.Core.Type.MPInterval> value whose elements are defined by the
C<MPInterval_payload>.  Each C<interval> of the C<MPInterval_payload>
defines a 4-ary tuple, representing a single-piece interval, of the new
multi-piece interval.

See also the definition of the 2 catalog data types
C<sys.std.Core.Type.Cat.[S|M]PIvlSelExprNodeSet>, a tuple of which is what
an C<[S|M]PInterval> node distills to, respectively, when it is beneath the
context of a C<depot> node, as it describes some semantics.

Examples:

    {1..10}

    {2.7..^9.3}

    {'a'^..'z'}

    {UTCInstant:[2002,12,6,,,] ^..^ UTCInstant:[2002,12,20,,,]}

    SPInterval:{'abc'}  #`1 element`#

    MPInterval:{}  #`zero elements`#

    MPInterval:{1..10}  #`10 elements`#

    {1..3,6,8..9}  #`6 elements`#

    {-Inf..3,14..21,29..Inf}  #`all Int besides {4..13,22..28}`#

## Low Level List Selectors

Grammar:

    <List> ::=
        List ':' <unspace>
        [<type_name> ':' <unspace>]?
        <List_payload>

    <List_payload> ::=
        '[' <ws>?
            [<expr> ** [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? ']'

A C<List> node represents a literal or selector invocation for a
low-level list value.  It is interpreted as a Muldis D
C<sys.std.Core.Type.Cat.List> value whose elements are defined by the
C<List_payload>.  Each C<expr> of the C<List_payload> defines an element
of the new list, where the elements keep the same order.

See also the definition of the catalog data type
C<sys.std.Core.Type.Cat.ListSelExprNodeSet>, a tuple of which is what
a C<List> node distills to when it is beneath the context of a
C<depot> node, as it describes some semantics.

Examples:

    #`Nonstructure : Unicode abstract code points = 'Perl'`#
    List:[80,101,114,109]

    #`UCPString : Unicode abstract code points = 'Perl'`#
    List:[1,List:[80,101,114,109]]

    #`%:{}`#
    List:[2,List:[],List:[]]

    #`@:{}`#
    List:[3,List:[],List:[]]

    #`Set : {17,42,5}`#
    List:[3,
        List:[List:[1,List:[118,97,108,117,101]]],
        List:[
            List:[17],
            List:[42],
            List:[5]
        ]
    ]

    #`Nothing`#
    List:[3,
        List:[List:[1,List:[118,97,108,117,101]]],
        List:[]
    ]

    #`Text : 'Perl'`#
    List:[4,
        #`type name : 'sys.std.Core.Type.Text'`#
        List:[
            List:[1,List:[115,121,115]],
            List:[1,List:[115,116,100]],
            List:[1,List:[67,111,114,101]],
            List:[1,List:[84,121,112,101]],
            List:[1,List:[84,101,120,116]],
        ],
        #`possrep name : 'nfd_codes'`#
        List:[1,List:[110,102,100,95,99,111,100,101,115]],
        #`possrep attributes : %:{""=>"Perl"}`#
        List:[2,
            List:[List:[1,List:[]]],
            List:[List:[1,List:[80,101,114,109]]]
        ]
    ]

# DEPOT SPECIFICATION

Grammar:

    <depot> ::=
        <depot_catalog>
        [<ws> <depot_data>]?

    <depot_catalog> ::=
        'depot-catalog' <ws> <catalog>

    <depot_data> ::=
        'depot-data' <ws> <Database>

    <catalog__code_as_data> ::=
        <Database>

    <catalog__plain_rtn_inv> ::=
          <catalog__code_as_data>
        | <depot_catalog_payload>

    <depot_catalog_payload> ::=
        '{' <ws>?
            [[
                  <subdepot>
                | <named_material>
                | <self_local_dbvar_type>
            ] ** <ws>]?
        <ws>? '}'

    <subdepot> ::=
        subdepot <ws> <subdepot_declared_name> <ws> <depot_catalog_payload>

    <subdepot_declared_name> ::=
        <Name_payload>

    <self_local_dbvar_type> ::=
        'self-local-dbvar-type' <ws> <PNSQNameChain_payload>

A C<depot> node specifies a single complete depot, which is the widest
scope user-defined DBMS entity that is a completely self-defined, and
doesn't rely on any user-defined entities external to itself to be
unambiguously understood.  A C<depot> node defines a (possibly empty)
system catalog database, holding user material (routine and type)
definitions, plus optionally a normal-user-data database.

A C<depot_catalog_payload> node in the PTMD_STD grammar is interpreted as a
Muldis D C<sys.std.Core.Type.Cat.Depot> value (which is also a C<Database>
value) whose attributes are defined by its child elements.

A C<subdepot> node specifies a single public entity namespace under a depot
and all of the C<subdepot> nodes under a C<depot> comprise a hierarchy of
such namespaces.

But a C<subdepot> node doesn't have a corresponding data type for its
entire content like with a C<depot_catalog_payload>; rather, a C<subdepot>
node hierarchy is stored flattened in the system catalog, such that each
tuple of the C<subdepots> attribute from the parent C<Depot> names one
subdepot that exists, and all the subdepot's materials are flattened into
tuples of the materials-defining attributes of the C<Depot>.

A C<self_local_dbvar_type> node specifies what the normal-user-data
database has as its declared data type.  The value of the C<data> attribute
of the parent C<Depot> is determined from this node.  Iff
C<self_local_dbvar_type> is not specified then C<depot_data> must be
omitted; iff C<self_local_dbvar_type> is specified then C<depot_data> must
be present.  The most liberal value of C<self_local_dbvar_type> is simply
C<Database>, meaning C<depot_data> may define any database value at all.  A
C<depot_catalog_payload> may have at most 1 C<self_local_dbvar_type>.

Examples:

    #`A completely empty depot that doesn't have a self-local dbvar.`#
    depot-catalog {}

    #`Empty depot with self-local dbvar with unrestricted allowed values.`#
    depot-catalog {
        self-local-dbvar-type Database
    }
    depot-data Database:{}

    #`A depot having just one function and no dbvar.`#
    depot-catalog {
        function cube (Int <-- topic : Int) {
            topic exp 3
        }
    }

# MATERIAL SPECIFICATION

Grammar:

    <material> ::=
          <function>
        | <procedure>
        | <scalar_type>
        | <tuple_type>
        | <relation_type>
        | <domain_type>
        | <subset_type>
        | <mixin_type>
        | <key_constr>
        | <distrib_key_constr>
        | <subset_constr>
        | <distrib_subset_constr>
        | <stim_resp_rule>

A C<material> node specifies a new material (routine or type) that lives in
a depot or subdepot.

A C<material> node in the PTMD_STD grammar corresponds directly to a tuple
of a (routine or type defining) attribute of a value of the catalog data
type C<sys.std.Core.Type.Cat.Depot>, which is how a material specification
is actually represented in Muldis D's nonsugared form, which is as a
component of the system catalog.  Or more specifically, an entire tree of
PTMD_STD C<material> nodes corresponds to a set of said attribute tuples,
one attribute tuple per C<material> node.  In the nonsugared form, every
C<material> node has an explicitly designated name, and all child nodes are
not declared inline with their parent nodes but rather are declared in
parallel with them, and the parents refer to their children by their names.
A feature of the PTMD_STD grammar is that material nodes may be declared
without explicit names, such that the parser would generate names for them
when deriving system catalog entries, and that is why PTMD_STD supports,
and encourages the use of for code brevity/readability, the use of
inline-declared material nodes, especially so when the C<material> in
question is a simple function or type that is only being used in one place,
such as a typical C<value-filter> function or a typical subset type.

When a C<material> node is contained within another C<material> node, the
first material is conceptually part of the implementation of the second
material; the first material is hereafter referred to as an I<inner>
material for this inter-material relationship.  When a C<material> node is
I<not> contained within any other C<material> node, but rather is directly
contained within a C<depot_catalog_payload> node, then this material is
hereafter referred to as an I<outer> material.  Both inner and outer
C<material> nodes may contain 0..N other (inner) C<material> nodes.

When a C<material> node defines an outer material C<foo> directly within a
subdepot (or depot) C<bar>, and C<foo> has no child inner materials, then
the material definition will be stored in the system catalog exactly as
conceived, as a new material named C<foo> directly in the subdepot C<bar>.
For example, the outer material will have the name C<fed.lib.mydb.bar.foo>.

In contrast, when said C<material> node has at least one child inner
material C<baz>, then what happens in the system catalog instead is that a
new subdepot named C<foo> is created directly in the subdepot C<bar> and
every one of the whole hierarchy of said C<material> nodes is stored
directly in the subdepot C<foo>; the outer material is stored under the
name that is the empty string, and its inner materials are stored under
their own names.  For example, the outer material will have the name
C<fed.lib.mydb.bar.foo.""> and the inner will be named
C<fed.lib.mydb.bar.foo.baz>.
Such a material hierarchy is stored in a flat namespace so it is required
for all inner materials having a common outer material to have distinct
declaration names, none of which are the empty string, regardless of
whether any of them was declared inside another inner material node or
directly inside the common outer node.

It is mandatory for outer C<material> nodes to have explicitly specified
declaration names, because they are expected to be invoked by name in the
general case, like any public routine or type.  An inner C<material> may
optionally have an explicitly specified declaration name, for either
self-documentation purposes or in case it might be invoked by name; however
an inner C<material> may also be anonymous, in which case it may only be
used inline with its declaration, or by way of an C<AbsPathMaterialNC>
value which
is defined inline with the material's declaration.  When an inner material
is declared as anonymous, it still actually has a name in the system
catalog (I<all> materials in the system catalog are named), but that name
is generated by the PTMD_STD parser; strictly speaking this material could
still be invoked by that name like an explicitly named one, but that would
not be a good practice; use explicit names if you want to invoke by name.
Strictly speaking, the algorithm to generate material names should be fully
deterministic, but the names would be non-descriptive so akin to random.

## Material Specification Common Elements

Every material has 2-3 elements, illustrated by this grammar:

    <x_material> ::=
        <named_material> | <anon_material>

    <named_material> ::=
        <material_kind> <ws> <material_declared_name>
            <ws> <material_payload>

    <anon_material> ::=
        <material_kind> <ws> <material_payload>

    <material_kind> ::=
          function
            | 'named-value'
            | 'value-map'
            | 'value-map-unary'
            | 'value-filter'
            | 'value-constraint'
            | 'value-reduction'
            | 'order-determination'
        | procedure
            | 'system-service'
            | transaction
            | recipe
            | updater
        | 'scalar-type'
        | 'tuple-type'
            | 'database-type'
        | 'relation-type'
        | 'domain-type'
        | 'subset-type'
        | 'mixin-type'
        | 'key-constraint'
            | 'primary-key'
        | 'distrib-key-constraint'
            | 'distrib-primary-key'
        | 'subset-constraint'
        | 'distrib-subset-constraint'
        | 'stimulus-response-rule'

    <material_declared_name> ::=
        <Name_payload>

    <material_payload> ::=
          <function_payload>
        | <procedure_payload>
        | <scalar_type_payload>
        | <tuple_type_payload>
        | <relation_type_payload>
        | <domain_type_payload>
        | <subset_type_payload>
        | <mixin_type_payload>
        | <key_constr_payload>
        | <distrib_key_constr_payload>
        | <subset_constr_payload>
        | <distrib_subset_constr_payload>
        | <stim_resp_rule_payload>

So a C<x_material>|C<material> node has 2-3 elements in general:

* C<material_kind>

This is a character string of the format C<< [<[ a..z ]>+] ** '-' >>; it
identifies the kind of the material and is the only external metadata of
C<material_payload> generally necessary to interpret the latter; what
grammars are valid for C<material_payload> depend just on C<material_kind>.

* C<material_declared_name>

This is the declared name of the material within the namespace defined by
its subdepot (or depot).  It is explicitly specified iff the C<material> is
a C<named_material>

* C<material_payload>

This is mandatory for all C<material>.  It specifies the entire material
sans its name.  Format varies with C<material_kind>.

For material examples, see the subsequent documentation sections.

Note that, for simplicity, the subsequent sections assume for now that
C<named_material> is the only valid option, and so the
C<material_declared_name> isn't optional, and the only way to embed a
material in another is using a C<with_clause>.

## Function Specification

Grammar:

    <function> ::=
        <function_kind>
        <ws> <material_declared_name>
        <ws> <function_payload>

    <function_kind> ::=
          function
        | 'named-value'
        | 'value-map'
        | 'value-map-unary'
        | 'value-filter'
        | 'value-constraint'
        | 'value-reduction'
        | 'order-determination'

    <function_payload> ::=
        <function_heading> <ws> <function_body>

    <function_heading> ::=
        <func_signature> [<ws> <implements_clause>]*

    <func_signature> ::=
        '(' <ws>?
            <result_type> <ws>? '<--'
            [<ws>? <func_param> ** [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? ')'

    <result_type> ::=
        <type_name>

    <func_param> ::=
        <ro_reg_param>

    <function_body> ::=
        <nonempty_function_body> | <empty_function_body>

    <nonempty_function_body> ::=
        '{' <ws>?
            [[<with_clause> | <named_expr>] <ws>]*
            <result_expr>
        <ws>? '}'

    <result_expr> ::=
        <expr>

    <empty_function_body> ::=
        '{' <ws>? '...' <ws>? '}'

A C<function> node specifies a new function that lives in a depot or
subdepot.  A C<function> node in the PTMD_STD grammar corresponds directly
to a tuple of the C<functions> attribute of a value of the catalog data
type C<sys.std.Core.Type.Cat.Depot>, which is how a function specification
is actually represented in Muldis D's nonsugared form, which is as a
component of the system catalog.  The C<functions> tuple has 2 primary
attributes, C<name> and C<material>, which are valued from the C<function>
node's C<material_declared_name> and C<function_payload> elements,
respectively.

A C<function_payload> specifies an entire function besides its name.  It is
interpreted as a Muldis D C<sys.std.Core.Type.Cat.Function> value.  The
C<function_heading> element specifies the function's public interface,
which is these 5 attributes of the new C<Function>: C<result_type>,
C<params>, C<opt_params>, C<dispatch_params>, C<implements>.  The
C<function_body> element specifies the function's implementation, which is
the 1 attribute C<expr> of the new C<Function>.

The C<function_kind> has no impact at all on the interpretation of a
C<function>.  However, it can serve to apply additional constraints on the
allowed values of the resulting C<Function>, in the manner of simple
subset-type constraints, and similarly it can serve to add
self-documentation to the intended purpose or use of the function.  Iff
C<function_kind> is C<function> then there are no such subset-type
constraints applied, as the node is simply denoting a generic function; any
other value of C<function_kind> means that the node is denoting a value of
a proper subtype of C<Function>, and so that subtype's respective
constraints are applied to the new C<Function>.  The various
C<function_kind> map to C<Function> subtypes as follows:

    function kind         | catalog data type
    ----------------------+------------------
    function              | Function
    named-value           | NamedValFunc
    value-map             | ValMapFunc
    value-map-unary       | ValMapUFunc
    value-filter          | ValFiltFunc
    value-constraint      | ValConstrFunc
    value-reduction       | ValRedFunc
    order-determination   | OrdDetFunc

The C<function_heading>'s C<result_type> is interpreted as the
C<Function>'s C<result_type> attribute.

Any of these kinds of components of a C<function> node are interpreted in
exactly the same manner as for a C<procedure> node, as a C<Function> is to
a C<Procedure>: C<ro_reg_param> (but that the C<Function> attribute is
named C<params> rather than C<ro_params>), C<implements_clause>,
C<empty_function_body>, C<with_clause>, C<named_expr>.

A C<nonempty_function_body> must have at least one C<expr>, because a
function must by definition result in a value, and that C<expr> says what
this result value is.  Said result-determining C<expr> must either not be a
C<named_expr> or it must be a C<named_expr> whose direct C<expr_name> is
the empty string; the latter option is saying explicitly what the parser
would otherwise name the C<expr> implicitly.  A C<nonempty_function_body>
may have at most one C<expr> that isn't a C<named_expr>, because it can
only have one result-determining C<expr>.

Examples:

    function cube (Int <-- topic : Int) {
        topic exp 3
    }

## Procedure Specification

Grammar:

    <procedure> ::=
        <procedure_kind>
        <ws> <material_declared_name>
        <ws> <procedure_payload>

    <procedure_kind> ::=
        procedure | 'system-service' | transaction | <recipe_kind>

    <recipe_kind> ::=
        recipe | updater

    <procedure_payload> ::=
        <procedure_heading> <ws> <procedure_body>

    <procedure_heading> ::=
        <proc_signature> [<ws> <implements_clause>]*

    <proc_signature> ::=
        '(' <ws>?
            [<proc_param> ** [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? ')'

    <proc_param> ::=
          <upd_reg_param>
        | <ro_reg_param>
        | <upd_global_param>
        | <ro_global_param>

    <upd_reg_param> ::=
        <upd_sigil> <ro_reg_param>

    <upd_sigil> ::=
        '&'

    <ro_reg_param> ::=
        <param_name> <param_flag>? <ws>? ':' <ws>? <type_name>

    <param_name> ::=
        <lex_entity_name>

    <lex_entity_name> ::=
        <Name_payload>

    <param_flag> ::=
        <opt_param_flag> | <dispatch_param_flag>

    <opt_param_flag> ::=
        '?'

    <dispatch_param_flag> ::=
        '@'

    <upd_global_param> ::=
        <upd_sigil> <ro_global_param>

    <ro_global_param> ::=
        <param_name> <ws>? <infix_bind_op> <ws>? <global_var_name>

    <infix_bind_op> ::=
        '::='

    <global_var_name> ::=
        <PNSQNameChain_payload>

    <implements_clause> ::=
        implements <ws> <routine_name>

    <routine_name> ::=
        <PNSQNameChain_payload>

    <procedure_body> ::=
          <nonempty_procedure_body> | <empty_procedure_body>
        | <nonempty_recipe_body> | <empty_recipe_body>

    <nonempty_procedure_body> ::=
        <nonempty_procedure_body_or_compound_stmt>

    <nonempty_recipe_body> ::=
        <nonempty_recipe_body_or_multi_upd_stmt>

    <nonempty_procedure_body_or_compound_stmt> ::=
        '[' <ws>?
            [[<with_clause> | <proc_var> | <named_expr> | <proc_stmt>]
                ** <ws>]*
        <ws>? ']'

    <nonempty_recipe_body_or_multi_upd_stmt> ::=
        '{' <ws>?
            [[<with_clause> | <named_expr> | <update_stmt>] ** <ws>]*
        <ws>? '}'

    <with_clause> ::=
        with <ws> <named_material>

    <proc_var> ::=
        var <ws> <var_name> <ws>? ':' <ws>? <type_name>

    <var_name> ::=
        <lex_entity_name>

    <empty_procedure_body> ::=
        '[' <ws>? '...' <ws>? ']'

    <empty_recipe_body> ::=
        '{' <ws>? '...' <ws>? '}'

A C<procedure> node specifies a new procedure that lives in a depot or
subdepot.  A C<procedure> node in the PTMD_STD grammar corresponds directly
to a tuple of the C<procedures> attribute of a value of the catalog data
type C<sys.std.Core.Type.Cat.Depot>, which is how a procedure specification
is actually represented in Muldis D's nonsugared form, which is as a
component of the system catalog.  The C<procedures> tuple has 2 primary
attributes, C<name> and C<material>, which are valued from the C<procedure>
node's C<material_declared_name> and C<procedure_payload> elements,
respectively.

A C<procedure_payload> specifies an entire procedure besides its name.  It
is interpreted as a Muldis D C<sys.std.Core.Type.Cat.Procedure> value.  The
C<procedure_heading> element specifies the procedure's public interface,
which is these 9 attributes of the new C<Procedure>: C<upd_params>,
C<ro_params>, C<opt_params>, C<upd_global_params>, C<ro_global_params>,
C<dispatch_params>, C<implements>, C<is_system_service>, C<is_transaction>.
The C<procedure_body> element specifies the procedure's implementation,
which is these 3 attributes of the new C<procedure>: C<vars>, C<exprs>,
C<stmt>.

The C<procedure_kind> often has no impact at all on the interpretation of a
C<procedure>.  However, it can serve to apply additional constraints on the
allowed values of the resulting C<procedure>, in the manner of simple
subset-type constraints, and similarly it can serve to add
self-documentation to the intended purpose or use of the procedure.  Iff
C<procedure_kind> is C<procedure> then there are no such subset-type
constraints applied, as the node is simply denoting a generic procedure;
any other value of C<procedure_kind> means that the node is denoting a
value of a proper subtype of C<procedure>, and so that subtype's respective
constraints are applied to the new C<procedure>.  Iff C<procedure_kind> is
a C<recipe_kind>, then C<procedure_body> is also constrained to be one of
C<[|non]empty_recipe_body>.  The C<procedure_kind> is
the sole determinant of the values of the C<is_system_service> and
C<is_transaction> attributes of the resulting C<Procedure>; for each valid
combination there also exists a C<Procedure> subtype.  The
various C<procedure_kind> map to attribute values and C<Procedure> subtypes
as follows:

    procedure kind | is_system_service | is_transaction | catalog data type
    ---------------+-------------------+----------------+------------------
    procedure      | Bool:False        | Bool:False     | Procedure
    system-service | Bool:True         | Bool:True      | SystemService
    transaction    | Bool:False        | Bool:True      | Transaction
    recipe         | Bool:False        | Bool:True      | Recipe
    updater        | Bool:False        | Bool:True      | Updater

Iff the C<procedure_heading> has at least one C<upd_reg_param> or
C<ro_reg_param>, then the procedure has one or more regular parameters,
which are what another routine can explicitly supply arguments for in an
invocation of the procedure; each regular parameter is either
subject-to-update or read-only.  Each C<upd_reg_param> is primarily
interpreted as a tuple of the C<procedure>'s C<upd_params> attribute, and
each C<ro_reg_param> is primarily interpreted as a tuple of the
C<procedure>'s C<ro_params> attribute; for each tuple, the C<param_name>
and C<type_name>, respectively, of the C<upd_reg_param> or C<ro_reg_param>
provide the tuple's C<name> and C<type> attribute.  Iff any of the
parameters have an C<opt_param_flag>, then those parameters are optional to
supply arguments for; for each parameter with an C<opt_param_flag>, the
C<procedure>'s C<opt_params> attribute has a tuple with the parameter's
C<param_name>.  Iff any of the parameters have a C<dispatch_param_flag>,
then the procedure is being explicitly declared to be a virtual procedure,
and so the C<procedure_body> must be C<empty_[procedure|recipe]_body>; for
each parameter with a C<dispatch_param_flag>, the C<procedure>'s
C<dispatch_params> attribute has a tuple with the parameter's
C<param_name>.

Iff the C<procedure_heading> has at least one C<upd_global_param> or
C<ro_global_param>, then the procedure has one or more global parameters,
which are lexical aliases for global variables; each global parameter is
either subject-to-update or read-only.  Each C<upd_global_param> is
primarily interpreted as a tuple of the C<procedure>'s C<upd_global_params>
attribute, and each C<ro_global_param> is primarily interpreted as a tuple
of the C<procedure>'s C<ro_global_params> attribute; for each tuple, the
C<param_name> and C<global_var_name>, respectively, of the
C<upd_global_param> or C<ro_global_param> provide the tuple's C<name> and
C<global> attribute.

Iff the C<procedure_heading> has at least one C<implements_clause>, then
the procedure is explicitly declaring that it implements one or more
virtual procedure, one being named by each C<implements_clause>.  Each
C<implements_clause> is interpreted as a tuple of the C<procedure>'s
C<implements> attribute.

Iff the C<procedure_body> is an C<empty_[procedure|recipe]_body>, then the
C<procedure>'s C<vars>, C<exprs> and C<stmt> attributes are all empty.

Iff the C<procedure_body> has at least one C<with_clause>, then the
procedure is explicitly declaring that it has one or more inner materials,
such that the other materials are conceptually part of the implementation
of the procedure; each C<with_clause> specifies one inner material in its
C<named_material> element.  A C<with_clause> is not interpreted as any part
of the C<procedure> but rather results in other additions to its parent
C<Depot>, in a manner similar to as if the C<named_material> were specified
externally of the C<procedure> node; but see the **MATERIAL SPECIFICATION**
main description for details on the complete effects of specifying an inner
material.

Iff the C<procedure_body> has at least one C<proc_var>, then the procedure
has one or more regular lexical variables.  Each C<proc_var> is interpreted
as a tuple of the C<Procedure>'s C<vars> attribute; for each tuple, the
C<var_name> and C<type_name>, respectively, of the C<proc_var> provide the
tuple's C<name> and C<type> attribute.

Iff the C<procedure_body> directly has at least one C<named_expr>, then
each such C<named_expr> is interpreted as a tuple of an attribute of the
C<procedure>'s C<exprs> attribute such that said tuple's C<name> is
explicitly user-defined rather than generated by the parser.  Any C<expr>
contained in a C<procedure_body> by way of one of its direct C<proc_stmt>
or C<named_expr> will similarly be interpreted as a tuple of an attribute
of the C<procedure>'s C<exprs> attribute, where said tuple's C<name> is
either user-defined or generated as appropriate for the kind of C<expr>.

Each C<proc_stmt> of a C<nonempty_procedure_body> is interpreted as a tuple
of an attribute of the the C<Procedure>'s C<stmt> attribute.  A
C<proc_stmt> may also, and typically does, also have nested C<proc_stmt>,
thereby forming a tree, and that tree is flattened with each nested
C<proc_stmt> becoming its own tuple under C<stmt> like with the first.  In
fact, all of a procedure's statements form a single statement tree, and the
root node of this tree is an implicit compound statement node (whose name
is the empty string) whose direct child statements are all of the direct
child C<proc_stmt> elements of the C<nonempty_procedure_body>, in order.
Iff a C<nonempty_procedure_body> has no C<proc_stmt> member elements, then
the procedure has a defined body that is an unconditional no-op.

A C<nonempty_recipe_body> must have at least one C<update_stmt>, because
a recipe must by definition update at least one of its (regular or
global) parameters, though possibly to the same value it already has, lest
it otherwise be an unconditional no-op.  Each C<update_stmt> is interpreted
as a tuple of the C<procedure>'s C<stmt> attribute.

Examples:

    procedure print_curr_time () [
        var now : Instant
        fetch_trans_instant( &now )
        write_Text_line( 'The current time is: '
            ~ nlx.par.lib.utils.time_as_text( time => now ) )
    ]

    recipe count_heads (&count : NNInt, search : Text,
            people ::= fed.data.db1.people) {
        with value-filter filt (Bool <-- topic : Tuple, search : Text) {
            .name like ('%' ~ search ~ '%')
        }
        count := #(people where <nlx.lib.filt>( =>search ))
    }

    updater make_coprime (&a : NNInt, &b : NNInt) {
        with function gcd (NNInt <-- a : NNInt, b : NNInt) {
            b = 0 ?? a !! rtn( a => b, b => a mod b round Down )
        }
        let gcd ::= nlx.lib.gcd( =>a, =>b )
        a := a div gcd round Down
        b := b div gcd round Down
    }

## Scalar Type Specification

Grammar:

    <scalar_type> ::=
        'scalar-type'
        <ws> <material_declared_name>
        <ws> <scalar_type_payload>

    <scalar_type_payload> ::=
        '{' <ws>?
            [
                  <with_clause>
                | <composes_clause>
                | <base_type_clause>
                | <subtype_constraint_clause>
                | <possrep>
                | <possrep_map>
                | <default_clause>
            ] ** <ws>
        <ws>? '}'

    <subtype_constraint_clause> ::=
        'subtype-constraint' <ws> <routine_name>

    <possrep> ::=
        possrep <ws>
        <possrep_name> <ws>
        '{' <ws>?
            <tuple_type_clause>
            [<ws> <is_base_clause>]?
        <ws>? '}'

    <is_base_clause> ::=
        'is-base'

    <possrep_map> ::=
        'possrep-map' <ws>
        '{' <ws>?
            <p2> <ws> from <ws> <p1>
            <ws> using <ws> <routine_name>
            <ws> 'reverse-using' <ws> <routine_name>
        <ws>? '}'

    <p1> ::=
        <possrep_name>

    <p2> ::=
        <possrep_name>

A C<scalar_type> node specifies a new scalar type that lives in a depot or
subdepot.  A C<scalar_type> node in the PTMD_STD grammar corresponds
directly to a tuple of the C<scalar_types> attribute of a value of the
catalog data type C<sys.std.Core.Type.Cat.Depot>, which is how a scalar
type specification is actually represented in Muldis D's nonsugared form,
which is as a component of the system catalog.  The C<scalar_types> tuple
has 2 primary attributes, C<name> and C<material>, which are valued from
the C<scalar_type> node's C<material_declared_name> and
C<scalar_type_payload> elements, respectively.

A C<scalar_type_payload> specifies an entire scalar type besides its name.
It is interpreted as a Muldis D C<sys.std.Core.Type.Cat.ScalarType> value.

I<TODO: The remaining description.>

I<TODO: Examples.>

## Tuple Type Specification

Grammar:

    <tuple_type> ::=
        <tuple_type_kind>
        <ws> <material_declared_name>
        <ws> <tuple_type_payload>

    <tuple_type_kind> ::=
        'tuple-type' | 'database-type'

    <tuple_type_payload> ::=
        '{' <ws>?
            [
                  <with_clause>
                | <composes_clause>
                | <base_type_clause>
                | <tuple_attr>
                | <virtual_attr_map>
                | <constraint_clause>
                | <default_clause>
            ] ** <ws>
        <ws>? '}'

    <tuple_attr> ::=
        attr <ws> <attr_name_lex> <ws>? ':' <ws>? <type_name>

    <attr_name_lex> ::=
        <lex_entity_name>

    <virtual_attr_map> ::=
        'virtual-attr-map' <ws>
        '{' <ws>?
            'determinant-attrs' <ws> <aliased_attr_list>
            <ws> 'dependent-attrs' <ws> <aliased_attr_list>
            <ws> 'map-function' <ws> <routine_name>
            [<ws> <is_updateable_clause>]?
        <ws>? '}'

    <aliased_attr_list> ::=
        '{' <ws>?
            [[<aliased_attr_pair> | <same_named_nonord_atvl>]
                ** [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'

    <aliased_attr_pair> ::=
        <attr_name_lex> <ws>? '=>' <ws>? <attr_nc_lex>

    <is_updateable_clause> ::=
        'is-updateable'

A C<tuple_type> node specifies a new tuple type that lives in a depot or
subdepot.  A C<tuple_type> node in the PTMD_STD grammar corresponds
directly to a tuple of the C<tuple_types> attribute of a value of the
catalog data type C<sys.std.Core.Type.Cat.Depot>, which is how a tuple
type specification is actually represented in Muldis D's nonsugared form,
which is as a component of the system catalog.  The C<tuple_types> tuple
has 2 primary attributes, C<name> and C<material>, which are valued from
the C<tuple_type> node's C<material_declared_name> and
C<tuple_type_payload> elements, respectively.

A C<tuple_type_payload> specifies an entire tuple type besides its name.
It is interpreted as a Muldis D C<sys.std.Core.Type.Cat.TupleType> value.

The C<tuple_type_kind> has no impact at all on the interpretation of a
C<tuple_type>.  However, it can serve to apply additional constraints on
the allowed values of the resulting C<TupleType>, in the manner of simple
subset-type constraints, and similarly it can serve to add
self-documentation to the intended purpose or use of the tuple type.  Iff
C<tuple_type_kind> is C<tuple-type> then there are no such subset-type
constraints applied, as the node is simply denoting a generic tuple type;
iff C<tuple_type_kind> is C<database-type> then there is a constraint
applied such that the node is denoting a database type.

I<TODO: The remaining description.>

Examples:

    #`db schema with 3 relvars, 2 subset constrs, the 5 def separately`#
    database-type CD_DB {
        attr artists : nlx.lib.Artists
        attr cds     : nlx.lib.CDs
        attr tracks  : nlx.lib.Tracks
        constraint nlx.lib.sc_artist_has_cds
        constraint nlx.lib.sc_cd_has_tracks
    }

    #`relation type using tuple virtual-attr-map for case-insen key attr
      where primary text data is case-sensitive, case-preserving`#
    relation-type Locations {
        tuple-type nlx.lib.Location
        with tuple-type Location {
            attr loc_name    : Text
            attr loc_name_uc : Text
            virtual-attr-map {
                determinant-attrs { =>loc_name }
                dependent-attrs { =>loc_name_uc }
                map-function nlx.lib.uc_loc_name
            }
            with value-map-unary uc_loc_name (Tuple <-- topic : Tuple) {
                %:{ loc_name_uc => upper( .loc_name ) }
            }
        }
        constraint nlx.lib.sk_loc_name_uc
        with key-constraint sk_loc_name_uc { loc_name_uc }
    }

    #`db schema with 2 real relvars, 1 virtual relvar; all are updateable
      real products has attrs { product_id, name }
      real sales has attrs { product_id, qty }
      virtual combines has attrs { product_id, name, qty }`#
    database-type DB {
        attr products : nlx.lib.Products
        attr sales    : nlx.lib.Sales
        attr combines : nlx.lib.Combines
        virtual-attr-map {
            determinant-attrs { =>products, =>sales }
            dependent-attrs { =>combines }
            map-function nlx.lib.combine_p_s
            is-updateable
        }
        with value-map-unary combine_p_s (Database <-- topic : Database) {
            Database:{ combines => .products join .sales }
        }
    }

## Relation Type Specification

Grammar:

    <relation_type> ::=
        'relation-type'
        <ws> <material_declared_name>
        <ws> <relation_type_payload>

    <relation_type_payload> ::=
        '{' <ws>?
            [
                  <with_clause>
                | <composes_clause>
                | <base_type_clause>
                | <tuple_type_clause>
                | <constraint_clause>
                | <default_clause>
            ] ** <ws>
        <ws>? '}'

    <tuple_type_clause> ::=
        tuple-type <ws> <type_name>

A C<relation_type> node specifies a new relation type that lives in a depot
or subdepot.  A C<relation_type> node in the PTMD_STD grammar corresponds
directly to a tuple of the C<relation_types> attribute of a value of the
catalog data type C<sys.std.Core.Type.Cat.Depot>, which is how a relation
type specification is actually represented in Muldis D's nonsugared form,
which is as a component of the system catalog.  The C<relation_types> tuple
has 2 primary attributes, C<name> and C<material>, which are valued from
the C<relation_type> node's C<material_declared_name> and
C<relation_type_payload> elements, respectively.

A C<relation_type_payload> specifies an entire relation type besides its
name.  It is interpreted as a Muldis D
C<sys.std.Core.Type.Cat.RelationType> value.

I<TODO: The remaining description.>

Examples:

    relation-type Artists {
        with tuple-type Artist {
            attr artist_id   : Int
            attr artist_name : Text
        }
        with primary-key pk_artist_id { artist_id }
        with key-constraint sk_artist_name { artist_name }
        tuple-type nlx.lib.Artist
        constraint nlx.lib.pk_artist_id
        constraint nlx.lib.sk_artist_name
    }

    relation-type CDs {
        with tuple-type CD {
            attr cd_id     : Int
            attr artist_id : Int
            attr cd_title  : Text
        }
        with primary-key pk_cd_id { cd_id }
        with key-constraint sk_cd_title { cd_title }
        tuple-type nlx.lib.CD
        constraint nlx.lib.pk_cd_id
        constraint nlx.lib.sk_cd_title
    }

## Domain Type Specification

Grammar:

    <domain_type> ::=
        'domain-type'
        <ws> <material_declared_name>
        <ws> <domain_type_payload>

    <domain_type_payload> ::=
        '{' <ws>?
            [
                  <with_clause>
                | <composes_clause>
                | <domain_sources>
                | <domain_filters>
                | <constraint_clause>
                | <default_clause>
            ] ** <ws>
        <ws>? '}'

    <domain_sources> ::=
        ['source-union' | 'source-intersection'] <ws>
        '{' <ws>?
            [<type_name> | <type_name> ** [<ws>? ',' <ws>?] [<ws>? ',']?]
        <ws>? '}'

    <domain_filters> ::=
        ['filter-union' | 'filter-intersection'] <ws>
        '{' <ws>?
            [<type_name> ** [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'

A C<domain_type> node specifies a new domain type that lives in a depot or
subdepot.  A C<domain_type> node in the PTMD_STD grammar corresponds
directly to a tuple of the C<domain_types> attribute of a value of the
catalog data type C<sys.std.Core.Type.Cat.Depot>, which is how a domain
type specification is actually represented in Muldis D's nonsugared form,
which is as a component of the system catalog.  The C<domain_types> tuple
has 2 primary attributes, C<name> and C<material>, which are valued from
the C<domain_type> node's C<material_declared_name> and
C<domain_type_payload> elements, respectively.

A C<domain_type_payload> specifies an entire domain type besides its name.
It is interpreted as a Muldis D C<sys.std.Core.Type.Cat.DomainType> value.

I<TODO: The remaining description.>

I<TODO: Examples.>

## Subset Type Specification

Grammar:

    <subset_type> ::=
        'subset-type'
        <ws> <material_declared_name>
        <ws> <subset_type_payload>

    <subset_type_payload> ::=
        <subset_type_pl_long> | <subset_type_pl_short>

    <subset_type_pl_long> ::=
        '{' <ws>?
            [
                  <with_clause>
                | <composes_clause>
                | <base_type_clause>
                | <constraint_clause>
                | <default_clause>
            ] ** <ws>
        <ws>? '}'

    <base_type_clause> ::=
        ['base-type' | of] <ws> <type_name>

    <constraint_clause> ::=
        [constraint | where] <ws> <constraint_name>

    <constraint_name> ::=
        <PNSQNameChain_payload>

    <default_clause> ::=
        default <ws> <routine_name>

    <subset_type_pl_short> ::=
        <base_type_clause>
        [<ws> <constraint_clause>]?
        [<ws> <default_clause>]?

A C<subset_type> node specifies a new subset type that lives in a depot or
subdepot.  A C<subset_type> node in the PTMD_STD grammar corresponds
directly to a tuple of the C<subset_types> attribute of a value of the
catalog data type C<sys.std.Core.Type.Cat.Depot>, which is how a subset
type specification is actually represented in Muldis D's nonsugared form,
which is as a component of the system catalog.  The C<subset_types> tuple
has 2 primary attributes, C<name> and C<material>, which are valued from
the C<subset_type> node's C<material_declared_name> and
C<subset_type_payload> elements, respectively.

A C<subset_type_payload> specifies an entire subset type besides its name.
It is interpreted as a Muldis D C<sys.std.Core.Type.Cat.SubsetType> value.

I<TODO: The remaining description.>

I<TODO: Examples.>

## Mixin Type Specification

Grammar:

    <mixin_type> ::=
        'mixin-type'
        <ws> <material_declared_name>
        <ws> <mixin_type_payload>

    <mixin_type_payload> ::=
        '{' <ws>?
            [[
                  <with_clause>
                | <composes_clause>
            ] ** <ws>]?
        <ws>? '}'

    <composes_clause> ::=
        composes <ws> <type_name> [<ws> <prov_def_clause>]?

    <prov_def_clause> ::=
        'and-provides-its-default'

A C<mixin_type> node specifies a new mixin type that lives in a depot or
subdepot.  A C<mixin_type> node in the PTMD_STD grammar corresponds
directly to a tuple of the C<mixin_types> attribute of a value of the
catalog data type C<sys.std.Core.Type.Cat.Depot>, which is how a mixin
type specification is actually represented in Muldis D's nonsugared form,
which is as a component of the system catalog.  The C<mixin_types> tuple
has 2 primary attributes, C<name> and C<material>, which are valued from
the C<mixin_type> node's C<material_declared_name> and
C<mixin_type_payload> elements, respectively.

A C<mixin_type_payload> specifies an entire mixin type besides its name.
It is interpreted as a Muldis D C<sys.std.Core.Type.Cat.MixinType> value.

I<TODO: The remaining description.>

I<TODO: Examples.>

## Key Constraint Specification

Grammar:

    <key_constr> ::=
        <key_constr_kind>
        <ws> <material_declared_name>
        <ws> <key_constr_payload>

    <key_constr_kind> ::=
        'key-constraint' | 'primary-key'

    <key_constr_payload> ::=
        '{' <ws>?
            [<attr_name_lex> ** [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'

A C<key_constr> node specifies a new unique key constraint or candidate
key, for a relation type, that lives in a depot or subdepot.  A
C<key_constr> node in the PTMD_STD grammar corresponds directly to a tuple
of the C<key_constrs> attribute of a value of the catalog data type
C<sys.std.Core.Type.Cat.Depot>, which is how a unique key constraint
specification is actually represented in Muldis D's nonsugared form, which
is as a component of the system catalog.  The C<key_constrs> tuple has 2
primary attributes, C<name> and C<material>, which are valued from the
C<key_constr> node's C<material_declared_name> and C<key_constr_payload>
elements, respectively.

A C<key_constr_payload> specifies an entire unique key constraint or
candidate key, for a relation type, besides its name.  It is interpreted as
a Muldis D C<sys.std.Core.Type.Cat.KeyConstr> value.  Each C<attr_name_lex>
element of a C<key_constr_payload> is interpreted as a tuple of the
C<KeyConstr>'s C<attrs> attribute.  Iff there are no C<attr_name_lex>, then
we have a nullary key which restricts the relation to have a maximum of 1
tuple.  The C<key_constr_kind> element of a C<key_constr> node is the sole
determinant of the value of the C<is_primary> attribute of the resulting
C<KeyConstr>; C<primary-key> means C<Bool:True>, while C<key-constraint>
means C<Bool:False>.

Examples:

    #`at most one tuple allowed`#
    key-constraint maybe_one {}

    #`relation type's artist_id attr is its primary key`#
    primary-key pk_artist_id { artist_id }

    #`relation type has surrogate key over both name attrs`#
    key-constraint sk_name { last_name, first_name }

## Distributed Key Constraint Specification

I<TODO.>

## Subset Constraint Specification

Grammar:

    <subset_constr> ::=
        'subset-constraint'
        <ws> <material_declared_name>
        <ws> <subset_constr_payload>

    <subset_constr_payload> ::=
        '{' <ws>?
            parent <ws> <parent> <ws> 'using-key' <ws> <parent_key>
            <ws> child <ws> <child> <ws> 'using-attrs' <ws> <sc_attr_map>
        <ws>? '}'

    <parent> ::=
        <attr_nc_lex>

    <attr_nc_lex> ::=
        <lex_entity_nc>

    <lex_entity_nc> ::=
        <NameChain_payload>

    <parent_key> ::=
        <constraint_name>

    <child> ::=
        <attr_nc_lex>

    <sc_attr_map> ::=
        '{' <ws>?
            [[<sc_attr_pair> | <same_named_nonord_atvl>]
                ** [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'

    <sc_attr_pair> ::=
        <child_attr> <ws>? '=>' <ws>? <parent_attr>

    <child_attr> ::=
        <attr_name_lex>

    <parent_attr> ::=
        <attr_name_lex>

A C<subset_constr> node specifies a (non-distributed) subset constraint
(foreign key constraint) over relation-valued attributes, for a tuple type,
that lives in a depot or subdepot.  A C<subset_constr> node in the PTMD_STD
grammar corresponds directly to a tuple of the C<subset_constrs> attribute
of a value of the catalog data type C<sys.std.Core.Type.Cat.Depot>, which
is how a (non-distributed) subset constraint
specification is actually represented in Muldis D's nonsugared form,
which is as a component of the system catalog.  The C<subset_constrs> tuple
has 2 primary attributes, C<name> and C<material>, which are valued from
the C<subset_constr> node's C<material_declared_name> and
C<subset_constr_payload> elements, respectively.

A C<subset_constr_payload> specifies an entire (non-distributed) subset
constraint, for a relation type, besides its name.  It is interpreted
as a Muldis D C<sys.std.Core.Type.Cat.SubsetConstr> value.

I<TODO: The remaining description.>

Examples:

    #`relation foo must have exactly 1 tuple when bar has at least 1`#
    subset-constraint sc_mutual_inclusion {
        parent foo using-key nlx.lib.maybe_one
        child bar using-attrs {}
    }

    subset-constraint sc_artist_has_cds {
        parent artists using-key nlx.lib.Artists.pk_artist_id
        child cds using-attrs { =>artist_id }
    }

## Distributed Subset Constraint Specification

I<TODO.>

## Stimulus-Response Rule Specification

Grammar:

    <stim_resp_rule> ::=
        'stimulus-response-rule'
        <ws> <material_declared_name>
        <ws> <stim_resp_rule_payload>

    <stim_resp_rule_payload> ::=
        when <ws> <stimulus> <ws> invoke <ws> <response>

    <stimulus> ::=
        'after-mount'

    <response> ::=
        <routine_name>

A C<stim_resp_rule> node specifies a new stimulus-response rule that lives
in a depot or subdepot.  A C<stim_resp_rule> node in the PTMD_STD grammar
corresponds directly to a tuple of the C<stim_resp_rules> attribute of a
value of the catalog data type C<sys.std.Core.Type.Cat.Depot>, which is how
a stimulus-response rule specification is actually represented in Muldis
D's nonsugared form, which is as a component of the system catalog.  The
C<stim_resp_rules> tuple has 2 primary attributes, C<name> and C<material>,
which are valued from the C<stim_resp_rule> node's
C<material_declared_name> and C<stim_resp_rule_payload> elements,
respectively.

A C<stim_resp_rule_payload> specifies an entire stimulus-response rule
besides its name.  It is interpreted as a Muldis D
C<sys.std.Core.Type.Cat.StimRespRule> value.  The C<stimulus> and
C<response> elements specify the C<stimulus> and C<response> attributes,
respectively, of the new C<StimRespRule>, which is the kind of stimulus and
the name of the procedure being invoked in response.  Currently,
C<after-mount> is the only kind of stimulus supported; other kinds will be
defined in the future.

Examples:

    stimulus-response-rule bootstrap {
        when after-mount
        invoke nlx.lib.main
    }

# GENERIC VALUE EXPRESSIONS

Grammar:

    <expr__plain_rtn_inv> ::=
          <delim_expr>
        | <expr_name>
        | <named_expr>
        | <value>
        | <accessor>
        | <func_invo>
        | <if_else_expr>
        | <given_when_def_expr>
        | <material_ref_sel_expr>

    <expr__rtn_inv_alt_syn> ::=
          <expr__plain_rtn_inv>
        | <func_invo_alt_syntax>

    <delim_expr> ::=
        '(' <ws>? <expr> <ws>? ')'

    <expr_name> ::=
        <lex_entity_name>

    <named_expr> ::=
        [let <ws>]? <expr_name> <ws> <infix_bind_op> <ws> <expr>

An C<expr> node is the general case of a Muldis D value expression tree
(which normally denotes a Muldis D value selector), which must be composed
beneath a C<depot>, or specifically into a routine or
type or constraint (etc) definition, because in the general case
an C<expr> can I<not> be completely evaluated at compile time.

An C<expr> node is a proper superset of a C<value> node, and any
occurrences of C<expr> nodes in this document may optionally be substituted
with C<value> nodes on a per-instance basis.

An C<expr> node in the PTMD_STD grammar corresponds directly to a tuple of
an attribute of a value of the catalog data type
C<sys.std.Core.Type.Cat.ExprNodeSet>, which is how a value expression node
is actually represented in Muldis D's nonsugared form, which is as a
component of the system catalog.  Or more specifically, an entire tree of
PTMD_STD C<expr> nodes corresponds to a set of said attribute tuples, one
attribute tuple per C<expr> node.  In the nonsugared form, every C<expr>
node has an explicitly designated name, as per a PTMD_STD C<named_expr>
node, and all child nodes are not declared inline with their parent nodes
but rather are declared in parallel with them, and the parents refer to
their children by their names.  A feature of the PTMD_STD grammar is that
expression nodes may be declared without explicit names, such that the
parser would generate names for them when deriving system catalog entries,
and that is why PTMD_STD supports, and encourages the use of for code
brevity/readability, the use of inline-declared expression nodes,
especially so when the C<expr> in question is an C<opaque_value_literal>.

Iff an C<expr> is a C<delim_expr>, then it is interpreted simply as if it
were its child C<expr> element; the I<only> reason that the C<delim_expr>
grammar element exists is to assist the parser in determining the
boundaries of an C<expr> where code otherwise might be ambiguous or be
interpreted differently than desired due to nesting precedence rules (see
**NESTING PRECEDENCE RULES** for more about those).  There is never a
distinct node in a parser's output for a C<delim_expr> itself.

Iff an C<expr> is an C<expr_name>, then this typically means that the
parent C<expr> is having at least one of its children declared with an
explicit name rather than inline, same as the corresponding system catalog
entry would do, and then the C<expr_name> is the invocation name of that
child.  Alternately, the C<expr_name> may be the invocation name of one of
the expression-containing routine's parameters, in which case the C<expr>
in question represents the current argument to that parameter; this also is
exactly the same as a corresponding catalog entry for using an argument.

Iff an C<expr> is a C<named_expr>, then the C<expr> element of the
C<named_expr> is being declared with an explicit name, and the C<expr_name>
element of the C<named_expr> is that name.  But if the C<expr> element of
the C<named_expr> is an C<expr_name> (or a C<named_expr> I<TODO: or a
C<param> >), then the C<named_expr> is in fact declaring a new node itself
(rather than simply naming its child node), which is a tuple of a Muldis D
C<sys.std.Core.Type.Cat.AccExprNodeSet> value; the new node is simply
declaring an alias for another node, namely the C<expr> element.

Examples:

    #`an expr_name node`#
    foo_expr

    #`a named_expr node`#
    let bar_expr ::= factorial( foo_expr )

## Generic Expression Attribute Accessors

Grammar:

    <accessor> ::=
        <acc_via_named> | <acc_via_topic> | <acc_via_anon>

    <acc_via_named> ::=
        <lex_entity_nc>

    <acc_via_topic> ::=
        '.' <NameChain_payload>

    <acc_via_anon> ::=
        <expr> <unspace> '.' <nc_nonempty>

An C<accessor> node represents an accessor or alias for an attribute of
another, tuple-valued expression node.  It is interpreted as a tuple of a
Muldis D C<sys.std.Core.Type.Cat.AccExprNodeSet> value.  If an C<accessor>
is an C<acc_via_named>, then the C<NameChain_payload> element specifies
the C<target> attribute of the new C<AccExprNodeSet>.  If an C<accessor> is
an C<acc_via_topic>, then it is interpreted in exactly the same manner as
for an C<acc_via_named> except that the C<NameChain_payload> element is
interpreted with a C<topic> element prepended to it; so for example a
C<.foo> is treated as being C<topic.foo>.  If an C<accessor> is
an C<acc_via_anon>, then the C<target> is derived from a catenation of the
node name that C<expr> has (explicitly or that will be generated for it by
the parser) with the C<nc_nonempty> in that order.  Note that an
C<acc_via_anon> whose C<expr> is an C<expr_name> is also an
C<acc_via_named>, and vice-versa.

Examples:

    #`an accessor node of a named tuple-valued node`#
    foo_t.bar_attr

    #`an accessor node of a tuple-valued node named "topic"`#
    .attr  #`same as topic.attr`#

    #`an accessor node of an anonymous tuple-valued node`#
    nlx.lib.tuple_res_func( arg ).quux_attr

## Generic Function Invocation Expressions

Grammar:

    <func_invo> ::=
        <routine_name> <unspace> <func_arg_list>

    <func_arg_list> ::=
        '(' <ws>?
            [<func_arg> ** [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? ')'

    <func_arg> ::=
        <named_ro_arg> | <anon_ro_arg> | <same_named_ro_arg>

A C<func_invo> node represents the result of invoking a named
function with specific arguments.  It is interpreted as a tuple of a
Muldis D C<sys.std.Core.Type.Cat.FuncInvoExprNodeSet> value.  The
C<routine_name> element specifies the C<function> attribute of the new
C<FuncInvoExprNodeSet>, which is the name of the function being invoked,
and the C<func_arg_list> element specifies the C<args> attribute.

In the general case of a function invocation, all of the arguments are
named, as per C<named_ro_arg>, and formatting a C<func_invo> node that
way is always allowed.  In some (common) special cases, some (which might
be all) arguments may be anonymous, as per C<anon_ro_arg>.

With just functions in the top-level namespaces C<sys.std>,
these 4 special cases apply:  If a function has exactly one parameter, then
it may be invoked with a single anonymous argument and the latter will bind
to that parameter.  Or, if a function has multiple parameters but exactly
one of those is mandatory, then it may be invoked with just one anonymous
argument, which is assumed to bind to the single mandatory parameter, and
all optional arguments must be named.  Or, if a function has multiple
mandatory parameters and one of them is named C<topic>, then it may be
invoked with a single anonymous argument and the latter will bind to that
parameter.  Or, if a function has multiple mandatory parameters and two of
them are named C<topic> and C<other>, then it may be invoked with two
anonymous arguments and the latter will bind to those parameters in
sequential order, the first one to C<topic> and the second one to C<other>.

With just functions in all top-level namespaces I<except> C<sys.std>,
these 2 special cases apply (similar to the prior-mentioned latter
2):  If a function invocation has either 1 or 2 anonymous arguments, then
they will be treated as if they were named arguments for the C<topic> and
C<other> parameters; the only or sequentially first argument will bind to
C<topic>, and any sequentially second argument will bind to C<other>.

One reason for this difference between treatment of top-level namespaces is
it allows the Muldis D parser to convert all the anonymous arguments to
named ones (all arguments in the system catalog are named) when parsing the
expression-containing routine/etc in isolation from any other
user-defined entities.  The other reason for this limitation is that it
helps with self-documentation; programmers wanting to know an anonymous
argument's parameter name won't have to look outside the
language spec to find the answer.

I<Maybe TODO:  Consider adding a language pragma to enable use of the first
4 special cases with functions in all top-level namespaces, where the cost
of enabling is added implementation complexity and a reduction of the
ability to parse exploiting Muldis D code piecemeal.>

A special shorthand for C<named_ro_arg> also exists, C<same_named_ro_arg>,
which may be used only if the C<expr> of the otherwise-C<named_ro_arg> is
an C<expr_name> and that C<expr_name> is identical to the
C<invo_param_name>.
In this situation, the identical name can be specified just once, which is
the shorthand; for example, the named argument C<< foo => foo >> may
alternately be written out as C<< =>foo >>.
This shorthand is to help with the possibly common
situation where two successive routines in a call-chain have any same-named
parameters and arguments are simply being passed through.
(This shorthand is like Raku's C<:$a> being short for C<< a => $a >>.)

Examples:

    #`zero params`#
    Nothing()

    #`single mandatory param`#
    median( Bag:{ 22, 20, 21, 20, 21, 21, 23 } )

    #`single mandatory param`#
    factorial( topic => 5 )

    #`two mandatory params`#
    frac_quotient( dividend => 43.7, divisor => 16.9 )

    #`same as previous`#
    frac_quotient( divisor => 16.9, dividend => 43.7 )

    #`one mandatory 'topic' param, two optional`#
    nlx.lib.barfunc( mand_arg, oa1 => opt_arg1, oa2 => opt_arg2 )

    #`same as previous`#
    nlx.lib.barfunc( oa2 => opt_arg2, mand_arg, oa1 => opt_arg1 )

    #`a user-defined function`#
    nlx.lib.foodb.bazfunc( a1 => 52, a2 => 'hello world' )

    #`two params named 'topic' and 'other'`#
    is_same( foo, bar )

    #`invoke the lexically innermost routine with 2 args`#
    rtn( x, y )

    #`three named params taking 2 same-named args, 1 diff-named arg`#
    nlx.lib.passed_thru( =>a, b => 5, =>c )

## Generic If-Else Expressions

Grammar:

    <if_else_expr> ::=
          if <ws> <if_expr> <ws> then <ws> <then_expr>
            <ws> else <ws> <else_expr>
        | <if_expr> <ws> '??' <ws> <then_expr> <ws> '!!' <ws> <else_expr>

    <if_expr> ::=
        <expr>

    <then_expr> ::=
        <expr>

    <else_expr> ::=
        <expr>

An C<if_else_expr> node represents a ternary if-then-else control flow
expression.  It is interpreted as a tuple of a Muldis D
C<sys.std.Core.Type.Cat.IfElseExprNodeSet> value.  The C<if_expr>,
C<then_expr>, and C<else_expr> elements specify the C<if>, C<then>, and
C<else> attributes, respectively, of the new C<IfElseExprNodeSet>;
C<if_expr> is the condition to evaluate at runtime and must result in a
C<Bool>; iff the result of that condition is C<Bool:True> then the
C<then_expr> is evaluated and its result is the result of the whole
if-then-else expression at runtime; otherwise, the C<else_expr> is
evaluated and its result is the whole if-then-else's result.

Examples:

    if foo > 5 then bar else baz

    if is_empty(ary) then empty_result else ary.[0]

    if x = ∅ or y = ∅ then ∅ else Just:{x.{*} + (y.{*} exp 3)}

    if val isa <Int> then val exp 3
        else if val isa <Text> then val ~# 5
        else True

    'My answer is: ' ~ (maybe ?? 'yes' !! 'no')

## Generic Given-When-Default Expressions

Grammar:

    <given_when_def_expr> ::=
        given <ws> <given_expr> <ws>
        [when <ws> <when_expr> <ws> then <ws> <then_expr> <ws>]*
        default <ws> <default_expr>

    <given_expr> ::=
        <expr>

    <when_expr> ::=
        <expr>

    <then_expr> ::=
        <expr>

    <default_expr> ::=
        <expr>

A C<given_when_def_expr> node represents an N-way given-when-default
switch control flow expression that dispatches based on matching a single
value with several options.  It is interpreted as a tuple of a Muldis D
C<sys.std.Core.Type.Cat.GivenWhenDefExprNodeSet> value.  The C<given_expr>
element specifies the C<given> attribute of the new
C<GivenWhenDefExprNodeSet>, which is the control value for the expression.
The whole collection of nonordered 0..N C<when_expr> + C<then_expr>
elements specifies the C<when_then> attribute, which is a set of I<when>
comparands; if any of these I<when> values matches the value of C<given>,
its associated I<then> result value is the result of the
C<given_when_def_expr>.  The C<default_expr> element specifies the
C<default> attribute, which determines the result value of the
C<given_when_def_expr> at runtime if either C<when_then> is an empty set or
none of its comparands match C<given>.

Examples:

    given digit
        when 'T' then 10
        when 'E' then 11
        default digit

## Material Reference Selector Expressions

Grammar:

    <material_ref_sel_expr> ::=
          <material_ref>
        | <primed_func>

    <material_ref> ::=
        '<' <material_name> '>'

    <material_name> ::=
        <PNSQNameChain_payload>

    <primed_func> ::=
        <material_ref> <unspace> <func_arg_list>

A C<material_ref> node represents a selector invocation for a value of the
C<sys.std.Core.Type.Cat.AbsPathMaterialNC> type, which is selected in terms
of a value of the C<sys.std.Core.Type.Cat.RelPathMaterialNC> type.  It is
interpreted as a tuple of a Muldis D
C<sys.std.Core.Type.Cat.APMaterialNCSelExprNodeSet> value.  The
C<material_name> element specifies the C<referencing> attribute of the new
C<APMaterialNCSelExprNodeSet>, which is the name, from the point of view of
the routine embedding this expression node, of the routine or type that the
new C<AbsPathMaterialNC> value is supposed to facilitate portable invoking
of, from any other routine besides the embedding routine.

A C<material_ref> node also serves as a less-verbose alternate syntax for a
C<PNSQNameChain> node, but only for C<PNSQNameChain> values where you
actually don't want a relative-path name-chain value.  For any
C<material_ref> node whose C<material_name> is already an
C<AbsPathMaterialNC> payload, a Muldis D parser will silently replace the
C<material_ref> node with a C<PNSQNameChain> node whose payload is its
C<material_name>.  In other words, you can safely use any primary namespace
qualified name chain in a C<material_ref> node and get the result that you
would reasonably expect.  This is primarily useful for system-defined types
and routines.

A C<primed_func> node represents a value of the
C<sys.std.Core.Type.Cat.PrimedFuncNC> type.  It is a special shorthand
syntax for a C<Tuple> node that defines a tuple with 2 attributes,
C<function> and C<args>, where the first's value is a C<material_ref> node
and the second's value is a C<Tuple> node as per a C<func_invo> node's
argument list.

Examples:

    #`a higher-order function primed with 1 argument`#
    <nlx.lib.filter>( =>search_term )

    #`a reference to an updater`#
    <nlx.lib.swap>

    #`a reference to a data type`#
    <nlx.lib.foo_type>

# GENERIC PROCEDURE STATEMENTS

Grammar:

    <proc_stmt__plain_rtn_inv> ::=
          <stmt_name>
        | <named_stmt>
        | <compound_stmt>
        | <multi_upd_stmt>
        | <proc_invo>
        | <try_catch_stmt>
        | <if_else_stmt>
        | <given_when_def_stmt>
        | <leave_or_iterate_or_loop_stmt>

    <proc_stmt__rtn_inv_alt_syn> ::=
          <proc_stmt__plain_rtn_inv>
        | <proc_invo_alt_syntax>

    <update_stmt__plain_rtn_inv> ::=
          <stmt_name>
        | <named_stmt>
        | <proc_invo>

    <update_stmt__rtn_inv_alt_syn> ::=
          <update_stmt__plain_rtn_inv>
        | <proc_invo_alt_syntax>

    <stmt_name> ::=
        <Name_payload>

    <named_stmt> ::=
        [let <ws>]? <stmt_name> <ws> <infix_bind_op> <ws> <proc_stmt>

A C<proc_stmt> node is the general case of a Muldis D statement tree, which
must be composed beneath a C<depot>, or specifically into a procedure
definition, because in the general case a C<proc_stmt> can I<not> be
completely evaluated at compile time.

A C<proc_stmt> node in the PTMD_STD grammar corresponds directly to a tuple
of an attribute of a value of the catalog data type
C<sys.std.Core.Type.Cat.StmtNodeSet>, which is how a statement node is
actually represented in Muldis D's nonsugared form, which is as a component
of the system catalog.  Or more specifically, an entire tree of PTMD_STD
C<proc_stmt> nodes corresponds to a set of said attribute tuples, one
attribute tuple per C<proc_stmt> node.  In the nonsugared form, every
C<proc_stmt> node has an explicitly designated name, as per a PTMD_STD
C<named_stmt> node, and all child nodes are not declared inline with their
parent nodes but rather are declared in parallel with them, and the parents
refer to their children by their names.  A feature of the PTMD_STD grammar
is that statement nodes may be declared without explicit names, such that
the parser would generate names for them when deriving system catalog
entries, and that is why PTMD_STD supports, and encourages the use of for
code brevity/readability, the use of inline-declared statement nodes.

Iff a C<proc_stmt> is an C<stmt_name>, then this typically means that the
parent C<proc_stmt> is having at least one of its children declared with an
explicit name rather than inline, same as the corresponding system catalog
entry would do, and then the C<stmt_name> is the invocation name of that
child.

Note that, regarding Muldis D's feature of a statement node having an
explicit name that can be referenced by "leave" and "iterate" control
flow statements to leave or re-iterate the corresponding block, both SQL
and Perl have native counterpart features in the form of block labels.

Examples:

    #`a stmt_name node`#
    foo_stmt

    #`a named_stmt node`#
    let bar_stmt ::= nlx.lib.swap( &=>first, &=>second )

## Generic Compound Statements

Grammar:

    <compound_stmt> ::=
        <nonempty_procedure_body_or_compound_stmt>

A C<compound_stmt> node specifies a procedure compound statement composed
of a sequence of 0..N other statements such that those other statements
execute in this given sequence; each statement of the sequence conceptually
executes at a different time.  It is interpreted as a tuple of a Muldis D
C<sys.std.Core.Type.Cat.CompoundStmtNodeSet> value.  Each C<proc_stmt>
element of a C<compound_statement> is a nested statement that is
interpreted as its own tuple of an attribute of the C<stmt> attribute of
the host C<Procedure>; for each said tuple, there exists an element of the
C<CompoundStmtNodeSet>'s C<stmts> attribute which matches the C<name>
attribute of the tuple.  Any C<with_clause> or C<proc_var> direct elements
of a C<compound_stmt> are interpreted as if they were directly in the
C<nonempty_procedure_body> that the C<compound_stmt> is under.

Examples:

    [
        var message : Text
        read_Text_line( &message )
        write_Text_line( message )
    ]

## Multi-Update Statements

Grammar:

    <multi_upd_stmt> ::=
        <nonempty_recipe_body_or_multi_upd_stmt>

A C<multi_upd_stmt> node specifies a multi-update statement, which is a
procedure compound statement composed of a set of 0..N other statements
such that those other statements execute all as one and collectively at a
single point in time, as if the collection were a single statement that did
all the work of the
component statements itself.  It is interpreted as a tuple of a Muldis D
C<sys.std.Core.Type.Cat.MultiUpdStmtNodeSet> value.  Each C<proc_stmt>
element of a C<multi_upd_stmt> is a nested statement that is
interpreted as its own tuple of an attribute of the C<stmt> attribute of
the host C<Procedure>; for each said tuple, there exists an element of the
C<MultiUpdStmtNodeSet>'s C<stmts> attribute which matches the C<name>
attribute of the tuple.  Any C<with_clause> direct elements
of a C<multi_upd_stmt> are interpreted as if they were directly in the
C<nonempty_procedure_body> that the C<multi_upd_stmt> is under.

Examples:

    {
        let order_id ::= is_empty(orders) ?? 1
            !! max( Set_from_attr( orders, name => Name:order_id ) ) ++

        assign_insertion( &orders,
            %:{ =>order_id, date => '2011-03-04' }
        )

        assign_union( &order_details,
            @:[ order_id, prod_code, qty ]:{
                [ order_id, 'COG' , 20, ],
                [ order_id, 'CAM' , 10, ],
                [ order_id, 'BOLT', 70, ],
            }
        )
    }

## Generic Procedure Invocation Statements

Grammar:

    <proc_invo> ::=
        <routine_name> <unspace> <proc_arg_list>

    <proc_arg_list> ::=
        '(' <ws>?
            [<proc_arg> ** [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? ')'

    <proc_arg> ::=
          <named_upd_arg>
        | <named_ro_arg>
        | <anon_upd_arg>
        | <anon_ro_arg>
        | <same_named_upd_arg>
        | <same_named_ro_arg>

    <named_upd_arg> ::=
        <upd_sigil> <named_ro_arg>

    <named_ro_arg> ::=
        <invo_param_name> <ws>? '=>' <ws>? <expr>

    <invo_param_name> ::=
        <Name_payload>

    <anon_upd_arg> ::=
        <upd_sigil> <anon_ro_arg>

    <anon_ro_arg> ::=
        <expr>

    <same_named_upd_arg> ::=
        <upd_sigil> <same_named_ro_arg>

    <same_named_ro_arg> ::=
        '=>' <invo_param_name>

A C<proc_invo> node represents the invocation of a named procedure,
with specific subject-to-update or read-only arguments, as a
statement of a procedure.  It is interpreted as a tuple of a Muldis D
C<sys.std.Core.Type.Cat.ProcInvoStmtNodeSet> value.  The C<routine_name>
element specifies the C<procedure> attribute of the new
C<ProcInvoStmtNodeSet>, which is the name of the procedure being
invoked, and the C<proc_arg_list> element specifies the C<upd_args>
plus C<ro_args> attributes, one tuple thereof per C<proc_arg>; each
C<proc_arg> having an C<upd_sigil> yields an C<upd_args> tuple, and
each C<proc_arg> without one yields a C<ro_args> tuple.

In the general case of a procedure invocation, all of the arguments are
named, as per C<named_[upd|ro]_arg>, and formatting a C<proc_invo> node
that way is always allowed.  In some (common) special cases, some (which
might be all) arguments may be anonymous, as per C<anon_[upd|ro]_arg>.  For
further details on this, see the C<func_invo> node kind, under **Generic
Function Invocation Expressions**, because the rules regarding when
arguments may be anonymous or must be named are the same for both main
routine kinds.

The sole exception to said rules is that the rules are evaluated
independently for subject-to-update arguments and read-only arguments,
because those 2 argument groups and their corresponding parameters
effectively have independent namespaces with respect to that the presence
or absence of an C<upd_sigil> can always be counted on to distinguish the
groups.  This means, for example, that you can have an anonymous
subject-to-update argument plus an anonymous read-only argument to a
system-defined procedure where none of the corresponding parameters are
named C<topic>.

The C<proc_invo> node kind also has the same special shorthand for named
arguments, in the form of C<same_named_[upd|ro]_arg>, as the C<func_invo>
node kind does with its C<same_named_ro_arg>, but that C<proc_invo>'s
version also works with subject-to-update arguments.

Examples:

    #`two mandatory params, one s-t-u, one r-o`#
    assign( &foo, 3 )

    #`same as previous`#
    assign( 3, &foo )

    #`still same as previous but with all-named syntax`#
    assign( &target => foo, v => 3 )

    #`three mandatory params`#
    nlx.lib.lookup( &=>addr, =>people, =>name )

    fetch_trans_instant( &now )

    prompt_Text_line( &name, 'Enter a person\'s name: ' )

    Integer.fetch_random( &rand, interval )

## Generic Try-Catch Statements

Grammar:

    <try_catch_stmt> ::=
        try <ws> <try_stmt>
        [<ws> catch <ws> <catch_stmt>]?

    <try_stmt> ::=
        <proc_stmt>

    <catch_stmt> ::=
        <proc_stmt>

A C<try_catch_stmt> node represents a try-catch control flow statement.  It
is interpreted as a tuple of a Muldis D
C<sys.std.Core.Type.Cat.TryCatchStmtNodeSet> value.  The C<try_stmt> and
C<catch_stmt> elements specify the C<try> and C<catch> attributes,
respectively, of the new C<TryCatchStmtNodeSet>, which are the names or
definitions of statements that represent the invocation of named
procedures.  The C<try> routine is unconditionally invoked first and then
iff
C<try> throws an exception then it will be caught and the C<catch> routine,
if any, will be invoked immediately after to handle it; if C<catch> also
throws an exception then it will not be caught.  It is invalid for
C<try_stmt> or C<catch_stmt> to name or define a procedure statement that
isn't just a routine invocation, though the grammar itself doesn't say so;
mainly the valid options are: C<proc_invo>, C<multi_upd_stmt>,
C<proc_invo_alt_syntax>, and C<stmt_name> or C<named_stmt> for the first 3.

Examples:

    try
        nlx.lib.attempt_the_work()
    catch
        nlx.lib.deal_with_failure()

## Generic If-Else Statements

Grammar:

    <if_else_stmt> ::=
        if <ws> <if_expr> <ws> then <ws> <then_stmt>
        [<ws> else <ws> <else_stmt>]?

    <then_stmt> ::=
        <proc_stmt>

    <else_stmt> ::=
        <proc_stmt>

An C<if_else_stmt> node represents a ternary if-then-else control flow
statement.  It is interpreted as a tuple of a Muldis D
C<sys.std.Core.Type.Cat.IfElseStmtNodeSet> value.  The C<if_expr>,
C<then_stmt>, and C<else_stmt> elements specify the C<if>, C<then>, and
C<else> attributes, respectively, of the new C<IfElseStmtNodeSet>;
C<if_expr> is the condition to evaluate at runtime and must result in a
C<Bool>; iff the result of that condition is C<Bool:True> then C<else_stmt>
is invoked; otherwise, C<then_stmt> is invoked.

Examples:

    if out_of_options then
        nlx.lib.give_up()
    else
        nlx.lib.keep_going()

## Generic Given-When-Default Statements

Grammar:

    <given_when_def_stmt> ::=
        given <ws> <given_expr> <ws>
        [when <ws> <when_expr> <ws> then <ws> <then_stmt> <ws>]*
        [default <ws> <default_stmt>]?

    <then_stmt> ::=
        <proc_stmt>

    <default_stmt> ::=
        <proc_stmt>

A C<given_when_def_stmt> node represents an N-way given-when-default switch
control flow statement that dispatches based on matching a single value
with several options.  It is interpreted as a tuple of a Muldis D
C<sys.std.Core.Type.Cat.GivenWhenDefStmtNodeSet> value.  The
C<given_expr> element specifies the C<given> attribute of the new
C<GivenWhenDefStmtNodeSet>, which is the control value for the statement.
The whole collection of nonordered 0..N C<when_expr> + C<then_stmt>
elements specifies the C<when_then> attribute, which is a set of I<when>
comparands; if any of these I<when> values matches the value of C<given>,
its associated I<then> statement is executed as if it were the whole
C<given_when_def_stmt>.  The C<default_stmt> element specifies the
C<default> attribute, which determines the statement that is executed at
runtime as if it were the whole C<given_when_def_stmt> if either
C<proc_when_then> is an empty set or none of its comparands match C<given>.

Examples:

    given picked_menu_item
        when 'v' then
            nlx.lib.screen_view_record()
        when 'a' then
            nlx.lib.screen_add_record()
        when 'd' then
            nlx.lib.screen_delete_record()
        default
            nlx.lib.display_bad_choice_error()

## Procedure Leave, Iterate, and Loop Statements

Grammar:

    <leave_or_iterate_or_loop_stmt> ::=
          <leave_stmt>
        | <iterate_stmt>
        | <loop_stmt>

    <leave_stmt> ::=
        leave [<ws> <stmt_name>]?

    <iterate_stmt> ::=
        iterate [<ws> <stmt_name>]?

    <loop_stmt> ::=
        loop <ws> <proc_stmt>

The 3 node kinds C<leave_stmt>, C<iterate_stmt>, C<loop_stmt> are all very
useable independently and are also commonly used together.

A C<leave_stmt> node represents an instruction to abnormally exit the block
defined by a parent statement node (a normal exit is to simply execute to
the end of the block).  If the parent node in question is the root
(compound) statement node for the host procedure, that is, if the parent
node has the empty string as its name, then the latter will be exited; this
is how a "return" statement is represented.  If the parent node in question
is an iterating or looping statement, then any remaining iterations it
might have had are skipped, especially useful if it was an infinite loop.
A C<leave_stmt> node is interpreted as a tuple of a Muldis D
C<sys.std.Core.Type.Cat.LeaveStmtNodeSet> value.  The optional C<stmt_name>
element specifies the name of the parent statement node to completely
abort; that name becomes the C<iterate> attribute of the new
C<LeaveStmtNodeSet> tuple.  Iff the C<leave_stmt> has no C<stmt_name>
element then the parser will automatically generate said element with a
value of the empty string, meaning it is a "return" statement.

An C<iterate_stmt> node represents an instruction to abnormally end the
current iteration of a looping block defined by a parent statement node,
and then start at the beginning of the next iteration of that loop if there
are any left; or, it can also be used to "redo" any non-looping parent
statement.  It is interpreted as a tuple of a Muldis D
C<sys.std.Core.Type.Cat.IterateStmtNodeSet> value.  The optional
C<stmt_name> element specifies the name of the parent statement node to
continue execution at the beginning of; that name becomes the C<iterate>
attribute of the new C<IterateStmtNodeSet> tuple.  Iff the C<iterate_stmt>
has no C<stmt_name> element then the parser will automatically generate
said element with a value of the empty string.  Having the C<stmt_name>
value of the empty string means that the root (compound) statement of the
host procedure is being referenced, in which case the C<iterate_stmt> is
saying to redo the whole procedure.

A C<loop_stmt> node represents a generic looping statement block which
iterates until a child "leave" statement executes.  It is interpreted as a
tuple of a Muldis D C<sys.std.Core.Type.Cat.LoopStmtNodeSet> value.  The
C<proc_stmt> element specifies the name or definition of the child
statement node to be repeatedly executed; the name of that statement
becomes the C<loop> attribute of the new C<LoopStmtNodeSet> tuple.

A C<loop_stmt> node in combination with C<leave_stmt> or C<iterate_stmt>
nodes is useful for a more ad-hoc means of performing procedural iteration
as well as for effectively simulating the syntax of common "while" or "for
i" loops, so Muldis D doesn't include special "while" or "for i" syntax.
A C<loop_stmt> is I<not> an effective "for each item in list" replacement,
however; Muldis D currently doesn't provide a procedural "foreach", but
typically any such tasks can effectively be performed in functional code
using various list-processing relational routines; if a case can be made
for procedural "foreach" then Muldis D may gain this feature in the future.

Examples:

    let lookup_person ::= loop [
        prompt_Text_line( &name, 'Enter a name to search for: ' )
        given name when '' leave lookup_person
        nlx.lib.do_search( =>name, &=>not_found, &=>report_text )
        if not_found then [
            write_Text_line( 'No person matched' )
            iterate lookup_person
        ]
        write_Text_line( report_text )
    ]

# DEPRECATED - FUNCTION INVOCATION ALTERNATE SYNTAX EXPRESSIONS

Grammar:

    <func_invo_alt_syntax> ::=
          <comm_infix_reduce_op_invo>
        | <noncomm_infix_reduce_op_invo>
        | <sym_dyadic_infix_op_invo>
        | <nonsym_dyadic_infix_op_invo>
        | <monadic_prefix_op_invo>
        | <monadic_postfix_op_invo>
        | <postcircumfix_op_invo>
        | <num_op_invo_with_round>
        | <ord_compare_op_invo>
        | ...

A C<func_invo_alt_syntax> node represents the result of invoking a named
system-defined function with specific arguments.  It is interpreted as a
tuple of a Muldis D C<sys.std.Core.Type.Cat.FuncInvoExprNodeSet> value.  A
C<func_invo_alt_syntax> node is a lot like a C<func_invo> node in purpose
and interpretation but it differs in several significant ways.

While a C<func_invo> node can be used to invoke any function at all,
a C<func_invo_alt_syntax> node can only invoke a fraction of them, and only
standard system-defined functions.  While a C<func_invo> node uses a simple
common format with all functions, written in prefix notation with generally
named arguments, a C<func_invo_alt_syntax> node uses potentially unique
syntax for each function, often written in infix notation, although
inter-function format consistency is still applied as much as is reasonably
possible.

Broadly speaking, a C<func_invo_alt_syntax> node has 2-3 kinds of payload
elements:  The first is the determinant of what function to invoke,
hereafter referred to as an I<op> or I<keyword>.  The second is an ordered
list of 1-N mandatory function inputs, hereafter referred to as I<main op
args>, whose elements typically have generic names like C<expr> or C<lhs>
or C<rhs>.  The (optional) third is a named list of optional function
inputs, hereafter referred to as I<extra op args>, whose elements tend to
have more purpose-specific names such as C<using_clause>, though note that
things like C<using_clause> can be either mandatory or optional depending
on the op they are being used with.

The decision of I<which> system-defined functions get the special alternate
syntax treatment partly comes down to respecting common good practices in
programming languages, letting people write code more like how they're
comfortable with.  Most programming languages only have special syntax for
a handful of their operators, such as common comparison and boolean and
mathematical and string and element extraction operators, and so Muldis D
mainly does likewise.  Functions get special alternate syntax if they would
be frequently used and the syntax would significantly aid programmers in
quickly writing understandeable code.

## Simple Commutative N-adic Infix Reduction Operators

Grammar:

    <comm_infix_reduce_op_invo> ::=
        <expr> ** [<ws> <comm_infix_reduce_op> <ws>]

    <comm_infix_reduce_op__op_cr_basic> ::=
          min | max
        | and | or | xnor | iff | xor
        | '+' | '*'
        | union | intersect | exclude | symdiff
        | join | times | 'cross-join'
        | 'union+' | 'union++' | 'intersect+'

    <comm_infix_reduce_op__op_cr_extended> ::=
          <comm_infix_reduce_op__op_cr_basic>
        | '∧' | '∨' | '↔' | '⊻' | '↮'
        | '∪' | '∩' | '∆'
        | '⋈' | '×'
        | '∪+' | '∪++' | '∩+'

A C<comm_infix_reduce_op_invo> node is for using infix notation to invoke a
(homogeneous) commutative N-adic reduction operator function.  Such a
function takes exactly 1 actual argument, which is unordered-collection
typed (set or bag), and the elements of that collection are the inputs
of the operation; the inputs are all of the same type as each other and of
the result.  A single C<comm_infix_reduce_op_invo> node is equivalent to a
single C<func_invo> node whose C<func_arg_list> element defines a single
argument, whose value is a C<Set> or C<Bag> node, which has a payload
C<expr> element for each C<expr> element of the
C<comm_infix_reduce_op_invo>, and the relative sequence of the C<expr>
elements isn't significant.  A C<comm_infix_reduce_op_invo> node requires
at least 2 input value providing child nodes (C<expr> must match at least
twice), which are its 2-N main op args; if you already have your inputs in
a single collection-valued node then use C<func_invo> to invoke the
function instead.  If C<comm_infix_reduce_op> matches more than once in the
same C<comm_infix_reduce_op_invo>, then all of the C<comm_infix_reduce_op>
matches must be identical / the same operator.

Some of the keywords are aliases for each other:

    keyword    | aliases
    -----------+--------
    and        | ∧
    or         | ∨
    xnor       | ↔ iff
    xor        | ⊻ ↮
    union      | ∪
    intersect  | ∩
    exclude    | ∆ symdiff
    join       | ⋈
    times      | × cross-join
    union+     | ∪+
    union++    | ∪++
    intersect+ | ∩+

This table indicates which function is invoked by each keyword:

    min -> Core.Ordered.min( { expr.[0], ..., expr.[n] } )
    max -> Core.Ordered.max( { expr.[0], ..., expr.[n] } )

    and  -> Core.Boolean.and( { expr.[0], ..., expr.[n] } )
    or   -> Core.Boolean.or( { expr.[0], ..., expr.[n] } )
    xnor -> Core.Boolean.xnor( Bag:{ expr.[0], ..., expr.[n] } )
    xor  -> Core.Boolean.xor( Bag:{ expr.[0], ..., expr.[n] } )
    +    -> Core.Numeric.sum( Bag:{ expr.[0], ..., expr.[n] } )
    *    -> Core.Numeric.product( Bag:{ expr.[0], ..., expr.[n] } )

    union     -> Core.Relation.union( { expr.[0], ..., expr.[n] } )
    intersect -> Core.Relation.intersection( { expr.[0], ..., expr.[n] } )
    exclude   -> Core.Relation.exclusion( Bag:{ expr.[0], ..., expr.[n] } )
    join      -> Core.Relation.join( { expr.[0], ..., expr.[n] } )
    times     -> Core.Relation.product( { expr.[0], ..., expr.[n] } )

    union+     -> Core.Bag.union( { expr.[0], ..., expr.[n] } )
    union++    -> Core.Bag.union_sum( Bag:{ expr.[0], ..., expr.[n] } )
    intersect+ -> Core.Bag.intersection( { expr.[0], ..., expr.[n] } )

Examples:

    a min b min c

    a max b max c

    True and False and True

    True or False or True

    True xor False xor True

    14 + 3 + -5

    -6 * 2 * 25

    4.25 + -0.002 + 1.0

    69.3 * 15*2^6 * 49/23

    { 1, 3, 5 } ∪ { 4, 5, 6 } ∪ { 0, 9 }

    { 1, 3, 5, 7, 9 } ∩ { 3, 4, 5, 6, 7, 8 } ∩ { 2, 5, 9 }

## Simple Non-commutative N-adic Infix Reduction Operators

Grammar:

    <noncomm_infix_reduce_op_invo> ::=
        <expr> ** [<ws> <noncomm_infix_reduce_op> <ws>]

    <noncomm_infix_reduce_op> ::=
        '[<=>]' | '~' | '//'

A C<noncomm_infix_reduce_op_invo> node is for using infix notation to
invoke a (homogeneous) non-commutative N-adic reduction operator function.
Such a function takes exactly 1 actual argument, which is
ordered-collection typed (array), and the elements of that collection are
the inputs of the operation; the inputs are all of the same type as each
other and of the result.  A single C<noncomm_infix_reduce_op_invo> node is
equivalent to a single C<func_invo> node whose C<func_arg_list> element
defines a single argument, whose value is an C<Array> node, which has a
payload C<expr> element for each C<expr> element of the
C<noncomm_infix_reduce_op_invo>, and the C<expr> elements have the same
relative sequence.  A C<noncomm_infix_reduce_op_invo> node requires at
least 2 input value providing child nodes (C<expr> must match at least
twice), which are its 2-N main op args; if you already have your inputs in
a single collection-valued node then use C<func_invo> to invoke the
function instead.  If C<noncomm_infix_reduce_op> matches more than once in
the same C<noncomm_infix_reduce_op_invo>, then all of the
C<noncomm_infix_reduce_op> matches must be identical / the same operator.
Exception: with some of these, the actual C<func_arg_list> derived from
this has 2 actual arguments, the first a collection and the second taking a
different type of value, from the last op input list element.

This table indicates which function is invoked by each keyword:

    [<=>] -> Core.Cat.Order.reduction( [ expr.[0], ..., expr.[n] ] )
    ~     -> Core.Stringy.catenation( [ expr.[0], ..., expr.[n] ] )
    //    -> Core.Set.Maybe.attr_or_value(
                [ expr.[0], ..., expr.[n-1] ], value => expr.[n] )

Examples:

    Same [<=>] Less [<=>] More

    0x'DEAD' ~ 0b'10001101' ~ 0x'BEEF'

    'hello' ~ ' ' ~ 'world'

    [ 24, 52 ] ~ [ -9 ] ~ [ 0, 11, 24, 7 ]

    a // b // 42

## Simple Symmetric Dyadic Infix Operators

Grammar:

    <sym_dyadic_infix_op_invo> ::=
        <expr> <ws> <sym_dyadic_infix_op> <ws> <expr>

    <sym_dyadic_infix_op__op_cr_basic> ::=
          '=' | '!='
        | nand | nor
        | '|-|'
        | compose

    <sym_dyadic_infix_op__op_cr_extended> ::=
          <sym_dyadic_infix_op__op_cr_basic>
        | '≠'
        | '⊼' | '↑' | '⊽' | '↓'

A C<sym_dyadic_infix_op_invo> node is for using infix notation to invoke a
symmetric dyadic operator function.  Such a function takes exactly 2
arguments, which are the inputs of the operation; the inputs are all of the
same type as each other but the result might be of either that type or a
different type.  A single C<sym_dyadic_infix_op_invo> node is equivalent
to a single C<func_invo> node whose C<func_arg_list> element defines 2
arguments, and the 2 C<expr> elements of the C<sym_dyadic_infix_op_invo>
supply the values of those arguments, and which arguments get which C<expr>
isn't significant.

Some of the keywords are aliases for each other:

    keyword | aliases
    --------+--------
    !=      | ≠
    nand    | ⊼ ↑
    nor     | ⊽ ↓

This table indicates which function is invoked by each keyword:

    =       -> Core.Universal.is_same( expr.[0], expr.[1] )
    !=      -> Core.Universal.is_not_same( expr.[0], expr.[1] )
    nand    -> Core.Boolean.nand( expr.[0], expr.[1] )
    nor     -> Core.Boolean.nor( expr.[0], expr.[1] )
    |-|     -> Core.Numeric.abs_diff( expr.[0], expr.[1] )
    compose -> Core.Relation.composition( expr.[0], expr.[1] )

Examples:

    foo = bar

    foo ≠ bar

    False nand True

    15 |-| 17

    7.5 |-| 9.0

## Simple Non-symmetric Dyadic Infix Operators

Grammar:

    <nonsym_dyadic_infix_op_invo> ::=
        <lhs> <ws> <nonsym_dyadic_infix_op> <ws> <rhs>

    <lhs> ::=
        <expr>

    <rhs> ::=
        <expr>

    <nonsym_dyadic_infix_op__op_cr_basic> ::=
          isa | '!isa' | 'not-isa' | as | asserting | assuming
        | '<' | '<=' | '>' | '>='
        | imp | implies | nimp | if | nif
        | '-' | '/' | '^' | exp
        | '~#'
        | where | '!where' | 'not-where'
        | inside | '!inside'|'not-inside' | holds | '!holds'|'not-holds'
        | in | '!in' | 'not-in' | has | '!has' | 'not-has'
        | '{<=}' | '{!<=}' | '{>=}' | '{!>=}'
        | '{<}'  | '{!<}'  | '{>}'  | '{!>}'
        | '{<=}+' | '{!<=}+' | '{>=}+' | '{!>=}+'
        | '{<}+'  | '{!<}+'  | '{>}+'  | '{!>}+'
        | minus | except
        | '!matching' | 'not-matching' | antijoin | semiminus
        | matching | semijoin
        | divideby
        | 'minus+' | 'except+'
        | like | '!like' | 'not-like'

    <nonsym_dyadic_infix_op__op_cr_extended> ::=
          <nonsym_dyadic_infix_op__op_cr_basic>
        | '≤' | '≥'
        | '→' | '↛' | '←' | '↚'
        | '∈@' | '∉@' | '@∋' | '@∌'
        | '∈' | '∉' | '∋' | '∌'
        | '⊆' | '⊈' | '⊇' | '⊉'
        | '⊂' | '⊄' | '⊃' | '⊅'
        | '⊆+' | '⊈+' | '⊇+' | '⊉+'
        | '⊂+' | '⊄+' | '⊃+' | '⊅+'
        | '∖' | '⊿' | '⋉' | '÷'
        | '∖+'

A C<nonsym_dyadic_infix_op_invo> node is for using infix notation to
invoke a non-symmetric dyadic operator function.  Such a function takes
exactly 2 arguments, which are the inputs of the operation; the inputs
and the result may possibly be all of the same type, or they might all be
of different types.  A single C<nonsym_dyadic_infix_op_invo> node is
equivalent to a single C<func_invo> node whose C<func_arg_list> element
defines 2 arguments, and the 2 C<expr> elements of the
C<nonsym_dyadic_infix_op_invo> supply the values of those arguments, which
are associated in the appropriate sequence.

Some of the keywords are aliases for each other:

    keyword   | aliases
    ----------+--------
    !isa      | not-isa
    <=        | ≤
    >=        | ≥
    imp       | → implies
    nimp      | ↛
    if        | ←
    nif       | ↚
    !where    | not-where
    inside    | ∈@
    !inside   | ∉@ not-inside
    holds     | @∋
    !holds    | @∌ not-holds
    in        | ∈
    !in       | ∉ not-in
    has       | ∋
    !has      | ∌ not-has
    {<=}      | ⊆
    {!<=}     | ⊈
    {>=}      | ⊇
    {!>=}     | ⊉
    {<}       | ⊂
    {!<}      | ⊄
    {>}       | ⊃
    {!>}      | ⊅
    {<=}+     | ⊆+
    {!<=}+    | ⊈+
    {>=}+     | ⊇+
    {!>=}+    | ⊉+
    {<}+      | ⊂+
    {!<}+     | ⊄+
    {>}+      | ⊃+
    {!>}+     | ⊅+
    minus     | ∖ except
    !matching | ⊿ not-matching antijoin semiminus
    matching  | ⋉ semijoin
    divideby  | ÷
    minus+    | ∖+ except+
    !like     | not-like

This table indicates which function is invoked by each keyword:

    isa  -> Core.Universal.is_value_of_type( lhs, type => rhs )
    !isa -> Core.Universal.is_not_value_of_type( lhs, type => rhs )
    as   -> Core.Universal.treated( lhs, as => rhs )
    asserting -> Core.Universal.assertion( lhs, is_true => rhs )
    assuming -> sys.std.Core.Cat.primed_func_static_exten(
                function => lhs, args => rhs )
    <    -> Core.Ordered.is_before( lhs, rhs )
    >    -> Core.Ordered.is_after( lhs, rhs )
    <=   -> Core.Ordered.is_before_or_same( lhs, rhs )
    >=   -> Core.Ordered.is_after_or_same( lhs, rhs )
    imp  -> Core.Boolean.imp( lhs, rhs )
    nimp -> Core.Boolean.nimp( lhs, rhs )
    if   -> Core.Boolean.if( lhs, rhs )
    nif  -> Core.Boolean.nif( lhs, rhs )
    -    -> Core.Numeric.diff( minuend => lhs, subtrahend => rhs )
    /    -> Core.Numeric.frac_quotient( dividend => lhs, divisor => rhs )
    ^    -> Core.Numeric.power_with_whole_exp( radix => lhs,
                exponent => rhs )
    exp  -> Core.Integer.power( radix => lhs, exponent => rhs )
    ~#   -> Core.Stringy.replication( lhs, count => rhs )

    where  -> Core.Relation.restriction( lhs, func => rhs )
    !where -> Core.Relation.cmpl_restr( lhs, func => rhs )

    inside  -> Core.Relation.tuple_is_member( t => lhs, r => rhs )
    !inside -> Core.Relation.tuple_is_not_member( t => lhs, r => rhs )
    holds   -> Core.Relation.has_member( r => lhs, t => rhs )
    !holds  -> Core.Relation.has_not_member( r => lhs, t => rhs )
    in      -> Core.Collective.value_is_member( value => lhs, coll => rhs )
    !in     -> Core.Collective.value_is_not_member( value=>lhs, coll=>rhs )
    has     -> Core.Collective.has_member( coll => lhs, value => rhs )
    !has    -> Core.Collective.has_not_member( coll => lhs, value => rhs )

    {<=}  -> Core.Relation.is_subset( lhs, rhs )
    {!<=} -> Core.Relation.is_not_subset( lhs, rhs )
    {>=}  -> Core.Relation.is_superset( lhs, rhs )
    {!>=} -> Core.Relation.is_not_superset( lhs, rhs )
    {<}   -> Core.Relation.is_proper_subset( lhs, rhs )
    {!<}  -> Core.Relation.is_not_proper_subset( lhs, rhs )
    {>}   -> Core.Relation.is_proper_superset( lhs, rhs )
    {!>}  -> Core.Relation.is_not_proper_superset( lhs, rhs )

    {<=}+  -> Core.Bag.is_subset( lhs, rhs )
    {!<=}+ -> Core.Bag.is_not_subset( lhs, rhs )
    {>=}+  -> Core.Bag.is_superset( lhs, rhs )
    {!>=}+ -> Core.Bag.is_not_superset( lhs, rhs )
    {<}+   -> Core.Bag.is_proper_subset( lhs, rhs )
    {!<}+  -> Core.Bag.is_not_proper_subset( lhs, rhs )
    {>}+   -> Core.Bag.is_proper_superset( lhs, rhs )
    {!>}+  -> Core.Bag.is_not_proper_superset( lhs, rhs )

    minus    -> Core.Relation.diff( source => lhs, filter => rhs )
    !matching -> Core.Relation.semidiff( source => lhs, filter => rhs )
    matching -> Core.Relation.semijoin( source => lhs, filter => rhs )
    divideby -> Core.Relation.quotient( dividend => lhs, divisor => rhs )

    minus+ -> Core.Bag.diff( source => lhs, filter => rhs )

    like  -> Core.Text.is_like( look_in => lhs, look_for => rhs )
    !like -> Core.Text.is_not_like( look_in => lhs, look_for => rhs )

Note that while the C<is[|_not]_like> functions also have an optional third
parameter C<escape>, you will have to use a C<func_invo> node to exploit
it; for simplicity, the infix C<like> and C<!like> don't support that
customization; but most actual uses of like/etc don't use C<escape> anyway.

Examples:

    bar isa <nlx.lib.foo_type>

    bar !isa <nlx.lib.foo_type>

    scalar as <Int>

    int asserting (int ≠ 0)

    True implies False

    foo < bar

    foo > bar

    foo ≤ bar

    foo ≥ bar

    34 - 21

    2 exp 63

    9.2 - 0.1

    0b101.01 / 0b11.0

    '-' ~# 80

    a ∈ {1..5}

    foo ∉ {"min"..^"max"}

    { 8, 4, 6, 7 } ∖ { 9, 0, 7 }

    @:[ x, y ]:{ [ 5, 6 ], [ 3, 6 ] } ÷ @:{ { y => 6 } }

## Simple Monadic Prefix Operators

Grammar:

    <monadic_prefix_op_invo> ::=
        <monadic_prefix_op_invo_alpha> | <monadic_prefix_op_invo_sym>

    <monadic_prefix_op_invo_alpha> ::=
        <monadic_prefix_op_alpha> <ws> <expr>

    <monadic_prefix_op_alpha> ::=
        not abs

    <monadic_prefix_op_invo_sym> ::=
        <monadic_prefix_op> <ws>? <expr>

    <monadic_prefix_op__op_cr_basic> ::=
        '!' | '#' | '#+' | '%' | '@'

    <monadic_prefix_op__op_cr_extended> ::=
          <monadic_prefix_op__op_cr_basic>
        | '¬'

A C<monadic_prefix_op_invo> node is for using prefix notation to invoke a
monadic operator function.  Such a function takes exactly 1 argument, which
is the input of the operation.  A single C<monadic_prefix_op_invo> node is
equivalent to a single C<func_invo> node whose C<func_arg_list> element
defines 1 argument, and the 1 C<expr> element of the
C<monadic_prefix_op_invo> supplies the value of that argument.

Some of the keywords are aliases for each other:

    keyword | aliases
    --------+--------
    not     | ¬ !

This table indicates which function is invoked by each keyword:

    not -> Core.Boolean.not( expr )
    abs -> Core.Numeric.abs( expr )
    #   -> Core.Relation.cardinality( expr )
    #+  -> Core.Bag.cardinality( expr )
    %   -> Core.Cast.Tuple_from_Relation( expr )
    @   -> Core.Cast.Relation_from_Tuple( expr )

Examples:

    not True

    abs -23

    abs -4.59

    #{ 5, -1, 2 }

    %relvar

    @tupvar

## Simple Monadic Postfix Operators

Grammar:

    <monadic_postfix_op_invo> ::=
        <expr> <ws>? <monadic_postfix_op>

    <monadic_postfix_op> ::=
        '++' | '--' | '!'

A C<monadic_postfix_op_invo> node is for using prefix notation to invoke a
monadic operator function.  Such a function takes exactly 1 argument, which
is the input of the operation.  A single C<monadic_postfix_op_invo> node is
equivalent to a single C<func_invo> node whose C<func_arg_list> element
defines 1 argument, and the 1 C<expr> element of the
C<monadic_postfix_op_invo> supplies the value of that argument.

This table indicates which function is invoked by each keyword:

    ++ -> Core.Ordered.Ordinal.succ( expr )
    -- -> Core.Ordered.Ordinal.pred( expr )
    !  -> Core.Integer.factorial( expr )

Examples:

    13++

    4--

    5!

## Simple Postcircumfix Operators

Grammar:

    <postcircumfix_op_invo> ::=
          <pcf_acc_op_invo>
        | <s_pcf_op_invo> | <atb_pcf_op_invo> | <r_pcf_op_invo>
        | <pcf_mbe_op_invo> | <pcf_ary_op_invo>

    <pcf_acc_op_invo> ::=
        <pcf_s_acc_op_invo> | <pcf_t_acc_op_invo>

    <pcf_s_acc_op_invo> ::=
        <expr> <unspace> '.{' [<ws>? <possrep_name>]? ':' <ws>?
            <attr_name>
        <ws>? '}'

    <pcf_t_acc_op_invo> ::=
        <expr> <unspace> '.{' <ws>? <attr_name> <ws>? '}'

    <s_pcf_op_invo> ::=
        <expr> <unspace> '{' [<ws>? <possrep_name>]? ':' <ws>?
            [<pcf_projection> | <pcf_cmpl_proj>]
        <ws>? '}'

    <atb_pcf_op_invo> ::=
        <expr> <unspace> '{' <ws>?
            [
                  <pcf_rename>
                | <pcf_projection> | <pcf_cmpl_proj>
                | <pcf_wrap> | <pcf_cmpl_wrap>
                | <pcf_unwrap>
            ]
        <ws>? '}'

    <r_pcf_op_invo> ::=
        <expr> <unspace> '{' <ws>?
            [
                  <pcf_group> | <pcf_cmpl_group>
                | <pcf_ungroup>
                | <pcf_count_per_group>
            ]
        <ws>? '}'

    <pcf_rename> ::=
        <pcf_rename_map>

    <pcf_rename_map> ::=
        [<atnm_aft_bef> | <atnm_aft_bef> ** [<ws>? ',' <ws>?] [<ws>? ',']?]

    <atnm_aft_bef> ::=
        <atnm_after> <ws>? '<-' <ws>? <atnm_before>

    <atnm_after> ::=
        <attr_name>

    <atnm_before> ::=
        <attr_name>

    <pcf_projection> ::=
        <pcf_atnms>?

    <pcf_cmpl_proj> ::=
        '!' <ws>? <pcf_atnms>

    <pcf_atnms> ::=
        [<attr_name> | <attr_name> ** [<ws>? ',' <ws>?] [<ws>? ',']?]

    <pcf_wrap> ::=
        '%' <outer_atnm> <ws>? '<-' <ws>? <inner_atnms>

    <pcf_cmpl_wrap> ::=
        '%' <outer_atnm> <ws>? '<-' <ws>? '!' <ws>? <cmpl_inner_atnms>

    <pcf_unwrap> ::=
         <inner_atnms> <ws>? '<-' <ws>? '%' <outer_atnm>

    <pcf_group> ::=
        '@' <outer_atnm> <ws>? '<-' <ws>? <inner_atnms>

    <pcf_cmpl_group> ::=
        '@' <outer_atnm> <ws>? '<-' <ws>? '!' <ws>? <cmpl_inner_atnms>

    <pcf_ungroup> ::=
         <inner_atnms> <ws>? '<-' <ws>? '@' <outer_atnm>

    <pcf_count_per_group> ::=
        '#@' <count_atnm> <ws>? '<-' <ws>? '!' <ws>? <cmpl_inner_atnms>

    <outer_atnm> ::=
        <attr_name>

    <count_atnm> ::=
        <attr_name>

    <inner_atnms> ::=
        <pcf_atnms>

    <cmpl_inner_atnms> ::=
        <pcf_atnms>

    <pcf_mbe_op_invo> ::=
        <expr> '.{*}'

    <pcf_ary_op_invo> ::=
        <pcf_ary_acc_op_invo> | <pcf_ary_slice_op_invo>

    <pcf_ary_value_op_invo> ::=
        <expr> <unspace> '.[' <ws>? <index> <ws>? ']'

    <index> ::=
          <num_max_col_val> '#' <unspace> <nnint_body>
        | <num_radix_mark> <unspace> <nnint_body>
        | <d_nnint_body>

    <pcf_ary_slice_op_invo> ::=
        <expr> <unspace> '[' <ws>?
            <min_index> <ws>? <interval_boundary_kind> <ws>? <max_index>
        <ws>? ']'

    <min_index> ::=
        <index>

    <max_index> ::=
        <index>

A C<postcircumfix_op_invo> node is for using postcircumfix notation to
invoke a relational operator function whose operation involves deriving a
single tuple|relation from another single tuple|relation customized only by
further inputs that are attribute names.  Such a function takes exactly 2
(C<expr> and C<pcf_rename_map>|C<pcf_atnms>) or 3 (C<expr> and
C<outer_atnm> and C<inner_atnms>|C<cmpl_inner_atnms>) or 3 (C<expr> and
C<count_atnm> and C<cmpl_inner_atnms>) primary arguments, which are the
inputs of the operation.  A single C<postcircumfix_op_invo> node is
equivalent to a single C<func_invo> node whose C<func_arg_list> element
defines 2-3 arguments, and the 2-3
C<expr|pcf[_rename_map|atnms]|[outer|count]_atnm|[|cmpl_]inner_atnms>
elements of the C<postcircumfix_op_invo> supply the values of those
arguments, which are associated in the appropriate sequence.

This table indicates which function is invoked by each format-keyword:

    .{:} -> Core.Scalar.attr( expr, possrep => possrep_name,
                name => attr_name )
    .{} -> Core.Tuple.attr( expr, name => attr_name )

    {<-} -> Core.Attributive.rename( expr,
                map => @:{
                    { after => atnm_after.[0], before => atnm_before.[0] },
                    ...,
                    { after => atnm_after.[n], before => atnm_before.[n] },
                } )

    {:}  -> Core.Scalar.projection( expr, possrep => possrep_name,
                attr_names => { pcf_atnms.[0], ..., pcf_atnms.[n] } )
    {}  -> Core.Attributive.projection( expr,
                attr_names => { pcf_atnms.[0], ..., pcf_atnms.[n] } )
    {:!} -> Core.Scalar.cmpl_proj( expr, possrep => possrep_name,
                attr_names => { pcf_atnms.[0], ..., pcf_atnms.[n] } )
    {!} -> Core.Attributive.cmpl_proj( expr,
                attr_names => { pcf_atnms.[0], ..., pcf_atnms.[n] } )

    {%<-}  -> Core.Attributive.wrap( expr, outer => outer_atnm,
                   inner => { inner_atnms.[0], ..., inner_atnms.[n] } )
    {%<-!} -> Core.Attributive.cmpl_wrap( expr, outer => outer_atnm,
                   cmpl_inner => { cmpl_inner_atnms.[0], ... } )
    {<-%}  -> Core.Attributive.unwrap( expr,
                   inner => { inner_atnms.[0], ..., inner_atnms.[n] },
                   outer => outer_atnm )

    {@<-}  -> Core.Relation.group( expr, outer => outer_atnm,
                   inner => { inner_atnms.[0], ..., inner_atnms.[n] } )
    {@<-!} -> Core.Relation.cmpl_group( expr, outer => outer_atnm,
                   group_per => { cmpl_inner_atnms.[0], ... } )
    {<-@}  -> Core.Relation.ungroup( expr,
                   inner => { inner_atnms.[0], ..., inner_atnms.[n] },
                   outer => outer_atnm )

    {#@<-!} -> Core.Relation.cardinality_per_group( expr,
                   count_attr_name => count_atnm,
                   group_per => { cmpl_inner_atnms.[0], ... } )

    .{*} -> Core.Set.Maybe.attr( expr )

    .[] -> Core.Array.value( expr, =>index )
    []  -> Core.Array.slice( expr, index_interval => {
                min_index interval_boundary_kind max_index } )

Examples:

    birthday.{date:day}

    pt.{city}

    pt{pnum<-pno, locale<-city}

    pr{pnum<-pno, locale<-city}

    birthday{date:year,month}

    pt{color,city}

    pr{color,city}

    pt{}  #`null projection`#

    pr{}  #`null projection`#

    rnd_rule{:!round_meth}  #`radix,min_exp`#

    pt{!pno,pname,weight}

    pr{!pno,pname,weight}

    person{%name <- fname,lname}

    people{%name <- fname,lname}

    person{%all_but_name <- !fname,lname}

    people{%all_but_name <- !fname,lname}

    person{fname,lname <- %name}

    people{fname,lname <- %name}

    orders{@vendors <- vendor}

    orders{@all_but_vendors <- !vendor}

    orders{vendor <- @vendors}

    people{#@count_per_age_ctry <- !age,ctry}

    maybe_foo.{*}

    ary.[3]

    ary[10..14]

## Numeric Operators That Do Rounding

Grammar:

    <num_op_invo_with_round> ::=
        <num_op_invo> <ws> <rounded_with_meth_or_rule_clause>

    <num_op_invo> ::=
          <expr>
        | <infix_num_op_invo>
        | <prefix_num_op_invo>
        | <postfix_num_op_invo>

    <infix_num_op_invo> ::=
        <lhs> <ws> <infix_num_op> <ws> <rhs>

    <infix_num_op> ::=
        div | mod | '**' | log

    <prefix_num_op_invo> ::=
        <expr> <ws> <prefix_num_op>

    <prefix_num_op>
        'e**'

    <postfix_num_op_invo> ::=
        <expr> <ws> <postfix_num_op>

    <postfix_num_op>
        'log-e'

    <rounded_with_meth_or_rule_clause> ::=
        round <ws> [<round_meth> | <round_rule>]

    <round_meth> ::=
        <expr>

    <round_rule> ::=
        <expr>

A C<num_op_invo_with_round> node is for using infix or prefix or postfix
notation to invoke a rational numeric operator function whose operation
involves rounding a number to one with less precision.  Such a function
takes exactly 1 (C<expr>) or 2 (C<lhs> and C<rhs>) primary arguments,
which are the inputs of the operation, plus a special C<round_rule>
argument which specifies explicitly the semantics of the numeric rounding
in a declarative way (all 2 or 3 of these are I<main op args>).  A single
C<num_op_invo_with_round> node is equivalent to a single C<func_invo> node
whose C<func_arg_list> element defines 2-3 arguments, and the
C<expr|lhs|rhs|round_[meth|rule]> elements of the C<num_op_invo_with_round>
supply the values of those arguments, which are associated in the
appropriate sequence.

This table indicates which function is invoked by each keyword:

    div -> Core.Numeric.whole_quotient( dividend => lhs, divisor => rhs,
                =>round_meth )
    mod -> Core.Numeric.remainder( dividend => lhs, divisor => rhs,
                =>round_meth )

          -> Core.Rational.round( expr, =>round_rule )
    **    -> Core.Rational.power( radix => lhs, exponent => rhs,
                =>round_rule )
    log   -> Core.Rational.log( lhs, radix => rhs, =>round_rule )
    e**   -> Core.Rational.natural_power( expr, =>round_rule )
    log-e -> Core.Rational.natural_log( expr, =>round_rule )

Examples:

    5 div 3 round ToZero

    5 mod 3 round ToZero

    foo round RatRoundRule:[10,-2,HalfEven]

    2.0 ** 0.5 round RatRoundRule:[2,-7,ToZero]

    309.1 log 5.4 round RatRoundRule:[10,-4,HalfUp]

    e** 6.3 round RatRoundRule:[10,-6,Up]

    17.0 log-e round RatRoundRule:[3,-5,Down]

## Order Comparison Operators

Grammar:

    <ord_compare_op_invo> ::=
        <lhs> <ws> '<=>' <ws> <rhs>
            [<ws> <assuming_clause>]?
            [<ws> <reversed_clause>]?

An C<ord_compare_op_invo> node is for using infix notation to invoke an
order comparison operator function.  I<Details are pending.>

This table indicates which function is invoked by each keyword:

    <=> -> Core.Ordered.order( lhs, rhs )

Examples:

    foo <=> bar

# DEPRECATED - PROCEDURE INVOCATION ALTERNATE SYNTAX STATEMENTS

Grammar:

    <proc_invo_alt_syntax> ::=
          <proc_monadic_postfix_op_invo>
        | <proc_nonsym_dyadic_infix_op_invo>
        | ...

A C<proc_invo_alt_syntax> node represents the invocation of a named
system-defined procedure with specific arguments.  It is
interpreted as a tuple of a Muldis D
C<sys.std.Core.Type.Cat.ProcInvoStmtNodeSet> value.  A
C<proc_invo_alt_syntax> node is a lot like a
C<proc_invo> node in purpose and interpretation but it differs in
several significant ways.

While a C<proc_invo> node can be used to invoke any procedure at all,
a C<proc_invo_alt_syntax> node can only invoke a fraction of
them, and only standard system-defined procedures.  While a
C<proc_invo> node uses a simple common format with
all procedures, written in prefix notation with generally named
arguments, a C<proc_invo_alt_syntax> node uses potentially unique syntax
for each procedure, often written in infix notation, although
inter-procedure format consistency is still applied as much as is
reasonably possible.

Broadly speaking, a C<proc_invo_alt_syntax> node has 2-3 kinds of payload
elements:  The first is the determinant of what procedure to
invoke, hereafter referred to as an I<op> or I<keyword>.  The second is an
ordered list of 1-N mandatory procedure inputs, hereafter referred
to as I<main op args>, whose elements typically have generic names like
C<expr> or C<lhs> or C<rhs>.  The (optional) third is a named
list of optional procedure inputs, hereafter referred to as
I<extra op args>, whose elements tend to have more purpose-specific names
such as C<using_clause>, though note that things like C<using_clause> can
be either mandatory or optional depending on the op they are being used
with.

Note that the procedures with alternate syntax include
recipes, and they are all shown in one list for simplicity.
But only alternate syntax for recipes is valid in a recipe; all of
these alternate syntaxes are valid in a procedure.

## Procedure Simple Monadic Postfix Operators

Grammar:

    <proc_monadic_postfix_op_invo> ::=
        <expr> <ws> <proc_monadic_postfix_op>

    <proc_monadic_postfix_op> ::=
        ':=++' | ':=--'

A C<proc_monadic_postfix_op_invo> node is for using prefix notation to
invoke a monadic operator procedure.  Such a procedure
takes exactly 1 argument, which is the input of the operation.  A single
C<proc_monadic_postfix_op_invo> node is equivalent to a single
C<proc_invo> node whose
C<proc_arg_list> element defines 1 argument, and the 1 C<expr>
element of the C<proc_monadic_postfix_op_invo> supplies the value of that
argument and takes its result.

This table indicates which procedure is invoked by each keyword:

    :=++ -> Core.Ordered.Ordinal.assign_succ( expr )
    :=-- -> Core.Ordered.Ordinal.assign_pred( expr )

Examples:

    counter :=++

    countdown :=--

## Procedure Simple Non-symmetric Dyadic Infix Operators

Grammar:

    <proc_nonsym_dyadic_infix_op_invo> ::=
        <lhs> <ws> <proc_nonsym_dyadic_infix_op_invo> <ws> <rhs>

    <proc_nonsym_dyadic_infix_op__op_cr_basic> ::=
          ':='
        | ':=union'
        | ':=where' | ':=!where' | ':=not-where'
        | ':=intersect' | ':=minus' | ':=except'
        | ':=!matching' | ':=not-matching' | ':=antijoin | ':=semiminus'
        | ':=matching' | ':=semijoin'
        | ':=exclude' | ':=symdiff'

    <proc_nonsym_dyadic_infix_op__op_cr_extended> ::=
          <proc_nonsym_dyadic_infix_op__op_cr_basic>
        | ':=∪'
        | ':=∩' | ':=∖' | ':=⊿' | ':=⋉'
        | ':=∆'

A C<proc_nonsym_dyadic_infix_op_invo> node is for using infix notation to
invoke a non-symmetric dyadic operator procedure.  Such a
procedure takes exactly 2 arguments.  A single
C<proc_nonsym_dyadic_infix_op_invo> node is equivalent to a single
C<proc_invo> node whose
C<proc_arg_list> element defines 2 arguments, and the 2
C<expr> elements of the C<proc_nonsym_dyadic_infix_op_invo> supply the
values of those arguments, which are associated in the appropriate
sequence.  When using this infix syntax, the C<&> sigil isn't used to
mark the subject-to-update argument(s).

Some of the keywords are aliases for each other:

    keyword     | aliases
    ------------+--------
    :=union     | :=∪
    :=!where    | :=not-where
    :=intersect | :=∩
    :=minus     | :=∖ :=except
    :=!matching | :=⊿ :=not-matching :=antijoin :=semiminus
    :=matching  | :=⋉ :=semijoin
    :=exclude   | :=∆ :=symdiff

This table indicates which procedure is invoked by each keyword:

    :=          -> Core.Universal.assign( &lhs, rhs )
    :=union     -> Core.Relation.assign_union( &lhs, rhs )
    :=where     -> Core.Relation.assign_restriction( &lhs, rhs )
    :=!where    -> Core.Relation.assign_cmpl_restr( &lhs, rhs )
    :=intersect -> Core.Relation.assign_intersection( &lhs,rhs )
    :=minus     -> Core.Relation.assign_diff( &lhs, rhs )
    :=!matching -> Core.Relation.assign_semidiff( &lhs, rhs )
    :=matching  -> Core.Relation.assign_semijoin( &lhs, rhs )
    :=exclude   -> Core.Relation.assign_exclusion( &lhs, rhs )

Examples:

    #`assign 3 to foo`#
    foo := 3

    #`swap x and y using pseudo-variables`#
    %:{"0"=>x,"1"=>y} := %:{"0"=>y,"1"=>x}
    #`TODO : A SUBSEQUENT SPEC UPDATE WILL MAKE THIS SHORT FORM VALID`#
    %:{x,y} := %:{y,x}

    #`delete every person in people whose age is either 10 or 20`#
    people :=!matching @:{ { age => 10 }, { age => 20 } }

# LANGUAGE MNEMONICS

PTMD_STD is designed to respect a variety of mnemonics that bring it some
self-similarity and an association between syntax and semantics so that it
is easier to read and write Muldis D code.  Some of these mnemonics are
more about self-similarity and others are more about shared traits with
other languages.

I<Note that some of these details aren't yet otherwise specified and
describe near-future planned changes.>

## Bareword Strings

All barewords, meaning runs of non-quoted non-whitespace alphanumeric
characters plus {C<_>,C<->,C<.>}, are generally either of these 3 things:
language keywords, entity names (including declarations or invocations of
routines/operators, types, variables), numeric literals (which may also
contain {C<#>,C</>,C<*>,C<^>}).

## Quoted Strings

All quoted strings, meaning runs of characters delimited with any of
{C<'>,C<">,C<`>}, are generally either of these 3 things: entity names (iff
C<">-quoted), value literals for general purpose string-like types (if
C<'>-quoted), code comments (iff C<`>-quoted, and typically also
C<#>-delimited forming double-character delimiters).

## C<#>

The C<#> character is mainly associated with numbers in some way but is
also associated with code comments, though in the latter case it always
appears together with C<`>.  Iff C<#> appears as part of a numeric value
literal, it is in a manner like and inspired by the "based" literals of the
Ada language, and separates the radix specifier from the main part of the
literal that it describes.  If C<#> appears other than for a code comment
or numeric literal then it generally means "count" or "cardinality".

## {C<$>,C<%>,C<@>}

The {C<$>,C<%>,C<@>} characters are mainly associated with scalars, tuples,
and relations, respectively.  They are used both to distinguish value
literals of those types as well as operators for those types.  In addition,
the C<@> character is used to indicate routine "dispatch" parameters.

## Bracketing Characters

Pairs of corresponding bracketing characters, meaning {C<()>,C<[]>,C<{}>},
are generally associated with groupings or lists of various kinds and serve
to delimit such.  The C<()> round-parenthesis pair is associated with
routine signatures (parameter list or result declarations), routine
invocations (argument list consisting of ordered or named arguments), and
disambiguating any functional code or value expressions (any
parenthesis-delimited routine body or code block therein is a function or a
value expression).  The C<[]> square-bracket pair is associated with
ordered lists and is used for: delimiting sequences of procedure
statements, delimiting array value literals, and in array-subscripting
operators, and for the reduction meta-operator.  The C<{}> pair is
associated with unordered lists and is used for: delimiting multi-update
statements, delimiting value literals of {tuples, relations,
(component-wise) scalars, sets, bags}, and in postcircumfix operators for
those same types.

## List-Separating Characters

The C<,> and C<;> characters are mainly used to separate (or trail) each of
the 0..N members of groupings or lists.  The C<,> comma is considered
tighter and is used for most groupings or lists, including: routine
signatures, routine invocations, collection value literals, postcircumfix
operators.  The C<;> semicolon is considered looser and is used for such
things as separating off-side-defined things like named value expressions
or variables or statements or inner materials.

## C<::=>

The C<::=> infix token is used for name binding; it declares that
whatever is on the right-hand side is associated with the entity name given
on the left-hand side.  The C<::=> is thusly used to explicitly name value
expressions, procedure statements, library materials, and to associate
global variables with lexical aliases.

## Pairs

The infix tokens {C<:>,C<< => >>,C<< <- >>,C<< <-- >>} are mainly used
between two items to designate that the they form a pair of some kind.  The
C<:> is the most common and is used for any context where the left-hand
side of the pair is always an entity name or heading, including: a
variable/parameter/attribute-like typed entity declaration
(var/param/attr-name : type-name), a named argument or tuple literal
attribute (arg/attr-name : value-expr), and a routine heading from a
routine body; a C<:> also separates the main parts of some value literals,
such as the literal kind keyword from the main literal.  The C<< => >> is
used for any context where two arbitrary value expressions are paired such
as in a C<Bag> literal or a C<Dict> literal.  The C<< <- >> is used just
between 2 entity names in the postcircumfix renaming operator.  The C<< <--
>> is used just in a function signature between the result type and
parameter list.

# RESOLVING AMBIGUITY

## Entity Names vs Keywords

A user-defined entity name may be any character string at all.  In the
general case, one must appear formatted as a C<quoted_name_str>, but if the
entity name only uses a limited set of characters, then it may appear
formatted as a C<nonquoted_name_str> instead, which is essentially the same
bareword format as the PTMD_STD language keywords.

When any PTMD_STD code contains a bareword whose meaning is ambiguous, in
that it could be interpreted as either a reference to a user-defined entity
or as a specific context-appropriate language keyword (including a routine
invocation alternate syntax), then the parser must always resolve it to the
keyword.  In these contexts, you must format a user-defined entity name as
a C<quoted_name_str> in order for it to be interpreted correctly.

Similarly, a user-defined entity name in C<quoted_name_str> format is
guaranteed to never be confused with a language keyword.

## Statements vs Expressions

Within a procedure, arbitrary value expressions may be used as the
left-hand-side of infix procedure calls, and some of those expressions may
normally have the same leading syntax as some kinds of statements.  For
example, an C<Array> expression can look like a C<compound_stmt>, and a
C<Set> expression can look like a C<multi_upd_stmt>, an C<if_else_expr> can
look like an C<if_else_stmt>, and so on.  When any PTMD_STD code exists
whose meaning is ambiguous from the context as to whether it is a statement
or an expression, then the parser must always resolve it to the statement.
In these contexts, you must surround the expression with parenthesis, a
C<delim_expr> in order for it to be interpreted correctly.  Similarly, any
routine code within parenthesis is always one or more expressions.

# NESTING PRECEDENCE RULES

This documentation section outlines Muldis D's PTMD_STD dialect's nesting
precedence rules, meaning how it accepts Muldis D code lacking explicit
expression delimiters and implicitly delimits the expressions therein, in a
fully deterministic manner.

PTMD_STD has 10 precedence levels when the C<catalog_abstraction_level>
pragma is C<rtn_inv_alt_syn>; if it is C<plain_rtn_inv> instead, then 6.5
of the levels can be eliminated, so then PTMD_STD has just 3.5; if it is
C<code_as_data> instead, then 2.5 more can be eliminated, leaving just 1.

Here we list the levels from "tightest" to "loosest", along with a few
examples of each level:

    Level            | Assoc | Examples
    -----------------+-------+---------------------------------------------
    Terms            | N/A   | Inf True Order:Same Down 42 3.14 -5/7 3*2^8
                     |       | F#'27E04' 'eek' foo "x" #`comment!`#
                     |       | {43,9,5} [1,2,3] {'Carrots'=>42} {11..20}
                     |       | $:{...} %:{...} @:{...} nlx.lib.MyType
                     |       | (1+2) myfunc(...) <Int> nlx.data.quux .age
    -----------------+-------+---------------------------------------------
    Postfix          | N/A   | func().attr p.{...} r{...} x.[...] y[...]
                     |       | ++ -- ! log-e
    -----------------+-------+---------------------------------------------
    Generic Prefix   | N/A   | abs # #+ % @ e**
    Generic Infix    | left  | assuming
                     |       | ^ exp ** log
                     |       | * / div mod intersect join times divideby
                     |       | where !where matching !matching compose
                     |       | intersect+
                     |       | + - |-| ~ ~# union exclude minus
                     |       | union+ union++ minus+ round
                     |       | as asserting min max //
    -----------------+-------+---------------------------------------------
    Comparison       | left  | <=> = != < > <= >= isa !isa like !like
                     |       | inside !inside holds !holds in !in has !has
                     |       | {<=} {!<=} {>=} {!>=} {<} {!<} {>} {!>}
                     |       | {<=}+ {!<=}+ {>=}+ {!>=}+ {<}+ {!<}+ {>}+ {!>}+
    -----------------+-------+---------------------------------------------
    Logical Prefix   | N/A   | not ! ¬
    Logical Infix    | left  | and ∧ nand ⊼ ↑ [<=>]
                     |       | or ∨ nor ⊽ ↓ xor ⊻ ↮
                     |       | imp → nimp ↛ if ← nif ↚
                     |       | xnor ↔
    -----------------+-------+---------------------------------------------
    Shorting Infix   | right | ??!! if-else-expr given-when-def-expr
    Binding Infix    | right | ::=
    -----------------+-------+---------------------------------------------
    Assignment       | non   | := :=++ :=-- :=foo

Any imperative code that embeds a value expression has looser precedence
than all value expressions.

Using two C<!> symbols below generically to represent any pair of operators
that have the same precedence, the associativities specified above
for binary, ternary, or N-ary operators are interpreted as follows:

    Assoc | Meaning of $a ! $b ! $c
    ------+------------------------
    left  | ($a ! $b) ! $c
    right | $a ! ($b ! $c)
    non   | ILLEGAL

# AUTHOR

Darren Duncan (C<darren@DarrenDuncan.net>)

# LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
