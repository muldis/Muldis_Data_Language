<a name="TOP"></a>

# NAME

Muldis Data Language (MDL) - Relational database application programming language

# VERSION

The fully-qualified name of this document is
`Muldis_Data_Language https://muldis.com 0.400.0`.

# PART

This artifact is part 2 of 2 of the document
`Muldis_Data_Language https://muldis.com 0.400.0`;
its part name is `Package_System`.

# CONTENTS

- [SYNOPSIS](#SYNOPSIS)
- [DESCRIPTION](#DESCRIPTION)
- [THE OTHER SECTIONS OF THIS PART](#THE-OTHER-SECTIONS-OF-THIS-PART)
- [AUTHOR](#AUTHOR)
- [LICENSE AND COPYRIGHT](#LICENSE-AND-COPYRIGHT)

[RETURN](#TOP)

<a name="SYNOPSIS"></a>

# SYNOPSIS

```
 (Muldis_Object_Notation_Syntax:([Muldis_Data_Language_Plain_Text, "https://muldis.com", "0.400.0"]:
  (Muldis_Object_Notation_Model:([Muldis_Data_Language, "https://muldis.com", "0.400.0"]:
   (\Package : (
    identity : (
        package_base_name : (\Array:[\My_App]),
        authority : "http://mycorp.com",
        version_number : "0",
    ),
    foundation : (\Tuple:{
        authority : "https://muldis.com",
        version_number : "0.400.0",
    }),
    uses : (
        MD : (
            package_base_name : (\Array:[\System]),
            authority : "https://muldis.com",
            version_number : "0.400.0",
        ),
    ),
    entry : package::main,
    floating : (\Set:[::package, used::MD, used::MD::Unicode_Aliases]),
    materials : (\Tuple:{
        `TODO: Put example routines etc here, one is a procedure named "main".`
    }),
   ))
  ))
 ))
```

[RETURN](#TOP)

<a name="DESCRIPTION"></a>

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Data_Language.md).

This part of the **Muldis Data Languagen** document specifies the
common core system-defined data types and operators that regular users of
the language would employ directly in their applications and schemas.

[RETURN](#TOP)

<a name="THE-OTHER-SECTIONS-OF-THIS-PART"></a>

# PACKAGE

```
 (Muldis_Object_Notation_Syntax:([Muldis_Data_Language_Plain_Text, "https://muldis.com", "0.400.0"]:
  (Muldis_Object_Notation_Model:([Muldis_Data_Language, "https://muldis.com", "0.400.0"]:
   (\Package : (
    identity : (
        package_base_name : (\Array:[\System]),
        authority : "https://muldis.com",
        version_number : "0.400.0",
    ),
    foundation : (\Tuple:{
        authority : "https://muldis.com",
        version_number : "0.400.0",
    }),
    floating : (\Set:[::package]),
    materials : (
        ...
    ),
   ))
  ))
 ))
```

# MAXIMAL AND MINIMAL DATA TYPES

## Any

        Any : (\Function : (\Tuple:{
            is_type_definer : 0bTRUE,
            evaluates : 0bTRUE,
            default : 0bFALSE,
        })),

The selection type definer `Any` represents the infinite *universal type*,
which is the maximal data type of the entire Muldis Data Language
type system and consists of all values which can possibly exist.  It also
represents the infinite Muldis Data Language Foundation type `foundation::Any`.
It is the union of all other types.  It is a *supertype* of every other type.
Its default value is `0bFALSE`.  Other programming languages may name their
corresponding types *Object* or *Universal*.

## None

        None : (\Function : (\Tuple:{
            is_type_definer : 0bTRUE,
            evaluates : 0bFALSE,
        })),

The selection type definer `None` represents the finite *empty type*,
which is the minimal data type of the entire Muldis Data Language type
system and consists of exactly zero values.
It is the intersection of all other types.  It is a *subtype* of every other type.
It can not have a default value.

## same =

        same : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Any, ::Any}),
            is_commutative : 0bTRUE,
            evaluates : (evaluates args --> \foundation::Any_same(\Tuple:{})),
        )),

        '=' : (\Alias : (\Tuple:{ of : ::same })),

The function `same` aka `=` results in `0bTRUE` iff its 2 arguments `0`
and `1` are exactly the same value, and `0bFALSE` otherwise.  Other
programming languages may name their corresponding operators `==` or
`===` or *eq*.

Note that `same` is guaranteed to result in `0bFALSE` when exactly one of
its 2 arguments is an `External` value but beyond that its behaviour when
both of its arguments are `External` values is implementation defined, in
that implementations are expected to make it completely deterministic
according to appropriate rules of value distinctness for the external
environment in question; for example, if the external entity referenced by
an `External` value is considered a mutable container, then 2 `External`
should only be considered *same* if they both point to the same container,
and not if two distinct containers have the same content.

## not_same != ≠

        not_same : (\Function : (\Tuple:{
            negates : ::same,
            is_commutative : 0bTRUE,
        })),

        '!=' : (\Alias : (\Tuple:{ of : ::not_same })),

        Unicode_Aliases::'≠' : (\Alias : (\Tuple:{ of : ::not_same })),

The function `not_same` aka `!=` aka `≠` results in `0bFALSE` iff its 2
arguments `0` and `1` are exactly the same value, and `0bTRUE` otherwise.
Other programming languages may name their corresponding operators
`<>` or `!===` or or `~=` or `^=` or `ne` or `/=` or `=/=`
or `=\=`.

## is_a

        is_a : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Any, ::Signature}),
            evaluates : (evaluates (\Tuple:{args:.\0}) --> Signature_to_Function_Call_But_0::(args:.\1)),
        )),

The function `is_a` results in `0bTRUE` iff its `0` argument is a
member of the type specified by its `1` argument, and `0bFALSE` otherwise.
Note that the idiomatic syntax for simply testing if a given value `v` is
a member of a type named `T` is `T v` or `T::(v)` or `evaluates \T::(\Tuple:{}) <-- (\Tuple:{v})`
and no generic testing operator is used for the purpose.  And so, the prime
operator name `is_a` is freed up for its current higher-level use, such
that the type specifier it takes has more of a template format suitable in
particular for concisely defining common cases of structural types, and in
particular routine input and output signatures.

## not_is_a

        not_is_a : (\Function : (\Tuple:{
            negates : ::is_a,
        })),

The function `not_is_a` results in `0bFALSE` iff its `0` argument is a
member of the type specified by its `1` argument, and `0bTRUE` otherwise.

# EXCUSE DATA TYPES

## Excuse

        Excuse : (\Function : (\Tuple:{
            is_type_definer : 0bTRUE,
            is_generalization : 0bTRUE,
        })),

The interface type definer `Excuse` is semifinite.  An `Excuse`
value is an explicitly stated reason for why, given some particular
problem domain, a value is not being used that is ordinary for that
domain.  For example, the typical integer division operation is not
defined to give an integer result when the divisor is zero, and so a
function for integer division could be defined to result in an
`Excuse` value rather than throw an exception in that case.
For another example, an `Excuse` value could be
used to declare that the information we are storing about a person is
missing certain details and why those are missing, such as because the
person left the birthdate field blank on their application form.  Its
default value is `0iIGNORANCE`.
An `Excuse` is also characterized by an *exception* that is not
meant to terminate execution of code early.
Other programming languages that have typed exceptions are analogous.

*TODO:  To be more specific, an Excuse value only should denote a
categorical reason for a normal value not being provided, and all possible
values of Excuse should be considered hard-coded.  They should not be
possible to vary based on user input; for example, a key out of range error
should not specify the attempted key.  Instead, other types that include an
Excuse as a component, such as an Exception, can include details that vary
on the specific user input, or include stack traces and such.*

*TODO:  Generally speaking, criteria for when it is better to use an
Excuse result value rather than exception is like this.  In a function, any
result which is non-determinisitic must always be as an exception; in a
function it should generally not be possible to cause non-determinisim on
purpose (except perhaps memory exhaustion), so such a failure would
originate in the runtime environment and truly be exceptional.  Otherwise,
in a function, Excuses should be used by default in most circumstances,
typically where it is reasonable to expect a fraction of inputs may be bad
and we are purposefully letting the function determine which is which and
tell us (such as parsers say), or situations where it is reasonable to
propagate errors while continuing to process good parts; in contrast,
exceptions should be reserved for situations where the caller should easily
have known better to either invoke it with correct inputs and doing
otherwise is obviously wrong code the caller should fix.  In a procedure,
the non-determinism factor categorically doesn't require an exception.  In
general, exceptions are for exceptional circumstances that we shouldn't
have to expect to account for within the normal code paths, where
cancelling whole blocks of code is ok, while returning Excuses is for when
we do expect to handle these things within the normal code flow and/or not
automatically halt blocks of code.*

## coalesce ??

        coalesce : (\Function : (
            returns : ::Any,
            matches : (\Tuple:{::Any, ::Any}),
            is_associative : 0bTRUE,
            is_idempotent : 0bTRUE,
            left_identity : 0iIGNORANCE,
            evaluates : (if Excuse args:.\0 then args:.\1 else args:.\0),
        )),

        '??' : (\Alias : (\Tuple:{ of : ::coalesce })),

The function `coalesce` aka `??` results in its `0` argument iff the
latter is not an `Excuse`, and results in its `1` argument otherwise.
This function is designed to be chained for any number of sequenced values
in order to pick the first non-`Excuse` in a list.
This function has analogous stop-or-continue behaviour to the Muldis Data Language
special syntax `or_else` where any `Excuse` or non-`Excuse` stands in
for `0bFALSE` and `0bTRUE` respectively but it has the opposite associativity.
Other programming languages may name their corresponding *null coalescing*
operators `?:` or `//` or *NVL* or *ISNULL*.

## anticoalesce !!

        anticoalesce : (\Function : (
            returns : ::Any,
            matches : (\Tuple:{::Any, ::Any}),
            is_associative : 0bTRUE,
            is_idempotent : 0bTRUE,
            left_identity : 0bTRUE,
            evaluates : (if Excuse args:.\0 then args:.\0 else args:.\1),
        )),

        '!!' : (\Alias : (\Tuple:{ of : ::anticoalesce })),

The function `anticoalesce` aka `!!` results in its `0` argument iff the
latter is an `Excuse`, and results in its `1` argument otherwise.
This function is designed to be chained for any number of sequenced values
in order to pick the first `Excuse` in a list.
This function has analogous stop-or-continue behaviour to the Muldis Data Language
special syntax `and_then` where any `Excuse` or non-`Excuse` stands in
for `0bFALSE` and `0bTRUE` respectively but it has the opposite associativity.

## Ignorance

        Ignorance : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Excuse]),
            provides_default_for : (\Set:[::Excuse]),
            constant : 0iIGNORANCE,
        )),

The singleton type definer `Ignorance`
represents the finite foundation type `foundation::Ignorance`.
The `Ignorance` value represents the `Excuse` value which
simply says that an ordinary value for any given domain is missing
and that there is simply no excuse that has been given for this; in
other words, something has gone wrong without the slightest hint of
an explanation.  This is conceptually the most generic `Excuse`
value there is, to help with expedient development, but any uses
should be considered technical debt, to be replaced later.
`Ignorance` has a default value of `0iIGNORANCE`.
Other programming languages may name their corresponding values or
quasi-values *null* or *nil* or *none* or *nothing* or *undef* or
*unknown*; but unlike some of those languages, `Ignorance` equals itself.

## Before_All_Others

        Before_All_Others : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Excuse, ::Orderable]),
            constant : (::Before_All_Others : (\Tuple:{})),
        )),

The singleton type definer `Before_All_Others` represents a type-agnostic
analogy of negative infinity, an `Orderable` value that sorts *before*
all other values in the Muldis Data Language type system, and that is its only meaning.
This value is expressly *not* meant to represent any specific mathematical
or physical concept of *infinity* or `∞` (of which there are many),
including those of the IEEE floating-point standards; such things should be
defined in other, not-`System`, Muldis Data Language packages for the relevant domains.

## After_All_Others

        After_All_Others : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Excuse, ::Orderable]),
            constant : (::After_All_Others : (\Tuple:{})),
        )),

The singleton type definer `After_All_Others` represents a type-agnostic
analogy of positive infinity, an `Orderable` value that sorts *after*
all other values in the Muldis Data Language type system, and that is its only meaning.
This value is expressly *not* meant to represent any specific mathematical
or physical concept of *infinity* or `∞` (of which there are many),
including those of the IEEE floating-point standards; such things should be
defined in other, not-`System`, Muldis Data Language packages for the relevant domains.

## Div_By_Zero

        Div_By_Zero : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Excuse]),
            constant : (::Div_By_Zero : (\Tuple:{})),
        )),

The singleton type definer `Div_By_Zero` represents the *undefined* result of
attempting to divide a simple number by a simple, unsigned, number zero.
Note that IEEE floating-point standards define a negative or positive
infinity result value when dividing by an explicitly signed (negative or
positive) zero, but the Muldis Data Language `System` package lacks those concepts.

## Zero_To_The_Zero

        Zero_To_The_Zero : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Excuse]),
            constant : (::Zero_To_The_Zero : (\Tuple:{})),
        )),

The singleton type definer `Zero_To_The_Zero` represents the *undefined* result
of attempting to exponentiate a number zero to the power of a number zero.

## No_Empty_Value

        No_Empty_Value : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Excuse]),
            constant : (::No_Empty_Value : (\Tuple:{})),
        )),

The singleton type definer `No_Empty_Value` represents the *undefined* result
of attempting to request the value with zero members of some collection
type that doesn't have a value with zero members.

## No_Such_Ord_Pos

        No_Such_Ord_Pos : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Excuse]),
            constant : (::No_Such_Ord_Pos : (\Tuple:{})),
        )),

The singleton type definer `No_Such_Ord_Pos` represents the *undefined* result of
attempting to use a member ordinal position *P* of `Positional` value *V* while
assuming incorrectly that *V* already has a member whose ordinal position is *P*.

## No_Such_Attr_Name

        No_Such_Attr_Name : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Excuse]),
            constant : (::No_Such_Attr_Name : (\Tuple:{})),
        )),

The singleton type definer `No_Such_Attr_Name` represents the *undefined*
result of attempting to use an attribute named *N* of `Attributive` value
*V* while assuming incorrectly that *V* already has an attribute whose
name is *N*.

## Not_Same_Heading

        Not_Same_Heading : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Excuse]),
            constant : (::Not_Same_Heading : (\Tuple:{})),
        )),

The singleton type definer `Not_Same_Heading` represents the *undefined* result
of attempting to perform an operation that takes 2 `Attributive` inputs
and requires them to have the same relational *heading* but the actual 2
inputs have different headings.

# ORDERABLE DATA TYPES

## Orderable

        Orderable::'' : (\Function : (\Tuple:{
            is_type_definer : 0bTRUE,
            is_generalization : 0bTRUE,
        })),

The interface type definer `Orderable` is semifinite.  An `Orderable` value has
all of the traditional comparison operators defined for it, such that
for each composing type *T* of `Orderable`, the set of values of *T*
can be deterministically mutually sorted by Muldis Data Language into a
canonical total order.  But *T* otherwise does not necessarily have
conceptually a total order in the normal sense or that order is different
than what the provided comparison operators give you.  An `Orderable` type
is a type for which one can take all of its values and place them on a line
such that each value is definitively considered *before* all of the values
one one side and *after* all of the values on the other side.  Other
programming languages may name their corresponding types *IComparable* or
*Ord* or *ordered* or *ordinal*.

The default value of `Orderable` is the `Integer` value `0`.  The
minimum and maximum values of `Orderable` are `(::Before_All_Others : (\Tuple:{}))`
and `(::After_All_Others : (\Tuple:{}))`, respectively; these 2 `Excuse` values are
canonically considered to be before and after, respectively, *every* other
value of the Muldis Data Language type system, regardless of whether those values are
members a type for which an `Orderable`-composing type definer exists.  The
two values `(::Before_All_Others : (\Tuple:{}))` and `(::After_All_Others : (\Tuple:{}))` can be useful in
defining an *interval* that is partially or completely unbounded, and to use
as *two-sided identity element* values for chained order-comparisons.
To be clear, Muldis Data Language does not actually system-define a
default total order for the whole type system, nor does it define
any orderings between discrete regular types, including with the
conceptually minimum and maximum values, so the set of all values
comprising `Orderable` itself only has a partial order, but users can
define a cross-composer total order for their own use cases as desired.

`Orderable` is composed, directly or indirectly, by:
`Before_All_Others`, `After_All_Others`, `Bicessable`,
`Boolean`, `Integral`, `Integer`, `Fractional`, `Rational`,
`Positional`, `Bits`, `Blob`, `Textual`, `Text`, `Array`, `Orderelation`.

## in_order

        in_order::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Boolean,
            matches : (\Tuple:{::Orderable, ::Orderable}),
        )),

The virtual function `in_order` results in `0bTRUE` iff its 2 arguments are
considered to already be *in order* as given to the function, meaning that
either both arguments are exactly the same value or otherwise that the `0`
argument value is definitively considered *before* the `1` argument
value; if `0` is considered *after* `1` then `in_order` results in
`0bFALSE`.  The primary reason for `in_order` is to underlie all
order-determination or value sorting operations in an easy consistent way;
an `Orderable`-composing type definer only has to implement `in_order` and
then values of its type can be compared, sorted on, and have intervals
defined in terms of them.

Other programming languages may instead typically use a three-way
comparison operator for this role, where its possible result values are
*before*, *same*, and *after*, and those 3 are typically represented by
either the integers {-1,0,1} or a special 3-valued enumeration type.  Said
operators may be named `<=>` or *cmp* or *compare* or *CompareTo*
or *memcmp* or *strcmp*.  But Muldis Data Language uses a `Boolean` result instead
partly to keep its core type system simpler (it would have gone the
enumeration route) and partly because the logic for doing sorting or
comparisons or validation is typically much simpler with this foundation.

## in_order (\Tuple:{Before_All_Others, After_All_Others})

        in_order::Before_All_Others_L : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Before_All_Others, ::Orderable}),
            implements : folder::'',
            evaluates : (0bTRUE),
        )),

        in_order::Before_All_Others_R : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Orderable, ::Before_All_Others}),
            implements : folder::'',
            evaluates : (args:.\0 = args:.\1),
        )),

        in_order::After_All_Others_L : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::After_All_Others, ::Orderable}),
            implements : folder::'',
            evaluates : (args:.\0 = args:.\1),
        )),

        in_order::After_All_Others_R : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Orderable, ::After_All_Others}),
            implements : folder::'',
            evaluates : (0bTRUE),
        )),

The 4 functions {`in_order::Before_All_Others_L`,
`in_order::Before_All_Others_R`, `in_order::After_All_Others_L`,
`in_order::After_All_Others_R`} implement the `Orderable` virtual
function `in_order` for the composing types `Before_All_Others`
and `After_All_Others`, specifically for comparing either value
with any `Orderable`.

## before <

        before : (\Function : (\Tuple:{
            commutes : ::after,
        })),

        '<' : (\Alias : (\Tuple:{ of : ::before })),

The function `before` aka `<` results in `0bTRUE` iff its `0`
argument is *before* its `1` argument; otherwise it results in `0bFALSE`.
Other programming languages may name this operator *lt*.

## after >

        after : (\Function : (\Tuple:{
            negates : ::before_or_same,
        })),

        '>' : (\Alias : (\Tuple:{ of : ::after })),

The function `after` aka `>` results in `0bTRUE` iff its `0`
argument is *after* its `1` argument; otherwise it results in `0bFALSE`.
Other programming languages may name this operator *gt*.

## before_or_same <= ≤

        before_or_same : (\Alias : (\Tuple:{ of : ::in_order })),

        '<=' : (\Alias : (\Tuple:{ of : ::before_or_same })),

        Unicode_Aliases::'≤' : (\Alias : (\Tuple:{ of : ::before_or_same })),

The function `before_or_same` aka `<=` aka `≤` results in `0bTRUE`
iff its `0` argument is *before* its `1` argument or they are the same
value; otherwise it results in `0bFALSE`.  Other programming languages may
name this operator *le*.

## after_or_same >= ≥

        after_or_same : (\Function : (\Tuple:{
            commutes : ::before_or_same,
        })),

        '>=' : (\Alias : (\Tuple:{ of : ::after_or_same })),

        Unicode_Aliases::'≥' : (\Alias : (\Tuple:{ of : ::after_or_same })),

The function `after_or_same` aka `>=` aka `≥` results in `0bTRUE`
iff its `0` argument is *after* its `1` argument or they are the same
value; otherwise it results in `0bFALSE`.  Other programming languages may
name this operator *ge*.

## min

        min : (\Function : (
            returns : ::Orderable,
            matches : (\Tuple:{::Orderable, ::Orderable}),
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            is_idempotent : 0bTRUE,
            identity : (::After_All_Others : (\Tuple:{})),
            evaluates : (if args:.\0 in_order args:.\1 then args:.\0 else args:.\1),
        )),

The function `min` results in whichever of its 2 arguments is first when
the 2 are sorted *in order*.  This function is designed to be chained for
any number of values in order to pick the one that sorts
*before* all of the others.

## max

        max : (\Function : (
            returns : ::Orderable,
            matches : (\Tuple:{::Orderable, ::Orderable}),
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            is_idempotent : 0bTRUE,
            identity : (::Before_All_Others : (\Tuple:{})),
            evaluates : (if args:.\0 in_order args:.\1 then args:.\1 else args:.\0),
        )),

The function `max` results in whichever of its 2 arguments is last when
the 2 are sorted *in order*.  This function is designed to be chained for
any number of values in order to pick the one that sorts
*after* all of the others.

## minmax

        minmax : (\Function : (
            returns : (\Tuple:{::Orderable, ::Orderable}),
            matches : (\Tuple:{::Orderable, ::Orderable}),
            is_commutative : 0bTRUE,
            evaluates : (if args:.\0 in_order args:.\1 then args else (\Tuple:{args:.\1, args:.\0})),
        )),

The function `minmax` results in a binary `Tuple` containing its 2
arguments sorted *in order*; the function's result is the same as its
source when the arguments are already in order, and the reverse of that
otherwise, meaning the values of `0` and `1` are swapped.

# SUCCESSABLE DATA TYPES

## Successable

        Successable : (\Function : (\Tuple:{
            is_type_definer : 0bTRUE,
            is_generalization : 0bTRUE,
        })),

The interface type definer `Successable` is semifinite.  A `Successable` value
is a member of a conceptually noncontiguous totally ordered type; it has a
definitive *successor* value of that type, at least where the given value
isn't the last value.

The primary reason for `Successable` is to provide an easy consistent and
terse API for a generator of arbitrary sequences of values of any type.  In
this context, a `Successable` value defines a complete self-contained
*state* for a sequence generator, which is everything the generator needs
to know to both emit a *current* value, which we call the *asset*, as
well as determine all subsequent values of the sequence without any further
input.  To keep the fundamental general case API simple, there is just the
a monadic function to derive the next state from the current one, and a
monadic function to extract the asset from the current state, so actually
reading a sequence of values requires 2 function calls per value in the
general case.  For some trivial cases of `Successable`, the *state* and
*asset* are one and the same, so just 1 function call per value is needed.
Keep in mind that asset values may repeat in a sequence, so it is not them
but rather the state values that have the total order property.  Other
programming languages may name their corresponding types *sequence* or
*iterator* or *enumerator*.

`Successable` is a less rigorous analogy to `Bicessable`, where the
latter also requires the ability to produce the *predecessor* value of the
given value, as well as the ability to determine if 2 arbitrary values are
in order.  While conceptually a `Successable` has those features, formally
it is not required to because for some types it may be onerous or
unnecessary for its mandate to support those features; for example,
producing a successor state may disgard information otherwise needed to
recall any of its predecessors.

The default and minimum and maximum values of `Successable` are the same
as those of `Orderable`.  `Successable` is composed, directly or
indirectly, by: `Bicessable`, `Boolean`, `Integral`, `Integer`.

`Successable` is intended to be a generalized tool for performing *list
comprehension* or *set comprehension*.  The typically idiomatic and more
efficient way to do many kinds of such *comprehensions* is to use the
features of various `Homogeneous` types to map an existing list or set to
another using generic member mapping and filtering functions, such as a
list of even integers less than a hundred.  With those cases, the
map/filter approach can permit processing members in any order or in
parallel, and avoiding unnecessary intermediate values.  In contrast, the
primary intended uses of `Successable` is when either you want to produce
or process a potentially infinite-sized list (lazily) or especially produce
a sequence with uneven step sizes, such as an arbitrary number of
Fibonacci.  This is for cases where it may be necessary to calculate all
the intermediate values in order to arrive at a desired nth one, and doing
them out of sequence or in parallel may not be an option.

## asset

        asset::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Any,
            matches : (\Tuple:{::Successable}),
        )),

The virtual function `asset` results in the *asset* of its `0` argument,
which for trivial cases may simply be that same argument.  Other
programming languages may name their corresponding operators *Current*.

## succ

        succ : (\Function : (
            returns : (\Set:[::Successable, ::After_All_Others]),
            matches : (\Tuple:{::Successable}),
            evaluates : (args:.\0 nth_succ 1),
        )),

The function `succ` results in the *successor* value of its `0`
argument, or in `(::After_All_Others : (\Tuple:{}))` if there is none.  Other
programming languages may name their corresponding operators *next* or
*MoveNext*.

## nth_succ

        nth_succ::'' : (\Function : (
            virtual : 0bTRUE,
            returns : (\Set:[::Successable, ::After_All_Others]),
            matches : (\Tuple:{::Successable, ::Integer_NN}),
        )),

The virtual function `nth_succ` results in the Nth *successor* value of
its `0` argument, where N is its `1` argument, or in
`(::After_All_Others : (\Tuple:{}))` if there is none.

# BICESSABLE DATA TYPES

## Bicessable

        Bicessable : (\Function : (
            is_type_definer : 0bTRUE,
            is_generalization : 0bTRUE,
            composes : (\Set:[::Orderable, ::Successable]),
            provides_default_for : (\Set:[::Orderable, ::Successable]),
        )),

The interface type definer `Bicessable` is semifinite.  A `Bicessable` value
is an `Orderable` value for which, using the same canonical total order
for its type, there exists definitive *predecessor* and *successor*
values, at least where the given value isn't the first or last value on the
line respectively.  Similarly, one can take any two values of a
`Bicessable` type and produce an ordered list of all of that type's values
which are on the line between those two values.  A primary quality of a
type that is `Orderable` but not `Bicessable` is that you can take any
two values of that type and then find a third value of that type which lies
between the first two on the line; by definition for a `Bicessable` type,
there is no third value between one of its values and that value's
predecessor or successor value.  Other programming languages may name their
corresponding types *ordinal* or categorically as *enum*.  Note that
while a generic rational numeric type may qualify as an ordinal type by
some definitions of *ordinal*, since it is possible to count all the
rationals if arranged a particular way, these types would not qualify as
`Bicessable` here when that ordering is not the same as the one used for
the same type's `Orderable` comparisons.  The default and minimum and
maximum values of `Bicessable` are the same as those of `Orderable`.
`Bicessable` is composed, directly or indirectly, by: `Boolean`,
`Integral`, `Integer`.

For some `Bicessable` types, there is the concept of a *quantum* or
*step size*, where every consecutive pair of values on that type's value
line are conceptually spaced apart at equal distances; this distance would
be the quantum, and all steps along the value line are at exact multiples
of that quantum.  However, `Bicessable` types in general don't need to be
like this, and there can be different amounts of conceivable distance
between consecutive values; a `Bicessable` type is just required to know
where all the values are.  For example, `Integer` has a quantum while a
type consisting just of prime integers does not.

Note that while mathematics formally defines *predecessor* and
*successor* for non-negative integers only, and some other programming
languages extend this concept to real numbers with the meaning *minus one*
and *plus one* respectively, Muldis Data Language only formally associates these terms
with the quantum of *one* for types specifically representing integers;
for `Bicessable` types in general, the terms just mean prior or next
values and should not be conceptualized as mathematical operations.

## pred

        pred : (\Function : (
            returns : (\Set:[::Bicessable, ::Before_All_Others]),
            matches : (\Tuple:{::Bicessable}),
            evaluates : (args:.\0 nth_pred 1),
        )),

The function `pred` results in the *predecessor* value of its `0`
argument, or in `(::Before_All_Others : (\Tuple:{}))` if there is none.  Other
programming languages may name their corresponding operators *prior* or
*previous*.

## nth_pred

        nth_pred::'' : (\Function : (
            virtual : 0bTRUE,
            returns : (\Set:[::Bicessable, ::Before_All_Others]),
            matches : (\Tuple:{::Bicessable, ::Integer_NN}),
        )),

The virtual function `nth_pred` results in the Nth *predecessor* value of
its `0` argument, where N is its `1` argument, or in
`(::Before_All_Others : (\Tuple:{}))` if there is none.

# BOOLEAN DATA TYPES

## Boolean

        Boolean : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Bicessable]),
            evaluates : \foundation::Boolean(\Tuple:{}),
            default : 0bFALSE,
        )),

The selection type definer `Boolean` represents the finite
foundation type `foundation::Boolean`.
A `Boolean` value is a general purpose 2-valued logic boolean or *truth
value*, or specifically it is one of the 2 values `0bFALSE` and `0bTRUE`.
`Boolean` has a default value of `0bFALSE`.
`Boolean` is both `Orderable` and `Bicessable`;
its minimum value is `0bFALSE` and its maximum value is `0bTRUE`.
Other programming languages frequently don't
have a dedicated boolean type but rather consider values of other types,
typically integer types, to be *false* or *true*.

## False ⊥

        False : (\Function : (\Tuple:{
            is_type_definer : 0bTRUE,
            constant : 0bFALSE,
        })),

        Unicode_Aliases::'⊥' : (\Alias : (\Tuple:{ of : ::0bFALSE })),

The singleton type definer `False` aka `⊥` represents the boolean logical truth value
*false* aka *contradiction*.  Other programming languages frequently use
the integer 0 to represent *false*.

## True ⊤

        True : (\Function : (\Tuple:{
            is_type_definer : 0bTRUE,
            constant : 0bTRUE,
        })),

        Unicode_Aliases::'⊤' : (\Alias : (\Tuple:{ of : ::0bTRUE })),

The singleton type definer `True` aka `⊤` represents the boolean logical truth value
*true* aka *tautology*.  Other programming languages frequently use the
integer 1 to represent *true*.

## in_order (Boolean)

        in_order::Boolean : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Boolean, ::Boolean}),
            implements : folder::'',
            evaluates : (!args:.\0 or args:.\1),
        )),

The function `in_order::Boolean` implements the `Orderable` virtual
function `in_order` for the composing type `Boolean`.

## asset (Boolean)

        asset::Boolean : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Boolean}),
            implements : folder::'',
            evaluates : (args:.\0),
        )),

The function `asset::Boolean` simply results in its `0` argument.
This function implements the `Successable` virtual function `asset` for
the composing type `Boolean`.

## nth_pred (Boolean)

        nth_pred::Boolean : (\Function : (
            returns : (\Set:[::0bFALSE, ::Before_All_Others]),
            matches : (\Tuple:{::Boolean, ::Integer_NN}),
            implements : folder::'',
            evaluates : (if args:.\1 = 0 then args:.\0 else if args:.\1 = 1 and args:.\0 then 0bFALSE else (::Before_All_Others : (\Tuple:{}))),
        )),

The function `nth_pred::Boolean` implements the `Bicessable` virtual
function `nth_pred` for the composing type `Boolean`.

## nth_succ (Boolean)

        nth_succ::Boolean : (\Function : (
            returns : (\Set:[::0bTRUE, ::After_All_Others]),
            matches : (\Tuple:{::Boolean, ::Integer_NN}),
            implements : folder::'',
            evaluates : (if args:.\1 = 0 then args:.\0 else if args:.\1 = 1 and !args:.\0 then 0bTRUE else (::After_All_Others : (\Tuple:{}))),
        )),

The function `nth_succ::Boolean` implements the `Successable` virtual
function `nth_succ` for the composing type `Boolean`.

## not ! ¬

        not : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Boolean}),
            evaluates : (if args:.\0 then 0bFALSE else 0bTRUE),
        )),

        '!' : (\Alias : (\Tuple:{ of : ::not })),

        Unicode_Aliases::'¬' : (\Alias : (\Tuple:{ of : ::not })),

The function `not` aka `!` aka `¬` performs a logical *negation* or
*logical complement*; it results in `0bTRUE` iff its `0` argument is
`0bFALSE` and vice-versa.  Other programming languages may name their
corresponding operators `~` or `^` or *N*.

## and ∧

        and : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Boolean, ::Boolean}),
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            is_idempotent : 0bTRUE,
            identity : 0bTRUE,
            evaluates : (args:.\0 and_then args:.\1),
        )),

        Unicode_Aliases::'∧' : (\Alias : (\Tuple:{ of : ::and })),

The function `and` aka `∧` performs a logical *conjunction*; it results
in `0bTRUE` iff its 2 arguments `0` and `1` are both `0bTRUE`, and `0bFALSE`
otherwise.  Other programming languages may name their corresponding
operators `&` or `&&` or *K*.

## nand not_and ⊼ ↑

        nand : (\Function : (\Tuple:{
            negates : ::and,
            is_commutative : 0bTRUE,
        })),

        not_and : (\Alias : (\Tuple:{ of : ::nand })),

        Unicode_Aliases::'⊼' : (\Alias : (\Tuple:{ of : ::nand })),
        Unicode_Aliases::'↑' : (\Alias : (\Tuple:{ of : ::nand })),

The function `nand` aka `not_and` aka `⊼` aka `↑` performs a logical
*alternative denial*; it results in `0bFALSE` iff its 2 arguments `0` and
`1` are both `0bTRUE`, and `0bTRUE` otherwise.

## or ∨

        or : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Boolean, ::Boolean}),
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            is_idempotent : 0bTRUE,
            identity : 0bFALSE,
            evaluates : (args:.\0 or_else args:.\1),
        )),

        Unicode_Aliases::'∨' : (\Alias : (\Tuple:{ of : ::or })),

The function `or` aka `∨` performs a logical *disjunction*; it results
in `0bTRUE` iff at least one of its 2 arguments `0` and `1` is `0bTRUE`,
and `0bFALSE` otherwise.  Other programming languages may name their
corresponding operators `|` or `||` or *A*.

## nor not_or ⊽ ↓

        nor : (\Function : (\Tuple:{
            negates : ::or,
            is_commutative : 0bTRUE,
        })),

        not_or : (\Alias : (\Tuple:{ of : ::nor })),

        Unicode_Aliases::'⊽' : (\Alias : (\Tuple:{ of : ::nor })),
        Unicode_Aliases::'↓' : (\Alias : (\Tuple:{ of : ::nor })),

The function `nor` aka `not_or` aka `⊽` aka `↓` performs a logical
*joint denial*; it results in `0bFALSE` iff at least one of its 2 arguments
`0` and `1` is `0bTRUE`, and `0bTRUE` otherwise.

## xnor iff ↔

        xnor : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Boolean, ::Boolean}),
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            identity : 0bTRUE,
            evaluates : (args:.\0 = args:.\1),
        )),

        iff : (\Alias : (\Tuple:{ of : ::xnor })),

        Unicode_Aliases::'↔' : (\Alias : (\Tuple:{ of : ::xnor })),

The function `xnor` aka `iff` aka `↔` performs a logical
*biconditional* or *material equivalence* or *even parity*; it results
in `0bTRUE` iff its 2 arguments `0` and `1` are exactly the same value,
and `0bFALSE` otherwise.  This function is effectively a `Boolean`-specific
alias of the function `same` aka `=`; it behaves identically to `same`
when given the same arguments.  Other programming languages may
name their corresponding operators *E*.

## xor ⊻ ↮

        xor : (\Function : (\Tuple:{
            negates : ::xnor,
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            identity : 0bFALSE,
        })),

        Unicode_Aliases::'⊻' : (\Alias : (\Tuple:{ of : ::xor })),
        Unicode_Aliases::'↮' : (\Alias : (\Tuple:{ of : ::xor })),

The function `xor` aka `⊻` aka `↮` performs a logical *exclusive
disjunction* or *odd parity*; it results in `0bFALSE` iff its 2 arguments
`0` and `1` are exactly the same value, and `0bTRUE` otherwise.  This
function is effectively a `Boolean`-specific alias of the function
`not_same` aka `!=` aka `≠`; it behaves identically to `not_same`
when given the same arguments.  Other programming languages may name their
corresponding operators `^`.

## imp implies →

        imp : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Boolean, ::Boolean}),
            evaluates : (if args:.\0 then args:.\1 else 0bTRUE),
        )),

        implies : (\Alias : (\Tuple:{ of : ::imp })),

        Unicode_Aliases::'→' : (\Alias : (\Tuple:{ of : ::imp })),

The function `imp` aka `implies` aka `→` performs a logical *material
implication*; it results in `0bFALSE` when its `0` argument is `0bTRUE` and
its `1` argument is `0bFALSE`, and `0bTRUE` otherwise.

## nimp not_implies ↛

        nimp : (\Function : (\Tuple:{
            negates : ::imp,
        })),

        not_implies : (\Alias : (\Tuple:{ of : ::nimp })),

        Unicode_Aliases::'↛' : (\Alias : (\Tuple:{ of : ::nimp })),

The function `nimp` aka `not_implies` aka `↛` performs a logical
*material nonimplication*; it results in `0bTRUE` when its `0` argument is
`0bTRUE` and its `1` argument is `0bFALSE`, and `0bFALSE` otherwise.

## if ←

        if : (\Function : (\Tuple:{
            commutes : ::imp,
        })),

        Unicode_Aliases::'←' : (\Alias : (\Tuple:{ of : ::if })),

The function `if` aka `←` performs a logical *converse implication* or
*reverse material implication*; it results in `0bFALSE` when its `0`
argument is `0bFALSE` and its `1` argument is `0bTRUE`, and `0bTRUE`
otherwise.

## nif not_if ↚

        nif : (\Function : (\Tuple:{
            commutes : ::nimp,
        })),

        not_if : (\Alias : (\Tuple:{ of : ::nif })),

        Unicode_Aliases::'↚' : (\Alias : (\Tuple:{ of : ::nif })),

The function `nif` aka `not_if` aka `↚` performs a logical *converse
nonimplication*; it results in `0bTRUE` when its `0` argument is `0bFALSE`
and its `1` argument is `0bTRUE`, and `0bFALSE` otherwise.

# ROUNDING INSTRUCTION DATA TYPES

## Round_Meth

        Round_Meth : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (
                    0 : \Round_Meth_Attr_Name::(\Tuple:{}),
                ),
            )),
            default : (::material : (\Tuple:{\To_Zero})),
        )),

The selection type definer `Round_Meth` is finite.  When a value of some
`Orderable` type needs to be mapped into a proper subtype that doesn't
contain that value, such as when mapping an arbitrary number to one with
less precision, some rounding method is applied to determine which value of
the subtype is to be mapped to while most accurately reflecting the
original value.  The `Round_Meth` type enumerates the rounding methods
that Muldis Data Language operators can typically apply.

With `Down` (aka *floor*), `Up` (aka *ceiling*), `To_Zero` (aka
*truncate*), and `To_Inf`, the original value will always be mapped to
the single nearest value that is lower than it, or higher than it, or
towards "zero" from it, or towards the nearer infinity from it,
respectively.  With `Half_Down`, `Half_Up`, `Half_To_Zero`,
`Half_To_Inf`, `Half_Even` (\Tuple:{aka *unbiased rounding*, *convergent
rounding*, *statistician's rounding*, or *bankers' rounding*}), and
`Half_Odd` the original value will be mapped to the single target value
that it is nearest to, if there is one; otherwise, if it is exactly
half-way between 2 adjacent target values, then `Half_Down` will round
towards negative infinity, `Half_Up` will round towards positive infinity,
`Half_To_Zero` will round towards "zero", `Half_To_Inf` will round
towards the nearer infinity, while `Half_Even` and `Half_Odd` will round
towards the nearest "even" or "odd" target respectively.

The default value of `Round_Meth` is `To_Zero`, which is the simplest.
Other programming languages may name their corresponding types
*RoundingMode* (Java) or *MidpointRounding* (C#).

## Round_Meth_Attr_Name

        Round_Meth_Attr_Name : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[\Attr_Name::(\Tuple:{}), \'⊆$'::( 1:
                ::(\Tuple:{Down,Up,To_Zero,To_Inf
                ,Half_Down,Half_Up,Half_To_Zero,Half_To_Inf
                ,Half_Even,Half_Odd})
            )]),
            default : \To_Zero,
        )),

The selection type definer `Round_Meth_Attr_Name` represents the finite type
consisting just of the `Attr_Name` values that are valid Article attribute
assets of `Round_Meth` values.

## RM

        RM : (\Function : (
            returns : ::Round_Meth,
            matches : (\Tuple:{::Round_Meth_Attr_Name}),
            evaluates : ((::Round_Meth : (\Tuple:{args:.\0}))),
        )),

The function `RM` results in the `Round_Meth` value selected in
terms of the `Attr_Name` of its `0` argument.

# NUMERICAL DATA TYPES

## Numerical

        Numerical : (\Function : (\Tuple:{
            is_type_definer : 0bTRUE,
            is_generalization : 0bTRUE,
        })),

The interface type definer `Numerical` is semifinite.  A `Numerical` value
either is a simple number of some kind or is something that can act as a
simple number.  A *simple number* means, typically speaking, any rational
real number, those numbers that can be derived simply by multiplying or
dividing integers.  All operators defined by the `System` package
for `Numerical` are expect to be closed over the real rational numbers,
and consist mainly of addition, subtraction, multiplication, and division
of any rationals, plus exponentiation of any rationals to integer powers
only.  Idiomatically a `Numerical` is a pure number which does not
represent any kind of thing in particular, neither cardinal nor ordinal nor
nominal; however some types which do represent such a particular kind of
thing may choose to compose `Numerical` because it makes sense to provide
its operators.  The default value of `Numerical` is the `Integer` value
`0`.  A `Numerical` in the general case is not `Orderable`, but often a
type that is numeric is also orderable.  Other programming languages may
name their corresponding types *Numeric*.

`Numerical` is composed, directly or indirectly, by: `Integral`,
`Integer`, `Fractional`, `Rational`, `Quantitative`, `Quantity`.
It is also composed by a lot of additional type definers defined by other
Muldis Data Language packages such as `System::Math`;
these include types for irrational or algebraic or complex numbers or
quaternions or rational types with a fixed precision or scale or
floating-point types and so on.

## not_zero

        not_zero : (\Function : (
            virtual : 0bTRUE,
            returns : ::Boolean,
            matches : (\Tuple:{::Numerical}),
        )),

The virtual function `not_zero` results in `0bTRUE` when its
`0` argument is a nonzero number; otherwise it results in `0bFALSE`.

## is_zero

        is_zero : (\Function : (\Tuple:{
            negates : ::not_zero,
        })),

The function `is_zero` results in `0bTRUE` when its `0` argument is a
number zero; otherwise it results in `0bFALSE`.

## zero

        zero::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Numerical,
            matches : (\Tuple:{::Numerical}),
        )),

The virtual function `zero` results in the number zero of its `0`
argument's numerical type, assuming that every type composing `Numerical`
has one.

## opposite

        opposite::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Numerical,
            matches : (\Tuple:{::Numerical}),
        )),

        additive_inverse : (\Alias : (\Tuple:{ of : ::opposite })),

The virtual function `opposite` aka `additive_inverse` aka unary `-` aka
unary `−` results in the numeric *opposite* or *negation* or *additive
inverse* or *unary minus* of its `0` argument, and is a shorthand for
either multiplying that argument by negative one or subtracting it from
zero.  By definition, the sum of a number and its opposite is zero.

## reciprocal

        reciprocal::'' : (\Function : (
            virtual : 0bTRUE,
            returns : (\Set:[::Numerical, ::Div_By_Zero]),
            matches : (\Tuple:{::Numerical}),
        )),

        multiplicative_inverse : (\Alias : (\Tuple:{ of : ::reciprocal })),

The virtual function `reciprocal` aka `multiplicative_inverse` results in
the numeric *reciprocal* or *multiplicative inverse* of its nonzero `0`
argument, and is a shorthand for dividing one by that argument.  By
definition, the product of a number and its reciprocal is one.  The result
is always `Fractional` for both `Integral` and `Fractional` arguments.
The result is only *defined* when the argument is a nonzero number; it is
`(::Div_By_Zero : (\Tuple:{}))` otherwise.

## modulus abs

        modulus::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Numerical,
            matches : (\Tuple:{::Numerical}),
        )),

        abs : (\Alias : (\Tuple:{ of : ::modulus })),

The virtual function `modulus` aka `abs` results in the numeric
*modulus* or *absolute value* of its `0` argument, which is the
(non-negative) distance between that argument and zero.  Note that typical
mathematical notion writes this operator in circumfix like *|n|*.

## plus +

        plus::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Numerical,
            matches : (\Tuple:{::Numerical, ::Numerical}),
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            repeater : ::times,
        )),

        '+' : (\Alias : (\Tuple:{ of : ::plus })),

The virtual function `plus` aka `+` results in the numeric *sum* from
performing *addition* of its 2 *summand* arguments `0` (*augend*) and
`1` (*addend*).  This operation has a *two-sided identity element* value of a number zero.

## minus

        minus::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Numerical,
            matches : (\Tuple:{::Numerical, ::Numerical}),
        )),

The virtual function `minus` aka binary `-` aka binary `−` results in
the numeric *difference* from performing *subtraction* of its 2 arguments
`0` (*minuend*) and `1` (*subtrahend*).  This operation has a *right
identity element* value of a number zero.

## - −

        '-' : (\Function : (
            returns : ::Numerical,
            matches : (\Set:[(::Numerical), (\Tuple:{::Numerical, ::Numerical})]),
            evaluates : (evaluates args --> (if degree::(args) = 1 then \opposite::(\Tuple:{}) else \minus::(\Tuple:{}))),
        )),

        Unicode_Aliases::'−' : (\Alias : ( of : '-' )),

The function `-` aka `−` is a proxy for either of the virtual functions
unary `opposite` and binary `minus`, depending on how many arguments it
was invoked with.

## modulus_minus abs_minus |-| |−|

        modulus_minus : (\Function : (
            returns : ::Numerical,
            matches : (\Tuple:{::Numerical, ::Numerical}),
            is_commutative : 0bTRUE,
            evaluates : (modulus args:.\0 - args:.\1),
        )),

        abs_minus : (\Alias : (\Tuple:{ of : ::modulus_minus })),
        '|-|'     : (\Alias : (\Tuple:{ of : ::modulus_minus })),

        Unicode_Aliases::'|−|' : (\Alias : (\Tuple:{ of : ::modulus_minus })),

The function `modulus_minus` aka `abs_minus` aka `|-|` aka `|−|`
results in the numeric *absolute difference* of its 2 arguments `0` and
`1`, which is the (non-negative) distance between those arguments.

## times * ×

        times::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Numerical,
            matches : (\Tuple:{::Numerical, ::Numerical}),
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            repeater : ::integral_nn_power,
        )),

        '*' : (\Alias : (\Tuple:{ of : ::times })),

        Unicode_Aliases::'×' : (\Alias : (\Tuple:{ of : ::times })),

The virtual function `times` aka `*` aka `×` results in the numeric
*product* from performing *multiplication* of its 2 *factor* arguments
`0` (*multiplier*) and `1` (*multiplicand*).  This operation has a
*two-sided identity element* value of a number positive one.

## multiple_of

        multiple_of::'' : (\Function : (
            virtual : 0bTRUE,
            returns : (\Set:[::Boolean, ::Div_By_Zero]),
            matches : (\Tuple:{::Numerical, ::Numerical}),
        )),

The virtual function `multiple_of` results in `0bTRUE` iff its `0`
argument is an even multiple of its `1` argument (\Tuple:{that is, the former is
evenly divisible by the latter}), and `0bFALSE` otherwise.  The result is
only *defined* when the `1` argument is a nonzero number; it is
`(::Div_By_Zero : (\Tuple:{}))` otherwise.  Other programming languages may name their
corresponding operators `%%`.

## nearest_multiple_of round

        nearest_multiple_of : (\Function : (
            returns : (\Set:[::Numerical, ::Div_By_Zero]),
            matches : (\Tuple:{::Numerical, ::Numerical, ::Round_Meth}),
            evaluates : (if is_zero args:.\1 then (::Div_By_Zero : (\Tuple:{}))
                else guard args:.\1 * (args:.\0 div args:.\1)),
        )),

        round : (\Alias : (\Tuple:{ of : ::nearest_multiple_of })),

The function `nearest_multiple_of` aka `round` results in the same or
nearest number to its `0` argument that is an even multiple of its `1`
argument (\Tuple:{that is, the result is evenly divisible by the latter}), where the
nearest is determined by the rounding method specified by the `2`
argument.  For the common case of rounding to the nearest integer, use a
`1` argument of positive one.  The result is `Integral` for `Integral`
arguments and is `Fractional` for `Fractional` arguments.  The result is
only *defined* when the `1` argument is a nonzero number; it is
`(::Div_By_Zero : (\Tuple:{}))` otherwise.  Other programming languages may name their
corresponding operators *truncate* or *int* or *floor* or *ceil* or
other things, some of which would always round to a multiple of one.

## fractional_divided_by / ÷ ∕

        fractional_divided_by::'' : (\Function : (
            virtual : 0bTRUE,
            returns : (\Set:[::Numerical, ::Div_By_Zero]),
            matches : (\Tuple:{::Numerical, ::Numerical}),
        )),

        '/' : (\Alias : (\Tuple:{ of : ::fractional_divided_by })),

        Unicode_Aliases::'÷' : (\Alias : (\Tuple:{ of : ::fractional_divided_by })),
        Unicode_Aliases::'∕' : (\Alias : (\Tuple:{ of : ::fractional_divided_by })),

The virtual function `fractional_divided_by` aka `/` aka `÷` aka `∕`
results in the typically-fractional numeric *quotient* from performing
*division* of its 2 arguments `0` (*dividend* or *numerator*) and `1`
(*divisor* or *denominator*) using the semantics of real number division.
The result is always `Fractional` for both `Integral` and `Fractional`
arguments; as such, `fractional_divided_by` is the idiomatic way to select
any `Rational` values in terms of `Integer` values.  The result is only
*defined* when the `1` argument is a nonzero number; it is `(::Div_By_Zero : (\Tuple:{}))`
otherwise.  This operation has a *right identity element* value of a
number positive one.

## integral_divided_by div

        integral_divided_by::'' : (\Function : (
            virtual : 0bTRUE,
            returns : (\Set:[::Numerical, ::Div_By_Zero]),
            matches : (\Tuple:{::Numerical, ::Numerical, ::Round_Meth}),
        )),

        div : (\Alias : (\Tuple:{ of : ::integral_divided_by })),

The virtual function `integral_divided_by` aka `div` results in the
integral numeric *quotient* from performing *division* of its 2 arguments
`0` (*dividend* or *numerator*) and `1` (*divisor* or *denominator*)
using the semantics of real number division, whereupon the real number
result is rounded to the same or nearest integral number, where the nearest
is determined by the rounding method specified by the `2` argument.  The
result is `Integral` for `Integral` arguments and is `Fractional` with a
*denominator* of one for `Fractional` arguments.  The result is only
*defined* when the `1` argument is a nonzero number; it is `(::Div_By_Zero : (\Tuple:{}))`
otherwise.  This operation has a *right identity element* value of a
number positive one.

## modulo mod

        modulo : (\Function : (
            returns : (\Set:[::Numerical, ::Div_By_Zero]),
            matches : (\Tuple:{::Numerical, ::Numerical, ::Round_Meth}),
            evaluates : (if is_zero args:.\1 then (::Div_By_Zero : (\Tuple:{}))
                else guard args:.\0 - (args:.\0 nearest_multiple_of args:.\1)),
        )),

        mod : (\Alias : (\Tuple:{ of : ::modulo })),

The function `modulo` aka `mod` results in the possibly-fractional
numeric *remainder* from performing same *division* operation as
`integral_divided_by` does with all of the same arguments; to be specific,
`modulo` preserves the identity `x mod y = x - y * (x div y)`.  The
result is `Integral` for `Integral` arguments and is `Fractional` for
`Fractional` arguments.  The result is only *defined* when the `1`
argument is a nonzero number; it is `(::Div_By_Zero : (\Tuple:{}))` otherwise.  Other
programming languages may name their corresponding operators `%` or `//`
or `\\` or *div* or *rem* or *remainder* or various other things.

## divided_by_and_modulo

        divided_by_and_modulo::'' : (\Function : (
            returns : ((\Set:[::Numerical, ::Div_By_Zero]), (\Set:[::Numerical, ::Div_By_Zero])),
            matches : (\Tuple:{::Numerical, ::Numerical, ::Round_Meth}),
            evaluates : ((\Tuple:{args:.\0 div args:.\1, args:.\0 mod args:.\1})),
        )),

The function `divided_by_and_modulo` results in a binary tuple whose `0`
and `1` attributes have the exact same values that `integral_divided_by`
and `modulo` would result in, respectively, when each is given all of the
same arguments.  This function is a shorthand for invoking the other two.

## integral_power **

        integral_power::'' : (\Function : (
            virtual : 0bTRUE,
            returns : (\Set:[::Numerical, ::Zero_To_The_Zero]),
            matches : (\Tuple:{::Numerical, ::Integral}),
        )),

        '**' : (\Alias : (\Tuple:{ of : ::integral_power })),

The virtual function `integral_power` aka `**` results in a
typically-fractional number from performing *exponentiation* of its 2
arguments `0` (*base*) and `1` (*exponent* or *power*).  The result is
always `Fractional` for both an `Integral` and a `Fractional` `0`
argument.  The result is only *defined* when at least one of the arguments
`0` and `1` is a nonzero number; it is `(::Zero_To_The_Zero : (\Tuple:{}))` otherwise.  Other
programming languages may name their corresponding operators *exp* or `^`.

## integral_nn_power power

        integral_nn_power::'' : (\Function : (
            virtual : 0bTRUE,
            returns : (\Set:[::Numerical, ::Zero_To_The_Zero]),
            matches : (\Tuple:{::Numerical, ::Integral_NN}),
        )),

        power : (\Alias : (\Tuple:{ of : ::integral_nn_power })),

The virtual function `integral_nn_power` aka `power` results in a
possibly-fractional number from performing *exponentiation* of its 2
arguments `0` (*base*) and `1` (*exponent* or *power*).  The result is
`Integral` for an `Integral` `0` argument and is `Fractional` for a
`Fractional` `0` argument.  The result is only *defined* when at least
one of the arguments `0` and `1` is a nonzero number; it is `(::Zero_To_The_Zero : (\Tuple:{}))`
otherwise.

# INTEGRAL DATA TYPES

## Integral

        Integral::'' : (\Function : (
            is_type_definer : 0bTRUE,
            is_generalization : 0bTRUE,
            composes : (\Set:[::Bicessable, ::Numerical]),
            provides_default_for : (\Set:[::Bicessable, ::Numerical]),
        )),

The interface type definer `Integral` is semifinite.  An `Integral` value
either is an exact integral number of some kind or is something that can
act as such.  Idiomatically an `Integral` is a pure integer which does not
represent any kind of thing in particular, neither cardinal nor ordinal nor
nominal; however some types which do represent such a particular kind of
thing may choose to compose `Integral` because it makes sense to provide
its operators.  The default value of `Integral` is the `Integer` value
`0`.  `Integral` is both `Orderable` and `Bicessable`.  For each type
composing `Integral`, a value closer to negative infinity is ordered
before a value closer to positive infinity, and the definition of
*predecessor* and *successor* is exactly equal to subtracting or adding
an integer positive-one respectively, while other `Bicessable` don't
generally mean that.  In the general case, `Integral` has no minimum or
maximum value, but often a type that is `Integral` will have them.
`Integral` is composed by `Integer`.

## Integral_NN

        Integral_NN : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Integral args:.\0 and_then guard
                args:.\0 >= zero::(args:.\0)),
        )),

The selection type definer `Integral_NN` represents the infinite type
consisting just of the `Integral` values that are non-negative.  Its
default and minmum value is `0`; it has no maximum value.

## Integral_P

        Integral_P : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Integral_NN::(args:.\0) and_then guard
                args:.\0 > zero::(args:.\0)),
            default : (succ::(Integral::(\Tuple:{}))),
        )),

The selection type definer `Integral_P` represents the infinite type
consisting just of the `Integral_NN` values that are positive.  Its
default and minmum value is `1`; it has no maximum value.

## --

        '--' : (\Function : (
            returns : (\Set:[::Integral, ::Before_All_Others]),
            matches : (\Tuple:{::Integral}),
            evaluates : (pred args:.\0),
        )),

The function `--` results in the *predecessor* value of its `0`
argument, or in `(::Before_All_Others : (\Tuple:{}))` if there is none.  It is an integral numeric
specific alias for the `Bicessable` virtual function `pred`.  Other
programming languages may name their corresponding operators *decrement*.

## ++

        '++' : (\Function : (
            returns : (\Set:[::Integral, ::After_All_Others]),
            matches : (\Tuple:{::Integral}),
            evaluates : (succ args:.\0),
        )),

The function `++` results in the *successor* value of its `0` argument,
or in `(::After_All_Others : (\Tuple:{}))` if there is none.  It is an integral numeric specific
alias for the `Successable` virtual function `succ`.  Other programming
languages may name their corresponding operators *increment*.

## to_Integer

        to_Integer::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Integer,
            matches : (\Tuple:{::Integral}),
        )),

The virtual function `to_Integer` results in the `Integer` value that
represents the same integer value as its `0` argument.  The purpose of
`to_Integer` is to canonicalize `Integral` values so they can be compared
abstractly as integers, or so that it is easier to do exact math with
integers without running afoul of possible range limits of fixed-size
`Integral` types, just dealing with the latter for storage.

## factorial

        factorial::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Integral_P,
            matches : (\Tuple:{::Integral_NN}),
        )),

The virtual function `factorial` results in the integral numeric
*factorial* of its `0` argument, and is a shorthand for the product of
every integer between 1 and that argument; the factorial of zero is defined
to result in positive one.  Note that typical mathematical notion writes
this operator in postfix like *n!*.

## gcd greatest_common_divisor

        gcd : (\Function : (
            returns : ::Integral_P,
            matches : (\Tuple:{::Integral_NN, ::Integral_NN}),
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            is_idempotent : 0bTRUE,
            evaluates : ((if is_zero args:.\1 then args:.\0
                else guard material::(args:.\1, mod::(args:.\0, args:.\1, RM::(\To_Zero))))
                note "Calculate using the Euclidean algorithm."),
        )),

        greatest_common_divisor : (\Alias : (\Tuple:{ of : ::gcd })),

The function `gcd` aka `greatest_common_divisor` results in the integral
numeric *greatest common divisor* of its 2 arguments `0` and `1`, which
is the largest integer that will divide both arguments evenly.
*TODO: Look into generalizing it to take negative integer arguments too.*

## lcm least_common_multiple

        lcm : (\Function : (
            returns : ::Integral_NN,
            matches : (\Tuple:{::Integral_NN, ::Integral_NN}),
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            is_idempotent : 0bTRUE,
            evaluates : (if is_zero args:.\0 or is_zero args:.\1 then zero args:.\0
                else guard div::(args:.\0 * args:.\1, args:.\0 gcd args:.\1, RM::(\To_Zero))),
        )),

        least_common_multiple : (\Alias : (\Tuple:{ of : ::lcm })),

The function `lcm` aka `least_common_multiple` results in the integral
numeric *least common multiple* of its 2 arguments `0` and `1`, which
is the smallest integer that is an even multiple of both arguments.
*TODO: Look into generalizing it to take negative integer arguments too.*

## coprime

        coprime : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Integral, ::Integral}),
            evaluates : ((abs::(args:.\0) gcd abs::(args:.\1)) = succ::(zero args:.\0)),
        )),

The function `coprime` results in `0bTRUE` iff its 2 arguments `0` and
`1` are coprime (their *greatest common divisor* is 1), and `0bFALSE`
otherwise.

# INTEGER DATA TYPES

## Integer

        Integer::'' : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Integral]),
            provides_default_for : (\Set:[::Integral]),
            evaluates : \foundation::Integer(\Tuple:{}),
            default : 0,
        )),

The selection type definer `Integer` represents
the infinite foundation type `foundation::Integer`.
An `Integer` value is a general purpose exact integral number of any
magnitude, which explicitly does not represent any kind of
thing in particular, neither cardinal nor ordinal nor nominal.
`Integer` has a default value of `0`.
`Integer` is both `Orderable` and `Bicessable`;
it has no minimum or maximum value.
Other programming languages may name their corresponding types *BigInt*
or *Bignum* or *BigInteger*.

## Integer_NN

        Integer_NN : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[\Integer::(\Tuple:{}), \'>='::( 1: 0 )]),
        )),

The selection type definer `Integer_NN` represents the infinite type
consisting just of the `Integer` values that are non-negative.  Its
default and minmum value is `0`; it has no maximum value.

## Integer_P

        Integer_P : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[\Integer_NN::(\Tuple:{}), \'>'::( 1: 0 )]),
            default : 1,
        )),

The selection type definer `Integer_P` represents the infinite type consisting
just of the `Integer_NN` values that are positive.  Its default and minmum
value is `1`; it has no maximum value.

## in_order (Integer)

        in_order::Integer : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Integer, ::Integer}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Integer_in_order(\Tuple:{})),
        )),

The function `in_order::Integer` implements the `Orderable` virtual
function `in_order` for the composing type `Integer`.

## asset (Integer)

        asset::Integer : (\Function : (
            returns : ::Integer,
            matches : (\Tuple:{::Integer}),
            implements : folder::'',
            evaluates : (args:.\0),
        )),

The function `asset::Integer` simply results in its `0` argument.
This function implements the `Successable` virtual function `asset` for
the composing type `Integer`.

## nth_pred (Integer)

        nth_pred::Integer : (\Function : (
            returns : ::Integer,
            matches : (\Tuple:{::Integer, ::Integer_NN}),
            implements : folder::Integral,
            evaluates : (args:.\0 - args:.\1),
        )),

The function `nth_pred::Integer` implements the `Bicessable`
virtual function `nth_pred` for the composing type `Integer`.

## nth_succ (Integer)

        nth_succ::Integer : (\Function : (
            returns : ::Integer,
            matches : (\Tuple:{::Integer, ::Integer_NN}),
            implements : folder::Integral,
            repeater : plus::Integer,
            evaluates : (args:.\0 + args:.\1),
        )),

The function `nth_succ::Integer` implements the `Successable`
virtual function `nth_succ` for the composing type `Integer`.

## not_zero (Integer)

        not_zero::Integer : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Integer}),
            implements : folder::'',
            evaluates : (args:.\0 != 0),
        )),

The function `not_zero::Integer` results in `0bTRUE` iff its `0`
argument is not `0`, and in `0bFALSE` if it is `0`.  This function
implements the `Numerical` virtual function `not_zero`
for the composing type `Integer`.

## zero (Integer)

        zero::Integer : (\Function : (
            returns : ::Integer,
            matches : (\Tuple:{::Integer}),
            implements : folder::'',
            evaluates : (0),
        )),

The function `zero::Integer` simply results in `0`.  This function
implements the `Numerical` virtual function `zero` for the composing type
`Integer`.

## opposite (Integer)

        opposite::Integer : (\Function : (
            returns : ::Integer,
            matches : (\Tuple:{::Integer}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Integer_opposite(\Tuple:{})),
        )),

The function `opposite::Integer` implements the `Numerical` virtual
function `opposite` aka `additive_inverse` aka unary `-` aka unary `−`
for the composing type `Integer`.

## reciprocal (Integer)

        reciprocal::Integer : (\Function : (
            returns : (\Set:[::Rational, ::Div_By_Zero]),
            matches : (\Tuple:{::Integer}),
            implements : folder::'',
            evaluates : (1 / args:.\0),
        )),

The function `reciprocal::Integer` implements the `Numerical` virtual
function `reciprocal` aka `multiplicative_inverse` for the composing type
`Integer`.

## modulus (Integer)

        modulus::Integer : (\Function : (
            returns : ::Integer_NN,
            matches : (\Tuple:{::Integer}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Integer_modulus(\Tuple:{})),
        )),

The function `modulus::Integer` implements the `Numerical`
virtual function `modulus` aka `abs` for the composing type `Integer`.

## plus (Integer)

        plus::Integer : (\Function : (
            returns : ::Integer,
            matches : (\Tuple:{::Integer, ::Integer}),
            implements : folder::'',
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            identity : 0,
            repeater : times::Integer,
            evaluates : (evaluates args --> \foundation::Integer_plus(\Tuple:{})),
        )),

The function `plus::Integer` implements the `Numerical`
virtual function `plus` aka `+` for the composing type `Integer`.

## minus (Integer)

        minus::Integer : (\Function : (
            returns : ::Integer,
            matches : (\Tuple:{::Integer, ::Integer}),
            implements : folder::'',
            right_identity : 0,
            evaluates : (evaluates args --> \foundation::Integer_minus(\Tuple:{})),
        )),

The function `minus::Integer` implements the `Numerical` virtual function
`minus` aka binary `-` aka binary `−` for the composing type `Integer`.

## times (Integer)

        times::Integer : (\Function : (
            returns : ::Integer,
            matches : (\Tuple:{::Integer, ::Integer}),
            implements : folder::'',
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            identity : 1,
            repeater : integral_nn_power::Integer,
            evaluates : (evaluates args --> \foundation::Integer_times(\Tuple:{})),
        )),

The function `times::Integer` implements the `Numerical` virtual function
`times` aka `*` aka `×` for the composing type `Integer`.

## multiple_of (Integer)

        multiple_of::Integer : (\Function : (
            returns : (\Set:[::Boolean, ::Div_By_Zero]),
            matches : (\Tuple:{::Integer, ::Integer}),
            implements : folder::'',
            evaluates : (if args:.\1 = 0 then (::Div_By_Zero : (\Tuple:{}))
                else guard evaluates args --> \foundation::Integer_multiple_of(\Tuple:{})),
        )),

The function `multiple_of::Integer` implements the `Numerical`
virtual function `multiple_of` for the composing type `Integer`.

## fractional_divided_by (Integer)

        fractional_divided_by::Integer : (\Function : (
            returns : (\Set:[::Rational, ::Div_By_Zero]),
            matches : (\Tuple:{::Integer, ::Integer}),
            implements : folder::'',
            right_identity : 1,
            evaluates : (
                n ::= args:.\0;
                d ::= args:.\1;

                returns if d = 0 then (::Div_By_Zero : (\Tuple:{})) else guard q;

                q ::= (\Rational : (
                    numerator   : div::((if d > 0 then n else -n), gcd, RM::(\To_Zero)),
                    denominator : div::((if d > 0 then d else -d), gcd, RM::(\To_Zero)),
                ));

                gcd ::= gcd::(abs::(n), abs::(d));
            ),
        )),

The function `fractional_divided_by::Integer` implements the `Numerical`
virtual function `fractional_divided_by` aka `/` aka `÷` aka `∕` for
the composing type `Integer`.

## integral_divided_by (Integer)

        integral_divided_by::Integer : (\Function : (
            returns : (\Set:[::Integer, ::Div_By_Zero]),
            matches : (\Tuple:{::Integer, ::Integer, ::Round_Meth}),
            implements : folder::'',
            right_identity : 1,
            evaluates : (
                dividend   ::= args:.\0;
                divisor    ::= args:.\1;
                round_meth ::= args:.\2;

                returns if divisor = 0 then (::Div_By_Zero : (\Tuple:{})) else guard e1;

                e1 note "This is the case where we are dividing by a non-zero.";

                e1 ::=   if dividend = 0       then 0
                    else if divisor  = 1       then dividend
                    else if dividend = divisor then 1
                    else if divisor  = -1      then -dividend
                    else                            e2
                ;

                e2 note "This is the case where the divisor and dividend do not"
                    " equal each other and neither of them is a zero or a one.";

                e2 ::= (
                    real_q_is_neg ::= dividend < 0 xor divisor < 0;
                    rtz_quotient  ::= foundation::Integer_divided_by_rtz(\Tuple:{dividend, divisor});
                    rtz_remainder ::= dividend - (divisor * rtz_quotient);

                    returns if rtz_remainder = 0 then rtz_quotient else e3;
                );

                e3 note "This is the case where the divisor does not divide the"
                    " dividend evenly and the real number division result would"
                    " have a fractional part, so we decide how to round that.";

                e3 ::= (
                    rti_quotient ::= rtz_quotient + (if real_q_is_neg then -1 else 1);
                    rdn_quotient ::= rtz_quotient + (if real_q_is_neg then -1 else 0);
                    rup_quotient ::= rtz_quotient + (if real_q_is_neg then  0 else 1);

                    returns given round_meth
                        when RM::(\Down)    then rdn_quotient
                        when RM::(\Up)      then rup_quotient
                        when RM::(\To_Zero) then rtz_quotient
                        when RM::(\To_Inf)  then rti_quotient
                        default
                                 if (2 * abs::(rtz_remainder)) < abs::(divisor) then rtz_quotient
                            else if (2 * abs::(rtz_remainder)) > abs::(divisor) then rti_quotient
                            else e4
                    ;
                );

                e4 note "This is the case where real division remainder is"
                    " exactly one-half so we decide how to round that.";

                e4 ::= (
                    q ::= foundation::Integer_divided_by_rtz(abs::(rtz_quotient),2)
                    r ::= abs::(rtz_quotient) - (2 * q);
                    rtz_quotient_is_even ::= r = 0;

                    returns given round_meth
                        when RM::(\Half_Down)    then rdn_quotient
                        when RM::(\Half_Up)      then rup_quotient
                        when RM::(\Half_To_Zero) then rtz_quotient
                        when RM::(\Half_To_Inf)  then rti_quotient
                        when RM::(\Half_Even)    then
                            (if rtz_quotient_is_even then rtz_quotient else rti_quotient)
                        when RM::(\Half_Odd)     then
                            (if rtz_quotient_is_even then rti_quotient else rtz_quotient)
                        default fail  `oops, an unhandled case`
                    ;
                );
            ),
        )),

The function `integral_divided_by::Integer` implements the `Numerical`
virtual function `integral_divided_by` aka `div` for the composing type
`Integer`.

## integral_power (Integer)

        integral_power::Integer : (\Function : (
            returns : (\Set:[::Rational, ::Zero_To_The_Zero]),
            matches : (\Tuple:{::Integer, ::Integer}),
            implements : folder::'',
            evaluates : (if args:.\0 = 0 and args:.\1 = 0 then (::Zero_To_The_Zero : (\Tuple:{}))
                else guard args:.\0 / 1 ** args:.\1),
        )),

The function `integral_power::Integer` implements the `Numerical` virtual
function `integral_power` aka `**` for the composing type `Integer`.

## integral_nn_power (Integer)

        integral_nn_power::Integer : (\Function : (
            returns : (\Set:[::Integer, ::Zero_To_The_Zero]),
            matches : (\Tuple:{::Integer, ::Integer_NN}),
            implements : folder::'',
            evaluates : (if args:.\0 = 0 and args:.\1 = 0 then (::Zero_To_The_Zero : (\Tuple:{}))
                else guard evaluates args --> \foundation::Integer_nn_power(\Tuple:{})),
        )),

The function `integral_nn_power::Integer` implements the `Numerical`
virtual function `integral_nn_power` aka `power` for the composing type
`Integer`.

## to_Integer (Integer)

        to_Integer::Integer : (\Function : (
            returns : ::Integer,
            matches : (\Tuple:{::Integer}),
            implements : folder::'',
            evaluates : (args:.\0),
        )),

The function `to_Integer::Integer` simply results in its `0` argument.
This function implements the `Integral` virtual function `to_Integer` for
the composing type `Integer`.

## factorial (Integer)

        factorial::Integer : (\Function : (
            returns : ::Integer_P,
            matches : (\Tuple:{::Integer_NN}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Integer_factorial(\Tuple:{})),
        )),

The function `factorial::Integer` implements the `Integral` virtual
function `factorial` for the composing type `Integer`.

# FRACTIONAL DATA TYPES

## Fractional

        Fractional::'' : (\Function : (
            is_type_definer : 0bTRUE,
            is_generalization : 0bTRUE,
            composes : (\Set:[::Orderable, ::Numerical]),
        )),

The interface type definer `Fractional` is semifinite.  A `Fractional` value
either is a rational exact numeric of some kind, expressible as a coprime
*numerator* / *denominator* pair of `Integral` whose *denominator* is
positive, or is something that can act as such.  Idiomatically a
`Fractional` is a pure rational number which does not represent any kind
of thing in particular, neither cardinal nor ordinal nor nominal; however
some types which do represent such a particular kind of thing may choose to
compose `Fractional` because it makes sense to provide its operators.  The
default value of `Fractional` is the `Rational` value `0.0`.
`Fractional` is `Orderable`; for each type composing `Fractional`, a
value closer to negative infinity is ordered before a value closer to
positive infinity.  In the general case it is not `Bicessable` nor does it
have a minimum or maximum value, but sometimes a type that is `Fractional`
will have either of those.  `Fractional` is composed by `Rational`.

## Fractional_NN

        Fractional_NN : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Fractional args:.\0 and_then guard
                args:.\0 >= zero::(args:.\0)),
        )),

The selection type definer `Fractional_NN` represents the infinite type
consisting just of the `Fractional` values that are non-negative.  Its
default and minmum value is `0.0`; it has no maximum value.

## to_Rational

        to_Rational::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Rational,
            matches : (\Tuple:{::Fractional}),
        )),

The virtual function `to_Rational` results in the `Rational` value that
represents the same rational value as its `0` argument.  The purpose of
`to_Rational` is to canonicalize `Fractional` values so they can be
compared abstractly as rationals, or so that it is easier to do exact math
with rationals without running afoul of possible range limits of fixed-size
`Fractional` types, just dealing with the latter for storage.

## numerator

        numerator::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Integral,
            matches : (\Tuple:{::Fractional}),
        )),

The virtual function `numerator` results in the *numerator* of its
`0` argument, when the latter is expressed as a coprime *numerator* /
*denominator* pair of `Integral` whose *denominator* is positive.

## denominator

        denominator::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Integral_P,
            matches : (\Tuple:{::Fractional}),
        )),

The virtual function `denominator` results in the *denominator* of its
`0` argument, when the latter is expressed as a coprime *numerator* /
*denominator* pair of `Integral` whose *denominator* is positive.

# FRACTION DATA TYPES

## Rational

        Rational::'' : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Fractional]),
            provides_default_for : (\Set:[::Fractional]),
            evaluates : (Signature::Article_Match : (
                label : \Rational,
                attrs : (\Array:[
                    (
                        numerator : \Integer::(\Tuple:{}),
                        denominator : \Integer_P::(\Tuple:{}),
                    ),
                    \(args:.\0:.\numerator coprime args:.\0:.\denominator),
                ]),
            )),
            default : 0.0,
        )),

The selection type definer `Rational`
represents the infinite foundation type `foundation::Rational`.
A `Rational` value is a general purpose exact rational number of any
magnitude and precision, which explicitly does not represent any
kind of thing in particular, neither cardinal nor ordinal nor nominal.
A `Rational` value is characterized by the pairing of a *numerator*,
which is an `Integer` value, with a *denominator*, which is an
`Integer` value that is non-zero.
The intended interpretation of a `Rational` is as the rational number
that results from evaluating the given 2 integers as the mathematical
expression `numerator/denominator`, such that `/` means divide.
Canonically the *numerator* / *denominator* pair is normalized/reduced/coprime.
`Rational` has a default value of `0.0`.
`Rational` is `Orderable`; it has no minimum or maximum value.
Other programming languages may name their corresponding types *BigRat*
or *Rational*.

## Rational_NN

        Rational_NN : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[\Rational::(\Tuple:{}), \'>='::( 1: 0.0 )]),
        )),

The selection type definer `Rational_NN` represents the infinite type
consisting just of the `Rational` values that are non-negative.  Its
default and minmum value is `0.0`; it has no maximum value.

## in_order (Rational)

        in_order::Rational : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Rational, ::Rational}),
            implements : folder::'',
            evaluates : (
                if (denominator args:.\0) = (denominator args:.\1)
                    then in_order::(\Tuple:{numerator args:.\0, numerator args:.\1})
                else
                  (
                    common_d ::= lcm::(\Tuple:{denominator args:.\0, denominator args:.\1});
                    returns in_order::(
                        (numerator args:.\0) * div::(common_d, denominator args:.\0, RM::(\To_Zero)),
                        (numerator args:.\1) * div::(common_d, denominator args:.\1, RM::(\To_Zero)),
                    );
                  )
            ),
        )),

The function `in_order::Rational` implements the `Orderable` virtual
function `in_order` for the composing type `Rational`.

## not_zero (Rational)

        not_zero::Rational : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Rational}),
            implements : folder::'',
            evaluates : (args:.\0 != 0.0),
        )),

The function `not_zero::Rational` results in `0bTRUE` iff its `0`
argument is not `0.0`, and in `0bFALSE` if it is `0.0`.  This function
implements the `Numerical` virtual function `not_zero`
for the composing type `Rational`.

## zero (Rational)

        zero::Rational : (\Function : (
            returns : ::Rational,
            matches : (\Tuple:{::Rational}),
            implements : folder::'',
            evaluates : (0.0),
        )),

The function `zero::Rational` simply results in `0.0`.  This function
implements the `Numerical` virtual function `zero` for the composing type
`Rational`.

## opposite (Rational)

        opposite::Rational : (\Function : (
            returns : ::Rational,
            matches : (\Tuple:{::Rational}),
            implements : folder::'',
            evaluates : (-(numerator args:.\0) / (denominator args:.\0)),
        )),

The function `opposite::Rational` implements the `Numerical` virtual
function `opposite` aka `additive_inverse` aka unary `-` aka unary `−`
for the composing type `Rational`.

## reciprocal (Rational)

        reciprocal::Rational : (\Function : (
            returns : (\Set:[::Rational, ::Div_By_Zero]),
            matches : (\Tuple:{::Rational}),
            implements : folder::'',
            evaluates : (if args:.\0 = 0.0 then (::Div_By_Zero : (\Tuple:{}))
                else guard (denominator args:.\0) / (numerator args:.\0)),
        )),

The function `reciprocal::Rational` implements the `Numerical` virtual
function `reciprocal` aka `multiplicative_inverse` for the composing type
`Rational`.

## modulus (Rational)

        modulus::Rational : (\Function : (
            returns : ::Rational_NN,
            matches : (\Tuple:{::Rational}),
            implements : folder::'',
            evaluates : (abs::(numerator args:.\0) / (denominator args:.\0)),
        )),

The function `modulus::Rational` implements the `Numerical`
virtual function `modulus` aka `abs` for the composing type `Rational`.

## plus (Rational)

        plus::Rational : (\Function : (
            returns : ::Rational,
            matches : (\Tuple:{::Rational, ::Rational}),
            implements : folder::'',
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            identity : 0.0,
            repeater : times::Rational_Integer,
            evaluates : (
                if (denominator args:.\0) = (denominator args:.\1)
                    then (numerator args:.\0) + (numerator args:.\1) / (denominator args:.\0)
                else
                  (
                    common_d ::= lcm::(\Tuple:{denominator args:.\0, denominator args:.\1});
                    returns ((numerator args:.\0) * div::(common_d, denominator args:.\0, RM::(\To_Zero)))
                        + ((numerator args:.\1) * div::(common_d, denominator args:.\1, RM::(\To_Zero)))
                        / common_d;
                  )
            ),
        )),

The function `plus::Rational` implements the `Numerical`
virtual function `plus` aka `+` for the composing type `Rational`.

## minus (Rational)

        minus::Rational : (\Function : (
            returns : ::Rational,
            matches : (\Tuple:{::Rational, ::Rational}),
            implements : folder::'',
            right_identity : 0.0,
            evaluates : (args:.\0 + -args:.\1),
        )),

The function `minus::Rational` implements the `Numerical` virtual function
`minus` aka binary `-` aka binary `−` for the composing type `Rational`.

## times (Rational)

        times::Rational : (\Function : (
            returns : ::Rational,
            matches : (\Tuple:{::Rational, ::Rational}),
            implements : folder::'',
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            identity : 1.0,
            repeater : integral_nn_power::Rational,
            evaluates : (((numerator args:.\0) * (numerator args:.\1))
                / ((denominator args:.\0) * (denominator args:.\1))),
        )),

The function `times::Rational` implements the `Numerical` virtual function
`times` aka `*` aka `×` for the composing type `Rational`.

## times (\Tuple:{Rational, Integer})

        times::Rational_Integer : (\Function : (
            returns : ::Rational,
            matches : (\Tuple:{::Rational, ::Integer}),
            implements : folder::'',
            evaluates : (((numerator args:.\0) * args:.\1) / (denominator args:.\0)),
        )),

The function `times::Rational_Integer` implements the `Numerical` virtual
function `times` aka `*` aka `×` for the composing type `Rational`,
specifically for multiplying one by an `Integer`.

## multiple_of (Rational)

        multiple_of::Rational : (\Function : (
            returns : (\Set:[::Boolean, ::Div_By_Zero]),
            matches : (\Tuple:{::Rational, ::Rational}),
            implements : folder::'',
            evaluates : (if args:.\1 = 0.0 then (::Div_By_Zero : (\Tuple:{}))
                else guard (args:.\0 mod args:.\1) = 0.0),
        )),

The function `multiple_of::Rational` implements the `Numerical`
virtual function `multiple_of` for the composing type `Rational`.

## fractional_divided_by (Rational)

        fractional_divided_by::Rational : (\Function : (
            returns : (\Set:[::Rational, ::Div_By_Zero]),
            matches : (\Tuple:{::Rational, ::Rational}),
            implements : folder::'',
            right_identity : 1.0,
            evaluates : (if args:.\1 = 0.0 then (::Div_By_Zero : (\Tuple:{}))
                else guard args:.\0 * reciprocal::(args:.\1)),
        )),

The function `fractional_divided_by::Rational` implements the `Numerical`
virtual function `fractional_divided_by` aka `/` aka `÷` aka `∕` for
the composing type `Rational`.

## integral_divided_by (Rational)

        integral_divided_by::Rational : (\Function : (
            returns : (\Set:[::Rational, ::Div_By_Zero]),
            matches : (\Tuple:{::Rational, ::Rational, ::Round_Meth}),
            implements : folder::'',
            right_identity : 1.0,
            evaluates : (
                d ::= lcm::(\Tuple:{denominator args:.\0, denominator args:.\1});
                n0 ::= (numerator args:.\0) * div::(d, denominator args:.\0, RM::(\To_Zero));
                n1 ::= (numerator args:.\1) * div::(d, denominator args:.\1, RM::(\To_Zero));
                returns if args:.\1 = 0.0 then (::Div_By_Zero : (\Tuple:{}))
                    else guard div::(\Tuple:{n0 * d, n1 * d, args:.\2}) / 1;
            ),
        )),

The function `integral_divided_by::Rational` implements the `Numerical`
virtual function `integral_divided_by` aka `div` for the composing type
`Rational`.

## integral_power (Rational)

        integral_power::Rational : (\Function : (
            returns : (\Set:[::Rational, ::Zero_To_The_Zero]),
            matches : (\Tuple:{::Rational, ::Integer}),
            implements : folder::'',
            evaluates : (evaluates \integral_nn_power::(\Tuple:{})
                <-- (if args:.\1 >= 0 then args else (reciprocal::(args:.\0), -args:.\1))),
        )),

The function `integral_power::Rational` implements the `Numerical` virtual
function `integral_power` aka `**` for the composing type `Rational`.

## integral_nn_power (Rational)

        integral_nn_power::Rational : (\Function : (
            returns : (\Set:[::Rational, ::Zero_To_The_Zero]),
            matches : (\Tuple:{::Rational, ::Integer_NN}),
            implements : folder::'',
            evaluates : (if args:.\0 = 0.0 and args:.\1 = 0 then (::Zero_To_The_Zero : (\Tuple:{}))
                else guard ((numerator args:.\0) ** args:.\1) / ((denominator args:.\0) ** args:.\1)),
        )),

The function `integral_nn_power::Rational` implements the `Numerical`
virtual function `integral_nn_power` aka `power` for the composing type
`Rational`.

## to_Rational (Rational)

        to_Rational::Rational : (\Function : (
            returns : ::Rational,
            matches : (\Tuple:{::Rational}),
            implements : folder::'',
            evaluates : (args:.\0),
        )),

The function `to_Rational::Rational` simply results in its `0` argument.
This function implements the `Fractional` virtual function `to_Rational`
for the composing type `Rational`.

## numerator (Rational)

        numerator::Rational : (\Function : (
            returns : ::Integer,
            matches : (\Tuple:{::Rational}),
            evaluates : (args:.\0:>.\numerator),
        )),

The function `numerator::Rational` implements the `Fractional` virtual
function `numerator` for the composing type `Rational`.

## denominator (Rational)

        denominator::Rational : (\Function : (
            returns : ::Integer_P,
            matches : (\Tuple:{::Rational}),
            evaluates : (args:.\0:>.\denominator),
        )),

The function `denominator::Rational` implements the `Fractional` virtual
function `denominator` for the composing type `Rational`.

# COLLECTIVE DATA TYPES OVERVIEW

A *collective* value either is a generic regular aggregate of a
multiplicity of other, *component*, values whose composition is
transparent to the user or is something that can act as such an aggregate.
The `System` package provides *collective* types with a variety of
desirable alternative properties.

Some *collective* values are fully *discrete* and so their components can
be enumerated as individuals and counted, while other collective values are
at least partially *continuous* and so at least some of their components
can not be enumerated or counted (the count is effectively an infinity);
however it is still possible to test the membership of a value in such a
collective.  `Interval` is an example of a typically-continuous type while
most collective types provided by `System` are discrete; however, an
`Interval` can be treated as a discrete type iff the types it ranges over
are `Bicessable`.

Some *collective* values are *positional* and define an explicit total
order for their components which does not necessarily depend on any order
specific to the component values themselves, and which does not necessarily
place multiple same-valued components consecutively.  Such a collective
value can reliably and consistently enumerate its components in its defined
order, and the collective also supports integral ordinal-position-based lookup of its
members where each member lives at a distinct ordinal position.  In contrast,
*nonpositional* collective values simply track what values their
components are and don't provide ordinal-position-based lookup; those that are
enumerable do not guarantee that components are returned in any particular
order.  An example positional type is `Array` while example nonpositional
types are `Set`, `Bag`, `Relation`, and `Interval`.  Some *positional*
types are *sorted*, ensuring that components are organized in the
collection corresponding to a total order that is specific to the component
values themselves, meaning also that all same-valued components are
consecutive; *nonsorted* positional types don't do this.

Some *collective* values are *setty*, ensuring that each of their
components is unique, while other collective values are *baggy*,
permitting multiple components to be the same value.  Examples of setty
types are `Set`, `Relation`, and `Interval`, while examples of baggy
types are `Array` and `Bag`.  Some setty types may silently avoid
duplicate values, where adding the same value twice has the same effect as
adding it once, while other setty types may raise an error if adding a
duplicate value is attempted.

The *collective* types provided by the `System` package all speak to a
space having two orthogonal dimensions into which their components are
logically arranged, where one dimension is called *homogeneous* and the
other dimension is called *attributive*.  A *collective* value's
components addressed in terms of their location along its *homogeneous*
dimension are called *members* of the collective, while components
addressed in terms of their location along its *attributive* dimension are
called *attributes*.  To be more accurate, a *member* is a slice of the
space that includes all components with the same single location along the
homogeneous dimension, while an *attribute* is a slice of the space that
includes all components with the same single location along the attributive
dimension; in many contexts, said slice is considered as a single value of
its own.  Every *member* of a collective value is conceptually of a common
data type with its fellow members or should be interpreted logically in the
same way.  Every *attribute* of a collective value is conceptually of its
own data type or should be interpreted logically in a distinct way from its
fellow attributes.

While many collective types just utilize one of the dimensions
*homogeneous* or *attributive*, some utilize both.  Values of the
`Array`, `Set`, `Bag`, `Interval` types each arrange their components
along just the *homogeneous* dimension and ignore *attributive*, so for
brevity we just say their components *are* members.  Values of the
`Tuple` type each arrange their components along just the *attributive*
dimension and ignore *homogeneous*, so for brevity we just say their
components *are* attributes.  Values of the `Relation` and `Multirelation`
types each arrange their components over both of the dimensions, so we say
they have both members and attributes.

Given that the *homogeneous* and *attributive* dimensions are to a large
extent isomorphic, and so there are a lot of corresponding operations that
apply to both, the `System` package uses different terminology and operator
names for corresponding things so it is clear what dimension is being acted
on.  For example, a `Relation` value has no single concept of its
component count, rather we say *cardinality* is a count of its members
while *degree* is a count of its attributes.  When equally terse and
pleasant terminology isn't available for a pair of corresponding concepts,
the homogeneous dimension is given priority for the nicer API since that is
expected to be the dominant one for typical usage patterns.

See the `Homogeneous` type which defines the common API for all collective
types utilizing the *homogeneous* dimension, and see the `Attributive`
type which defines the orthogonal common API for all collective types
utilizing the *attributive* dimension.  See the `Relational` type which
defines the common API for all collective types utilizing both dimensions.

See also the `Accessible` type which provides an extra API that can be
applied on a type-by-type basis to either the *homogeneous* dimension or
the *attributive* dimension (but not both) as makes the most sense for the
composing types in question; example composers are `Array` and `Tuple`
respectively for said dimensions.

# ACCESSIBLE DATA TYPES

## Accessible

        Accessible : (\Function : (\Tuple:{
            is_type_definer : 0bTRUE,
            is_generalization : 0bTRUE,
        })),

The interface type definer `Accessible` is semifinite.  An `Accessible` value
is an aggregate of other, *mapping* values such that each *mapping* is a
pair of associated other values, a *key* and *asset* respectively, such
that no 2 *key* of an `Accessible` value are the same value.  The primary
reason for `Accessible` is to provide an easy consistent and terse
accessor API for individual components in a collection of key-asset pairs,
where the pair exists at a slot addressable by its key.  An `Accessible`
value is isomorphic to a space in which 0..N slots can exist; possible
operations include testing if a slot exists, fetching the content of a
slot, replacing the content of a slot, inserting another slot, removing an
existing slot.  `Accessible` does not have anything to say about other
qualities of its composers, such as on matters of enumerating components or
slicing a subset of components into a new collection, and so composers
might have little in common besides sharing certain operator names.

If an `Accessible` value is also `Positional`, then each of its
*key*/*asset* pairs is actually an *ordinal-position*/*member* pair, and all of
its keys must be adjacent `Integer`; therefore, since each `Accessible`
operation may only affect 1 slot at a time, it is only valid to insert or
remove a slot at the `first_unused_ord_pos` or `last_ord_pos` respectively.
Other composers of `Accessible` may have their own restrictions on
inserting or removing slots besides key uniqueness, but typically don't.

The default value of `Accessible` is the `Tuple` value with zero
attributes, `(\Tuple:{})`.  `Accessible` is composed, directly or indirectly, by:
`Positional`, `Array`, `Orderelation`, `Structural`, `Tuple`.
*TODO: Also composed by Dictionary.*

Note that this interface type definer could have as easily been mamed
*Associative*, but it wasn't so that term could be reserved for the
`associative` function trait which has a different meaning.

## has_any_at .?

        has_any_at::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Boolean,
            matches : (\Tuple:{::Accessible, ::Any}),
        )),

        '.?' : (\Alias : (\Tuple:{ of : ::has_any_at })),

The virtual function `has_any_at` aka `.?` results in `0bTRUE` iff its
`0` argument has a mapping whose key is equal to its `1` argument;
otherwise it results in `0bFALSE`.  Other programming languages may name
their corresponding operators *ContainsKey* or *has_key?* or *key?* or
*exists* or *in* or *array_key_exists*.

## not_has_any_at .!?

        not_has_any_at : (\Function : (\Tuple:{
            negates : ::has_any_at,
        })),

        '.!?' : (\Alias : (\Tuple:{ of : ::not_has_any_at })),

The function `not_has_any_at` aka `.!?` results in `0bTRUE` iff its `0`
argument does not have any mapping whose key is equal to its `1` argument;
otherwise it results in `0bFALSE`.

## has_mapping_at .:?

        has_mapping_at::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Boolean,
            matches : (Accessible, (\Tuple:{Any, Any})),
        )),

        '.:?' : (\Alias : (\Tuple:{ of : ::has_mapping_at })),

The virtual function `has_mapping_at` aka `.:?` results in `0bTRUE` iff
its `0` argument has a mapping that is equal to its `1` argument;
otherwise it results in `0bFALSE`.  The `1` argument is a binary `Tuple`
whose `0` and `1` attributes are the mapping key and asset respectively.

## mapping_at .:

        mapping_at::'' : (\Function : (
            virtual : 0bTRUE,
            returns : (\Tuple:{::Any, ::Any}),
            matches : (\Tuple:{::Accessible, ::Any}),
            accepts : (args:.\0 .? args:.\1),
        )),

        '.:' : (\Alias : (\Tuple:{ of : ::mapping_at })),

The virtual function `mapping_at` aka `.:` results in a binary `Tuple`
whose `0` attribute is the function's `1` argument and whose `1`
attribute is the asset value of the mapping of its `0` argument where that
mapping's key is equal to its `1` argument.  Other programming languages
may name their corresponding operators *assoc*.

## at .

        at::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Any,
            matches : (\Tuple:{::Accessible, ::Any}),
            accepts : (args:.\0 .? args:.\1),
        )),

        '.' : (\Alias : (\Tuple:{ of : ::at })),

The virtual function `at` aka `.` results in the asset value of the
mapping of its `0` argument where that mapping's key is equal to its `1`
argument.  This function will fail if the `0` argument doesn't have such a
mapping.  Other programming languages may name their corresponding
operators *ElementAt* or *fetch*; it is also common to use
subscript/postcircumfix syntax.

## maybe_at .!

        maybe_at::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Any,
            matches : (\Tuple:{::Accessible, ::Any}),
        )),

        '.!' : (\Alias : (\Tuple:{ of : ::maybe_at })),

The virtual function `maybe_at` aka `.!` results in the asset value of
the mapping of its `0` argument where that mapping's key is equal to its
`1` argument, iff there is such a mapping; otherwise it results in an
`Excuse`.  Other programming languages may name their corresponding
operators *ElementAtOrDefault* or *at* or *get* or *fetch*; it is also
common to use subscript/postcircumfix syntax.

## replace_at .:=

        replace_at::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Accessible,
            matches : (Accessible, (\Tuple:{Any, Any})),
            accepts : (args:.\0 .? (args:.\1.\0)),
        )),

        '.:=' : (\Alias : (\Tuple:{ of : ::replace_at })),

The virtual function `replace_at` aka `.:=` results in the value of its
`0` argument's collection type that has all of the mappings of the
function's `0` argument but that, for the 1 mapping of the `0` argument
whose key *K* is equal to the function's `1` argument's `0` attribute,
the result's mapping instead has an asset equal to the `1` argument's `1`
attribute.  This function will fail if the `0` argument doesn't have a
mapping with the key *K*.  Other programming languages commonly use
assignment syntax.

## shiftless_insert_at .+

        shiftless_insert_at::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Accessible,
            matches : (Accessible, (\Tuple:{Any, Any})),
            accepts : (not args:.\0 .? (args:.\1.\0)),
        )),

        '.+' : (\Alias : (\Tuple:{ of : ::shiftless_insert_at })),

The virtual function `shiftless_insert_at` aka `.+` results in the value
of its `0` argument's collection type that has all of the mappings of the
function's `0` argument plus 1 additional mapping that is equal to its
`1` argument.  The `1` argument is a binary `Tuple` whose `0` and `1`
attributes are the mapping key and asset respectively.  This function will
fail if the `0` argument already has a mapping with that key.  Other
programming languages may name their corresponding operators *Add*; it is
also common to use assignment syntax.

## shiftless_remove_at .-

        shiftless_remove_at::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Accessible,
            matches : (\Tuple:{::Accessible, ::Any}),
            accepts : (args:.\0 .? args:.\1),
        )),

        '.-' : (\Alias : (\Tuple:{ of : ::shiftless_remove_at })),

The virtual function `shiftless_remove_at` aka `.-` results in the value
of its `0` argument's collection type that has all of the mappings of the
function's `0` argument minus 1 existing mapping whose key is equal to its
`1` argument.  This function will fail if the `0` argument doesn't have
such a mapping.  Other programming languages may name their corresponding
operators *del* or *delete_at*.

## replace_or_insert_at .=+

        replace_or_insert_at::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Accessible,
            matches : (Accessible, (\Tuple:{Any, Any})),
        )),

        '.=+' : (\Alias : (\Tuple:{ of : ::replace_or_insert_at })),

The virtual function `replace_or_insert_at` aka `.=+` behaves identically
in turn to each of the functions `replace_at` and `shiftless_insert_at`
when given the same arguments, where the `0` argument does or doesn't,
respectively, have a mapping whose key is equal to the `1` argument's `0`
attribute.  Other programming languages may name their corresponding
operators *Item* or *set* or *put* or *store* or *update*; it is also
common to use subscript/postcircumfix syntax plus assignment syntax.

## shiftless_maybe_remove_at .?-

        shiftless_maybe_remove_at::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Accessible,
            matches : (\Tuple:{::Accessible, ::Any}),
        )),

        '.?-' : (\Alias : (\Tuple:{ of : ::shiftless_maybe_remove_at })),

The virtual function `shiftless_maybe_remove_at` aka `.?-` behaves
identically to `shiftless_remove_at` when given the same arguments but
that it simply results in its `0` argument when that has no mapping whose
key matches its `1` argument, rather than fail.  Other programming
languages may name their corresponding operators *Remove* or *remove* or
*delete* or *unset*.

# HOMOGENEOUS DATA TYPES

## Homogeneous

        Homogeneous : (\Function : (\Tuple:{
            is_type_definer : 0bTRUE,
            is_generalization : 0bTRUE,
        })),

The interface type definer `Homogeneous` is semifinite.  A `Homogeneous` value
is a *collective* value such that every one of its component *members* is
conceptually of a common data type with its fellow members or should be
interpreted logically in the same way.  Idiomatically a `Homogeneous` is a
generic collection which does not as a whole represent any kind of thing in
particular, such as a text or a graphic, and is simply the sum of its
*members*; however some types which do represent such a particular kind of
thing may choose to compose `Homogeneous` because it makes sense to
provide its operators.  The default value of `Homogeneous` is the `Array`
value with zero members, `(\Array:[])`.

If a `Homogeneous` value is also `Unionable`, then another value of its
collection type can be derived by either inserting new members whose values
are distinct from those already in the collection or by removing arbitrary
members from the collection; otherwise, that may not be possible.
If a `Homogeneous` value is also `Discrete`, all of its members can be
enumerated as individuals and counted; otherwise, that may not be possible.
If a `Homogeneous` value is also `Positional`, all of its members are
arranged in an explicit total order and can both be enumerated in that
order as well as be looked up by integral ordinal position against
that order; otherwise, that may not be possible.  If a `Homogeneous` value
is also `Setty`, all of its members are guaranteed to be distinct values;
otherwise, duplication of values may occur amongst members.

`Homogeneous` is composed, directly or indirectly, by:
`Unionable`, `Discrete`, `Positional`,
`Bits`, `Blob`, `Textual`, `Text`, `Array`, `Set`, `Bag`,
`Relational`, `Orderelation`, `Relation`, `Multirelation`, `Intervalish`,
`Interval`, `Unionable_Intervalish`, `Set_Of_Interval`, `Bag_Of_Interval`.

*TODO.  Note that for all the regular function-taking member-wise
Homogeneous operators that are logically supposed to work with each
collection member in isolation and/or shouldn't put significance on either
duplicate members or member position in the collection, including the likes
of {any, where, map} etc, but not including the likes of {reduce}, the
operators will only be passing the asset portion (where applicable) of the
member to the higher-order function, and not say the ordinal-position-asset pair for a
Positional or the asset-count pair for a Baggy.  Note that for a Relation
or Multirelation each entire Tuple is the member asset, and for a Dictionary
the pair is the asset.  (\Tuple:{With the corresponding attribute-wise Tuple
operators, they are given the whole attribute name-asset pair.})  The main
reason for this is to help ensure consistency of results while supporting a
variety of collection implementations including ones that are lazy, such as
by not eagerly counting duplicates, or that use distributed computation.
For that matter, the likes of {reduce} should probably be treated the same
way; see also the 'repeater' function trait that helps optimize it.
Surely, any time when one may think these operations need to know the
baggy count or ordinal position, its for a problem best solved differently.*

## not_empty has_any_members ∅!?

        not_empty : (\Function : (
            virtual : 0bTRUE,
            returns : ::Boolean,
            matches : (\Tuple:{::Homogeneous}),
        )),

        has_any_members : (\Alias : (\Tuple:{ of : ::not_empty })),

        Unicode_Aliases::'∅!?' : (\Alias : (\Tuple:{ of : ::is_empty })),

The virtual function `not_empty` aka `has_any_members` aka `∅!?`
results in `0bTRUE` iff its `0` argument has any members, and in `0bFALSE`
iff it has no members.

## is_empty ∅?

        is_empty : (\Function : (\Tuple:{
            negates : ::not_empty,
        })),

        Unicode_Aliases::'∅?' : (\Alias : (\Tuple:{ of : ::is_empty })),

The function `is_empty` aka `∅?` results in `0bTRUE` iff its `0` argument
has no members, and in `0bFALSE` iff it has any members.
Other programming languages may name their corresponding operators *empty?*.

## empty ∅

        empty::'' : (\Function : (
            virtual : 0bTRUE,
            returns : (\Set:[::Homogeneous, ::No_Empty_Value]),
            matches : (\Tuple:{::Homogeneous}),
        )),

        Unicode_Aliases::'∅' : (\Alias : (\Tuple:{ of : ::empty })),

The virtual function `empty` aka `∅` results in the value of its `0`
argument's collection type that has zero members.  For many types like
`Text` or `Set`, this is a constant value, but for types like `Relation`
or `Multirelation`, there is a distinct result for each distinct *heading*.
Other programming languages may name their corresponding operators *clear*.

## singular

        singular::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Boolean,
            matches : (\Tuple:{::Homogeneous}),
        )),

The virtual function `singular` results in `0bTRUE` iff its `0` argument
has exactly 1 distinct member value, and `0bFALSE` otherwise.

## only_member

        only_member::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Any,
            matches : (\Tuple:{::Homogeneous}),
            accepts : (singular args:.\0),
        )),

The virtual function `only_member` results in its `0` argument's only
distinct member value.  This function will fail if the argument doesn't
have exactly 1 distinct member value.  The general deterministic way to
select a single possibly-unknown member of a `Homogeneous` value is to
first derive from the latter another `Homogeneous` value with exactly 1
distinct member (using means such as filtering or mapping or reducing) and
then use this function on the derived one.  For types such as `Set` or
`Bag` one can't select a member using an ordinal position, say, like with an
`Array`, and a general solution provided by other programming languages
for simply picking *a* member would give an effectively random one.

*TODO: See also the C# methods "Single" and "SingleOrDefault" etc.*

## in ∈

        in : (\Function : (\Tuple:{
            commutes : ::has,
        })),

        Unicode_Aliases::'∈' : (\Alias : (\Tuple:{ of : ::in })),

The function `in` aka `∈` results in `0bTRUE` iff its `0` argument is
equal to at least 1 member value of its `1` argument; otherwise it results
in `0bFALSE`.  Note that this operation is also known as *containment*.
Other programming languages may name their corresponding operators
*in_array*.

## not_in ∉

        not_in : (\Function : (\Tuple:{
            commutes : ::not_has,
        })),

        Unicode_Aliases::'∉' : (\Alias : (\Tuple:{ of : ::not_in })),

The function `not_in` aka `∉` results in `0bTRUE` iff its `0` argument is
equal to no member value of its `1` argument; otherwise it results in
`0bFALSE`.

## has ∋

        has : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Homogeneous, ::Any}),
            evaluates : (has_n::(\Tuple:{args:.\0, args:.\1, 1})),
        )),

        Unicode_Aliases::'∋' : (\Alias : (\Tuple:{ of : ::has })),

The function `has` aka `∋` results in `0bTRUE` iff its `0` argument has
at least 1 member whose value is equal to its `1` argument; otherwise it
results in `0bFALSE`.  Other programming languages may name their
corresponding operators *contains* or *exists* or *includes*.

## not_has ∌

        not_has : (\Function : (\Tuple:{
            negates : ::has,
        })),

        Unicode_Aliases::'∌' : (\Alias : (\Tuple:{ of : ::not_has })),

The function `not_has` aka `∌` results in `0bTRUE` iff its `0` argument
does not have any member whose value is equal to its `1` argument;
otherwise it results in `0bFALSE`.

## has_n

        has_n::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Boolean,
            matches : (\Tuple:{::Homogeneous, ::Any, ::Integer_NN}),
        )),

The virtual function `has_n` results in `0bTRUE` iff its `0` argument has
at least N members such that each is equal to its `1` argument, where N is
defined by its `2` argument; otherwise it results in `0bFALSE`.  The
result is always `0bTRUE` when the `2` argument is zero.  Note that
having a `2` argument greater than 1 in combination with a `Setty` typed
`0` argument will always result in `0bFALSE`.

## multiplicity

        multiplicity::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Integer_NN,
            matches : (\Tuple:{::Homogeneous, ::Any}),
        )),

The virtual function `multiplicity` results in the integral count of
members of its `0` argument such that each member value is equal to its
`1` argument.  For a `Setty` typed `0` argument, the result is always
just 0 or 1.

## all_unique

        all_unique::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Boolean,
            matches : (\Tuple:{::Homogeneous}),
        )),

The virtual function `all_unique` results in `0bTRUE` iff its `0` argument
has no 2 members that are the same value, and `0bFALSE` otherwise.  The
result is always `0bTRUE` for a `Setty` argument.

## unique

        unique::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Homogeneous,
            matches : (\Tuple:{::Homogeneous}),
        )),

The virtual function `unique` results in the value of its `0` argument's
collection type that has, for every distinct member value *V* of the
function's `0` argument, exactly 1 member whose value is equal to *V*.
The result is always the same value as its argument when that is `Setty`.
If the result's type is `Positional`, then each retained member is the one
closest to the start of the argument out of those members sharing the
retained member's value.  See also the `Positional` function `squish`.

## proper_subset_of ⊂

        proper_subset_of : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Homogeneous, ::Homogeneous}),
            evaluates : (args:.\0 != args:.\1 and (args:.\0 subset_of args:.\1)),
        )),

        Unicode_Aliases::'⊂' : (\Alias : (\Tuple:{ of : ::proper_subset_of })),

The function `proper_subset_of` aka `⊂` results in `0bTRUE` iff the
multiset of members of its `0` argument is a proper subset of the
multiset of members of its `1` argument; otherwise it results in `0bFALSE`.
Note that this operation is also known as *strict multiset inclusion*.

## not_proper_subset_of ⊄

        not_proper_subset_of : (\Function : (\Tuple:{
            negates : ::proper_subset_of,
        })),

        Unicode_Aliases::'⊄' : (\Alias : (\Tuple:{ of : ::not_proper_subset_of })),

The function `not_proper_subset_of` aka `⊄` results in `0bTRUE` iff the
multiset of members of its `0` argument is not a proper subset of the
multiset of members of its `1` argument; otherwise it results in `0bFALSE`.

## proper_superset_of ⊃

        proper_superset_of : (\Function : (\Tuple:{
            commutes : ::proper_subset_of,
        })),

        Unicode_Aliases::'⊃' : (\Alias : (\Tuple:{ of : ::proper_superset_of })),

The function `proper_superset_of` aka `⊃` results in `0bTRUE` iff the
multiset of members of its `0` argument is a proper superset of the
multiset of members of its `1` argument; otherwise it results in `0bFALSE`.

## not_proper_superset_of ⊅

        not_proper_superset_of : (\Function : (\Tuple:{
            negates : ::proper_superset_of,
        })),

        Unicode_Aliases::'⊅' : (\Alias : (\Tuple:{ of : ::not_proper_superset_of })),

The function `not_proper_superset_of` aka `⊅` results in `0bTRUE` iff the
multiset of members of its `0` argument is not a proper superset of the
multiset of members of its `1` argument; otherwise it results in `0bFALSE`.

## subset_of ⊆

        subset_of::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Boolean,
            matches : (\Tuple:{::Homogeneous, ::Homogeneous}),
        )),

        Unicode_Aliases::'⊆' : (\Alias : (\Tuple:{ of : ::subset_of })),

The function `subset_of` aka `⊆` results in `0bTRUE` iff the multiset of
members of its `0` argument is a subset of the multiset of members of
its `1` argument; otherwise it results in `0bFALSE`.  Note that this
operation is also known as *multiset inclusion*.

## not_subset_of ⊈

        not_subset_of : (\Function : (\Tuple:{
            negates : ::subset_of,
        })),

        Unicode_Aliases::'⊈' : (\Alias : (\Tuple:{ of : ::not_subset_of })),

The function `not_subset_of` aka `⊈` results in `0bTRUE` iff the multiset
of members of its `0` argument is not a subset of the multiset of
members of its `1` argument; otherwise it results in `0bFALSE`.

## superset_of ⊇

        superset_of : (\Function : (\Tuple:{
            commutes : ::subset_of,
        })),

        Unicode_Aliases::'⊇' : (\Alias : (\Tuple:{ of : ::superset_of })),

The function `superset_of` aka `⊇` results in `0bTRUE` iff the multiset of
members of its `0` argument is a superset of the multiset of members of
its `1` argument; otherwise it results in `0bFALSE`.

## not_superset_of ⊉

        not_superset_of : (\Function : (\Tuple:{
            negates : ::superset_of,
        })),

        Unicode_Aliases::'⊉' : (\Alias : (\Tuple:{ of : ::not_superset_of })),

The function `not_superset_of` aka `⊉` results in `0bTRUE` iff the
multiset of members of its `0` argument is not a superset of the multiset
of members of its `1` argument; otherwise it results in `0bFALSE`.

## same_members

        same_members::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Boolean,
            matches : (\Tuple:{::Homogeneous, ::Homogeneous}),
            is_commutative : 0bTRUE,
        )),

The virtual function `same_members` results in `0bTRUE` iff the multiset of
members of its `0` argument is the same as the multiset of members of its
`1` argument; otherwise it results in `0bFALSE`.  This function may result
in `0bTRUE` for some `Positional` arguments for which `same` would result
in `0bFALSE` because the latter considers member order significant while the
former doesn't; for non-`Positional` arguments, the 2 functions are
typically the same.

## proper_subset_or_superset

        proper_subset_or_superset : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Homogeneous, ::Homogeneous}),
            is_commutative : 0bTRUE,
            evaluates : (not (args:.\0 same_members args:.\1) and (args:.\0 subset_or_superset args:.\1)),
        )),

The function `proper_subset_or_superset` results in `0bTRUE` iff the
multiset of members of one of its 2 arguments `0` and `1` is a proper
subset of the multiset of members of its other argument; otherwise it
results in `0bFALSE`.

## subset_or_superset

        subset_or_superset : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Homogeneous, ::Homogeneous}),
            is_commutative : 0bTRUE,
            evaluates : ((args:.\0 subset_of args:.\1) or (args:.\0 superset_of args:.\1)),
        )),

The function `subset_or_superset` results in `0bTRUE` iff the multiset of
members of one of its 2 arguments `0` and `1` is a subset of the multiset
of members of its other argument; otherwise it results in `0bFALSE`.

## overlaps_members

        overlaps_members::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Boolean,
            matches : (\Tuple:{::Homogeneous, ::Homogeneous}),
            is_commutative : 0bTRUE,
        )),

The virtual function `overlaps_members` results in `0bTRUE` iff, given *X* as the
multiset of members of its argument `0` and *Y* as the multiset of
members of its argument `1`, there exists at least 1 member that both *X*
and *Y* have, and there also exists at least 1 other member each of *X*
and *Y* that the other doesn't have; otherwise it results in `0bFALSE`.

## disjoint_members

        disjoint_members::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Boolean,
            matches : (\Tuple:{::Homogeneous, ::Homogeneous}),
            is_commutative : 0bTRUE,
        )),

The virtual function `disjoint_members` results in `0bTRUE` iff the multiset of
members of its `0` argument has no member values in common with the
multiset of members of its `1` argument; otherwise it results in `0bFALSE`.

## any there_exists ∃

        any::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Boolean,
            matches : (\Tuple:{::Homogeneous, ::Signature}),
        )),

        there_exists : (\Alias : (\Tuple:{ of : ::any })),

        Unicode_Aliases::'∃' : (\Alias : (\Tuple:{ of : ::any })),

*TODO.  Result is true when at least one member evaluates to true.
This is logically equivalent to testing if a same-source 'where' result is nonempty,
but 'any' is instead virtual with applicable Foundation-level functions to
aid efficiency with less-savvy optimizers that don't know to short-circuit.*

*TODO.  Definition of any/none/all etc would have to be altered for
intervalish types in general such that they only evaluate endpoints rather
than all members, and therefore the result would only be valid for
predicates that for the given member types would always produce the same
results for endpoints as for non-endpoints the former bound.*

## none there_does_not_exist ∄

        none : (\Function : (\Tuple:{
            negates : ::any,
        })),

        there_does_not_exist : (\Alias : (\Tuple:{ of : ::none })),

        Unicode_Aliases::'∄' : (\Alias : (\Tuple:{ of : ::none })),

*TODO.  Result is true when no member evaluates to true.*

## all for_all ∀

        all : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Homogeneous, ::Signature}),
            evaluates : (args:.\0 none \not_is_a::( 1: args:.\1 )),
        )),

        for_all : (\Alias : (\Tuple:{ of : ::all })),

        Unicode_Aliases::'∀' : (\Alias : (\Tuple:{ of : ::all })),

*TODO.  Result is true when no member evaluates to false.*

*Other languages: "TrueForAll".*

## not_all

        not_all : (\Function : (\Tuple:{
            negates : ::all,
        })),

*TODO.  Result is true when at least one member evaluates to false.*

# UNIONABLE DATA TYPES

## Unionable

        Unionable : (\Function : (
            is_type_definer : 0bTRUE,
            is_generalization : 0bTRUE,
            composes : (\Set:[::Homogeneous]),
        )),

The interface type definer `Unionable` is semifinite.  A `Unionable` value is a
`Homogeneous` value such that another value of its collection type can be
derived by either inserting new members whose values are distinct from
those already in the collection or by removing arbitrary members from the
collection.  The default value of `Unionable` is the `Array` value with
zero members, `(\Array:[])`.

`Unionable` is composed, directly or indirectly, by: `Discrete`,
`Positional`, `Array`, `Set`, `Bag`, `Relational`,
`Orderelation`, `Relation`, `Multirelation`, `Unionable_Intervalish`,
`Set_Of_Interval`, `Bag_Of_Interval`.  A key type that composes `Homogeneous`
but not `Unionable` is `Interval`; use `Set_Of_Interval` instead for its
`Unionable` closest analogy.

## insert

        insert : (\Function : (
            returns : ::Unionable,
            matches : (\Tuple:{::Unionable, ::Any}),
            evaluates : (insert_n::(\Tuple:{args:.\0, args:.\1, 1})),
        )),

The function `insert` results in the value of its `0` argument's
collection type that has all of the members of the function's `0` argument
plus 1 additional member that is equal to its `1` argument; its semantics
are identical to those of `insert_n` where N is 1.  Other programming
languages may name their corresponding operators *add*; it is also common
to use assignment syntax.

## insert_n

        insert_n::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Unionable,
            matches : (\Tuple:{::Unionable, ::Any, ::Integer_NN}),
        )),

The virtual function `insert_n` results in the value of its `0`
argument's collection type that has all of the members of the function's
`0` argument plus N additional members that are each equal to its `1`
argument, where N is defined by its `2` argument; however, if the result's
type is `Setty`, the result will have no more than 1 member equal to the
`1` argument (any duplicates will be silently eliminated), so the result
may equal the `0` argument even when the `2` argument is nonzero.  If the
result's type is `Positional`, then the result starts with all of the
members of `0` in the same order and ends with any added instances of `1`.

## remove

        remove : (\Function : (
            returns : ::Unionable,
            matches : (\Tuple:{::Unionable, ::Any}),
            evaluates : (remove_n::(\Tuple:{args:.\0, args:.\1, 1})),
        )),

The function `remove` results in the value of its `0` argument's
collection type that has all of the members of the function's `0` argument
minus 1 existing member that is each equal to its `1` argument; its
semantics are identical to those of `remove_n` where N is 1.  Other
programming languages may name their corresponding operators *delete*.

## remove_n

        remove_n::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Unionable,
            matches : (\Tuple:{::Unionable, ::Any, ::Integer_NN}),
        )),

The virtual function `remove_n` results in the value of its `0`
argument's collection type that has all of the members of the function's
`0` argument minus N existing members that are each equal to its `1`
argument, where N is defined as the lesser of its `2` argument and the
count of members of `0` equal to the `1` argument, so the result may
equal the `0` argument even when the `2` argument is nonzero.  If the
result's type is `Positional`, then the removed instances of `1` are
those closest to the end of `0`.  Note that `remove_n` is designed to
mirror `insert_n`, so the identity `c = remove_n::(insert_n::(\Tuple:{c,x,n}),x,n)`
should hold for any `Unionable` type, even a `Positional` one, except
with a `Setty` `c` that already has an `x` element with a nonzero `n`.

## member_plus ⊎

        member_plus::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Unionable,
            matches : (\Tuple:{::Unionable, ::Unionable}),
            is_associative : 0bTRUE,
        )),

        Unicode_Aliases::'⊎' : (\Alias : (\Tuple:{ of : ::member_plus })),

The virtual function `member_plus` aka `⊎` results in the *multiset sum*
of its 2 arguments `0` and `1`.  The result is a value of the function's
`0` argument's collection type that has all of the members of the
function's `0` argument plus all of the members of its `1` argument.  For
every distinct member value of the result, its multiplicity is the integral
sum of the multiplicities of that same member value of each of the 2
arguments; however, if the result's type is `Setty`, the result will only
have 1 member per distinct member value (any duplicates will be silently
eliminated).  If the result's type is `Positional`, then the result starts
with all of the members of `0` and ends with the members of `1`, the
members from both in the same order as in their respective arguments; that
is, this function then behaves identically to `catenate` aka `~` when
given the same arguments.  This operation has a *two-sided identity element* value of a
collection with zero members.  For non-ordered types, this operation is
also commutative.  Other programming languages may name their corresponding
operators *union all* or `+`.

## except ∖

        except::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Unionable,
            matches : (\Tuple:{::Unionable, ::Unionable}),
        )),

        Unicode_Aliases::'∖' : (\Alias : (\Tuple:{ of : ::except })),

The virtual function `except` aka `∖` results in the *multiset
difference* or *multiset relative complement*
between its 2 arguments `0` (*minuend*) and `1`
(*subtrahend*).  The result is a value of the function's `0` argument's
collection type that has all of the members of the function's `0` argument
minus all of the matching members of its `1` argument.  For every distinct
member value of the result, its multiplicity is the integral difference of
the multiplicities of that same member value of each of the 2 arguments
(when subtracting the *subtrahend* from the *minuend*); a multiplicity is
zero when it would otherwise be negative.  If the result's type is
`Positional`, then the removed instances of any distinct member value are
those closest to the end of `0`.  Note that `except` is designed to
mirror `member_plus`, so the identity `x = except::(member_plus::(\Tuple:{x,y}),y)`
should hold for any `Unionable` type, even a `Positional` one, except
with `Setty` `x` and `y` that have any members that are the same value.
This operation has a *right identity element* value of a collection with zero members.
Other programming languages may name their corresponding operators *minus*
or `-` or *difference* or `\\` or *complement* or *setdiff* or *diff*
or `--` etc or *subtract*.

## intersect ∩

        intersect::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Unionable,
            matches : (\Tuple:{::Unionable, ::Unionable}),
            is_associative : 0bTRUE,
            is_idempotent : 0bTRUE,
        )),

        Unicode_Aliases::'∩' : (\Alias : (\Tuple:{ of : ::intersect })),

The virtual function `intersect` aka `∩` results in the *multiset
intersection* of its 2 arguments `0` and `1`.  The result is a value of
the function's `0` argument's collection type that has all of the members
of the function's `0` argument that match their own members of its `1`
argument.  For every distinct member value of the result, its multiplicity
is the integral minimum of the multiplicities of that same member value of
each of the 2 arguments (any nonmatched argument member does not appear in
the result).  If the result's type is `Positional`, then the removed
instances of any distinct member value are those closest to the end of
`0`.  This operation conceptually has a *two-sided identity element* value of a collection
with an infinite number of members.  (\Tuple:{For `Setty` collections whose member type is
finite, the *two-sided identity element* of `intersect` instead simply has 1 member
for every member of that member type.})  For non-ordered types, this operation
is also commutative.  Other programming languages may name their
corresponding operators `&` or `*`.

## union ∪

        union::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Unionable,
            matches : (\Tuple:{::Unionable, ::Unionable}),
            is_idempotent : 0bTRUE,
        )),

        Unicode_Aliases::'∪' : (\Alias : (\Tuple:{ of : ::union })),

The virtual function `union` aka `∪` results in the *multiset union* of
its 2 arguments `0` and `1`.  The result is a value of the function's
`0` argument's collection type that has all of the members of the
function's `0` argument plus all of the nonmatching members of its `1`
argument.  For every distinct member value of the result, its multiplicity
is the integral maximum of the multiplicities of that same member value of
each of the 2 arguments.  If the result's type is `Positional`, then the
result starts with all of the members of `0` and ends with the nonmatching
members of `1`, the members from both in the same order as in their
respective arguments; the removed (due to matching) instances of any
distinct member value are those closest to the end of `1`.  Note that the
identity `union::(\Tuple:{x,y}) = member_plus::(x,except::(\Tuple:{y,x}))` should hold for
any `Unionable` type, even a `Positional` one.  This operation has a
*two-sided identity element* value of a collection with zero members.  For non-ordered types,
this operation is also associative and commutative.  Other programming
languages may name their corresponding operators `|` or `+`.

## exclusive symm_diff ∆

        exclusive::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Unionable,
            matches : (\Tuple:{::Unionable, ::Unionable}),
        )),

        symm_diff : (\Alias : (\Tuple:{ of : ::exclusive })),

        Unicode_Aliases::'∆' : (\Alias : (\Tuple:{ of : ::exclusive })),

The virtual function `exclusive` aka `symm_diff` aka `∆` results in the
*multiset symmetric difference* of its 2 arguments `0` and `1`.  The
result is a value of the function's `0` argument's collection type that
has all of the members of each of the function's `0` and `1` arguments
that do not have matching members of their counterpart argument.  For every
distinct member value of the result, its multiplicity is the integral
maximum of the multiplicities of that same member value of each of the 2
arguments, minus the integral minimum of the same.  If the result's type is
`Positional`, then the result starts with the nonmatching members of `0`
and ends with the nonmatching members of `1`, the members from both in the
same order as in their respective arguments; the removed (due to matching)
instances of any distinct member value are those closest to the end of `0`
or `1` respectively.  Note that the identity `exclusive::(\Tuple:{x,y}) =
member_plus::(except::(\Tuple:{x,y}),except::(\Tuple:{y,x})) =
except::(union::(\Tuple:{x,y}),intersect::(\Tuple:{x,y}))`
should hold for any `Unionable` type, even a `Positional` one.  This
operation has a *two-sided identity element* value of a collection with zero members.  For
non-ordered types, this operation is also associative and commutative.
Other programming languages may name their corresponding operators
*symmdiff* or `^` or `%`.

## nest group

        nest::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Unionable,
            matches : (\Tuple:{::Unionable}),
            accepts : (...),
        )),

        group : (\Alias : (\Tuple:{ of : ::nest })),

*TODO.*

## unnest ungroup

        unnest::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Unionable,
            matches : (\Tuple:{::Unionable}),
            accepts : (...),
        )),

        ungroup : (\Alias : (\Tuple:{ of : ::unnest })),

*TODO.*

## where σ

        where::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Unionable,
            matches : (\Tuple:{::Unionable, ::Signature}),
        )),

        Unicode_Aliases::'σ' : (\Alias : (\Tuple:{ of : ::where })),

*TODO.  The function-call is expected to be a Article with 2 attributes
named 'call' and 'args', which are a Function_Name and a Tuple respectively.
The 'args' can be any Tuple that doesn't have a '0' attr.
The function referenced by 'call' is expected to take a Tuple argument
whose '0' attr is a member of the collection and whose other attrs match
those given in 'args'.*
*Ruby calls its version "select" (returns list) and a "keep_if" (mutates).*

*Note: Ruby has a "reject" and a "delete_if" function that is like SQL's delete.*

*TODO.  Definition of where/map/reduce etc would have to be altered for
intervalish types in general such that they only evaluate endpoints rather
than all members, and therefore the result may not be valid depending on
what the function argument does or on the given member types.*

## filtering

        filtering : (\Function : (\Tuple:{
            commutes : ::where,
        })),

*TODO.*

## map

        map::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Unionable,
            matches : (\Tuple:{::Unionable, ::Function_Call_But_0}),
        )),

*TODO.  The function-call is as per that of 'where'.*
*Ruby calls its version "collect".*

*TODO.  For the general case of intervalish types, the result of map would
only be valid when the function argument is order-preserving, for example a
plain function that adds 3 to all members or multiplies all members by 2,
etc.  Also note that for intervals over successable types, some operations
may result in every member becoming discontinuous from the others, such as
multiply with integers.*

## reduce

        reduce::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Any,
            matches : (\Tuple:{::Unionable, ::Function_Call_But_0_1}),
        )),

*TODO.  Restrict "reduce" to take dyadic functions which are commutative
plus associative only, corresponding to more formal common usage of the
term "reduce".  Then add a pair of other operators, foo(\Tuple:{}) and bar(\Tuple:{}),
to Positional where foo(\Tuple:{}) requires associative but not commutative, and
is used for catenation, and bar(\Tuple:{}) requires neither assoc/commut, and is used
for more esoteric things perhaps resembling a common meaning of "fold".
The next paragraph is partly obsoleted by this.*

*TODO.  The function-call is expected to be a Article with 2 attributes
named 'call' and 'args', which are a Function_Name and a Tuple respectively.
The 'args' can be any Tuple that doesn't have either '0' or '1' attrs.
The function referenced by 'call' is expected to take a Tuple argument
whose '0' and '1' attrs are members of the collection and whose other attrs match
those given in 'args'.
Depending on the collection subtype, order of 0,1 may or may not be significant.
If collection is unordered, 'call' must be both associative and commutative,
and reduce can always be parallelized.
If collection is ordered, reduce can be parallelized if 'call' is associative;
otherwise the reduce is a serial operation, at least naively.*

*TODO.  Also define related No_Identity_Element type.*

# DISCRETE DATA TYPES

## Discrete

        Discrete : (\Function : (
            is_type_definer : 0bTRUE,
            is_generalization : 0bTRUE,
            composes : (\Set:[::Unionable]),
            provides_default_for : (\Set:[::Unionable]),
        )),

The interface type definer `Discrete` is semifinite.  A `Discrete` value is a
`Unionable` value such that all of its members can be enumerated as
individuals and counted.  The default value of `Discrete` is the `Array`
value with zero members, `(\Array:[])`.

`Discrete` is composed, directly or indirectly, by: `Positional`,
`Array`, `Set`, `Bag`, `Relational`, `Orderelation`,
`Relation`, `Multirelation`.

## to_Set ?|

        to_Set::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Set,
            matches : (\Tuple:{::Discrete}),
        )),

        '?|' : (\Alias : (\Tuple:{ of : ::to_Set })),

The virtual function `to_Set` aka `?|` results in the `Set` value
that represents the same set of distinct member values as its `0`
argument.  The purpose of `to_Set` is to canonicalize `Discrete` values
so they can be treated abstractly as sets of discrete values, for
operations where neither multiplicity nor order is significant.

## to_Bag +|

        to_Bag::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Bag,
            matches : (\Tuple:{::Discrete}),
        )),

        '+|' : (\Alias : (\Tuple:{ of : ::to_Bag })),

The virtual function `to_Bag` aka `+|` results in the `Bag` value
that represents the same multiset of members as its `0` argument.  The
purpose of `to_Bag` is to canonicalize `Discrete` values so they can be
treated abstractly as multisets of discrete values, for operations where
multiplicity possibly is significant but order isn't.

## count cardinality #

        count::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Integer_NN,
            matches : (\Tuple:{::Discrete}),
        )),

        cardinality : (\Alias : (\Tuple:{ of : ::count })),
        '#'         : (\Alias : (\Tuple:{ of : ::count })),

The virtual function `count` aka `cardinality` aka `#` results in the
integral count of the members of its `0` argument; when multiple members
have the same member value, every member counts as 1 towards the total.

## unique_count

        unique_count::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Integer_NN,
            matches : (\Tuple:{::Discrete}),
        )),

The virtual function `unique_count` results in the integral count of the
distinct member values of its `0` argument.

## order

        order : (\Function : (
            returns : ::Positional,
            matches : (\Tuple:{::Discrete}),
            evaluates : (args:.\0 order_using \in_order::(\Tuple:{})),
        )),

The function `order` results in the `Positional` value that represents
the same multiset of members as its `0` argument but that the members are
arranged into a sequence in accordance with a total order defined by the
function `in_order`.  This function will succeed iff `in_order` is
defined for the types of the members or they are of an `Orderable` type.

## order_using

        order_using::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Positional,
            matches : (\Tuple:{::Discrete, ::Function_Call_But_0_1}),
        )),

The virtual function `order_using` results in the `Positional` value that
represents the same multiset of members as its `0` argument but that the
members are arranged into a sequence in accordance with a total order
defined by the function given in its `1` argument.  Iff the members of the
`0` argument are all of the same `Orderable`-composing type, then the
generic `in_order` function may be used as the `1` argument; regardless,
the `1` argument can define any total order it likes for members that are
of any type, both `Orderable` or not.

# POSITIONAL DATA TYPES

## Positional

        Positional : (\Function : (
            is_type_definer : 0bTRUE,
            is_generalization : 0bTRUE,
            composes : (\Set:[::Orderable, ::Discrete, ::Accessible]),
            provides_default_for : (\Set:[::Discrete]),
        )),

The interface type definer `Positional` is semifinite.  A `Positional` value is
a `Discrete` value; it is a homogeneous
aggregate of other, *member* values that are arranged in an explicit total
order and can both be enumerated in that order as well as be looked up by
integral ordinal position against that order; there is a single
canonical interpretation of where each *member* begins and ends within the
aggregate.  A `Positional` value is dense, meaning that every one of its
members exists at a distinct adjacent integral position; a `Positional`
preserves the identity that the count of its members is equal to one plus
the difference of its first and last ordinal positions.  Idiomatically, a
`Positional` value is zero-based, meaning its first-ordered member is at
ordinal position `0`, but that doesn't have to be the case.  `Positional`
requires that for every composing type definer *T* there is a single integral
value *P* such that the first ordinal position of every value of *T* is
*P*; as such, any catenation or slice of `Positional` values would have
well-definined shifting of member values between ordinal positions.

The default value of `Positional` is the `Array` value with zero members,
`(\Array:[])`.  `Positional` is `Orderable` in the general case conditionally
depending on whether all of its member values are mutually `Orderable`
themselves; its minimum value is the same `(\Array:[])` as its default value; it
has no maximum value.  The ordering algorithm of `Positional` is based on
pairwise comparison of its members by matching ordinal position starting at the lowest
ordinal position; iff `Positional` value X is a leading sub-sequence of `Positional`
value Y, then X is ordered before Y; otherwise, the mutual ordering of the
lowest-ordinal-positioned non-matching members of X and Y determines that the ordering
of X and Y as a whole are the same as said members.

`Positional` is composed, directly or indirectly, by: `Bits`, `Blob`,
`Textual`, `Text`, `Array`, `Orderelation`.

## singular (Positional)

        singular::Positional : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Positional}),
            implements : folder::'',
            evaluates : ((unique_count args:.\0) = 1),
        )),

The function `singular::Positional` results in `0bTRUE` iff its `0`
argument has exactly 1 distinct member value, and `0bFALSE` otherwise.  This
function implements the `Homogeneous` virtual function `singular` for the
composing type `Positional`.

## only_member (Positional)

        only_member::Positional : (\Function : (
            returns : ::Any,
            matches : (\Tuple:{::Positional}),
            implements : folder::'',
            accepts : (singular args:.\0),
            evaluates : (first args:.\0),
        )),

The function `only_member::Positional` results in its `0` argument's only
distinct member value.  This function will fail if the argument doesn't
have exactly 1 distinct member value.  This function implements the
`Homogeneous` virtual function `only_member` for the composing type
`Positional`.

## subset_of (Positional)

        subset_of::Positional : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Positional, ::Positional}),
            implements : folder::'',
            evaluates : ((to_Bag args:.\0) subset_of (to_Bag args:.\1)),
        )),

The function `subset_of::Positional` results in `0bTRUE` iff the multiset
of members of its `0` argument is a subset of the multiset of members of
its `1` argument; otherwise it results in `0bFALSE`.  This function
implements the `Homogeneous` virtual function `subset_of` aka `⊆` for
the composing type `Positional`.

## same_members (Positional)

        same_members::Positional : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Positional, ::Positional}),
            implements : folder::'',
            is_commutative : 0bTRUE,
            evaluates : ((to_Bag args:.\0) same_members (to_Bag args:.\1)),
        )),

The function `same_members::Positional` results in `0bTRUE` iff the
multiset of members of its `0` argument is the same as the multiset of
members of its `1` argument; otherwise it results in `0bFALSE`.  This
function may result in `0bTRUE` for some arguments for which `same` would
result in `0bFALSE` because the latter considers member order significant
while the former doesn't.  This function implements the `Homogeneous`
virtual function `same_members` for the composing type `Positional`.

## overlaps_members (Positional)

        overlaps_members::Positional : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Positional, ::Positional}),
            implements : folder::'',
            is_commutative : 0bTRUE,
            evaluates : ((to_Bag args:.\0) overlaps_members (to_Bag args:.\1)),
        )),

The function `overlaps_members::Positional` results in `0bTRUE` iff, given
*X* as the multiset of members of its argument `0` and *Y* as the
multiset of members of its argument `1`, there exists at least 1 member
that both *X* and *Y* have, and there also exists at least 1 other member
each of *X* and *Y* that the other doesn't have; otherwise it results in
`0bFALSE`.  This function implements the `Homogeneous` virtual function
`overlaps_members` for the composing type `Positional`.

## disjoint_members (Positional)

        disjoint_members::Positional : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Positional, ::Positional}),
            implements : folder::'',
            is_commutative : 0bTRUE,
            evaluates : ((to_Bag args:.\0) disjoint_members (to_Bag args:.\1)),
        )),

The function `disjoint_members::Positional` results in `0bTRUE` iff the
multiset of members of its `0` argument has no member values in common
with the multiset of members of its `1` argument; otherwise it results in
`0bFALSE`.  This function implements the `Homogeneous` virtual function
`disjoint_members` for the composing type `Positional`.

## member_plus (Positional)

        member_plus::Positional : (\Function : (
            returns : ::Positional,
            matches : (\Tuple:{::Positional, ::Positional}),
            implements : folder::'',
            is_associative : 0bTRUE,
            evaluates : (args:.\0 ~ args:.\1),
        )),

The function `member_plus::Positional` results in the *multiset sum* of
its 2 arguments `0` and `1`; it behaves identically to `catenate` aka
`~` when given the same arguments.  This function implements the
`Unionable` virtual function `member_plus` aka `⊎` for the composing
type `Positional`.

## unique_count (Positional)

        unique_count::Positional : (\Function : (
            returns : ::Integer_NN,
            matches : (\Tuple:{::Positional}),
            implements : folder::'',
            evaluates : (count::(to_Set args:.\0)),
        )),

The function `unique_count::Positional` results in the integral count of
the distinct member values of its `0` argument.  This function implements
the `Discrete` virtual function `unique_count` for the composing type
`Positional`.

## has_any_at (Positional)

        has_any_at::Positional : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Positional, ::Integer}),
            implements : folder::'',
            evaluates : (args:.\1 >= first_possible_ord_pos::(args:.\0)
                and args:.\1 < first_unused_ord_pos::(args:.\0)),
        )),

The function `has_any_at::Positional` results in `0bTRUE` iff its `0`
argument has a member whose ordinal position is equal to its `1` argument;
otherwise it results in `0bFALSE`.  This function implements the
`Accessible` virtual function `has_any_at` aka `.?` for the composing
type `Positional`.

## has_mapping_at (Positional)

        has_mapping_at::Positional : (\Function : (
            returns : ::Boolean,
            matches : (Positional, (\Tuple:{Integer, Any})),
            implements : folder::'',
            evaluates : (args:.\0 .? (args:.\1.\0) and_then guard args:.\0.(args:.\1.\0) = (args:.\1.\1)),
        )),

The function `has_mapping_at::Positional` results in `0bTRUE` iff its `0`
argument has a member that is equal to its `1` argument's `1` attribute,
where the ordinal position of that member is equal to the `1` argument's
`0` attribute; otherwise it results in `0bFALSE`.  This function implements
the `Accessible` virtual function `has_mapping_at` aka `.:?` for the
composing type `Positional`.

## mapping_at (Positional)

        mapping_at::Positional : (\Function : (
            returns : (\Tuple:{::Integer, ::Any}),
            matches : (\Tuple:{::Positional, ::Integer}),
            implements : folder::'',
            accepts : (args:.\0 .? args:.\1),
            evaluates : ((\Tuple:{args:.\1, args:.\0.args:.\1})),
        )),

The function `mapping_at::Positional` results in a binary `Tuple` whose
`0` attribute is the function's `1` argument and whose `1` attribute is
the member value of the function's `0` argument whose ordinal position is
equal to its `1` argument.  This function will fail if the `0` argument
doesn't have such a member.  This function implements the `Accessible`
virtual function `mapping_at` aka `.:` for the composing type
`Positional`.

## maybe_at (Positional)

        maybe_at::Positional : (\Function : (
            returns : ::Any,
            matches : (\Tuple:{::Positional, ::Integer}),
            implements : folder::'',
            evaluates : (if args:.\0 .? args:.\1 then guard args:.\0.args:.\1 else (::No_Such_Ord_Pos : (\Tuple:{}))),
        )),

The function `maybe_at::Positional` results in the member value of its
`0` argument whose ordinal position is equal to its `1` argument, iff there
is such a member; otherwise it results in `(::No_Such_Ord_Pos : (\Tuple:{}))`.  This function
implements the `Accessible` virtual function `maybe_at` aka `.!` for the
composing type `Positional`.

## replace_at (Positional)

        replace_at::Positional : (\Function : (
            returns : ::Positional,
            matches : (Positional, (\Tuple:{Integer, Any})),
            implements : folder::'',
            accepts : (args:.\0 .? (args:.\1.\0)),
            evaluates : (
                src ::= args:.\0;
                rop ::= args:.\1.\0;
                repl_member ::= args:.\1.\1;
                fop ::= first_ord_pos src;
                lop ::= last_ord_pos src;
                emp ::= empty src;
                returns (if rop > fop then guard slice_range::(\Tuple:{src, fop, --rop}) else emp)
                    insert repl_member
                    catenate (if rop < lop then guard slice_range::(\Tuple:{src, ++rop, lop}) else emp);
            ),
        )),

The function `replace_at::Positional` results in the value of its `0`
argument's collection type that has all of the members of the function's
`0` argument in the same order but that, for the 1 member of the `0`
argument whose ordinal position *K* is equal to the function's `1`
argument's `0` attribute, the result instead has at ordinal position *K* a
member whose value is equal to the `1` argument's `1` attribute.  This
function will fail if the `0` argument doesn't have a member with the
ordinal position *K*.  This function implements the `Accessible` virtual
function `replace_at` aka `.:=` for the composing type `Positional`.

## shiftless_insert_at (Positional)

        shiftless_insert_at::Positional : (\Function : (
            returns : ::Positional,
            matches : (Positional, (\Tuple:{Integer, Any})),
            implements : folder::'',
            accepts : (args:.\1.\0 = first_unused_ord_pos::(args:.\0)),
            evaluates : (args:.\0 insert args:.\1.\1),
        )),

The function `shiftless_insert_at::Positional` results in the value of its
`0` argument's collection type that has all of the members of the
function's `0` argument in the same order, plus 1 additional member *M*
that is equal to its `1` argument's `1` attribute, where the ordinal
position *K* in the result of *M* is equal to the `1` argument's `0`
attribute.  This function will fail if *K* is not equal to the `0`
argument's `first_unused_ord_pos`.  This function implements the
`Accessible` virtual function `shiftless_insert_at` aka `.+` for the
composing type `Positional`.

## shiftless_remove_at (Positional)

        shiftless_remove_at::Positional : (\Function : (
            returns : ::Positional,
            matches : (\Tuple:{::Positional, ::Integer}),
            implements : folder::'',
            accepts : (args:.\1 >= first_possible_ord_pos::(args:.\0)
                and args:.\1 = --first_unused_ord_pos::(args:.\0)),
            evaluates : (nonlast args:.\0),
        )),

The function `shiftless_remove_at::Positional` results in the value of its
`0` argument's collection type that has all of the members of the
function's `0` argument in the same order minus 1 existing element whose
ordinal position *K* is equal to its `1` argument.  This function will fail
if either the `0` argument doesn't have any members or if *K* is not
equal to the `0` argument's `last_ord_pos`.  This function implements the
`Accessible` virtual function `shiftless_remove_at` aka `.-` for the
composing type `Positional`.

## replace_or_insert_at (Positional)

        replace_or_insert_at::Positional : (\Function : (
            returns : ::Positional,
            matches : (Positional, (\Tuple:{Integer, Any})),
            implements : folder::'',
            accepts : (args:.\1 >= first_possible_ord_pos::(args:.\0)
                and args:.\1 <= first_unused_ord_pos::(args:.\0)),
            evaluates : (if args:.\0 .? (args:.\1.\0) then guard args:.\0 .:= (args:.\1.\0) else guard args:.\0 .+ (args:.\1.\0)),
        )),

The function `replace_or_insert_at::Positional` behaves identically in
turn to each of the functions `replace_at` and `shiftless_insert_at` when
given the same arguments, where the `0` argument does or doesn't,
respectively, have a member whose ordinal position is equal to the `1`
argument's `0` attribute.  This function implements the `Accessible`
virtual function `replace_or_insert_at` aka `.=+` for the composing type
`Positional`.

## shiftless_maybe_remove_at (Positional)

        shiftless_maybe_remove_at::Positional : (\Function : (
            returns : ::Positional,
            matches : (\Tuple:{::Positional, ::Integer}),
            implements : folder::'',
            accepts : (args:.\1 >= first_possible_ord_pos::(args:.\0)
                and args:.\1 >= --first_unused_ord_pos::(args:.\0)),
            evaluates : (if args:.\1 = --first_unused_ord_pos::(args:.\0) then guard nonlast args:.\0 else args:.\0),
        )),

The function `shiftless_maybe_remove_at::Positional` behaves identically
to `shiftless_remove_at` when given the same arguments but that it simply
results in its `0` argument when that has no member whose ordinal position
matches its `1` argument, rather than fail.  This function implements the
`Accessible` virtual function `shiftless_maybe_remove_at` aka `.?-` for
the composing type `Positional`.

## to_Array ~|

        to_Array::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Array,
            matches : (\Tuple:{::Positional}),
        )),

        '~|' : (\Alias : (\Tuple:{ of : ::to_Array })),

The virtual function `to_Array` aka `~|` results in the `Array`
value that represents the same sequence of members as its `0` argument.
The purpose of `to_Array` is to canonicalize `Positional` values so they
can be treated abstractly as sequences of discrete values with minimal
effort.

## substring_of

        substring_of::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Boolean,
            matches : (\Tuple:{::Positional, ::Positional}),
        )),

The virtual function `substring_of` results in `0bTRUE` iff the sequence of
members of its `0` argument is a substring of the sequence of members of
its `1` argument; otherwise it results in `0bFALSE`.  Other programming
languages may name their corresponding operators *in*.

## superstring_of

        superstring_of : (\Function : (\Tuple:{
            commutes : ::substring_of,
        })),

The function `superstring_of` results in `0bTRUE` iff the sequence of
members of its `0` argument is a superstring of the sequence of members of
its `1` argument; otherwise it results in `0bFALSE`.  Other programming
languages may name their corresponding operators *contains* or
*include?*; some of them instead provide more generalized pattern
searching operators such as *like* or `~~` or `=~`; some of them also
provide operators that result in an ordinal position or nonmatch indicator
rather than a boolean.

## proper_substring_or_superstring

        proper_substring_or_superstring : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Positional, ::Positional}),
            is_commutative : 0bTRUE,
            evaluates : (args:.\0 != args:.\1 and (args:.\0 substring_or_superstring args:.\1)),
        )),

The function `proper_substring_or_superstring` results in `0bTRUE` iff the
sequence of members of one of its 2 arguments `0` and `1` is a proper
substring of the sequence of members of its other argument; otherwise it
results in `0bFALSE`.

## substring_or_superstring

        substring_or_superstring : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Positional, ::Positional}),
            is_commutative : 0bTRUE,
            evaluates : ((args:.\0 substring_of args:.\1) or (args:.\0 superstring_of args:.\1)),
        )),

The function `substring_or_superstring` results in `0bTRUE` iff the
sequence of members of one of its 2 arguments `0` and `1` is a substring
of the sequence of members of its other argument; otherwise it results in
`0bFALSE`.

## overlaps_string

        overlaps_string::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Boolean,
            matches : (\Tuple:{::Positional, ::Positional}),
            is_commutative : 0bTRUE,
        )),

The virtual function `overlaps_string` results in `0bTRUE` iff, given *X*
as the sequence of members of its argument `0` and *Y* as the sequence of
members of its argument `1`, when *X* and *Y* are overlapped to the
greatest possible extent such that every corresponding member pair has 2 of
the same value, the overlap of *X* and *Y* has at least 1 member, and
each of *X* and *Y* has at least 1 member that is not overlapped;
otherwise it results in `0bFALSE`.

## disjoint_string

        disjoint_string::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Boolean,
            matches : (\Tuple:{::Positional, ::Positional}),
            is_commutative : 0bTRUE,
        )),

The virtual function `disjoint_string` results in `0bTRUE` iff the sequence
of members of its `0` argument can not be overlapped with the sequence of
members of its `1` argument by at least 1 member such that every
corresponding member pair has 2 of the same value; otherwise it results in
`0bFALSE`.

## catenate ~

        catenate::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Positional,
            matches : (\Tuple:{::Positional, ::Positional}),
            is_associative : 0bTRUE,
            repeater : ::replicate,
        )),

        '~' : (\Alias : (\Tuple:{ of : ::catenate })),

The virtual function `catenate` aka `~` results in the catenation of its
2 arguments `0` and `1` such that the result starts with the members of
`0` and ends with the members of `1`, the members from both in the same
order as in their respective arguments.  This operation has a *two-sided identity element*
value of a collection with zero members.  Other programming languages may
name their corresponding operators *concat* or `||` or `+` or *.* or
*strcat* or *join*; some of them also have string interpolation syntax
which logically does the same thing without an explicit operator.

## replicate ~#

        replicate::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Positional,
            matches : (\Tuple:{::Positional, ::Integer_NN}),
        )),

        '~#' : (\Alias : (\Tuple:{ of : ::replicate })),

The virtual function `replicate` aka `~#` results in the catenation of N
instances of its `0` argument where N is defined by its `1` argument.  If
the `1` argument is zero then the result is the value of the `0`
argument's collection type that has zero members.  Other programming
languages may name their corresponding operators *x*.

## squish

        squish : (\Function : (
            returns : ::Positional,
            matches : (\Tuple:{::Positional}),
            evaluates : (args:.\0 map \((\Tuple:{ group : args:.\0, member : 0bFALSE }))
                pipe nest map \(args:.\0.\group)),
        )),

The function `squish` results in the value of its `0` argument's
ordered collection type that has all of the members of the function's `0`
argument but that, for every run of 2 or more consecutive members that are
all the same value, that run retains only 1 of those members.  Iff the
argument is such that all appearances of each distinct value are adjacent
members, the result of `squish` is the same as that of `unique`.
TODO CAN AVOID SECOND LAMBDA?

## first_possible_ord_pos

        first_possible_ord_pos::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Integer,
            matches : (\Tuple:{::Positional}),
        )),

The virtual function `first_possible_ord_pos` results in the integral first
possible ordinal position *P* that every value of its `0` argument's
collection type has in common.  Iff the `0` argument *C* is nonempty then
the result is also equal to the actual ordinal position of *C*'s first
member; otherwise *P* is the ordinal position that a subsequently-added
first member of *C* would have.

## first_unused_ord_pos

        first_unused_ord_pos : (\Function : (
            returns : ::Integer,
            matches : (\Tuple:{::Positional}),
            evaluates : (first_possible_ord_pos::(args:.\0) + #args:.\0),
        )),

The function `first_unused_ord_pos` results in the integral first unused
ordinal position of its `0` argument, which is the ordinal position that the
first subsequently-appended member would have.  Iff the `0` argument *C*
is nonempty then the result is one greater than the last ordinal position of
*C*; otherwise the result is equal to the first possible ordinal position.  For a
zero-based `Positional`, the result is equal to its `count`.

## first_ord_pos

        first_ord_pos : (\Function : (
            returns : ::Integer,
            matches : (\Tuple:{::Positional}),
            accepts : (not_empty args:.\0),
            evaluates : (first_possible_ord_pos::(args:.\0)),
        )),

The function `first_ord_pos` results in the integral ordinal position of its
nonempty `0` argument's first member.

## last_ord_pos

        last_ord_pos : (\Function : (
            returns : ::Integer,
            matches : (\Tuple:{::Positional}),
            accepts : (not_empty args:.\0),
            evaluates : (--first_unused_ord_pos::(args:.\0)),
        )),

The function `last_ord_pos` results in the integral ordinal position of its
nonempty `0` argument's last member.

## slice_n

        slice_n::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Positional,
            matches : (\Tuple:{::Positional, ::Integer, ::NN_Integer}),
            accepts : (args:.\1 >= first_possible_ord_pos::(args:.\0)
                and args:.\1 + args:.\2 <= first_unused_ord_pos::(args:.\0)),
        )),

The virtual function `slice_n` results in the value of its `0` argument's
ordered collection type that has exactly *N* consecutive members of the
function's `0` argument *C*, in the same order, such that the first
member existed at ordinal position *F* of *C* where *F* and *N* are equal
to the function's `1` and `2` arguments respectively.  The taken members
do not necessarily occupy the same ordinal positions in the result as they
did in *C*.  This function will fail if *C* does not have members at any
of the ordinal positions requested.  Other programming languages may name
their corresponding operators *array_slice*.

## slice_range

        slice_range : (\Function : (
            returns : ::Positional,
            matches : (\Tuple:{::Positional, ::Integer, ::Integer}),
            accepts : (not_empty args:.\0 and args:.\1 >= first_possible_ord_pos::(args:.\0)
                and args:.\2 < first_unused_ord_pos::(args:.\0)),
            evaluates : (slice_n::(\Tuple:{args:.\0, args:.\1, args:.\2 - args:.\1 + 1})),
        )),

The function `slice_range` results in the value of its `0` argument's
ordered collection type that has all of the members of the function's `0`
argument *C*, in the same order, such that the first and last members
existed at ordinal positions equal to the function's `1` and `2` arguments
respectively.  The taken members do not necessarily occupy the same ordinal
positions in the result as they did in *C*.  This function will fail if
*C* does not have members at any of the ordinal positions requested.  Other
programming languages may name their corresponding operators *slice* or
may instead overload their array element subscripting syntax.

## first

        first : (\Function : (
            returns : ::Any,
            matches : (\Tuple:{::Positional}),
            accepts : (not_empty args:.\0),
            evaluates : (args:.\0 . first_ord_pos::(args:.\0)),
        )),

The function `first` results in its nonempty `0` argument's first member.

## nonfirst

        nonfirst : (\Function : (
            returns : ::Positional,
            matches : (\Tuple:{::Positional}),
            accepts : (not_empty args:.\0),
            evaluates : (slice_range::(args:.\0, ++first_ord_pos::(args:.\0), last_ord_pos::(args:.\0))),
        )),

The function `nonfirst` results in the value of its `0` argument's
ordered collection type that has all of the members of the function's
nonempty `0` argument, in the same order, except for its very first one.
The taken members occupy ordinal positions of exactly 1 less in the result as
they did in the argument.

## last

        last : (\Function : (
            returns : ::Any,
            matches : (\Tuple:{::Positional}),
            accepts : (not_empty args:.\0),
            evaluates : (args:.\0 . last_ord_pos::(args:.\0)),
        )),

The function `last` results in its nonempty `0` argument's last member.

## nonlast

        nonlast : (\Function : (
            returns : ::Positional,
            matches : (\Tuple:{::Positional}),
            accepts : (not_empty args:.\0),
            evaluates : (slice_range::(args:.\0, first_ord_pos::(args:.\0), --last_ord_pos::(args:.\0))),
        )),

The function `nonlast` results in the value of its `0` argument's ordered
collection type that has all of the members of the function's nonempty `0`
argument, in the same order, except for its very last one.  The taken
members occupy the exact same ordinal positions in the result as they did in
the argument.

## ord_pos_succ_all_matches

        ord_pos_succ_all_matches::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Integer,
            matches : (\Tuple:{::Positional, ::Positional}),
            is_commutative : 0bTRUE,
        )),

*TODO.  Also consider ord_pos_first_diff_elem or ord_pos_succ_common_prefix as name.*

# BITS DATA TYPES

## Bits

        Bits : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Positional]),
            provides_default_for : (\Set:[::Positional]),
            evaluates : (Signature::Article_Match : (
                label : \Bits,
                attrs : (
                    bits : \Array::Bits(\Tuple:{}),
                ),
            )),
            default : 0bb,
        )),

The selection type definer `Bits` is infinite.  A `Bits` value is an
arbitrarily-long sequence of *bits* where each bit is represented by
an `Integer` in the range 0..1.  The default value of `Bits` is
`0bb` (the empty bit string).  `Bits` is `Orderable`; its minimum
value is the same `0bb` as its default value; it has no maximum value;
its ordering algorithm corresponds directly to that of `Array`, pairwise
as integer sequences.  Other programming languages may name their
corresponding types *bit* or *bit varying*.

## Array::Bits

        Array::Bits : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[\Array::(\Tuple:{}), \all::( 1: \in::( 1: 0..1 ) )]),
        )),

The selection type definer `Array::Bits` represents the infinite type
consisting just of the `Array` values for which every one of their member
values is an integer in the range 0..1 inclusive.

## in_order (Bits)

        in_order::Bits : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Bits, ::Bits}),
            implements : folder::'',
            evaluates : ((Bits_to_Array_Bits args:.\0) in_order (Bits_to_Array_Bits args:.\1)),
        )),

The function `in_order::Bits` implements the `Orderable` virtual
function `in_order` for the composing type `Bits`.

## not_empty (Bits)

        not_empty::Bits : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Bits}),
            implements : folder::'',
            evaluates : (args:.\0 != 0bb),
        )),

The function `not_empty::Bits` results in `0bTRUE` iff its `0` argument
is not `0bb`, and in `0bFALSE` if it is `0bb`.  This function
implements the `Homogeneous` virtual function `not_empty`
for the composing type `Bits`.

## empty (Bits)

        empty::Bits : (\Function : (
            returns : ::Bits,
            matches : (\Tuple:{::Bits}),
            implements : folder::'',
            evaluates : (0bb),
        )),

The function `empty::Bits` simply results in `0bb`.  This function
implements the `Homogeneous` virtual function `empty` for the composing
type `Bits`.

## substring_of (Bits)

        substring_of::Bits : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Bits, ::Bits}),
            implements : folder::'',
            evaluates : ((Bits_to_Array_Bits args:.\0) substring_of (Bits_to_Array_Bits args:.\1)),
        )),

The function `substring_of::Bits` implements the `Positional` virtual
function `substring_of` for the composing type `Bits`.

## overlaps_string (Bits)

        overlaps_string::Bits : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Bits, ::Bits}),
            implements : folder::'',
            is_commutative : 0bTRUE,
            evaluates : ((Bits_to_Array_Bits args:.\0)
                overlaps_string (Bits_to_Array_Bits args:.\1)),
        )),

The function `overlaps_string::Bits` implements the `Positional` virtual
function `overlaps_string` for the composing type `Bits`.

## disjoint_string (Bits)

        disjoint_string::Bits : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Bits, ::Bits}),
            implements : folder::'',
            is_commutative : 0bTRUE,
            evaluates : ((Bits_to_Array_Bits args:.\0)
                disjoint_string (Bits_to_Array_Bits args:.\1)),
        )),

The function `disjoint_string::Bits` implements the `Positional` virtual
function `disjoint_string` for the composing type `Bits`.

## catenate (Bits)

        catenate::Bits : (\Function : (
            returns : ::Bits,
            matches : (\Tuple:{::Bits, ::Bits}),
            implements : folder::'',
            is_associative : 0bTRUE,
            identity : 0bb,
            repeater : replicate::Bits,
            evaluates : (Bits_from_Array_Bits::((Bits_to_Array_Bits args:.\0)
                ~ (Bits_to_Array_Bits args:.\1))),
        )),

The function `catenate::Bits` implements the `Positional` virtual function
`catenate` aka `~` for the composing type `Bits`.

## replicate (Bits)

        replicate::Bits : (\Function : (
            returns : ::Bits,
            matches : (\Tuple:{::Bits, ::Integer_NN}),
            implements : folder::'',
            evaluates : (Bits_from_Array_Bits::((Bits_to_Array_Bits args:.\0) ~# args:.\1)),
        )),

The function `replicate::Bits` implements the `Positional` virtual function
`replicate` aka `~#` for the composing type `Bits`.

## Bits_from_Array_Bits

        Bits_from_Array_Bits : (\Function : (
            returns : ::Bits,
            matches : (\Tuple:{Array::Bits}),
            evaluates : ((\Bits : (\Tuple:{bits : args:.\0}))),
        )),

The function `Bits_from_Array_Bits` results in the `Bits` value selected
in terms of the integer sequence of its `0` argument.

## Bits_to_Array_Bits

        Bits_to_Array_Bits : (\Function : (
            returns : Array::Bits,
            matches : (\Tuple:{::Bits}),
            evaluates : (args:.\0:>.\bits),
        )),

The function `Bits_to_Array_Bits` results in an integer sequence defining
the bits of its `Bits`-typed `0` argument.

# BLOB DATA TYPES

## Blob

        Blob : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Positional]),
            evaluates : (Signature::Article_Match : (
                label : \Blob,
                attrs : (
                    octets : \Array::Octets(\Tuple:{}),
                ),
            )),
            default : 0xx,
        )),

The selection type definer `Blob` is infinite.  A `Blob` value is an
arbitrarily-long sequence of *octets* where each octet is represented by
an `Integer` in the range 0..255.  The default value of `Blob` is
`0xx` (the empty octet string).  `Blob` is `Orderable`; its minimum
value is the same `0xx` as its default value; it has no maximum value;
its ordering algorithm corresponds directly to that of `Array`, pairwise
as integer sequences.  Other programming languages may name their
corresponding types *Buf* or *byte(\Array:[])* or *bytea*.

## Array::Octets

        Array::Octets : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[\Array::(\Tuple:{}), \all::( 1: \in::( 1: 0..255 ) )]),
        )),

The selection type definer `Array::Octets` represents the infinite type
consisting just of the `Array` values for which every one of their member
values is an integer in the range 0..255 inclusive.

## in_order (Blob)

        in_order::Blob : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Blob, ::Blob}),
            implements : folder::'',
            evaluates : ((Blob_to_Octets args:.\0) in_order (Blob_to_Octets args:.\1)),
        )),

The function `in_order::Blob` implements the `Orderable` virtual
function `in_order` for the composing type `Blob`.

## not_empty (Blob)

        not_empty::Blob : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Blob}),
            implements : folder::'',
            evaluates : (args:.\0 != 0xx),
        )),

The function `not_empty::Blob` results in `0bTRUE` iff its `0` argument
is not `0xx`, and in `0bFALSE` if it is `0xx`.  This function
implements the `Homogeneous` virtual function `not_empty`
for the composing type `Blob`.

## empty (Blob)

        empty::Blob : (\Function : (
            returns : ::Blob,
            matches : (\Tuple:{::Blob}),
            implements : folder::'',
            evaluates : (0xx),
        )),

The function `empty::Blob` simply results in `0xx`.  This function
implements the `Homogeneous` virtual function `empty` for the composing
type `Blob`.

## substring_of (Blob)

        substring_of::Blob : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Blob, ::Blob}),
            implements : folder::'',
            evaluates : ((Blob_to_Octets args:.\0) substring_of (Blob_to_Octets args:.\1)),
        )),

The function `substring_of::Blob` implements the `Positional` virtual
function `substring_of` for the composing type `Blob`.

## overlaps_string (Blob)

        overlaps_string::Blob : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Blob, ::Blob}),
            implements : folder::'',
            is_commutative : 0bTRUE,
            evaluates : ((Blob_to_Octets args:.\0) overlaps_string (Blob_to_Octets args:.\1)),
        )),

The function `overlaps_string::Blob` implements the `Positional` virtual
function `overlaps_string` for the composing type `Blob`.

## disjoint_string (Blob)

        disjoint_string::Blob : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Blob, ::Blob}),
            implements : folder::'',
            is_commutative : 0bTRUE,
            evaluates : ((Blob_to_Octets args:.\0) disjoint_string (Blob_to_Octets args:.\1)),
        )),

The function `disjoint_string::Blob` implements the `Positional` virtual
function `disjoint_string` for the composing type `Blob`.

## catenate (Blob)

        catenate::Blob : (\Function : (
            returns : ::Blob,
            matches : (\Tuple:{::Blob, ::Blob}),
            implements : folder::'',
            is_associative : 0bTRUE,
            identity : 0xx,
            repeater : replicate::Blob,
            evaluates : (Blob_from_Octets::((Blob_to_Octets args:.\0) ~ (Blob_to_Octets args:.\1))),
        )),

The function `catenate::Blob` implements the `Positional` virtual function
`catenate` aka `~` for the composing type `Blob`.

## replicate (Blob)

        replicate::Blob : (\Function : (
            returns : ::Blob,
            matches : (\Tuple:{::Blob, ::Integer_NN}),
            implements : folder::'',
            evaluates : (Blob_from_Octets::((Blob_to_Octets args:.\0) ~# args:.\1)),
        )),

The function `replicate::Blob` implements the `Positional` virtual function
`replicate` aka `~#` for the composing type `Blob`.

## Blob_from_Octets

        Blob_from_Octets : (\Function : (
            returns : ::Blob,
            matches : (\Tuple:{Array::Octets}),
            evaluates : ((\Blob : (\Tuple:{octets : args:.\0}))),
        )),

The function `Blob_from_Octets` results in the `Blob` value selected in
terms of the integer sequence of its `0` argument.

## Blob_to_Octets

        Blob_to_Octets : (\Function : (
            returns : Array::Octets,
            matches : (\Tuple:{::Blob}),
            evaluates : (args:.\0:>.\octets),
        )),

The function `Blob_to_Octets` results in an integer sequence defining the
octets of its `Blob`-typed `0` argument.

# TEXTUAL DATA TYPES

## Textual

        Textual : (\Function : (
            is_type_definer : 0bTRUE,
            is_generalization : 0bTRUE,
            composes : (\Set:[::Positional]),
        )),

The interface type definer `Textual` is semifinite.  A `Textual` value is a
`Positional` value which is explicitly a sequence of character code points of some
repertoire, typically Unicode or a subset thereof such as ASCII.

`Textual` is composed by `Text`, which implements `Orderable` using the
simple culture-agnostic method of ordering code points numerically.
Idiomatically each culture-specific text collation method will have its own
distinct `Textual`-composing type that implements `Orderable` in its own
way, so the latter's operators will just work like users expect.

The `System` package excludes the majority of useful operators specific to
working with character strings; see instead other Muldis Data Language packages such as
`System::Text` for these things.  Such tasks
include like case folding, pattern matching, whitespace trimming, Unicode
normalization, encoding to and decoding from most binary formats, and so on.

Muldis Data Language is designed expressly to avoid mandatory external dependencies of
large complexity, such as most of the details of Unicode, in contrast with
a lot of the more modern languages of its time.  The Muldis Data Language Foundation
and `System` package are strictly limited in their knowledge of Unicode;
they know that a code point of the Unicode repertoire is just in the integer
set `{0..0xD7FF,0xE000..0x10FFFF}`,
and that the leading subset `0..127` is also 7-bit
ASCII, and they know how to read and write the fairly simple and stable
`UTF-8` binary encoding for Unicode text, which is a proper superset of
7-bit ASCII encoding and is CPU endian-agnostic.  In contrast, anything to
do with knowing what abstract characters exist, and their various
properties (\Tuple:{upper or lowercase, combining or not, etc}), anything to do with
normalization or folding or pattern matching, and anything to do with other
binary encodings or character repertoires especially endian-specific, this
is all expressly *not* part of the language core.  A
Muldis Data Language implementation can choose whether or not to support them, allowing
for a lower barrier to entry.  Unicode in particular requires a vast
knowledge base to work properly with that is regularly updated, and
Muldis Data Language has a principle that it is better to have multiple specialized components
that do their jobs well, such as handle Unicode intricacies, while the core
language can focus on other core competencies that don't involve complex
externally-defined moving targets.  The `System` package loosely just
considers a character string to be a sequence of generic integers and
doesn't ascribe very many distinct semantics to particular ones, while
non-`System` code is empowered to do that instead.

## to_Text

        to_Text::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Text,
            matches : (\Tuple:{::Textual}),
        )),

The virtual function `to_Text` results in the `Text` value that
represents the same character string value as its `0` argument.  The
purpose of `to_Text` is to canonicalize `Textual` values so they can be
compared or worked with as character strings in a manner agnostic to things
like national collations or fixed-size types.

*TODO: Add an Excuse for when the source type has non-Unicode characters.*

# TEXT DATA TYPES

## Text Text::Unicode

        Text::'' : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Textual]),
            provides_default_for : (\Set:[::Textual]),
            evaluates : (Signature::Article_Match : (
                label : \Text,
                attrs : (
                    unicode_codes : \Array::Unicode_Codes(\Tuple:{}),
                ),
            )),
            default : "",
        )),

        Text::Unicode : (\Alias : (\Tuple:{ of : ::Text })),

The selection type definer `Text`
represents the infinite foundation type `foundation::Text`.
A `Text` value is characterized by an arbitrarily-large ordered sequence of
Unicode standard *character code points*, where each distinct code point
corresponds to a distinct integer in the set `(\Array:[0..0xD7FF,0xE000..0x10FFFF])`,
which explicitly does not represent any kind of thing in particular.
Each character is taken from a finite repertoire having 0x10F7FF members,
but `Text` imposes no limit on the length of each character sequence.
A `Text` value is isomorphic to an `Attr_Name` value.
`Text` has a default value of `""` (the empty character string).
`Text` is `Orderable`; its minimum value is `""`; it has no maximum value;
its ordering algorithm corresponds directly to that of `Array`,
pairwise as integer sequences.
Other programming languages may name their
corresponding types *Str* or *string* or *varchar* or *char*.

There are many defined character sets in the computing world that map
agreed upon sets of symbols to integers.  For those character repertoires
that are a subset of Unicode, such as 7-bit ASCII or ISO Latin 1 or EBCDIC,
the `Text` type should map with character strings using them in a simple
and well-defined way, although the integers used to represent the same
logical characters may be different.  But for other character sets that are
not a subset of Unicode, such as ISO/IEC 2022 or Mojikyo or HKSCS, a
`Text` value can not directly represent all possible character strings
that they can, and so other `Textual`-composing types should be used
instead for such character strings.

## Array::Unicode_Codes

        Array::Unicode_Codes : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[\Array::(\Tuple:{}),
                \all::( 1: \in::( 1: ?..(\Set:[0..0xD7FF,0xE000..0x10FFFF]) ) )]),
        )),

The selection type definer `Array::Unicode_Codes` represents the infinite type
consisting just of the `Array` values for which every one of their member
values is an integer in the range {0..0xD7FF,0xE000..0x10FFFF} inclusive.

## Text::ASCII

        Text::ASCII : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Text::Unicode::(args:.\0) and_then guard
                Array::ASCII_Chars::(Text_from_Unicode_Codes args:.\0)),
        )),

The selection type definer `Text::ASCII` represents the infinite type
consisting just of the `Text` values for which every one of their member
characters is a member of the 128-character repertoire of 7-bit ASCII.
This `Text` subtype has its own canonical representation in terms of an
`Array` value named `ASCII_Chars` where each member code point matches
the standard ASCII codes for the same symbols.

## Array::ASCII_Chars

        Array::ASCII_Chars : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[\Array::Unicode_Codes(\Tuple:{}), \all::( 1: \in::( 1: 0..127 ) )]),
        )),

The selection type definer `Array::ASCII_Chars` represents the infinite type
consisting just of the `Array` values for which every one of their member
values is an integer in the range 0..127 inclusive.

## in_order (Text)

        in_order::Text : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Text, ::Text}),
            implements : folder::'',
            evaluates : ((Text_to_Unicode_Codes args:.\0) in_order (Text_to_Unicode_Codes args:.\1)),
        )),

The function `in_order::Text` implements the `Orderable` virtual
function `in_order` for the composing type `Text`.

## not_empty (Text)

        not_empty::Text : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Text}),
            implements : folder::'',
            evaluates : (args:.\0 != ""),
        )),

The function `not_empty::Text` results in `0bTRUE` iff its `0` argument
is not `""`, and in `0bFALSE` if it is `""`.  This function implements the
`Homogeneous` virtual function `not_empty` for the composing type `Text`.

## empty (Text)

        empty::Text : (\Function : (
            returns : ::Text,
            matches : (\Tuple:{::Text}),
            implements : folder::'',
            evaluates : (""),
        )),

The function `empty::Text` simply results in `""`.  This function
implements the `Homogeneous` virtual function `empty` for the composing
type `Text`.

## substring_of (Text)

        substring_of::Text : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Text, ::Text}),
            implements : folder::'',
            evaluates : ((Text_to_Unicode_Codes args:.\0)
                substring_of (Text_to_Unicode_Codes args:.\1)),
        )),

The function `substring_of::Text` implements the `Positional` virtual
function `substring_of` for the composing type `Text`.

## overlaps_string (Text)

        overlaps_string::Text : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Text, ::Text}),
            implements : folder::'',
            is_commutative : 0bTRUE,
            evaluates : ((Text_to_Unicode_Codes args:.\0)
                overlaps_string (Text_to_Unicode_Codes args:.\1)),
        )),

The function `overlaps_string::Text` implements the `Positional` virtual
function `overlaps_string` for the composing type `Text`.

## disjoint_string (Text)

        disjoint_string::Text : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Text, ::Text}),
            implements : folder::'',
            is_commutative : 0bTRUE,
            evaluates : ((Text_to_Unicode_Codes args:.\0)
                disjoint_string (Text_to_Unicode_Codes args:.\1)),
        )),

The function `disjoint_string::Text` implements the `Positional` virtual
function `disjoint_string` for the composing type `Text`.

## catenate (Text)

        catenate::Text : (\Function : (
            returns : ::Text,
            matches : (\Tuple:{::Text, ::Text}),
            implements : folder::'',
            is_associative : 0bTRUE,
            identity : "",
            repeater : replicate::Text,
            evaluates : (Text_from_Unicode_Codes::((Text_to_Unicode_Codes args:.\0)
                ~ (Text_to_Unicode_Codes args:.\1))),
        )),

The function `catenate::Text` implements the `Positional` virtual function
`catenate` aka `~` for the composing type `Text`.

## replicate (Text)

        replicate::Text : (\Function : (
            returns : ::Text,
            matches : (\Tuple:{::Text, ::Integer_NN}),
            implements : folder::'',
            evaluates : (Text_from_Unicode_Codes::((Text_to_Unicode_Codes args:.\0) ~# args:.\1)),
        )),

The function `replicate::Text` implements the `Positional` virtual function
`replicate` aka `~#` for the composing type `Text`.

## to_Text (Text)

        to_Text::Text : (\Function : (
            returns : ::Text,
            matches : (\Tuple:{::Text}),
            implements : folder::'',
            evaluates : (args:.\0),
        )),

The function `to_Text::Text` simply results in its `0` argument.
This function implements the `Textual` virtual function `to_Text`
for the composing type `Text`.

## Text_from_Unicode_Codes

        Text_from_Unicode_Codes : (\Function : (
            returns : ::Text,
            matches : (\Tuple:{Array::Unicode_Codes}),
            evaluates : ((\Text : (\Tuple:{unicode_codes : args:.\0}))),
        )),

The function `Text_from_Unicode_Codes` results in the `Text` value selected
in terms of an integer sequence in the standard Unicode code point
mapping of its `0` argument.

## Text_to_Unicode_Codes

        Text_to_Unicode_Codes : (\Function : (
            returns : Array::Unicode_Codes,
            matches : (\Tuple:{::Text}),
            evaluates : (args:.\0:>.\unicode_codes),
        )),

The function `Text_to_Unicode_Codes` results in an integer sequence in the
standard Unicode code point mapping that corresponds to its
`Text`-typed `0` argument.

## Text_from_ASCII_Chars

        Text_from_ASCII_Chars : (\Function : (
            returns : Text::ASCII,
            matches : (\Tuple:{Array::ASCII_Chars}),
            evaluates : (Text_from_Unicode_Codes args:.\0),
        )),

The function `Text_from_ASCII_Chars` results in the `Text` value selected
in terms of an integer sequence in the standard 7-bit ASCII character
mapping of its `0` argument.

## Text_to_ASCII_Chars

        Text_to_ASCII_Chars : (\Function : (
            returns : Array::ASCII_Chars,
            matches : (\Tuple:{Text::ASCII}),
            evaluates : (Text_to_Unicode_Codes args:.\0),
        )),

The function `Text_to_ASCII_Chars` results in an integer sequence in the
standard 7-bit ASCII character mapping that corresponds to its
`Text`-typed `0` argument.

## Blob_is_UTF_8

        Blob_is_UTF_8 : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Blob}),
            evaluates : (...),
        )),

*TODO.  See also https://tools.ietf.org/html/rfc3629 for the UTF-8 definition.*

*TODO.  Note that while the UTF-8 encoding scheme can represent all Unicode
code points in the range 0..0x1FFFFF with 4 octets (and all 0..0x7FFFFFFF
with 6 octets), the UTF-8 standard further restricts the range to
{0..0xD7FF,0xE000..0x10FFFF} to match the constraints of the limitations of UTF-16.*

*TODO.  Note that we don't define a Blob::UTF_8 type as
it is superfluous with simply trying to decode one and see if it succeeded.*

## Text_from_UTF_8_Blob

        Text_from_UTF_8_Blob : (\Function : (
            returns : (\Set:[Text::Unicode, Unicode::..., ...]),
            matches : (\Tuple:{::Blob}),
            evaluates : (...),
        )),

*TODO.  As a code/implementation comment, say the parallel design is
benefitting from the self-syncrhonizing nature that is a key feature of UTF-8.*

*TODO.  Note, the multiple Excuse options are used to indicate the
different reasons why the Blob is not considered valid UTF-8, including
that it doesn't use the fewest bytes possible for a character, or it
represents code points greater than 0x10FFFF or it represents illegal
code points in the 0xD800..0xDFFF range of UTF-16 surrogates, or it has the
wrong number of continuation bytes following an ASCII char or starting byte
etc.  If a Blob contains multiple errors, the returned Excuse is for the
error closest to the start of the Blob; that is, chained anticoalesce(\Tuple:{}) is
used. TODO, perhaps declare a union type collecting the Unicode errors like
we have with rounding methods, or we actually may have multiple Unicode sets.*

*TODO.  See also http://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-test.txt
and http://cpansearch.perl.org/src/RJBS/perl-5.24.0/t/op/utf8decode.t for
some decoder edge case testing.*

## Text_from_UTF_8_Blob_with_repl_Text

        Text_from_UTF_8_Blob_with_repl_Text : (\Function : (
            returns : Text::Unicode,
            matches : (\Tuple:{::Blob, Text::Unicode}),
            evaluates : (...),
        )),

*TODO.  Each invalid octet encountered is replaced by the substitution text
(\Tuple:{which can be a single character, or several, or the empty string}).  For
consistency, even if the sequence decodes fine in one sense but is an out
of range character, the instances of substitution are per count of octets
not one per character.*

## Text_from_UTF_8_Blob_with_repl_char

        Text_from_UTF_8_Blob_with_repl_char : (\Function : (
            returns : Text::Unicode,
            matches : (\Tuple:{::Blob}),
            evaluates : (Text_from_UTF_8_Blob_with_repl_Text::(\Tuple:{args:.\0,"\\c<0xFFFD>"})),
        )),

*TODO.  The special Unicode char "REPLACEMENT CHARACTER" aka 0xFFFD is used.*

## Text_to_UTF_8_Blob

        Text_to_UTF_8_Blob : (\Function : (
            returns : ::Blob,
            matches : (\Tuple:{Text::Unicode}),
            evaluates : (...),
        )),

*TODO.  This should just work as Text::Unicode excludes the surrogate
pairs and out of range etc stuff.*

## Blob_is_ASCII

        Blob_is_ASCII : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Blob}),
            evaluates : (Array::ASCII_Chars(Blob_to_Octets args:.\0)),
        )),

*TODO.*

## Text_from_ASCII_Blob

        Text_from_ASCII_Blob : (\Function : (
            returns : (\Set:[Text::ASCII, ASCII::High_Bit_Not_Zero]),
            matches : (\Tuple:{::Blob}),
            evaluates : (
                octets ::= Blob_to_Octets args:.\0;
                returns if Array::ASCII_Chars(octets)
                    then guard Text_from_ASCII_Chars octets
                    else ASCII::High_Bit_Not_Zero(\Tuple:{});
            ),
        )),

*TODO.  Note, still have to define that Excuse.*

## Text_from_ASCII_Blob_with_repl_Text

        Text_from_ASCII_Blob_with_repl_Text : (\Function : (
            returns : Text::ASCII,
            matches : (\Tuple:{::Blob, Text::ASCII}),
            evaluates : (
                src_octets ::= Blob_to_Octets args:.\0;
                repl_chars ::= Text_to_ASCII_Chars args:.\1;
                result_chars ::=
                    given #repl_chars
                        when 0 then
                            src_octets where \in::( 1: 0..127 )
                        when 1 then guard
                            src_octets
                                map \(if args:.\0 in 0..127 then args:.\0 else args:.\1)
                                    <-- (\Tuple:{1 : repl_chars.0})
                        default
                            src_octets
                                map \(if args:.\0 in 0..127 then (\Array:[args:.\0]) else args:.\1)
                                    <-- (\Tuple:{1 : repl_chars})
                                reduce \catenate::(\Tuple:{})
                    ;
                returns Text_from_ASCII_Chars result_chars;
            ),
        )),

*TODO.  Each invalid octet encountered is replaced by the substitution text
(\Tuple:{which can be a single character, or several, or the empty string}).
Note there is no alternate with a predefined substitution char as there
is no good implicit default in ASCII, unlike with Unicode.*

## Text_to_ASCII_Blob

        Text_to_ASCII_Blob : (\Function : (
            returns : ::Blob,
            matches : (\Tuple:{Text::ASCII}),
            evaluates : (Blob_from_Octets::(Text_to_ASCII_Chars args:.\0)),
        )),

*TODO.*

# ARRAY DATA TYPES

## Array

        Array::'' : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Positional]),
            provides_default_for : (\Set:[::Positional]),
            evaluates : \foundation::Array(\Tuple:{}),
            default : (\Array:[]),
        )),

The selection type definer `Array` represents the infinite Muldis Data Language Foundation
type `foundation::Array`.  An `Array` value is a general purpose
arbitrarily-long ordered sequence of any other, *member* values, which
explicitly does not represent any kind of thing in particular, and is
simply the sum of its members.  An `Array` value is dense; iff it has any
members, then its first-ordered member is at ordinal position `0`, and its
last-ordinal-positioned member is at the ordinal position that is one less than the
count of its members.  An `Array` in the general case may have
multiple members that are the same value, and any duplicates may or may not
exist at consecutive ordinal positions.  The default value of `Array` is `(\Array:[])`, the
only zero-member `Array` value.  `Array` is `Orderable`; its minimum
value is the same `(\Array:[])` as its default value; it has no maximum value; its
ordering algorithm is defined by `Positional`.  Other programming
languages may name their corresponding types *List*.

## Array_C0 ~∅

        Array_C0 : (\Function : (
            is_type_definer : 0bTRUE,
            constant : (\Array:[]),
        )),

        Unicode_Aliases::'~∅' : (\Alias : (\Tuple:{ of : ::Array_C0 })),

The singleton type definer `Array_C0` aka `~∅` represents the only zero-member
`Array` value, `(\Array:[])`.

## in_order (Array)

        in_order::Array : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Array, ::Array}),
            implements : folder::'',
            evaluates : (
                i ::= args:.\0 ord_pos_succ_all_matches args:.\1;
              returns
                if not args:.\0 .? i then
                    e1 ::= 0bTRUE
                else if not args:.\1 .? i then
                    0bFALSE
                else guard
                    e2 ::= args:.\0.i in_order args:.\1.i;

                e1 note "This is the case where LHS is a leading subsequence of or is equal to RHS.";
                e2 note "This will succeed iff in_order(\Tuple:{}) is defined for the member type.";
            ),
        )),

The function `in_order::Array` implements the `Orderable` virtual
function `in_order` for the composing type `Array`.  This function
will succeed iff `in_order` is also defined for the types of the members.

## not_empty (Array)

        not_empty::Array : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Array}),
            implements : folder::'',
            evaluates : (args:.\0 != (\Array:[])),
        )),

The function `not_empty::Array` results in `0bTRUE` iff its `0` argument
has any members, and in `0bFALSE` iff it has no members.  This function
implements the `Homogeneous` virtual function `not_empty`
for the composing type `Array`.

## empty (Array)

        empty::Array : (\Function : (
            returns : ::Array,
            matches : (\Tuple:{::Array}),
            implements : folder::'',
            evaluates : ((\Array:[])),
        )),

The function `empty::Array` results in the only zero-member `Array`
value.  This function implements the `Homogeneous` virtual function `empty`
aka `∅` for the composing type `Array`.

## has_n (Array)

        has_n::Array : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Array, ::Any, ::Integer_NN}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Array_has_n(\Tuple:{})),
        )),

The function `has_n::Array` results in `0bTRUE` iff its `0` argument has
at least N members at any ordinal-positions such that each is equal to its `1`
argument, where N is defined by its `2` argument; otherwise it results in
`0bFALSE`.  This function implements the `Homogeneous` virtual function
`has_n` for the composing type `Array`.

## multiplicity (Array)

        multiplicity::Array : (\Function : (
            returns : ::Integer_NN,
            matches : (\Tuple:{::Array, ::Any}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Array_multiplicity(\Tuple:{})),
        )),

The function `multiplicity::Array` results in the integral count
of members of its `0` argument such that each member value is equal to its
`1` argument.  This function implements the `Homogeneous` virtual
function `multiplicity` for the composing type `Array`.

## all_unique (Array)

        all_unique::Array : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Array}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Array_all_unique(\Tuple:{})),
        )),

The function `all_unique::Array` results in `0bTRUE` iff its `0` argument
has no 2 members that are the same value, and `0bFALSE` otherwise.  This
function implements the `Homogeneous` virtual function `all_unique` for
the composing type `Array`.

## unique (Array)

        unique::Array : (\Function : (
            returns : ::Array,
            matches : (\Tuple:{::Array}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Array_unique(\Tuple:{})),
        )),

The function `unique::Array` results in the `Array` value that has, for
every distinct member value *V* of the function's `0` argument, exactly 1
member whose value is equal to *V*.  Each retained member is the one
closest to the start of the argument out of those members sharing the
retained member's value.  This function implements the `Homogeneous`
virtual function `unique` for the composing type `Array`.

## any (Array)

        any::Array : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Array, ::Signature}),
            implements : folder::'',
            evaluates : (foundation::Array_any(args:.\0, Signature_to_Function_Call_But_0::(args:.\1))),
        )),

*TODO.*

## insert_n (Array)

        insert_n::Array : (\Function : (
            returns : ::Array,
            matches : (\Tuple:{::Array, ::Any, ::Integer_NN}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Array_insert_n(\Tuple:{})),
        )),

The function `insert_n::Array` results in the `Array` value that has all
of the members of the function's `0` argument plus N additional members
that are each equal to its `1` argument, where N is defined by its `2`
argument.  The result starts with all of the members of `0` in the same
order and ends with any added instances of `1`.  This function implements
the `Unionable` virtual function `insert_n` for the composing type
`Array`.

## remove_n (Array)

        remove_n::Array : (\Function : (
            returns : ::Array,
            matches : (\Tuple:{::Array, ::Any, ::Integer_NN}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Array_remove_n(\Tuple:{})),
        )),

The function `remove_n::Array` results in the `Array` value that has all
of the members of the function's `0` argument minus N existing members
that are each equal to its `1` argument, where N is defined as the lesser
of its `2` argument and the count of members of `0` equal to the `1`
argument.  The removed instances of `1` are those closest to the end of
`0`.  This function implements the `Unionable` virtual function
`remove_n` for the composing type `Array`.

## except (Array)

        except::Array : (\Function : (
            returns : ::Array,
            matches : (\Tuple:{::Array, ::Array}),
            implements : folder::'',
            right_identity : (\Array:[]),
            evaluates : (evaluates args --> \foundation::Array_except(\Tuple:{})),
        )),

The function `except::Array` results in the *multiset difference* between
its 2 arguments `0` (*minuend*) and `1` (*subtrahend*).  The result is
the `Array` value that has all of the members of the function's `0`
argument minus all of the matching members of its `1` argument.  The
removed instances of any distinct member value are those closest to the end
of `0`.  This function implements the `Unionable` virtual function
`except` aka `∖` for the composing type `Array`.

## intersect (Array)

        intersect::Array : (\Function : (
            returns : ::Array,
            matches : (\Tuple:{::Array, ::Array}),
            implements : folder::'',
            is_associative : 0bTRUE,
            is_idempotent : 0bTRUE,
            evaluates : (evaluates args --> \foundation::Array_intersect(\Tuple:{})),
        )),

The function `intersect::Array` results in the *multiset intersection* of
its 2 arguments `0` and `1`.  The result is the `Array` value that has
all of the members of the function's `0` argument that match their own
members of its `1` argument.  The removed instances of any distinct member
value are those closest to the end of `0`.  This operation conceptually
has a *two-sided identity element* value of a collection with an infinite number of members.
This function implements the `Unionable` virtual function `intersect`
aka `∩` for the composing type `Array`.

## union (Array)

        union::Array : (\Function : (
            returns : ::Array,
            matches : (\Tuple:{::Array, ::Array}),
            implements : folder::'',
            is_idempotent : 0bTRUE,
            identity : (\Array:[]),
            evaluates : (evaluates args --> \foundation::Array_union(\Tuple:{})),
        )),

The function `union::Array` results in the *multiset union* of its 2
arguments `0` and `1`.  The result is the `Array` value that has all of
the members of the function's `0` argument plus all of the nonmatching
members of its `1` argument.  The result starts with all of the members of
`0` and ends with the nonmatching members of `1`, the members from both
in the same order as in their respective arguments; the removed (due to
matching) instances of any distinct member value are those closest to the
end of `1`.  This function implements the `Unionable` virtual function
`union` aka `∪` for the composing type `Array`.

## exclusive (Array)

        exclusive::Array : (\Function : (
            returns : ::Array,
            matches : (\Tuple:{::Array, ::Array}),
            implements : folder::'',
            identity : (\Array:[]),
            evaluates : (evaluates args --> \foundation::Array_exclusive(\Tuple:{})),
        )),

The function `exclusive::Array` results in the *multiset symmetric
difference* of its 2 arguments `0` and `1`.  The result is the `Array`
value that has all of the members of each of the function's `0` and `1`
arguments that do not have matching members of their counterpart argument.
The result starts with the nonmatching members of `0` and ends with the
nonmatching members of `1`, the members from both in the same order as in
their respective arguments; the removed (due to matching) instances of any
distinct member value are those closest to the end of `0` or `1`
respectively.  This function implements the `Unionable` virtual function
`exclusive` aka `symm_diff` aka `∆` for the composing type `Array`.

## nest (Array)

        nest::Array : (\Function : (
            returns : ::Array,
            matches : (\Tuple:{::Array}),
            implements : folder::'',
            accepts : (...),
            evaluates : (evaluates args --> \foundation::Array_nest(\Tuple:{})),
        )),

*TODO.*

## unnest (Array)

        unnest::Array : (\Function : (
            returns : ::Array,
            matches : (\Tuple:{::Array}),
            implements : folder::'',
            accepts : (...),
            evaluates : (evaluates args --> \foundation::Array_unnest(\Tuple:{})),
        )),

*TODO.*

## where (Array)

        where::Array : (\Function : (
            returns : ::Array,
            matches : (\Tuple:{::Array, ::Signature}),
            implements : folder::'',
            evaluates : (foundation::Array_where(args:.\0, Signature_to_Function_Call_But_0::(args:.\1))),
        )),

*TODO.*

## map (Array)

        map::Array : (\Function : (
            returns : ::Array,
            matches : (\Tuple:{::Array, ::Function_Call_But_0}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Array_map(\Tuple:{})),
        )),

*TODO.*

## reduce (Array)

        reduce::Array : (\Function : (
            returns : ::Any,
            matches : (\Tuple:{::Array, ::Function_Call_But_0_1}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Array_reduce(\Tuple:{})),
        )),

*TODO.*

## to_Set (Array)

        to_Set::Array : (\Function : (
            returns : ::Set,
            matches : (\Tuple:{::Array}),
            implements : folder::'',
            evaluates : (to_Set::(to_Bag args:.\0)),
        )),

The function `to_Set::Array` results in the `Set` value that has, for
every distinct member value *V* of the function's `0` argument, exactly 1
member whose value is equal to *V*.  This function implements the
`Discrete` virtual function `to_Set` aka `?|` for the composing type
`Array`.

## to_Bag (Array)

        to_Bag::Array : (\Function : (
            returns : ::Bag,
            matches : (\Tuple:{::Array}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Array_to_Bag(\Tuple:{})),
        )),

The function `to_Bag::Array` results in the `Bag` value that has all of
the members of the function's `0` argument.  This function implements the
`Discrete` virtual function `to_Bag` aka `+|` for the composing type
`Array`.

## count (Array)

        count::Array : (\Function : (
            returns : ::Integer_NN,
            matches : (\Tuple:{::Array}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Array_count(\Tuple:{})),
        )),

The function `count::Array` results in the integral count of the members
of its `0` argument.  This function implements the `Discrete` virtual
function `count` aka `cardinality` aka `#` for the composing type
`Array`.

## order_using (Array)

        order_using::Array : (\Function : (
            returns : ::Array,
            matches : (\Tuple:{::Array, ::Function_Call_But_0_1}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Array_order_using(\Tuple:{})),
        )),

The function `order_using::Array` results in the `Array` value that
represents the same multiset of members as its `0` argument but that the
members are arranged into a sequence in accordance with a total order
defined by the function given in its `1` argument.  This function
implements the `Discrete` virtual function `order_using` for the composing
type `Array`.

## at (Array)

        at::Array : (\Function : (
            returns : ::Any,
            matches : (\Tuple:{::Array, ::Integer_NN}),
            implements : folder::'',
            accepts : (args:.\0 .? args:.\1),
            evaluates : (evaluates args --> \foundation::Array_at(\Tuple:{})),
        )),

The function `at::Array` results in the member value of its `0` argument
whose ordinal position is equal to its `1` argument.  This function will
fail if the `0` argument doesn't have such a member.  This function
implements the `Accessible` virtual function `at` aka `.` for the
composing type `Array`.

## to_Array (Array)

        to_Array::Array : (\Function : (
            returns : ::Array,
            matches : (\Tuple:{::Array}),
            implements : folder::'',
            evaluates : (args:.\0),
        )),

The function `to_Array::Array` simply results in its `0` argument.  This
function implements the `Positional` virtual function `to_Array` aka
`~|` for the composing type `Array`.

## substring_of (Array)

        substring_of::Array : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Array, ::Array}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Array_substring_of(\Tuple:{})),
        )),

The function `substring_of::Array` results in `0bTRUE` iff the sequence of
members of its `0` argument is a substring of the sequence of members of
its `1` argument; otherwise it results in `0bFALSE`.  This function
implements the `Positional` virtual function `substring_of` for the
composing type `Array`.

## overlaps_string (Array)

        overlaps_string::Array : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Array, ::Array}),
            implements : folder::'',
            is_commutative : 0bTRUE,
            evaluates : (evaluates args --> \foundation::Array_overlaps_string(\Tuple:{})),
        )),

The function `overlaps_string::Array` results in `0bTRUE` iff, given *X*
as the sequence of members of its argument `0` and *Y* as the sequence of
members of its argument `1`, when *X* and *Y* are overlapped to the
greatest possible extent such that every corresponding member pair has 2 of
the same value, the overlap of *X* and *Y* has at least 1 member, and
each of *X* and *Y* has at least 1 member that is not overlapped;
otherwise it results in `0bFALSE`.  This function implements the `Positional`
virtual function `overlaps_string` for the composing type `Array`.

## disjoint_string (Array)

        disjoint_string::Array : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Array, ::Array}),
            implements : folder::'',
            is_commutative : 0bTRUE,
            evaluates : (evaluates args --> \foundation::Array_disjoint_string(\Tuple:{})),
        )),

The function `disjoint_string::Array` results in `0bTRUE` iff the sequence
of members of its `0` argument can not be overlapped with the sequence of
members of its `1` argument by at least 1 member such that every
corresponding member pair has 2 of the same value; otherwise it results in
`0bFALSE`.  This function implements the `Positional` virtual function
`disjoint_string` for the composing type `Array`.

## catenate (Array)

        catenate::Array : (\Function : (
            returns : ::Array,
            matches : (\Tuple:{::Array, ::Array}),
            implements : folder::'',
            is_associative : 0bTRUE,
            identity : (\Array:[]),
            repeater : replicate::Array,
            evaluates : (evaluates args --> \foundation::Array_catenate(\Tuple:{})),
        )),

The function `catenate::Array` results in the catenation of its 2
arguments `0` and `1` such that the result starts with the members of
`0` and ends with the members of `1`.  This function implements the
`Positional` virtual function `catenate` aka `~` for the composing type
`Array`.

## replicate (Array)

        replicate::Array : (\Function : (
            returns : ::Array,
            matches : (\Tuple:{::Array, ::Integer_NN}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Array_replicate(\Tuple:{})),
        )),

The function `replicate::Array` results in the catenation of N instances
of its `0` argument where N is defined by its `1` argument.  If the `1`
argument is zero then the result is the only zero-member `Array`.  This
function implements the `Positional` virtual function `replicate` aka `~#`
for the composing type `Array`.

## first_possible_ord_pos (Array)

        first_possible_ord_pos::Array : (\Function : (
            returns : ::Integer_NN,
            matches : (\Tuple:{::Array}),
            implements : folder::'',
            evaluates : (0),
        )),

The function `first_possible_ord_pos::Array` simply results in `0`.  This
function implements the `Positional` virtual function
`first_possible_ord_pos` for the composing type `Array`.

## slice_n (Array)

        slice_n::Array : (\Function : (
            returns : ::Array,
            matches : (\Tuple:{::Array, ::NN_Integer, ::NN_Integer}),
            implements : folder::'',
            accepts : (args:.\1 + args:.\2 <= #args:.\0),
            evaluates : (evaluates args --> \foundation::Array_slice_n(\Tuple:{})),
        )),

The function `slice_n::Array` results in the `Array` value that has
exactly *N* consecutive members of the function's `0` argument *C*, in
the same order, such that the first member existed at ordinal position *F*
of *C* where *F* and *N* are equal to the function's `1` and `2`
arguments respectively.  The taken members do not necessarily occupy the
same ordinal positions in the result as they did in *C*.  This function will
fail if *C* does not have members at any of the ordinal positions requested.
This function implements the `Positional` virtual function `slice_n` for
the composing type `Array`.

## ord_pos_succ_all_matches (Array)

        ord_pos_succ_all_matches::Array : (\Function : (
            returns : ::Integer_NN,
            matches : (\Tuple:{::Array, ::Array}),
            implements : folder::'',
            is_commutative : 0bTRUE,
            evaluates : (evaluates args --> \foundation::Array_ord_pos_succ_all_matches(\Tuple:{})),
        )),

*TODO.  While conceivably implementable at a higher level, make low level
for perceived efficiency.*

# SETTY DATA TYPES

## Setty

        Setty : (\Function : (\Tuple:{
            is_type_definer : 0bTRUE,
            is_generalization : 0bTRUE,
        })),

The semantic type definer `Setty` is semifinite.  A `Setty` value is a
*collective* value such that every one of its component *members* is a
distinct value.  The default value of `Setty` is the `Set` value with
zero members, `(\Set:[])`.  `Setty` is composed, directly or indirectly, by:
`Set`, `Relation`, `Interval`, `Set_Of_Interval`.

# SET DATA TYPES

## Set

        Set : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Discrete, ::Setty]),
            provides_default_for : (\Set:[::Setty]),
            evaluates : (Signature::Article_Match : (
                label : \Set,
                attrs : (
                    members : (\Array:[\Bag::(\Tuple:{}), \all_unique::(\Tuple:{})]),
                ),
            )),
            default : (\Set:[]),
        )),

The selection type definer `Set` is infinite.  A `Set` value is a general
purpose arbitrarily-large unordered collection of any other, *member*
values, which explicitly does not represent any kind of thing in
particular, and is simply the sum of its members.  A `Set` ensures that no
2 of its members are the same value.  The default value of `Set` is `(\Set:[])`,
the only zero-member `Set` value.

## Set_C0 ?∅

        Set_C0 : (\Function : (
            is_type_definer : 0bTRUE,
            constant : (\Set:[]),
        )),

        Unicode_Aliases::'?∅' : (\Alias : (\Tuple:{ of : ::Set_C0 })),

The singleton type definer `Set_C0` aka `?∅` represents the only zero-member
`Set` value, `(\Set:[])`.

## not_empty (Set)

        not_empty::Set : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Set}),
            implements : folder::'',
            evaluates : (args:.\0 != (\Set:[])),
        )),

The function `not_empty::Set` results in `0bTRUE` iff its `0` argument
has any members, and in `0bFALSE` iff it has no members.  This function
implements the `Homogeneous` virtual function `not_empty`
for the composing type `Set`.

## empty (Set)

        empty::Set : (\Function : (
            returns : ::Set,
            matches : (\Tuple:{::Set}),
            implements : folder::'',
            evaluates : ((\Set:[])),
        )),

The function `empty::Set` results in the only zero-member `Set`
value.  This function implements the `Homogeneous` virtual function `empty`
aka `∅` for the composing type `Set`.

## singular (Set)

        singular::Set : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Set}),
            implements : folder::'',
            evaluates : (singular args:.\0:>.\members),
        )),

The function `singular::Set` results in `0bTRUE` iff its `0` argument has
exactly 1 member value, and `0bFALSE` otherwise.  This function implements
the `Homogeneous` virtual function `singular` for the composing type
`Set`.

## only_member (Set)

        only_member::Set : (\Function : (
            returns : ::Any,
            matches : (\Tuple:{::Set}),
            implements : folder::'',
            accepts : (singular args:.\0),
            evaluates : (only_member args:.\0:>.\members),
        )),

The function `only_member::Set` results in its `0` argument's only member
value.  This function will fail if the argument doesn't have exactly 1
member value.  This function implements the `Homogeneous` virtual function
`only_member` for the composing type `Set`.

## has_n (Set)

        has_n::Set : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Set, ::Any, ::Integer_NN}),
            implements : folder::'',
            evaluates : (has_n::(\Tuple:{args:.\0:>.\members, args:.\1, args:.\2})),
        )),

The function `has_n::Set` results in `0bTRUE` iff either its `2` argument
is zero or its `0` argument has a member equal to its `1` argument and
its `2` argument is 1; otherwise it results in `0bFALSE`.  This function
implements the `Homogeneous` virtual function `has_n` for the composing
type `Set`.

## multiplicity (Set)

        multiplicity::Set : (\Function : (
            returns : ::Integer_NN,
            matches : (\Tuple:{::Set, ::Any}),
            implements : folder::'',
            evaluates : (args:.\0:>.\members multiplicity args:.\1),
        )),

The function `multiplicity::Set` results in 1 if its `0` argument
has a member equal to its `1` argument; otherwise it results in 0.  This
function implements the `Homogeneous` virtual function `multiplicity` for
the composing type `Set`.

## all_unique (Set)

        all_unique::Set : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Set}),
            implements : folder::'',
            evaluates : (0bTRUE),
        )),

The function `all_unique::Set` simply results in `0bTRUE`.  This function
implements the `Homogeneous` virtual function `all_unique` for the
composing type `Set`.

## unique (Set)

        unique::Set : (\Function : (
            returns : ::Set,
            matches : (\Tuple:{::Set}),
            implements : folder::'',
            evaluates : (args:.\0),
        )),

The function `unique::Set` simply results in its `0` argument.  This
function implements the `Homogeneous` virtual function `unique` for the
composing type `Set`.

## subset_of (Set)

        subset_of::Set : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Set, ::Set}),
            implements : folder::'',
            evaluates : (args:.\0:>.\members subset_of args:.\1:>.\members),
        )),

The function `subset_of::Set` results in `0bTRUE` iff the set of members of
its `0` argument is a subset of the set of members of its `1` argument;
otherwise it results in `0bFALSE`.  This function implements the
`Homogeneous` virtual function `subset_of` aka `⊆` for the composing
type `Set`.

## same_members (Set)

        same_members::Set : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Set, ::Set}),
            implements : folder::'',
            is_commutative : 0bTRUE,
            evaluates : (args:.\0 = args:.\1),
        )),

The function `same_members::Set` results in `0bTRUE` iff its 2 arguments
`0` and `1` are exactly the same `Set` value, and `0bFALSE` otherwise;
its behaviour is identical to that of the function `same` when given the
same arguments.  This function implements the `Homogeneous` virtual
function `same_members` for the composing type `Set`.

## overlaps_members (Set)

        overlaps_members::Set : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Set, ::Set}),
            implements : folder::'',
            is_commutative : 0bTRUE,
            evaluates : (args:.\0:>.\members overlaps_members args:.\1:>.\members),
        )),

The function `overlaps_members::Set` results in `0bTRUE` iff, given
*X* as the set of members of its argument `0` and *Y* as the
set of members of its argument `1`, there exists at least 1 member
that both *X* and *Y* have, and there also exists at least 1 other member
each of *X* and *Y* that the other doesn't have; otherwise it results in
`0bFALSE`.  This function implements the `Homogeneous` virtual function
`overlaps_members` for the composing type `Set`.

## disjoint_members (Set)

        disjoint_members::Set : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Set, ::Set}),
            implements : folder::'',
            is_commutative : 0bTRUE,
            evaluates : (args:.\0:>.\members disjoint_members args:.\1:>.\members),
        )),

The function `disjoint_members::Set` results in `0bTRUE` iff the
set of members of its `0` argument has no member values in common
with the set of members of its `1` argument; otherwise it results in
`0bFALSE`.  This function implements the `Homogeneous` virtual function
`disjoint_members` for the composing type `Set`.

## any (Set)

        any::Set : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Set, ::Signature}),
            implements : folder::'',
            evaluates : (args:.\0:>.\members any args:.\1),
        )),

*TODO.*

## insert_n (Set)

        insert_n::Set : (\Function : (
            returns : ::Set,
            matches : (\Tuple:{::Set, ::Any, ::Integer_NN}),
            implements : folder::'',
            evaluates : (if args:.\0 has args:.\1 or args:.\2 = 0 then args:.\0
                else (\Set : (members : insert_n::(\Tuple:{args:.\0:>.\members, args:.\1, 1}),))),
        )),

The function `insert_n::Set` results in the `Set` value that has all of
the members of the function's `0` argument; but, if the `2` argument is
nonzero then the result has a member equal to the `1` argument, whether or
not `0` had it.  This function implements the `Unionable` virtual
function `insert_n` for the composing type `Set`.

## remove_n (Set)

        remove_n::Set : (\Function : (
            returns : ::Set,
            matches : (\Tuple:{::Set, ::Any, ::Integer_NN}),
            implements : folder::'',
            evaluates : ((\Set : (members : remove_n::(\Tuple:{args:.\0:>.\members, args:.\1, args:.\2}),))),
        )),

The function `remove_n::Set` results in the `Set` value that has all of
the members of the function's `0` argument; but, if the `2` argument is
nonzero and `0` had a member equal to the `1` argument, the result lacks
that member.  This function implements the `Unionable` virtual function
`remove_n` for the composing type `Set`.

## member_plus (Set)

        member_plus::Set : (\Function : (
            returns : ::Set,
            matches : (\Tuple:{::Set, ::Set}),
            implements : folder::'',
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            is_idempotent : 0bTRUE,
            identity : (\Set:[]),
            evaluates : (args:.\0 union args:.\1),
        )),

The function `member_plus::Set` results in the *set union* of its 2
arguments `0` and `1`; it behaves identically to `union` aka `∪` when
given the same arguments.  This function implements the `Unionable`
virtual function `member_plus` aka `⊎` for the composing type `Set`.

## except (Set)

        except::Set : (\Function : (
            returns : ::Set,
            matches : (\Tuple:{::Set, ::Set}),
            implements : folder::'',
            right_identity : (\Set:[]),
            evaluates : ((\Set : (\Tuple:{members : args:.\0:>.\members except args:.\1:>.\members}))),
        )),

The function `except::Set` results in the *set difference* between
its 2 arguments `0` (*minuend*) and `1` (*subtrahend*).  The result is
the `Set` value that has all of the members of the function's `0`
argument minus all of the matching members of its `1` argument.  This
function implements the `Unionable` virtual function `except` aka `∖`
for the composing type `Set`.

## intersect (Set)

        intersect::Set : (\Function : (
            returns : ::Set,
            matches : (\Tuple:{::Set, ::Set}),
            implements : folder::'',
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            is_idempotent : 0bTRUE,
            evaluates : ((\Set : (\Tuple:{members : args:.\0:>.\members intersect args:.\1:>.\members}))),
        )),

The function `intersect::Set` results in the *set intersection* of
its 2 arguments `0` and `1`.  The result is the `Set` value that has all
of the members of the function's `0` argument that match their own members
of its `1` argument.  This function implements the `Unionable` virtual
function `intersect` aka `∩` for the composing type `Set`.

## union (Set)

        union::Set : (\Function : (
            returns : ::Set,
            matches : (\Tuple:{::Set, ::Set}),
            implements : folder::'',
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            is_idempotent : 0bTRUE,
            identity : (\Set:[]),
            evaluates : ((\Set : (\Tuple:{members : args:.\0:>.\members union args:.\1:>.\members}))),
        )),

The function `union::Set` results in the *set union* of its 2
arguments `0` and `1`.  The result is the `Set` value that has all of
the members of the function's `0` argument plus all of the nonmatching
members of its `1` argument.  This function implements the `Unionable`
virtual function `union` aka `∪` for the composing type `Set`.

## exclusive (Set)

        exclusive::Set : (\Function : (
            returns : ::Set,
            matches : (\Tuple:{::Set, ::Set}),
            implements : folder::'',
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            identity : (\Set:[]),
            evaluates : ((\Set : (\Tuple:{members : args:.\0:>.\members exclusive args:.\1:>.\members}))),
        )),

The function `exclusive::Set` results in the *set symmetric
difference* of its 2 arguments `0` and `1`.  The result is the `Set`
value that has all of the members of each of the function's `0` and `1`
arguments that do not have matching members of their counterpart argument.
This function implements the `Unionable` virtual function `exclusive`
aka `symm_diff` aka `∆` for the composing type `Set`.

## nest (Set)

        nest::Set : (\Function : (
            returns : ::Set,
            matches : (\Tuple:{::Set}),
            implements : folder::'',
            accepts : (...),
            evaluates : ((\Set : (\Tuple:{members : nest args:.\0:>.\members}))),
        )),

*TODO.*

## unnest (Set)

        unnest::Set : (\Function : (
            returns : ::Set,
            matches : (\Tuple:{::Set}),
            implements : folder::'',
            accepts : (...),
            evaluates : ((\Set : (\Tuple:{members : unnest args:.\0:>.\members}))),
        )),

*TODO.*

## where (Set)

        where::Set : (\Function : (
            returns : ::Set,
            matches : (\Tuple:{::Set, ::Signature}),
            implements : folder::'',
            evaluates : ((\Set : (\Tuple:{members : args:.\0:>.\members where args:.\1}))),
        )),

*TODO.*

## map (Set)

        map::Set : (\Function : (
            returns : ::Set,
            matches : (\Tuple:{::Set, ::Function_Call_But_0}),
            implements : folder::'',
            evaluates : ((\Set : (\Tuple:{members : args:.\0:>.\members map args:.\1}))),
        )),

*TODO.*

## reduce (Set)

        reduce::Set : (\Function : (
            returns : ::Any,
            matches : (\Tuple:{::Set, ::Function_Call_But_0_1}),
            implements : folder::'',
            evaluates : ((\Set : (\Tuple:{members : args:.\0:>.\members reduce args:.\1}))),
        )),

*TODO.*

## to_Set (Set)

        to_Set::Set : (\Function : (
            returns : ::Set,
            matches : (\Tuple:{::Set}),
            implements : folder::'',
            evaluates : (args:.\0),
        )),

The function `to_Set::Set` simply results in its `0` argument.  This
function implements the `Discrete` virtual function `to_Set` aka
`?|` for the composing type `Set`.

## to_Bag (Set)

        to_Bag::Set : (\Function : (
            returns : ::Bag,
            matches : (\Tuple:{::Set}),
            implements : folder::'',
            evaluates : (args:.\0:>.\members),
        )),

The function `to_Bag::Set` results in the `Bag` value that has all of the
members of the function's `0` argument.  This function implements the
`Discrete` virtual function `to_Bag` aka `+|` for the composing type
`Set`.

## count (Set)

        count::Set : (\Function : (
            returns : ::Integer_NN,
            matches : (\Tuple:{::Set}),
            implements : folder::'',
            evaluates : (count args:.\0:>.\members),
        )),

The function `count::Set` results in the integral count of the members
of its `0` argument.  This function implements the `Discrete` virtual
function `count` aka `cardinality` aka `#` for the composing type `Set`.

## unique_count (Set)

        unique_count::Set : (\Function : (
            returns : ::Integer_NN,
            matches : (\Tuple:{::Set}),
            implements : folder::'',
            evaluates : (count args:.\0),
        )),

The function `unique_count::Set` results in the integral count of the
members of its `0` argument; its behaviour is identical to `count` given
the same argument.  This function implements the `Discrete` virtual
function `unique_count` for the composing type `Set`.

## order_using (Set)

        order_using::Set : (\Function : (
            returns : ::Array,
            matches : (\Tuple:{::Set, ::Function_Call_But_0_1}),
            implements : folder::'',
            evaluates : (args:.\0:>.\members order_using args:.\1),
        )),

The function `order_using::Set` results in the `Array` value that represents
the same set of members as its `0` argument but that the members are
arranged into a sequence in accordance with a total order defined by the
function given in its `1` argument.  This function implements the
`Discrete` virtual function `order_using` for the composing type `Set`.

# BAG DATA TYPES

## Bag

        Bag : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Discrete]),
            evaluates : \foundation::Bag(\Tuple:{}),
            default : (\Bag:[]),
        )),

The selection type definer `Bag` represents the infinite Muldis Data Language Foundation
type `foundation::Bag`.  A `Bag` value is a general purpose arbitrarily-large
unordered collection of any other, *member* values, which explicitly does
not represent any kind of thing in particular, and is simply the sum of its
members.  A `Bag` in the general case may have multiple members that are
the same value.  The default value of `Bag` is `(\Bag:[])`, the only
zero-member `Bag` value.  Other programming languages may name their
corresponding types *Multiset*.

## Bag_C0 +∅

        Bag_C0 : (\Function : (
            is_type_definer : 0bTRUE,
            constant : (\Bag:[]),
        )),

        Unicode_Aliases::'+∅' : (\Alias : (\Tuple:{ of : ::Bag_C0 })),

The singleton type definer `Bag_C0` aka `+∅` represents the only zero-member
`Bag` value, `(\Bag:[])`.

## not_empty (Bag)

        not_empty::Bag : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Bag}),
            implements : folder::'',
            evaluates : (args:.\0 != (\Bag:[])),
        )),

The function `not_empty::Bag` results in `0bTRUE` iff its `0` argument
has any members, and in `0bFALSE` iff it has no members.  This function
implements the `Homogeneous` virtual function `not_empty`
for the composing type `Bag`.

## empty (Bag)

        empty::Bag : (\Function : (
            returns : ::Bag,
            matches : (\Tuple:{::Bag}),
            implements : folder::'',
            evaluates : ((\Bag:[])),
        )),

The function `empty::Bag` results in the only zero-member `Bag`
value.  This function implements the `Homogeneous` virtual function `empty`
aka `∅` for the composing type `Bag`.

## singular (Bag)

        singular::Bag : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Bag}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Bag_singular(\Tuple:{})),
        )),

The function `singular::Bag` results in `0bTRUE` iff its `0` argument has
exactly 1 distinct member value, and `0bFALSE` otherwise.  This function
implements the `Homogeneous` virtual function `singular` for the
composing type `Bag`.

## only_member (Bag)

        only_member::Bag : (\Function : (
            returns : ::Any,
            matches : (\Tuple:{::Bag}),
            implements : folder::'',
            accepts : (singular args:.\0),
            evaluates : (evaluates args --> \foundation::Bag_only_member(\Tuple:{})),
        )),

The function `only_member::Bag` results in its `0` argument's only
distinct member value.  This function will fail if the argument doesn't
have exactly 1 distinct member value.  This function implements the
`Homogeneous` virtual function `only_member` for the composing type
`Bag`.

## has_n (Bag)

        has_n::Bag : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Bag, ::Any, ::Integer_NN}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Bag_has_n(\Tuple:{})),
        )),

The function `has_n::Bag` results in `0bTRUE` iff its `0` argument has at
least N members such that each is equal to its `1` argument, where N is
defined by its `2` argument; otherwise it results in `0bFALSE`.  This
function implements the `Homogeneous` virtual function `has_n` for the
composing type `Bag`.

## multiplicity (Bag)

        multiplicity::Bag : (\Function : (
            returns : ::Integer_NN,
            matches : (\Tuple:{::Bag, ::Any}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Bag_multiplicity(\Tuple:{})),
        )),

The function `multiplicity::Bag` results in the integral count
of members of its `0` argument such that each member value is equal to its
`1` argument.  This function implements the `Homogeneous` virtual
function `multiplicity` for the composing type `Bag`.

## all_unique (Bag)

        all_unique::Bag : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Bag}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Bag_all_unique(\Tuple:{})),
        )),

The function `all_unique::Bag` results in `0bTRUE` iff its `0` argument
has no 2 members that are the same value, and `0bFALSE` otherwise.  This
function implements the `Homogeneous` virtual function `all_unique` for
the composing type `Bag`.

## unique (Bag)

        unique::Bag : (\Function : (
            returns : ::Bag,
            matches : (\Tuple:{::Bag}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Bag_unique(\Tuple:{})),
        )),

The function `unique::Bag` results in the `Bag` value that has, for every
distinct member value *V* of the function's `0` argument, exactly 1
member whose value is equal to *V*.  This function implements the
`Homogeneous` virtual function `unique` for the composing type `Bag`.

## subset_of (Bag)

        subset_of::Bag : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Bag, ::Bag}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Bag_subset_of(\Tuple:{})),
        )),

The function `subset_of::Bag` results in `0bTRUE` iff the multiset of
members of its `0` argument is a subset of the multiset of members of its
`1` argument; otherwise it results in `0bFALSE`.  This function implements
the `Homogeneous` virtual function `subset_of` aka `⊆` for the composing
type `Bag`.

## same_members (Bag)

        same_members::Bag : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Bag, ::Bag}),
            implements : folder::'',
            is_commutative : 0bTRUE,
            evaluates : (args:.\0 = args:.\1),
        )),

The function `same_members::Bag` results in `0bTRUE` iff its 2 arguments
`0` and `1` are exactly the same `Bag` value, and `0bFALSE` otherwise;
its behaviour is identical to that of the function `same` when given the
same arguments.  This function implements the `Homogeneous` virtual
function `same_members` for the composing type `Bag`.

## overlaps_members (Bag)

        overlaps_members::Bag : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Bag, ::Bag}),
            implements : folder::'',
            is_commutative : 0bTRUE,
            evaluates : (evaluates args --> \foundation::Bag_overlaps_members(\Tuple:{})),
        )),

The function `overlaps_members::Bag` results in `0bTRUE` iff, given
*X* as the multiset of members of its argument `0` and *Y* as the
multiset of members of its argument `1`, there exists at least 1 member
that both *X* and *Y* have, and there also exists at least 1 other member
each of *X* and *Y* that the other doesn't have; otherwise it results in
`0bFALSE`.  This function implements the `Homogeneous` virtual function
`overlaps_members` for the composing type `Bag`.

## disjoint_members (Bag)

        disjoint_members::Bag : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Bag, ::Bag}),
            implements : folder::'',
            is_commutative : 0bTRUE,
            evaluates : (evaluates args --> \foundation::Bag_disjoint_members(\Tuple:{})),
        )),

The function `disjoint_members::Bag` results in `0bTRUE` iff the
multiset of members of its `0` argument has no member values in common
with the multiset of members of its `1` argument; otherwise it results in
`0bFALSE`.  This function implements the `Homogeneous` virtual function
`disjoint_members` for the composing type `Bag`.

## any (Bag)

        any::Bag : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Bag, ::Signature}),
            implements : folder::'',
            evaluates : (foundation::Bag_any(args:.\0, Signature_to_Function_Call_But_0::(args:.\1))),
        )),

*TODO.*

## insert_n (Bag)

        insert_n::Bag : (\Function : (
            returns : ::Bag,
            matches : (\Tuple:{::Bag, ::Any, ::Integer_NN}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Bag_insert_n(\Tuple:{})),
        )),

The function `insert_n::Bag` results in the `Bag` value that has all of
the members of the function's `0` argument plus N additional members that
are each equal to its `1` argument, where N is defined by its `2`
argument.  This function implements the `Unionable` virtual function
`insert_n` for the composing type `Bag`.

## remove_n (Bag)

        remove_n::Bag : (\Function : (
            returns : ::Bag,
            matches : (\Tuple:{::Bag, ::Any, ::Integer_NN}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Bag_remove_n(\Tuple:{})),
        )),

The function `remove_n::Bag` results in the `Bag` value that has all of
the members of the function's `0` argument minus N existing members that
are each equal to its `1` argument, where N is defined as the lesser of
its `2` argument and the count of members of `0` equal to the `1`
argument.  This function implements the `Unionable` virtual function
`remove_n` for the composing type `Bag`.

## member_plus (Bag)

        member_plus::Bag : (\Function : (
            returns : ::Bag,
            matches : (\Tuple:{::Bag, ::Bag}),
            implements : folder::'',
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            identity : (\Bag:[0:0]),
            evaluates : (evaluates args --> \foundation::Bag_member_plus(\Tuple:{})),
        )),

The function `member_plus::Bag` results in the *multiset sum* of its 2
arguments `0` and `1`.  The result is the `Bag` value that has all of
the members of the function's `0` argument plus all of the members of its
`1` argument.  This function implements the `Unionable` virtual
function `member_plus` aka `⊎` for the composing type `Bag`.

## except (Bag)

        except::Bag : (\Function : (
            returns : ::Bag,
            matches : (\Tuple:{::Bag, ::Bag}),
            implements : folder::'',
            right_identity : (\Bag:[]),
            evaluates : (evaluates args --> \foundation::Bag_except(\Tuple:{})),
        )),

The function `except::Bag` results in the *multiset difference* between
its 2 arguments `0` (*minuend*) and `1` (*subtrahend*).  The result is
the `Bag` value that has all of the members of the function's `0`
argument minus all of the matching members of its `1` argument.  This
function implements the `Unionable` virtual function `except` aka `∖`
for the composing type `Bag`.

## intersect (Bag)

        intersect::Bag : (\Function : (
            returns : ::Bag,
            matches : (\Tuple:{::Bag, ::Bag}),
            implements : folder::'',
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            is_idempotent : 0bTRUE,
            evaluates : (evaluates args --> \foundation::Bag_intersect(\Tuple:{})),
        )),

The function `intersect::Bag` results in the *multiset intersection* of
its 2 arguments `0` and `1`.  The result is the `Bag` value that has all
of the members of the function's `0` argument that match their own members
of its `1` argument.  This function implements the `Unionable` virtual
function `intersect` aka `∩` for the composing type `Bag`.

## union (Bag)

        union::Bag : (\Function : (
            returns : ::Bag,
            matches : (\Tuple:{::Bag, ::Bag}),
            implements : folder::'',
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            is_idempotent : 0bTRUE,
            identity : (\Bag:[]),
            evaluates : (evaluates args --> \foundation::Bag_union(\Tuple:{})),
        )),

The function `union::Bag` results in the *multiset union* of its 2
arguments `0` and `1`.  The result is the `Bag` value that has all of
the members of the function's `0` argument plus all of the nonmatching
members of its `1` argument.  This function implements the `Unionable`
virtual function `union` aka `∪` for the composing type `Bag`.

## exclusive (Bag)

        exclusive::Bag : (\Function : (
            returns : ::Bag,
            matches : (\Tuple:{::Bag, ::Bag}),
            implements : folder::'',
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            identity : (\Bag:[]),
            evaluates : (evaluates args --> \foundation::Bag_exclusive(\Tuple:{})),
        )),

The function `exclusive::Bag` results in the *multiset symmetric
difference* of its 2 arguments `0` and `1`.  The result is the `Bag`
value that has all of the members of each of the function's `0` and `1`
arguments that do not have matching members of their counterpart argument.
This function implements the `Unionable` virtual function `exclusive`
aka `symm_diff` aka `∆` for the composing type `Bag`.

## nest (Bag)

        nest::Bag : (\Function : (
            returns : ::Bag,
            matches : (\Tuple:{::Bag}),
            implements : folder::'',
            accepts : (...),
            evaluates : (evaluates args --> \foundation::Bag_nest(\Tuple:{})),
        )),

*TODO.*

## unnest (Bag)

        unnest::Bag : (\Function : (
            returns : ::Bag,
            matches : (\Tuple:{::Bag}),
            implements : folder::'',
            accepts : (...),
            evaluates : (evaluates args --> \foundation::Bag_unnest(\Tuple:{})),
        )),

*TODO.*

## where (Bag)

        where::Bag : (\Function : (
            returns : ::Bag,
            matches : (\Tuple:{::Bag, ::Signature}),
            implements : folder::'',
            evaluates : (foundation::Bag_where(args:.\0, Signature_to_Function_Call_But_0::(args:.\1))),
        )),

*TODO.*

## map (Bag)

        map::Bag : (\Function : (
            returns : ::Bag,
            matches : (\Tuple:{::Bag, ::Function_Call_But_0}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Bag_map(\Tuple:{})),
        )),

*TODO.*

## reduce (Bag)

        reduce::Bag : (\Function : (
            returns : ::Any,
            matches : (\Tuple:{::Bag, ::Function_Call_But_0_1}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Bag_reduce(\Tuple:{})),
        )),

*TODO.*

## to_Set (Bag)

        to_Set::Bag : (\Function : (
            returns : ::Set,
            matches : (\Tuple:{::Bag}),
            implements : folder::'',
            evaluates : ((\Set : (\Tuple:{members : unique args:.\0}))),
        )),

The function `to_Set::Bag` results in the `Set` value that has, for every
distinct member value *V* of the function's `0` argument, exactly 1
member whose value is equal to *V*.  This function implements the
`Discrete` virtual function `to_Set` aka `?|` for the composing type
`Bag`.

## to_Bag (Bag)

        to_Bag::Bag : (\Function : (
            returns : ::Bag,
            matches : (\Tuple:{::Bag}),
            implements : folder::'',
            evaluates : (args:.\0),
        )),

The function `to_Bag::Bag` simply results in its `0` argument.  This
function implements the `Discrete` virtual function `to_Bag` aka
`+|` for the composing type `Bag`.

## count (Bag)

        count::Bag : (\Function : (
            returns : ::Integer_NN,
            matches : (\Tuple:{::Bag}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Bag_count(\Tuple:{})),
        )),

The function `count::Bag` results in the integral count of the members
of its `0` argument.  This function implements the `Discrete` virtual
function `count` aka `cardinality` aka `#` for the composing type `Bag`.

## unique_count (Bag)

        unique_count::Bag : (\Function : (
            returns : ::Integer_NN,
            matches : (\Tuple:{::Bag}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Bag_unique_count(\Tuple:{})),
        )),

The function `unique_count::Bag` results in the integral count of the
distinct member values of its `0` argument.  This function implements the
`Discrete` virtual function `unique_count` for the composing type `Bag`.

## order_using (Bag)

        order_using::Bag : (\Function : (
            returns : ::Array,
            matches : (\Tuple:{::Bag, ::Function_Call_But_0_1}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Bag_order_using(\Tuple:{})),
        )),

The function `order_using::Bag` results in the `Array` value that represents
the same multiset of members as its `0` argument but that the members are
arranged into a sequence in accordance with a total order defined by the
function given in its `1` argument.  This function implements the
`Discrete` virtual function `order_using` for the composing type `Bag`.

# ATTRIBUTIVE DATA TYPES

## Attributive

        Attributive : (\Function : (\Tuple:{
            is_type_definer : 0bTRUE,
            is_generalization : 0bTRUE,
        })),

The interface type definer `Attributive` is semifinite.  An `Attributive` value
is a *collective* value such that every one of its component *attributes*
is conceptually of its own data type or should be interpreted logically in
a distinct way from its fellow attributes.  Idiomatically an `Attributive`
is a generic collection which does not as a whole represent any kind of
thing in particular, such as a text or a graphic, and is simply the sum of
its *attributes*; however some types which do represent such a particular
kind of thing may choose to compose `Attributive` because it makes sense
to provide its operators.  The default value of `Attributive` is the
`Tuple` value with zero attributes, `(\Tuple:{})`.

An `Attributive` value either is a `Tuple` or is isomorphic to a `Tuple`
or is isomorphic to a `Homogeneous` collection each of whose *members* is
a `Tuple`.  An `Attributive` value is always *discrete* in its
*attributive* dimension such that all of its attributes can be enumerated
as individuals and counted.  However, an `Attributive` value is not
necessarily *discrete* in its *homogeneous* dimension, depending on the
specific collection type in question.  If an `Attributive` value is also
`Discrete`, then it is *discrete* in both dimensions.

Every attribute of an `Attributive` value has a distinct *attribute name*
by which it can be looked up.  An `Attributive` value has a *heading*
which is a set of distinct attribute names; corresponding to this, an
`Attributive` value has a *body* which has the zero or more other values
that can be looked up using the attribute names.  Each attribute then is
conceptually a name-asset pair.  An *attribute name* is characterized by
an arbitrarily-long sequence of Unicode 12.1 standard *character
code points* but it is not a `Text` value; every distinct *attribute name*
is represented canonically in the type system by a distinct
`Attr_Name` value.  More precisely, an *attribute name* is an unqualified
program identifier and forms the basis for Muldis Data Language identifiers.

If an `Attributive` value is also `Structural`, it has exactly 1 member,
meaning the value is or is isomorphic to a `Tuple`, meaning each attribute
name has exactly 1 corresponding attribute asset; otherwise, that may not
be the case.  If an `Attributive` value is also `Relational`, it
potentially has any number of members, zero or more, meaning the value is
isomorphic to a `Homogeneous` collection each of whose *members* is a
`Tuple`; otherwise, that may not be the case.

`Attributive` is composed, directly or indirectly, by: `Structural`,
`Tuple`, `Relational`, `Orderelation`, `Relation`, `Multirelation`.

## has_any_attrs ?$

        has_any_attrs::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Boolean,
            matches : (\Tuple:{::Attributive}),
        )),

        '?$' : (\Alias : (\Tuple:{ of : ::has_any_attrs })),

The virtual function `has_any_attrs` aka `?$` results in `0bTRUE` iff its
`0` argument has any attributes, and in `0bFALSE` iff it has no attributes.

## is_nullary !?$

        is_nullary : (\Function : (\Tuple:{
            negates : ::has_any_attrs,
        })),

        '!?$' : (\Alias : (\Tuple:{ of : ::is_nullary })),

The function `is_nullary` aka `!?$` results in `0bTRUE` iff its `0`
argument has no attributes, and in `0bFALSE` iff it has any attributes.

## nullary

        nullary::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Attributive,
            matches : (\Tuple:{::Attributive}),
        )),

The virtual function `nullary` results in the value of its `0` argument's
collection type that has zero attributes.  For `Structural` types like
`Tuple`, this is a constant value, but for types like `Multirelation`, there
is a distinct result for each *cardinality*; for types like `Relation`
there are exactly 2 possible result values.

## is_unary

        is_unary::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Boolean,
            matches : (\Tuple:{::Attributive}),
        )),

The virtual function `is_unary` results in `0bTRUE` iff its `0` argument
has exactly 1 attribute, and `0bFALSE` otherwise.

## degree #$

        degree::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Integer_NN,
            matches : (\Tuple:{::Attributive}),
        )),

        '#$' : (\Alias : (\Tuple:{ of : ::degree })),

The virtual function `degree` aka `#$` results in the integral count of
the attributes of its `0` argument.

## heading $

        heading::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Heading,
            matches : (\Tuple:{::Attributive}),
        )),

        '$' : (\Alias : (\Tuple:{ of : ::heading })),

The virtual function `heading` aka `$` results in the
relational *heading* of its `0` argument, that is its set of distinct
attribute names.  The form that this takes is a `Tuple` having just the
same attribute names where every one of its assets is the value `0bTRUE`.
The purpose of `heading` is to canonicalize `Attributive` values such
that their headings can be reasoned about in isolation from their bodies.

## subheading_of ⊆$

        subheading_of : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Attributive, ::Attributive}),
            evaluates : (foundation::Tuple_subheading_of(\Tuple:{$args:.\0, $args:.\1})),
        )),

        Unicode_Aliases::'⊆$' : (\Alias : (\Tuple:{ of : ::subheading_of })),

The function `subheading_of` aka `⊆$` results in `0bTRUE` iff the heading
of its `0` argument is a subset of the heading of its `1` argument;
otherwise it results in `0bFALSE`.

## superheading_of has_subheading $? ⊇$

        superheading_of : (\Function : (\Tuple:{
            commutes : ::subheading_of,
        })),

        has_subheading : (\Alias : (\Tuple:{ of : ::superheading_of })),
        '$?'           : (\Alias : (\Tuple:{ of : ::superheading_of })),

        Unicode_Aliases::'⊇$' : (\Alias : (\Tuple:{ of : ::superheading_of })),

The function `superheading_of` aka `has_subheading` aka `$?` aka `⊇$`
results in `0bTRUE` iff the heading of its `0` argument is a superset of
the heading of its `1` argument; otherwise it results in `0bFALSE`.  Note
that using this function with a `Heading` as its `1` argument is the
idiomatic way to test if an `Attributive` has all of a specific set of
attribute names; whereas the `.?` function is idiomatic for testing for
exactly 1 name.

## same_heading =$

        same_heading : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Attributive, ::Attributive}),
            is_commutative : 0bTRUE,
            evaluates : ($args:.\0 = $args:.\1),
        )),

        '=$' : (\Alias : (\Tuple:{ of : ::same_heading })),

The function `same_heading` aka `=$` results in `0bTRUE` iff the heading
of its `0` argument is the same as the heading of its `1` argument;
otherwise it results in `0bFALSE`.

## proper_subheading_or_superheading

        proper_subheading_or_superheading : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Attributive, ::Attributive}),
            is_commutative : 0bTRUE,
            evaluates : ($args:.\0 != $args:.\1 and (args:.\0 subheading_or_superheading args:.\1)),
        )),

The function `proper_subheading_or_superheading` results in `0bTRUE` iff
the heading of one of its 2 arguments `0` and `1` is a proper subset of
the heading of its other argument; otherwise it results in `0bFALSE`.

## subheading_or_superheading

        subheading_or_superheading : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Attributive, ::Attributive}),
            is_commutative : 0bTRUE,
            evaluates : ((args:.\0 subheading_of args:.\1) or (args:.\0 superheading_of args:.\1)),
        )),

The function `subheading_or_superheading` results in `0bTRUE` iff the
heading of one of its 2 arguments `0` and `1` is a subset of the heading
of its other argument; otherwise it results in `0bFALSE`.

## overlaps_heading

        overlaps_heading : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Attributive, ::Attributive}),
            is_commutative : 0bTRUE,
            evaluates : (foundation::Tuple_overlaps_heading(\Tuple:{$args:.\0, $args:.\1})),
        )),

The function `overlaps_heading` results in `0bTRUE` iff, given *X* as the
heading of its argument `0` and *Y* as the heading of its argument `1`,
there exists at least 1 attribute name that both *X* and *Y* have, and
there also exists at least 1 other attribute name each of *X* and *Y*
that the other doesn't have; otherwise it results in `0bFALSE`.

## disjoint_heading

        disjoint_heading : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Attributive, ::Attributive}),
            is_commutative : 0bTRUE,
            evaluates : (foundation::Tuple_disjoint_heading(\Tuple:{$args:.\0, $args:.\1})),
        )),

The function `disjoint_heading` results in `0bTRUE` iff the heading of its
`0` argument has no attribute names in common with the heading of its `1`
argument; otherwise it results in `0bFALSE`.

## except_heading ∖$

        except_heading : (\Function : (
            returns : ::Heading,
            matches : (\Tuple:{::Attributive, ::Attributive}),
            evaluates : (foundation::Tuple_except_heading(\Tuple:{$args:.\0, $args:.\1})),
        )),

        Unicode_Aliases::'∖$' : (\Alias : (\Tuple:{ of : ::except_heading })),

The function `except_heading` aka `∖$` results in the *set difference*
between the *headings* of its 2 arguments `0` (*minuend*) and `1`
(*subtrahend*).  The result is the `Heading` value that just has every
attribute name that exists in the heading of the function's `0` argument
but not in the heading of its `1` argument.

## intersect_heading ∩$

        intersect_heading : (\Function : (
            returns : ::Heading,
            matches : (\Tuple:{::Attributive, ::Attributive}),
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            is_idempotent : 0bTRUE,
            evaluates : (foundation::Tuple_intersect_heading(\Tuple:{$args:.\0, $args:.\1})),
        )),

        Unicode_Aliases::'∩$' : (\Alias : (\Tuple:{ of : ::intersect_heading })),

The function `intersect_heading` aka `∩$` results in the *set
intersection* of the *headings* of its 2 arguments `0` and `1`.  The
result is the `Heading` value that just has every attribute name that
exists in both of the headings of the function's `0` and `1` arguments.
This operation conceptually has a *two-sided identity element* value of a `Heading` with an
infinite number of attribute names.

## union_heading ∪$

        union_heading : (\Function : (
            returns : ::Heading,
            matches : (\Tuple:{::Attributive, ::Attributive}),
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            is_idempotent : 0bTRUE,
            identity : (\Tuple:{}),
            evaluates : (foundation::Tuple_union_heading(\Tuple:{$args:.\0, $args:.\1})),
        )),

        Unicode_Aliases::'∪$' : (\Alias : (\Tuple:{ of : ::union_heading })),

The function `union_heading` aka `∪$` results in the *set union* of the
*headings* of its 2 arguments `0` and `1`.  The result is the `Heading`
value that just has every attribute name that exists in either or both of
the headings of the function's `0` and `1` arguments.

## exclusive_heading symm_diff_heading ∆$

        exclusive : (\Function : (
            returns : ::Heading,
            matches : (\Tuple:{::Attributive, ::Attributive}),
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            identity : (\Tuple:{}),
            evaluates : (foundation::Tuple_exclusive_heading(\Tuple:{$args:.\0, $args:.\1})),
        )),

        symm_diff_heading : (\Alias : (\Tuple:{ of : ::exclusive_heading })),

        Unicode_Aliases::'∆$' : (\Alias : (\Tuple:{ of : ::exclusive_heading })),

The function `exclusive_heading` aka `symm_diff_heading` aka `∆$`
results in the *set symmetric difference* of the *headings* of its 2
arguments `0` and `1`.  The result is the `Heading` value that just has
every attribute name that exists in the heading of exactly one of the
function's `0` or `1` arguments.

## rename $:= ρ

        rename::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Attributive,
            matches : (\Tuple:{::Attributive, ::Renaming}),
            accepts : (...),
        )),

        '$:=' : (\Alias : (\Tuple:{ of : ::rename })),

        Unicode_Aliases::'ρ' : (\Alias : (\Tuple:{ of : ::rename })),

The virtual function `rename` aka `$:=` aka `ρ` results results in the
*relational rename* of its `0` argument in terms of its `1` argument.
The result is a value of the function's `0` argument's collection type
that has all of the attributes of the function's `0` argument but that,
for each attribute of the `0` argument whose attribute name matches a
*before* element of its `1` argument, the result's corresponding
attribute instead has an attribute name that matches the corresponding
*after* element of the `1` argument.  The *degree* and the
*cardinality* of the result are both equal to the degree and cardinality
of the `0` argument, respectively.  This function will fail if any
*before* element of the `1` argument does not match the name of an
attribute name of the `0` argument, or if any *after* element of the
former does match an attribute name of the latter that isn't being renamed.

*TODO: Revisit the spec_2011 docs of this operator after the Renaming type
is fully defined, for additional useful language for describing "rename".*

## renaming

        renaming : (\Function : (\Tuple:{
            commutes : ::rename,
        })),

The function `renaming` behaves identically to the function `rename` when
given the same arguments in swapped positions.

## can_project_matching %=?

        can_project_matching::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Boolean,
            matches : (\Tuple:{::Attributive, ::Structural}),
        )),

        '%=?' : (\Alias : (\Tuple:{ of : ::can_project_matching })),

The virtual function `can_project_matching` aka `%=?` results in `0bTRUE`
iff the heading of its `0` argument is a superset of the heading of its
`1` argument and every commonly-named attribute of the two arguments also
has the same attribute asset; otherwise it results in `0bFALSE`.  Note that
by definition, the identity `can_project_matching::(update::(\Tuple:{a,s}),s) = 0bTRUE`
aka `a %:= s %=? s = 0bTRUE` should hold for all valid `a` and `s`.

## on project %= π

        on::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Attributive,
            matches : (\Tuple:{::Attributive, ::Heading}),
            accepts : (args:.\0 $? args:.\1),
        )),

        project : (\Alias : (\Tuple:{ of : ::on })),
        '%='    : (\Alias : (\Tuple:{ of : ::on })),

        Unicode_Aliases::'π' : (\Alias : (\Tuple:{ of : ::on })),

The virtual function `on` aka `project` aka `%=` aka `π` results in the
*relational projection* of its `0` argument in terms of its `1`
argument.  The result is a value of the function's `0` argument's
collection type that has all of the attributes of the function's `0`
argument whose names match the names of attributes of its `1` argument.
The *degree* of the result is equal to the degree of the `1` argument,
and the *cardinality* of the result is either equal to or less than the
cardinality of the `0` argument; a lesser cardinality would be the result
of duplicate result member elimination for a *setty* type.  For every
member tuple or isomorphism *X* in the `0` argument, the result has a
member tuple or isomorphism *Y* that is equal to the result of projecting
*X* on all of the attribute names of the `1` argument.  This function
will fail if the *heading* of the `1` argument is not a subset of the
*heading* of the `0` argument.  Other programming languages may name
their corresponding operators *over* or *select*; it is also common to
use subscript/postcircumfix syntax.

## from

        from : (\Function : (\Tuple:{
            commutes : ::on,
        })),

The function `from` behaves identically to the function `on`
when given the same arguments in swapped positions.

## maybe_on %!

        maybe_on : (\Function : (
            returns : ::Attributive,
            matches : (\Tuple:{::Attributive, ::Heading}),
            evaluates : (args:.\0 on (args:.\0 intersect_heading args:.\1)),
        )),

        '%!' : (\Alias : (\Tuple:{ of : ::maybe_on })),

The function `maybe_on` aka `%!` behaves identically to `on`
when given the same arguments but that it simply ignores the existence of
attributes of its `1` argument whose names don't match attributes of its
`0` argument rather than failing.

## update %:=

        update::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Attributive,
            matches : (\Tuple:{::Attributive, ::Structural}),
            accepts : (args:.\0 $? args:.\1),
        )),

        '%:=' : (\Alias : (\Tuple:{ of : ::update })),

The virtual function `update` aka `%:=` results in the value of its `0`
argument's collection type that has all of the attributes of the function's
`0` argument but that, for each attribute of the `0` argument whose
attribute name *K* matches the name of an attribute of its `1` argument,
the result takes its corresponding attribute from the `1` argument rather
than from the `0` argument.  The *degree* of the result is equal to the
degree of the `0` argument, and the *cardinality* of the result is either
equal to or less than the cardinality of the `0` argument; a lesser
cardinality would be the result of duplicate result member elimination for
a *setty* type.  For every member tuple or isomorphism *X* in the `0`
argument, the result has a member tuple or isomorphism *Y* that is equal
to *X* but that, for each attribute name *K* of *X*, the asset of the
attribute named *K* of *Y* is equal to the asset of the attribute named
*K* of the `1` argument rather than its value from *X*.  This function
will fail if the *heading* of the `1` argument is not a subset of the
*heading* of the `0` argument.  Other programming languages may name
their corresponding operators *update ... set*; it is also common to use
subscript/postcircumfix syntax plus assignment syntax.

## extend %+

        extend::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Attributive,
            matches : (\Tuple:{::Attributive, ::Structural}),
            accepts : (args:.\0 disjoint_heading args:.\1),
        )),

        '%+' : (\Alias : (\Tuple:{ of : ::extend })),

The virtual function `extend` aka `%+` results in the *relational
extension* of its `0` argument in terms of its `1` argument.  The result
is a value of the function's `0` argument's collection type that has all
of the attributes of the function's `0` argument plus all of the
attributes of its `1` argument.  The *degree* of the result is equal to
the integral sum of the degrees of the 2 arguments, and the *cardinality*
of the result is equal to the cardinality of the `0` argument.  There is a
bijection between the `0` argument and the result with respect to their
*members*; for every tuple or isomorphism *X* in the `0` argument, the
result has a tuple or isomorphism *Y* that is equal to the result of
extending *X* with all of the attributes (names and assets) of the `1`
argument.  This function will fail if the *headings* of the 2 arguments
are not disjoint.  Other programming languages may name their corresponding
operators *join*.

*TODO.  There is no version of 'extend' that takes a routine; one can just
use the above version plus an eg-tuple selector. In the case of relation
extend, one can do the aforementioned within a 'map' routine, for the
routine version; they can use join/cross-product for the static version.
Also, this is analogous to set union (disjoint).
The Structural version is commutative and associative, but not Attributive in general.*

## but project_all_but %-

        but : (\Function : (
            returns : ::Attributive,
            matches : (\Tuple:{::Attributive, ::Heading}),
            accepts : (args:.\0 $? args:.\1),
            evaluates : (args:.\0 on (args:.\0 except_heading args:.\1)),
        )),

        project_all_but : (\Alias : (\Tuple:{ of : ::but })),
        '%-'            : (\Alias : (\Tuple:{ of : ::but })),

The function `but` aka `project_all_but` aka `%-` results in the
*relational projection* of its `0` argument in terms of its `1`
argument.  The result is a value of the function's `0` argument's
collection type that has all of the attributes of the function's `0`
argument whose names do not match the names of attributes of its `1`
argument.  The *degree* of the result is equal to the integral difference
of the degrees of the 2 arguments, and the *cardinality* of the result is
either equal to or less than the cardinality of the `0` argument; a lesser
cardinality would be the result of duplicate result member elimination for
a *setty* type.  For every member tuple or isomorphism *X* in the `0`
argument, the result has a member tuple or isomorphism *Y* that is equal
to the result of projecting *X* on all of its attribute names except for
those in common with the `1` argument.  This function will fail if the
*heading* of the `1` argument is not a subset of the *heading* of the
`0` argument.  Other programming languages may name their corresponding
operators *remove*.

## update_or_extend %=+

        update_or_extend : (\Function : (
            returns : ::Attributive,
            matches : (\Tuple:{::Attributive, ::Structural}),
            evaluates : (args:.\0 on (args:.\0 except_heading args:.\1) extend args:.\1),
        )),

        '%=+' : (\Alias : (\Tuple:{ of : ::update_or_extend })),

The function `update_or_extend` aka `%=+` is a hybrid of the 2
functions `update` and `extend`.  The result is a value of the function's
`0` argument's collection type that has attribute assets substituted with
those from the function's `1` argument where the attribute names match,
and the result has new attributes added from the `1` argument where the
latter's names don't match.

## maybe_but %?-

        maybe_but : (\Function : (
            returns : ::Attributive,
            matches : (\Tuple:{::Attributive, ::Heading}),
            evaluates : (args:.\0 but (args:.\0 intersect_heading args:.\1)),
        )),

        '%?-' : (\Alias : (\Tuple:{ of : ::maybe_but })),

The function `maybe_but` aka `%?-` behaves identically to `but`
when given the same arguments but that it simply ignores the existence of
attributes of its `1` argument whose names don't match attributes of its
`0` argument rather than failing.

# STRUCTURAL DATA TYPES

## Structural

        Structural : (\Function : (
            is_type_definer : 0bTRUE,
            is_generalization : 0bTRUE,
            composes : (\Set:[::Attributive, ::Accessible]),
            provides_default_for : (\Set:[::Attributive, ::Accessible]),
        )),

The interface type definer `Structural` is semifinite.  A `Structural` value is
an `Attributive` value that has exactly 1 member, meaning the value is or
is isomorphic to a `Tuple`, meaning each attribute name has exactly 1
corresponding attribute asset.  The default value of `Structural` is the
`Tuple` value with zero attributes, `(\Tuple:{})`.  `Structural` is composed by
`Tuple`.

## can_project_matching (Structural)

        can_project_matching::Structural : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Structural, ::Structural}),
            implements : folder::'',
            evaluates : (args:.\0 $? args:.\1 and_then guard args:.\0 %= $args:.\1 = args:.\1),
        )),

The function `can_project_matching::Structural` results in `0bTRUE` iff the
heading of its `0` argument is a superset of the heading of its `1`
argument and every commonly-named attribute of the two arguments also has
the same attribute asset; otherwise it results in `0bFALSE`.  Note that by
definition, the identity `can_project_matching::(update::(\Tuple:{a,s}),s) = 0bTRUE`
aka `a %:= s %=? s = 0bTRUE` should hold for all valid `a` and `s`.  This
function implements the `Attributive` virtual function
`can_project_matching` aka `%=?` for the composing type `Structural`.

## has_any_at (Structure)

        has_any_at::Structure : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Structure, ::Attr_Name}),
            implements : folder::'',
            evaluates : (args:.\0 $? args:.\1),
        )),

The function `has_any_at::Structure` results in `0bTRUE` iff its `0`
argument has an attribute whose attribute name is equal to its `1`
argument; otherwise it results in `0bFALSE`.  This function implements the
`Accessible` virtual function `has_any_at` aka `.?` for the composing
type `Structure`.

## has_mapping_at (Structural)

        has_mapping_at::Structural : (\Function : (
            returns : ::Boolean,
            matches : (Structural, (\Tuple:{Attr_Name, Any})),
            implements : folder::'',
            evaluates : (args:.\0 .? (args:.\1.\0) and_then guard args:.\0.(args:.\1.\0) = (args:.\1.\1)),
        )),

The function `has_mapping_at::Structural` results in `0bTRUE` iff its `0`
argument has an attribute whose name and asset are equal to the function's
`1` argument's `0` and `1` attribute assets, respectively; otherwise it
results in `0bFALSE`.  This function implements the `Accessible` virtual
function `has_mapping_at` aka `.:?` for the composing type `Structural`.

## mapping_at (Structural)

        mapping_at::Structural : (\Function : (
            returns : (\Tuple:{::Attr_Name, ::Any}),
            matches : (\Tuple:{::Structural, ::Attr_Name}),
            implements : folder::'',
            accepts : (args:.\0 .? args:.\1),
            evaluates : ((\Tuple:{args:.\1, args:.\0.args:.\1})),
        )),

The function `mapping_at::Structural` results in a binary `Tuple` whose
`0` attribute is the function's `1` argument and whose `1` attribute is
the attribute asset value of the function's `0` argument whose attribute
name is equal to its `1` argument.  This function will fail if the `0`
argument doesn't have such an attribute.  This function implements the
`Accessible` virtual function `mapping_at` aka `.:` for the composing
type `Structural`.

## maybe_at (Structural)

        maybe_at::Structural : (\Function : (
            returns : ::Any,
            matches : (\Tuple:{::Structural, ::Attr_Name}),
            implements : folder::'',
            evaluates : (if args:.\0 .? args:.\1 then guard args:.\0.args:.\1 else (::No_Such_Attr_Name : (\Tuple:{}))),
        )),

The function `maybe_at::Structural` results in the attribute asset value
of its `0` argument whose attribute name is equal to its `1` argument,
iff there is such an attribute; otherwise it results in `(::No_Such_Attr_Name : (\Tuple:{}))`.  This
function implements the `Accessible` virtual function `maybe_at` aka
`.!` for the composing type `Structural`.

## replace_at (Structure)

        replace_at::Structure : (\Function : (
            returns : ::Structure,
            matches : (Structure, (\Tuple:{Attr_Name, Any})),
            implements : folder::'',
            accepts : (args:.\0 .? (args:.\1.\0)),
            evaluates : (args:.\0 update D1::(args:.\1)),
        )),

The function `replace_at::Structure` results in the value of its `0`
argument's collection type that has all of the attributes of the function's
`0` argument but that, for the 1 attribute of the `0` argument whose
attribute name is equal to the function's `1` argument's `0` attribute
asset, the result's attribute instead has an asset equal to the `1`
argument's `1` attribute asset.  This function will fail if the `0`
argument doesn't have an attribute with that name.  This function
implements the `Accessible` virtual function `replace_at` aka `.:=` for
the composing type `Structure`.

## shiftless_insert_at (Structure)

        shiftless_insert_at::Structure : (\Function : (
            returns : ::Structure,
            matches : (Structure, (\Tuple:{Attr_Name, Any})),
            implements : folder::'',
            accepts : (not args:.\0 .? (args:.\1.\0)),
            evaluates : (args:.\0 extend D1::(args:.\1)),
        )),

The function `shiftless_insert_at::Structure` results in the value of its
`0` argument's collection type that has all of the attributes of the
function's `0` argument plus 1 additional attribute whose name and asset
are equal to the function's `1` argument's `0` and `1` attribute assets,
respectively.  This function will fail if the `0` argument already has an
attribute with that name.  This function implements the `Accessible`
virtual function `shiftless_insert_at` aka `.+` for the composing type
`Structure`.

## shiftless_remove_at (Structure)

        shiftless_remove_at::Structure : (\Function : (
            returns : ::Structure,
            matches : (\Tuple:{::Structure, ::Attr_Name}),
            implements : folder::'',
            accepts : (args:.\0 .? args:.\1),
            evaluates : (args:.\0 but args:.\1),
        )),

The function `shiftless_remove_at::Structure` results in the value of its
`0` argument's collection type that has all of the attributes of the
function's `0` argument minus 1 existing attribute whose name is equal to
its `1` argument.  This function will fail if the `0` argument doesn't
have such an attribute.  This function implements the `Accessible` virtual
function `shiftless_remove_at` aka `.-` for the composing type
`Structure`.

## replace_or_insert_at (Structural)

        replace_or_insert_at::Structural : (\Function : (
            returns : ::Structural,
            matches : (Structural, (\Tuple:{Attr_Name, Any})),
            implements : folder::'',
            evaluates : (args:.\0 update_or_extend D1::(args:.\1)),
        )),

The function `replace_or_insert_at::Structural` behaves identically in
turn to each of the functions `replace_at` and `shiftless_insert_at` when
given the same arguments, where the `0` argument does or doesn't,
respectively, have an attribute whose attribute name is equal to the `1`
argument's `0` attribute.  This function implements the `Accessible`
virtual function `replace_or_insert_at` aka `.=+` for the composing type
`Structural`.

## shiftless_maybe_remove_at (Structural)

        shiftless_maybe_remove_at::Structural : (\Function : (
            returns : ::Structural,
            matches : (\Tuple:{::Structural, ::Attr_Name}),
            implements : folder::'',
            evaluates : (args:.\0 maybe_but args:.\1),
        )),

The function `shiftless_maybe_remove_at::Structural` behaves identically
to `shiftless_remove_at` when given the same arguments but that it simply
results in its `0` argument when that has no attribute whose attribute
name matches its `1` argument, rather than fail.  This function implements
the `Accessible` virtual function `shiftless_maybe_remove_at` aka `.?-`
for the composing type `Structural`.

## to_Tuple %

        to_Tuple::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Tuple,
            matches : (\Tuple:{::Structural}),
        )),

        '%' : (\Alias : (\Tuple:{ of : ::to_Tuple })),

The virtual function `to_Tuple` aka `%` results in the `Tuple` value
that represents the same set of attributes as its `0` argument.  The
purpose of `to_Tuple` is to canonicalize `Structural` values so they can
be treated abstractly as sets of attributes with minimal effort.

# TUPLE DATA TYPES

## Tuple

        Tuple::'' : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Structural]),
            provides_default_for : (\Set:[::Structural]),
            evaluates : \foundation::Tuple(\Tuple:{}),
            default : (\Tuple:{}),
        )),

The selection type definer `Tuple` represents the infinite Muldis Data Language Foundation
type `foundation::Tuple`.  A `Tuple` value is a general purpose
arbitrarily-large unordered heterogeneous collection of named
*attributes*, such that no 2 attributes have the same *attribute name*,
which explicitly does not represent any kind of thing in particular, and is
simply the sum of its attributes.  An attribute is conceptually a
name-asset pair, the name being used to look up the attribute in a
`Tuple`.  An *attribute name* is an unqualified program identifier,
characterized by an arbitrarily-long sequence of Unicode 12.1 standard
*character code points* but it is not a
`Text` value; it forms the basis for Muldis Data Language identifiers.
In the general case each attribute of a tuple is of a distinct data type,
though multiple attributes often have the same type.  The set of attribute
names of a `Tuple` is called its *heading*, and the corresponding
attribute assets are called its *body*.  With respect to the relational
model of data, a *heading* represents a predicate, for which each
*attribute name* is a free variable, and a `Tuple` as a whole represents
a derived proposition, where the corresponding attribute asset values
substitute for the free variables; however, any actual predicate/etc is
defined by the context of a `Tuple` value and a `Tuple` in isolation
explicitly does not represent any proposition in particular.  The default
value of `Tuple` is `(\Tuple:{})`, the only zero-attribute `Tuple` value.  Other
programming languages may name their corresponding types *Capture* or
*Stash* or *record* or *struct* or *row* or *DataRow* or *Hash*.

## Tuple_D0

        Tuple_D0 : (\Function : (
            is_type_definer : 0bTRUE,
            constant : (\Tuple:{}),
        )),

The singleton type definer `Tuple_D0` represents the only zero-attribute
`Tuple` value.

## Tuple_D1

        Tuple_D1 : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[\Tuple::(\Tuple:{}), \is_unary::(\Tuple:{})]),
            default : (\Tuple:{0bFALSE}),
        )),

The selection type definer `Tuple_D1` represents the infinite type consisting
just of the `Tuple` values having exactly 1 attribute.  Its default value
has just the attribute with the name `0` and asset value of `0bFALSE`.

## D1

        D1 : (\Function : (
            returns : ::Tuple_D1,
            matches : (\Tuple:{::Attr_Name, ::Any}),
            evaluates : (evaluates args --> \foundation::Tuple_D1_select(\Tuple:{})),
        )),

The function `D1` results in the `Tuple_D1` value whose sole attribute's
name is is specified in its `0` argument and that attribute's value is
specified in its `1` argument.

## has_any_attrs (Tuple)

        has_any_attrs::Tuple : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Tuple}),
            implements : folder::'',
            evaluates : (args:.\0 != (\Tuple:{})),
        )),

The function `has_any_attrs::Tuple` results in `0bTRUE` iff its `0`
argument has any attributes, and in `0bFALSE` iff it has no attributes.
This function implements the `Attributive` virtual function
`has_any_attrs` aka `?$` for the composing type `Tuple`.

## nullary (Tuple)

        nullary::Tuple : (\Function : (
            returns : ::Tuple,
            matches : (\Tuple:{::Tuple}),
            implements : folder::'',
            evaluates : ((\Tuple:{})),
        )),

The function `nullary::Tuple` results in the only zero-attribute `Tuple`
value.  This function implements the `Attributive` virtual function
`nullary` for the composing type `Tuple`.

## is_unary (Tuple)

        is_unary::Tuple : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Tuple}),
            implements : folder::'',
            evaluates : (degree::(args:.\0) = 1),
        )),

The function `is_unary::Tuple` results in `0bTRUE` iff its `0` argument
has exactly 1 attribute, and `0bFALSE` otherwise.  This function implements
the `Attributive` virtual function `is_unary` for the composing type
`Tuple`.

## degree (Tuple)

        degree::Tuple : (\Function : (
            returns : ::Integer_NN,
            matches : (\Tuple:{::Tuple}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Tuple_degree(\Tuple:{})),
        )),

The function `degree::Tuple` results in the integral count of the
attributes of its `0` argument.  This function implements the
`Attributive` virtual function `degree` aka `#$` for the composing type
`Tuple`.

## heading (Tuple)

        heading::Tuple : (\Function : (
            returns : ::Heading,
            matches : (\Tuple:{::Tuple}),
            implements : folder::'',
            evaluates : (evaluates args --> \foundation::Tuple_heading(\Tuple:{})),
        )),

The function `heading::Tuple` results in the relational *heading* of its
`0` argument, that is its set of distinct attribute names.  This function
implements the `Attributive` virtual function `heading` aka `$` for the
composing type `Tuple`.

## rename (Tuple)

        rename::Tuple : (\Function : (
            returns : ::Tuple,
            matches : (\Tuple:{::Tuple, ::Renaming}),
            implements : folder::'',
            accepts : (...),
            evaluates : (evaluates args --> \foundation::Tuple_rename(\Tuple:{})),
        )),

The function `rename::Tuple` results results in the *relational rename*
of its `0` argument in terms of its `1` argument.  The result is a
`Tuple` value that has all of the attributes of the function's `0`
argument but that, for each attribute of the `0` argument whose attribute
name matches a *before* element of its `1` argument, the result's
corresponding attribute instead has an attribute name that matches the
corresponding *after* element of the `1` argument.  The *degree* of the
result is equal to the degree of the `0` argument.  This function will
fail if any *before* element of the `1` argument does not match the name
of an attribute name of the `0` argument, or if any *after* element of
the former does match an attribute name of the latter that isn't being
renamed.  This function implements the `Attributive` virtual function
`rename` aka `$:=` aka `ρ` for the composing type `Tuple`.

## on (Tuple)

        on::Tuple : (\Function : (
            returns : ::Tuple,
            matches : (\Tuple:{::Tuple, ::Heading}),
            implements : folder::'',
            accepts : (args:.\0 $? args:.\1),
            evaluates : (evaluates args --> \foundation::Tuple_on(\Tuple:{})),
        )),

The function `on::Tuple` results in the *relational projection* of its
`0` argument in terms of its `1` argument.  The result is a `Tuple`
value that has all of the attributes of the function's `0` argument whose
names match the names of attributes of its `1` argument. The *degree* of
the result is equal to the degree of the `1` argument.  This function will
fail if the *heading* of the `1` argument is not a subset of the
*heading* of the `0` argument.  This function implements the
`Attributive` virtual function `on` aka `project` aka `%=` aka `π` for
the composing type `Tuple`.

## update (Tuple)

        update::Tuple : (\Function : (
            returns : ::Tuple,
            matches : (\Tuple:{::Tuple, ::Tuple}),
            implements : folder::'',
            accepts : (args:.\0 $? args:.\1),
            evaluates : (evaluates args --> \foundation::Tuple_update(\Tuple:{})),
        )),

The function `update::Tuple` results in a `Tuple` value that has all of
the attributes of the function's `0` argument but that, for each attribute
of the `0` argument whose attribute name *K* matches the name of an
attribute of its `1` argument, the result takes its corresponding
attribute from the `1` argument rather than from the `0` argument.  The
*degree* of the result is equal to the degree of the `0` argument.  This
function will fail if the *heading* of the `1` argument is not a subset
of the *heading* of the `0` argument.  This function implements the
`Attributive` virtual function `update` aka `%:=` for the composing type
`Tuple`.

## extend (Tuple)

        extend::Tuple : (\Function : (
            returns : ::Tuple,
            matches : (\Tuple:{::Tuple, ::Tuple}),
            implements : folder::'',
            accepts : (args:.\0 disjoint_heading args:.\1),
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            identity : (\Tuple:{}),
            evaluates : (evaluates args --> \foundation::Tuple_extend(\Tuple:{})),
        )),

The function `extend::Tuple` results in the *relational extension* of its
`0` argument in terms of its `1` argument.  The result is a `Tuple`
value that has all of the attributes of the function's `0` argument plus
all of the attributes of its `1` argument.  The *degree* of the result is
equal to the integral sum of the degrees of the 2 arguments.  This function
will fail if the *headings* of the 2 arguments are not disjoint.  This
function implements the `Attributive` virtual function `extend` aka `%+`
for the composing type `Tuple`.

## at (Tuple)

        at::Tuple : (\Function : (
            returns : ::Any,
            matches : (\Tuple:{::Tuple, ::Attr_Name}),
            implements : folder::'',
            accepts : (args:.\0 .? args:.\1),
            evaluates : (args:.\0 :. (args:.\1)),
        )),

The function `at::Tuple` results in the attribute asset value of its `0`
argument whose attribute name is equal to its `1` argument.  This function
will fail if the `0` argument doesn't have such an attribute.  This
function implements the `Accessible` virtual function `at` aka `.` for
the composing type `Tuple`.

Note that while the `at::Tuple` definition could have been in terms of a
plain invocation of the Foundation function `Tuple_at`, it is instead in
terms of the special-purpose expression syntax for a `Tuple` attribute
asset accessor aka `:.`.

## to_Tuple (Tuple)

        to_Tuple::Tuple : (\Function : (
            returns : ::Tuple,
            matches : (\Tuple:{::Tuple}),
            implements : folder::'',
            evaluates : (args:.\0),
        )),

The function `to_Tuple::Tuple` simply results in its `0` argument.  This
function implements the `Structural` virtual function `to_Tuple` aka `%`
for the composing type `Tuple`.

## any_attrs

        any_attrs : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Tuple, ::Signature}),
            evaluates : (foundation::Tuple_any_attrs(args:.\0, Signature_to_Function_Call_But_0::(args:.\1))),
        )),

*TODO.*

## none_of_attrs

        none_of_attrs : (\Function : (\Tuple:{
            negates : ::any_attrs,
        })),

*TODO.*

## all_attrs

        all_attrs : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Tuple, ::Signature}),
            evaluates : (args:.\0 none_of_attrs \not_is_a::( 1: args:.\1 )),
        )),

*TODO.*

## not_all_attrs

        not_all_attrs : (\Function : (\Tuple:{
            negates : ::all_attrs,
        })),

*TODO.*

## all_attr_assets

        all_attr_assets : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Tuple, ::Signature}),
            evaluates : (args:.\0 all_attrs \(evaluates args:.\1 <-- (\Tuple:{args:.\0.\asset}))
                <-- (1 : Signature_to_Function_Call_But_0::(args:.\1))),
        )),

*TODO.*

## attrs_where

        attrs_where : (\Function : (
            returns : ::Tuple,
            matches : (\Tuple:{::Tuple, ::Signature}),
            evaluates : (foundation::Tuple_attrs_where(args:.\0, Signature_to_Function_Call_But_0::(args:.\1))),
        )),

*TODO.*

## attrs_map

        attrs_map : (\Function : (
            returns : ::Tuple,
            matches : (\Tuple:{::Tuple, ::Function_Call_But_0}),
            evaluates : (evaluates args --> \foundation::Tuple_attrs_map(\Tuple:{})),
        )),

*TODO.*

## attrs_reduce

        attrs_reduce : (\Function : (
            returns : ::Any,
            matches : (\Tuple:{::Tuple, ::Function_Call_But_0_1}),
            evaluates : (evaluates args --> \foundation::Tuple_attrs_reduce(\Tuple:{})),
        )),

*TODO.*

# RELATIONAL DATA TYPES

## Relational

        Relational : (\Function : (
            is_type_definer : 0bTRUE,
            is_generalization : 0bTRUE,
            composes : (\Set:[::Unionable, ::Attributive]),
        )),

The interface type definer `Relational` is semifinite.  A `Relational` value is
a `Unionable` value that is also an `Attributive` value.  This means the
value is or is isomorphic to a `Homogeneous` collection each of whose
*members* is a `Tuple`, and every member has the same relational
*heading*; but a `Relational` value still has a heading even if it has no
members.  The default value of `Relational` is the `Relation` value with
zero attributes and zero members, `\?%(\Tuple:{})`.  `Relational` is composed by
`Orderelation`, `Relation`, `Multirelation`.

## not_empty (Relational)

        not_empty::Relational : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Relational}),
            implements : folder::'',
            evaluates : (? |args:.\0),
        )),

The function `not_empty::Relational` results in `0bTRUE` iff its `0`
argument has any tuples, and in `0bFALSE` iff it has no tuples.  This
function implements the `Homogeneous` virtual function `not_empty`
for the composing type `Relational`.

## empty (Relational)

        empty::Relational : (\Function : (
            returns : ::Relational,
            matches : (\Tuple:{::Relational}),
            implements : folder::'',
            evaluates : (select_Relational::(\Tuple:{ like: args:.\0, heading: $args:.\0, body: empty |args:.\0 })),
        )),

The function `empty::Relational` results in the only value of its `0`
argument's relational type that has the same *heading* as that argument
and whose *body* has zero tuples.  This function implements the
`Homogeneous` virtual function `empty` aka `∅` for the composing type
`Relational`.

## singular (Relational)

        singular::Relational : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Relational}),
            implements : folder::'',
            evaluates : (singular |args:.\0),
        )),

The function `singular::Relational` results in `0bTRUE` iff its `0`
argument has exactly 1 distinct tuple, and `0bFALSE` otherwise.  This
function implements the `Homogeneous` virtual function `singular` for the
composing type `Relational`.

## only_member (Relational)

        only_member::Relational : (\Function : (
            returns : ::Structural,
            matches : (\Tuple:{::Relational}),
            implements : folder::'',
            accepts : (singular args:.\0),
            evaluates : (only_member |args:.\0),
        )),

The function `only_member::Relational` results in its `0` argument's only
distinct tuple.  This function will fail if the argument doesn't have
exactly 1 distinct tuple.  This function implements the `Homogeneous`
virtual function `only_member` for the composing type `Relational`.

## has_n (Relational)

        has_n::Relational : (\Function : (
            returns : (\Set:[::Boolean, ::Not_Same_Heading]),
            matches : (\Tuple:{::Relational, ::Structural, ::Integer_NN}),
            implements : folder::'',
            evaluates : (if args:.\0 =$ args:.\1 then guard has_n::(\Tuple:{|args:.\0, args:.\1, args:.\2})
                else (::Not_Same_Heading : (\Tuple:{}))),
        )),

The function `has_n::Relational` results in `0bTRUE` iff its `0` argument
has at least N tuples such that each is equal to its `1` argument, where N
is defined by its `2` argument; otherwise it results in `0bFALSE`.  The
result is always `0bTRUE` when the `2` argument is zero.  Note that having
a `2` argument greater than 1 in combination with a `Setty` typed `0`
argument will always result in `0bFALSE`.  The result is only *defined*
when the `0` and `1` arguments have the same *heading*; it is
`(::Not_Same_Heading : (\Tuple:{}))` otherwise.  This function implements the `Homogeneous` virtual
function `has_n` for the composing type `Relational`.

## multiplicity (Relational)

        multiplicity::Relational : (\Function : (
            returns : ::Integer_NN,
            matches : (\Tuple:{::Relational, ::Structural}),
            implements : folder::'',
            evaluates : (|args:.\0 multiplicity args:.\1),
        )),

The function `multiplicity::Relational` results in the integral count
of tuples of its `0` argument such that each tuple is equal to its
`1` argument.  For a `Setty` typed `0` argument, the result is always
just 0 or 1.  This function implements the `Homogeneous` virtual
function `multiplicity` for the composing type `Relational`.

## all_unique (Relational)

        all_unique::Relational : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Relational}),
            implements : folder::'',
            evaluates : (all_unique |args:.\0),
        )),

The function `all_unique::Relational` results in `0bTRUE` iff its `0`
argument has no 2 members that are the same tuple, and `0bFALSE` otherwise.
The result is always `0bTRUE` for a `Setty` argument.  This function
implements the `Homogeneous` virtual function `all_unique` for the
composing type `Relational`.

## unique (Relational)

        unique::Relational : (\Function : (
            returns : ::Relational,
            matches : (\Tuple:{::Relational}),
            implements : folder::'',
            evaluates : (select_Relational::(\Tuple:{ like: args:.\0, heading: $args:.\0, body: unique |args:.\0 })),
        )),

The function `unique::Relational` results in the value of its `0`
argument's relational type that has, for every distinct tuple *V* of the
function's `0` argument, exactly 1 tuple that is equal to *V*. The result
is always the same value as its argument when that is `Setty`.  If the
result's type is `Positional`, then each retained tuple is the one closest
to the start of the argument out of those tuples sharing the retained
tuple's value.  See also the `Positional` function `squish`.  This
function implements the `Homogeneous` virtual function `unique` for the
composing type `Relational`.

## subset_of (Relational)

        subset_of::Relational : (\Function : (
            returns : (\Set:[::Boolean, ::Not_Same_Heading]),
            matches : (\Tuple:{::Relational, ::Relational}),
            implements : folder::'',
            evaluates : (if args:.\0 =$ args:.\1 then guard |args:.\0 subset_of |args:.\1
                else (::Not_Same_Heading : (\Tuple:{}))),
        )),

The function `subset_of::Relational` results in `0bTRUE` iff the multiset
of tuples of its `0` argument is a subset of the multiset of tuples of its
`1` argument; otherwise it results in `0bFALSE`.  The result is only
*defined* when the 2 arguments have the same *heading*; it is
`(::Not_Same_Heading : (\Tuple:{}))` otherwise.  This function implements the `Homogeneous` virtual
function `subset_of` aka `⊆` for the composing type `Relational`.

## same_members (Relational)

        same_members::Relational : (\Function : (
            returns : (\Set:[::Boolean, ::Not_Same_Heading]),
            matches : (\Tuple:{::Relational, ::Relational}),
            implements : folder::'',
            is_commutative : 0bTRUE,
            evaluates : (if args:.\0 =$ args:.\1 then guard |args:.\0 same_members |args:.\1
                else (::Not_Same_Heading : (\Tuple:{}))),
        )),

The function `same_members::Relational` results in `0bTRUE` iff the
multiset of tuples of its `0` argument is the same as the multiset of
tuples of its `1` argument; otherwise it results in `0bFALSE`.  This
function may result in `0bTRUE` for some `Positional` arguments for which
`same` would result in `0bFALSE` because the latter considers tuple order
significant while the former doesn't; for non-`Positional` arguments, the
2 functions are typically the same.  The result is only *defined* when the
2 arguments have the same *heading*; it is `(::Not_Same_Heading : (\Tuple:{}))` otherwise.  This
function implements the `Homogeneous` virtual function `same_members` for
the composing type `Relational`.

## overlaps_members (Relational)

        overlaps_members::Relational : (\Function : (
            returns : (\Set:[::Boolean, ::Not_Same_Heading]),
            matches : (\Tuple:{::Relational, ::Relational}),
            implements : folder::'',
            is_commutative : 0bTRUE,
            evaluates : (if args:.\0 =$ args:.\1 then guard |args:.\0 overlaps_members |args:.\1
                else (::Not_Same_Heading : (\Tuple:{}))),
        )),

The function `overlaps_members::Relational` results in `0bTRUE` iff, given
*X* as the multiset of tuples of its argument `0` and *Y* as the
multiset of tuples of its argument `1`, there exists at least 1 tuple that
both *X* and *Y* have, and there also exists at least 1 other tuple each
of *X* and *Y* that the other doesn't have; otherwise it results in
`0bFALSE`.  The result is only *defined* when the 2 arguments have the same
*heading*; it is `(::Not_Same_Heading : (\Tuple:{}))` otherwise.  This function implements the
`Homogeneous` virtual function `overlaps_members` for the composing type
`Relational`.

## disjoint_members (Relational)

        disjoint_members::Relational : (\Function : (
            returns : (\Set:[::Boolean, ::Not_Same_Heading]),
            matches : (\Tuple:{::Relational, ::Relational}),
            implements : folder::'',
            is_commutative : 0bTRUE,
            evaluates : (if args:.\0 =$ args:.\1 then guard |args:.\0 disjoint_members |args:.\1
                else (::Not_Same_Heading : (\Tuple:{}))),
        )),

The function `disjoint_members::Relational` results in `0bTRUE` iff the
multiset of tuples of its `0` argument has no tuples in common with the
multiset of tuples of its `1` argument; otherwise it results in `0bFALSE`.
The result is only *defined* when the 2 arguments have the same
*heading*; it is `(::Not_Same_Heading : (\Tuple:{}))` otherwise.  This function implements the
`Homogeneous` virtual function `disjoint_members` for the composing type
`Relational`.

## any (Relational)

        any::Relational : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Relational, ::Signature}),
            implements : folder::'',
            evaluates : (|args:.\0 any args:.\1),
        )),

*TODO.*

## insert_n (Relational)

        insert_n::Relational : (\Function : (
            returns : (\Set:[::Relational, ::Not_Same_Heading]),
            matches : (\Tuple:{::Relational, ::Structural, ::Integer_NN}),
            implements : folder::'',
            evaluates : (if args:.\0 =$ args:.\1 then guard select_Relational::
                    ( like: args:.\0, heading: $args:.\0, body: insert_n::(\Tuple:{|args:.\0, args:.\1, args:.\2}) )
                else (::Not_Same_Heading : (\Tuple:{}))),
        )),

The function `insert_n::Relational` results in the value of its `0`
argument's relational type that has all of the tuples of the function's
`0` argument plus N additional tuples that are each equal to its `1`
argument, where N is defined by its `2` argument; however, if the result's
type is `Setty`, the result will have no more than 1 tuple equal to the
`1` argument (any duplicates will be silently eliminated), so the result
may equal the `0` argument even when the `2` argument is nonzero.  If the
result's type is `Positional`, then the result starts with all of the
tuples of `0` in the same order and ends with any added instances of `1`.
The result is only *defined* when the `0` and `1` arguments have the
same *heading*; it is `(::Not_Same_Heading : (\Tuple:{}))` otherwise. This function implements the
`Unionable` virtual function `insert_n` for the composing type
`Relational`.

## remove_n (Relational)

        remove_n::Relational : (\Function : (
            returns : (\Set:[::Relational, ::Not_Same_Heading]),
            matches : (\Tuple:{::Relational, ::Structural, ::Integer_NN}),
            implements : folder::'',
            evaluates : (if args:.\0 =$ args:.\1 then guard select_Relational::
                    ( like: args:.\0, heading: $args:.\0, body: remove_n::(\Tuple:{|args:.\0, args:.\1, args:.\2}) )
                else (::Not_Same_Heading : (\Tuple:{}))),
        )),

The function `remove_n::Relational` results in the value of its `0`
argument's relational type that has all of the tuples of the function's
`0` argument minus N existing tuples that are each equal to its `1`
argument, where N is defined as the lesser of its `2` argument and the
count of tuples of `0` equal to the `1` argument, so the result may equal
the `0` argument even when the `2` argument is nonzero.  If the result's
type is `Positional`, then the removed instances of `1` are those closest
to the end of `0`.  The result is only *defined* when the `0` and `1`
arguments have the same *heading*; it is `(::Not_Same_Heading : (\Tuple:{}))` otherwise.  This
function implements the `Unionable` virtual function `remove_n` for the
composing type `Relational`.

## member_plus (Relational)

        member_plus::Relational : (\Function : (
            returns : (\Set:[::Relational, ::Not_Same_Heading]),
            matches : (\Tuple:{::Relational, ::Relational}),
            implements : folder::'',
            is_associative : 0bTRUE,
            evaluates : (if args:.\0 =$ args:.\1 then guard select_Relational::
                    (\Tuple:{ like: args:.\0, heading: $args:.\0, body: |args:.\0 member_plus |args:.\1 })
                else (::Not_Same_Heading : (\Tuple:{}))),
        )),

The function `member_plus::Relational` results in the *multiset sum* of
its 2 arguments `0` and `1`.  The result is the value of its `0`
argument's relational type that has all of the tuples of the function's
`0` argument plus all of the tuples of its `1` argument.  For every
distinct tuple of the result, its multiplicity is the integral sum of the
multiplicities of that same tuple of each of the 2 arguments; however, if
the result's type is `Setty`, the result will only have 1 tuple per
distinct tuple (any duplicates will be silently eliminated).  If the
result's type is `Positional`, then the result starts with all of the
members of `0` and ends with the members of `1`, the members from both in
the same order as in their respective arguments; that is, this function
then behaves identically to `catenate` aka `~` when given the same
arguments.  This operation has a *two-sided identity element* value of a collection with zero
members.  For non-ordered types, this operation is also commutative.  The
result is only *defined* when the 2 arguments have the same *heading*; it
is `(::Not_Same_Heading : (\Tuple:{}))` otherwise.  This function implements the `Unionable`
virtual function `member_plus` aka `⊎` for the composing type
`Relational`.

## except (Relational)

        except::Relational : (\Function : (
            returns : (\Set:[::Relational, ::Not_Same_Heading]),
            matches : (\Tuple:{::Relational, ::Relational}),
            implements : folder::'',
            evaluates : (if args:.\0 =$ args:.\1 then guard select_Relational::
                    (\Tuple:{ like: args:.\0, heading: $args:.\0, body: |args:.\0 except |args:.\1 })
                else (::Not_Same_Heading : (\Tuple:{}))),
        )),

The function `except::Relational` results in the *multiset difference*
between its 2 arguments `0` (*minuend*) and `1` (*subtrahend*).  The
result is the value of its `0` argument's relational type that has all of
the tuples of the function's `0` argument minus all of the matching tuples
of its `1` argument.  For every distinct tuple of the result, its
multiplicity is the integral difference of the multiplicities of that same
tuple of each of the 2 arguments (when subtracting the *subtrahend* from
the *minuend*); a multiplicity is zero when it would otherwise be
negative.  If the result's type is `Positional`, then the removed
instances of any distinct tuple are those closest to the end of `0`.  This
operation has a *right identity element* value of a collection with zero members.  The
result is only *defined* when the 2 arguments have the same *heading*; it
is `(::Not_Same_Heading : (\Tuple:{}))` otherwise.  This function implements the `Unionable`
virtual function `except` aka `∖` for the composing type `Relational`.

## intersect (Relational)

        intersect::Relational : (\Function : (
            returns : (\Set:[::Relational, ::Not_Same_Heading]),
            matches : (\Tuple:{::Relational, ::Relational}),
            implements : folder::'',
            is_associative : 0bTRUE,
            is_idempotent : 0bTRUE,
            evaluates : (if args:.\0 =$ args:.\1 then guard select_Relational::
                    (\Tuple:{ like: args:.\0, heading: $args:.\0, body: |args:.\0 intersect |args:.\1 })
                else (::Not_Same_Heading : (\Tuple:{}))),
        )),

The function `intersect::Relational` results in the *multiset
intersection* of its 2 arguments `0` and `1`.  The result is the value of
its `0` argument's relational type that has all of the tuples of the
function's `0` argument that match their own tuples of its `1` argument.
For every distinct tuple of the result, its multiplicity is the integral
minimum of the multiplicities of that same tuple of each of the 2 arguments
(any nonmatched argument tuple does not appear in the result).  If the
result's type is `Positional`, then the removed instances of any distinct
tuple are those closest to the end of `0`.  This operation conceptually
has a *two-sided identity element* value of a collection with an infinite number of members.
For non-ordered types, this operation is also commutative.  The result is
only *defined* when the 2 arguments have the same *heading*; it is
`(::Not_Same_Heading : (\Tuple:{}))` otherwise.  This function implements the `Unionable` virtual
function `intersect` aka `∩` for the composing type `Relational`.

## union (Relational)

        union::Relational : (\Function : (
            returns : (\Set:[::Relational, ::Not_Same_Heading]),
            matches : (\Tuple:{::Relational, ::Relational}),
            implements : folder::'',
            is_idempotent : 0bTRUE,
            evaluates : (if args:.\0 =$ args:.\1 then guard select_Relational::
                    (\Tuple:{ like: args:.\0, heading: $args:.\0, body: |args:.\0 union |args:.\1 })
                else (::Not_Same_Heading : (\Tuple:{}))),
        )),

The function `union::Relational` results in the *multiset union* of its 2
arguments `0` and `1`.  The result is the value of its `0` argument's
relational type that has all of the tuples of the function's `0` argument
plus all of the nonmatching tuples of its `1` argument.  For every
distinct tuple of the result, its multiplicity is the integral maximum of
the multiplicities of that same tuple of each of the 2 arguments.  If the
result's type is `Positional`, then the result starts with all of the
members of `0` and ends with the nonmatching members of `1`, the members
from both in the same order as in their respective arguments; the removed
(due to matching) instances of any distinct tuple are those closest to the
end of `1`.  This operation has a *two-sided identity element* value of a collection with
zero members.  For non-ordered types, this operation is also associative
and commutative.  The result is only *defined* when the 2 arguments have
the same *heading*; it is `(::Not_Same_Heading : (\Tuple:{}))` otherwise.  This function
implements the `Unionable` virtual function `union` aka `∪` for the
composing type `Relational`.

## exclusive (Relational)

        exclusive::Relational : (\Function : (
            returns : (\Set:[::Relational, ::Not_Same_Heading]),
            matches : (\Tuple:{::Relational, ::Relational}),
            implements : folder::'',
            is_associative : 0bTRUE,
            is_commutative : 0bTRUE,
            evaluates : (if args:.\0 =$ args:.\1 then guard select_Relational::
                    (\Tuple:{ like: args:.\0, heading: $args:.\0, body: |args:.\0 exclusive |args:.\1 })
                else (::Not_Same_Heading : (\Tuple:{}))),
        )),

The function `exclusive::Relational` results in the *multiset symmetric
difference* of its 2 arguments `0` and `1`.  The result is the value of
its `0` argument's relational type that has all of the tuples of each of
the function's `0` and `1` arguments that do not have matching tuples of
their counterpart argument.  For every distinct tuple of the result, its
multiplicity is the integral maximum of the multiplicities of that same
tuple of each of the 2 arguments, minus the integral minimum of the same.
If the result's type is `Positional`, then the result starts with the
nonmatching members of `0` and ends with the nonmatching members of `1`,
the members from both in the same order as in their respective arguments;
the removed (due to matching) instances of any distinct tuple are those
closest to the end of `0` or `1` respectively.  This operation has a
*two-sided identity element* value of a collection with zero members.  For non-ordered types,
this operation is also associative and commutative.  The result is only
*defined* when the 2 arguments have the same *heading*; it is
`(::Not_Same_Heading : (\Tuple:{}))` otherwise. This function implements the `Unionable` virtual
function `exclusive` aka `symm_diff` aka `∆` for the composing type
`Relational`.

## nest (Relational)

        nest::Relational : (\Function : (
            returns : ::Relational,
            matches : (\Tuple:{::Relational}),
            implements : folder::'',
            accepts : (...),
            evaluates : (...),
        )),

*TODO.*

## unnest (Relational)

        unnest::Relational : (\Function : (
            returns : ::Relational,
            matches : (\Tuple:{::Relational}),
            implements : folder::'',
            accepts : (...),
            evaluates : (...),
        )),

*TODO.*

## where (Relational)

        where::Relational : (\Function : (
            returns : ::Relational,
            matches : (\Tuple:{::Relational, ::Signature}),
            implements : folder::'',
            evaluates : (select_Relational::(\Tuple:{ like: args:.\0, heading: $args:.\0, body: |args:.\0 where args:.\1 })),
        )),

*TODO.*

## map (Relational)

        map::Relational : (\Function : (
            returns : ::Relational,
            matches : (\Tuple:{::Relational, ::Function_Call_But_0}),
            implements : folder::'',
            evaluates : (...),
        )),

*TODO.*

## reduce (Relational)

        reduce::Relational : (\Function : (
            returns : ::Any,
            matches : (\Tuple:{::Relational, ::Function_Call_But_0_1}),
            implements : folder::'',
            evaluates : (|args:.\0 reduce args:.\1),
        )),

*TODO.*

## has_any_attrs (Relational)

        has_any_attrs::Relational : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Relational}),
            implements : folder::'',
            evaluates : ($args:.\0 != (\Tuple:{})),
        )),

The function `has_any_attrs::Relational` results in `0bTRUE` iff its `0`
argument has any attributes, and in `0bFALSE` iff it has no attributes.
This function implements the `Attributive` virtual function
`has_any_attrs` aka `?$` for the composing type `Relational`.

## nullary (Relational)

        nullary::Relational : (\Function : (
            returns : ::Relational,
            matches : (\Tuple:{::Relational}),
            implements : folder::'',
            evaluates : (args:.\0 on (\Tuple:{})),
        )),

The function `nullary::Relational` results in the value of its `0`
argument's relational type that has zero attributes.  For types like
`Multirelation`, there is a distinct result for each *cardinality*; for types
like `Relation` there are exactly 2 possible result values.  This function
implements the `Attributive` virtual function `nullary` for the composing
type `Relational`.

## is_unary (Relational)

        is_unary::Relational : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Relational}),
            implements : folder::'',
            evaluates : (is_unary $args:.\0),
        )),

The function `is_unary::Relational` results in `0bTRUE` iff its `0`
argument has exactly 1 attribute, and `0bFALSE` otherwise.  This function
implements the `Attributive` virtual function `is_unary` for the
composing type `Relational`.

## degree (Relational)

        degree::Relational : (\Function : (
            returns : ::Integer_NN,
            matches : (\Tuple:{::Relational}),
            implements : folder::'',
            evaluates : (degree $args:.\0),
        )),

The function `degree::Relational` results in the integral count of the
attributes of its `0` argument.  This function implements the
`Attributive` virtual function `degree` aka `#$` for the composing type
`Relational`.

## rename (Relational)

        rename::Relational : (\Function : (
            returns : ::Relational,
            matches : (\Tuple:{::Relational, ::Renaming}),
            implements : folder::'',
            accepts : (...),
            evaluates : (select_Relational::( like: args:.\0, heading: $args:.\0 rename args:.\1,
                body: |args:.\0 map \rename::( 1: args:.\1 ) )),
        )),

The function `rename::Relational` results results in the *relational
rename* of its `0` argument in terms of its `1` argument.  The result is
a value of the function's `0` argument's relational type that has all of
the attributes of the function's `0` argument but that, for each attribute
of the `0` argument whose attribute name matches a *before* element of
its `1` argument, the result's corresponding attribute instead has an
attribute name that matches the corresponding *after* element of the `1`
argument.  The *degree* and the *cardinality* of the result are both
equal to the degree and cardinality of the `0` argument, respectively.
This function will fail if any *before* element of the `1` argument does
not match the name of an attribute name of the `0` argument, or if any
*after* element of the former does match an attribute name of the latter
that isn't being renamed.  This function implements the `Attributive`
virtual function `rename` aka `$:=` aka `ρ` for the composing type
`Relational`.

## can_project_matching (Relational)

        can_project_matching::Relational : (\Function : (
            returns : ::Boolean,
            matches : (\Tuple:{::Relational, ::Structural}),
            implements : folder::'',
            evaluates : (args:.\0 $? args:.\1
                and_then guard |args:.\0 all \(args:.\0 %= $args:.\1 = args:.\1) <-- (\Tuple:{1 : args:.\1})),
        )),

The function `can_project_matching::Relational` results in `0bTRUE` iff the
heading of its `0` argument is a superset of the heading of its `1`
argument and every commonly-named attribute of the two arguments also has
the same attribute asset; otherwise it results in `0bFALSE`.  Note that by
definition, the identity `can_project_matching::(update::(\Tuple:{a,s}),s) = 0bTRUE`
aka `a %:= s %=? s = 0bTRUE` should hold for all valid `a` and `s`.  This
function implements the `Attributive` virtual function
`can_project_matching` aka `%=?` for the composing type `Relational`.

## on (Relational)

        on::Relational : (\Function : (
            returns : ::Relational,
            matches : (\Tuple:{::Relational, ::Heading}),
            implements : folder::'',
            accepts : (args:.\0 $? args:.\1),
            evaluates : (select_Relational::( like: args:.\0, heading: $args:.\0 on args:.\1,
                body: |args:.\0 map \on::( 1: args:.\1 ) )),
        )),

The function `on::Relational` results in the *relational projection* of
its `0` argument in terms of its `1` argument.  The result is a value of
the function's `0` argument's relational type that has all of the
attributes of the function's `0` argument whose names match the names of
attributes of its `1` argument.  The *degree* of the result is equal to
the degree of the `1` argument, and the *cardinality* of the result is
either equal to or less than the cardinality of the `0` argument; a lesser
cardinality would be the result of duplicate result member elimination for
a *setty* type.  For every member tuple or isomorphism *X* in the `0`
argument, the result has a member tuple or isomorphism *Y* that is equal
to the result of projecting *X* on all of the attribute names of the `1`
argument.  This function will fail if the *heading* of the `1` argument
is not a subset of the *heading* of the `0` argument.  This function
implements the `Attributive` virtual function `on` aka `project` aka
`%=` aka `π` for the composing type `Relational`.

## update (Relational)

        update::Relational : (\Function : (
            returns : ::Relational,
            matches : (\Tuple:{::Relational, ::Structural}),
            implements : folder::'',
            accepts : (args:.\0 $? args:.\1),
            evaluates : (select_Relational::( like: args:.\0, heading: $args:.\0,
                body: |args:.\0 map \update::( 1: args:.\1 ) )),
        )),

The function `update::Relational` results in the value of its `0`
argument's relational type that has all of the attributes of the function's
`0` argument but that, for each attribute of the `0` argument whose
attribute name *K* matches the name of an attribute of its `1` argument,
the result takes its corresponding attribute from the `1` argument rather
than from the `0` argument.  The *degree* of the result is equal to the
degree of the `0` argument, and the *cardinality* of the result is either
equal to or less than the cardinality of the `0` argument; a lesser
cardinality would be the result of duplicate result member elimination for
a *setty* type.  For every member tuple or isomorphism *X* in the `0`
argument, the result has a member tuple or isomorphism *Y* that is equal
to *X* but that, for each attribute name *K* of *X*, the asset of the
attribute named *K* of *Y* is equal to the asset of the attribute named
*K* of the `1` argument rather than its value from *X*.  This function
will fail if the *heading* of the `1` argument is not a subset of the
*heading* of the `0` argument.  This function implements the
`Attributive` virtual function `update` aka `%:=` for the composing type
`Relational`.

## extend (Relational)

        extend::Relational : (\Function : (
            returns : ::Relational,
            matches : (\Tuple:{::Relational, ::Structural}),
            implements : folder::'',
            accepts : (args:.\0 disjoint_heading args:.\1),
            evaluates : (select_Relational::( like: args:.\0, heading: $args:.\0 extend args:.\1,
                body: |args:.\0 map \extend::( 1: args:.\1 ) )),
        )),

The function `extend::Relational` results in the *relational extension*
of its `0` argument in terms of its `1` argument.  The result is a value
of the function's `0` argument's relational type that has all of the
attributes of the function's `0` argument plus all of the attributes of
its `1` argument.  The *degree* of the result is equal to the integral
sum of the degrees of the 2 arguments, and the *cardinality* of the result
is equal to the cardinality of the `0` argument.  There is a bijection
between the `0` argument and the result with respect to their *members*;
for every tuple or isomorphism *X* in the `0` argument, the result has a
tuple or isomorphism *Y* that is equal to the result of extending *X*
with all of the attributes (names and assets) of the `1` argument.  This
function will fail if the *headings* of the 2 arguments are not disjoint.
This function implements the `Attributive` virtual function `extend` aka
`%+` for the composing type `Relational`.

## body |

        body::'' : (\Function : (
            virtual : 0bTRUE,
            returns : ::Unionable,
            matches : (\Tuple:{::Relational}),
        )),

        '|' : (\Alias : (\Tuple:{ of : ::body })),

The virtual function `body` aka `|` results in the relational *body* of
its `0` argument, that is its multiset of member tuples.  The form that
this takes is a generic `Unionable` (such as a generic `Array` or `Set`
or `Bag`) each of whose members is a `Structural` value.  Note that the 2
functions `heading` and `body` are complementary for `Relational`
values; between the two of them, one can obtain all primary components of a
typical `Relational` value, and select that same value again.

## select_Relational

        select_Relational::'' : (\Function : (
            virtual : 0bTRUE,
            returns : (\Set:[::Relational, ::...]),
            matches : (\Tuple:{like : ::Relational, heading : ::Heading, body : ::Unionable}),
        )),

The virtual function `select_Relational` results in the value of its
`like` argument's relational type that has the same *heading* as its
`heading` argument and whose *body* consists of just the member *tuples*
of its `body` argument.  The purpose of `select_Relational` is to help
facilitate ease of reuse of code between different `Relational` types.
Note that the identity `r = select_Relational::(\Tuple:{ like : r, heading : $r,
body : |r })` should hold for any `Relational` type.

*TODO: Flesh out the set of predefined Excuse values, such as for body
members that aren't compatible with the heading, or possibly for composing
types that restrict their possible headings at the type level.*

# TUPLE-ARRAY DATA TYPES

## Orderelation

        Orderelation : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Relational, ::Positional]),
            evaluates : (Signature::Article_Match : (
                label : \Orderelation,
                attrs : [
                    (
                        heading : \Heading::(\Tuple:{}),
                        body : (\Array:[\Array::(\Tuple:{}), \all::( 1: \Tuple::(\Tuple:{}) )]),
                    ),
                    \(args:.\0:.\body all \($args:.\0 = args:.\1) <-- (\Tuple:{1: args:.\0:.\heading})),
                ],
            )),
            default : (Orderelation:{}),
        )),

*TODO.*

*Note:  The in_order(\Tuple:{TA,TA}) inherited via Positional, which Orderelation
implements just for convenience and consistency with Array but doesn't
expect to be meaningful any more than say the Boolean version...
It needs to inline the in_order(\Tuple:{Tuple,Tuple}) used for its heading and for
its first nonmatching member, rather than Tuple implementing an in_order(\Tuple:{}),
since we don't want to infect the generic Tuple with all the Orderable ops.*
*Note: This type structurally resembles a spreadsheet or a .NET DataTable,
or a subtype of it does.*

## Orderelation_D0C0

        Orderelation_D0C0 : (\Function : (
            is_type_definer : 0bTRUE,
            constant : (Orderelation:{}),
        )),

The singleton type definer `Orderelation_D0C0` represents the only zero-attribute,
zero-tuple `Orderelation` value.

## Orderelation_D0C1

        Orderelation_D0C1 : (\Function : (
            is_type_definer : 0bTRUE,
            constant : (Orderelation:[{}]),
        )),

The singleton type definer `Orderelation_D0C1` represents the only zero-attribute,
single-tuple `Orderelation` value.

## heading (Orderelation)

        heading::Orderelation : (\Function : (
            returns : ::Heading,
            matches : (\Tuple:{::Orderelation}),
            implements : folder::'',
            evaluates : (args:.\0:>.\heading),
        )),

The function `heading::Orderelation` results in the relational *heading*
of its `0` argument, that is its set of distinct attribute names.  This
function implements the `Attributive` virtual function `heading` aka `$`
for the composing type `Orderelation`.

## body (Orderelation)

        body::Orderelation : (\Function : (
            returns : ::Array,
            matches : (\Tuple:{::Orderelation}),
            implements : folder::'',
            evaluates : (args:.\0:>.\body),
        )),

The function `body::Orderelation` results in the relational *body* of its
`0` argument, that is its multiset of member tuples.  This function
implements the `Relational` virtual function `body` aka `|` for the
composing type `Orderelation`.

## select_Relational (Orderelation)

        select_Relational::Orderelation : (\Function : (
            returns : (\Set:[::Relational, ::...]),
            matches : (\Tuple:{like : ::Orderelation, heading : ::Heading, body : ::Array}),
            implements : folder::'',
            evaluates : ((\Orderelation : (args %= ::(\Tuple:{heading,body})))),
        )),

The function `select_Relational::Orderelation` results in the
`Orderelation` value that has the same *heading* as its `heading`
argument and whose *body* consists of just the member *tuples* of its
`body` argument.  This function implements the `Relational` virtual
function `select_Relational` for the composing type `Orderelation`.

# RELATION DATA TYPES

## Relation

        Relation : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Relational, ::Discrete, ::Setty]),
            provides_default_for : (\Set:[::Relational]),
            evaluates : (Signature::Article_Match : (
                label : \Relation,
                attrs : [
                    (
                        heading : \Heading::(\Tuple:{}),
                        body : (\Array:[\Set::(\Tuple:{}), \all::( 1: \Tuple::(\Tuple:{}) )]),
                    ),
                    \(args:.\0:.\body all \($args:.\0 = args:.\1) <-- (\Tuple:{1: args:.\0:.\heading})),
                ],
            )),
            default : (Relation:{}),
        )),

*TODO.  See also definition of Set in terms of Bag, which Relation mirrors.*

## Relation_D0C0

        Relation_D0C0 : (\Function : (
            is_type_definer : 0bTRUE,
            constant : (Relation:{}),
        )),

The singleton type definer `Relation_D0C0` represents the only
zero-attribute, zero-tuple `Relation` value.  Note that *The Third
Manifesto* also refers to this value by the special name *TABLE_DUM*.

## Relation_D0C1

        Relation_D0C1 : (\Function : (
            is_type_definer : 0bTRUE,
            constant : (Relation:[{}]),
        )),

The singleton type definer `Relation_D0C1` represents the only
zero-attribute, single-tuple `Relation` value.  Note that *The Third
Manifesto* also refers to this value by the special name *TABLE_DEE*.

## heading (Relation)

        heading::Relation : (\Function : (
            returns : ::Heading,
            matches : (\Tuple:{::Relation}),
            implements : folder::'',
            evaluates : (args:.\0:>.\heading),
        )),

The function `heading::Relation` results in the relational *heading*
of its `0` argument, that is its set of distinct attribute names.  This
function implements the `Attributive` virtual function `heading` aka `$`
for the composing type `Relation`.

## body (Relation)

        body::Relation : (\Function : (
            returns : ::Set,
            matches : (\Tuple:{::Relation}),
            implements : folder::'',
            evaluates : (args:.\0:>.\body),
        )),

The function `body::Relation` results in the relational *body* of its
`0` argument, that is its set of member tuples.  This function
implements the `Relational` virtual function `body` aka `|` for the
composing type `Relation`.

## select_Relational (Relation)

        select_Relational::Relation : (\Function : (
            returns : (\Set:[::Relational, ::...]),
            matches : (\Tuple:{like : ::Relation, heading : ::Heading, body : ::Set}),
            implements : folder::'',
            evaluates : ((\Relation : (args %= ::(\Tuple:{heading,body})))),
        )),

The function `select_Relational::Relation` results in the
`Relation` value that has the same *heading* as its `heading`
argument and whose *body* consists of just the member *tuples* of its
`body` argument.  This function implements the `Relational` virtual
function `select_Relational` for the composing type `Relation`.

# TUPLE-BAG DATA TYPES

## Multirelation

        Multirelation : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Relational, ::Discrete]),
            evaluates : (Signature::Article_Match : (
                label : \Multirelation,
                attrs : [
                    (
                        heading : \Heading::(\Tuple:{}),
                        body : (\Array:[\Bag::(\Tuple:{}), \all::( 1: \Tuple::(\Tuple:{}) )]),
                    ),
                    \(args:.\0:.\body all \($args:.\0 = args:.\1) <-- (\Tuple:{1: args:.\0:.\heading})),
                ],
            )),
            default : (Multirelation:{}),
        )),

*TODO.*

## Multirelation_D0C0

        Multirelation_D0C0 : (\Function : (
            is_type_definer : 0bTRUE,
            constant : (Multirelation:{}),
        )),

The singleton type definer `Multirelation_D0C0` represents the only zero-attribute,
zero-tuple `Multirelation` value.

## Multirelation_D0C1

        Multirelation_D0C1 : (\Function : (
            is_type_definer : 0bTRUE,
            constant : (Multirelation:[{}]),
        )),

The singleton type definer `Multirelation_D0C1` represents the only zero-attribute,
single-tuple `Multirelation` value.

## heading (Multirelation)

        heading::Multirelation : (\Function : (
            returns : ::Heading,
            matches : (\Tuple:{::Multirelation}),
            implements : folder::'',
            evaluates : (args:.\0:>.\heading),
        )),

The function `heading::Multirelation` results in the relational *heading*
of its `0` argument, that is its set of distinct attribute names.  This
function implements the `Attributive` virtual function `heading` aka `$`
for the composing type `Multirelation`.

## body (Multirelation)

        body::Multirelation : (\Function : (
            returns : ::Bag,
            matches : (\Tuple:{::Multirelation}),
            implements : folder::'',
            evaluates : (args:.\0:>.\body),
        )),

The function `body::Multirelation` results in the relational *body* of its
`0` argument, that is its multiset of member tuples.  This function
implements the `Relational` virtual function `body` aka `|` for the
composing type `Multirelation`.

## select_Relational (Multirelation)

        select_Relational::Multirelation : (\Function : (
            returns : (\Set:[::Relational, ::...]),
            matches : (\Tuple:{like : ::Multirelation, heading : ::Heading, body : ::Bag}),
            implements : folder::'',
            evaluates : ((\Multirelation : (args %= ::(\Tuple:{heading,body})))),
        )),

The function `select_Relational::Multirelation` results in the
`Multirelation` value that has the same *heading* as its `heading`
argument and whose *body* consists of just the member *tuples* of its
`body` argument.  This function implements the `Relational` virtual
function `select_Relational` for the composing type `Multirelation`.

# INTERVALISH DATA TYPES

## Intervalish

        Intervalish : (\Function : (
            is_type_definer : 0bTRUE,
            is_generalization : 0bTRUE,
            composes : (\Set:[::Homogeneous]),
        )),

*TODO.*

# INTERVAL DATA TYPES

## Interval

        Interval : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Intervalish, ::Setty]),
            evaluates : (Signature::Article_Match : (
                label : \Interval,
                attrs : \Interval_Attrs::(\Tuple:{}),
            )),
            default : ((::Before_All_Others : (\Tuple:{}))..(::After_All_Others : (\Tuple:{}))),
        )),

*TODO.*

## Interval_Attrs

        Interval_Attrs : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[\Tuple::(\Tuple:{}), ...]),
        )),

*TODO.*

# UNIONABLE INTERVALISH DATA TYPES

## Unionable_Intervalish

        Unionable_Intervalish : (\Function : (
            is_type_definer : 0bTRUE,
            is_generalization : 0bTRUE,
            composes : (\Set:[::Intervalish, ::Unionable]),
        )),

*TODO.*

# INTERVAL-SET DATA TYPES

## Set_Of_Interval

        Set_Of_Interval : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Unionable_Intervalish, ::Setty]),
            evaluates : (Signature::Article_Match : (
                label : \Set_Of_Interval,
                attrs : (
                    members : (\Array:[\Bag_Of_Interval::(\Tuple:{}), \all_unique::(\Tuple:{})]),
                ),
            )),
            default : ...,
        )),

*TODO.  See also definition of Set in terms of Bag, which Set_Of_Interval mirrors.*

# INTERVAL-BAG DATA TYPES

## Bag_Of_Interval

        Bag_Of_Interval : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Unionable_Intervalish]),
            evaluates : (Signature::Article_Match : (
                label : \Bag_Of_Interval,
                attrs : (
                    members : (\Array:[\Multirelation::(\Tuple:{}), ...]),
                ),
            )),
            default : ...,
        )),

*TODO.*

# QUANTITATIVE DATA TYPES

## Quantitative

        Quantitative : (\Function : (
            is_type_definer : 0bTRUE,
            is_generalization : 0bTRUE,
            composes : (\Set:[::Numerical]),
        )),

*TODO.*

# QUANTITY DATA TYPES

## Quantity

        Quantity : (\Function : (
            is_type_definer : 0bTRUE,
            composes : (\Set:[::Quantitative]),
            evaluates : (Signature::Article_Match : (
                label : \Quantity,
                attrs : (
                    0 : (\Array:[\Relation::(\Tuple:{}), ...]),
                ),
            )),
            default : ...,
        )),

*TODO.*

# ARTICLE DATA TYPES

## Article

        Article : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : \foundation::Article(\Tuple:{}),
            default : (0bFALSE : (\Tuple:{})),
        )),

The selection type definer `Article` represents the infinite Muldis Data Language
Foundation type `foundation::Article`.  An `Article` value is ...

A `Article` value consists of a *label* paired with a set of 0..N
*attributes* where that set must be represented by a `Tuple`.  While
conceptually a `Article` could pair a *label* with an *asset* of any
type, restricting the latter to a `Tuple` helps avoid unnecessary
complication for the design and users of the language.  The idiomatic way
to have an *attributes* *AV* that is conceptually of some non-`Tuple`
type is to have a single attribute whose asset is *AV*.  The idiomatic
default attribute name for a single-attribute `Article` is `0` when there
isn't an actual meaningful name to give it.

Given that almost every selection type definer is a subset of `Article`, the
latter intentionally does not compose any interface type definers, and also
does not have any of its own `System` package operators, so to minimize
interference with other types' interfaces.

Generic means for selecting `Article` values in terms of a
*label*/*attributes* pair, or for extracting the *label* or
*attributes* of a `Article`, are provided by dedicated language
expression node types and concrete syntax (and Foundation functions).

# HANDLE DATA TYPES

## Handle

        Handle : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : \foundation::Handle(\Tuple:{}),
        )),

The selection type definer `Handle` represents the infinite Muldis Data Language
Foundation type `foundation::Handle`.  A `Handle` value is an opaque and
transient reference to an entity or resource that potentially exists at
arms length from the current Muldis Data Language process or language environment or
that otherwise has the potential to mutate in a way visible to the current
Muldis Data Language process either due to or independent of the actions of said
process.  In the general case, the current Muldis Data Language process employs
*message passing* to interact with the entity such that the `Handle`
serves as its uniform resource identifier.  In notable contrast to other
type definers, except `None`, no `Handle` type definer has a `default`
trait, since it doesn't make sense for a `Handle` to be a default value.

`Handle` has multiple specialized subtypes including: `Variable`,
`Process`, `Stream`, `External`.  Given that `Handle` is opaque, its
subtypes can only be distinguised using Foundation type definers.  It is
possible that these subtypes may overlap if the same entity is capable of
multiple relevant behaviours / can process applicable messages.

Note that `Handle` are allowed to participate in reference cycles, for
example that the current value of a `Variable` is itself, however the
intentional use of cycles is strongly discouraged.  Optional hints may be
associated with `Handle` by users to help the system manage such cycles.

## Variable

        Variable : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : \foundation::Variable(\Tuple:{}),
        )),

The selection type definer `Variable` represents the infinite Muldis Data Language
Foundation type `foundation::Variable`.  A `Variable` value is an opaque and
transient reference to a Muldis Data Language *variable* (the latter being a container
for an appearance of a value).  The identity of a `Variable` is just the
identity of the (anonymous) variable that it points to, which is the
latter's address; when `same` is given two `Variable` arguments it will
result in `0bTRUE` iff they both point to the same variable.  Selection of a
`Variable` value is formally a non-deterministic niladic operation, and
can only be performed in a *procedure*, not in a *function*.  Selecting a
`Variable` value will create a new variable which it points to, and the
variable will be destroyed automatically when that `Variable` value is no
longer in use by the program.  Only a procedure may use a `Variable` to
access (read or mutate) the latter's variable; a function may only pass
around a `Variable` it is given or compare two (that they point to the
same variable or not), and can not access the variable behind it.

As a function only can perceive a `Variable` as a generic identifier, it
doesn't make sense to subtype or constrain a `Variable` as if it were the
type of the underlying variable's current value.  However, a `Variable`
can be wrapped by another value on the basis of whose other components
there can be subtyping or constraints.

TODO: Consider whether it is logically necessary for functions to be able
to read the variable behind a Variable, with a special expression node,
albeit with the guarantee that the variable is immutable / repeatable-read
during the life of the function call.  But if so, then that causes problems
in theory for higher-order functions, because then captures do or don't
have to be worried about should the function referring to the variable be
passed between statements.  Restricting to procedure expressions may help,
or not. Perhaps a solution to that is requiring functions to unwrap any
Variable into regular values if it expects to be non-deterministic.  Or
perhaps a more generic thing to do is split functions into 2 variants where
one is allowed to be non-deterministic (and read variables behind
Variables) while the other isn't.  The former can then also do certain
other things like read random numbers or fetch random elements or whatever.
If we cross this line, then variable reads don't need special syntax,
they're just a function of the appropriate kind.  We should probably use a
keyword other than "function" to name the variant, then, but their
structures are mostly alike.  Maybe call it a "reader"?  Note that this
"reader" would exclude most functional traits, particularly any that give
hints or imply commutativity etc.  Note that there are different kinds of
nondeterminism, such as select implementation-dependent-random something,
or scope over which a variable can be read repeatedly with same results, or
environment-based stuff, and each could perhaps be allowed or disallowed
individually.  MIND ALSO THE YAGNI PRINCIPLE, DON'T MOVE MORE OUT OF
EXCLUSIVE DOMAIN OF PROCEDURES THAN WE REALLY NEED TO. So something we
could do is NOT add the function variant, but supply a set of special
purpose foundational procedures for the common reasons we might want them.
FOR EXAMPLE, JUST CREATE A FOUNDATION 'SNAPSHOT' PROCEDURE WHICH WILL
RECURSIVELY FOLLOW A STRUCTURE AND REPLACE ALL HANDLES WITH THE CURRENT VALUES OF
THEIR VARIABLES AT THAT TIME (THIS OP SHOULD BE CHEAP).  Regular "current"/":&" deref
keyword would work for the typical single level fine, give value of a
variable to a function say.  Likewise, a proc to fetch a set of randoms.

TODO, other notes.  A `Variable` value also carries meta-data such as
whether it is a strong or a weak reference.  The actual current value of
the referenced variable is itself readonly, but if it or any of its
elements is a Variable, then via that indirection one can have an
arbitrarily complex graph of memory that is subject-to-update, and hence
any programming language or hardware having the concept of memory pointers
can be emulated or interfaced without too much indirection.
A *variable* itself also has meta-data such as its declared type (a
type definer) or registered stimulus-response rules etc.  Typically,
externally-interfacing resources such as file or network streams are
represented by `Variable` values.  The generic assignment procedure `:=`
takes a `Variable` as its left-hand argument and updates the variable
that this points to to hold the value of its right-hand argument.

## Process

        Process : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : \foundation::Process(\Tuple:{}),
        )),

The selection type definer `Process` represents the infinite Muldis Data Language
Foundation type `foundation::Process`.  A `Process` value is an opaque
and transient reference to a *process* running inside the Muldis Data Language
environment / DBMS / virtual machine, which typically has its own
autonomous transactional context.  Each Muldis Data Language *process*
might be either self-contained or be a proxy for some entity outside the
Muldis Data Language environment.

A typical and idiomatic example use for multiple processes is to coordinate
usage of a shared resource such as *the database*.  In this scenario, one
process would *own the database* and do the actual work of reading it from
or persisting it to storage and serializing transactions, while other
processes would represent users of *the database* that send the owner
messages defining data fetching queries or data manipulation requests, etc.

An idiomatic *request message* includes all of the self-contained logic
necessary to perform a complete database transaction, which would
effectively be performed using *serializable transaction isolation*, and
commit as a whole or else have no lasting effect.  An idiomatic *response
message* indicates whether the request was granted/succeeded or
denied/failed and returns any relevant fetched data.

Any translation of a message into physical actions against a file system,
or any translation of a message into some other query language such as SQL
for a remote execution, is done by the *database owner* Muldis Data Language process.

## Stream

        Stream : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : \foundation::Stream(\Tuple:{}),
        )),

The selection type definer `Stream` represents the infinite Muldis Data Language
Foundation type `foundation::Stream`.  A `Stream` value is an opaque and
transient reference to a Muldis Data Language *stream*, which represents streaming
data such as from/to user I/O or the filesystem or network services etc.

## External

        External::'' : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : \foundation::External(\Tuple:{}),
        )),

The selection type definer `External` represents the infinite Muldis Data Language
Foundation type `foundation::External`.  An `External` value is an opaque and
transient reference to an entity that is defined and managed externally to
Muldis Data Language environment, either internally to the Muldis Data Language host
implementation or in some peer language that it mediates.

As `External` values are black boxes to Muldis Data Language, it is the responsibility
of their external manager to at the very least implement the `same`
function for them in a fully deterministic manner, as well as externally
define any other operators for them that users may wish to invoke for those
values from Muldis Data Language code, including any to map with or marshal with
Muldis Data Language values.

Other programming languages may name their corresponding types *extern*
(asmjs).

## External::call_function

        External::call_function : (\Function : (
            returns : ::Any,
            matches : (\Tuple:{::Any}),
            evaluates : (evaluates \foundation::External_call_function(\Tuple:{}) <-- args),
        )),

The function `External::call_function` is a proxy for invoking a function
that is defined and managed externally to Muldis Data Language
environment.  Muldis Data Language will assume said function is completely
deterministic, and there would likely be problems if it isn't.  Using
`External::call_function` as a foundation, it is possible to define an
arbitrarily complex type graph involving `External` values.

# SOURCE CODE BEHAVIOURAL DATA TYPES

*TODO.*

## Package

        Package : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : \Package,
                attrs : (
                    identity : \Package::Identity::(\Tuple:{}),
                    foundation : \Package::Foundation::(\Tuple:{}),
                    uses : \Package::Uses_Map::(\Tuple:{}),
                    entry : \Package::Entry_Point::(\Tuple:{}),
                    floating : \Package::Floating::(\Tuple:{}),
                    materials : \Package::Folder::(\Tuple:{}),
                ),
            )),
            default : ...,
        )),

*TODO.*

## Package::Identity

        Package::Identity : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (
                package_base_name : \Package::Base_Name::(\Tuple:{}),
                authority : \Package::Canon_Authority::(\Tuple:{}),
                version_number : \Package::Canon_Version_Number::(\Tuple:{}),
            ),
        )),

## Package::Foundation

        Package::Foundation : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (
                authority : \Package::Canon_Authority::(\Tuple:{}),
                version_number : \Package::Canon_Version_Number::(\Tuple:{}),
            ),
        )),

## Package::Base_Name

        Package::Base_Name : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[\Nesting::(\Tuple:{}), \not_empty::(\Tuple:{}), \'∌'::( 1: \'' )]),
        )),

*TODO.*

## Package::Canon_Authority

        Package::Canon_Authority : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[\Text::(\Tuple:{}), \not_empty::(\Tuple:{})]),
        )),

*TODO.*

## Package::Canon_Version_Number

        Package::Canon_Version_Number : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[\Text::(\Tuple:{}), \not_empty::(\Tuple:{})]),
        )),

*TODO.*

## Package::Uses_Map

        Package::Uses_Map : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[\Tuple::(\Tuple:{}), \'.!?'::( 1: \'' ),
                \all_attr_assets::( 1: \Package::Uses_Item(\Tuple:{}) )]),
        )),

*TODO.  Each attribute name declares a single-element composing-package-local
alias for the used package.*

## Package::Uses_Item

        Package::Uses_Item : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (
                package_base_name : \Package::Base_Name::(\Tuple:{}),
                authority : \Package::Canon_Authority::(\Tuple:{}),
                version_number : \Package::Canon_Version_Number::(\Tuple:{}),
            ),
        )),

*TODO.  This type should be more complicated in order to support indicating
eg multiple authorities or version numbers including in interval format and
also indicate both positive or negative assertions of compatibility.
Until then, this type just represents a single positive assertion.*

## Package::Entry_Point

        Package::Entry_Point : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : \Absolute_Name::(\Tuple:{}),
        )),

*TODO.  This type is subject to be expanded to some collection or have alternatives.*

## Package::Floating

        Package::Floating : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[\Set::(\Tuple:{}), \all::( 1: \Absolute_Name::(\Tuple:{}) )]),
        )),

*TODO.*

## Package::Folder

        Package::Folder : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[\Tuple::(\Tuple:{}),
                \all_attr_assets::( 1: (\Set:[\Package::Folder(\Tuple:{}), \Material::(\Tuple:{})]) )]),
        )),

*TODO.*

## Material

        Material : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Set:[::Alias, ::Function, ::Procedure]),
            default : ...,
        )),

## Alias

        Alias : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : \Alias,
                attrs : (
                    of : \Identity_Identifier(\Tuple:{}),
                ),
            )),
            default : ((\Alias : (of : Identity_Identifier::(\Tuple:{}),))),
        )),

*TODO.  Also possibly use something other than Identity_Identifier as payload.*

## Function

        Function : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (
                function ::= args:.\0;

                returns Article function
                    and_then guard function:< = \Function
                    and_then guard when_well_formed_Article;

                traits ::= function:>;

                when_well_formed_Article ::=
                    if traits .:? (\is_type_definer, 0bTRUE) then
                        if traits .:? (\is_generalization, 0bTRUE) then
                            when_generalized_type_definer
                        else if traits.?\constant then
                            when_singleton_type_definer
                        else
                            when_regular_type_definer
                    else
                        when_regular_function;

                when_generalized_type_definer ::=
                    traits is_a (Signature::Tuple_Attrs_Match : (attrs : (
                        is_type_definer : (type : \True::(\Tuple:{}),),
                        is_generalization : (type : \True::(\Tuple:{}),),
                        default : (type : \Expression::(\Tuple:{}), optional : 0bTRUE),
                    ) %+ type_specialization_attrs_template,))
                    and_then type_specialization_attrs_constraint;

                when_singleton_type_definer ::=
                    traits is_a (Signature::Tuple_Attrs_Match : (attrs : (
                        is_type_definer : (type : \True::(\Tuple:{}),),
                        is_generalization : (type : \False::(\Tuple:{}), optional : 0bTRUE),
                        constant : (type : \Expression::(\Tuple:{}),),
                    ) %+ type_specialization_attrs_template,))
                    and_then type_specialization_attrs_constraint;

                when_regular_type_definer ::=
                    traits is_a (Signature::Tuple_Attrs_Match : (attrs : (
                        is_type_definer : (type : \True::(\Tuple:{}),),
                        is_generalization : (type : \False::(\Tuple:{}), optional : 0bTRUE),
                        evaluates : (type : (\Set:[\Expression::(\Tuple:{}), \Signature::(\Tuple:{})]),),
                        default : (type : \Expression::(\Tuple:{}), optional : 0bTRUE),
                    ) %+ type_specialization_attrs_template,))
                    and_then type_specialization_attrs_constraint;

                type_specialization_attrs_template ::=
                    (
                        composes : (type : \Set_of_Identity_Identifier::(\Tuple:{}), optional : 0bTRUE),
                        provides_default_for :
                            (type : \Set_of_Identity_Identifier::(\Tuple:{}), optional : 0bTRUE),
                    );

                type_specialization_attrs_constraint ::=
                    if traits.?\provides_default_for then
                        traits.?\composes
                        and_then guard traits:.\provides_default_for ⊆ traits:.\composes
                    else
                        0bTRUE;

                when_regular_function ::=
                    traits is_a (Signature::Tuple_Attrs_Match : (attrs : (
                        is_type_definer : (type : \False::(\Tuple:{}), optional : 0bTRUE),
                        virtual : (type : \Boolean::(\Tuple:{}), optional : 0bTRUE),
                        commutes : (type : \Identity_Identifier::(\Tuple:{}), optional : 0bTRUE),
                        negates : (type : \Identity_Identifier::(\Tuple:{}), optional : 0bTRUE),
                        returns : (type : \Signature::(\Tuple:{}), optional : 0bTRUE),
                        matches : (type : \Signature::Tuple_Attrs_Match_Simple(\Tuple:{}),
                            optional : 0bTRUE),
                        implements : (\Tuple:{type : ..., optional : 0bTRUE}),
                        overrides : (\Tuple:{type : ..., optional : 0bTRUE}),
                        accepts : (type : \Expression::(\Tuple:{}), optional : 0bTRUE),
                        intends : (type : \Expression::(\Tuple:{}), optional : 0bTRUE),
                        is_associative : (type : \Boolean::(\Tuple:{}), optional : 0bTRUE),
                            `two-way associative`
                        is_commutative : (type : \Boolean::(\Tuple:{}), optional : 0bTRUE),
                        is_idempotent : (type : \Boolean::(\Tuple:{}), optional : 0bTRUE),
                        identity : (type : \Expression::(\Tuple:{}), optional : 0bTRUE),
                            `iff two-sided identity element exists`
                        left_identity : (type : \Expression::(\Tuple:{}), optional : 0bTRUE),
                            `iff only left-identity element exists`
                        right_identity : (type : \Expression::(\Tuple:{}), optional : 0bTRUE),
                            `iff only right-identity element exists`
                        repeater : (\Tuple:{type : ..., optional : 0bTRUE}),
                        evaluates : (type : \Expression::(\Tuple:{}), optional : 0bTRUE),
                    ),));
            ),
            default : ...,
        )),

*TODO.*

*TODO.  Add is_opaque trait, normally just (or possibly reserved for) used
in the Foundation pseudo-package, but that (possibly) may also be used in
other packages to indicate the package interfaces to some host-provided thing
without going through a Foundation-provided wrapper.*

*TODO.  A "singleton type definer" always has a "constant" attribute and optionally has a
"composes" attribute; it is always lacking in the other attributes.
An "interface type definer" always has a 0bTRUE "is_generalization" attribute and
optionally has a "composes" attribute; it is always lacking in the other attributes.
A "selection type definer" always lacks an "is_generalization" attribute
(or has a 0bFALSE one) and always lacks a "constant" attribute; it may have any
of the other attributes.*

*TODO.  Re-add the 'folded' of a 'singleton type definer' into an expression type or such.*

*TODO.  A Function represents a generic expression to be evaluated at a
future date, which also has its own lexical and argument scopes.
Each Expression tree used as the value of an applicable trait of a Function has
its own isolated lexical scope and its own `args` context where generally the
`args` has the same value in every trait of a Function for a call to said.*

## Procedure

        Procedure : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : \Procedure,
                attrs : (Signature::Tuple_Attrs_Match : (attrs : (
                    virtual : (type : \Boolean::(\Tuple:{}), optional : 0bTRUE),
                    matches : (type : \Signature::Tuple_Attrs_Match_Simple(\Tuple:{}), optional : 0bTRUE),
                    implements : (\Tuple:{type : ..., optional : 0bTRUE}),
                    overrides : (\Tuple:{type : ..., optional : 0bTRUE}),
                    accepts : (type : \Expression::(\Tuple:{}), optional : 0bTRUE),
                    intends : (type : \Expression::(\Tuple:{}), optional : 0bTRUE),
                    performs : (type : \Statement::(\Tuple:{}), optional : 0bTRUE),
                ),)),
            )),
            default : ...,
        )),

*TODO.*

## Signature

        Signature::'' : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Set:[
                ::Function_Call_But_0,
                Signature::Conjunction,
                Signature::Disjunction,
                Signature::Tuple_Attrs_Match_Simple,
                Signature::Tuple_Attrs_Match,
                Signature::Article_Match,
            ]),
            default : \Any::(\Tuple:{}),
        )),

*TODO.*

## Signature::Conjunction

        Signature::Conjunction : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[\Array::(\Tuple:{}), \all::( 1: \Signature::(\Tuple:{}) )]),
        )),

*TODO.*

## Signature::Disjunction

        Signature::Disjunction : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[\Set::(\Tuple:{}), \all::( 1: \Signature::(\Tuple:{}) )]),
        )),

*TODO.*

## Signature::Tuple_Attrs_Match_Simple

        Signature::Tuple_Attrs_Match_Simple : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[\Tuple::(\Tuple:{}), \all_attr_assets::( 1: \Signature::(\Tuple:{}) )]),
        )),

*TODO.*

## Signature::Tuple_Attrs_Match

        Signature::Tuple_Attrs_Match : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (
                    attrs : (\Array:[
                        \Tuple::(\Tuple:{}),
                        \all_attr_assets::( 1: \(
                            attr_sig ::= args:.\0;
                            returns
                                attr_sig ⊆$ ::(\Tuple:{type,optional})
                                and
                                (attr_sig.?\type and_then guard Signature attr_sig.\type)
                                and
                                if attr_sig.?\optional
                                    then guard Boolean attr_sig.\optional
                                    else 0bTRUE
                            ;
                        ) )
                    ]),
                ),
            )),
        )),

*TODO.*

## Signature::Article_Match

        Signature::Article_Match : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : \Any::(\Tuple:{}),
                attrs : \Signature::(\Tuple:{}),
            )),
        )),

*TODO.*

## Expression

        Expression : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Set:[
                ::Literal,
                ::Args,
                ::Evaluates,
                ::Array_Selector,
                ::Set_Selector,
                ::Bag_Selector,
                ::Tuple_Selector,
                ::Article_Selector,
                ::If_Then_Else_Expr,
                ::And_Then,
                ::Or_Else,
                ::Given_When_Default_Expr,
                ::Guard,
                ::Factorization,
                ::Expansion,
                ::Vars,
                ::New,
                ::Current,
            ]),
            default : (::Literal : (\Tuple:{0bFALSE})),
        )),

*TODO.  This represents a generic expression to be evaluated at a future date.
Its lexical scope and `args` context is the innermost Function/Procedure (trait) containing it.*

## Literal

        Literal : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (
                    0 : \Any::(\Tuple:{}),
                ),
            )),
            default : (::material : (\Tuple:{0bFALSE})),
        )),

*TODO.  This represents an expression that evaluates to yield the exact
same value as its payload attribute value in the source code.  Typically a
Literal node is the result of constant expression folding which in the
trivial case is just the result of a normal source code literal like `3`.*

*However one can use the Plain_Text `literal` prefix keyword to turn
anything that might be interpreted as a non-literal expression into a
literal expression, in particular nested routine definitions with their
own `args` that one wants to execute "later" rather than "now"; for example
`add_42 ::= literal (\Function : (evaluates : (args:.\0 + 42)))`; without
the `literal` the `args` would be interpreted as the `args` of the routine
containing the `add_42` and not the `args` of the nested routine.*

## Args

        Args : (\Function : (\Tuple:{
            is_type_definer : 0bTRUE,
            constant : ::material,
        })),

*TODO.  This represents an expression that evaluates to the Tuple of
input arguments given to the current call of the Function/Procedure
that this Args node is part of.
Written in Plain_Text with the token `args`.*

## Evaluates

        Evaluates : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (
                    0 : \Expression::(\Tuple:{}),
                ),
            )),
            default : (::material : ...),
        )),

*TODO.  This represents a generic function invocation expression,
where its sole sub-expression names or defines the function to invoke and
also defines the arguments to pass to said function while invoking it,
written in Plain_Text with special syntax example `evaluates X`
where X denotes a Function_Call value.*

*Note: Visual Basic has the 'Nothing' keyword that represents the default
value of the type of the variable it is assigned to.*

## Array_Selector

        Array_Selector : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (
                    0 : (\Array:[\Array::(\Tuple:{}), \all::( 1: (
                        0 : \Expression::(\Tuple:{}),  `member value`
                        1 : \Expression::(\Tuple:{}),  `multiplicity`
                    ) )]),
                ),
            )),
            default : (::material : ((\Array:[]),)),
        )),

*TODO.  This represents a selection of an Array value in terms of a list
of multiplied members; each member value and its given multiplicity comes
from a child expression.  Written in Plain_Text like `(\Array:["hello":3,-5:2])`.
This is intended as a convenient shorthand for a tree of Literal+Evaluates.*

## Set_Selector

        Set_Selector : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (
                    0 : (\Array:[\Bag::(\Tuple:{}), \all::( 1: (
                        0 : \Expression::(\Tuple:{}),  `member value`
                        1 : \Expression::(\Tuple:{}),  `multiplicity`
                    ) )]),
                ),
            )),
            default : (::material : ((\Bag:[]),)),
        )),

*TODO.  This represents a selection of an Set value in terms of a list
of multiplied members; each member value and its given multiplicity comes
from a child expression.  Written in Plain_Text like `(\Set:["hello",-5])`.
While Sets have no duplicate values, Set_Selector has common syntax with
Array_Selector and Bag_Selector in allowing one to specify a multiplicity
to support greater code reuse, including explicitly specifying one vs zero.
This is intended as a convenient shorthand for a tree of Literal+Evaluates.*

## Bag_Selector

        Bag_Selector : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (
                    0 : (\Array:[\Bag::(\Tuple:{}), \all::( 1: (
                        0 : \Expression::(\Tuple:{}),  `member value`
                        1 : \Expression::(\Tuple:{}),  `multiplicity`
                    ) )]),
                ),
            )),
            default : (::material : ((\Bag:[]),)),
        )),

*TODO.  This represents a selection of an Bag value in terms of a list
of multiplied members; each member value and its given multiplicity comes
from a child expression.  Written in Plain_Text like `(\Set:["hello":3,-5:2])`.
This is intended as a convenient shorthand for a tree of Literal+Evaluates.*

## Tuple_Selector

        Tuple_Selector : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (
                    0 : (\Array:[\Tuple::(\Tuple:{}), \all_attr_assets::( 1: \Expression::(\Tuple:{}) )]),
                ),
            )),
            default : (::material : ((\Tuple:{}))),
        )),

*TODO.  This represents a selection of a Tuple value in terms of a list
of attributes; each attribute name is specified directly, each attribute asset comes
from a child expression.  Written in Plain_Text like `(\Tuple:{name:"Jo",age:7})`.
This is intended as a convenient shorthand for a tree of Literal+Evaluates.*

## Article_Selector

        Article_Selector : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (
                    0 : \Expression::(\Tuple:{}),  `label`
                    1 : \Expression::(\Tuple:{}),  `attributes`
                ),
            )),
            default : (::material : ((folder::Literal : (\Tuple:{\''})),
                (folder::Literal : (\Tuple:{})))),
        )),

*TODO.  This represents a selection of a Article value in terms of a
label plus a list of attributes, each of which comes from a child
expression.  Written in Plain_Text like `(\Person:(\Tuple:{name:"Jo",age:7}))`.
This is intended as a convenient shorthand for a tree of Literal+Evaluates.*

## If_Then_Else_Expr

        If_Then_Else_Expr : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (
                    0 : \Expression::(\Tuple:{}),
                    1 : \Expression::(\Tuple:{}),
                    2 : \Expression::(\Tuple:{}),
                ),
            )),
            default : (::material : ((::Literal : (\Tuple:{0bFALSE})),
                (::Literal : (\Tuple:{0bFALSE})), (::Literal : (\Tuple:{0bFALSE})))),
        )),

*TODO.  This represents an if-then-else expression,
written in Plain_Text with special syntax example `if P then X else Y`.*

## And_Then

        And_Then : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (
                    0 : \Expression::(\Tuple:{}),
                    1 : \Expression::(\Tuple:{}),
                ),
            )),
            default : (::material : ((::Literal : (\Tuple:{0bFALSE})),
                (::Literal : (\Tuple:{0bFALSE})))),
        )),

*TODO.  This represents an and-then expression,
written in Plain_Text with special syntax example `P and_then X`.*

*Note: Visual Basic has "AndAlso" operator that does the same thing.*

## Or_Else

        Or_Else : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (
                    0 : \Expression::(\Tuple:{}),
                    1 : \Expression::(\Tuple:{}),
                ),
            )),
            default : (::material : ((::Literal : (\Tuple:{0bFALSE})),
                (::Literal : (\Tuple:{0bFALSE})))),
        )),

*TODO.  This represents an or-else expression,
written in Plain_Text with special syntax example `P or_else X`.*

*Note: Visual Basic has "OrElse" operator that does the same thing.*

## Given_When_Default_Expr

        Given_When_Default_Expr : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (
                    0 : \Expression::(\Tuple:{}),
                    1 : (\Array:[\Set::(\Tuple:{}), \all::( 1: (
                        0 : \Expression::(\Tuple:{}),
                        1 : \Expression::(\Tuple:{}),
                    ) )]),
                    2 : \Expression::(\Tuple:{}),
                ),
            )),
            default : (::material : ((::Literal : (\Tuple:{0bFALSE})),
                (\Set:[]), (::Literal : (\Tuple:{0bFALSE})))),
        )),

*TODO.  This represents a given-when-default expression,
written in Plain_Text with special syntax example
`given X when A then B when C then D default Y`.*

## Guard

        Guard : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (
                    0 : \Expression::(\Tuple:{}),
                ),
            )),
            default : (::material : ((::Literal : (\Tuple:{0bFALSE})),)),
        )),

*TODO.  This represents a guard expression,
written in Plain_Text with special syntax example `guard X`.*

## Factorization

        Factorization : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (
                    factors : (\Array:[\Tuple::(\Tuple:{}), \all_attr_assets::( 1: \Expression::(\Tuple:{}) )]),
                    returns : \Expression::(\Tuple:{}),
                ),
            )),
            default : (::material : (factors : (\Tuple:{}), returns : (::Literal : (\Tuple:{0bFALSE})))),
        )),

TODO.  This represents a compound expression, which consists of a single
"returns" component plus a list of 0..N lexically labelled expression factors,
written in Plain_Text with special syntax example `(x ::= y+3; returns 2*x)`.
When one (less commonly) wants to simply name an expression factor not
conceptually part of a compound expression, the alternate Plain Text syntax
example `foo ::= 42` is shorthand for `(foo ::= 42; returns foo)`.

*TODO.  Consider provision for declaring standalone factors where
procedure statements are allowed, which would normally look a lot like an
assignment statement or be confused for such; in the meantime, procedure
factors may only be declared in sub-expressions of statements though they
can be re-used in other statements.*

## Expansion

        Expansion : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (
                    factor : \Attr_Name::(\Tuple:{}),
                ),
            )),
            default : (::material : (\Tuple:{factor : \''})),
        )),

*TODO.  This represents a logical expansion of an expression factor at this
spot that was previously declared within a Factorization, written in Plain_Text
as an unqualified alphanumeric or quoted identifier example `foo`.
Note that it is an error for a factor to contain any Expansion referring
to itself, either directly or indirectly (except via a routine call).*

## Vars

        Vars : (\Function : (\Tuple:{
            is_type_definer : 0bTRUE,
            constant : ::material,
        })),

*TODO.  This represents a procedure expression that evaluates to a
Variable whose current value is a Tuple whose attributes are intended to be
used as procedure body lexical variables.  Written in Plain_Text with the
token `vars`.  On entry to a procedure call a new Variable is created for
"vars" and given the nullary Tuple as its initial current value; this
Variable is usually destroyed when that procedure exits, unless some other
Variable has been made to reference it directly or indirectly meanwhile.*

## New

        New : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (
                    0 : \Expression::(\Tuple:{}),
                )
            )),
            default : (::material : ((::Literal : (\Tuple:{0bFALSE})),)),
        )),

*TODO.  This represents a procedure expression that evaluates to a newly
created "Variable" whose initial current value is given by evaluating its
sub-expression.  Written in Plain_Text with syntax example `new foo`.*

## Current

        Current : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (
                    0 : \Expression::(\Tuple:{}),
                ),
            )),
            default : (::material : ((::New : ((::Literal : (\Tuple:{0bFALSE})),)),)),
        )),

TODO.  This represents a procedure expression that evaluates to the
"current value" of the "Variable" that its sub-expression evaluates to.
Written in Plain_Text with syntax example `current bar` or `bar:&`.
Note that `Current` is designed to mirror `New`, so the identity
`x = (new x):& = current new x` should hold for any value of `x`.

## Statement

        Statement : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Set:[
                ::Declare,
                ::Performs,
                ::If_Then_Else_Stmt,
                ::Given_When_Default_Stmt,
                ::Block,
                ::Leave,
                ::Iterate,
            ]),
            default : (::Block : ((\Array:[]),)),
        )),

*TODO.  This represents a generic statement to be performed at a future date.
Its lexical scope and `args` context is the innermost Procedure (trait) containing it.*

## Declare

        Declare : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (
                    vars : (\Array:[\Tuple::(\Tuple:{}), \all_attr_assets::( 1: \Expression::(\Tuple:{}) )]),
                ),
            )),
            default : (::material : (vars : (\Tuple:{}),)),
        )),

TODO.  This represents a procedure body statement that declares 0..N
lexically labelled expression factors, each of which is intended to be a
convenient shorthand for referring to a procedure body lexical variable.
To be specific, using Plain\_Text syntax examples, the statement
`declare (foo:42, bar:"Hello", baz:(\Set:[]))` is strictly a shorthand for
`vars := vars:& %+ (foo ::= vars:&.\foo; bar ::= vars:&.\bar; baz ::= vars:&.\baz;
returns (foo : new 42, bar : new "Hello", baz : new (\Set:[])))`.
Or, the parens may be omitted for singles, for example `declare foo:42`.
Note that in theory the fact this is a shorthand means that `declare` might
best just exist as a Plain\_Text feature and be rendered in its longhand
at this core data types level; on the other hand we have types for And\_Then
plus Or\_Else and justified keeping them; its a similar situation.

## Performs

        Performs : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (
                    0 : \Expression::(\Tuple:{}),
                ),
            )),
            default : (::material : ...),
        )),

*TODO.  This represents a generic procedure invocation statement,
where its sole sub-expression names or defines the procedure to invoke and
also defines the arguments to pass to said procedure while invoking it,
written in Plain_Text with special syntax example `performs X`
where X denotes a Procedure_Call value.*

## If_Then_Else_Stmt

        If_Then_Else_Stmt : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (
                    0 : \Expression::(\Tuple:{}),
                    1 : \Statement::(\Tuple:{}),
                    2 : \Statement::(\Tuple:{}),
                ),
            )),
            default : (::material : ((::Literal : (\Tuple:{0bFALSE})),
                (::Block : ((\Array:[]),)), (::Block : ((\Array:[]),)))),
        )),

*TODO.  This represents an if-then-else statement,
written in Plain_Text with special syntax example `if P then X else Y`.
Note that a plain if-then statement is shorthand for this, in which case
the 'else' is an empty compound statement.*

## Given_When_Default_Stmt

        Given_When_Default_Stmt : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (
                    0 : \Expression::(\Tuple:{}),
                    1 : (\Array:[\Set::(\Tuple:{}), \all::( 1: (
                        0 : \Expression::(\Tuple:{}),
                        1 : \Statement::(\Tuple:{}),
                    ) )]),
                    2 : \Statement::(\Tuple:{}),
                ),
            )),
            default : (::material : ((::Literal : (\Tuple:{0bFALSE})),
                (\Set:[]), (::Block : ((\Array:[]),)))),
        )),

*TODO.  This represents a given-when-default statement,
written in Plain_Text with special syntax example
`given X when A then B when C then D default Y`.*

## Block

        Block : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (Signature::Tuple_Attrs_Match : (attrs : (
                    0 : (type : (\Array:[\Array::(\Tuple:{}), \all::( 1: \Statement::(\Tuple:{}) )])),
                    label : (type : \Attr_Name::(\Tuple:{}), optional : 0bTRUE),
                ),)),
            )),
            default : (::material : ((\Array:[]),)),
        )),

*TODO.  This represents an optionally labelled statement block, which
consists of an ordered list of 0..N statements, which optionally may be
iterated, written in Plain_Text with special syntax example
`(\Array:[declare x: 42; print(x:&);])` or `do_work block (\Array:[foo(\Tuple:{}); bar(\Tuple:{});])`.*

## Leave

        Leave : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (Signature::Tuple_Attrs_Match : (attrs : (
                    label : (type : \Attr_Name::(\Tuple:{}), optional : 0bTRUE),
                ),)),
            )),
            default : (::material : (\Tuple:{})),
        )),

*TODO.  This represents an instruction to abnormally exit the statement
block defined by a specified parent Block node (a normal exit is to simply
execute to the end of the statement block); if an explicit label is given,
the ancestor Block with that label is the one abnormally exited, and
otherwise the most immediate parent Block is the one; written in Plain_Text
with special syntax examples `leave` or `leave do_work`.*

## Iterate

        Iterate : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (Signature::Tuple_Attrs_Match : (attrs : (
                    label : (type : \Attr_Name::(\Tuple:{}), optional : 0bTRUE),
                ),)),
            )),
            default : (::material : (\Tuple:{})),
        )),

*TODO.  This represents an instruction to immediately exit, and then
continue execution at the start of, the statement block defined by a
specified parent Block node; if an explicit label is given, the ancestor
Block with that label is the one iterated, and otherwise the most immediate
parent Block is the one; written in Plain_Text
with special syntax examples `iterate` or `iterate do_work`.*

## Heading

        Heading : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[\Tuple::(\Tuple:{}), \all_attr_assets::( 1: \True::(\Tuple:{}) )]),
        )),

*TODO.*

*TODO.  For the likes of all_attrs etc consider making args:.\0 a unary tuple
instead whereupon keywords analagous to name/asset are used, if we had such
a thing for opening tuples as for creating them.*

## Attr_Name

        Attr_Name : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[\Heading::(\Tuple:{}), \is_unary::(\Tuple:{})]),
        )),

*TODO.*

## Nesting

        Nesting : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[\Array::(\Tuple:{}), \all::( 1: \Attr_Name::(\Tuple:{}) )]),
        )),

*TODO.*

## Local_Name

        Local_Name : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[\Nesting::(\Tuple:{}), \not_empty::(\Tuple:{}), \(
                given args:.\0.0
                    when \foundation then #args:.\0 = 2
                    when \used       then #args:.\0 ≥ 2  `elem 2 is pkg local alias`
                    when \package    then #args:.\0 ≥ 1
                    when \folder     then #args:.\0 ≥ 1
                    when \material   then #args:.\0 = 1
                    when \floating   then #args:.\0 ≥ 2
                    default 0bFALSE
            )]),
            default : (\Array:[\foundation, ...]),
        )),

*TODO.*

## Absolute_Name

        Absolute_Name : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Local_Name args:.\0 and_then guard
                args:.\0.0 ⊆$ ::(\Tuple:{foundation,used,package})),
        )),

*TODO.*

## Routine_Call

        Routine_Call : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Signature::Article_Match : (
                label : ::material,
                attrs : (
                    call : (\Set:[\Local_Name::(\Tuple:{}), \Identity_Identifier::(\Tuple:{}), \Function::(\Tuple:{}), \Procedure::(\Tuple:{})]),
                    args : \Tuple::(\Tuple:{}),
                ),
            )),
            default : \foundation::0bFALSE(\Tuple:{}),
        )),

*TODO.  This represents a specification of a function or procedure invocation,
and names or defines the function or procedure to invoke and
also defines the arguments to pass to said function or procedure while invoking it,
written in Plain_Text with special syntax example `\foo::(\Tuple:{})` or `\(...)` or `\[...]`.*

*TODO.  See also and update the documentation or bodies of Homogeneous or
Unionable or etc other operators to more explicitly take/use Routine_Call
where they have better knowledge of its structure now that its more nailed
down than before.*

*TODO.  Consider whether Routine_Call needs to be stricter eg requiring
Absolute_Name rather than Local_Name, or whether or not it needs any extra
attributes for caller context.  But to avoid over-engineering, don't worry
about those / assume they are not needed here, until such time we actually
are trying to make the code execute.  Users shouldn't have to be writing
such manually anyhow, the runtime environment should fill them in as needed.*

## Function_Call

        Function_Call : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[
                \Routine_Call::(\Tuple:{}),
                \(args:.\0:>.\asset:.\call is_a (\Set:[\Local_Name::(\Tuple:{}), \Identity_Identifier::(\Tuple:{}), \Function::(\Tuple:{})])),
            ]),
            default : \(0bFALSE),
        )),

*TODO.  This represents a specification of a function invocation,
and names or defines the function to invoke and
also defines the arguments to pass to said function while invoking it,
written in Plain_Text with special syntax example `\foo::(\Tuple:{})` or `\(...)`.*

## Function_Call_But_0

        Function_Call_But_0 : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Function_Call args:.\0 and_then guard
                args:.\0.\args disjoint_heading \0),
        )),

*TODO.*

## Function_Call_But_0_1

        Function_Call_But_0_1 : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Function_Call args:.\0 and_then guard
                args:.\0.\args disjoint_heading ::(0..1)),
        )),

*TODO.*

## Procedure_Call

        Procedure_Call : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (\Array:[
                \Routine_Call::(\Tuple:{}),
                \(args:.\0:>.\asset:.\call is_a (\Set:[\Local_Name::(\Tuple:{}), \Identity_Identifier::(\Tuple:{}), \Procedure::(\Tuple:{})])),
            ]),
            default : \[],
        )),

*TODO.  This represents a specification of a procedure invocation,
and names or defines the procedure to invoke and
also defines the arguments to pass to said procedure while invoking it,
written in Plain_Text with special syntax example `\foo::(\Tuple:{})` or `\[...]`.*

## Key_Asset_Pair

        Key_Asset_Pair : (\Function : (
            is_type_definer : 0bTRUE,
            evaluates : (Tuple args:.\0 and_then guard
                $args:.\0 = ::(\Tuple:{key,asset})),
        )),

*TODO.  Note, this type currently isn't used anywhere.*

## with_args

        with_args : (\Function : (
            returns : ::Routine_Call,
            matches : (\Tuple:{::Routine_Call, ::Tuple}),
            evaluates : (::Routine_Call : (\Tuple:{
                call : args:.\0:>.\call,
                args : args:.\0:>.\args %+ args:.\1,
            })),
        )),

        '<--' : (\Alias : (\Tuple:{ of : ::with_args })),

*TODO.  This adds to the list of arguments for routine call.  It is
functionally equivalent to "priming" or "partial function application".
A Raku corresponding operator has the name "assuming".*

## priming

        priming : (\Function : (\Tuple:{
            commutes : ::assuming,
        })),

        '-->' : (\Alias : (\Tuple:{ of : ::priming })),

*TODO.  This also adds to the list of arguments for a routine call.*

## Signature_to_Function_Call_But_0

        Signature_to_Function_Call_But_0 : (\Function : (
            returns : ::Function_Call_But_0,
            matches : (\Tuple:{::Signature}),
            evaluates : (
                sig ::= args:.\0;
                returns
                    if Function_Call_But_0 sig then
                        sig
                    else if Signature::Conjunction sig then guard
                        \(
                            topic    ::= args:.\0;
                            conj_sig ::= args:.\sig;
                            returns empty::(conj_sig)
                                or_else guard topic is_a first::(conj_sig)
                                and_then guard topic is_a nonfirst::(conj_sig)
                        ) <-- (\Tuple:{:sig})
                    else if Signature::Disjunction sig then guard
                        \(
                            topic    ::= args:.\0;
                            disj_sig ::= args:.\sig;
                            returns disj_sig any \(args:.\topic is_a args:.\0) <-- (\Tuple:{:topic})
                        ) <-- (\Tuple:{:sig})
                    else if Signature::Tuple_Attrs_Match_Simple sig then guard
                        \(
                            topic     ::= args:.\0;
                            tuple_sig ::= args:.\sig;
                            returns Tuple topic
                                and_then guard topic =$ tuple_sig
                                and_then guard
                                    tuple_sig all_attrs \(
                                        name     ::= args:.\0:.\name;
                                        attr_sig ::= args:.\0:.\asset;
                                        topic    ::= args:.\topic;
                                        returns topic.name is_a attr_sig;
                                    ) <-- (\Tuple:{:topic})
                        ) <-- (\Tuple:{:sig})
                    else if Signature::Tuple_Attrs_Match sig then guard
                        \(
                            topic     ::= args:.\0;
                            tuple_sig ::= args:.\sig;
                            attrs_sig ::= tuple_sig:>.\attrs;
                            returns Tuple topic
                                and_then guard
                                    topic ⊆$ attrs_sig
                                    and
                                    (attrs_sig all_attrs \(
                                        name     ::= args:.\0:.\name;
                                        attr_sig ::= args:.\0:.\asset;
                                        topic    ::= args:.\topic;
                                        returns if topic.?name
                                            then guard topic.name is_a attr_sig
                                            else attr_sig.?\optional
                                        ;
                                    ) <-- (\Tuple:{:topic}))
                        ) <-- (\Tuple:{:sig})
                    else if Signature::Article_Match sig then guard
                        \(
                            topic       ::= args:.\0;
                            article_sig ::= args:.\sig:>;
                            returns Article topic
                                and_then guard topic:< = article_sig:.\label
                                and_then guard topic:> is_a article_sig:.\attrs
                        ) <-- (\Tuple:{:sig})
                    else
                        fail  `We should never get here.`
                    ;
            ),
        )),

*TODO.  Also double-check that all_attrs etc are not infinite-recursing
by way of this function.  Also make sure Foundation implementations can
recognize and short-circuit the simple boolean signatures.*

*WARNING/TODO.  Actually, now that regular types are largely defined in
terms of Signature, it is very likely we would have infinite recursion at
runtime due to for example any code asking "is this a Signature::foo" which
includes Signature_to_Function_Call_But_0 would be calling
Signature_to_Function_Call_But_0 in order to answer that question, at least
until something is changed that the compiler folds the type definitions to
no longer use Signature_to_Function_Call_But_0.*

# SOURCE CODE ANNOTATION DATA TYPES

*TODO.*

## Annotation

        Annotation::'' : (\Function : (\Tuple:{
            is_type_definer : 0bTRUE,
            is_generalization : 0bTRUE,
        })),

*TODO.*

*Annotations can include what otherwise would be a separate special table
for higher level DBMS mappers such as Entity Framework or DBIx::Class to
track their own metadata within a database, such as an easy way to tell if
the database schema version matches what the application expects.*

# SOURCE CODE DECORATION DATA TYPES

*TODO.  Generally speaking, all Decoraction types are declared by a
package that is not System, such as in some System::Plain_Text/etc package.*

*TODO:  The decoration data types may loosely resemble template defs so
that decorations don't necessarily have to be attached to all
behavioural/annotation nodes they are conceptually adjacent / apply to but
rather can be in some nearby parent context and refer to behavioural/etc
nodes by name.*

*When representing extra info used by eg EF/DBIC, that should be split
between Annotation and Decoration depending on whether it affects behaviour
in any way / would cause a problem if missing, or if it is purely cosmetic
and would not cause a problem if missing.*

## Decoration

        Decoration::'' : (\Function : (\Tuple:{
            is_type_definer : 0bTRUE,
            is_generalization : 0bTRUE,
        })),

*TODO.*

[RETURN](#TOP)

<a name="AUTHOR"></a>

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

[RETURN](#TOP)

<a name="LICENSE-AND-COPYRIGHT"></a>

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Data Language** (**MDL**).

MDL is Copyright © 2002-2024, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Overview](Muldis_Data_Language.md) for details.
