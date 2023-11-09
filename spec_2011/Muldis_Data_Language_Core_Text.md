=pod

=encoding utf8

=head1 NAME

Muldis::D::Core::Text - Muldis D character string operators

=head1 VERSION

This document is Muldis::D::Core::Text version 0.148.1.

=head1 PREFACE

This document is part of the Muldis D language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

=head1 DESCRIPTION

This document describes essentially all of the core Muldis D operators that
are specific to the core data type C<Text>, essentially all the generic
ones that a typical programming language should have.

I<This documentation is pending.>

=head1 FUNCTIONS IMPLEMENTING VIRTUAL ORDERED FUNCTIONS

=head2 sys.std.Core.Text.order

C<< function order (Order <-- topic : Text,
other : Text, misc_args? : Tuple, is_reverse_order? : Bool)
implements sys.std.Core.Ordered.order {...} >>

This is a (total) C<order-determination> function specific to C<Text>.
I<TODO: What (optional) C<misc_args> does this support?>

=head1 FUNCTIONS IMPLEMENTING VIRTUAL STRINGY FUNCTIONS

=head2 sys.std.Core.Text.catenation

C<< function catenation (Text <--
topic? : array_of.Text) implements sys.std.Core.Stringy.catenation {...} >>

This function results in the catenation of the N element values of its
argument; it is a reduction operator that recursively takes each
consecutive pair of input values and catenates (which is associative) them
together until just one is left, which is the result.  If C<topic> has zero
values, then C<catenation> results in the empty string value, which is the
identity value for catenation.

=head2 sys.std.Core.Text.replication

C<< function replication (Text <-- topic : Text,
count : NNInt) implements sys.std.Core.Stringy.replication {...} >>

This function results in the catenation of C<count> instances of C<topic>.

=head1 GENERIC FUNCTIONS FOR TEXTS

These functions implement commonly used character string operations.

=head2 sys.std.Core.Text.cat_with_sep

C<< function cat_with_sep (Text <--
topic : array_of.Text, sep : Text) {...} >>

This function results in the catenation of the N element values of its
C<topic> argument such that an instance of its C<sep> argument is catenated
between each pair of consecutive C<topic> elements.

=head2 sys.std.Core.Text.len_in_nfd_codes

C<< function len_in_nfd_codes (NNInt <-- topic : Text) {...} >>

This function results in the length of its argument in Unicode canonical
decomposed normal form (NFD) abstract code points, or in other words, in the
actual length of the argument since Muldis D explicitly works natively at
the abstract code point abstraction level.

=head2 sys.std.Core.Text.len_in_graphs

C<< function len_in_graphs (NNInt <-- topic : Text) {...} >>

This function results in the length of its argument in language-independent
graphemes.

=head2 sys.std.Core.Text.has_substr

C<< function has_substr (Bool <-- look_in : Text,
look_for : Text, fixed_start? : Bool, fixed_end? : Bool) {...} >>

This function results in C<Bool:True> iff its C<look_for> argument is a
substring of its C<look_in> argument as per the optional C<fixed_start> and
C<fixed_end> constraints, and C<Bool:False> otherwise.  If C<fixed_start>
or C<fixed_end> are C<Bool:True>, then C<look_for> must occur right at the
start or end, respectively, of C<look_in> in order for C<contains> to
result in C<Bool:True>; if either flag is C<Bool:False>, its additional
constraint doesn't apply.  Each of the C<fixed_[start|end]> parameters is
optional and defaults to C<Bool:False> if no explicit argument is given to
it.  Note that C<has_substr> will handle the common special cases of SQL's
"LIKE" operator for patterns like ['foo', '%foo', 'foo%', '%foo%'], but see
also the C<is_like> function which provides the full generality
of SQL's "LIKE", such as 'foo%bar%baz'.

=head2 sys.std.Core.Text.has_not_substr

C<< function has_not_substr (Bool <-- look_in : Text,
look_for : Text, fixed_start? : Bool, fixed_end? : Bool) {...} >>

This function is exactly the same as C<sys.std.Core.Text.has_substr> except
that
it results in the opposite boolean value when given the same arguments.

=head1 FUNCTIONS FOR TEXT NORMALIZATION

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
over Muldis D.

=head2 sys.std.Core.Text.upper

C<< function upper (Text <-- topic : Text) {...} >>

This function results in the normalization of its argument where any
letters considered to be (small) lowercase are folded to (capital)
uppercase.

=head2 sys.std.Core.Text.lower

C<< function lower (Text <-- topic : Text) {...} >>

This function results in the normalization of its argument where any
letters considered to be (capital) uppercase are folded to (small)
lowercase.

=head2 sys.std.Core.Text.marks_stripped

C<< function marks_stripped (Text <-- topic : Text) {...} >>

This function results in the normalization of its argument where any accent
marks or diacritics are removed from letters, leaving just the primary
letters.

=head2 sys.std.Core.Text.ASCII

C<< function ASCII (Text <-- topic : Text, mark? : Text) {...} >>

This function results in the normalization of its C<topic> argument where
any characters not in the 7-bit ASCII repertoire are stripped out, where
each non-ASCII character is replaced with the common ASCII character string
specified by its C<mark> argument; if C<mark> is the empty string, then the
non-ASCII characters are simply stripped.  This function is quite simple
and does not do a smart replace with sequences of similar looking ASCII
characters.  The C<mark> parameter is optional and defaults to the empty
string if no explicit argument is given to it.

=head2 sys.std.Core.Text.trim

C<< function trim (Text <-- topic : Text) {...} >>

This function results in the normalization of its argument where any
leading or trailing whitespace characters are trimmed, but no other changes
are made, including to any whitespace bounded by non-whitespace characters.

=head1 FUNCTIONS FOR PATTERN MATCHING AND TRANSLITERATION

These functions implement commonly used operations for matching text
against a pattern or performing substitutions of characters for others;
included are both the functionality of SQL's simple "LIKE" pattern matching
operator but also support for Perl's regular expressions and Raku's
rules.  All of these functions are case-sensitive et al as per
C<is_same> unless explicitly given flags to do otherwise, where
applicable; or just use them to search results of normalization functions
if you need to.  Note that Perl 5.10+ is also an inspiration such that its
regular expression feature is algorithm-agnositic and can both be plugined
with new algorithms or have multiple system-defined ones.  I<Note that a
lot of this section is still TODO, with several useful functions missing,
or more complicated parts like the Perl pattern matching may be separated
off into their own language extensions later.>
I<ACTUALLY, EACH NON-TRIVIAL PATTERN-MATCHING WILL BE ITS OWN OPTIONAL
EXTENSION, SO ONE FOR RAKU RULES, ONE FOR PERL REGEX, 1 PER OTHER REGEX
KIND, ETC.  CORE KEEPS THE TRIVIALLY SIMPLE 'LIKE' OF SQL.>

=head2 sys.std.Core.Text.is_like

C<< function is_like (Bool <-- look_in : Text,
look_for : Text, escape? : Text) {...} >>

This function results in C<Bool:True> iff its C<look_in> argument is
matched by the pattern given in its C<look_for> argument, and C<Bool:False>
otherwise.  This function implements the full generalization of SQL's
simple "LIKE" pattern matching operator.  Any characters in C<look_for> are
matched literally except for the 2 wildcard characters C<_> (match any
single character) and C<%> (match any string of 0..N characters); the
preceeding assumes that the C<escape> argument is the empty string (or is
missing).  If C<escape> is a character, then that character is also special
and its lone occurrence in C<look_for> will no longer match itself as per
the 2 wildcard characters; rather it will be used in C<look_for> to
indicate when the pattern wishes to match a literal C<_> or C<%> or the
escape character itself literally.  For example, if C<\> is used as the
escape character, then you use C<\_>, C<\%>, C<\\> to match the literal
wildcard characters or itself, respectively.  Note that this operation is
also known as I<is match using like> or C<like>.

=head2 sys.std.Core.Text.is_not_like

C<< function is_not_like (Bool <-- look_in : Text,
look_for : Text, escape? : Text) {...} >>

This function is exactly the same as C<sys.std.Core.Text.is_like>
except that it results in the opposite boolean value when given the same
arguments; it implements SQL's "NOT LIKE".  Note that this operation is
also known as I<is not match using like> or C<!like> or C<not-like>.

=head1 AUTHOR

Darren Duncan (C<darren@DarrenDuncan.net>)

=head1 LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.

=cut
