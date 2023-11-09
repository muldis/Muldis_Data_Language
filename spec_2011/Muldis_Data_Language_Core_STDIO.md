# NAME

Muldis::D::Core::STDIO - Muldis D routines for basic command-line user I/O

# VERSION

This document is Muldis::D::Core::STDIO version 0.148.1.

# PREFACE

This document is part of the Muldis D language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

This document defines all of the core Muldis D routines that provide
basic command-line user input/output.

*This documentation is pending.*

# GENERIC SYSTEM-SERVICES FOR STANDARD I/O

These system-services are provided so Muldis D can do basic user
input/output by itself, using standard input and standard output, like any
general purpose programming language, and help satisfy its need to be
computationally complete.  For now they just work with plain (Unicode) text
data, so one can implement a basic command-line program interface, or do
basic invoker-setup file piping, as well as display diagnostics to standard
error.  These routines are not exhaustive, and their details are subject to
future revision.

## sys.std.Core.STDIO.end_of_line_Text

C<system-service end_of_line_Text (&target : Text)
[...]>

This system-service routine will update the variable supplied as its
`target` argument so that it holds the same implementation-defined
end-of-line character or character sequence that `write_Text_line` appends
to its output, and that `read_Text_line` looks out for to terminate its
input.  The purpose of this routine is to support users that want to
catenate Text within Muldis D for output with a single `write_Text` that
is intended to display over multiple implementation-defined lines.

## sys.std.Core.STDIO.read_Text

C<system-service read_Text (&target : Text,
len_in_graphs : NNInt) [...]>

This system-service routine will attempt to read `len_in_graphs`
characters from standard input as a single `Text` value, blocking the
current in-DBMS process until it finishes, and then update the variable
supplied as its `target` argument so that it holds the read value.  The
routine will only fetch fewer than the requested number of characters if
the input stream is closed first.  This routine will throw an exception if
any system errors occur.

## sys.std.Core.STDIO.read_Text_line

C<system-service read_Text_line (&target : Text,
ignore_empty_lines? : Bool) [...]>

This system-service routine is the same as `sys.std.Core.STDIO.read_Text`
except that it will read from standard input until an
implementation-defined end-of-line character is read, rather than reading a
fixed number of characters; this end-of-line character will not be included
in the read `Text` value.  If the `ignore_empty_lines` argument is
`Bool:True`, then this routine will keep reading lines from standard input
until it reads a non-empty line, and then `target` is only updated to hold
that last non-empty line; otherwise, this routine will end as soon as one
line is read, even if it is empty.

## sys.std.Core.STDIO.write_Text

C<system-service write_Text (v : Text) [...]>

This system-service routine will attempt to write the characters of its
`v` argument to standard output, blocking the current in-DBMS process
until it finishes.  This routine will throw an exception if any system
errors occur.

## sys.std.Core.STDIO.write_Text_line

C<system-service write_Text_line (v? : Text) [...]>

This system-service routine is the same as `sys.std.Core.STDIO.write_Text`
except that it will additionally write an implementation-defined
end-of-line character after writing `v`.  If the `v` argument is omitted,
then this routine simply writes the end-of-line.

## sys.std.Core.STDIO.prompt_Text_line

C<system-service prompt_Text_line (&target : Text,
prompt : Text, ignore_empty_lines? : Bool ) [...]>

This system-service routine is a wrapper over first invoking
`sys.std.Core.STDIO.write_Text` with its `prompt` argument and then
invoking `sys.std.Core.STDIO.read_Text_line` with its `target` argument.
A true `ignore_empty_lines` argument will result in *both* of the wrapped
routines being invoked repeatedly, not just `read_text_line`.

## sys.std.Core.STDIO.error_Text

C<system-service error_Text (v : Text) [...]>

This system-service routine is the same as `sys.std.Core.STDIO.write_Text`
except that it will write to standard error rather than standard output.

## sys.std.Core.STDIO.error_Text_line

C<system-service error_Text_line (v? : Text) [...]>

This system-service routine is the same as
`sys.std.Core.STDIO.write_Text_line` except that it will write to standard
error rather than standard output.

# AUTHOR

Darren Duncan (`darren@DarrenDuncan.net`)

# LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
