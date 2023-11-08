# NAME

Muldis::D::Foundation - Muldis D fundamental architecture, behaviour, and type system

# VERSION

This document is Muldis::D::Foundation version 0.300.0.

# DESCRIPTION

This document is the human readable authoritative formal specification of
the **Muldis D Foundation** (**MDF**) primary component of the **Muldis D**
language.  The fully-qualified name of this document and the specification
it contains is `Muldis_D_Foundation https://muldis.com 0.300.0`.

See also [Muldis_Data_Language](Muldis_Data_Language.md) to read the **Muldis D** language meta-specification.

The **Muldis D Foundation** specification defines the fundamental
architecture, behaviour, and type system of Muldis D.  For all intents and
purposes, it is the entire official Muldis D language specification except
for any candidate syntaxes and any candidate standard libraries.  So it is
generally useful to read this specification first and consider any others
subservient to it.  While many alternative syntaxes and standard libraries
are likely and expected to exist in a combination called **Muldis D**,
substituting out **Muldis D Foundation** for something with a large degree
of changes would likely yield a combination that is best to name something
other than **Muldis D**.  **Muldis D Foundation** defines the *native* form
of Muldis D source code, which is homoiconic data structures composed
largely in terms of function calls, and is expressly agnostic to any
concrete language syntax.  It defines the user-facing behaviour/API of the
small number of foundational / low-level system-defined types and
operators and other features which are canonically written in one or more
third-party languages which are *hosting* Muldis D; formally their
implementation or internals are expected to be hidden from the Muldis D
user, and differ in arbitrarily large ways between hosts, so to take
advantage of the strengths of each host.

*TODO, overhaul/refactor this document.*

# OVERVIEW

Muldis D is an industrial-strength computationally complete high-level
application programming language with fully integrated database
functionality; you can use it to define, query, and update ("object")
relational databases, as well as write general purpose applications.  The
language's paradigm is a mixture of declarative, homoiconic, functional,
imperative, and object-oriented.  It is primarily focused on providing
reliability, consistency, portability, and ease of use and extension.  The
language should also lend itself to making fast implementations.

Muldis D provides an effective means to reduce or avoid entirely the
problem of "object-relational impedance mismatch".  The main way that it
deals with that problem is that it natively supports user-defined types at
the database level, which can be arbitrarily complex such as to support
collection values as attribute values.  And so users can effectively use
their same type definitions in both the databases and in their
applications, with no non-trivial mapping required. This is in contrast
with typical database ORM tools which only remap application objects into
simpler built-in database types like plain numbers and strings.

The syntax and feature set of Muldis D is like that of a general purpose
programming language, and so shouldn't be too difficult to learn.  Multiple
other languages influence its design in various ways, not just SQL but also
a variety of general purpose application languages, such as Raku.

In contrast to a typical SQL DBMS which uses multiple programming languages
together, where SQL is used for queries and something else (possibly
SQL-alike) for defining stored procedures, a Muldis D DBMS would use the
same Muldis D language to assume both roles.

Muldis D is rigorously defined and requires users to be explicit, which
leaves little room for ambiguity and related bugs.  When something is
specified in Muldis D, its semantics should be well known and fully
portable (not implementation dependent).  If a conforming implementation
(such as Muldis::D::Ref_Eng) can't provide a specified
behaviour, code using it will refuse to run at all, rather than silently
changing its semantics; this also helps users to avoid bugs.  Moreover,
Muldis D generally disallows any details of an implementation's "physical
representation" or other internals to leak through into the language; eg,
there is no "varchar" vs "char", simply "text".  Users should not have to
know about this level of detail, and implementers should be free to
adaptively pick optimum ways to satisfy user requests, and change later.

Muldis D, being first and foremost a data processing language, provides a
thorough means to both introspect and define all entities using just data
processing operators.  In general purpose languages an analogous concept is
*reflection* and in SQL it is the *system catalog*.

The design and various features of Muldis D go a long way to help both its
users and implementers alike.  A lot of flexibility is afforded to
implementers of the language to be adaptive to changing constraints of
their environment and deliver efficient solutions.  This also makes things
a lot easier for users of the language because they can focus on the
meaning of their data rather than worrying about implementation details;
users can focus on defining what needs to be accomplished rather than how
to accomplish that, which relieves burdens on their creativity, and saves
them time.

Muldis D is designed such that, to nearly the maximum degree possible, the
built-in language syntax is expressed just in terms of generic-syntax
routine invocations, meaning that wherever possible the language features
are defined in terms of being just routines.  This allows the fundamental
Muldis D grammar to be as simple as possible and it empowers users to
define additional features that can mimic nearly any built-in ones in both
functionality and syntax.  There are only a few exceptions to this rule,
where doing so has a large net benefit to the language design.

Muldis D is intended to qualify as a "**D**" language as defined by
"*Databases, Types, and The Relational Model: The Third Manifesto*"
(*TTM*), a formal proposal for a solid foundation for data and database
management systems, written by Chris Date (C.J. Date) and Hugh Darwen.  See
<http://thethirdmanifesto.com> and its "Documents and Books" section for
that book, and the website also has other resources explaining what *TTM*
is, and has copies of some documents that were used in writing Muldis D.

It should be noted that Muldis D, being quite new, may omit some features
that are mandatory for a "**D**" language initially, to speed the way to a
useable partial solution, but any omissions will be corrected later.  Also,
it contains some features that go beyond the scope of a "**D**" language, so
Muldis D is technically a "**D** plus extra"; examples of this are
constructs for creating the databases themselves and managing connections
to them.

Muldis D also incorporates design aspects and constructs that are taken
from or influenced by a wide variety of other general-purpose languages,
such as Raku, functional languages in particular, and various
DBMS languages, including SQL and other **D** languages.  At some
point a section will be added that lists the various influences as well as
similarities with other languages, whether by influence or by coincidence.

In any event, the Muldis D documentation will be focusing mainly on how
Muldis D itself works, and will spend little time in providing rationale;
you can read the aforementioned external documentation for much of that.

# FUNDAMENTAL CONCEPTS

The most fundamental concepts of Muldis D are *values*, *variables*,
*functions*, and *procedures*.

All other Muldis D concepts relate directly to or are defined in terms of
those 4, including *types*, *type definers*, *packages*,
*databases*, *expressions*, *statements*, and so on.

## value

A *value* is an individual constant that is not fixed in time or space.
Every value is unique, eternal, and immutable; it has no address and can
not be updated.  It does not make sense to say that you are creating or
destroying or copying or mutating a *value*, but it does make sense to say
you are *selecting* one.  So when one appears to be testing 2 values for
equality, they are actually testing whether 2 value appearances are in fact
the same value.  Every conceivable distinct concept can be represented by a
value, whether it is a simple number or an arbitrarily complex collection.
For every value there exists at least one *selector* by means of which
that value may manifest within a program; each selector takes the form of
either a function or a value literal syntax.  A value's fundamental
identity is itself, and does not vary with any labels applied to it.

## variable

A *variable* is a container for an appearance of a value.  It is neither
unique nor eternal nor immutable in the typical case; it does have an
address and in the typical case can be updated, meaning that over time a
variable may hold appearances of different values.  A variable can be
created, destroyed, copied, and mutated.  A variable's fundamental identity
is its address, its identity does not vary with what value appears there
nor with any labels applied to its address.

## function

A *function* is a set of instructions for mapping a set of input *source*
values, its *domain*, to a set of output *result* values, its
*codomain*, in a pure and deterministic manner.  The result value of a
function call is determined entirely by its source value, and a function is
guaranteed to give exactly the same single result value for every call with
the same source value.  A *function* is more constrained than a
mathematical function (that it otherwise resembles) such that its *source*
may only be a *tuple* (a value of the `Tuple` type) and not some other
value.  This is for the purpose of avoiding unnecessary complications.

## procedure

A *procedure* is a set of instructions for either enacting possibly
non-deterministic change over time in a set of variables or for reading
from or writing to the external environment of the application, including
its users or various external systems.

# ENVIRONMENT

The Muldis D DBMS / virtual machine, which by definition is the environment
in which Muldis D executes, conceptually resembles a hardware PC, having
command processors (CPUs), standard user input and output channels,
persistent read-only memory (ROM), volatile read-write memory (RAM), and
persistent read-write disk or network storage.

The virtual machine effectively has multiple concurrent processes, where
each process effectively handles just one (possibly complex) command at a
time (a command being realized as a "statement"), and executes each
separately and in the order received; any results or side-effects of each
command provide a context for the next command, both in the current process
and, where applicable, in other processes.

The normal context of a command is a single process.  Within a process is
where a routine call chain exists, where statements execute, where program
variables exist, where the scope of "atomic" operations and transactions
lie, and so on.  However, some commands could cause other processes to
start or end, and some could send messages to or receive messages from
other processes, either individuals or groups of processes.  When a Muldis
D virtual machine first starts up, there is an initial root process which
in turn starts any others and which is the last to end on shutdown.  Each
concurrent user connection or autonomous transaction is represented by its
own process.

# FUNCTIONS

A *function* (also known as a *read-only operator*) is a set of
instructions for mapping a set of input *source* values, its *domain*, to a set of
output *result* values, its *codomain*, in a pure and deterministic manner.

A Muldis D function is isomorphic to a mathematical function.  A function
call/invocation takes exactly 1 input *source* value and gives exactly 1
output *result* value.  The result value of a function call is determined
entirely by its source value, and a function is guaranteed to give exactly
the same single result value for every call with the same source value.
Multiple distinct sources may yield the same result, but multiple calls with
the same source never give different results.

A Muldis D *function* is more constrained than a mathematical function such
that its input *source* may only be a *tuple* (a value of the
`Tuple` type) and not some other value.  This is for the purpose of
avoiding unnecessary complication for the design and users of the language.
Each (distinctly named) member *attribute* of the *source* is an input
*argument* to the function, and a function may thus take anywhere from
zero to N arguments.  In contrast to this, there are no restrictions on
what the type of a Muldis D *result* may be; some functions might result
in a tuple as the idiomatic way to give multiple outputs, but those are
likely rare compared to those that don't.  An example with multiple inputs
and outputs is the common whole division operation; it takes a dividend
plus a divisor and gives a quotient plus a remainder.

Note that for brevity the Muldis D language specifications will refer to
arguments with the same `foo` syntax regardless of whether they
are conceptually positional or named, examples being `0` and `1` for the
former and `like` or `body` for the latter.  However, while the latter are
equivalent to the text characters they look like, the former are officially
equivalent to the Unicode code point numbers they look like, rather than the
digit characters they look like; so `0` is `"\c<0>"` and not `"0"`.

A Muldis D function is composed fundamentally of one or more arbitrarily
complex value expressions, and the former is essentially just a wrapper for
the latter.  Complementary to this, a function can only be invoked as part
of a value expression, such that its result value is the value of the
expression, and similarly, the function call's source must be
defined by a value expression.  The ultimate roots of value expression call
chains are typically procedure statements.

A Muldis D *predicate function* is a function whose *result* is always a
*boolean* (a value of the `Boolean` type) and which has exactly 1
*argument* that is positional (its name is `0`).  A predicate function
considers its argument and results in either *true* or *false*.

A function has no lexical variables at all, although they can be faked for
code factoring purposes by giving explicit names to its component
sub-expressions, the current value for each of which is defined/set once
within a function call but referenceable multiple times.  Value expressions
are also conceptually lazy and can be gated to only be evaluated
conditionally.
*TODO: Update this with appropriate language-specific terms such as "label" and "embed".*

A function call, like any value expression evaluation in general, is an
implicitly atomic operation.  From the perspective of Muldis D code or its
users, there is no discrete instant within its host process at which a
function/expression has partially evaluated or that any involved variables
are in a partly-changed state; at one instant there is the system state
just prior to the outermost function/expression of the call chain being
evaluated, and at the subsequent instant that outermost has terminated.

A function can not read from any dynamic portion of the wider environment
such as program variables or user input or disk or network or a system
clock or a system number generator; a function can not see anything that
could possibly make its results differ between calls, with the sole
exception of its arguments.

That being said, a function call *is* allowed to have some kinds of
side-effects in the form of writing messages to side channels, such as for
purposes of auditing activity or debugging or providing runtime
optimization hints; such activities are write-only to functions, so their
use doesn't make the function non-deterministic with its result, and no
determinism is guaranteed with side channel messages.

Normal function termination is to give a result, but one may instead
terminate abnormally by throwing an exception.  While exceptions may be
thrown due to bad arguments, such as an attempt to divide by zero,
potentially any function may throw an exception non-deterministically due
to environmental conditions at the time, such as due to a lack of
sufficient system memory.  A function or expression may not catch a thrown
exception, so one will unwind the call stack up to some invoking procedure.
If one wants to effectively trap failures within a function, then its
expressions or called functions must explicitly return excuse-indicating
values among their possible results, such as IEEE NaN values, rather than
throw exceptions; as far as Muldis D is concerned, all explicit results,
even the likes of NaN, are considered to be normal termination.

It is considered a best practice for a function to indicate failure with
excuse-indicating results wherever reasonably possible, and only throw
exceptions in cases where a function's result alone can't distinguish a
successful execution from a non-successful one.  An example where an
exception is preferred is on failure to fetch an element from a collection,
where an excuse-indicating value might be a valid collection element.  In
contrast, a mathematical function that always results in a number on
success should only throw an exception for a non-deterministic failure such
as memory exhaustion, and should return an excuse-indiciating value for a
deterministic failure such as dividing by zero.

*TODO: Other related notes.  Especially the parts of a function definition.*

# TYPES AND TYPE DEFINERS

Muldis D has a formal type system, at least in intent, which works
conceptually in the following manner.

A *type* aka *data type* is characterized by an unordered set (or just
*set*) of values, nothing more and nothing less.  A type's fundamental
identity is the set of values that characterizes it, and that identity does
not vary with any labels applied to that set.  If and only if 2 sets of
values are the same unordered set, they characterize the same type.
Analogous to how values are conceived, every type is unique, eternal,
immutable, has no address and can not be updated.  Types are not values and
values are not types, and this is despite the fact that some values (such
as relations) are also characterized by unordered sets of other values.

A *type* is also characterized by a *type definer* which is a *predicate
function* that takes any value at all as its sole argument and results in
`True` iff that argument is a member of the set characterizing that type
and `False` otherwise.  Given 2 *type definer* functions *F1* and *F2*,
if and only if for every possible value *V*, an invocation of *F1* with
*V* as its argument gives the exact same result as an invocation of *F2*
with *V* as its argument, *F1* and *F2* both characterize the same
*type*, even if any part of the source code for *F1* and *F2* differs.

## Type Relationships

The *universal type* is the only type that consists of all values which
can possibly exist, and is an infinite set; it is the maximal data type of
the entire type system.  The *empty type* is the only type that consists
of exactly zero values, and is the empty set; it is the minimal data type.
Every other type has at least 1 value and lacks at least 1 value.

Take 2 arbitrary but not necessarily distinct data types, *T1* and *T2*.
Iff the value set of *T1* is a superset of that of *T2*, then *T1* is a
*supertype* of *T2*, and *T2* is a *subtype* of *T1*.  If additionally
the 2 types are mutually distinct, meaning *T1* has at least 1 value that
*T2* lacks, then *T1* is additionally a *proper supertype* of *T2*, and
*T2* is additionally a *proper subtype* of *T1*.  Given those last
examples, *T1* is a *more general* type, and *T2* is a *more specific*
type.  In this way, the *universal type* is a proper supertype of all
other types, and the *empty type* is a proper subtype of all other types.

Iff 2 data types have no values in common, they are said to be *disjoint*.
Iff 2 data types have any values in common, they are said to be *conjoined*.
Iff a data type *T1* has all of the values of two data types *T2* and
*T3*, and *T1* has no values that are not also members of *T2* or *T3*,
then *T1* is a *union type* with respect to *T2* and *T3*.  Iff instead
*T1* has only but all of the values that *T2* and *T3* have in common,
then *T1* is an *intersection type* with respect to *T2* and *T3*.  Iff
2 data types, *T1* and *T2*, are disjoint, and every value of a third
data type *T3* is a member of one of them, and every value of *T1* and
*T2* is a member of *T3*, then *T1* and *T2* are
*complementary types* with respect to *T3*.  In this way, the *universal
type* is a union type of all other types, and the *empty type* is the
intersection of all others; the two are both disjoint and complementary.
A *singleton type* or *singleton* is a type that consists of exactly 1 value.

Subtyping in Muldis D, as in any **D** language, fundamentally takes the
form of *specialization by constraint*, not *specialization by
extension*.  (A consequence is that every Muldis D function is covariant.)

So conceptually speaking, a plain "circle" value is an "ellipse" value, but
a "coloured circle" is neither a "circle" value nor a "colour" value; the
type "circle" is a subtype of "ellipse", and "coloured circle" is neither a
subtype of "circle" nor of "colour".  Rather, for example, a "coloured
circle" is a multi-component type which has components of type "circle" and
"colour", but composition like this does not a subtype make.  That being
said, the type "coloured circle" is a subtype of "coloured ellipse".

Every Muldis D type is *countable* such that every one of its member
values can be mapped 1:1 with a subset of the set of natural numbers, and
likewise the set of member values can be deterministically arranged in some
total order where every member value can be reached via enumeration in that
order within a finite amount of time.  Moreover, every value of a Muldis D
type can be represented somehow using a finite amount of memory.  This
doesn't exclude the possibility that the representation of any value is
larger than present-day computing hardware can handle, but even if so, it
could be handled by sufficiently larger but finite resources.

Every Muldis D type is exactly 1 of *finite*, *infinite*, *semifinite*.
A *finite type* is a data type whose cardinality (count of member values)
is known to be *finite*, and this cardinality can be deterministically
computed with finite time and memory resources.  An *infinite type* is a
data type whose cardinality is known to be *countably infinite*.
A *semifinite type* is a data type whose cardinality might be either
finite or infinite, because its membership is only partially defined at any
given time, typically because it corresponds to an *interface type definer*.
The universal type is an infinite type and the empty type is a finite type.

Data types in Muldis D are characterized by unordered sets of values, and so
in the general case, it does not make sense to use them in a context that
requires some conception of values being mutually ordered.  However,
potentially any type can externally have ordering algorithms (as defined by
functions) applied to it in particular contexts, and so fake the type being
ordered, in either one or multiple ways.  Moreover, many of the common use
cases here have system-defined functionality to support them.

## Type Definers

*TODO: Rewrite the text of this section.*

A *type definer* is an association with a *data type* of various metadata
which can be applied where that type definer is used.  The most common such
metadata are an explicit name or alias for the type, or a default value
(the latter not valid for the *empty type* nor for any handle type).

Every *type definer* is of exactly 1 of 2 kinds based on how it is declared;
it is either a *selection type definer* or an *interface type definer*; these
two declaration methods are polar opposites of each other.

Each given *selection type definer*, *R1*, explicitly declares for itself
what its associated type / value set is.  The form this takes in the
general case is a set of
(typically exactly one) other type definers' names, *S1*, plus a predicate
expression, *P1*.  The type of *R1* is defined as taking the union of the
types of *S1* as source values and then applying *P1* as a filter; the
type of *R1* consists of just the values for which *P1* results in
*true*.  Having a *S1* is optional; the value source of an *R1* without
a *S1* is implicitly the universal type.  Having a *P1* is also optional;
for an *R1* without a *P1*, its implicit predicate is unconditionally
*true*.  The canonical way to associate an *R1* with the universal type
is to omit both its *S1* and *P1*; the canonical way to associate with
the empty type is to have an explicit empty *S1* and omit *P1*.

A selection type definer associated with a *singleton type* is
idiomatically declared in a different way, by declaring a *singleton type definer* whose
value is the type's only value.  For any context in Muldis D where a
reference to or a definition of a selection type definer is allowed, a
reference to or a definition of a singleton type definer is allowed in its place.  A
given singleton type definer for value *V1* is semantically identical for such uses as a
general form selection type definer with an omitted *S1*, a *P1* that tests
its sole argument for equality with *V1*, and a default value of *V1*.

Each given *interface type definer*, *I1*, explicitly does *not* declare its
associated type.  Instead, *I1* relies on other type definers, *S1*, to
explicitly declare that they *compose* *I1*, and that therefore *I1* is
a type union that includes all of the values of *S1*.

Each given type definer, with the sole exception of one associating with the
empty type or a handle type, must have exactly 1 associated *default value*.  Any
selection type definer, *R1*, may explicitly declare this value for itself;
if *R1* does not do this, then the default value of its immediate sources
is implicitly inherited as its own; if the set of default values of the
direct sources of *R1*, after being filtered by the predicate of *R1*, is
not a singleton, this is an error.  Any interface type definer *I1* must have
exactly 1 composing type definer *S1* that also explicitly declares that it
provides the default value of *I1*; that is, the default value of *S1* is
also the default value of *I1*.  A handle value is never allowed to be
used as a default value for a type, but any non-handle value is allowed to.

Any kind of type definer may compose an *interface type definer*, and so the
latter may be chained, but ultimately each end composer must be a
*selection type definer* as only they can originate default values.  For
example, one may have 2 interface type definers and a selection type definer to
represent, respectively, a general numeric type, a rational numeric type,
and a 64-bit fraction type; these ordered from most general to most specific.

Each interface type definer *I1* declares a set of zero or more virtual
routine (function or procedure) names *N1*.  For each name of *N1* there
must exist a virtual routine *R1* of that name which takes at least 1
conceptual argument *A1* of the type associated with *I1*.  For each
given composing type *S1* of *I1*, for each virtual routine *R1*, there
must exist a (possibly virtual) routine *R2* which explicitly declares
that it *implements* *R1*, where the conceptual argument *A2*
corresponding to *A1* is of the type associated with *S1*.  That is, any
type definer composing an interface type definer must implement the latter's
required interface; failing to do so is an error.

And so, regardless of whether types are manifested in a program by way of a
a selection type definer or an interface type definer, users can be confident
that if some code declares acceptance of a particular supertype, they
should be able to easily predict the manners and circumstances where they
may use all of its subtypes interchangeably, with more general code,
regardless of how the various subtypes are implemented.

Note that a non-virtual routine *R2* defined over subtype *T2* is also
allowed to *implement* a non-virtual routine *R1* defined over supertype
*T1*, in which case *R2* is declaring itself to be a more optimal
implementation for its specific subtype than is the more general
implementation of *R1*.

An interface type definer which declares zero required virtual routines is also
called a *semantic type definer*.  A semantic type definer just exists for
providing a semantic label to the type definers that compose it, and doesn't
otherwise imply anything about their API.  Examples of semantic type definers
are ones that declare a number is either ordinal or cardinal or nominal.
In contrast, an interface type definer which declares at least one required
virtual routine exists mainly to aid generic code reuse, but may optionally
provide a semantic label as well.

The primary determinant for whether you would declare a type definer as a
selection type definer or an interface type definer is whether you want the
type definer's definition to be closed, or open, respectively.  If you use a
selection type definer, then assuming you have control over all the types it
unions (or they are system-defined), you are fairly guaranteed that your
type definer will remain static and continue to contain exactly the same values
indefinitely, or in other words that the type will continue to mean exactly
what you intended no matter what anyone else does with types outside your
control.  If you use an interface type definer, in contrast, you are expressly
empowering others to alter the meaning of that type by adding new values to
it from their own new type definers, and so your type definer is flexible to
accommodate new uses automatically, at the cost that you can't always
assume when you ask for a value of that type that you'll know in advance
all the possible values you might get.  A particularly important use of
interface type definers is doing operator overloading between disjoint types,
which would be considerably more difficult without them.

One might say that Muldis D is using *progressive nominal typing*; or at
least Larry Wall made up that term on the spot in reference to how Muldis D
was perceived to work, <http://irclog.perlgeek.de/perl6/2010-05-06/text>.
Users can choose to select values before or without at all declaring the
types of (that is, type definers for) those values, and not just after; the
values alternately do or don't belong to named types/type definers; values can
often include a declaration of a nominal type in their composition,
regardless of whether such a type/type definer exists at the time.

For any context in Muldis D where a reference to or a definition of a
function is allowed, a reference to or a definition of a type definer is
allowed in its place.  An invocation as if it were a function of a given
type definer for type *T1*, where the invocation has exactly 1 argument whose
name is `0` and whose asset is value *V1*, is semantically identical to
(and is idiomatic for) testing if *V1* is a member of the type *T1*; the
result is *true* if so and *false* otherwise.  An invocation as if it
were a function of a given type definer *C1*, where the invocation has exactly
zero arguments, is semantically identical to (and is idiomatic for)
selecting the *default value* of *C1*.  Likewise, a reference to a
*singleton type definer* is allowed to be invoked as if it were a function, in both of
the same ways that a type definer is allowed to be.  Frequently, it is
appropriate to treat both type definers and constants simply as being special
cases of functions, with zero or 1 arguments, rather than distinct things.

*TODO: Rewrite the text of this section.*

A *singleton type definer* is similar to a *function* but that it takes no arguments at
all (its *source* is the sole nullary/zero-attribute *tuple*) and it
always gives the same result.  A singleton type definer may be invoked anywhere that a
function may be, and a singleton type definer may invoke functions.  The single value a
singleton type definer denotes may be arbitrarily complex, and repeated portions may be
factored under their own names, like in a function.

A primary use of a Muldis D *singleton type definer* is for code factoring, so that
multiple routines or dependent packages may share a common named singleton type definer.

In Muldis D, an additional idiomatic purpose of a *singleton type definer* is to support
representing the current value of any arbitrary database (or data dump) in
the form of Muldis D source code, where it is a named entity in a package.
Such a form allows one to bundle up all the type definitions the database
depends on, or factor repeated database content values, within a common
package, or cite external definition or content dependencies of such, with
all the same flexibility and power as with ordinary source code.  In this
context, all kinds of database updates, both *data definition* and *data
manipulation*, occur using the same basic tools, updating Muldis D package
source-code-as-data, at runtime.

Normally, when Muldis D source code is parsed, the details of its actual
user-written syntax are preserved as data, so that it is possible to
losslessly round trip the source code to a form identical to what the users
wrote.  However, in the case of singleton type definers used to represent a database,
especially one previously created or changed at runtime as ordinary user
data values, there is no benefit to maintaining that syntax meta-data when
parsing such singleton type definers, and it takes up a lot of extra space.  For a given
*singleton type definer*, since the Muldis D parser can never otherwise know for sure of
its source code's origin or purpose, the singleton type definer can explicitly declare
that it is *folded*, in which case the parser can throw away any syntax
meta-data and just store the singleton type definer's result value.  It is idiomatic for
a singleton type definer that is produced with a database dump to be declared *folded*
while a singleton type definer hand-written by a user to not be declared so.

A third idiomatic purpose of a *singleton type definer* is to provide a terse alternate
means to define a selection type definer associated with a singleton type;
as such a reference to a singleton type definer can be used both where a type definer or a
value is expected.

For any context in Muldis D where a reference to or a definition of a
singleton type definer is allowed, a reference to or a definition of a type definer is
allowed in its place.  An invocation as if it were a singleton type definer of a given
type definer is semantically identical to (and is idiomatic for) selecting the
default value of the type definer.

## Type Safety

Muldis D should qualify as a *type-safe* language by many, if not all,
definitions of the term *type-safe*.

The Muldis D type system is used to prevent certain erroneous or
undesirable program behaviour.  Type errors are usually those that result
from attempts to perform an operation on some values that is not
appropriate to their data types; or any contravention of the programmer's
intent (as communicated via type definer annotations) are erroneous and to be
prevented by the system.

Every value is of a type.  Every literal, expression, function result,
routine parameter, type component, and variable has a declared type by way
of a type definer; the system ensures that a variable will only ever hold a
value of its declared type, that a routine parameter will only take an
argument of its declared type, and a function will only ever result in a
value of its declared type.  There are no implicit type conversions, only
explicit type mapping.  For example, it is invalid for a numeric value to
appear where a character string value is expected, or vice-versa, but an
expression or function that explicitly maps a numeric to a string is valid
to use there.  Muldis D follows the *principle of cautious design*.

Muldis D is a hybrid dynamic and static language, and where on the spectrum
it is varies by implementation.  At the very least, all imminent type
errors would be prevented by the system at run time.  But the more
potential type errors are caught at compile time, the better for users.

Fundamentally, Muldis D is a dynamic language, associating type information
with values at run time and consulting them as needed to detect imminent
errors; the system prevents run time imminent type errors by throwing an
exception.  However, it is possible in many cases for Muldis D to be
treated as a static language, where type errors are found and prevented at
compile time, such that the compilation process throws an exception.
Ideally, all type errors would be found at compile time, and more
intelligent compilers will be closer to that goal, but in the general case
it is not possible to go all the way.  In order to increase type error
detection at compile time, a wider scope needs to be analysed than
otherwise; in practice, the widest practical scope is to analyse the entire
*package* that would contain the code being compiled, as well as any other
currently available packages that may use or be used by it.

*TODO: Other related notes.*

Generally speaking, there are two categories of type errors.  The first is
where the system simply can't function in a reasonable or deterministic
manner if they are violated; this is the kind that must always be detected
and prevented by the system.  The second is where the type error is more
just an error concerning the programmer's intent, and this is not fatal by
any means; the system will still produce a reasonable and deterministic
result if those were not treated as errors and be allowed to resume.  An
example of the first is divide by zero with the system standard integer and
rational types.  An example of the second is an identity/equality
comparison between 2 values from variables of different declared types; it
is valid to compare an integer to a character string for equality; the
result would always be false, but it is still logical; however the user
might want the system to detect such occurrences.

Therefore, Muldis D officially defines for now that the latter category is
not fatal and would just generate a warning by default.  Warnings can be
either enabled as warnings, disabled to not display, or be promoted to
fatal errors automatically, using a compile-time option or lexically scoped
pragma or something.

All warnings are issued at compile-time only, which includes any time when
a package is being registered.

Generally speaking, a Muldis D implementation can not expect at run time to
remember matters related to declared types of contexts that values are
coming from.  Rather, only the most specific type of the value itself can
be known or computable at runtime in order to enforce say the constraint
from the declared type of a variable it is being assigned to.  However, the
declared type of a variable used as an argument to a subject-to-update
parameter *would* be known at runtime, if it is more specific than the
declared type of the parameter.

The declared type of an operator argument's origin generally can not be
seen or used by a logical decision in the routine, so for example, if a
generic operator is going to return the default value of its argument's
declared type and not the default value of its corresponding parameter's
declared type, then this can't be done.  What must happen is for the
operator to take an extra argument where the name of the type whose default
we want is spelled out, or alternately just the default value itself.

# EXPRESSIONS

*TODO.*

# PROCEDURES

A *procedure* (a special case of which is known as an *update operator*)
is a set of instructions for either enacting possibly non-deterministic
change over time in a set of variables or for reading from or writing to
the external environment of the application, including its users or various
external systems.

*TODO.*

# STATEMENTS

*TODO.*

# STIMULUS-RESPONSE RULES

Muldis D natively supports the concept of *stimulus-response rules*,
otherwise known as *triggered routines*.  The concept involves the
automatic execution of a procedure in response to a particular
defined stimulus.  This is in contrast with the normal way to execute a
routine which is in response to an explicit invocation in code.

*TODO: Other related notes.*

# TODO - SECTIONS ON NAMESPACES, PACKAGES, AND OTHER THINGS

*TODO.  Also say what 'using','floating' etc do.*

*TODO.  A package is the standard compilation unit.*

# EXTERNAL TYPES AND ROUTINES

*TODO.  Meanwhile see 'same' and 'EXTERNAL DATA TYPES' in System.pod.*

## FOUNDATION

*TODO: Rewrite the following.*

This document defines the fundamental data types and operators of Muldis D,
collectively referred to as the *Muldis D Foundation*; these are the
mandatory minimal core set of system-defined and eternally available
entities that all Muldis D implementations, at least those that claim to
support the `Muldis_D Plain_Text https://muldis.com 0.300.0` language,
need to provide.

The official Muldis D language is canonically stratified into 2
main layers implementation-wise, *low-level* and *high-level*.

High-level Muldis D provides the system-defined types and operators and
other features that regular users of the language would employ directly in
their applications and schemas.  High-level Muldis D is formally defined
using the exact same methods available to users for writing their own
types/operators/etc, including choices of syntax and features.  It is
canonically written as regular Muldis D packages / code libraries just like
user code is; users can introspect it or write their own alternatives for
parts or the whole of it that look and function as it does.  See
[Muldis_Data_Language_Package_System](Muldis_Data_Language_Package_System.md) for the details of high-level Muldis D.

The *Muldis D Foundation* defines low-level Muldis D, which is the
system-defined types and operators and other features which are canonically
written in one or more third-party languages which are *hosting* Muldis D,
whether for purposes of bootstrapping Muldis D or for purposes of
integrating the languages in a common user development environment.

The Muldis D Foundation encompases fundamental types and operators that
best practice would deem each host should be taking care of their
implementation details itself and that implementing such higher up would
not be a pragmatic use of resources or would be inappropriate reinventing
the wheel.  Moreover, that is about the level of abstraction where hosts
would tend to strongly diverge from each other in implementation details in
matters that strongly effect performance or that differentiate themselves,
not the least of which is functional vs procedural or distributed vs not,
or static vs dynamic, or other matters of algorithms and integration.

Low-level Muldis D is a polar opposite of high-level; its API is not
defined or invokable or introspectable in the same way as normal Muldis D
code, and users can not define their own substitutes that have the exact
same user syntax as they have.  The purpose of low-level is to provide the
basis for writing the system-defined high level language, and users should
not normally be invoking low-level directly, although they do in fact have
all of the same freedom to do so if the situation warrants.

Canonically speaking, any system-defined entities defined as part of
high-level Muldis D can just be written once and be shared by all host
implementations as is, and so porting Muldis D to a new host can be done
with fairly little work in order for it to run at all.  The Muldis D
Foundation is minimized to the reasonable bare bones on purpose in order
largely to aid this (and largely to increase user substitutability).  That
being said, each host implementation is free to override the
implementations of any Muldis D code, whether part of high-level Muldis D
or part of a user's own code, with host-native implementations in order to
boost performance.  It is in fact assumed that such overrides will be
common, with simple hosts doing little of it and sophisticated industrial
strength hosts doing it a lot.  As long as the actual semantics as seen by
the user is unchanged, this is all fair game.  The design of Muldis D is
also meant to help hosts do this more reliably and with fewer errors.

*TODO.  Update the following, and some preceding, which are now outdated.*

Formally speaking, all low-level data types are anonymous, and this
documentation refers to them italicized like *foo*; any *foo* is for
human reference and that name doesn't physically exist as part of the
low-level API as a type or type definer name.  In contrast, all low-level
operators/routines are named, and the documentation refers to them like
`foo` as they do physically exist as part of the low-level API.

The high-level API gives more user-friendly physical `foo` names to all of
the above in its own type definer/routine wrappers for the low-level entities,
but those names won't be used in this Muldis D Foundation document.

The low-level entity names given here, whether anonymous or not, are
purposefully given different names than their high-level wrappers have,
to help easily distinguish them; mainly they have `foundation::` prefixes.

# FOUNDATION TYPES

*TODO.*

## Any

The `Any` type is the infinite *universal type*, which is the
maximal data type of the entire Muldis D type system and consists of all
values which can possibly exist.  It is a union type over just these 7
low-level types, all of the latter being mutually disjoint:
`Boolean`, `Integer`, `Array`, `Bag`, `Tuple`, `Article`, `Handle`.

## Boolean

The `Boolean` type is finite.  A `Boolean` value is a general
purpose 2-valued logic boolean or *truth value*, or specifically it is one
of the 2 values *false* and *true*.

## Integer

The `Integer` type is infinite.  An `Integer` value is a
general purpose exact integral number of any magnitude, which explicitly
does not represent any kind of thing in particular, neither cardinal nor
ordinal nor nominal.

## Array

The `Array` type is infinite.  An `Array` value is a ... *TODO*.

## Bag

The `Bag` type is infinite.  A `Bag` value is a ... *TODO*.

## Tuple

The `Tuple` type is infinite.  A `Tuple` value is a ... *TODO*.

## Article

The `Article` type is infinite.  A `Article` value is a ... *TODO*.

## Handle

The `Handle` type is infinite.  A `Handle` value is a ... *TODO*.

# FOUNDATION HANDLE SUBTYPES

## Variable

The `Variable` type is infinite.  A `Variable` value is a ... *TODO*.

## Process

The `Process` type is infinite.  A `Process` value is a ... *TODO*.

## Stream

The `Stream` type is infinite.  A `Stream` value is a ... *TODO*.

## External

The `External` type is infinite.  An `External` value is an
opaque and transient reference to an entity that is defined and managed
externally to the Muldis D language environment, either internally to the
Muldis D host implementation or in some peer language that it mediates.

# FOUNDATION SUBTYPES FOR DEFINING SOURCE CODE

*TODO.*

## ...

*TODO.*

# FOUNDATION SINGLETON TYPE DEFINERS

*TODO.*

## False

The Foundation singleton type definer `False` represents the `Boolean`
value *false*.

## True

The Foundation singleton type definer `True` represents the `Boolean`
value *true*.

## Neg_One

The Foundation singleton type definer `Neg_One` represents the `Integer`
value negative-one.

## Zero

The Foundation singleton type definer `Zero` represents the `Integer`
value zero.

## Pos_One

The Foundation singleton type definer `Pos_One` represents the `Integer`
value positive-one.

# FOUNDATION FUNCTIONS

*TODO.*

Every low-level routine takes a source of just the `Any` type, so
any value expression will bind to it; any further input requirements will
be defined in their bodies and fail with thrown exceptions.

## Boolean

The function `Boolean` requires its source to be a `Tuple`
value with just 1 attribute/argument named `0`, where that argument may be
any value.  This function results in the `Boolean` value
*true* iff its `0` argument is a member of the `Boolean` type, and
results in the `Boolean` value *false* otherwise.

## Integer

The function `Integer` requires its source to be a `Tuple`
value with just 1 attribute/argument named `0`, where that argument may be
any value.  This function results in the `Boolean` value
*true* iff its `0` argument is a member of the `Integer` type, and
results in the `Boolean` value *false* otherwise.

## Array

The function `Array` requires its source to be a `Tuple`
value with just 1 attribute/argument named `0`, where that argument may be
any value.  This function results in the `Boolean` value
*true* iff its `0` argument is a member of the `Array` type, and
results in the `Boolean` value *false* otherwise.

## Bag

The function `Bag` requires its source to be a `Tuple`
value with just 1 attribute/argument named `0`, where that argument may be
any value.  This function results in the `Boolean` value
*true* iff its `0` argument is a member of the `Bag` type, and
results in the `Boolean` value *false* otherwise.

## Tuple

The function `Tuple` requires its source to be a `Tuple`
value with just 1 attribute/argument named `0`, where that argument may be
any value.  This function results in the `Boolean` value
*true* iff its `0` argument is a member of the `Tuple` type, and
results in the `Boolean` value *false* otherwise.

## Article

The function `Article` requires its source to be a `Tuple`
value with just 1 attribute/argument named `0`, where that argument may be
any value.  This function results in the `Boolean` value
*true* iff its `0` argument is a member of the `Article` type, and
results in the `Boolean` value *false* otherwise.

## Handle

The function `Handle` requires its source to be a `Tuple`
value with just 1 attribute/argument named `0`, where that argument may be
any value.  This function results in the `Boolean` value
*true* iff its `0` argument is a member of the `Handle` type, and
results in the `Boolean` value *false* otherwise.

## Variable

The function `Variable` requires its source to be a `Tuple`
value with just 1 attribute/argument named `0`, where that argument may be
any value.  This function results in the `Boolean` value
*true* iff its `0` argument is a member of the `Variable` type, and
results in the `Boolean` value *false* otherwise.

## Process

The function `Process` requires its source to be a `Tuple`
value with just 1 attribute/argument named `0`, where that argument may be
any value.  This function results in the `Boolean` value
*true* iff its `0` argument is a member of the `Process` type, and
results in the `Boolean` value *false* otherwise.

## Stream

The function `Stream` requires its source to be a `Tuple`
value with just 1 attribute/argument named `0`, where that argument may be
any value.  This function results in the `Boolean` value
*true* iff its `0` argument is a member of the `Stream` type, and
results in the `Boolean` value *false* otherwise.

## External

The function `External` requires its source to be a `Tuple`
value with just 1 attribute/argument named `0`, where that argument may be
any value.  This function results in the `Boolean` value
*true* iff its `0` argument is a member of the `External` type, and
results in the `Boolean` value *false* otherwise.

## Any_same

The function `Any_same` requires its source to be a `Tuple`
value with just 2 attributes/arguments named `0` and `1`.  This function
results in the `Boolean` value *true* iff its 2 arguments `0` and
`1` are exactly the same value, and results in the `Boolean` value
*false* otherwise.  This function is commutative.

## Integer_in_order

The function `Integer_in_order` requires its source to be a
`Tuple` value with just 2 attributes/arguments named `0` and
`1`, where each argument is an `Integer` value.  This function
results in the `Boolean` value *true* iff either its 2 arguments
`0` and `1` are exactly the same value or the `0` argument is closer to
negative infinity than its `1` argument; it results in the `Boolean`
value *false* otherwise.

## Integer_opposite

The function `Integer_opposite` requires its source to be a
`Tuple` value with just 1 attribute/argument named `0`, where
that argument is an `Integer` value.  This function results in the
`Integer` value that is the *opposite* of its `0` argument.

## Integer_modulus

The function `Integer_modulus` requires its source to be a
`Tuple` value with just 1 attribute/argument named `0`, where
that argument is an `Integer` value.  This function results in the
non-negative `Integer` value that is the *absolute value* of its
`0` argument.

## Integer_plus

The function `Integer_plus` requires its source to be a
`Tuple` value with just 2 attributes/arguments named `0` and
`1`, where each argument is an `Integer` value.  This function
results in the `Integer` *sum* from performing *addition* of
its 2 *summand* arguments `0` (*augend*) and `1` (*addend*).  This
function is both associative and commutative; its *two-sided identity element* value is the
`Integer` zero; `Integer_times` is its repeater function.

## Integer_minus

The function `Integer_minus` requires its source to be a
`Tuple` value with just 2 attributes/arguments named `0` and
`1`, where each argument is an `Integer` value.  This function
results in the `Integer` *difference* from performing
*subtraction* of its 2 arguments `0` (*minuend*) and `1`
(*subtrahend*).

## Integer_times

The function `Integer_times` requires its source to be a
`Tuple` value with just 2 attributes/arguments named `0` and
`1`, where each argument is an `Integer` value.  This function
results in the `Integer` *product* from performing
*multiplication* of its 2 *factor* arguments `0` (*multiplier*) and
`1` (*multiplicand*).  This function is both associative and commutative;
its *two-sided identity element* value is the `Integer` positive one;
`Integer_nn_power` is its repeater function.

## Integer_multiple_of

The function `Integer_multiple_of` requires its source to be a
`Tuple` value with just 2 attributes/arguments named `0` and
`1`, where each argument is an `Integer` value and `1` must also
be nonzero.  This function results in the `Boolean` value *true* iff
its `0` argument is an even multiple of its `1` argument (that is, the
former is evenly divisible by the latter); it results in the
`Boolean` value *false* otherwise.

## Integer_divided_by_rtz

The function `Integer_divided_by_rtz` requires its source to be a
`Tuple` value with just 2 attributes/arguments named `0` and
`1`, where each argument is an `Integer` value and `1` must also
be nonzero.  This function results in the `Integer` *quotient*
from performing *division* of its 2 arguments `0` (*dividend* or
*numerator*) and `1` (*divisor* or *denominator*) using the semantics
of real number division, whereupon the real number result is rounded to the
same or nearest-towards-zero integral number.

## Integer_nn_power

The function `Integer_nn_power` requires its source to be a
`Tuple` value with just 2 attributes/arguments named `0` and
`1`, where each argument is an `Integer` value and at least one
of those must also be nonzero and `1` must also be non-negative.  This
function results in the `Integer` value from performing
*exponentiation* of its 2 arguments `0` (*base*) and `1` (*exponent*
or *power*).

## Integer_factorial

The function `Integer_factorial` requires its source to be a
`Tuple` value with just 1 attribute/argument named `0`, where
that argument is a non-negative `Integer` value.  This function
results in the positive `Integer` value that is the *factorial*
of its `0` argument.

## Array_substring_of

*TODO.*

## Array_overlaps_string

*TODO.*

## Array_disjoint_string

*TODO.*

## Array_catenate

*TODO.*

## Array_replicate

*TODO.*

## Array_has_n

*TODO.*

## Array_multiplicity

*TODO.*

## Array_all_unique

*TODO.*

## Array_unique

*TODO.*

## Array_any

*TODO.*

## Array_insert_n

*TODO.*

## Array_remove_n

*TODO.*

## Array_except

*TODO.  Change from except(A1,A2) to except(A1,to_Bag(A2)).*

## Array_intersect

*TODO.  Change from intersect(A1,A2) to intersect(A1,to_Bag(A2)).*

## Array_union

*TODO.  Kill this; instead of union(A1,A2), users catenate(A1,except(A2,(to_Bag(A1)))).*

## Array_exclusive

*TODO.  Kill this; users do analagous to union replacement.*

## Array_nest

*TODO.*

## Array_unnest

*TODO.*

## Array_where

*TODO.*

## Array_map

*TODO.*

## Array_reduce

*TODO.*

## Array_to_Bag

*TODO.*

## Array_count

*TODO.*

## Array_order_using

*TODO.*

## Array_at

*TODO.*

## Array_slice_n

*TODO.*

## Array_ord_pos_succ_all_matches

*TODO.*

## Bag_singular

*TODO.*

## Bag_only_member

*TODO.*

## Bag_has_n

*TODO.*

## Bag_multiplicity

*TODO.*

## Bag_all_unique

*TODO.*

## Bag_unique

*TODO.*

## Bag_subset_of

*TODO.*

## Bag_overlaps_members

*TODO.*

## Bag_disjoint_members

*TODO.*

## Bag_any

*TODO.*

## Bag_insert_n

*TODO.*

## Bag_remove_n

*TODO.*

## Bag_member_plus

*TODO.*

## Bag_except

*TODO.*

## Bag_intersect

*TODO.*

## Bag_union

*TODO.*

## Bag_exclusive

*TODO.*

## Bag_nest

*TODO.*

## Bag_unnest

*TODO.*

## Bag_where

*TODO.*

## Bag_map

*TODO.*

## Bag_reduce

*TODO.*

## Bag_count

*TODO.*

## Bag_unique_count

*TODO.*

## Bag_order_using

*TODO.*

## Tuple_D1_select

*TODO.*

## Tuple_degree

*TODO.*

## Tuple_heading

*TODO.*

## Tuple_subheading_of

*TODO.*

## Tuple_overlaps_heading

*TODO.*

## Tuple_disjoint_heading

*TODO.*

## Tuple_except_heading

*TODO.*

## Tuple_intersect_heading

*TODO.*

## Tuple_union_heading

*TODO.*

## Tuple_exclusive_heading

*TODO.*

## Tuple_rename

*TODO.*

## Tuple_on

*TODO.*

## Tuple_update

*TODO.*

## Tuple_extend

*TODO.*

## Tuple_at

*TODO.*

## Tuple_any_attrs

*TODO.*

## Tuple_attrs_where

*TODO.*

## Tuple_attrs_map

*TODO.*

## Tuple_attrs_reduce

*TODO.*

## Article_select

*TODO.*

## Article_label

*TODO.*

## Article_attrs

*TODO.*

## Article_at

*TODO.*

## External_call_function

The function `External_call_function` requires its source to be a
`Tuple` value with just 1 attribute/argument named `0`, where that
argument may be any value.  This function is a proxy for
invoking a function that is defined and managed externally to the Muldis D
language environment where that external function receives the value of the
`0` attribute as its source/arguments.  Its result type is `Any`.

# FOUNDATION PROCEDURES

*TODO.*

*TODO.  Practically all Variable ops are procedures.*

## ...

*TODO.*

# AUTHOR

Darren Duncan (`darren@DarrenDuncan.net`)

# LICENSE AND COPYRIGHT

This file is part of the formal specification of the **Muldis D Foundation**
(**MDF**) primary component of the **Muldis D** language specification.

MDF is Copyright © 2002-2018, Muldis Data Systems, Inc.

<https://muldis.com>

MDF is free documentation for software; you can redistribute it and/or
modify it under the terms of the Apache License, Version 2.0 (AL2) as
published by the Apache Software Foundation (<https://www.apache.org>).
You should have received a copy of the AL2 as part of the MDF
distribution, in the file named "LICENSE/Apache-2.0.txt";
if not, see <https://www.apache.org/licenses/LICENSE-2.0>.

Any versions of MDF that you modify and distribute must carry prominent
notices stating that you changed the files and the date of any changes, in
addition to preserving this original copyright notice and other credits.

While it is by no means required, the copyright holder of MDF would
appreciate being informed any time you create a modified version of MDF
that you are willing to distribute, because that is a practical way of
suggesting improvements to the standard version.
