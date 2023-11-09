# NAME

Muldis::D::Ext::Temporal - Muldis D extension for temporal data types and operators

# VERSION

This document is Muldis::D::Ext::Temporal version 0.148.1.

# PREFACE

This document is part of the Muldis D language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document
before you read this one, which provides subservient details.

# DESCRIPTION

Muldis D has a mandatory core set of system-defined (eternally available)
entities, which is referred to as the I<Muldis D core> or the I<core>; they
are the minimal entities that all Muldis D implementations need to provide;
they are mutually self-describing and are either used to bootstrap the
language or they constitute a reasonable minimum level of functionality for
a practically useable industrial-strength (and fully I<TTM>-conforming)
programming language; any entities outside the core, called I<Muldis D
extensions>, are non-mandatory and are defined in terms of the core or each
other, but the reverse isn't true.

This current C<Temporal> document describes the system-defined I<Muldis D
Temporal Extension>, which consists of temporal data types and operators.
To be specific, the I<Muldis D Temporal Extension> only describes the most
generic temporal-concerning mixin types, plus the most generic virtual
routines to use with them; it does I<not> define any types that compose
these mixins, or routines that implement those virtuals.  It is expected,
considering the complexity of temporals, that in the general case any
temporal types and routines that would actually be used would be either
user-defined, or implementation-defined, or both, or some other standard
Muldis D extensions would provide them; the latter don't exist yet.

See also the separately-distributed [Muldis_Data_Language_Manual::TemporalExtras](Muldis_Data_Language_Manual::TemporalExtras.md)
document, which provides complete examples of temporal types that could
compose this extension's mixins, and of routines that could implement its
virtual routines.

This current document does not describe the polymorphic operators that all
types, or some types including core types, have defined over them; said
operators are defined once for all types in [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md).

# TYPE SUMMARY

Following are all the data types described in this document, which are all
mixin types, arranged in a type graph according to their proper
sub|supertype relationships; currently there are no system-defined types
that compose them:

    sys.std.Core.Type.Universal
        sys.std.Temporal.Type.Instant
        sys.std.Temporal.Type.Duration

# TEMPORAL MIXIN DATA TYPES

## sys.std.Temporal.Type.Instant

The C<Instant> type is a mixin (union) type that is intended to be
explicitly composed by every other type where each of the values of that
type is considered to be an I<instant>, which is a distinct point on some
timeline.  Types that compose C<Instant> can vary greatly with respect to
either what timeline/calendar provides the context for interpreting them,
or to what their granularity is.  Common examples of an I<instant> are a
I<datetime> or a I<date> or a I<time>.  The cardinality of C<Instant> is
infinity.  The C<Instant> type is not itself ordered, but often a type
which composes C<Duration> is also ordered.  The C<Instant> type is
intended to have exactly the same meaning as the same-named type of Raku
(see <http://perlcabal.org/syn/S02.html> for details).  The default value
of C<Instant> is implementation-defined.

## sys.std.Temporal.Type.Duration

The C<Duration> type is a mixin (union) type that is intended to be
explicitly composed by every other type where each of the values of that
type is considered to be a I<duration>, which is a single amount of time
that is generally specified in terms of the same units as an I<instant>,
and it is generally interpreted with respect to a timeline or calendar.  A
C<Duration> is, by definition, the result of taking the difference of 2
C<Instant>.  A C<Duration> is not fixed to any points on a timeline, simply
dealing with a quantity.  If you want to represent an interval of time that
is anchored to a timeline, then canonically you do this in terms of a
composite type having two C<Instant> attributes representing the endpoints;
either an C<sp_interval_of.Instant> or an C<mp_interval_of.Instant>.  The
cardinality of C<Duration> is infinity.  The C<Duration> type is not itself
ordered, but often a type which composes C<Duration> is also ordered.  The
C<Duration> type is intended to have exactly the same meaning as the
same-named type of Raku.  The default value of C<Duration> is
implementation-defined.

# VIRTUAL FUNCTIONS FOR THE INSTANT MIXIN TYPE

## sys.std.Temporal.Instant.diff

C<< function diff (Duration <--
minuend@ : Instant, subtrahend@ : Instant) {...} >>

This virtual function results in the duration-typed difference when its
instant-typed C<subtrahend> argument is subtracted from its instant-typed
C<minuend> argument.  The result is the amount of time between the 2
arguments, which may be positive or negative depending on which argument
was earlier.

## sys.std.Temporal.Instant.abs_diff

C<< function abs_diff (Duration <--
topic@ : Instant, other@ : Instant) {...} >>

This virtual symmetric function results in the absolute difference between
its 2 arguments.  The result is the amount of time between the 2 arguments,
which is always non-negative.

## sys.std.Temporal.Instant.later

C<< function later (Instant <--
instant@ : Instant, duration@ : Duration) {...} >>

This virtual function results in the instant that is later than its
C<instant> argument by the amount of time in the C<duration> argument.

## sys.std.Temporal.Instant.earlier

C<< function earlier (Instant <--
instant@ : Instant, duration@ : Duration) {...} >>

This virtual function results in the instant that is earlier than its
C<instant> argument by the amount of time in the C<duration> argument.

# VIRTUAL FUNCTIONS FOR THE DURATION MIXIN TYPE

## sys.std.Temporal.Duration.abs

C<< function abs (Duration <-- topic@ : Duration) {...} >>

This virtual function results in the absolute value of its argument.

## sys.std.Temporal.Duration.sum

C<< function sum (Duration <-- topic@ : bag_of.Duration) {...} >>

This virtual function results in the sum of the N element values of its
argument; it is a reduction operator that recursively takes each pair of
input values and adds (which is both commutative and associative) them
together until just one is left, which is the result.  Conceptually, if
C<topic> has zero values, then C<sum> results in the duration zero, which
is the identity value for addition; however, while each implementing
function of C<sum> could actually result in a type-specific value of zero,
this virtual function itself will instead fail when C<topic> has zero
values, because then it would lack the necessary type information to know
which type-specific implementing function to dispatch to.

## sys.std.Temporal.Duration.diff

C<< function diff (Duration <--
minuend@ : Duration, subtrahend@ : Duration) {...} >>

This virtual function results in the difference when its C<subtrahend>
argument is subtracted from its C<minuend> argument.

## sys.std.Temporal.Duration.abs_diff

C<< function abs_diff (Duration <--
topic@ : Duration, other@ : Duration) {...} >>

This virtual symmetric function results in the absolute difference between
its 2 arguments.

# VIRTUAL SYSTEM-SERVICES FOR CURRENT DATES AND TIMES

## sys.std.Temporal.Instant.fetch_trans_instant

C<system-service fetch_trans_instant (&target@ : Instant) [...]>

This virtual system-service routine will update the variable supplied as
its C<target> argument so that it holds the value of the current instant as
taken from the implementation's system clock or the time server it uses.
Or to be more accurate, the fetched instant is the one that was current
when the parent-most transaction was started within which this routine was
invoked; this means that multiple invocations of C<fetch_trans_instant>
within the same transaction are guaranteed to fetch the same value; if
this routine is not invoked within the context of an explicit transaction,
then then routine call by itself is its own transaction for that purpose.
The implementing system-service which this dispatches to is determined by
the type of the value that C<target> has at the moment when
C<fetch_trans_instant> is invoked; typically that value is the default
of the declared type of the invoker variable which is C<target>'s argument;
this routine might fail if said declared type isn't a subset of C<Instant>.

# AUTHOR

Darren Duncan (C<darren@DarrenDuncan.net>)

# LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
