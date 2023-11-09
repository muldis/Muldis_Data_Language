# NAME

Muldis Data Language Dialect HDMD_Raku_STD - How to format Raku Hosted Data Muldis Data Language

# VERSION

This document is Muldis Data Language Dialect HDMD_Raku_STD version 0.148.1.

# PREFACE

This document is part of the Muldis Data Language language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document
before you read this one, which provides subservient details.

# DESCRIPTION

This document outlines the grammar of the *Hosted Data Muldis Data Language* standard
dialect named `HDMD_Raku_STD`.  The fully-qualified name of this Muldis Data Language
standard dialect is `[ 'Muldis_Data_Language', 'https://muldis.com', '0.148.1',
'HDMD_Raku_STD' ]`.

The `HDMD_Raku_STD` dialect is defined to be hosted in Raku, and is
composed of just|mainly core Raku types.  This dialect is optimized for
Raku specifically, and doesn't try to match the version for Perl; you
*will* have to reformat any Perl Hosted Data Muldis Data Language when migrating
between Perl and Raku, same as with your ordinary Perl code.

This dialect is designed to exactly match the structure of a possible
concrete syntax tree, comprised of native Raku scalar and collection
typed values, resulting from parsing code written in the Muldis Data Language dialect
[PTMD_STD](Muldis_Data_Language_Dialect_PTMD_STD.md) using Raku.  This dialect
exists as a convenience to Raku programmers that want to generate or
introspect Muldis Data Language code by saving them the difficulty and overhead of
escaping and stitching plain text code; it is expected that a Muldis Data Language
implementation written in Raku will natively accept input in both the
`PTMD_STD` and `HDMD_Raku_STD` dialects.  Furthermore, the
`HDMD_Raku_STD` dialect provides additional Muldis Data Language syntax options to
Raku programmers besides what `PTMD_STD` would canonically parse into,
such as the direct use of some Raku-only features.

**Note that most of the details that the 2 dialects have in common are
described just in the `PTMD_STD` file, for both dialects; this current
file will mainly focus on the differences; you should read the
[Dialect_PTMD_STD](Muldis_Data_Language_Dialect_PTMD_STD.md) file before the current one, so to provide
a context for better understanding it.**

# GENERAL STRUCTURE

A `HDMD_Raku_STD` Muldis Data Language code file is actually a Raku code file that
defines particular multi-dimensional Raku data structures which resemble
possible concrete syntax trees (CSTs) from parsing `PTMD_STD` Muldis Data Language
code.  Each component of a CST is called a *node* or node element, and
roughly corresponds to a capture by the `PTMD_STD` parser.  A node is
typically represened as a Raku Seq|Array, but could alternately be a Raku
scalar or something else, and so `HDMD_Raku_STD` Muldis Data Language code is
typically a tree of Raku structures, called *node trees*, with Raku
Seq|Array as the central nodes and Raku scalars as the leaf nodes.  Often
`HDMD_Raku_STD` code is embedded or constructed in one or more files of
a larger Raku program that does more than define this code, such as
various non-database-related tasks.  A node tree is just composed using
basic Raku data types, and there are no Muldis Data Language node-specific Raku classes
or objects required for doing this.

Note that Raku undefined values are not allowed anywhere in a node in the
general case; you must use only defined values instead.  This documentation
also assumes that only defined values are used, and that supplying a Raku
undef will result in an error.  The few exceptions to this rule are
explicitly stated.

The grammar in this file is informal and consists just of written
descriptions of how each kind of *node* must be composed and how to
interpret such Raku data structures as Muldis Data Language code.  Every named grammar
node is a Raku Seq|Array unless otherwise stated, and every grammar element
is a Seq|Array element; the first node element is the Seq|Array element at
index zero, and so on.

The root grammar node for the entire dialect is `Muldis_Data_Language`.

# START

A `Muldis_Data_Language` node has 2 ordered elements where the first element is a
`language_name` node and the second element is either a `value` node or a
`depot` node.

See the pod sections in this file named **LANGUAGE NAME**, **VALUE
LITERALS AND SELECTORS**, and **DEPOT SPECIFICATION**, for more details
about the aforementioned tokens/nodes.

When Muldis Data Language is being compiled and invoked piecemeal, such as because the
Muldis Data Language implementing virtual machine (VM) is attached to an interactive
user terminal, or the VM is embedded in a host language where code in the
host language invokes Muldis Data Language code at various times, many `value` may be
fed to the VM directly for inter-language exchange, and not every one
would then have its own `language_name`.  Usually a `language_name` would
be supplied to the Muldis Data Language VM just once as a VM configuration step, which
provides a context for further interaction with the VM that just involves
Muldis Data Language code that isn't itself qualified with a `language_name`.

# LANGUAGE NAME

As per the VERSIONING pod section of [Muldis_Data_Language](Muldis_Data_Language.md), code written in Muldis Data Language
must start by declaring the fully-qualified Muldis Data Language language name it is
written in.  The `HDMD_Raku_STD` dialect formats this name as a
`language_name` node having 5 ordered elements:

* `ln_base_name`

This is the Muldis Data Language language base name; it is simply the Raku `Str` value
`Muldis_Data_Language`.

* `ln_base_authority`

This is the base authority; it is a Raku `Str` formatted as per a
specific-context `Name` value literal, except that must be nonempty and it
is expressly limited to using non-control characters in the ASCII
repertoire; it is typically the Raku `Str` value `https://muldis.com`.

* `ln_base_version_number`

This is the base version number; it is a Raku `Str` formatted as per
`ln_base_authority`; it is typically a Raku `Str` value like `0.148.1`.

* `ln_dialect`

This is the dialect name; it is simply the Raku `Str` value
`HDMD_Raku_STD`.

* `ln_extensions`

This is a set of chosen pragma/parser-config options, which is formatted
similarly to a `Tuple` SCVL.  The only 2 mandatory pragmas are
`catalog_abstraction_level` (see the **CATALOG ABSTRACTION LEVELS** pod
section) and `op_char_repertoire` (see **OPERATOR CHARACTER REPERTOIRE**).
The only optional pragma is `standard_syntax_extensions` (see the
**STANDARD SYNTAX EXTENSIONS** pod section).  Other pragmas may be added
later, which would likely be optional.

The value associated with the `ln_extensions` attribute named
`catalog_abstraction_level` must be one of these 4 Raku `Str` values:
`the_floor`, `code_as_data`, `plain_rtn_inv`, `rtn_inv_alt_syn`.

The value associated with the `ln_extensions` attribute named
`op_char_repertoire` must be one of these 2 Raku character strings:
`basic`, `extended`.

The value associated with the `ln_extensions` attribute named
`standard_syntax_extensions` must be formatted similarly to a `Set` SCVL;
each of the value's elements must be one of these 0 Raku `Str` values.

Examples:

    [ 'Muldis_Data_Language', 'https://muldis.com', '0.148.1', 'HDMD_Raku_STD', {
        catalog_abstraction_level => 'rtn_inv_alt_syn',
        op_char_repertoire => 'extended'
    } ]

    [ 'Muldis_Data_Language', 'https://muldis.com', '0.148.1', 'HDMD_Raku_STD', {
        catalog_abstraction_level => 'rtn_inv_alt_syn',
        op_char_repertoire => 'extended',
        standard_syntax_extensions => Set.new()
    } ]

# CATALOG ABSTRACTION LEVELS

The `catalog_abstraction_level` pragma determines with a broad granularity
how large the effective Muldis Data Language grammar is that a programmer may employ
with their Muldis Data Language code.

The catalog abstraction level of some Muldis Data Language code is a measure of how
much or how little that code would resemble the system catalog data that
the code would parse into.  The lower the abstraction level, the smaller
and simpler the used Muldis Data Language grammar is and the more like data structure
literals it is; the higher the abstraction level, the larger and more
complicated the Muldis Data Language grammar is and the more like
general-purpose-language typical code it is.

There are currently 4 specified catalog abstraction levels, which when
arranged from lowest to highest amount of abstraction, are: `the_floor`,
`code_as_data`, `plain_rtn_inv`, `rtn_inv_alt_syn`.  Every abstraction
level has a proper superset of the grammar of every other abstraction level
that is lower than itself, so for example any code that is valid
`code_as_data` is also valid `plain_rtn_inv`, and so on.

## the_floor

This abstraction level exists more as an academic exercise and is not
intended to actually be used.

Examples:

    [
        [ 'Muldis_Data_Language', 'https://muldis.com', '0.148.1', 'HDMD_Raku_STD', {
            catalog_abstraction_level => 'the_floor',
            op_char_repertoire => 'basic'
        } ],
        :List[3,
           :List[
              :List[1,:List[102,111,111,100]],
              :List[1,:List[113,116,121]],
           ],
           :List[
              :List[
                 :List[4,
                    :List[
                       :List[1,:List[115,121,115]],
                       :List[1,:List[115,116,100]],
                       :List[1,:List[67,111,114,101]],
                       :List[1,:List[84,121,112,101]],
                       :List[1,:List[84,101,120,116]],
                    ],
                    :List[1,:List[110,102,100,95,99,111,100,101,115]],
                    :List[2,
                       :List[:List[1,:List[]]],
                       :List[:List[1,:List[67,97,114,114,111,116,115]]]
                    ]
                 ],
                 100
              ],
              :List[
                 :List[4,
                    :List[
                       :List[1,:List[115,121,115]],
                       :List[1,:List[115,116,100]],
                       :List[1,:List[67,111,114,101]],
                       :List[1,:List[84,121,112,101]],
                       :List[1,:List[84,101,120,116]],
                    ],
                    :List[1,:List[110,102,100,95,99,111,100,101,115]],
                    :List[2,
                       :List[:List[1,:List[]]],
                       :List[:List[1,:List[75,105,119,105,115]]]
                    ]
                 ],
                 30
              ]
           ]
        ]
    ]

## code_as_data

This abstraction level is the best one for when you want to write code in
exactly the same form as it would take in the system catalog.

Code written to the `code_as_data` level can employ all of the language
grammar constructs described in these main pod sections: **VALUE LITERALS
AND SELECTORS**, **OPAQUE VALUE LITERALS**, **COLLECTION VALUE SELECTORS**.

Examples:

    [
        [ 'Muldis_Data_Language', 'https://muldis.com', '0.148.1', 'HDMD_Raku_STD', {
            catalog_abstraction_level => 'code_as_data',
            op_char_repertoire => 'basic'
        } ],
        '@' => Set.new(
            { food => 'Carrots', qty => 100 },
            { food => 'Kiwis', qty => 30 }
        )
    ]

    [
       [ 'Muldis_Data_Language', 'https://muldis.com', '0.148.1', 'HDMD_Raku_STD', {
          catalog_abstraction_level => 'code_as_data',
          op_char_repertoire => 'basic'
       } ],
       [ 'depot', :depot-catalog[ 'Database', 'Depot', {
          functions => '@' => Set.new(
             {
                name => :Name<cube>,
                material => [ '%', 'Function', {
                   result_type => :PNSQNameChain<Int>,
                   params => [ '@', 'NameTypeMap', Set.new(
                      { name => :Name<topic>, type => :PNSQNameChain<Int> }
                   ) ],
                   expr => [ 'Database', 'ExprNodeSet', {
                      sca_val_exprs => '@' => Set.new(
                         { name => :Name<INT_3>, value => 3 }
                      ),
                      func_invo_exprs => '@' => Set.new(
                         {
                            name => :Name(''),
                            function => :PNSQNameChain<Integer.power>,
                            args => [ '@', 'NameExprMap', [
                               {name=>:Name<radix>, expr=>:Name<topic>},
                               {name=>:Name<exponent>, expr=>:Name<INT_3>}
                            ] ]
                         }
                      )
                   } ]
                } ]
             }
          )
       } ] ]
    ]

## plain_rtn_inv

This abstraction level is the lowest one that can be recommended for
general use.

Code written to the `plain_rtn_inv` level can employ all of the language
grammar constructs that `code_as_data` can, plus all of those
described in these main pod sections: **MATERIAL SPECIFICATION**,
**GENERIC VALUE EXPRESSIONS**, **GENERIC PROCEDURE STATEMENTS**.

Examples:

    [
        [ 'Muldis_Data_Language', 'https://muldis.com', '0.148.1', 'HDMD_Raku_STD', {
            catalog_abstraction_level => 'plain_rtn_inv',
            op_char_repertoire => 'basic'
        } ],
        [ 'depot', :depot-catalog[
            [ 'function', 'cube', [ 'Int', { topic => 'Int' } ] => [
                [ 'func-invo', 'Integer.power',
                    { radix => :d<topic>, exponent => 3 } ]
            ] ]
        ] ]
    ]

## DEPRECATED - rtn_inv_alt_syn

**The `rtn_inv_alt_syn` catalog abstraction level as it currently exists
is deprecated and will disappear in the near future.  Other pending
enhancements to the language in both the system catalog itself and in the
`plain_rtn_inv` level will make the latter more capable and suitable by
itself for normal use.  A new highest level or 3 will probably appear in
place of `rtn_inv_alt_syn` later for their still-unique useful features.**

This abstraction level is the highest one and is the most recommended one
for general use.

Code written to the `rtn_inv_alt_syn` level can employ all of the language
grammar constructs that `plain_rtn_inv` can, plus all of those described
in these main pod sections: **DEPRECATED - FUNCTION INVOCATION ALTERNATE SYNTAX
EXPRESSIONS**, **DEPRECATED - PROCEDURE INVOCATION ALTERNATE SYNTAX STATEMENTS**.

Examples:

    [
        [ 'Muldis_Data_Language', 'https://muldis.com', '0.148.1', 'HDMD_Raku_STD', {
            catalog_abstraction_level => 'rtn_inv_alt_syn',
            op_char_repertoire => 'basic'
        } ],
        [ 'depot', :depot-catalog[
            [ 'function', 'cube', [ 'Int', { topic => 'Int' } ] => [
                [ 'i-op', 'exp', [ :d<topic>, 3 ] ]
            ] ]
        ] ]
    ]

# OPERATOR CHARACTER REPERTOIRE

The `op_char_repertoire` pragma determines primarily whether or not the
various routine invocation alternate syntaxes, herein called *operators*,
may be composed of only ASCII characters or also other Unicode characters,
and this pragma determines secondarily whether or not a few special value
literals (effectively nullary operators) composed of non-ASCII Unicode
characters may exist.

There are currently 2 specified operator character repertoires: `basic`,
`extended`.  The latter is a proper superset of the former.

Specifying the `op_char_repertoire` pragma in a `language_name` node is
mandatory, since there is no obviously best setting to use implicitly when
one isn't specified.

## basic

The `basic` operator character repertoire is the smallest one, and it only
supports writing the proper subset of defined operator invocations and
special value literals that are composed of just 7-bit ASCII characters.
This repertoire can be recommended for general use, especially since code
written to it should be the most universally portable as-is (with respect
to operator character repertoires), including full support even by minimal
Muldis Data Language implementations and older text editors.

## extended

The `extended` operator character repertoire is the largest one, and it
supports the entire set of defined operator invocations and special value
literals, many of which are composed of Unicode characters outside the
7-bit ASCII repertoire.  This is the most recommended repertoire for
general use, assuming that all the Muldis Data Language implementations and source code
text editors you want to use support it.

# STANDARD SYNTAX EXTENSIONS

The `standard_syntax_extensions` pragma declares which optional portions
of the Muldis Data Language grammar a programmer may employ with their Muldis Data Language code.

There are currently no specified standard syntax extensions.
These are all mutually independent and any or all may be used at once.

While each *standard syntax extension* is closely related to a *Muldis Data Language
language extension*, you can use the latter's types and routines without
declaring the former; you only declare you are using a *standard syntax
extension* if you want the Muldis Data Language parser to recognize special syntax
specific to those types and routines, and otherwise you just use them using
the generic syntax provided for all types and routines.

The `standard_syntax_extensions` pragma is generally orthogonal to the
`catalog_abstraction_level` pragma, so you can combine any value of the
latter with any value-list of the former.  However, in practice all
standard syntax extensions will have no effect when the catalog abstraction
level is `the_floor`, and some of their features may only take effect when
the catalog abstraction level is `rtn_inv_alt_syn`, as is appropriate.

Specifying the `standard_syntax_extensions` pragma in a `language_name`
node is optional, and when omitted it defaults to the empty set, meaning no
extensions may be used.

# VALUE LITERALS AND SELECTORS

A `value` node is a Muldis Data Language value literal, which is a common special case
of a Muldis Data Language value selector.

There are 23 main varieties of `value` node, each of which is a named node
kind of its own:  `Singleton`, `Bool`, `Order`, `RoundMeth`, `Int`,
`Rat`, `Blob`, `Text`, `Name`, `NameChain`, `PNSQNameChain`,
`RatRoundRule`, `Scalar`, `Tuple`, `Database`, `Relation`,
`Set`, `Maybe`, `Array`, `Bag`, `[S|M]PInterval`, `List`.

Fundamentally, the various Muldis Data Language scalar and collection types are
represented by their equivalent Raku native scalar and collection types.
But since Muldis Data Language is more strongly typed, or at least differently typed,
than Raku, each `value` node is represented by a Raku Seq|Array, whose
elements include both the payload Raku literal plus explicit metadata for
how to interpret that Raku literal for mapping to Muldis Data Language.

## Value Literal Common Elements

Every `value` node is either a GCVL (generic context value literal) or a
SCVL (specific context value literal).

Every GCVL has 1-3 ordered elements:

* `value_kind`

This is a Raku `Str` value of the format
`<[A..Z]> <[ a..z A..Z ]>+ | '$'|'%'|'@'`;
it identifies the data type of the value literal in broad terms and is the
only external metadata of `value_payload` generally necessary to
interpret the latter; what grammars are valid for `value_payload` depend
just on `value_kind`.

Between the various kinds of `value` node, these 42 values are allowed for
`value_kind`:  `Singleton`, `Bool`, `Order`, `RoundMeth`,
`[|NN|P]Int`, `[|NN|P]Rat`, `[|Octet]Blob`, `Text`, `Name`,
`[|PNSQ]NameChain`, `RatRoundRule`, `[|DH]Scalar|$`,
`[|DH]Tuple|%`, `Database`, `[|DH]Relation|@`, `[|DH]Set`,
`[|DH][Maybe|Just]`, `[|DH]Array`, `[|DH]Bag`, `[|DH][S|M]PInterval`,
`List`.

For just some data types, the `value_kind` may be omitted; see below.

* `type_name`

Only when the `value` node has 3 elements:  This is a Muldis Data Language data type
name, for example `sys.std.Core.Type.Int`; it identifies a specific
subtype of the generic type denoted by `value_kind`, and serves as an
assertion that the Muldis Data Language value denoted by `value_payload` is a member
of the named subtype.  Its format is a `PNSQNameChain_payload` node.  Iff
`value_kind` is `[|DH]Scalar` then `type_name` is mandatory; otherwise,
`type_name` is optional for all `value`, except that `type_name` must be
omitted when `value_kind` is one of the 3 [`Singleton`, `Bool`,
`Order`]; this isn't because those 3 types can't be subtyped, but because
in practice doing so isn't useful.

* `value_payload`

This is mandatory for all `value`.  Format varies with `value_kind`.

A Raku Pair may alternately be used to represent a GCVL iff that node has
exactly 2 elements (`value_kind` and `value_payload`); in that case, the
`value_kind` is stored in that Pair's key, and the `value_payload` is
stored in the Pair's value.

For some data types, a GCVL may alternately be just its payload for the
sake of brevity.  If any Raku value of one of the following types is
encountered where a GCVL node is expected, then it is interpreted as a full
`value` node as follows:

    Muldis Data Language   <- Raku
    ----------------------------
    -Inf       <- -Inf
    Inf        <- Inf|+Inf
    Bool       <- Bool
    Order      <- Order
    Int        <- Int
    Rat        <- FatRat|Rat|Num
    Blob       <- Blob
    Text       <- Str
    SPInterval <- Range
    TAIInstant <- Instant  # TODO: UPDATE THIS! #
    TAIDuration <- Duration  # TODO: UPDATE THIS! #

The above details are subject to revision regarding when a Raku object
might claim to do multiple type interfaces.

For GCVL and SCVL examples, see the subsequent documentation sections.

# OPAQUE VALUE LITERALS

## Singleton Literals

A `Singleton` node represents a value of any of the singleton scalar types
that `sys.std.Core.Type.Cat.Singleton` is a union over.  The payload must
be one of these 2 special named Raku values: `-Inf`, `Inf|+Inf`.

Examples:

    :Singleton(-Inf)

    Inf

## Boolean Literals

A `Bool` node represents a logical boolean value.  It is interpreted as a
Muldis Data Language `sys.std.Core.Type.Bool` value as follows:  The payload must be a
Raku `Bool`, and so `Bool::False` and `Bool::True` are mapped directly.

Examples:

    :Bool(Bool::True)

    Bool::False

## Order-Determination Literals

An `Order` node represents an order-determination.  It is interpreted as a
Muldis Data Language `sys.std.Core.Type.Cat.Order` value as follows:  The payload must
be a Raku `Order`, and so `Order::Less` and `Order::Same` and
`Order::More` are mapped directly.

Examples:

    :Order(Order::Same)

    Order::More

## Rounding Method Literals

A `RoundMeth` node represents a rounding method.  It is
interpreted as a Muldis Data Language `sys.std.Core.Type.Cat.RoundMeth` value by
directly mapping the payload.  The payload must be a Raku `Str`
having one of the 9 values `Down`, `Up`, `ToZero`, `ToInf`,
`HalfDown`, `HalfUp`, `HalfToZero`, `HalfToInf`, `HalfEven`.

Examples:

    :RoundMeth<HalfUp>

    :RoundMeth<ToZero>

## General Purpose Integer Numeric Literals

An `Int` node represents an integer numeric value.  It is interpreted as a
Muldis Data Language `sys.std.Core.Type.Int` value as follows:  The payload must be a
Raku `Int`, which is mapped directly.

Examples:

    :Int(0b11001001) # binary #

    0o0 # octal #

    0o644 # octal #

    -34 # decimal #

    42 # decimal #

    0xDEADBEEF # hexadecimal #

    :36<-HELLOWORLD> # base-36 #

    :4<301> # base-4 #

    :12<A09B> # base-12 #

## General Purpose Rational Numeric Literals

A `Rat` node represents a rational numeric value.  It is interpreted as a
Muldis Data Language `sys.std.Core.Type.Rat` value as follows:  The payload must
be a Raku `FatRat|Rat|Num|Int`, which is mapped directly.

Examples:

    :Rat(-0b1.1)

    -1.5 # same val as prev #

    3.14159

    :11<0.0>

    0xDEADBEEF.FACE

    :36<0.000AZE>

    :Rat(:7<500001>/:7<1000>)

    :12<A09B>/:12<A>

    :Rat(0b1011101101 * 0b10 ** -0b11011)

    45207196 * 10 ** 37

    1/43

    314159 * 10 ** -5

## General Purpose Binary String Literals

A `Blob` node represents a general purpose bit string.  It is interpreted
as a Muldis Data Language `sys.std.Core.Type.Blob` value as follows:  The payload must
be a Raku `Blob`, which is mapped directly.

Examples:

    :Blob(:2{00101110100010}) # binary #

    :4{}

    :16{A705E} # hexadecimal #

    :8{523504376}

## General Purpose Character String Literals

A `Text` node represents a general purpose character string.  It is
interpreted as a Muldis Data Language `sys.std.Core.Type.Text` value by directly
mapping the payload.  The payload must be a Raku `Str`.

Examples:

    :Text<Ceres>

    'サンプル'

    ''

    'Perl'

    "\c[LATIN SMALL LETTER OU]\x[263A]\c[65]"

## DBMS Entity Name Literals

A `Name` node represents a canonical short name for any kind of DBMS
entity when declaring it; it is a character string type, that is disjoint
from `Text`.  It is interpreted as a Muldis Data Language
`sys.std.Core.Type.Cat.Name` value by directly mapping the payload.  The
payload must be a Raku `Str`.

A `NameChain` node represents a canonical long name for invoking a DBMS
entity in some contexts; it is conceptually a sequence of entity short
names.  Its payload is a Raku `Seq|Array` value or `Str` value.  This
node is interpreted as a Muldis Data Language `sys.std.Core.Type.Cat.NameChain` value
as follows:

* If the payload is a `Seq|Array`, then
every element must be a valid payload for a `Name` node (that
is, any Raku character string).  Each element of the payload, in order,
defines an element of the `array` possrep's attribute of a `NameChain`.

* If the payload is a `Str`, then it must be formatted as a catenation
(using period (`.`) separators) of at least 1 part, where each part can
not have any literal period (`.`) characters (if you want literal periods
then you can only use the `Seq|Array` payload format to express it).  The
`Str` format of payload is interpreted by splitting it on the separators
into the `Seq|Array` format, then processed as per the latter.  A zero
part chain can only be expressed with the `Seq|Array` payload format; an
empty string `Str` format will be interpreted as having a single element
that is the empty string.

Fundamentally a `PNSQNameChain` node is exactly the same as a `NameChain`
node in format and interpretation, with the primary difference being that
it may only define `NameChain` values that are also values of the proper
subtype `sys.std.Core.Type.Cat.PNSQNameChain`, all of which are nonempty
chains.  Now that distinction alone wouldn't be enough rationale to have
these 2 distinct node kinds, and so the secondary difference between the 2
provides that rationale; the `PNSQNameChain` node supports a number of
chain value shorthands while the `NameChain` node supports none.

A `PNSQNameChain` node is interpreted the same as a `NameChain` node
except for the extra restrictions and shorthands.

Examples:

    :Name<login_pass>

    :Name('First Name')

    :NameChain['gene','sorted_person_name']

    :NameChain('stats.samples by order')

    :NameChain[]

    :PNSQNameChain['fed','data','the_db','gene','sorted_person_names']

    :PNSQNameChain('fed.data.the_db.stats.samples by order')

## Rational Rounding Rule Literals

A `RatRoundRule` node represents a rational rounding rule.  It is
interpreted as a Muldis Data Language `sys.std.Core.Type.Cat.RatRoundRule` value whose
attributes are defined by the `RatRoundRule_payload`.  A
`RatRoundRule_payload` must be a Raku `Seq|Array` with 3 elements, which
correspond in order to the 3 attributes: `radix` (a `PInt2_N`),
`min_exp` (an `Int`), and `round_meth` (a `RoundMeth`).  Each of
`radix` and `min_exp` must qualify as a valid `Int_payload`, and
`round_meth` must qualify as a valid `RoundMeth_payload`.

Examples:

    :RatRoundRule[10,-2,'HalfEven']

    :RatRoundRule[2,-7,'ToZero']

# COLLECTION VALUE SELECTORS

Note that, with each of the main value selector nodes documented in this
main POD section, any occurrences
of child `expr` nodes should be read as being `value` nodes instead in
contexts where instances of the main nodes are being composed beneath
`value` nodes.  That is, any `expr` node options beyond what `value`
options exist are only valid within a `depot` node.

## Scalar Selectors

A `Scalar` node represents a literal or selector invocation for a
not-`Int|String` scalar subtype value.  It is interpreted as a Muldis Data Language
`sys.std.Core.Type.Scalar` subtype value whose declared type is specified
by the node's (mandatory for `Scalar`) `type_name` element and whose
attributes are defined by the payload.  If the payload is a Raku `Pair`,
then its key and value, respectively, are designated *possrep name* and
*possrep attrs*; if the payload is not a Raku `Pair`, then it is
interpreted as if it was just the *possrep attrs*, and the *possrep name*
was the empty string.  The possrep name and possrep attrs must be as per
the payload of a `Name` and `Tuple` node, respectively.  The *possrep
attrs* is interpreted specifically as attributes of the declared type's
possrep which is specified by the *possrep name*.  Each key+value pair of
the *possrep attrs* defines a named possrep attribute of the new scalar;
the pair's key and value are, respectively, a Raku `Str` that specifies
the possrep attribute name, and an `expr` node that specifies the possrep
attribute value.

Examples:

    [ 'Scalar', 'Name', { '' => 'the_thing' } ]

    [ '$', 'Rat', float => {
        mantissa => 45207196,
        radix    => 10,
        exponent => 37,
    } ]

    [ '$', 'fed.lib.the_db.UTCDateTime', datetime => {
        year   => 2003,
        month  => 10,
        day    => 26,
        hour   => 1,
        minute => 30,
        second => 0.0,
    } ]

    [ '$', 'fed.lib.the_db.WeekDay', name => {
        '' => 'monday',
    } ]

    [ '$', 'fed.lib.the_db.WeekDay', number => {
        '' => 5,
    } ]

## Tuple Selectors

A `Tuple` node represents a literal or selector invocation for a
tuple value.  It is interpreted as a Muldis Data Language
`sys.std.Core.Type.Tuple` value whose attributes are defined by the
payload.  The payload must be a Raku `Mapping|Hash`.  Each key+value pair
of the payload defines a named attribute of the new tuple; the pair's key
and value are, respectively, a Raku `Str` that specifies the attribute
name, and an `expr` node that specifies the attribute value.

Examples:

    :Tuple{}

    [ '%', 'type.tuple_from.var.fed.data.the_db.account.users', {
        login_name => 'hartmark',
        login_pass => 'letmein',
        is_special => Bool::True,
    } ]

    '%' => {
        name => 'Michelle',
        age  => 17,
    }

## Database Selectors

A `Database` node represents a literal or selector invocation for a
'database' value.  It is interpreted as a Muldis Data Language
`sys.std.Core.Type.Database` value whose attributes are defined by the
payload.  The payload must be a Raku `Mapping|Hash`.  Each key+value pair
of the payload defines a named attribute of the new 'database'; the pair's
key and value are, respectively, a Raku `Str` that specifies the attribute
name, and an `expr` node that specifies the attribute value, which must be
represent a relation value.

## Relation Selectors

A `Relation` node represents a literal or selector invocation for a
relation value.  It is interpreted as a Muldis Data Language
`sys.std.Core.Type.Relation` value whose attributes and tuples are
defined by the payload, which is interpreted as follows:

* Iff the payload is a Raku `Set|KeySet` with zero elements, then it
defines the only relation value having zero attributes and zero tuples.

* Iff the payload is a Raku `Set|KeySet` with at least one element, and
every element is a Raku `Str` (as per a valid payload for a `Name` node),
then it defines the attribute names of a relation having zero tuples.

* Iff the payload is a Raku `Set|KeySet` with at least one element, and
every element is a Raku `Mapping|Hash` (as per a valid payload for a
`Tuple` node), then each element of the payload defines a tuple of
the new relation; every tuple-defining element of the payload must be of
the same degree and have the same attribute names as its sibling elements;
these are the degree and attribute names of the relation as a whole, which
is its heading for the current purposes.

* Iff the payload is a Raku `Pair`, then:  The new relation value's
attribute names are defined by the payload's key, which is a Raku
`Seq|Array` of `Str` (each as per a `Name` node payload), and the
relation body's tuples' attribute values are defined by the payload's
value, which is a Raku `Set|KeySet` of `Seq|Array` of tuple attribute
value defining  nodes.  This format is meant to be the most compact of
the generic relation payload formats, as the attribute names only appear
once for the relation rather than repeating for each tuple.  As a
trade-off, the attribute values per tuple from the payload value must
appear in the same order as their corresponding attribute names appear in
the payload key, as the names and values in the relation literal are
matched up by ordinal position here.

Examples *What is the actual syntax for the P6 Set type?*:

    :Relation( Set.new() )  # zero attrs + zero tuples #

    '@' => Set.new(<x y z>)  # 3 attrs + zero tuples #

    '@' => Set.new( {} )  # zero attrs + 1 tuple #

    '@' => Set.new(
        {
            login_name => 'hartmark',
            login_pass => 'letmein',
            is_special => Bool::True,
        },
    )  # 3 attrs + 1 tuple #

    [ '@', 'fed.lib.the_db.gene.Person', <name age> => Set.new(
        [ 'Michelle', 17 ],
    ) ]  # 2 attrs + 1 tuple #

## Set Selectors

A `Set` node represents a literal or selector invocation for a set
value.  It is interpreted as a Muldis Data Language `sys.std.Core.Type.Set` value
whose elements are defined by the payload.  The payload must be a Raku
`Set|KeySet`.  Each element of the payload defines a unary tuple of
the new set; each element is an `expr` node that defines the `value`
attribute of the tuple.

Examples *What is the actual syntax for the P6 Set type?*:

    [ 'Set', 'fed.lib.the_db.account.Country_Names', Set.new(
        'Canada',
        'Spain',
        'Jordan',
        'Thailand',
    ) ]

    :Set( Set.new(
        3,
        16,
        85,
    ) )

## Maybe Selectors

A `Maybe` node represents a literal or selector invocation for a
maybe value.  It is interpreted as a Muldis Data Language
`sys.std.Core.Type.Maybe` value.  If the node payload is missing or
undefined, then the node is interpreted as the special value
`Maybe:Nothing`, aka `Nothing`, which is the only `Maybe` value with
zero elements.  If the node payload is defined then the node is interpreted
as a `Just` whose element is defined by the payload.  The payload is an
`expr` node that defines the `value` attribute of the single tuple
of the new 'single'.

Examples:

    :Maybe( 'I know this one!' )

    :Maybe()  # or how does Raku make a Pair with undef/default value? #

## Array Selectors

An `Array` node represents a literal or selector invocation for an
array value.  It is interpreted as a Muldis Data Language
`sys.std.Core.Type.Array` value whose elements are defined by the
payload.  The payload must be a Raku `Seq|Array`.  Each element of the
payload defines a binary tuple of the new sequence; the element value
is an `expr` node that defines the `value` attribute of the tuple,
and the element index is used as the `index` attribute of the tuple.

Examples:

    :Array[
        'Alphonse',
        'Edward',
        'Winry',
    ]

    [ 'Array', 'fed.lib.the_db.stats.Samples_By_Order', [
        57,
        45,
        63,
        61,
    ] ]

## Bag Selectors

A `Bag` node represents a literal or selector invocation for a bag
value.  It is interpreted as a Muldis Data Language `sys.std.Core.Type.Bag` value
whose elements are defined by the payload.  The payload must be a Raku
`Bag|KeyBag|Set|KeySet` value; the payload element keys are `expr` nodes
corresponding to the `value` attribute of the new bag's
tuples, and the payload element values are positive integers (or
`Bool::True`, which counts as the number 1) corresponding to the `count`
attribute; the payload element mapping is as you should expect.

Examples *What is the actual syntax for the P6 Bag type?*:

    [ 'Bag', 'fed.lib.the_db.inventory.Fruit', Bag.new(
        'Apple'  => 500,
        'Orange' => 300,
        'Banana' => 400,
    ) ]

    :Bag( Bag.new(
        'Foo',
        'Quux',
        'Foo',
        'Bar',
        'Baz',
        'Baz',
    ) )

## Interval Selectors

An `SPInterval` node represents a literal or selector invocation for a
single-piece interval value.  It is interpreted as a Muldis Data Language
`sys.std.Core.Type.SPInterval` value whose attributes are defined by the
payload.  The node payload must be a Raku `Range`, which is mapped
directly.  Each of the `min` and `max` attributes/method-return-values of
the `Range` is an `expr` node that defines the `min` and `max`
attribute value, respectively, of the new single-piece interval.  Each of
the `excludes_min` and `excludes_max` of the `Range` maps directly with
the single-piece interval.

A special shorthand for an `SPInterval` payload also exists, which is to
help with the possibly common situation where an interval is a singleton,
meaning the interval has exactly 1 value; the shorthand empowers that value
to be specified just once rather than twice.  Iff the payload is *not* a
Raku `Range`, then the payload is treated as if it was instead the usual
Raku `Range`, whose `min` and `max` are both identical to the actual
payload and whose `excludes_min` and `excludes_max` are both
`Bool::False`.  For example, the payload `6` is shorthand for `6..6`.

An `MPInterval` node represents a literal or selector invocation for a
multi-piece interval value.  It is interpreted as a Muldis Data Language
`sys.std.Core.Type.MPInterval` value whose elements are defined by the
payload.  The payload must be a Raku `Set|KeySet`.  Each element of the
payload must be a valid payload for an `SPInterval` node (that is, a Raku
`Range`).  Each element of the payload defines a 4-ary tuple, representing
a single-piece interval, of the new multi-piece interval.

Examples *What is the actual syntax for the P6 Set type?*:

    :SPInterval(1..10)

    2.7..^9.3

    'a'^..'z'

    :UTCInstant[2002,12,6] ^..^ :UTCInstant[2002,12,20]

    :SPInterval<abc>  # 1 element #

    :MPInterval( Set.new() )  # zero elements #

    :MPInterval( Set.new(1..10) )  # 10 elements #

    :MPInterval( Set.new(1..3,6,8..9) )  # 6 elements #

    :MPInterval( Set.new(-Inf..3,14..21,29..Inf) )
        # all Int besides {4..13,22..28} #

## Low Level List Selectors

A `List` node represents a literal or selector invocation for a low-level
list value.  It is interpreted as a Muldis Data Language `sys.std.Core.Type.Cat.List`
value whose elements are defined by the payload.  The payload must be just
a Raku `Seq|Array`.  Each element of the payload defines an element of the
new list, where the elements keep the same order.

Examples:

    # Nonstructure : Unicode abstract code points = 'Perl' #
    :List[80,101,114,109]

    # UCPString : Unicode abstract code points = 'Perl' #
    :List[1,:List[80,101,114,109]]

    # %:{} #
    :List[2,:List[],:List[]]

    # @:{} #
    :List[3,:List[],:List[]]

    # Set : {17,42,5} #
    :List[3,
        :List[:List[1,:List[118,97,108,117,101]]],
        :List[
            :List[17],
            :List[42],
            :List[5]
        ]
    ]

    # Nothing #
    :List[3,
        :List[:List[1,:List[118,97,108,117,101]]],
        :List[]
    ]

    # Text : 'Perl' #
    :List[4,
        # type name : 'sys.std.Core.Type.Text' #
        :List[
            :List[1,:List[115,121,115]],
            :List[1,:List[115,116,100]],
            :List[1,:List[67,111,114,101]],
            :List[1,:List[84,121,112,101]],
            :List[1,:List[84,101,120,116]],
        ],
        # possrep name : 'nfd_codes' #
        :List[1,:List[110,102,100,95,99,111,100,101,115]],
        # possrep attributes : %:{""=>"Perl"} #
        :List[2,
            :List[:List[1,:List[]]],
            :List[:List[1,:List[80,101,114,109]]]
        ]
    ]

# DEPOT SPECIFICATION

A `depot` node has 2-3 ordered elements such that 3 elements means the
depot has a normal-user-data database and 2 elements means it has just a
(possibly empty) system catalog database:  The first element is the Raku
`Str` value `depot`.  Iff the `depot` has 3 elements then the third
element specifies the normal-user-data database; it is a Raku `Pair` whose
key is the Raku `Str` value `depot-data` and whose value is a `Database`
node.  The second element specifies the system catalog database; it is a
Raku `Pair` whose key is the Raku `Str` value `depot-catalog` and whose
value is either a `Database` node or a Raku `Seq|Array` which is
hereafter referred to as `depot_catalog_payload`.  A
`depot_catalog_payload` either has zero elements, designating an empty
catalog, or all of its elements are Raku `Seq|Array` (in particular, none
of its elements is the Raku `Str` value 'Database'), each of which is one
of the following kinds of nodes: `subdepot`, `named_material`,
`self_local_dbvar_type`.

A `subdepot` node has 3 ordered elements:  The first element is the Raku
`Str` value `subdepot`.  The second element is a `Name_payload`,
which is the declared name of the subdepot within the namespace defined by
its parent subdepot (or depot).  The third element is a
`depot_catalog_payload`.

A `self_local_dbvar_type` node has 2 ordered elements:  The first element
is the Raku `Str` value `self-local-dbvar-type`.  The second element
is a `PNSQNameChain_payload`, which specifies what the normal-user-data
database has as its declared data type.

Examples:

    # A completely empty depot that doesn't have a self-local dbvar. #
    [ 'depot', :depot-catalog[] ]

    # Empty depot with self-local dbvar with unrestricted allowed values. #
    [ 'depot',
        :depot-catalog[
            :self-local-dbvar-type<Database>
        ],
        :depot-data[ 'Database', {} ]
    ]

    # A depot having just one function and no dbvar. #
    [ 'depot', :depot-catalog[
        [ 'function', 'cube', [ 'Int', { topic => 'Int' } ] => [
            [ 'i-op', 'exp', [ :d<topic>, 3 ] ]
        ] ]
    ] ]

# MATERIAL SPECIFICATION

A `material` node specifies a new material (routine or type) that lives in
a depot or subdepot.

There are 13 main varieties of `material` node, each of which is a named
node kind of its own:  `function`, `procedure`,
`scalar_type`, `tuple_type`, `relation_type`, `domain_type`,
`subset_type`, `mixin_type`, `key_constr`, `distrib_key_constr`,
`subset_constr`, `distrib_subset_constr`, `stim_resp_rule`.

## Material Specification Common Elements

A `material` node has 2-3 ordered elements, such that a material that has
2 elements is an `anon_material` and a material with 3 elements is a
`named_material`:  The first element is `material_kind`.  The last
element is `material_payload`.  Iff there are 3 elements then the
middle element is `material_declared_name`.

* `material_kind`

This is a Raku `Str` value of the format `[<[ a..z ]>+] ** '-'`; it
identifies the kind of the material and is the only external metadata of
`material_payload` generally necessary to interpret the latter; what
grammars are valid for `material_payload` depend just on `material_kind`.

* `material_declared_name`

This is the declared name of the material within the namespace defined by
its subdepot (or depot).  It is explicitly specified iff the `material` is
a `named_material`

* `material_payload`

This is mandatory for all `material`.  It specifies the entire material
sans its name.  Format varies with `material_kind`.

For material examples, see the subsequent documentation sections.

Note that, for simplicity, the subsequent sections assume for now that
`named_material` is the only valid option, and so the
`material_declared_name` isn't optional, and the only way to embed a
material in another is using a `with_clause`.

## Function Specification

A `function` node specifies a new function that lives in a depot or
subdepot.  A `function` node has 3 ordered elements:  The first element
is one of these 8 Raku `Str` values: `function`, `named-value`,
`value-map`, `value-map-unary`, `value-filter`, `value-constraint`,
`value-reduction`, `order-determination`.  The
second element is a `Name_payload`, which is the function's declared name.
The third element is a `function_payload`.  A `function_payload` is a
Raku `Pair` whose key and value are designated, in order,
`function_heading` and `function_body`.

A `function_heading` is a Raku `Seq|Array` with 2-3 ordered elements.
The first element is designated `result_type` and is mandatory.  The
second element is designated `func_params` and is mandatory.  The third
element is designated `implements` and is optional.

A `result_type` is a `type_name` which is a `PNSQNameChain_payload`.

A `func_params` is structurally a proper subset of an `proc_params`;
every valid `proc_params` is also a structurally valid `func_params`
except for any `procedure_payload` that has either a `::=` element or a
`&` element; in other words, a function has neither global nor
subject-to-update parameters; it just has regular read-only parameters.

A `function_body` must be either the Raku character string `...`, in
which case it is an `empty_routine_body`, or it must be a Raku
`Seq|Array`, having at least one element which is an `expr`, and each
other element of said Raku `Seq|Array` must be either a `with_clause` or
a `named_expr`.

Each of `implements` and `with_clause` of a `function_payload` is
structurally identical to one of a `procedure_payload`.

Examples:

    [ 'function', 'cube', [ 'Int', { topic => 'Int' } ] => [
        [ 'i-op', 'exp', [ :d<topic>, 3 ] ]
    ] ]

## Procedure Specification

A `procedure` node specifies a new procedure that lives in a depot or
subdepot.  A `procedure` node has 3 ordered elements:  The first element
is one of these 5 Raku `Str` values: `procedure`, `system-service`,
`transaction`, `recipe`, `updater`.
The second element is a `Name_payload`, which is the
procedure's declared name.  The third element is a `procedure_payload`.  A
`procedure_payload` is a Raku `Pair` whose key and value are
designated, in order, `procedure_heading` and `procedure_body`.

Iff the `procedure_heading` is a Raku `Seq|Array`, then it has 1-2
ordered elements.  The first element is designated `proc_params` and is
mandatory.  The second element is designated `implements` and is optional.
Iff the `procedure_heading` is a Raku `Mapping|Hash`, then it is
designated `proc_params` and there is no `implements`.

A `proc_params` is a Raku `Mapping|Hash`; it must have at least one
element, meaning the procedure has one or more parameters; each hash
element specifies one parameter, and for each hash element, the hash
element's key and value, respectively, are designated `param_name` and
`param_details`.  Iff `param_details` is a Raku `Seq|Array` with at
least two elements, and its first element is not a non-empty Raku `Str`
value consisting of just the characters <[ a..z A..Z 0..9 _ - ]>, then the
`param_details` is a `param_multi_meta`; otherwise, `param_details` is a
`param_single_meta`.

Iff a parameter's `param_details` is a `param_single_meta`, then the
latter must be either a `PNSQNameChain_payload` or a single-element array
whose sole element is one of those; then the parameter is a
`ro_reg_param`, its `param_details` is designated `type_name`, and it
has no `param_flag`.

Iff a parameter's `param_details` is a `param_multi_meta`, then the
latter's last element must be a `PNSQNameChain_payload`, and each of the
`param_details`' other elements must be a distinct one of these 4 Raku
`Str` values: `&`, `?`, `@`, `::=`.  A `param_multi_meta` must
have at least 1 of those 4 and at most 2 of them, and furthermore only
certain permutations are allowed.  A `&` may be used either alone or in
combination with exactly one of the other 3; its presence means that the
parameter is subject-to-update; its absence means the parameter is
read-only; iff a `&` is used then it must be the first `param_details`
element.  The 3 of `?`, `@`, `::=` are mutually exclusive so a
`param_details` may have at most one of them, either alone or with a `&`.

Iff a parameter's `param_details` is a `param_multi_meta` and it does not
have a `::=` element, then the parameter is a regular parameter.  A
regular parameter's last (`PNSQNameChain_payload`) element is designated
`type_name`.  Iff a regular parameter has a `&` element then the
parameter is an `upd_reg_param`; otherwise it is a `ro_reg_param`.  Iff a
regular parameter has a `?` then the parameter has an `opt_param_flag`.
Iff a regular parameter has a `@` then the parameter has a
`dispatch_param_flag`.

Iff a parameter's `param_details` is a `param_multi_meta` and it does
have a `::=` element, then the parameter is a global parameter.  A global
parameter's last (`PNSQNameChain_payload`) element is designated
`global_var_name`.  Iff a global parameter has a `&` element then the
parameter is an `upd_global_param`; otherwise it is a `ro_global_param`.

An `implements` must be either a `PNSQNameChain_payload` or a Raku
`Seq|Array` having zero or more elements where every element is a
`PNSQNameChain_payload`; each `PNSQNameChain_payload` names a virtual
procedure which the current procedure is declaring that it implements.

A `procedure_body` must be either the Raku `Str` value `...`, in which
case it is an `empty_routine_body`, or it must be a Raku `Seq|Array`
having zero or more elements where each element must be either a
`with_clause` or a `proc_var` or a
`named_expr` or a `proc_stmt`; zero elements means that
the procedure is an unconditional no-op.

A `with_clause` is a Raku `Pair` whose key is the Raku `Str` value
`with` and whose value is a `material` node.

A `proc_var` is a 3-element Raku `Seq|Array` whose first element is the
Raku `Str` value `var`, whose second element is a `Name_payload`, and
whose third element is a `type_name` which is a `PNSQNameChain_payload`.

Examples:

    [ 'procedure', 'print_curr_time', {} => [
        [ 'var', 'now', 'Instant' ],
        [ 'proc-invo', 'fetch_trans_instant', [ ['&',:d<now>] ] ],
        [ 'proc-invo', 'write_Text_line', [ [ 'i-op', '~', [
            'The current time is: ',
            [ 'func-invo', 'nlx.par.lib.utils.time_as_text',
                { time => :d<now> } ]
        ] ] ] ],
    ] ]

    [ 'recipe', 'count_heads', { count => ['&','NNInt'], search => 'Text',
            people => ['::=','fed.data.db1.people'] } => [
        :with[ 'value-filter', 'filt',
            [ 'Bool', { topic => 'Tuple', search => 'Text' } ]
            => [
                [ 'i-op', 'like', [ :acc<topic.name>,
                    [ 'i-op', '~', [ '%', :d<search>, '%' ] ] ] ]
            ]
        ],
        [ 'i-op', ':=', [ :d<count>, [ 'pre-op', '#, [
            [ 'i-op', 'where', [ :d<people>,
                ['primed-func', 'nlx.lib.filt', {search=>:d<search>}]
            ] ]
        ] ] ] ],
    ] ]

    [ 'updater', 'make_coprime', {a=>['&','NNInt'],b=>['&','NNInt']} => [
        :with[ 'function', 'gcd',
            [ 'NNInt', { a => 'NNInt', b => 'NNInt' } ]
            => [
                [ '??!!', [ 'i-op', '=', [ :d<b>, 0 ] ],
                    :d<a>,
                    [ 'func-invo', 'rtn', { a => :d<b>,
                        b => [ 'i-op', 'mod', [ :d<a>, :d<b>,
                            :RoundMeth<Down> ] ] } ]
                ]
            ]
        ],
        [ '::=', 'gcd', [ 'func-invo', 'nlx.lib.gcd',
            { a => :d<a>, b => :d<b> } ] ],
        [ 'i-op', ':=', [ :d<a>, [ 'i-op', 'div',
            [ :d<a>, :d<gcd>, :RoundMeth<Down> ] ] ] ],
        [ 'i-op', ':=', [ :d<b>, [ 'i-op', 'div',
            [ :d<b>, :d<gcd>, :RoundMeth<Down> ] ] ] ],
    ] ]

## Scalar Type Specification

A `scalar_type` node specifies a new scalar type that lives in a depot
or subdepot.  A `scalar_type` node has 3 ordered elements:  The first
element is the Raku `Str` value `scalar-type`.  The second element
is a `Name_payload`, which is the scalar type's declared name.  The
third element is a `scalar_type_payload`.

*The remaining description.*

*Examples.*

## Tuple Type Specification

A `tuple_type` node specifies a new tuple type that lives in a depot or
subdepot.  A `tuple_type` node has 3 ordered elements:  The first element
is one of these 2 Raku `Str` values: `tuple-type`, `database-type`.
The second element is a `Name_payload`, which is the tuple type's declared
name.  The third element is a `tuple_type_payload`.

*The remaining description.*

Examples:

    # db schema with 3 relvars, 2 subset constrs, the 5 def separately #
    [ 'database-type', 'CD_DB', [
        [ 'attr', 'artists', 'nlx.lib.Artists' ],
        [ 'attr', 'cds'    , 'nlx.lib.CDs'     ],
        [ 'attr', 'tracks' , 'nlx.lib.Tracks'  ],
        :constraint<nlx.lib.sc_artist_has_cds>,
        :constraint<nlx.lib.sc_cd_has_tracks>,
    ] ]

    # relation type using tuple virtual-attr-map for case-insen key attr #
    # where primary text data is case-sensitive, case-preserving #
    [ 'relation-type', 'Locations', [
        :tuple-type<nlx.lib.Location>,
        :with[ 'tuple-type', 'Location', [
            [ 'attr', 'loc_name'   , 'Text' ],
            [ 'attr', 'loc_name_uc', 'Text' ],
            virtual-attr-map:{
                determinant-attrs => { loc_name => 'loc_name' },
                dependent-attrs   => { loc_name_uc => 'loc_name_uc' },
                map-function      => 'nlx.lib.uc_loc_name'
            },
            :with[ 'value-map-unary', 'uc_loc_name',
                [ 'Tuple', { topic => 'Tuple' } ]
                => [
                    [ '%', { loc_name_uc => [ 'func-invo', 'upper',
                        [ :acc<topic.loc_name> ] ] } ]
                ]
            ],
        ] ],
        :constraint<nlx.lib.sk_loc_name_uc>,
        :with['key-constraint', 'sk_loc_name_uc', 'loc_name_uc'],
    ] ]

    # db schema with 2 real relvars, 1 virtual relvar; all are updateable #
    # real products has attrs { product_id, name } #
    # real sales has attrs { product_id, qty } #
    # virtual combines has attrs { product_id, name, qty } #
    [ 'database-type', 'DB', [
        [ 'attr', 'products', 'nlx.lib.Products' ],
        [ 'attr', 'sales'   , 'nlx.lib.Sales'    ],
        [ 'attr', 'combines', 'nlx.lib.Combines' ],
        virtual-attr-map:{
            determinant-attrs => {products => 'products',sales => 'sales'},
            dependent-attrs   => { combines => 'combines' },
            map-function      => 'nlx.lib.combine_p_s',
            is-updateable     => Bool::True
        },
        :with[ 'value-map-unary', 'combine_p_s',
            [ 'Database', { topic => 'Database' } ]
            => [
                [ 'Database', { combines => [ 'i-op', 'join',
                    [ :acc<topic.products>, :acc<topic.sales> ] ] } ]
            ]
        ],
    ] ]

## Relation Type Specification

A `relation_type` node specifies a new relation type that lives in a depot
or subdepot.  A `relation_type` node has 3 ordered elements:  The first
element is the Raku `Str` value `relation-type`.  The second element
is a `Name_payload`, which is the relation type's declared name.  The
third element is a `relation_type_payload`.

*The remaining description.*

Examples:

    [ 'relation-type', 'Artists', [
        :with[ 'tuple-type', 'Artist', [
            [ 'attr', 'artist_id'  , 'Int'  ],
            [ 'attr', 'artist_name', 'Text' ],
        ] ],
        :with[ 'primary-key', 'pk_artist_id', 'artist_id' ],
        :with[ 'key-constraint', 'sk_artist_name', 'artist_name' ],
        :tuple-type<nlx.lib.Artist>,
        :constraint<nlx.lib.pk_artist_id>,
        :constraint<nlx.lib.sk_artist_name>,
    ] ]

    [ 'relation-type', 'CDs', [
        :with[ 'tuple-type', 'CD', [
            [ 'attr', 'cd_id'    , 'Int'  ],
            [ 'attr', 'artist_id', 'Int'  ],
            [ 'attr', 'cd_title' , 'Text' ],
        ] ],
        :with[ 'primary-key', 'pk_cd_id', 'cd_id' ],
        :with[ 'key-constraint', 'sk_cd_title', 'cd_title' ],
        :tuple-type<nlx.lib.CD>,
        :constraint<nlx.lib.pk_cd_id>,
        :constraint<nlx.lib.sk_cd_title>,
    ] ]

## Domain Type Specification

A `domain_type` node specifies a new domain type that lives in a depot
or subdepot.  A `domain_type` node has 3 ordered elements:  The first
element is the Raku `Str` value `domain-type`.  The second element
is a `Name_payload`, which is the domain type's declared name.  The
third element is a `domain_type_payload`.

*The remaining description.*

*Examples.*

## Subset Type Specification

A `subset_type` node specifies a new subset type that lives in a depot
or subdepot.  A `subset_type` node has 3 ordered elements:  The first
element is the Raku `Str` value `subset-type`.  The second element
is a `Name_payload`, which is the subset type's declared name.  The
third element is a `subset_type_payload`.

*The remaining description.*

*Examples.*

## Mixin Type Specification

A `mixin_type` node specifies a new mixin type that lives in a depot
or subdepot.  A `mixin_type` node has 3 ordered elements:  The first
element is the Raku `Str` value `mixin-type`.  The second element
is a `Name_payload`, which is the mixin type's declared name.  The
third element is a `mixin_type_payload`.

*The remaining description.*

*Examples.*

## Key Constraint Specification

A `key_constr` node specifies a new unique key constraint or candidate
key, for a relation type, that lives in a depot or subdepot.  A
`key_constr` node has 3 ordered elements:  The first element is one of
these 2 Raku `Str` values: `key-constraint`, `primary-key`.  The
second element is a `Name_payload`, which is the constraint's declared
name.  The third element is a `key_constr_payload`, which is just a Raku
`Set|KeySet` of 0..N elements where each of said elements is a
`Name_payload`, which is the name of an attribute that the key ranges
over; alternately, a `key_constr_payload` may be just a `Name_payload`,
which is equivalent to the `Set|KeySet` format with 1 element.

Examples:

    # at most one tuple allowed #
    [ 'key-constraint', 'maybe_one', Set.new() ]

    # relation type's artist_id attr is its primary key #
    [ 'primary-key', 'pk_artist_id', 'artist_id' ]

    # relation type has surrogate key over both name attrs #
    [ 'key-constraint', 'sk_name', Set.new( 'last_name', 'first_name' ) ]

## Distributed Key Constraint Specification

*TODO.*

## Subset Constraint Specification

A `subset_constr` node specifies a (non-distributed) subset constraint
(foreign key constraint) over relation-valued attributes, for a tuple type,
that lives in a depot or subdepot.  A `subset_constr` node has 3 ordered
elements:  The first element is the Raku `Str` value `subset-constraint`.
The second element is a `Name_payload`, which is the constraint's declared
name.  The third element is a `subset_constr_payload`.

*The remaining description.*

Examples:

    # relation foo must have exactly 1 tuple when bar has at least 1 #
    [ 'subset-constraint', 'sc_mutual_inclusion', {
        parent      => 'foo',
        using-key   => 'nlx.lib.maybe_one',
        child       => 'bar',
        using-attrs => {}
    } ]

    [ 'subset-constraint', 'sc_artist_has_cds', {
        parent      => 'artists',
        using-key   => 'nlx.lib.Artists.pk_artist_id',
        child       => 'cds',
        using-attrs => { artist_id => 'artist_id' }
    } ]

## Distributed Subset Constraint Specification

*TODO.*

## Stimulus-Response Rule Specification

A `stim_resp_rule` node specifies a new stimulus-response rule that lives
in a depot or subdepot.  A `stim_resp_rule` node has 3 ordered elements:
The first element is the Raku `Str` value `stimulus-response-rule`.
The second element is a `Name_payload`, which is the stimulus-response
rule's declared name.  The third element is a `stim_resp_rule_payload`.

A `stim_resp_rule_payload` is a Raku `Pair` whose key and value
are designated, in order, `stimulus` and `response`; `stimulus` is the
Raku `Str` value `after-mount` (the kind of stimulus), and
`response` is a `PNSQNameChain_payload` (the name of the recipe or
procedure being invoked in response).

Examples:

    [ 'stimulus-response-rule', 'bootstrap', :after-mount<nlx.lib.main> ]

# GENERIC VALUE EXPRESSIONS

An `expr_name` node has 2 ordered elements:  The first element is the Raku
`Str` value `d` ("data").  The second element is a `Name_payload`.

An `expr_name` node may alternately be formatted as a Raku Pair whose key
and value are what would otherwise be the first and second node elements,
respectively.

A `named_expr` node has 3 ordered elements:  The first element is either
of the 2 Raku `Str` values [`::=`, `let`].  The second element is
a `Name_payload` and the third element is an `expr` node; the second
element declares an explicit expression node name for the third element.

Examples:

    # an expr_name node #
    :d<foo_expr>

    # a named_expr node #
    [ '::=', 'bar_expr', [ 'func-invo', 'factorial', [:d<foo_expr>] ] ]

## Generic Expression Attribute Accessors

An `accessor` node has 2-3 ordered elements, such that 2 elements makes it
an `acc_via_named` and 3 elements makes it an `acc_via_anon`:  The first
element is the Raku `Str` value `acc`.  The last element of an
`acc_via_named` is a `NameChain_payload`, which is by itself the
`target` of the accessor (naming both the other node plus its attribute to
alias).  The second element of an `acc_via_anon` is an `expr` node which
is the other node whose attribute is being aliased.  The last element of an
`acc_via_anon` is a nonempty `NameChain_payload` and names the attribute.

Examples:

    # an accessor node of a named tuple-valued node #
    :acc<foo_t.bar_attr>

    # an accessor node of an anonymous tuple-valued node #
    ['acc',['func-invo','nlx.lib.tuple_res_func',[:d<arg>]],'quux_attr']

## Generic Function Invocation Expressions

A `func_invo` node has 2-4 ordered elements:  The first element is the
Raku `Str` value `func-invo`.  The second element is a
`PNSQNameChain_payload`, which names the function to invoke.  The last 1-2
elements provide arguments to the function invocation; either or both or
none of an `Array_payload` element and a `Tuple_payload` element may be
given.  The `Array_payload` 3rd/4th element is for any anonymous (and
ordered if multiple exist) arguments, and the `Tuple_payload` 3rd/4th
element is for any named arguments; each `Array_payload` element or
`Tuple_payload` element value is an `expr` node which is the argument
value.

Examples:

    # zero params #
    :func-invo<Nothing>

    # single mandatory param #
    [ 'func-invo', 'median', [ :Bag( Bag.new(22,20,21,20,21,21,23) ) ] ]

    # single mandatory param #
    [ 'func-invo', 'factorial', { topic => 5 } ]

    # two mandatory params #
    [ 'func-invo', 'frac_quotient', { dividend => 43.7, divisor => 16.9 } ]

    # one mandatory 'topic' param, two optional #
    [ 'func-invo', 'nlx.lib.barfunc', [ :d<mand_arg> ],
        { oa1 => :d<opt_arg1>, oa2 => :d<opt_arg2> } ]

    # a user-defined function #
    [ 'func-invo', 'nlx.lib.foodb.bazfunc',
        { a1 => 52, a2 => 'hello world' } ]

    # two params named 'topic' and 'other' #
    [ 'func-invo', 'is_same', [ :d<foo>, :d<bar> ] ]

    # invoke the lexically innermost routine with 2 args #
    [ 'func-invo', 'rtn', [ :d<x>, :d<y> ] ]

## Generic If-Else Expressions

An `if_else_expr` node has 4 ordered elements:  The first element is
either of the 2 Raku `Str` values `if-else-expr` and `??!!`.  The
second element is the *if* condition expression; the third and fourth
elements are the *then* and *else* result expressions, respectively;
every one of the last 3 elements is an `expr` node.

Examples:

    [ 'if-else-expr', [ 'i-op', '>', [:d<foo>, 5] ], :d<bar>, :d<baz> ]

    [ 'if-else-expr',
        ['func-invo','is_empty',[:d<ary>]],
        :d<empty_result>,
        [ 'post-op', '.[]', [:d<ary>, 0] ]
    ]

    [ 'i-op', '~', ['My answer is: ', [ '??!!', :d<maybe>, 'yes', 'no' ]] ]

## Generic Given-When-Default Expressions

A `given_when_def_expr` node has 3-4 ordered elements:  The first element
is the Raku `Str` value `given-when-def-expr`.  The second element is an
`expr` node which is the *given* common comparand.  The optional third
element is *when_then*, a Raku `Seq|Array` with 0..N elements, each of
those being a 2-element Raku `Seq|Array` or a Raku Pair, where each
element is an `expr` node; the first element / key is a *when* comparand,
and the second element / value is the associated *then* result expression.
The 4th/last element of a `given_when_def_expr` node is *default* result
expression, which is an `expr` node.

Examples:

    [ 'given-when-def-expr',
        :d<digit>,
        [
            'T' => 10,
            'E' => 11,
        ],
        :d<digit>,
    ]

## Material Reference Selector Expressions

A `material_ref` node has 2 ordered elements:  The first element
is the Raku `Str` value `material-ref`.  The second element is a
`PNSQNameChain_payload`, which names the routine or type to reference.

A `primed_func` node has 2-4 ordered elements:  The first element is the
Raku `Str` value `primed-func`.  The second element is a
`PNSQNameChain_payload`, which names the function to reference.  The last
1-2 elements provide arguments for the function as per the last 1-2
elements of a `func_invo` node.

A `material_ref` node, or a `primed_func` node with zero primed
arguments, may alternately be formatted as
a Raku Pair whose key and value are what would otherwise be the first and
second node elements, respectively.

Examples:

    # a higher-order function primed with 1 argument #
    [ 'primed-func', 'nlx.lib.filter',
        { search_term => :d<search_term> } ]

    # a reference to an updater #
    :material-ref<nlx.lib.swap>

    # a reference to a data type #
    :material-ref<nlx.lib.foo_type>

# GENERIC PROCEDURE STATEMENTS

A `stmt_name` node has 2 ordered elements:  The first element is the Raku
`Str` value `s`.  The second element is a `Name_payload`.

A `stmt_name` node may alternately be formatted as a Raku Pair whose key
and value are what would otherwise be the first and second node elements,
respectively.

A `named_stmt` node has 3 ordered elements:  The first element is either
of the 2 Raku `Str` values [`::=`, `let`].  The second element is
a `Name_payload` and the third element is a `proc_stmt` node; the second
element declares an explicit statement node name for the third element.

Examples:

    # a stmt_name node #
    :s<foo_stmt>

    # a named_stmt node #
    [ '::=', 'bar_stmt', [ 'proc-invo', 'nlx.lib.swap',
        {first => ['&',:d<first>], second => ['&',:d<second>]} ] ]

## Generic Compound Statements

A `compound_stmt` node has 2 ordered elements:  The first element is the
Raku `Str` value `compound-stmt`.  The second element is a Raku
`Seq|Array` having zero or more elements where each element must be either
a `with_clause` or a `proc_var` or a `named_expr` or a `proc_stmt`;
it is interpreted as
per a nonempty procedure body, which has exactly the same format.

Examples:

    :compound-stmt[
        [ 'var', 'message', 'Text' ],
        [ 'proc-invo', 'read_Text_line', [ ['&',:d<message>] ] ],
        [ 'proc-invo', 'write_Text_line', [ :d<message> ] ],
    ]

## Multi-Update Statements

A `multi_upd_stmt` node has 2 ordered elements:  The first element is the
Raku `Str` value `multi-upd-stmt`.  The second element is a Raku
`Seq|Array`; it is interpreted as per a nonempty recipe body, which has
exactly the same format.

Examples:

    :multi-upd-stmt[
        [ '::=', 'order_id', [ '??!!',
            [ 'func-invo', 'is_empty', [:d<orders>] ],
            1,
            [ 'post-op', '++', [[ 'func-invo', 'max', [
                [ 'func-invo', 'Set_from_attr',
                    [:d<orders>], {name => :Name<order_id>} ]
            ] ]] ]
        ] ],

        [ 'proc-invo', 'assign_insertion', [ ['&',[:d<orders>]],
            [ '%', { order_id => :d<order_id>, date => '2011-03-04' } ]
        ] ],

        [ 'proc-invo', 'assign_union', [ ['&',[:d<order_details>]],
            '@' => <order_id prod_code qty> => Set.new(
                [ :d<order_id>, 'COG' , 20, ],
                [ :d<order_id>, 'CAM' , 10, ],
                [ :d<order_id>, 'BOLT', 70, ],
            )
        ] ],
    ]

## Generic Procedure Invocation Statements

A `proc_invo` node has 2-4 ordered elements:  The first element is
the Raku `Str` value `proc-invo`.  The second element is a
`PNSQNameChain_payload`, which names the procedure to invoke.
The last 1-2 elements provide arguments to the procedure
invocation; either or both or none of an `Array_payload` element and a
`Tuple_payload` element may be given.  The `Array_payload` 3rd/4th
element is for any anonymous (and ordered if multiple exist) arguments, and
the `Tuple_payload` 3rd/4th element is for any named arguments; each
`Array_payload` element or `Tuple_payload` element value is the
*possibly tagged argument value* (PTAV).  For each PTAV, if the argument
is for a read-only parameter, then the PTAV is just an `expr` node
which is the argument value; if the argument is for a subject-to-update
parameter, then the PTAV is a Raku `Seq|Array` with exactly 2 elements,
where the first element is the Raku `Str` value `&`, and the second
element is the same `expr` node that the PTAV would have been were this
for a read-only parameter.

Examples:

    # two mandatory params, one s-t-u, one r-o #
    [ 'proc-invo', 'assign', [ ['&',:d<foo>], 3 ] ]

    # same as previous #
    [ 'proc-invo', 'assign', [ 3, ['&',:d<foo>] ] ]

    # still same as previous but with all-named syntax #
    [ 'proc-invo', 'assign', { target => ['&',:d<foo>], v => 3 } ]

    # three mandatory params #
    [ 'proc-invo', 'nlx.lib.lookup', { addr => ['&',:d<addr>],
        people => :d<people>, name => :d<name> } ]

    [ 'proc-invo', 'fetch_trans_instant', [ ['&',:d<now>] ] ]

    [ 'proc-invo', 'prompt_Text_line',
        [ ['&',:d<name>], 'Enter a person\'s name: ' ] ]

    [ 'proc-invo', 'Integer.fetch_random',
        [ ['&',:d<rand>], :d<interval> ] ]

## Generic Try-Catch Statements

A `try_catch_stmt` node has 2-3 ordered elements:  The first element is
the Raku `Str` value `try-catch`.  The second element is a
`proc_stmt` node having the *try* routine to unconditionally invoke
first.  The optional third element is a `proc_stmt` node having the
*catch* routine to execute iff *try* throws an exception.

Examples:

    [ 'try-catch',
        :proc-invo<nlx.lib.attempt_the_work>,
        :proc-invo<nlx.lib.deal_with_failure>
    ]

## Generic If-Else Statements

An `if_else_stmt` node has 3-4 ordered elements:  The first element is the
Raku `Str` value `if-else-stmt`.  The second element is the *if*
condition expression (an `expr` node).  The third element is the *then*
statement (a `proc_stmt` node).  The optional fourth/last element is the
*else* statement (a `proc_stmt` node).

Examples:

    [ 'if-else-stmt',
        :d<out_of_options>,
        :proc-invo<nlx.lib.give_up>,
        :proc-invo<nlx.lib.keep_going>
    ]

## Generic Given-When-Default Statements

A `given_when_def_stmt` node has 3-4 ordered elements:  The first element
is the Raku `Str` value `given-when-def-stmt`.  The second element is
an `expr` node which is the *given* common comparand.  The optional
third element is *proc_when_then*, a Raku `Seq|Array` with 0..N elements,
each of those being a 2-element Raku `Seq|Array` or a Raku Pair; the first
element / key is a *when* comparand (an `expr` node), and the second
element / value is the associated *then* result statement (a `proc_stmt`
node).  The optional 4th/last element of a `given_when_def_stmt` node is
*default_stmt* statement, which is a `proc_stmt` node.

Examples:

    [ 'given-when-def-stmt',
        :d<picked_menu_item>,
        [
            'v' => :proc-invo<nlx.lib.screen_view_record>,
            'a' => :proc-invo<nlx.lib.screen_add_record>,
            'd' => :proc-invo<nlx.lib.screen_delete_record>
        ],
        :proc-invo<nlx.lib.display_bad_choice_error>,
    ]

## Procedure Leave, Iterate, and Loop Statements

A `leave_stmt` node has 1-2 ordered elements:  The first element is the
Raku `Str` value `leave`.  The optional second element is a
`Name_payload` which names the parent statement node to abort; it defaults
to the empty string if not specified.

An `iterate_stmt` node has 1-2 ordered elements:  The first element is the
Raku `Str` value `iterate`.  The optional second element is a
`Name_payload` which names the parent statement node to redo; it defaults
to the empty string if not specified.

A `loop_stmt` node has 2 ordered elements:  The first element is the Raku
`Str` value `loop`.  The second element is a `proc_stmt` node having
the statement to repeatedly execute.

Examples:

    [ '::=', 'lookup_person', loop => :compound-stmt[
        [ 'proc-invo', 'prompt_Text_line',
            [ ['&',:d<name>], 'Enter a name to search for: ' ] ],
        [ 'given-when-def-stmt', :d<name>,
            [ '' => :leave<lookup_person> ] ],
        [ 'proc-invo', 'nlx.lib.do_search', {
            name => :d<name>,
            not_found => ['&',:d<not_found>],
            report_text => ['&',:d<report_text>]
        } ],
        [ 'if-else-stmt', :d<not_found>, :compound-stmt[
            [ 'proc-invo', 'write_Text_line', ['No person matched'] ],
            :iterate<lookup_person>
        ] ],
        [ 'proc-invo', 'write_Text_line', [ :d<report_text> ] ],
    ] ]

# DEPRECATED - FUNCTION INVOCATION ALTERNATE SYNTAX EXPRESSIONS

A `func_invo_alt_syntax` node has 3-4 ordered elements:  The first element
is one of the 3 Raku `Str` values [`i-op`, `pre-op`, `post-op`],
depending on whether it represents infix, prefix, or postfix syntax,
respectively.  The second element is a Raku `Str` value,
hereafter referred to as *op* or *keyword*, which determines the function
to invoke.  The third element is (usually) a Raku `Seq|Array`, hereafter
referred to as *main op args*, which is an ordered list of 1-N mandatory
inputs to the function invocation.  The (optional) fourth element is a Raku
`Mapping|Hash`, hereafter referred to as *extra op args*, which is a
named list of optional function inputs.  The number and format of elements
of either *main op args* or *extra op args* varies depending on *op*.
Note that, when a *main op args* would just contain a single element, such
as when it is for a monadic operator, it may alternately be formatted as
what is otherwise just its sole (node) element iff that node is not
formatted as a Raku `Seq|Array`.

## Simple Commutative N-adic Infix Reduction Operators

A `comm_infix_reduce_op_invo` node has 2-N main op args, each of which is
an `expr` node.  Note that the *main op args* may alternately be given as
a Raku `Bag|KeyBag|Set|KeySet` rather than a Raku `Seq|Array`.

Examples:

    [ 'i-op', 'min', [ :d<a>, :d<b>, :d<c> ] ]

    [ 'i-op', 'max', [ :d<a>, :d<b>, :d<c> ] ]

    [ 'i-op', 'and', [ Bool::True, Bool::False, Bool::True ] ]

    [ 'i-op', 'or', [ Bool::True, Bool::False, Bool::True ] ]

    [ 'i-op', 'xor', [ Bool::True, Bool::False, Bool::True ] ]

    [ 'i-op', '+', [ 14, 3, -5 ] ]

    [ 'i-op', '*', [ -6, 2, 25 ] ]

    [ 'i-op', '+', [ 4.25, -0.002, 1.0 ] ]

    [ 'i-op', '*', [ 69.3, 15 * 2 ** 6, 49/23 ] ]

    [ 'i-op', '∪', [ :Set( Set.new( 1, 3, 5 ) ),
        :Set( Set.new( 4, 5, 6 ) ), :Set( Set.new( 0, 9 ) ) ] ]

    [ 'i-op', '∩', [ :Set( Set.new( 1, 3, 5, 7, 9 ) ),
        :Set( Set.new( 3, 4, 5, 6, 7, 8 ) ), :Set( Set.new( 2, 5, 9 ) ) ] ]

## Simple Non-commutative N-adic Infix Reduction Operators

A `noncomm_infix_reduce_op_invo` node has 2-N main op args, each of which
is an `expr` node.

Examples:

    [ 'i-op', '[<=>]', [ Order::Same, Order::Less, Order::More ] ]

    [ 'i-op', '~', [ :16{DEAD}, :2{10001101}, :16{BEEF} ] ]

    [ 'i-op', '~', [ 'hello', ' ', 'world' ] ]

    [ 'i-op', '~', [ :Array[24, 52], :Array[-9], :Array[0, 11, 24, 7] ] ]

    [ 'i-op', '//', [ :d<a>, :d<b>, 42 ] ]

## Simple Symmetric Dyadic Infix Operators

A `sym_dyadic_infix_op_invo` node has exactly 2 main op args, each of
which is an `expr` node; which function arguments get which main op args
isn't significant.

Examples:

    [ 'i-op', '=', [ :d<foo>, :d<bar> ] ]

    [ 'i-op', '≠', [ :d<foo>, :d<bar> ] ]

    [ 'i-op', 'nand', [ Bool::False, Bool::True ] ]

    [ 'i-op', '|-|', [ 15, 17 ] ]

    [ 'i-op', '|-|', [ 7.5, 9.0 ] ]

## Simple Non-symmetric Dyadic Infix Operators

A `nonsym_dyadic_infix_op_invo` node has exactly 2 main op args, each of
which is an `expr` node; the first and second main op args are `lhs` and
`rhs`, respectively.

Examples:

    [ 'i-op', 'isa', [ :d<bar>, :material-ref<nlx.lib.foo_type> ] ]

    [ 'i-op', '!isa', [ :d<bar>, :material-ref<nlx.lib.foo_type> ] ]

    [ 'i-op', 'as', [ :d<scalar>, :material-ref<Int> ] ]

    [ 'i-op', 'asserting', [:d<int>, [ 'i-op', '≠', [:d<int>, 0] ]] ]

    [ 'i-op', 'implies', [ Bool::True, Bool::False ] ]

    [ 'i-op', '<', [ :d<foo>, :d<bar> ] ]

    [ 'i-op', '>', [ :d<foo>, :d<bar> ] ]

    [ 'i-op', '≤', [ :d<foo>, :d<bar> ] ]

    [ 'i-op', '≥', [ :d<foo>, :d<bar> ] ]

    [ 'i-op', '-', [ 34, 21 ] ]

    [ 'i-op', 'exp', [ 2, 63 ] ]

    [ 'i-op', '-', [ 9.2, 0.1 ] ]

    [ 'i-op', '/', [ 0b101.01, 0b11.0 ] ]

    [ 'i-op', '~#', [ '-', 80 ] ]

    [ 'i-op', '∈', [ :d<a>, 1..5 ] ]

    [ 'i-op', '∉', [ :d<foo>, :d<min>..^:d<max> ] ]

    [ 'i-op', '∖', [:Set(Set.new( 8, 4, 6, 7 )), :Set(Set.new( 9, 0, 7 ))] ]

    [ 'i-op', '÷', [ '@' => <x y> => Set.new( [ 5, 6 ], [ 3, 6 ] ),
        '@' => Set.new( { y => 6 } ) ] ]

## Simple Monadic Prefix Operators

A `monadic_prefix_op_invo` node has exactly 1 main op arg, which is an
`expr` node.

Examples:

    [ 'pre-op', 'not, Bool::True ]

    [ 'pre-op', 'abs, -23 ]

    [ 'pre-op', 'abs, -4.59 ]

    [ 'pre-op', '#, :Set(Set.new( 5, -1, 2 )) ]

    [ 'pre-op', '%, :d<relvar> ]

    [ 'pre-op', '@, :d<tupvar> ]

## Simple Monadic Postfix Operators

A `monadic_postfix_op_invo` node has exactly 1 main op arg, which is an
`expr` node.

Examples:

    [ 'post-op', '++', 13 ]

    [ 'post-op', '--', 4 ]

    [ 'post-op', '!', 5 ]

## Simple Postcircumfix Operators

A `postcircumfix_op_invo` node has exactly 2-3 main op args, where the
first is an `expr` node that defines the primary input value for the
operator and the other 1-2 provide attribute names that customize the
operation.

Note that for the `[]` op, the `min_index`, `interval_boundary_kind`,
`max_index` are collectively the 2nd main op arg which is an `SPInterval`
node payload that defines an `sp_interval_of.NNInt`.

Examples:

    [ 'post-op', '.{:}', [:d<birthday>, 'date', 'day'] ]

    [ 'post-op', '.{}', [:d<pt>, 'city'] ]

    [ 'post-op', '{<-}', [:d<pt>, {pnum=>'pno', locale=>'city'}] ]

    [ 'post-op', '{<-}', [:d<pr>, {pnum=>'pno', locale=>'city'}] ]

    [ 'post-op', '{:}', [:d<birthday>, 'date', ['year','month']] ]

    [ 'post-op', '{}', [:d<pt>, ['color','city']] ]

    [ 'post-op', '{}', [:d<pr>, ['color','city']] ]

    [ 'post-op', '{}', [:d<pt>, []] ]  # null projection #

    [ 'post-op', '{}', [:d<pr>, []] ]  # null projection #

    [ 'post-op', '{:!}', [:d<rnd_rule>, ['round_meth']] ]  # radix,min_exp #

    [ 'post-op', '{!}', [:d<pt>, ['pno','pname','weight']] ]

    [ 'post-op', '{!}', [:d<pr>, ['pno','pname','weight']] ]

    [ 'post-op', '{%<-}', [:d<person>, 'name', ['fname','lname']] ]

    [ 'post-op', '{%<-}', [:d<people>, 'name', ['fname','lname']] ]

    [ 'post-op', '{%<-!}', [:d<person>,'all_but_name',['fname','lname']] ]

    [ 'post-op', '{%<-!}', [:d<people>,'all_but_name',['fname','lname']] ]

    [ 'post-op', '{<-%}', [:d<person>, ['fname','lname'], 'name'] ]

    [ 'post-op', '{<-%}', [:d<people>, ['fname','lname'], 'name'] ]

    [ 'post-op', '{@<-}', [:d<orders>, 'vendors', ['vendor']] ]

    [ 'post-op', '{@<-!}', [:d<orders>, 'all_but_vendors', ['vendor']] ]

    [ 'post-op', '{<-@}', [:d<orders>, ['vendor'], 'vendors'] ]

    [ 'post-op', '{#@<-!}',
        [:d<people>, 'count_per_age_ctry', ['age','ctry']] ]

    [ 'post-op', '.{*}', :d<maybe_foo> ]

    [ 'post-op', '.[]', [:d<ary>, 3] ]

    [ 'post-op', '[]', [:d<ary>, 10..14] ]

## Numeric Operators That Do Rounding

A `num_op_invo_with_round` node has exactly 2-3 main op args, each of
which is an `expr` node that defines an input value for the operator.
When there are 2 main op args, the first and second args are `expr` and
`round_rule`, respectively.  When there are 3 main op args, the first,
second and third args are `lhs`, `rhs` and `round_rule`, respectively.

Examples:

    [ 'i-op', 'div', [ 5, 3, :RoundMeth<ToZero> ] ]

    [ 'i-op', 'mod', [ 5, 3, :RoundMeth<ToZero> ] ]

    [ 'i-op', 'round', [:d<foo>, :RatRoundRule[10,-2,'HalfEven']] ]

    [ 'i-op', '**', [ 2.0, 0.5, :RatRoundRule[2,-7,'ToZero'] ] ]

    [ 'i-op', 'log', [ 309.1, 5.4, :RatRoundRule[10,-4,'HalfUp'] ] ]

    [ 'pre-op', 'e**, [ 6.3, :RatRoundRule[10,-6,'Up'] ] ]

    [ 'post-op', 'log-e', [ 17.0, :RatRoundRule[3,-5,'Down'] ] ]

## Order Comparison Operators

An `ord_compare_op_invo` node has exactly 2 main op args,
each of which is an `expr` node.  The first and second args are `lhs` and
`rhs`, respectively.  *Details on the extra op args are pending.*

Examples:

    [ 'i-op', '<=>', [ :d<foo>, :d<bar> ] ]

# DEPRECATED - PROCEDURE INVOCATION ALTERNATE SYNTAX STATEMENTS

A `proc_invo_alt_syntax` node has 3-4 ordered elements:  The first element
is one of the 3 Raku `Str` values [`i-op`, `pre-op`, `post-op`],
depending on whether it represents infix, prefix, or postfix syntax,
respectively.  The second element is a Raku `Str` value,
hereafter referred to as *op* or *keyword*, which determines the
procedure to invoke.  The third element is (usually) a Raku
`Seq|Array`, hereafter referred to as *main op args*, which is an ordered
list of 1-N mandatory inputs to the procedure invocation.  The
(optional) fourth element is a Raku `Mapping|Hash`, hereafter referred to
as *extra op args*, which is a named list of optional procedure
inputs.  The number and format of elements of either *main op args* or
*extra op args* varies depending on *op*.  Note that, when a *main op
args* would just contain a single element, such as when it is for a monadic
operator, it may alternately be formatted as what is otherwise just its
sole (node) element iff that node is not formatted as a Raku `Seq|Array`.

## Procedure Simple Monadic Postfix Operators

An `proc_monadic_postfix_op_invo` node has exactly 1 main op arg, which is
an `expr` node.

Examples:

    [ 'post-op', ':=++', :d<counter> ]

    [ 'post-op', ':=--', :d<countdown> ]

## Procedure Simple Non-symmetric Dyadic Infix Operators

A `proc_nonsym_dyadic_infix_op_invo` node has exactly 2 main op args, each
of which is an `expr` node; the first and second main op args are `lhs`
and `rhs`, respectively.

Examples:

    # assign 3 to foo #
    [ 'i-op', ':=', [ :d<foo>, 3 ] ]

    # swap x and y using pseudo-variables #
    [ 'i-op', ':=', [ ['%',{0=>:d<x>,1=>:d<y>}], ['%',{0=>:d<y>,1=>:d<x>}] ] ]

    # delete every person in people whose age is either 10 or 20 #
    [ 'i-op', ':=!matching', [ :d<people>,
        '@' => Set.new( { age => 10 }, { age => 20 } ) ] ]

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Data Language** (**MDL**).

MDL is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
