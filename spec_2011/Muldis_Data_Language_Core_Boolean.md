# NAME

Muldis::D::Core::Boolean - Muldis D boolean logic operators

# VERSION

This document is Muldis::D::Core::Boolean version 0.148.1.

# PREFACE

This document is part of the Muldis D language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

This document describes essentially all of the core Muldis D operators that
are specific to the core data type C<Bool>, a superset of all the generic
ones that a typical programming language should have.

I<This documentation is pending.>

# FUNCTIONS IMPLEMENTING VIRTUAL ORDERED FUNCTIONS

## sys.std.Core.Boolean.order

`function order (Order <-- topic : Bool,
other : Bool, misc_args? : Tuple, is_reverse_order? : Bool)
implements sys.std.Core.Ordered.order {...}`

This is a (total) C<order-determination> function specific to C<Bool>.  Its
only valid C<misc_args> argument is C<Tuple:D0>.

# FUNCTIONS IMPLEMENTING VIRTUAL ORDINAL FUNCTIONS

## sys.std.Core.Boolean.pred

`function pred (Bool <-- topic : Bool)
implements sys.std.Core.Ordered.Ordinal.pred {...}`

This function results in the value that precedes its argument.  It results
in C<Bool:False> iff its argument is C<Bool:True>, and C<-Inf> otherwise.

## sys.std.Core.Boolean.succ

`function succ (Bool <-- topic : Bool)
implements sys.std.Core.Ordered.Ordinal.succ {...}`

This function results in the value that succeeds its argument.  It results
in C<Bool:True> iff its argument is C<Bool:False>, and C<Inf> otherwise.

# FUNCTIONS FOR BOOLEAN LOGIC

These functions implement commonly used boolean logic operations.

## sys.std.Core.Boolean.not

`function not (Bool <-- topic : Bool) {...}`

This function results in the logical I<not> of its argument.  This function
results in C<Bool:True> iff its argument is C<Bool:False>, and
C<Bool:False> otherwise.  Note that this operation is also known as
I<negation> or C<¬> or (prefix) C<!>.

There also exists conceptually the logical monadic operation called I<so>
or I<proposition> which results simply in its argument; this is the
complement operation of I<not> or I<negation>.  Now in practice any value
expression that is an invocation of I<so> can simply be replaced with its
argument, so there is no reason for I<so> to exist as an actual function.

## sys.std.Core.Boolean.and

`function and (Bool <-- topic? : set_of.Bool) {...}`

This function is a reduction operator that recursively takes each pair of
its N input element values and does a logical I<and> (which is commutative,
associative, and idempotent) on them until just one is left, which is the
function's result.  For each pair of input values, the I<and> of that pair
is C<Bool:True> iff both input values are C<Bool:True>, and C<Bool:False>
otherwise.  If C<topic> has zero values, then C<and> results in
C<Bool:True>, which is the identity value for logical I<and>.  Note that
this operation is also known as I<all> or I<every> or I<conjunction> or
C<∧>.

## sys.std.Core.Boolean.all

`function all (Bool <-- topic? : set_of.Bool) {...}`

This function is an alias for C<sys.std.Core.Boolean.and>.  This function
results in C<Bool:True> iff all of its input element values are
C<Bool:True> (or it has no input values), and C<Bool:False> otherwise (when
it has at least one input value that is C<Bool:False>).

## sys.std.Core.Boolean.nand

`function nand (Bool <-- topic : Bool, other : Bool) {...}`

This symmetric function results in C<Bool:False> iff its 2
arguments are both C<Bool:True>, and C<Bool:True> otherwise.  Note that
this operation is also known as I<not and> or I<not both> or I<alternative
denial> or C<⊼> or C<↑>.

## sys.std.Core.Boolean.or

`function or (Bool <-- topic? : set_of.Bool) {...}`

This function is a reduction operator that recursively takes each pair of
its N input element values and does a logical inclusive-or (which is
commutative, associative, and idempotent) on them until just one is left,
which is the function's result.  For each pair of input values, the I<or>
of that pair is C<Bool:False> iff both input values are C<Bool:False>, and
C<Bool:True> otherwise.  If C<topic> has zero values, then C<or> results in
C<Bool:False>, which is the identity value for logical inclusive-or.  Note
that this operation is also known as I<any> or I<some> or I<disjunction> or
C<∨>.

## sys.std.Core.Boolean.any

`function any (Bool <-- topic? : set_of.Bool) {...}`

This function is an alias for C<sys.std.Core.Boolean.or>.  This function
results in C<Bool:True> iff any of its input element values are
C<Bool:True>, and C<Bool:False> otherwise (when all of its input values are
C<Bool:False> or if it has no input values).

## sys.std.Core.Boolean.nor

`function nor (Bool <-- topic : Bool, other : Bool) {...}`

This symmetric function results in C<Bool:True> iff its 2
arguments are both C<Bool:False>, and C<Bool:False> otherwise.  Note that
this operation is also known as I<not or> or I<neither ... nor> or I<joint
denial> or C<⊽> or C<↓>.

## sys.std.Core.Boolean.xnor

`function xnor (Bool <-- topic? : bag_of.Bool) {...}`

This function is a reduction operator that recursively takes each pair of
its N input element values and does a logical xnor (which is both
commutative and associative) on them until just one is left, which is the
function's result.  For each pair of input values, the I<xnor> of that pair
is C<Bool:True> iff both input values are exactly the same value, and
C<Bool:False> otherwise.  If C<topic> has zero values, then C<xnor> results
in C<Bool:True>, which is the identity value for logical xnor.  Note that
this operation is also known as I<not xor> or I<iff> (I<if and only if>) or
I<material equivalence> or I<biconditional> or I<equivalent> (dyadic usage)
or I<even parity> or C<↔>.  Note that a dyadic (2 input value) invocation
of C<xnor> is exactly the same operation as a
C<sys.std.Core.Universal.is_same> invocation whose arguments are both
C<Bool>-typed.

## sys.std.Core.Boolean.iff

`function iff (Bool <-- topic? : bag_of.Bool) {...}`

This function is an alias for C<sys.std.Core.Boolean.xnor>.

## sys.std.Core.Boolean.xor

`function xor (Bool <-- topic? : bag_of.Bool) {...}`

This function is a reduction operator that recursively takes each pair of
its N input element values and does a logical exclusive-or (which is both
commutative and associative) on them until just one is left, which is the
function's result.  For each pair of input values, the I<xor> of that pair
is C<Bool:False> iff both input values are exactly the same value, and
C<Bool:True> otherwise.  If C<topic> has zero values, then C<xor> results
in C<Bool:False>, which is the identity value for logical exclusive-or.
Note that this operation is also known as I<exclusive disjunction> or
I<not equivalent> (dyadic usage) or I<odd parity> or C<⊻> or C<↮>.  Note
that a dyadic (2 input value) invocation of C<xor> is exactly the same
operation as a C<sys.std.Core.Universal.is_not_same> invocation whose
arguments are both C<Bool>-typed.

## sys.std.Core.Boolean.imp

`function imp (Bool <-- topic : Bool, other : Bool) {...}`

This function results in C<Bool:False> iff its C<topic> argument is
C<Bool:True> and its C<other> argument is C<Bool:False>, and C<Bool:True>
otherwise.  Note that this operation is also known as I<implies> or
I<material implication> or C<→>.

## sys.std.Core.Boolean.implies

`function implies (Bool <-- topic : Bool, other : Bool) {...}`

This function is an alias for C<sys.std.Core.Boolean.imp>.

## sys.std.Core.Boolean.nimp

`function nimp (Bool <-- topic : Bool, other : Bool) {...}`

This function is exactly the same as C<sys.std.Core.Boolean.imp> except
that it results in the opposite boolean value when given the same
arguments.  Note that this operation is also known as I<not implies> or
I<material nonimplication> or C<↛>.

## sys.std.Core.Boolean.if

`function if (Bool <-- topic : Bool, other : Bool) {...}`

This function is an alias for C<sys.std.Core.Boolean.imp> except that it
transposes the C<topic> and C<other> arguments.  This function results in
C<Bool:False> iff its C<topic> argument is C<Bool:False> and its C<other>
argument is C<Bool:True>, and C<Bool:True> otherwise.  Note that this
operation is also known as I<converse implication> or I<reverse material
implication> or C<←>.

## sys.std.Core.Boolean.nif

`function nif (Bool <-- topic : Bool, other : Bool) {...}`

This function is exactly the same as C<sys.std.Core.Boolean.if> except that
it results in the opposite boolean value when given the same arguments.
Note that this operation is also known as I<not if> or I<converse
nonimplication> or C<↚>.

## sys.std.Core.Boolean.not_all

`function not_all (Bool <-- topic? : set_of.Bool) {...}`

This function is exactly the same as C<sys.std.Core.Boolean.all> except
that it results in the opposite boolean value when given the same argument.
This function results in C<Bool:True> iff not all of its input element
values are C<Bool:True>, and C<Bool:False> otherwise (when all of its input
values are C<Bool:True> or if it has no input values).

## sys.std.Core.Boolean.none

`function none (Bool <-- topic? : set_of.Bool) {...}`

This function is exactly the same as C<sys.std.Core.Boolean.any> except
that it results in the opposite boolean value when given the same argument.
This function results in C<Bool:True> iff none of its input element values
are C<Bool:True> (or it has no input values), and C<Bool:False> otherwise
(when it has at least one input value that is C<Bool:True>).  Note that
this operation is also known as I<not any>.

## sys.std.Core.Boolean.not_any

`function not_any (Bool <-- topic? : set_of.Bool) {...}`

This function is an alias for C<sys.std.Core.Boolean.none>.

## sys.std.Core.Boolean.one

`function one (Bool <-- topic? : bag_of.Bool) {...}`

This function results in C<Bool:True> iff exactly one of its input element
values is C<Bool:True>, and C<Bool:False> otherwise.  Note that in some
contexts, this operation would alternately be known as I<xor>, but in
Muldis D it is not.

## sys.std.Core.Boolean.not_one

`function not_one (Bool <-- topic? : bag_of.Bool) {...}`

This function is exactly the same as C<sys.std.Core.Boolean.one> except
that it results in the opposite boolean value when given the same argument.

## sys.std.Core.Boolean.exactly

`function exactly (Bool <-- topic? : bag_of.Bool, count : NNInt) {...}`

This function results in C<Bool:True> iff the count of its input element
values that are C<Bool:True> matches the C<count> argument, and
C<Bool:False> otherwise.

## sys.std.Core.Boolean.not_exactly

`function not_exactly (Bool <--
topic? : bag_of.Bool, count : NNInt) {...}`

This function is exactly the same as C<sys.std.Core.Boolean.exactly> except
that it results in the opposite boolean value when given the same argument.

## sys.std.Core.Boolean.true

`function true (NNInt <-- topic? : bag_of.Bool) {...}`

This function results in the count of its input element values that are
C<Bool:True>.

## sys.std.Core.Boolean.false

`function false (NNInt <-- topic? : bag_of.Bool) {...}`

This function results in the count of its input element values that are
C<Bool:False>.

# UPDATERS IMPLEMENTING VIRTUAL ORDINAL FUNCTIONS

## sys.std.Core.Boolean.assign_pred

C<updater assign_pred (&topic : Bool)
implements sys.std.Core.Ordered.Ordinal.assign_pred {...}>

This update operator is a short-hand for first invoking the
C<sys.std.Core.Boolean.pred> function with the same argument, and
then assigning the result of that function to its argument.

## sys.std.Core.Boolean.assign_succ

C<updater assign_succ (&topic : Bool)
implements sys.std.Core.Ordered.Ordinal.assign_succ {...}>

This update operator is a short-hand for first invoking the
C<sys.std.Core.Boolean.succ> function with the same argument, and
then assigning the result of that function to its argument.

# AUTHOR

Darren Duncan (C<darren@DarrenDuncan.net>)

# LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
