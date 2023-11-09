# NAME

Muldis::D::Core::Stringy - Muldis D generic stringy operators

# VERSION

This document is Muldis::D::Core::Stringy version 0.148.1.

# PREFACE

This document is part of the Muldis D language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

This document describes essentially all of the core Muldis D
stringy operators, essentially all the generic ones that a
typical programming language should have.

I<This documentation is pending.>

# VIRTUAL FUNCTIONS FOR THE STRINGY MIXIN TYPE

## sys.std.Core.Stringy.catenation

C<< function catenation (Stringy <-- topic@ : array_of.Stringy) {...} >>

This virtual function results in the catenation of the N element values of
its argument; it is a reduction operator that recursively takes each
consecutive pair of input values and catenates (which is associative) them
together until just one is left, which is the result.  Conceptually, if
C<topic> has zero values, then C<catenation> results in the empty string or
empty sequence, which is the identity value for catenation; however, while
each implementing function of C<catenation> could actually result in a
type-specific value of the empty string or empty sequence, this virtual
function itself will instead fail when C<topic> has zero values, because
then it would lack the necessary type information to know which
type-specific implementing function to dispatch to.  Note that this
operation is also known as C<~>.

## sys.std.Core.Stringy.replication

C<< function replication (Stringy <--
topic@ : Stringy, count : NNInt) {...} >>

This virtual function results in the catenation of C<count> instances of
C<topic>.  Note that this operation is also known as C<~#>.

# AUTHOR

Darren Duncan (C<darren@DarrenDuncan.net>)

# LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
