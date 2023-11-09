# NAME

Muldis Data Language Conventions - Style and design guidelines for Muldis Data Language

# VERSION

This document is Muldis Data Language Conventions version 0.148.1.

# PREFACE

This document is part of the Muldis Data Language language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document
before you read this one, which provides subservient details.

# DESCRIPTION

This document briefly outlines various conventions used in the Muldis Data Language
language, and provides some style and design recommendations for code
and/or projects written in Muldis Data Language, or for alternate language dialects, or
extensions, or implementations.

Unlike the rest of the Muldis Data Language language specification, following anything
stated herein is not necessary for conformation to the spec, and you should
feel free to break these suggestions whenever it makes sense, just like
when using any style rules.

This document is very much an early draft, and for not just contains a bit
of brainstorming in point form.

# GUIDELINES

## Entity Naming

Note that any use of the word "name" specifically refers to a `Name`, or
in other words the declared unqualified name of an entity, which sometimes
is always used in that form, and which other times forms an element of a
`NameChain`.

Although Muldis Data Language allows names to be comprised of any characters at all,
and hence they are used delimited in the general case, it is highly
recommended to use only characters in names that are valid for identifier
names in most programming languages, and that are part of the 7-bit ASCII
repertoire, such as `[a-zA-Z0-9_]`, and that the first character of a name
isn't a digit; that way, it would be easy to support Muldis Data Language dialects
where names are allowed to be non-delimited, as well as more easily permit
translation of Muldis Data Language code into other programming languages while making
fewer changes.  Or if your system is Unicode-saavy (Raku for example),
then the recommendation can be broadened to allow the word characters of
any script, but names should still avoid including whitespace and
punctuation characters.

Type names should all be nouns, or nouns plus adjectives of said, and be
named after what a value of that type *is*; eg, for any given value Foo of
type Bar, you can say "Foo is a Bar".

Type names should have all of their words capitalized (first letter of each
word is uppercase, other letters of each word are lowercase.  It is
suggested that the words directly adjoin each other without separator
characters, but use of separators is also fine.  In other words, see the
convention for Perl package names, perhaps aka camel case.  But if the type
name includes acronyms, then the acronym should be all uppercase, and where
necessary, multiple acronyms or abbreviations would then often be
underscore-separated.  For examples, `Int` or `RatRoundRule`.

Function routine names should all be nouns, and be named after the meaning
of what they result in; also, function parameters should all be nouns, and
be named after the meaning of what they convey to the functions.  For
example, the integer `difference` function results in the difference when
its `subtrahend` argument is subtracted from its `minuend` argument.
Every invocation of a function in Muldis Data Language denotes a value, just like any
program literal, and it is helpful for it to be named accordingly.  A
function name should never be a verb, as a function does not take an action
or *do* something or have a side-effect; its invocation *is* something.
Likewise, all named expression names should be nouns.

For a boolean-resulting function, the function name typically is best the
text of a question whose answer is just *yes* or *no*; for example,
`is_same` or `is_a_member`.  While not a noun per se, such names
indicate that the meaning of the function's result is the answer of the
question as applied to the function's arguments.

For functions that are best described as deriving Foo from Bar, such as
between numbers and strings, they should be named with the result coming
first in the name and the input coming second, like Foo_from_Bar; do not
use names like Bar_to_Foo.  If the convention of prefix/polish notation is
also followed, then each part of the function's name is next to what it is
describing (output closer to output, input to input, etc), not opposite.

Procedure routine names, by contrast, should all be verbs, and
be named after what action they take, because their invocation *does* do
something and/or has a side-effect, and does *not* denote a value.  For
example, `fail` or `create_function`.  Their parameters should be nouns
as per function routines.  Their variables should also be nouns.

If a routine has just one main parameter, and/or the routine could be
conceived as a method for an object that is that argument, and there isn't
already a good name for the parameter, then `topic` is a good name to
default to; it says that this argument is the topic that the routine is
most concerned with, as per what `$_` means to Perl (a topicalizer).

All routine names should have their words separated by underscores, and
they generally should be entirely lowercase.  The main exception to this is
if the routine name embeds a type name, in which case the type should be
spelled with its normal casing, such as `Int_from_Text`.

When a relation is best described as being a plurality of a kind of thing,
where each of its tuples is exactly one of those things, then any contexts
working with such relations should name the whole relation in the plural
form, not the singular form.  For example, if each tuple of a relation
represents either a person or a business, then a relvar of that relation's
type should have a name like "people" or "businesses" rather than "person"
or "business"; similarly, the relation type of that relvar might be
"People" or "Businesses" while the tuple type which that relation type is
defined partly in terms of might be "Person" and "Business".

When defining a pair of closely related types where one of the types is a
relation type and the other type is the tuple type over which that relation
type is directly partially defined, then:  1.  If one of the types is
clearly dominant over the other in terms of importance or likelihood to be
used as the declared type of anything (most likely the relation type), and
especially if it would be a challenge to name the subservient type, then
the pair should be grouped together under their own subdepot, such that the
subdepot has the conceptual name of the dominant type (and is referenced
directly by users as a proxy for said), and the dominant type's actual name
under that subdepot's namespace is the empty string, and the subservient
type's name under that namespace is either `T` or `R` depending on
whether it is a tuple or relation type.  For example, given the
system-defined relation type `Array`, that type's actual name is
`Array.""` and the tuple type it is partly defined over is named
`Array.T`.  2.  If the two types have a mutually even status, and it would
be relatively easy to name both of them, then the pair should live out in a
more public namespace, each directly under their conceptual names.

## Defaults and Options

When defining a routine parameter or type attribute that is expected to
have the same single value in a majority of usage scenarios, and that users
would generally conceive that they shouldn't have to explicitly specify a
value for that parameter or attribute when it would be that common value,
then you should give the parameter or attribute an appropriate name and
declared type such that the single default value of the declared type is
the same as the common value in question; for a parameter, typically it
should also be marked as optional.

Similarly, if a certain attribute or parameter would be considered
non-applicable or ignorable under certain circumstances, such as defined by
neighboring parameters or circumstances, then said ignorables should be
named and typed such that their declared type gives them a default value
that is best for use when it should be ignored.

One example is a binary choice encoded as a boolean value; the boolean
parameter or attribute can be named after the infrequent choice such that
giving it a true value will pick the infrequent choice and letting it
default to the false value (`Bool:False` is the default value of the
`Bool` type) will pick the frequent choice.

Generally speaking, the default value of a type should correspond most
closely to its concept of *empty*, unless there is no such concept in the
type.  So for string types this would mean the empty string, or for
collection types, one with no elements, or for numeric types, the value
zero.

When declaring a scalar root type that has exactly one possrep, the name
of that possrep should be the empty string, which makes it easier for that
possrep to be referred to by default in contexts where a possrep name is
optional to specify.  By contrast, when declaring a scalar root type that
has at least 2 possreps of its own, none of the possreps should have the
empty string as their name.  When declaring a scalar subtype that adds
one or more extra possreps, none of the added possreps should have the
empty string as its name.  On the other hand, don't be hesitant to just use
a non-empty name even when there is just one possrep, if that name results
in better self-documentation of the type and its value selections.

## Syntax Ordering

Muldis Data Language internally (that is, in the system catalog) organizes parts of
syntax by name rather than by order, so in that respect the language is not
specifically prefix/polish or postfix/reverse-polish or infix or circumfix,
and a Muldis Data Language dialect can take any of those forms or mix them.  You can
even write your code right-to-left if you want, assuming a compatible
parser.

That said, the recommended convention is to use prefix/polish notation
conceptually, or actually if the dialect makes a distinction.  So for
example, in a value expression, the result comes out on the left side and
the inputs go in on the right side.  At least this is assuming you normally
read left-to-right.  But even if you don't, practically all programming
languages are oriented left-to-right anyway, and we can follow that.

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Data Language** (**MDL**).

MDL is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
