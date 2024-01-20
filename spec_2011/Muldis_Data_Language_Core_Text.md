# NAME

Muldis Data Language Core Text - Muldis Data Language character string operators

# VERSION

This document is Muldis Data Language Core Text version 0.148.1.

# PREFACE

This document is part of the Muldis Data Language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md);
you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

This document describes essentially all of the core Muldis Data Language operators that
are specific to the core data type `Text`, essentially all the generic
ones that a typical programming language should have.

*This documentation is pending.*

# FUNCTIONS IMPLEMENTING VIRTUAL ORDERED FUNCTIONS

## sys.std.Core.Text.order

`function order (Order <-- topic : Text,
other : Text, misc_args? : Tuple, is_reverse_order? : Bool)
implements sys.std.Core.Ordered.order {...}`

This is a (total) `order-determination` function specific to `Text`.
*TODO: What (optional) `misc_args` does this support?*

# FUNCTIONS IMPLEMENTING VIRTUAL STRINGY FUNCTIONS

## sys.std.Core.Text.catenation

`function catenation (Text <--
topic? : array_of.Text) implements sys.std.Core.Stringy.catenation {...}`

This function results in the catenation of the N element values of its
argument; it is a reduction operator that recursively takes each
consecutive pair of input values and catenates (which is associative) them
together until just one is left, which is the result.  If `topic` has zero
values, then `catenation` results in the empty string value, which is the
identity value for catenation.

## sys.std.Core.Text.replication

`function replication (Text <-- topic : Text,
count : NNInt) implements sys.std.Core.Stringy.replication {...}`

This function results in the catenation of `count` instances of `topic`.

# GENERIC FUNCTIONS FOR TEXTS

These functions implement commonly used character string operations.

## sys.std.Core.Text.cat_with_sep

`function cat_with_sep (Text <--
topic : array_of.Text, sep : Text) {...}`

This function results in the catenation of the N element values of its
`topic` argument such that an instance of its `sep` argument is catenated
between each pair of consecutive `topic` elements.

## sys.std.Core.Text.len_in_nfd_codes

`function len_in_nfd_codes (NNInt <-- topic : Text) {...}`

This function results in the length of its argument in Unicode canonical
decomposed normal form (NFD) abstract code points, or in other words, in the
actual length of the argument since Muldis Data Language explicitly works natively at
the abstract code point abstraction level.

## sys.std.Core.Text.len_in_graphs

`function len_in_graphs (NNInt <-- topic : Text) {...}`

This function results in the length of its argument in language-independent
graphemes.

## sys.std.Core.Text.has_substr

`function has_substr (Bool <-- look_in : Text,
look_for : Text, fixed_start? : Bool, fixed_end? : Bool) {...}`

This function results in `Bool:True` iff its `look_for` argument is a
substring of its `look_in` argument as per the optional `fixed_start` and
`fixed_end` constraints, and `Bool:False` otherwise.  If `fixed_start`
or `fixed_end` are `Bool:True`, then `look_for` must occur right at the
start or end, respectively, of `look_in` in order for `contains` to
result in `Bool:True`; if either flag is `Bool:False`, its additional
constraint doesn't apply.  Each of the `fixed_[start|end]` parameters is
optional and defaults to `Bool:False` if no explicit argument is given to
it.  Note that `has_substr` will handle the common special cases of SQL's
"LIKE" operator for patterns like ['foo', '%foo', 'foo%', '%foo%'], but see
also the `is_like` function which provides the full generality
of SQL's "LIKE", such as 'foo%bar%baz'.

## sys.std.Core.Text.has_not_substr

`function has_not_substr (Bool <-- look_in : Text,
look_for : Text, fixed_start? : Bool, fixed_end? : Bool) {...}`

This function is exactly the same as `sys.std.Core.Text.has_substr` except
that
it results in the opposite boolean value when given the same arguments.

# FUNCTIONS FOR TEXT NORMALIZATION

These functions implement commonly used text normalization operations which
are relatively simple or whose details are fully specified by the Unicode
standard; examples are folding letters to lower or upper case, removing
combining characters like accent marks and other diacritics from base
letters, or removing or normalizing whitespace, or that convert text from a
larger to a smaller character repertoire such as to ASCII.  By contrast,
operations such as stemming or removing common words or expanding
abbreviations are not done by these functions and are best implemented by a
third party language extension or library.  You can use these functions as
a basis for making comparison or ranking or collation operators that ignore
some distinctions between values such as their case or marks, such as to
do case-insensitive or mark-insensitive or whitespace-insensitive
matching or indexing or sorting; the actual system-defined matching
operators are still sensitive to case et al, but you can pretend they're
not by having them work with the results of these normalization functions
rather than on the inputs to these functions.  This is useful when you want
to emulate the semantics of insensitive though possibly preserving systems
over Muldis Data Language.

## sys.std.Core.Text.upper

`function upper (Text <-- topic : Text) {...}`

This function results in the normalization of its argument where any
letters considered to be (small) lowercase are folded to (capital)
uppercase.

## sys.std.Core.Text.lower

`function lower (Text <-- topic : Text) {...}`

This function results in the normalization of its argument where any
letters considered to be (capital) uppercase are folded to (small)
lowercase.

## sys.std.Core.Text.marks_stripped

`function marks_stripped (Text <-- topic : Text) {...}`

This function results in the normalization of its argument where any accent
marks or diacritics are removed from letters, leaving just the primary
letters.

## sys.std.Core.Text.ASCII

`function ASCII (Text <-- topic : Text, mark? : Text) {...}`

This function results in the normalization of its `topic` argument where
any characters not in the 7-bit ASCII repertoire are stripped out, where
each non-ASCII character is replaced with the common ASCII character string
specified by its `mark` argument; if `mark` is the empty string, then the
non-ASCII characters are simply stripped.  This function is quite simple
and does not do a smart replace with sequences of similar looking ASCII
characters.  The `mark` parameter is optional and defaults to the empty
string if no explicit argument is given to it.

## sys.std.Core.Text.trim

`function trim (Text <-- topic : Text) {...}`

This function results in the normalization of its argument where any
leading or trailing whitespace characters are trimmed, but no other changes
are made, including to any whitespace bounded by non-whitespace characters.

# FUNCTIONS FOR PATTERN MATCHING AND TRANSLITERATION

These functions implement commonly used operations for matching text
against a pattern or performing substitutions of characters for others;
included are both the functionality of SQL's simple "LIKE" pattern matching
operator but also support for Perl's regular expressions and Raku's
rules.  All of these functions are case-sensitive et al as per
`is_same` unless explicitly given flags to do otherwise, where
applicable; or just use them to search results of normalization functions
if you need to.  Note that Perl 5.10+ is also an inspiration such that its
regular expression feature is algorithm-agnositic and can both be plugined
with new algorithms or have multiple system-defined ones.  *Note that a
lot of this section is still TODO, with several useful functions missing,
or more complicated parts like the Perl pattern matching may be separated
off into their own language extensions later.*
*ACTUALLY, EACH NON-TRIVIAL PATTERN-MATCHING WILL BE ITS OWN OPTIONAL
EXTENSION, SO ONE FOR RAKU RULES, ONE FOR PERL REGEX, 1 PER OTHER REGEX
KIND, ETC.  CORE KEEPS THE TRIVIALLY SIMPLE 'LIKE' OF SQL.*

## sys.std.Core.Text.is_like

`function is_like (Bool <-- look_in : Text,
look_for : Text, escape? : Text) {...}`

This function results in `Bool:True` iff its `look_in` argument is
matched by the pattern given in its `look_for` argument, and `Bool:False`
otherwise.  This function implements the full generalization of SQL's
simple "LIKE" pattern matching operator.  Any characters in `look_for` are
matched literally except for the 2 wildcard characters `_` (match any
single character) and `%` (match any string of 0..N characters); the
preceeding assumes that the `escape` argument is the empty string (or is
missing).  If `escape` is a character, then that character is also special
and its lone occurrence in `look_for` will no longer match itself as per
the 2 wildcard characters; rather it will be used in `look_for` to
indicate when the pattern wishes to match a literal `_` or `%` or the
escape character itself literally.  For example, if `\` is used as the
escape character, then you use `\_`, `\%`, `\\` to match the literal
wildcard characters or itself, respectively.  Note that this operation is
also known as *is match using like* or `like`.

## sys.std.Core.Text.is_not_like

`function is_not_like (Bool <-- look_in : Text,
look_for : Text, escape? : Text) {...}`

This function is exactly the same as `sys.std.Core.Text.is_like`
except that it results in the opposite boolean value when given the same
arguments; it implements SQL's "NOT LIKE".  Note that this operation is
also known as *is not match using like* or `!like` or `not-like`.

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Data Language** (**MDL**).

MDL is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of
[Muldis_Data_Language](Muldis_Data_Language.md) for details.
