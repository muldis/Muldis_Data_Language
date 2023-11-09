# NAME

Muldis Data Language Plain Text (MDPT) - Muldis Data Language concrete syntax for source code

# VERSION

This document is Muldis Data Language Plain Text (MDPT) version 0.300.0.

# DESCRIPTION

This document is the human readable authoritative formal specification of
the **Muldis Data Language Plain Text** (**MDPT**) primary component of the **Muldis Data Language**
language.  The fully-qualified name of this document and the specification
it contains is `Muldis_Data_Language_Plain_Text https://muldis.com 0.300.0`.

See also [Muldis_Data_Language](Muldis_Data_Language.md) to read the **Muldis Data Language** language meta-specification.

The **Muldis Data Language Plain Text** specification defines the grammar of the official
concrete Muldis Data Language language syntax that every Muldis Data Language implementation
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

This document defines the grammar that all non-hosted plain-text Muldis Data Language
source code must conform to when it claims to be written in the
`Muldis_Data_Language Plain_Text https://muldis.com 0.300.0` (**MDPT**) language.

This grammar is meant to be more illustrative to human readers than
executable, as is typical for standards documents; you wouldn't likely be
able to just hand if off to a parser-generator and expect it to work as is.
But it should still have enough information to derive an executable parser.

Note that the standard filename extension for files with such source code
is `.mdpt`, though as per standard UNIX conventions, such Muldis Data Language source
code files can in fact have any filename extension when there is other
context to interpret them with.  Filename extensions are more for the
benefit of the operating system or command shell or users than for a
Muldis Data Language implementation, the latter just cares about the content of the file.

*TODO: Comment about resolving package names to package source files;
the CompUnitRepo concept of Raku would be a good precedent.
That will probably go somewhere else in the spec rather than here.*

A primary feature of Muldis Data Language is a grammar that is small and simple while
still being quite rich and expressive.  As much as possible of the language
is defined in terms of ordinary packages, types and routines, in exactly
the same manner as users write their own code in.  Therefore, a Muldis Data Language
grammar has no special knowledge of, or specific syntax for, the vast
majority of the language, and mainly just concerns itself with the minimal
syntactic framework for defining generic types and routines, generic
expressions and statements, and has special handling for just a small
number of data types or routines.  A key benefit of this is that it is very
easy for users to extend the language with new features that look and work
in the same way as the system-defined ones, and are drop-in substitutable
for them, rather than user-defined things being second-class citizens.  The
design also means it is much easier to implement the Muldis Data Language language
itself, a large part of the langauge can be bootstrapped, and both parsers
and generators of Muldis Data Language Plain Text can be simple and easy to make.

Muldis Data Language Plain Text has a *linear syntax*, and is designed to be easily
handled by a single-pass parser, or at least a single-pass lexer; all the
context that one needs to know for how to parse or lex any arbitrary
substring of code is provided by prior code, or any required lookahead is
just by a few characters in general.  Therefore, a parser/lexer can easily
work on a streaming input like a file-handle where you can't go back
earlier in the stream.  Often this means a parser/lexer can work with
little RAM.

Also the grammar is designed that any amount of whitespace can be added or
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

# GRAMMAR INTERPRETATION

*TODO: Describe the grammar itself and how to interpret it.  Meanwhile,
keep in mind that the grammar is inspired by both EBNF and Raku rules.*

    About separator-defined repetitions:
    - ** takes number or range on right
    - % takes list item separator on right, eg allows "x,y" but not "x,y,"
    - %% is like % but allows separator to end the list, eg allows "x,y,"

# PARSING UNITS

The root grammar token for Muldis Data Language Plain Text is `<MDPT>`.

Grammar:

    <MDPT> ::=
        ^ <parsing_unit> $

    <parsing_unit> ::=
        <shebang_line>? <sp> <parsing_unit_subject>

See the sections in this file named **SHEBANG LINE**
and **PARSING UNIT SUBJECTS** for more details.

# SHEBANG LINE

Grammar:

    <shebang_line> ::=
        '#!' <shebang_directive> <shebang_whitespace_break>

    <shebang_directive> ::=
        ...

    <shebang_whitespace_break> ::=
        ...

A `<shebang_line>`, if it exists, must be the first characters of the
text file, and consists of a magic number which expressed as ASCII or UTF-8
is `#!`, followed by a UNIX-like interpreter directive or path to an
executable that can interpret Muldis Data Language Plain Text files.  When a Muldis Data Language
Plain Text file starts with a shebang line, it can be invoked directly as
if it were an executable on a UNIX-like system.  The format of
`<shebang_directive>` isn't defined in this document; see the appropriate
external UNIX/etc documentation for that; however, the Muldis Data Language Plain Text
file must have at least one line-breaking whitespace character of some kind
following it, which is how we know where the Muldis Data Language code begins.

Examples:

    #!/usr/bin/env muldisdre

# PARSING UNIT SUBJECTS

Grammar:

    <parsing_unit_subject> ::=
        <expr>

See the section in this file named **GENERIC EXPRESSIONS** for more details.

# CHARACTER CLASSES

Grammar:

    <enumerated_char> ::=
          <alphanumeric_char>
        | <quoting_char>
        | <bracketing_char>
        | <symbolic_char>
        | <whitespace_char>
        | <illegal_char>

    <alphanumeric_char> ::=
        <alpha_char> | <digit_char>

    <alpha_char> ::=
        <[ A..Z _ a..z ]>

    <digit_char> ::=
        <[ 0..9 ]>

    <quoting_char> ::=
        <["'`]>

    <bracketing_char> ::=
        '(' | ')' | '[' | ']' | '{' | '}'

    <symbolic_char> ::=
        <special_symbolic_char> | <regular_symbolic_char>

    <special_symbolic_char> ::=
        ',' | ':' | ';' | '\\'

    <regular_symbolic_char> ::=
        <regular_symbolic_char_ASCII> | <regular_symbolic_char_nonASCII>

    <regular_symbolic_char_ASCII> ::=
          '!' | '#' | '$' | '%' | '&' | '*' | '+' | '-' | '.' | '/'
        | '<' | '=' | '>' | '?' | '@' | '^' | '|' | '~'

    <regular_symbolic_char_nonASCII> ::=
          '¬' | '±' | '×' | '÷'
        | 'π' | 'ρ' | 'σ'
        | '←' | '↑' | '→' | '↓' | '↔' | '↚' | '↛' | '↮'
        | '∀' | '∃' | '∄' | '∅' | '∆' | '∈' | '∉' | '∋' | '∌' | '−' | '∕'
        | '∖' | '∞' | '∧' | '∨' | '∩' | '∪' | '≠' | '≤' | '≥' | '⊂' | '⊃'
        | '⊄' | '⊅' | '⊆' | '⊇' | '⊈' | '⊉' | '⊎' | '⊤' | '⊥' | '⊻' | '⊼'
        | '⊽' | '⊿' | '⋊' | '⋈' | '⋉'
        | '▷' | '⟕' | '⟖' | '⟗' | '⨝' | '⨯'

    <whitespace_char> ::=
        <ws_unrestricted_char> | <ws_restricted_outside_char>

    <ws_unrestricted_char> ::=
        ' '

    <ws_restricted_outside_char> ::=
        '\t' | '\n' | '\r'

    <illegal_char> ::=
        <[ \x<0>..\x<8> \x<B>..\x<C> \x<E>..\x<1F> \x<80>..\x<9F> ]>

    <unrestricted_char> ::=
          <alphanumeric_char>
        | <bracketing_char>
        | <symbolic_char>
        | <ws_unrestricted_char>

    <restricted_outside_char> ::=
        <unrestricted_char> | <ws_restricted_outside_char>

    <restricted_inside_char> ::=
        <-quoting_char -illegal_char -ws_restricted_outside_char>

The Muldis Data Language Plain Text grammar recognizes 7 distinct character code point
(hereafter referred to as *character*) classes,
which are mutually disjoint proper subsets of the character repertoire
identified by the *script name*: *alphanumeric*, *quoting*, *bracketing*,
*symbolic*, *whitespace*, *illegal*, *nonenumerated*; the first 6 are
collectively *enumerated*.

The first 5 *enumerated* classes (all but *illegal*) are the more
syntactically interesting ones and are generally what the grammar are
defined in terms of.

Broadly speaking, Muldis Data Language Plain Text code is made up of 2 primary
grammatical contexts which are mutually disjoint and complementary; one of
these is anywhere *outside* all quoted strings, and its complement is
anywhere *inside* any quoted string; it is the *quoting* characters that
mark the transition between these 2 contexts.  Broadly speaking, all of the
*enumerated* classes (except *illegal*) represent characters that are
*unrestricted* and may appear anywhere in Plain Text source code.  In
contrast, *nonenumerated* characters may only appear literally
inside of a quoted string, and *illegal* characters may not appear
literally in source code at all.

All characters of the ASCII repertoire are *enumerated*; loosely speaking,
all printable ASCII characters are *unrestricted*, as
are the small number of non-printable ASCII characters named in
`<whitespace_char>`; all other (non-printable) ASCII characters are
*illegal*.

The vast majority of non-ASCII Unicode characters are *restricted* to
appearing literally inside of a quoted string, loosely speaking the
only exceptions being the small number named in `<symbolic_char>` or
`<whitespace_char>`; any non-ASCII Unicode control characters not
otherwise named are *illegal*.

Regardless of character class, all characters may be logically represented
in terms of character escape sequences, but only inside of a quoted string.

Note that the primary reason most enumerated whitespace characters are
generally restricted from being inside of a quoted string is so that the
Muldis Data Language Plain Text code is resilient to passage through environments that
might have different native line-breaking characters; the restriction
guarantees that executing the code will produce logically identical values
and behaviour for character string literals or quoted identifiers.  In
contrast, changing the line-breaking whitespace outside of string literals
is okay and doesn't change behaviour, so code can be formatted with them.

Note that the symbolic category is arbitrary in the trans-ASCII range and
is highly subject to gain or lose characters over time.

Note that, while in theory supporting bareword Greek letters may make math
or logic expressions more pleasant, for now they aren't partly to avoid
confusion with similar-looking ASCII letters, and because its hard to know
where to draw the line if one wanted to include the whole un-accented Greek
alphabet, not just `[ Α..Ρ Σ..Ω α..ω ]`; so in the end, simplicity rules.
UPDATE: A select few Greek letters are supported bareword, enumerated above.

# ESCAPED CHARACTERS

Grammar:

    <escaped_char> ::=
          '\\q' | '\\a' | '\\g'
        | '\\b'
        | '\\t' | '\\n' | '\\r'
        | ['\\c<' <nonsigned_int> '>']

The meanings of the simple character escape sequences are:

    Esc | Unicode    | Unicode         | Chr | Literal character used
    Seq | Code Point | Character Name  | Lit | for when not escaped
    ----+------------+-----------------+-----+------------------------------
    \q  | 0x22    34 | QUOTATION MARK  | "   | delimit Text/opaque literals
    \a  | 0x27    39 | APOSTROPHE      | '   | delimit quoted names
    \g  | 0x60    96 | GRAVE ACCENT    | `   | delimit dividing space comments
    \b  | 0x5C    93 | REVERSE SOLIDUS | \   | no special meaning in non-escaped
    \t  | 0x9      9 | CHAR... TAB...  |     | control char horizontal tab
    \n  | 0xA     10 | LINE FEED (LF)  |     | ctrl char line feed / newline
    \r  | 0xD     13 | CARR. RET. (CR) |     | control char carriage return

There is currently just one complex escape sequence, of the format
`\c<...>`, that supports specifying characters in terms of their Unicode
abstract code point number.  One reason for this feature is to empower more
elegant passing of Unicode-savvy Plain_Text source code through a
communications channel that is more limited, such as to 7-bit ASCII.

Examples:

    \a

    \n

    \c<0x263A>

    \c<65>

Note that Plain_Text eschews built-in support for a `\c<...>` format
that specifies characters in terms of their Unicode character name, for
example `\c<LATIN SMALL LETTER OU>`.  Instead, it is left to the
domain of non-core Muldis Data Language packages to support such a feature.  The main
reason for this is to avoid an unconditionally-mandatory complex dependency
that is the Unicode character database.

# DIVIDING SPACE

Grammar:

    <sp> ::=
        [<whitespace> | <quoted_sp_comment_str>]*

    <whitespace> ::=
        <whitespace_char>+

    <quoted_sp_comment_str> ::=
        '`' <-[`]>* '`'

The primary function of *dividing space*, represented by `<sp>`, is
to disambiguate the boundaries of otherwise-consecutive grammar tokens.

Once Muldis Data Language Plain Text code is parsed, any dividing space is just
discardable non-semantic metadata for its wider context, but during a parse
its presence is often critical to properly interpret the wider context.

The grammar doesn't specify this explicitly for simplicity, but anywhere a
`<sp>` token appears, it should be interpreted as carrying a number of
look-around assertions regarding adjacent tokens.

In the context of any `<foo> <sp> <bar>`, these syntax rules apply:

* If `<foo>` and `<bar>` are of different character classes
(alphanumeric vs quoting vs bracketing vs symbolic vs whitespace) then
`<sp>` is allowed to be empty.

* Otherwise, if `<foo>` and `<bar>` are both alphanumeric then
`<sp>` must be nonempty.

* Otherwise, if `<foo>` and `<bar>` are both quoting or bracketing
or whitespace then `<sp>` is allowed to be empty.

* Otherwise, `<foo>` and `<bar>` are both symbolic; whether or not
`<sp>` is allowed to be empty or not depends on the specific sequence
of symbolic characters in the original source code, as described by the
subsequent syntax rules.

* If either `<foo>` or `<bar>` or both are either `,` or `;` or
`\` then `<sp>` is allowed to be empty.

* Otherwise, if exactly one of `<foo>` or `<bar>` is `:` and the
other doesn't have that character then `<sp>` is allowed to be empty.

* OBSOLETE: Otherwise, if `<foo>` is `:=` then `<sp>` is allowed to be empty.

* Otherwise, `<sp>` must be nonempty.

*TODO.  Some of the above points concerning ":" are outdated and need fixing.*

The secondary function of *dividing space* is to empower users to format
their code for easier readability through appropriate linebreaks,
indentation, and other kinds of spacing, as they see fit; what they choose
here has no impact on the behaviour of the code.

The tertiary function of *dividing space* is to empower the placement of
code comments or visual dividers almost anywhere, but with the caveat that
comments written this way are not introspectable as comments in the parsed
code, and rather are treated like insignificant whitespace.  This style of
comment defined with backtick-quoted strings should just be used for the
likes of visual dividers or less important comments or for when you want to
quickly "comment out" some source code rather than deleting it.

For more important comments that are introspectable as such, see the
section in this file named **... TODO ...**.

Examples:

    `This does something.`

# KEYWORDS

Muldis Data Language Plain Text has a number of keywords, both alphanumeric and
symbolic, which have special meaning in certain contexts.  However, it does
not have any reserved words so users can still define identifiers having
any character string they want.

The keywords use a proper subset of the same syntax otherwise available for
user-defined identifiers.  In any contexts where it would otherwise be
ambiguous as to whether a term is a keyword versus the name of some entity,
the parser will always take the keyword interpretation.  For all such
cases, Muldis Data Language Plain Text provides syntax options that explicitly
disambiguate in favor of the non-keyword choice.  Since every entity name
`foo` is allowed to be double-quoted anywhere it appears like `'foo'`,
while all keywords only have a single syntax each which is non-quoted, a
non-quoted `foo` will always favor the keyword while a quoted `'foo'`
will always favor the entity name.

These are keywords:

    and_then
    args
    block
    current
    declare
    default
    else
    evaluates
    fail
    given
    guard
    if
    iterate
    leave
    literal
    new
    note
    or_else
    performs
    pipe
    returns
    then
    vars
    when
    ::=
    :.
    :<
    :>
    :>.
    :&
    :&.

These are keyword-like value literals:

    False
    True

These are used as list/pair separators:

    ::
    :
    ;
    ,

Finally, the backslash `\` is used heavily to indicate value literals of
many different kinds, disambiguating them from other things.

Muldis Data Language Plain Text purposefully keeps its set of keywords small, therefore
giving users the maximum amount of flexibility to effectively define
whatever operator/etc names they want for use as barewords, and the full
complement of system-defined types and operators are defined using the same
tools users have, so if you don't see something in the lists you would
expect to be system-defined, i's likely they're defined in libraries.

# IDENTIFIERS

Grammar:

    <alphanumeric_name> ::=
        <alpha_char> <alphanumeric_char>*

    <symbolic_name> ::=
        <symbolic_char>+

    <quoted_name> ::=
        <quoted_name_seg> % <sp>

    <quoted_name_seg> ::=
        '\'' <qnots_content> '\''

    <generic_name> ::=
        <alphanumeric_name> | <quoted_name>

    <fixed_name> ::=
        <alphanumeric_name> | <symbolic_name>

    <attr_name> ::=
        <nonord_attr_name> | <ord_attr_name>

    <nonord_attr_name> ::=
        <generic_name>

    <ord_attr_name> ::=
        <nonsigned_int>

    <nesting_attr_names> ::=
        <attr_name> % [<sp> '::' <sp>]

    <expr_name> ::=
        <generic_name>

    <var_name> ::=
        <generic_name>

    <stmt_name> ::=
        <generic_name>

    <pkg_entity_name> ::=
          <absolute_name>
        | <relative_name>
        | <floating_name>

    <absolute_name> ::=
        '::' <sp> <floating_name>

    <relative_name> ::=
        <digit_char>+ [<sp> '::' <sp> <floating_name>]?

    <floating_name> ::=
        <generic_name> % [<sp> '::' <sp>]

    <folder_name> ::=
        <absolute_name>

    <material_name> ::=
        <absolute_name>

    <generic_func_name> ::=
        <pkg_entity_name>

    <generic_proc_name> ::=
        <pkg_entity_name>

    <entry_point_rtn_name> ::=
        <absolute_name>

A `<generic_name>` is a *generic context entity name*, which can be
used in any context that is expecting *a* Muldis Data Language entity name in the
general sense, without restrictions.  Examples of use are when declaring
any named entity or with general type/routine/etc invocation syntax that
allows any entity of the respective kind, or for attr names.

A `<fixed_name>` is for use within value expressions with certain
common cases of function invocations where an unqualified
operator name appears next to its operands without any parenthesis to group
the operands under the operator.  The *fixed* name comes from such
invocations being usually qualified as *prefix* or *infix* or *postfix*.

A `<pkg_entity_name>` is for use when either declaring or referencing
package entities (types, singleton type definers, functions, procedures, aliases, etc)
which live within a multi-level namespace.

# GENERIC EXPRESSIONS

Grammar:

    <expr> ::=
        <expr_name> | <naming_expr> | <annotating_expr> | <anon_expr>

    <naming_expr> ::=
        <expr_name> <sp> '::=' <sp> <named_expr>

    <named_expr> ::=
        <expr>

    <annotating_expr> ::=
        <annotated_expr> note <annotation_expr>

    <annotated_expr> ::=
        <expr>

    <annotation_expr> ::=
        <expr>

    <anon_expr> ::=
          <delimiting_expr>
        | <source_expr>
        | <literal_expr>
        | <opaque_literal_expr>
        | <collection_selector_expr>
        | <collection_accessor_expr>
        | <invocation_expr>
        | <conditional_expr>
        | <fail_expr>
        | ...

    <delimiting_expr> ::=
        '(' <sp> [
            <naming_expr> | <result_expr> | ''
        ] % [<sp> ';' <sp>] <sp> ')'

    <result_expr> ::=
          [returns <sp> <expr>]
        | <expr_name>
        | <annotating_expr>
        | <anon_expr>

    <source_expr> ::=
        args

    <literal_expr> ::=
        literal <expr>

    <fail_expr> ::=
        fail

An `<expr>` is a Muldis Data Language *generic context value expression*, which
can be used in any context that is expecting *a* value but has no
expectation that said value belongs to a specific data type.  In the
general case, an expression denoting any value of the `Any` type may
be used where you see `<expr>`, any further restrictions would be
provided by the context.

Iff an `<expr>` is an `<expr_name>`, then this means that an
ancestor `<expr>` is having at least one of its descendents declared
with an explicit name/alias rather than being anonymous inline, and then
the `<expr_name>` is the invocation name of that child.

Iff an `<expr>` is a `<naming_expr>`, then the `<named_expr>`
element of the `<naming_expr>` is being declared with an explicit
name/alias, and the `<expr_name>` element of the `<naming_expr>`
is that name/alias.  Any `<expr>` not thusly named/aliased is
anonymous; there is no name to refer to it by in the system and it only can
be used in the one place where it is declared.

Iff an `<expr>` is an `<annotating_expr>`, then the
`<annotated_expr>` element of the `<annotating_expr>` is being given
an explicit introspectable code annotation whose value is the
`<annotation_expr>` element.  Keep in mind that `note` binds tighter than
nearly anything, so you may have to use parenthesis when you want the
annotation to associate with a non-leaf node.  The most typical kind of
annotation is an internal code comment expressed as a `Text` literal,
or it may be a `Tuple` of what would otherwise be individual annotations.

An `<annotation_expr>` is subject to the additional rule that it must
be a completely foldable singleton type definer.  It may not contain a `<source_expr>`.

Iff an `<expr>` is a `<delimiting_expr>`, then it is interpreted
simply as if it were its child `<expr>` element; the primary reason
that the `<delimiting_expr>` grammar element exists is to assist the
parser in determining the boundaries of an `<expr>` where code
otherwise might be ambiguous or be interpreted differently than desired due
to nesting precedence rules.

A `<delimiting_expr>` is subject to the additional rule that it must
contain exactly one `<result_expr>` element, which provides its value.

Iff an `<expr>` is a `<source_expr>`, then it represents the value
of the expression-containing routine's *source* / read-only arguments.

Iff an `<expr>` is a `<literal_expr>`, then its child `<expr>`
is treated as completely foldable to a `Literal`
value even if it otherwise wouldn't be, such as when a descendant `<expr>`
is an `<args_expr>`; useful for nested routine definitions.

Iff an `<expr>` is a `<fail_expr>`, then any attempt at runtime
to take that node's value will throw an exception, and so it should only
appear as a child of a `<conditional_expr>` node, one that is
performing an assertion that its other inputs are reasonable.

*TODO: Add something like 'publish' or 'trace' etc which writes to a
side-channel but has no local effect.  Such as these and maybe 'fail'
should be documented in another sub-section perhaps.*

See the sections in this file named **OPAQUE LITERAL EXPRESSIONS**,
**COLLECTION SELECTOR EXPRESSIONS**, **INVOCATION EXPRESSIONS**, and
**CONDITIONAL EXPRESSIONS** for more details.

Examples:

    `an expr_name node`
    foo_expr

    `a naming_expr node`
    bar_expr ::= factorial::( foo_expr )

    5 + 42 note "this is an introspectable comment attached to the 42"

    myfoo note "this is a comment on the elsewhere-declared node named myfoo"

    `a delimiting_expr node`
    (x ::= y + 2; returns x * x)

    `this uses one too`
    (x + y) * z

    `this is the routine's argument list`
    args

    `nested definition of function that adds 42 to its sole argument`
    literal (\Function : (evaluates : (args:.\0 + 42)))

    `some assertion failed`
    fail

*TODO: ADD SIGNAL SENDING AND OTHER MISC EXPRESSIONS.*

# OPAQUE LITERAL AND COLLECTION SELECTOR EXPRESSIONS

Grammar:

    <opaque_literal_expr> ::=
          <Boolean>
        | <Integer>
        | <Fraction>
        | <Bits>
        | <Blob>
        | <Text>
        | <Simple_Excuse>
        | <Attr_Name>
        | <Nesting>
        | <Heading>
        | <Renaming>
        | <Identifier>
        | <Identity_Identifier>

    <collection_selector_expr> ::=
          <Array>
        | <Set>
        | <Bag>
        | <Tuple>
        | <Tuple_Array>
        | <Relation>
        | <Tuple_Bag>
        | <Article>
        | <Excuse>
        | <Function_Call>

An `<opaque_literal_expr>` is an `<expr>` that denotes a value
literal specific to some system-defined data type that has its own special
Muldis Data Language Plain Text selector syntax, and this literal syntax explicitly has
no child `<expr>` nodes.  In conventional terms, one is typically for
selecting scalar values, though many cases are also simple collections.

A `<collection_selector_expr>` is an `<expr>` that denotes a
value literal specific to some system-defined data type that has its own
special Muldis Data Language Plain Text selector syntax, and this literal syntax
explicitly does have child `<expr>` nodes in the general case, as in
conventional terms it is for selecting values representing collections of
other values.

## Boolean Literals

Grammar:

    <Boolean> ::=
        ['\\?' <sp>]? [False | True]

A `<Boolean>` node represents a value of the Muldis Data Language `Boolean` type,
which is a general purpose 2-valued logic boolean or *truth value*.  The
`Boolean` type is a foundational type of the Muldis Data Language type system, and
this is the canonical grammar for them.

Examples:

    False

    True

    \?False

    \?True

## Integer Literals

Grammar:

    <Integer> ::=
        <nonquoted_int> | <quoted_int>

    <nonquoted_int> ::=
        ['\\+' <sp>]? <asigned_int>

    <asigned_int> ::=
        <num_sign>? <nonsigned_int>

    <num_sign> ::=
        '+' | '-'

    <nonsigned_int> ::=
        <num_radix_mark>? <num_seg>

    <num_radix_mark> ::=
        0 <[bodx]>

    <num_seg> ::=
        <num_char>+

    <num_char> ::=
        <nc2> | <nc8> | <nc10> | <nc16>

    <nc2> ::=
        <[ 0..1 _ ]>

    <nc8> ::=
        <[ 0..7 _ ]>

    <nc10> ::=
        <[ 0..9 _ ]>

    <nc16> ::=
        <[ 0..9 A..F _ a..f ]>

    <quoted_int> ::=
        <qu_num_head> <qu_asigned_int> <qu_num_tail>

    <qu_num_head> ::=
        '\\+' <sp> '"'

    <qu_asigned_int> ::=
        <asigned_int> <qu_num_mid>?

    <qu_num_mid> ::=
        <num_seg> % <qu_num_sp>

    <qu_num_sp> ::=
        '"' <sp> '"'

    <qu_num_tail> ::=
        '"'

An `<Integer>` node represents a value of the Muldis Data Language `Integer`
type, which is a general purpose exact integral number of any magnitude,
which explicitly does not represent any kind of thing in particular,
neither cardinal nor ordinal nor nominal.  The `Integer` type is a
foundational type of the Muldis Data Language type system, and this is the canonical
grammar for them.

This grammar supports writing `Integer` literals in any of the numeric
bases {2,8,10,16} using conventional syntax.  The literal may optionally
contain underscore characters (`_`), which exist just to help with visual
formatting, such as for `10_000_000`.

This grammar is subject to the following additional rules:

* If `<num_radix_mark>` is omitted or is `0d` then every
`<num_char>` must be a `<nc10>`.

* Otherwise, if `<num_radix_mark>` is `0b` or `0o` or `0x` then every
`<num_char>` must be a `<nc2>` or `<nc8>` or `<nc16>`
respectively.

A quoted `<Integer>` may optionally be split into 1..N quoted segments
where each pair of consecutive segments is separated by dividing space;
this segmenting ability is provided to support code that contains very long
numeric literals while still being well formatted (no extra long lines).

Note that the general grammar rules of Muldis Data Language Plain Text will treat all
nonquoted symbolic characters {-,+,.,/} as *fixed* operator invocations,
and nonquoted digit sequences as positive integer literals.  However,
nonquoted numeric literals have a special exception for {-,+,.,/} iff they
appear in very specific places, such that those symbolics are treated as
part of a numeric literal instead of an operator call.  This is done so
that all values of the core numeric types can be written in a clean and
concise manner while avoiding any risk of the meanings of the literals
changing depending what Muldis Data Language packages are in scope, which would be the
case if the symbolics were parsed as operator calls.  When writing Muldis Data Language
Plain Text code with unquoted numeric literals, having dividing space
between any {-,+,.,/} and any `<num_char>` should guarantee their
interpretation as an operator call, while ensuring no dividing space
between them should guarantee interpretation as part of the literal iff the
symbolics are in specific positions expected for the latter.  This special
exception breaks the general grammar rule where symbolics and alphanumerics
are always considered separate tokens regardless of whether or not there is
dividing space between them, however that is considered a lesser surprise.

Examples:

    42

    0

    -3

    \+"-3" "50_897"

    \+81

    0d39

    0xDEADBEEF

    0o644

    0b11001001

## Fraction Literals

Grammar:

    <Fraction> ::=
        <nonquoted_frac> | <quoted_frac>

    <nonquoted_frac> ::=
        <nonquoted_int> <frac_div> <num_seg>

    <frac_div> ::=
        '.' | '/'

    <quoted_frac> ::=
        <qu_num_head> <qu_asigned_int> <frac_div> <qu_num_mid> <qu_num_tail>

A `<Fraction>` node represents a value of the Muldis Data Language `Fraction`
type, which is a general purpose exact rational number of any magnitude and
precision, expressible as a coprime *numerator* / *denominator* pair of
`Integer` whose *denominator* is positive, which explicitly does not
represent any kind of thing in particular, neither cardinal nor ordinal nor
nominal.

The `Fraction` type is not a foundational type of the Muldis Data Language type
system, but rather is a subtype by constraint of the `Article` type, and
all `Fraction` values can be selected in terms of `<Article>` grammar
nodes.  However, `<Fraction>` is the canonical grammar for all
`Fraction` values.

An entire `<Fraction>` literal has the same numeric base, both the
part before the `<frac_div>` and the part after it.  When the
`<frac_div>` is a `/`, the literal portion on the left is treated as the
integral *numerator* and the part on the right as the integral
*denominator*; the literal allows that pair to not be coprime, and it will
be normalized in the derived `Fraction` value.  When the `<frac_div>`
is a `.`, the anormal *numerator* is determined by treating all of the
`<num_char>` as an integral literal as if the `.` wasn't there, and
the anormal *denominator* is determined by taking the numeric base to the
power of the number of `<num_char>` on the right side of the `.`.

Examples:

    3.14159

    0.0

    5/3

    -4.72

    -472/100

    \+29.95

    0xDEADBEEF.FACE

    -0o35/3

    0b1.1

## Bits Literals

Grammar:

    <Bits> ::=
        '\\~?' <sp> [
              [['"' ['0b'? <nc2>* ]? '"'] % <sp>]
            | [['"' ['0o'  <nc8>* ]? '"'] % <sp>]
            | [['"' ['0x'  <nc16>*]? '"'] % <sp>]
        ]

A `<Bits>` node represents a value of the Muldis Data Language `Bits` type, which
is an arbitrarily-long sequence of *bits* where each bit is represented by
an `Integer` in the range 0..1.

The `Bits` type is not a foundational type of the Muldis Data Language type system,
but rather is a subtype by constraint of the `Article` type, and all
`Bits` values can be selected in terms of `<Article>` grammar nodes.
However, `<Bits>` is the canonical grammar for all `Bits` values.

This grammar supports writing `Bits` literals in any of the numeric bases
{2,8,16} using conventional syntax.  The literal may optionally contain
underscore characters (`_`), which exist just to help with visual
formatting.  A `<Bits>` may optionally be split into 1..N segments
where each pair of consecutive segments is separated by dividing space.

Examples:

    \~?""

    \~?"00101110100010"

    \~?"0b00101110100010"

    \~?"0o644"

    \~?"0xA705E"

## Blob Literals

Grammar:

    <Blob> ::=
        '\\~+' <sp> [
              [['"' ['0b'  <nc2>* ]? '"'] % <sp>]
            | [['"' ['0x'? <nc16>*]? '"'] % <sp>]
        ]

A `<Blob>` node represents a value of the Muldis Data Language `Blob` type, which
is an arbitrarily-long sequence of *octets* where each octet is
represented by an `Integer` in the range 0..255.

The `Blob` type is not a foundational type of the Muldis Data Language type system,
but rather is a subtype by constraint of the `Article` type, and all
`Blob` values can be selected in terms of `<Article>` grammar nodes.
However, `<Blob>` is the canonical grammar for all `Blob` values.

This grammar supports writing `Blob` literals in any of the numeric bases
{2,16} using conventional syntax.  The literal may optionally contain
underscore characters (`_`), which exist just to help with visual
formatting.  A `<Blob>` may optionally be split into 1..N segments
where each pair of consecutive segments is separated by dividing space.

This grammar is subject to the following additional rules:

* If the `<Blob>` segments are prefixed by `0b` then the total count of
`<nc2>` in the `<Blob>` excluding `_` must be an even multiple
of 8.

* Otherwise, if the `<Blob>` segments are prefixed by `0x` then the
total count of `<nc16>` in the `<Blob>` excluding `_` must be an
even multiple of 2.

Examples:

    \~+""

    \~+"A705E416"

    \~+"0xA705E416"

    \~+"0b00101110_10001011"

## Text Literals

Grammar:

    <Text> ::=
        ['\\~' <sp>]? [<Text_seg> % <sp>]

    <Text_seg> ::=
        '"' <qnots_content> '"'

    <qnots_content> ::=
        <qns_nonescaped_content> | <qns_escaped_content>

    <qnots_nonescaped_content> ::=
        [<restricted_inside_char-[\\]> <restricted_inside_char>*]?

    <qnots_escaped_content> ::=
        '\\' [<restricted_inside_char-[\\]> | <escaped_char>]*

A `<Text>` node represents a value of the Muldis Data Language `Text` type, which
is characterized by an arbitrarily-long sequence of Unicode 12.1 standard
*character code points*.

The `Text` type is not a foundational type of the Muldis Data Language type system,
but rather is a subtype by constraint of the `Article` type, and all
`Text` values can be selected in terms of `<Article>` grammar nodes.
However, `<Text>` is the canonical grammar for all `Text` values.

A `<Text>` may optionally be split into 1..N segments where each pair
of consecutive segments is separated by dividing space.

*TODO: Change to a strict 3-level hierarchy which ranks double-quoted
strings above single-quoted strings and allows literal single-quotes inside
double-quoted strings. This is part of the Plain_Text syntax becoming a
proper superset of the Muldis Object Notation syntax.*

Examples:

    "Ceres"

    "サンプル"

    ""

    "\This isn\at not escaped.\n"

    "\\c<0x263A>\c<65>"

    \~"Green"

## Array Selectors

Grammar:

    <Array> ::=
        ['\\~' <sp>]? <ord_member_commalist>

    <ord_member_commalist> ::=
        '[' <sp> <member_commalist> <sp> ']'

An `<Array>` node represents a value of the Muldis Data Language
`Array` type, which is ...

## Set Selectors

Grammar:

    <Set> ::=
        ['\\?' <sp>]? <nonord_member_commalist>

A `<Set>` node represents a value of the Muldis Data Language
`Set` type, which is ...

A `<Set>` is subject to the additional rule that, either its
`<member_commalist>` must not have any `<multiplied_member>`
elements, or the `<Set>` must have the `\?` prefix, so that the
`<Set>` can be distinguished from every possible `<Bag>`.

## Bag / Multiset Selectors

Grammar:

    <Bag> ::=
        ['\\+' <sp>]? <nonord_member_commalist>

    <nonord_member_commalist> ::=
        '{' <sp> <member_commalist> <sp> '}'

    <member_commalist> ::=
        [<single_member> | <multiplied_member> | ''] % [<sp> ',' <sp>]

    <single_member> ::=
        <member_expr>

    <multiplied_member> ::=
        <member_expr> <sp> ':' <sp> <multiplicity_expr>

    <member_expr> ::=
        <expr>

    <multiplicity_expr> ::=
        <expr>

A `<Bag>` node represents a value of the Muldis Data Language
`Bag` type, which is ...

A `<Bag>` is subject to the additional rule that, either its
`<member_commalist>` must have at least 1 `<multiplied_member>`
element, or the `<Bag>` must have the `\+` prefix, so that the
`<Bag>` can be distinguished from every possible `<Set>`.  An
idiomatic way to represent an empty `Bag` is to have exactly 1
`<multiplied_member>` whose `<multiplicity_expr>` is zero.

## Tuple / Attribute Set Selectors

Grammar:

    <Tuple> ::=
        ['\\%' <sp>]? <delim_attr_commalist>

    <delim_attr_commalist> ::=
        '(' <sp> <attr_commalist> <sp> ')'

    <attr_commalist> ::=
        [<anon_attr> | <named_attr> | <nested_named_attr> | <same_named_attr> | <same_named_var> | ''] % [<sp> ',' <sp>]

    <anon_attr> ::=
        <attr_asset_expr>

    <named_attr> ::=
        <attr_name> <sp> ':' <sp> <attr_asset_expr>

    <nested_named_attr> ::=
        <nesting_attr_names> <sp> ':' <sp> <attr_asset_expr>

    <same_named_attr> ::=
        ':' <sp> <attr_name>

    <same_named_var> ::=
        ':&' <sp> <attr_name>

    <attr_asset_expr> ::=
        <expr>

A `<Tuple>` node represents a value of the Muldis Data Language
`Tuple` type, which is ...

A `<Tuple>` is subject to the additional rule that, iff its
`<attr_commalist>` has exactly 1 `<*_attr>` element, either that
element must have a leading or trailing comma, or the `<Tuple>` must
have the `\%` prefix, so that the `<Tuple>` can be distinguished from
every possible `<Article>` and `<delimiting_expr>`.

## Tuple Array Selectors

Grammar:

    <Tuple_Array> ::=
        '\\~%' <sp> [<delim_attr_name_commalist> | <ord_member_commalist>]

A `<Tuple_Array>` node represents a value of the Muldis Data Language
`Tuple_Array` type, which is ...

A `<Tuple_Array>` with an `<ord_member_commalist>` is subject to
the additional rule that its `<member_commalist>` has at least 1
`<*_member>` element; otherwise the `<Tuple_Array>` must have a
`<delim_attr_name_commalist>`.

## Relation / Tuple Set Selectors

Grammar:

    <Relation> ::=
        '\\?%' <sp> [<delim_attr_name_commalist> | <nonord_member_commalist>]

A `<Relation>` node represents a value of the Muldis Data Language
`Relation` type, which is ...

A `<Relation>` with a `<nonord_member_commalist>` is subject to
the additional rule that its `<member_commalist>` has at least 1
`<*_member>` element; otherwise the `<Relation>` must have a
`<delim_attr_name_commalist>`.

## Tuple Bag Selectors

Grammar:

    <Tuple_Bag> ::=
        '\\+%' <sp> [<delim_attr_name_commalist> | <nonord_member_commalist>]

A `<Tuple_Bag>` node represents a value of the Muldis Data Language
`Tuple_Bag` type, which is ...

A `<Tuple_Bag>` with a `<nonord_member_commalist>` is subject to
the additional rule that its `<member_commalist>` has at least 1
`<*_member>` element; otherwise the `<Tuple_Bag>` must have a
`<delim_attr_name_commalist>`.

## Article / Labelled Tuple Selectors

Grammar:

    <Article> ::=
        ['\\:' <sp>]? '(' <sp> <c_label_expr> <sp> ':' <sp> <c_attrs_expr> <sp> ')'

    <c_label_expr> ::=
        <expr>

    <c_attrs_expr> ::=
        <expr>

A `<Article>` node represents a value of the Muldis Data Language
`Article` type, which is ...

Examples:

    (\Fraction : (numerator : 5, denominator : 3))

## Excuse Selectors

Grammar:

    <Excuse> ::=
        '\\!' <sp> <delim_attr_commalist>

An `<Excuse>` node represents a value of the Muldis Data Language
`Excuse` type, which is ...

## Simple Excuse Literals

Grammar:

    <Simple_Excuse> ::=
        '\\!' <sp> <attr_name>

A `<Simple_Excuse>` node represents a value of the Muldis Data Language `Excuse`
type, and provides a terser alternative syntax to an `<Excuse>` node
for the common special case of `Excuse` having just the `0` attribute
where that attribute is valued with an `Attr_Name`, such as is the case
for all typical Muldis Data Language Foundation defined `Excuse` subtypes.

Examples:

  \!No_Reason

  \!Before_All_Others

  \!Div_By_Zero

  \!No_Such_Attr_Name

## Nesting / Attribute Name List Literals

Grammar:

    <Nesting> ::=
        '\\\$' <sp> <nesting_attr_names>

An `<Nesting>` node represents a value of the Muldis Data Language `Nesting`
type, which is an arbitrarily-long sequence of `Attr_Name` values.  It
typically serves as a (fully or partially) qualified identifier for referencing
either a foundation entity, or a package or component of the latter, from
the perspective of an entity in a (possibly same) package using it.

THIS PARAGRAPH IS OBSOLETE AND DESCRIBES AFTER-PARSING BEHAVIOUR FOR CONTEXTS
WHERE A Local_Name VALUE IS EXPECTED.
Iff the first/only `Attr_Name` in the sequence is one of the barewords
`{foundation,used,package,folder,material,floating}` then it is used
as-is; otherwise the sequence will implicitly have the element `floating`
prepended to it.  Each of the non-first (post optional prepend) sequence
elements corresponds in order to a level in a multi-level namespace.

The `Nesting` type is not a foundational type of the Muldis Data Language type
system, but rather is a subtype by constraint of the `Array` type, and all
`Nesting` values can be selected in terms of `<Array>` grammar
nodes.  However, `<Nesting>` is the canonical grammar for all
`Nesting` values.

Examples (comments refer to their Muldis Data Language runtime specific interpretation):

    `The Muldis Data Language Foundation function Integer_plus, from any perspective.`
    \$foundation::Integer_plus

    `The system-defined "Relation" type, from the perspective of some other
    package that "uses" the "System" package under the local alias "MD".`
    \$used::MD::Relation

    `Some user-defined "main" procedure, from the perspective of the same
    package as that which it is defined in.`
    \$package::main

    `Some entity "foo" that has the same parent folder as the observer.`
    \$folder::foo

    `Some material from its own perspective, such as for self-recursion.`
    \$material

    `Same "Relation" as above iff \$used::MD is among in the declared
    "floating" list of the same observer's package.`
    \$floating::Relation

    `Same thing, after post-processing.`
    \$Relation

## Attribute Name and Heading / Attribute Name Set Literals

Grammar:

    <Attr_Name> ::=
        '\\' <sp> <attr_name>

    <Heading> ::=
        '\\\$' <sp> <delim_attr_name_commalist>

    <delim_attr_name_commalist> ::=
        '(' <sp> <attr_name_commalist> <sp> ')'

    <attr_name_commalist> ::=
        [<attr_name> | <ord_attr_name_range> | ''] % [<sp> ',' <sp>]

    <ord_attr_name_range> ::=
        <min_ord_attr> <sp> '..' <sp> <max_ord_attr>

    <min_ord_attr> ::=
        <ord_attr_name>

    <max_ord_attr> ::=
        <ord_attr_name>

A `<Heading>` node represents a value of the Muldis Data Language
`Heading` type, which is an arbitrarily-large unordered collection of
attribute names.  An `<Attr_Name>` node represents a value of the
Muldis Data Language `Attr_Name` type, which is a subtype by constraint of the `Heading`
type; `<Attr_Name>` provides a terser alternative syntax for the
common special case of `<Heading>` having exactly 1 attribute.

An `<ord_attr_name_range>` is subject to the additional rule that its
integral `<min_ord_attr>` value must be less than or equal to its
integral `<max_ord_attr>` value.

The `Heading` type is not a foundational type of the Muldis Data Language type
system, but rather is a subtype by constraint of the `Tuple` type, and all
`Heading` values can be selected in terms of `<Tuple>` grammar
nodes.  However, `<Heading>` is the canonical grammar for all
`Heading` values, except for all `Attr_Name` values, for which
`<Attr_Name>` is the canonical grammar.

Examples:

    `Zero attributes.`
    \$()

    `One named attribute.`
    \sales

    `Same thing.`
    \$(sales)

    `Same thing.`
    \$('sales')

    `One ordered attribute.`
    \0

    `Same thing.`
    \'\\c<0>'

    `Three nonordered attributes.`
    \$(region,revenue,qty)

    `Three ordered attributes.`
    \$(0..2)

    `One of each.`
    \$(1,age)

    `Some attribute names can only appear quoted.`
    \'Street Address'

    `A non-Latin name.`
    \'サンプル'

## Attribute Renaming Specification Literals

Grammar:

    <Renaming> ::=
        '\\\$:' <sp> '(' <sp> <renaming_commalist> <sp> ')'

    <renaming_commalist> ::=
        [<anon_attr_rename> | <named_attr_rename> | ''] % [<sp> ',' <sp>]

    <anon_attr_rename> ::=
          ['->' <sp> <attr_name_after>]
        | [<attr_name_after> <sp> '<-']
        | [<attr_name_before> <sp> '->']
        | ['<-' <sp> <attr_name_before>]

    <named_attr_rename> ::=
          [<attr_name_before> <sp> '->' <sp> <attr_name_after>]
        | [<attr_name_after> <sp> '<-' <sp> <attr_name_before>]

    <attr_name_before> ::=
        <nonord_attr_name>

    <attr_name_after> ::=
        <nonord_attr_name>

A `<Renaming>` node represents a value of the Muldis Data Language `Renaming`
type, which is an arbitrarily-large unordered collection of attribute
renaming specifications.  Each attribute renaming specification is a pair
of attribute names marked with a `->` or a `<-` element; the
associated `<attr_name_before>` and `<attr_name_after>` indicate
the name that an attribute has *before* and *after* the renaming
operation, respectively.  Iff the renaming specification is a
`<anon_attr_rename>` then either the *before* or *after* name is an
ordered attribute name corresponding to the ordinal position of the
renaming specification element in the `<renaming_commalist>`, starting
at zero.

A `<renaming_commalist>` is subject to the additional rule that no 2
`<attr_name_before>` may be the same attribute name and that no 2
`<attr_name_after>` may be the same attribute name.

The `Renaming` type is not a foundational type of the Muldis Data Language type
system, but rather is a subtype by constraint of the `Tuple` type, and all
`Renaming` values can be selected in terms of `<Tuple>` grammar
nodes.  However, `<Renaming>` is the canonical grammar for all
`Renaming` values.

Examples:

    `Zero renamings, a no-op.`
    \$:()

    `Also a no-op.`
    \$:(age->age)

    `Rename one attribute.`
    \$:(fname->first_name)

    `Same thing.`
    \$:(first_name<-fname)

    `Swap 2 named attributes.`
    \$:(foo->bar,foo<-bar)

    `Convert ordered names to nonordered.`
    \$:(->foo,->bar)

    `Same thing.`
    \$:(0->foo,1->bar)

    `Convert nonordered names to ordered.`
    \$:(<-foo,<-bar)

    `Same thing.`
    \$:(0<-foo,1<-bar)

    `Swap 2 ordered attributes.`
    \$:(0->1,0<-1)

    `Same thing.`
    \$:(->1,->0)

    `Some attribute names can only appear quoted.`
    \$:('First Name'->'Last Name')

## Identifier and Identity_Identifier Literals

Grammar:

    <Identifier> ::=
        ...

    <Identity_Identifier> ::=
        ...

*TODO.  Note that Function_Name and ..._Name are aliases for Identity_Identifier.*

## Generic Function Call Specification Selectors

Grammar:

    <Function_Call> ::=
        <long_arrowed_func_invo_sel> | <postcircumfixed_func_invo_sel>

    <long_arrowed_func_invo_sel> ::=
          [<generic_func_args> <sp> '\\-->' <sp> <generic_func_call>]
        | [<generic_func_call> <sp> '\\<--' <sp> <generic_func_args>]

    <postcircumfixed_func_invo_sel> ::=
        '\\' <postcircumfixed_func_invo_expr>

*TODO.*
*Note that, yes, the generic_func_call input is also a Function_Call value,
same type as the result of the Function_Call expression, so that is indeed
recursively defined in the general case.  And so other syntax would be used
to select the most-nested Function_Call value, often postcircumfixed_func_invo_expr.*

# COLLECTION ACCESSOR EXPRESSIONS

Grammar:

    <collection_accessor_expr> ::=
          <Tuple_at>
        | <Article_label>
        | <Article_attrs>
        | <Article_at>
        | <Variable_current>
        | <Variable_at>

    <Tuple_at> ::=
        <expr> <sp> ':.' <sp> <expr>

    <Article_label> ::=
        <expr> <sp> ':<'

    <Article_attrs> ::=
        <expr> <sp> ':>'

    <Article_at> ::=
        <expr> <sp> ':>.' <sp> <expr>

    <Variable_current> ::=
        <expr> <sp> ':&'

    <Variable_at> ::=
        <expr> <sp> ':&.' <sp> <expr>

*TODO.*

# INVOCATION EXPRESSIONS

Grammar:

    <invocation_expr> ::=
          <generic_func_invo_expr>
        | <fixed_func_invo_expr>

*TODO.*

*OBSOLETE... Also TODO is adding things like --*? and -->! etc to test if something
is invokable or indicate a result if one isn't invokable.>

## Generic Function Invocation Expressions

Grammar:

    <generic_func_invo_expr> ::=
        <primed_func_invo_expr> | <postcircumfixed_func_invo_expr>

    <primed_func_invo_expr> ::=
        evaluates <sp> <primed_func_call>

    <primed_func_call> ::=
        <expr>

    <postcircumfixed_func_invo_expr> ::=
        <generic_func_name> <sp> '::'? <sp> <Tuple>

*TODO.*

A `<primed_func_call>` denotes a `Function_Call` value, which pairs
a `Function_Name` (`Identity_Identifier`) value naming a function
with a `Tuple` value giving arguments to pass to it; typically this
is defined either with a `<Function_Call>` selector expression or with
an inline-defined `function`.

*TODO: Also define the \foo::(...) and \(...) and \[...] syntaxes for "Routine_Call" type.*

A `<postcircumfixed_func_invo_expr>` is subject to the additional rule
that, iff its `<generic_func_name>` element has no `::` within
itself, then that element must have a trailing `::` element.

A `<generic_func_name>` may alternately be a singleton type definer name or a type
name, and not just a function name, because those can be invoked like
functions under certain circumstances.  When the `<attr_commalist>`
has exactly zero `<*_attr>` elements, either a singleton type definer or a niladic
function or a type (implicitly its default value) may be invoked; for
exactly 1 `<*_attr>` element which is positional, either a monadic
function or a type (implicitly its membership predicate) may be invoked;
for other arguments, only a function of corrisponding arity may be invoked.
*TODO: Update this concerning type definers.*

## Fixed Function Invocation Expressions

Grammar:

    <fixed_func_invo_expr> ::=
        ...

    <infix_func_invo_expr> ::=
        ...

    <infix_func_name_or_op_same> ::=
        <special_infix_op_same> | <regular_infix_func_name>

    <special_infix_op_same> ::=
        '='

*TODO: Note, special_infix_op_same etc are subject to be renamed maybe.
Say that it is just syntactic sugar for a specific foundation func invo
but we special-case it because we don't want "=" to change based on what
packages are in scope, same as ":=" etc don't change.
UPDATE: ":=" is actually a regular procedure now, not special syntax, same as "=".
Note, this only affects '=' when called like an infix op syntactically;
calling it as `evaluates \"="::(x,y)` or `"="::(x,y)` gets the reg func if exists.*

*Generic allow multi-level or quoted identifiers,
fixed allows only single-level unquoted identifiers.*

*TODO.*

*TODO: FORGET NOT THE ps5_nonquoted_symbolic_grouping.*

# CONDITIONAL EXPRESSIONS

Grammar:

    <conditional_expr> ::=
          <if_else_expr>
        | <and_then_expr>
        | <or_else_expr>
        | <given_when_def_expr>
        | <guard_expr>

## If-Else Expressions

    if P then X else Y

*TODO.  Make 'if' keyword optional/noiseword, or not.*

## And-Then Expressions

This short-hand:

    P and_then X

Is semantically equivalent to:

    if P then X else False

It is functionally a generalized non-associative non-commutative logical
"and" suited in particular for situations where X needs to be guarded based
on P, but an explicit "guard" is still needed to actually have a guard.

## Or-Else Expressions

This short-hand:

    P or_else X

Is semantically equivalent to:

    if P then True else X

It is functionally a generalized non-associative non-commutative logical
"or" suited in particular for situations where X needs to be guarded based
on P, but an explicit "guard" is still needed to actually have a guard.

## Given-When-Default Expressions

*TODO.  Make 'given' keyword optional/noiseword, or not.*

## Guard Expressions

*TODO.  A guard forces short-circuiting in an expression where otherwise an
expression makes no guarantee as to whether anything is eager or lazy;
in contrast, a conditional statement is implicitly always short-circuiting.*

    if x != 0 then guard y/x else 42

    Numeric x and_then guard x multiple_of 2

    given #x when 0 then "empty" when 1 then guard only_member x default "too many"

*TODO.  Note that 'fail' is implicitly guarded.*

# GENERIC STATEMENTS

*TODO.*

# NESTING PRECEDENCE RULES

*TODO.  These are listed from tightest at the top to loosest at the bottom.*

    N - terms - base literals or delimited anything or special selector syntax,
        including inline func/type/etc decls, or foo::bar::etc or foo::(...) or \foo::(...)
        or `args` or `vars` tokens
    N - "literal" expression prefix
    L - special symbolic accessor post/infix :. :< :> :>. :& :&.
    L - symbolic in/pre/postfix (bareword) (postfix indicated with 'pipe' keyword)
    L - alpha in/pre/postfix (bareword) (postfix indicated with 'pipe' keyword)
    N - "evaluates" generic universal function call prefix
        or `new` or `current` pseudo-function call prefix
    R - conditional binaries or ternaries or n-aries or guards:
        and_then / or_else / if-then-else / given-when-default / guard
    R - expression annotating infix 'note'
    R - expression factor declaring infix ::=
    N - "returns" expression prefix
    N - every kind of procedure statement, including postcircumfix foo::()
        or symbolic/alpha pre/in/postfix (bareword) (postfix indicated with 'pipe' keyword)
        procedure calls, "performs" generic universal procedure call prefix,
        `declare` statement, conditional if-then-else / given-when-default,
        block with or without leading 'block' infix, `leave` and `iterate`
    R - statement annotating infix 'note'
    L - list separators ; , :

*TODO.  Loosely speaking, "L" means left-associative,
"R" means right-associative, "N" means non-associative.*

A `::=` is *what-binding* while a `note` is *why-binding*.

# SYNTACTIC MNEMONICS

The syntax of Muldis Data Language Plain Text, as well as the names of standard
library routines of Muldis Data Language, are designed around a variety of mnemonics
that bring it some self-similarity and an association between syntax and
semantics so that it is easier to read and write data and code in it.  Some
of these mnemonics are more about self-similarity and others are more about
shared traits with other languages.

The following table enumerates and explains the syntactic character
mnemonics that Muldis Data Language Plain Text itself has specific knowledge of
and ascribes specific meanings to; where multiple characters are shown
together that means they are used in pairs.

    Chars | Generic Meaning        | Specific Use Cases
    ------+------------------------+---------------------------------------
    ''    | stringy identifiers    | * delimit quoted code identifiers/names
    ------+------------------------+---------------------------------------
    ""    | stringy user data      | * delimit quoted opaque regular literals
          |                        | * delimit all Bits/Blob/Text literals
          |                        | * delimit quoted Integer/Fraction literals
    ------+------------------------+---------------------------------------
    ``    | stringy comments       | * delimit expendable dividing space comments
    ------+------------------------+---------------------------------------
    \     | special contexts       | * indicates special contexts where
          |                        |   typical meanings may not apply
          |                        | * first char inside a quoted string
          |                        |   to indicate it has escaped characters
          |                        | * prefix for each escaped char in quoted string
          |                        | * L0 of prefix for literals/selectors
          |                        |   to disambiguate that they are lits/sels
    ------+------------------------+---------------------------------------
    []    | ordered collections    | * delimit homogeneous ordered collections
          |                        |   of members, concept ordinal+asset pairs
          |                        | * delimit Array selectors
          |                        | * delimit nonempty-Tuple_Array selectors
          |                        | * delimit statement blocks
    ------+------------------------+---------------------------------------
    {}    | nonordered collections | * delimit homogeneous nonordered collections
          |                        |   of members, concept asset+cardinal pairs
          |                        | * delimit Set/Bag selectors
          |                        | * delimit nonempty-Relation/Tuple_Bag sels
    ------+------------------------+---------------------------------------
    ()    | aordered collections   | * delimit heterogeneous aordered collections
          |                        |   of attributes, concept nominal+asset pairs
          |                        | * delimit Tuple/Article/Excuse selectors
          |                        | * delimit Heading literals
          |                        | * delimit empty-Tuple_Array/Relation/Tuple_Bag lits
          |                        | * generic delimiting expressions
    ------+------------------------+---------------------------------------
    :     | pairings               | * indicates a pairing context
          |                        | * separates the 2 parts of a pair
          |                        | * indicates selection of a pair
          |                        | * optional pair separator in Array/Set/Bag sels
          |                        | * optional pair separator in Tuple/Excuse sels
          |                        | * optional pair separator in ne-TA/Rel/TB sels
          |                        | * label/attributes separator in Article sel
          |                        | * L1 of optional prefix for Article selectors
          |                        | * disambiguate Bag sel from Set sel
          |                        | * L2 of prefix for Renaming literals
          |                        | * syntax for binding a name to something
          |                        | * syntax for assigning a value to a variable
    ------+------------------------+---------------------------------------
    =     | associations           | * indicates that 2 things are associated
          |                        | * name of standard equality test function
          |                        | * syntax for binding a name to something
          |                        | * syntax for assigning a value to a variable
    ------+------------------------+---------------------------------------
    ,     | list builders          | * separates collection elements
          |                        | * separate members in Array/Set/Bag sels
          |                        | * separate members in nonempty-TA/Rel/TB sels
          |                        | * separate attributes in Tuple/Excuse sels
          |                        | * separate attributes in Heading lits
          |                        | * disambiguate unary named Tuple sels from Article sels
          |                        | * disambiguate unary anon Tuple selectors
          |                        |   from generic delimiting expressions
    ------+------------------------+---------------------------------------
    ;     | code block builders    | * separates code block elements, each
          |                        | * of which is an expression or statement
    ------+------------------------+---------------------------------------
    ?     | qualifications/is?/so  | * indicates a qualifying/yes-or-no context
          |                        | * L1 of optional prefix for Boolean literals
          |                        | * L2 of prefix for Bits literals
          |                        | * L1 of optional prefix for Set selectors
          |                        | * L1 of prefix for Relation lits/sels
          |                        | * predicate functions
          |                        | * existential tests / mapping to Boolean
          |                        | * non-Excuse values
    ------+------------------------+---------------------------------------
    +     | quantifications/count  | * indicates a quantifying/count context
          |                        | * L1 of optional prefix for Integer/Fraction literals
          |                        | * L2 of prefix for Blob literals
          |                        | * L1 of optional prefix for Bag selectors
          |                        | * L1 of prefix for Tuple_Bag lits/sels
          |                        | * numeric addition
          |                        | * collection element insertion
    ------+------------------------+---------------------------------------
    ~     | sequences/stitching    | * indicates a sequencing context
          |                        | * L1 of prefix for Bits/Blob literals
          |                        | * L1 of optional prefix for Text literals
          |                        | * L1 of optional prefix for Array selectors
          |                        | * L1 of prefix for Tuple_Array lits/sels
          |                        | * catenation of ordered collections
    ------+------------------------+---------------------------------------
    %     | tuples/heterogeneous   | * indicates that tuples are featured
          |                        | * L1 of optional prefix for Tuple selectors
          |                        | * L2 of prefix for Tuple_Array/Relation/Tuple_Bag lits/sels
          |                        | * in names of many tuple-related operators
    ------+------------------------+---------------------------------------
    !     | excuses/but/not        | * indicates that excuses are featured
          |                        | * prefix for Excuse literals/selectors
          |                        | * logical negation
          |                        | * in names of functions that may result
          |                        |   in Excuses rather than throw exceptions
    ------+------------------------+---------------------------------------
    $     | locators/at/headings   | * indicates identifiers/names are featured
          |                        | * L1 of prefix for Nesting/Heading literals
          |                        | * L1 of prefix for Renaming literals
          |                        | * in names of functions about relational headings
    ------+------------------------+---------------------------------------
    |     | homogeneous/bodies     | * indicates non-tuple-specific homogeneous collections
          |                        | * in names of functions about relational bodies
    ------+------------------------+---------------------------------------
    &     | variables/read+write   | * indicates a program variable is featured
          |                        | * syntax for reading current value of variable
          |                        | * syntax for updating variable to new current value
    ------+------------------------+---------------------------------------
    -     | subtraction            | * indicates negative-Integer/Fraction literal
          |                        | * numeric subtraction
          |                        | * collection element removal
    ------+------------------------+---------------------------------------
    /     | division               | * disambiguate Fraction lit from Integer lit
    ------+------------------------+---------------------------------------
    .     | radix point            | * disambiguate Fraction lit from Integer lit
          | accessor/at            | * in names of collection item accessor functions
    ------+------------------------+---------------------------------------
    digit | number                 | * first char 0..9 in bareword indicates is a number
    ------+------------------------+---------------------------------------
    alpha | identifier             | * first char a..z/etc in bareword indicates is identifier
    ------+------------------------+---------------------------------------
    0b    | base-2                 | * indicates base-2/binary notation
          |                        | * prefix for Integer/Fraction/Bits/Blob in base-2
    ------+------------------------+---------------------------------------
    0o    | base-8                 | * indicates base-8/octal notation
          |                        | * prefix for Integer/Fraction/Bits in base-8
    ------+------------------------+---------------------------------------
    0d    | base-10                | * indicates base-10/decimal notation
          |                        | * optional prefix for Integer/Fraction in base-10
    ------+------------------------+---------------------------------------
    0x    | base-16                | * indicates base-16/hexadecimal notation
          |                        | * prefix for Integer/Fraction/Bits/Blob in base-16
    ------+------------------------+---------------------------------------

    When combining symbols in a \XY prefix (L0+L1+L2) to represent both
    collection type and element type, the X and Y always indicate the
    collection and element type respectively; the mnemonic is "X of Y", for
    example, \?% says "set of tuple", or \~? says "string of boolean".

# STRATEGIES FOR PARSING

Muldis Data Language Plain Text is designed to be easy to parse, where one can use a
multi-stage pipeline with simple rules at each step, and typically the work
of parsing can be done in a highly parallel fashion, where each part of the
code can be parsed properly with very little or no knowledge of what came
before or after it.

In particular, earlier stages of the pipeline can complete successfully
even in the face of syntax errors, as the latter would be caught in a later
pipeline stage where more meaningful error messages can be given.

For the purposes of this documentation section, we will assume that the
source code has already been processed from any binary or other formats
into a single character string token having a well-known
character repertoire that is compatible with Unicode.  This may have
involved scanning ahead for a `<language_name>` or in particular a
`<script_name>` directive should that have been needed to resolve ambiguity.

Note that it is assumed that all parsing stages following the above
assumption are completely lossless, and that any stages which conceptually
would lose information actually maintain all of it in (generally)
`Plain_Text`-specific metadata so the original source string could be
reassembled from the parse form in all its details, including for example
the exact character escape sequences and whitespace used.  Also maintained
as useful for debugging is knowledge of what line numbers and character
positions within a line each token ranged over in the original source.

Note that it is assumed that every token indicated as being a *character
string* would in likely practice be some other type whose payload is the
character string and it is tagged to say how the string was interpreted,
so that tokens can more easily be further processed in isolation, the work
to consider their wider context having already been done.

## Pipeline Stage 1

Stage 1 in the parsing pipeline is to split off any leading `<shebang_line>`
that might prefix the code.  The primary output of stage 1 is a single
character string token with the code itself, and any leading shebang is
metadata.  Further stages below only consider this primary as their input.

Grammar:

    <ps1> ::=
        ^ <shebang_line>? <ps2> $

## Pipeline Stage 2

Broadly speaking, Muldis Data Language Plain Text code is made up of 2 primary
grammatical contexts which are mutually disjoint and complementary; one of
these is anywhere outside all quoted strings, and its complement is
anywhere inside any quoted string; quoted strings don't overlap or nest, or
if they appear to, any inner ones are just regular string contents.

Stage 2 in the parsing pipeline is to split the single input
character string token on all transition points between those grammatical
contexts.  The output of stage 2 is an array of character string tokens
such that catenating them in order gives the input token.  Each output
token is either one of the delimiters by itself, or is the characters
between a delimiter pair, or is the characters between 2 delimited strings.
Alternately, the output of stage 2 is an array of parse nodes where each
node either represents a nonquoted context or a quoted context, the latter
bundling up what its delimiters were.

Note that any possible quoting character nesting is in a strict hierarchy.
That is, backtick-quoted strings may contain literal single/double-quote
characters, but single/double-quoted strings both may not have literal
quote characters of any kind.  Therefore, it should be trivially easy to
implement Stage 2 in a fully parallel fashion, at least if divided into 2
similar sub-stages of parsing out backtick-quoted strings first and then
single/double-quoted strings second; in either case, it is guaranteed that
each pair of consecutive delimiters in well-formed source code is a whole
quoted context and no serial examination of found delimiters is necessary.

*TODO: Change to a strict 3-level hierarchy which ranks double-quoted
strings above single-quoted strings and allows literal single-quotes inside
double-quoted strings. This is part of the Plain_Text syntax becoming a
proper superset of the Muldis Object Notation syntax.*

Grammar:

    <ps2> ::=
        <ps2_non_backtick_quoted> % <ps2_backtick_quoted>

    <ps2_non_backtick_quoted> ::=
        <ps2_nonquoted> % <ps2_double_or_single_quoted>

    <ps2_nonquoted> ::=
        <-quoting_char>*

    <ps2_double_or_single_quoted> ::=
        <ps2_double_quoted> | <ps2_single_quoted>

    <ps2_double_quoted> ::=
        '"' <-quoting_char>* '"'

    <ps2_single_quoted> ::=
        '\'' <-quoting_char>* '\''

    <ps2_backtick_quoted> ::=
        '`' <-[`]>* '`'

### Pipeline Stage 3

Stage 3 in the parsing pipeline is to take any tokens from stage 2
representing a nonquoted context, and for each one, split it into tokens by
character class, that is just on the transition between any 2 characters
not of the same one of the 5 character groups shown.  The output of stage 3
is an array of character string tokens such that each output token is
either the same as an input token or is a non-overlapping substring of one.
Alternately, each parse node from stage 2 representing a nonquoted context
has been replaced by an array of 1..N parse nodes, one per new substring.

Grammar:

    <ps3_nonquoted> ::=
          <alphanumeric_char>
        | <bracketing_char>
        | <symbolic_char>
        | <whitespace_char>

### Pipeline Stage 4

Stage 4 in the parsing pipeline is to split any nonquoted context tokens
consisting of multiple `<bracketing_char>` into multiple tokens such that
each such individual character becomes its own token.  The output of stage
4 is an array of character string tokens, or parse nodes, as per stage 3.

### Pipeline Stage 5

Stage 5 in the parsing pipeline is to split any nonquoted context tokens
consisting of multiple `<symbolic_char>` into multiple tokens where those
tokens contain characters well-known to `Plain_Text` for special uses such
as meta-operator characters.  The output of stage 5 is an array of
character string tokens, or parse nodes, as per stage 3.

Grammar:

    <ps5_nonquoted_symbolic_grouping> ::=
          ','
        | '::='
        | '::'
        | ':'
        | ';'
        | '\\'

Where any of the shown symbolic character sequences exist, each sequence
becomes its own token, and any runs of symbolics besides those each become
their own token also.  When looking for sequences, evaluation is
left-to-right and the longest match wins between multiple matches.

Generally speaking, the parsing of nonquoted context symbolic character
runs is complete following stage 5, and each remaining token is not likely
to be split again or be merged with other tokens.

### Pipeline Stage 6

Stages 6 and later in the parsing pipeline focus more on combining adjacent
tokens or parse nodes of known kinds into subtrees of other node types,
that progressively add more semantic meaning to the parse tree, and the
syntax becomes metadata rather than something needed to execute the code.

Stage 6 in the parsing pipeline is to collect any runs of consecutive
tokens or parse nodes, where each represents either a backtick-quoted
string or nonquoted `<whitespace>`, beneath a parse node
representing the run; this new node is logically treated as insignificant
(other than for its role in separating otherwise adjacent things)
dividing space, and becomes non-semantic metadata for its wider context.

### Pipeline Stage 7

Stage 7 in the parsing pipeline is to collect any runs of consecutive
(apart from any invervening dividing space) quoted context tokens or parse
nodes of the same kind, specifically those delimited by either
single-quotes or double-quotes, beneath a parse node representing the run.
Such runs are logically a single contiguous quoted string (except possibly
for matters of escape sequences) but were split for readability.

### Pipeline Stage 8

Stage 8 in the parsing pipeline is to take any tokens from stage 2
representing a single-quoted or double-quoted context, and for each one, if
it contains any character escape sequences, to replace those escape
sequences with the actual characters they represent.  Any `"..."` or
`'...'` represent character data, either `Text`
literals or quoted identifiers, and the valid formats for both
within the quoted contexts are identical.  Note that for a run, each
individual quoted context is treated in isolation, as some may be formatted
for escape sequences and some may not.  Also using single-quoted contexts
for some or all of their literals are the `Bits` (`\~?"..."`) or `Blob` (`\~+"..."`) or
`Integer` or `Fraction` (`\+"..."` for both) and they have
their own interpretation formats different from those of character strings.

Grammar:

    <ps8_quoted_sans_delimiters> ::=
        <ps8_chars_nonescaped> | <ps8_chars_escaped>

    <ps8_chars_nonescaped> ::=
        [<-[\\]> .*]?

    <ps8_chars_escaped> ::=
        '\\' [<-[\\]> | <escaped_char>]*

Note that the definition of `<escaped_char>` includes an escape sequence
each for a single-quote and a double-quote.

### Pipeline Stage 9

Stage 9 in the parsing pipeline is to isolate any literals specific to
certain numeric types, which are a particular run of
`<alphanumeric_char>` optionally with some `<symbolic_char>`,
and further optionally split (when long) using dividing space.

Grammar:

    <ps9_numeric> ::=
        <ps9_nonquoted_numeric> | <ps9_quoted_numeric>

    <ps9_nonquoted_numeric> ::=
        <num_sign>? <digit_char> <alphanumeric_char>*
            [<frac_div> <alphanumeric_char>]?

    <ps9_quoted_numeric> ::=
        '\\+' <sp> <ps2_single_quoted> % <sp>

Note that the above actually allows invalid numeric literals, however
anything matching the above pattern will be a syntax error if it doesn't
otherwise match a stricter numeric definition.

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification of the **Muldis Data Language Plain Text**
(**MDPT**) primary component of the **Muldis Data Language** language specification.

MDPT is Copyright © 2002-2018, Muldis Data Systems, Inc.

<https://muldis.com>

MDPT is free documentation for software;
you can redistribute it and/or modify it under the terms of the Apache
License, Version 2.0 (AL2) as published by the Apache Software Foundation
(<https://apache.org>).  You should have received a copy of the
AL2 as part of the MDPT distribution, in the file
[LICENSE/Apache-2.0.txt](../LICENSE/Apache-2.0.txt); if not, see
<https://apache.org/licenses/LICENSE-2.0>.

Any versions of MDPT that you modify and distribute must carry prominent
notices stating that you changed the files and the date of any changes, in
addition to preserving this original copyright notice and other credits.

While it is by no means required, the copyright holder of MDPT
would appreciate being informed any time you create a modified version of
MDPT that you are willing to distribute, because that is a
practical way of suggesting improvements to the standard version.
