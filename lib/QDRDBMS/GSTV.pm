use 5.008001;
use utf8;
use strict;
use warnings FATAL => 'all';

use Encode;

###########################################################################
###########################################################################

my $FALSE = (1 == 0);
my $TRUE  = (1 == 1);

my $SCALAR_METHOD_RETURN_PAYLOAD = sub {
    my ($self) = @_;
    return ${$self};
};
my $SCALAR_OVERLOAD_SETUP_ARGS = {
    q{bool} => $SCALAR_METHOD_RETURN_PAYLOAD,
    q{""}   => $SCALAR_METHOD_RETURN_PAYLOAD,
    q{0+}   => $SCALAR_METHOD_RETURN_PAYLOAD,
    'fallback' => 1,
};

###########################################################################
###########################################################################

{ package QDRDBMS::GSTV; # module
    our $VERSION = 0.000000;
    # Note: This given version applies to all of this file's packages.

    use base 'Exporter';
    our @EXPORT_OK = qw( Bool Str Blob Int Num Hash );

    use Carp;
    use Scalar::Util qw( looks_like_number );

###########################################################################

sub Bool {
    my ($v) = @_;
    confess q{Bool(): Bad constructor arg; it is undefined.}
        if !defined $v;

    $v = $v ? $TRUE : $FALSE;

    return bless \$v, 'QDRDBMS::GSTV::Bool';
}

sub Str {
    my ($v) = @_;
    confess q{Str(): Bad constructor arg; it is undefined.}
        if !defined $v;

    confess q{Str(): Bad constructor arg; Perl 5 does not consider}
            . q{ it to be a character string.}
        if !Encode::is_utf8( $v ) and $v =~ m/[^\x00-\x7F]/xs;

    return bless \$v, 'QDRDBMS::GSTV::Str';
}

sub Blob {
    my ($v) = @_;
    confess q{Blob(): Bad constructor arg; it is undefined.}
        if !defined $v;

    confess q{Blob(): Bad constructor arg; Perl 5 does not consider}
            . q{ it to be a byte string.}
        if Encode::is_utf8( $v );

    return bless \$v, 'QDRDBMS::GSTV::Blob';
}

sub Int {
    my ($v) = @_;
    confess q{Int(): Bad constructor arg; it is undefined.}
        if !defined $v;

    confess q{Int(): Bad constructor arg; Perl 5 does not consider}
            . q{ it to be a number.}
        if !looks_like_number $v;
    $v += 0; # TODO: Check if BigInt stays a BigInt.
    confess q{Int(): Bad constructor arg; it's a non-integral number.}
        if int $v != $v;

    return bless \$v, 'QDRDBMS::GSTV::Int';
}

sub Num {
    my ($v) = @_;
    confess q{Num(): Bad constructor arg; it is undefined.}
        if !defined $v;

    confess q{Num(): Bad constructor arg; Perl 5 does not consider}
            . q{ it to be a number.}
        if !looks_like_number $v;
    $v += 0; # TODO: Check if BigRat stays a BigRat.

    return bless \$v, 'QDRDBMS::GSTV::Num';
}

sub Hash {
    my ($v) = @_;
    confess q{Hash(): Bad constructor arg; it is undefined.}
        if !defined $v;

    confess q{Hash(): Bad constructor arg; Perl 5 does not consider}
            . q{ it to be a Hash.}
        if ref $v ne 'HASH';

    for my $key (keys %{$v}) {
        my $val = $v->{$key};

        confess q{Hash(): Bad constructor arg key;}
                . q{ Perl 5 does not consider it to be a character string.}
            if !Encode::is_utf8( $key ) and $key =~ m/[^\x00-\x7F]/xs;

        confess q{Hash(): Bad constructor arg val for key '$key';}
                . q{ it is undefined.}
            if !defined $val;
    }

    return bless {%{$v}}, 'QDRDBMS::GSTV::Hash';
}

###########################################################################

} # module QDRDBMS::GSTV

###########################################################################
###########################################################################

{ package QDRDBMS::GSTV::Bool; # class
    use overload (%{$SCALAR_OVERLOAD_SETUP_ARGS});
} # class QDRDBMS::GSTV::Bool

###########################################################################
###########################################################################

{ package QDRDBMS::GSTV::Str; # class
    use overload (%{$SCALAR_OVERLOAD_SETUP_ARGS});
} # class QDRDBMS::GSTV::Str

###########################################################################
###########################################################################

{ package QDRDBMS::GSTV::Blob; # class
    use overload (%{$SCALAR_OVERLOAD_SETUP_ARGS});
} # class QDRDBMS::GSTV::Blob

###########################################################################
###########################################################################

{ package QDRDBMS::GSTV::Int; # class
    use overload (%{$SCALAR_OVERLOAD_SETUP_ARGS});
} # class QDRDBMS::GSTV::Int

###########################################################################
###########################################################################

{ package QDRDBMS::GSTV::Num; # class
    use overload (%{$SCALAR_OVERLOAD_SETUP_ARGS});
} # class QDRDBMS::GSTV::Num

###########################################################################
###########################################################################

{ package QDRDBMS::GSTV::Hash; # class
} # class QDRDBMS::GSTV::Hash

###########################################################################
###########################################################################

1; # Magic true value required at end of a reuseable file's code.
__END__

=pod

=encoding utf8

=head1 NAME

QDRDBMS::GSTV -
Generic Strong Typed Value - a basic Perl 6 feature brought to Perl 5

=head1 VERSION

This document describes QDRDBMS::GSTV ("GSTV") version 0.0.0.

It also describes the same-number versions of QDRDBMS::GSTV::Bool ("Bool")
and QDRDBMS::GSTV::Str ("Str") and QDRDBMS::GSTV::Blob ("Blob") and
QDRDBMS::GSTV::Int ("Int") and QDRDBMS::GSTV::Num ("Num").

=head1 SYNOPSIS

    use QDRDBMS::GSTV qw( Bool Str Blob Int Num Hash );

    my $truth_value = Bool( 2 + 2 == 4 );
    my $planetoid = Str('Ceres');
    my $package = Blob( pack 'H2', 'P' );
    my $answer = Int(42);
    my $pi = Num(3.14159);

    binmode *main::STDOUT, ':utf8';
    print $truth_value ? "True" : "False";
    print "A big round thing, $planetoid, is between Mars and Jupiter.";
    binmode *main::STDOUT, ':bytes';
    print $package;
    binmode *main::STDOUT, ':utf8';
    print "Answer plus plus is " . ($answer ++) . ".";
    print "A circumference is " . (2 * $pi) . " radians";

    Int(3.7); # dies
    Num('Perl'); # ditto
    # ... and so on

    my $map = Hash({ 'foo' => 'fuzz', 'bar' => 42 });
    # ... then use $map as a hash ref, which it is

=head1 DESCRIPTION

QDRDBMS::GSTV provides very thin wrapper classes for Perl 5 weak data types
which constrain their values to be within the domains of strong data types,
akin to those that are a standard part of Perl 6.  The purpose of GSTV is
to help provide a more Perl 6 like foundation upon which to build the
QDRDBMS framework proper.  GSTV generally does not provide any features
that are not in Perl 6 itself, unless those are features that ought to be
in Perl 6 itself.  It stands to reason that a Perl 6 version of QDRDBMS
would not need to use GSTV itself.

Practically speaking, the scalar-type objects that this class creates are
the same as Perl 5 scalars but for a construction-time domain-restricting
assertion (that throws an exception for invalid input), and that each
carries a property (the blessing-provided class name) that says what strong
data type the value is supposed to be in the domain of.  Note that undef
is considered to be outside of the domain of any GSTV data type.

I<TODO:  Document collection-type objects et al.>

=head1 INTERFACE

The interface of QDRDBMS::GSTV is a combination of functions, objects, and
overloading.

The usual way that QDRDBMS::GSTV indicates a failure is to throw an
exception; most often this is due to invalid input.  If an invoked routine
simply returns, you can assume that it has succeeded, even if the return
value is undefined.

QDRDBMS::GSTV is a module that declares 5 functions: Bool(), Str(), Blob(),
Int(), Num(); each takes a single Perl 5 scalar argument, checks it for
validity, and then wraps it in an object based on a scalar reference; this
object is intended to be immutable.  That module can export all those
functions for user simplicity, but not by default.

These functions will throw an exception if inappropriate input is given.
First, all functions require their argument to be defined.

Beyond that, Bool() will take anything and map it to either '' or '1'
depending on whether Perl thinks the value is true.

Str() will take any scalar whose utf8-flag is true, meaning Perl is
treating it as a string of characters, as well as any scalar where both its
utf8-flag is false and it contains only 7-bit or lesser values per byte;
Blob() will take any scalar whose utf8-flag is false; if the tests pass,
then the value is coerced to an actual string if necessary by concatenating
it with an empty string.

Num() will take any scalar that looks like a number to Perl, and Int() will
take the same but further restricted such that the integer-truncation of
the value equals the value; if the tests pass, then the value is coerced to
an actual number if necessary by adding a zero to it.

The objects created by this module are of classes like QDRDBMS::GSTV::Bool,
which have zero normal methods, but are all have overload behaviour set for
string and numeric and boolean contexts; each will behave as it normally
does in Perl 5 when used in said contexts.

QDRDBMS::GSTV also declares the function Hash() which takes a Perl 5 hash
argument, checks that its keys are 'Str'-valid Perl 5 strings, and that its
values are defined; the function then clones the hash into a new hash
reference, (which is directly blessed as a ::Hash object); it is otherwise
the same as the above.

I<Currently, you can also retrieve the payload value by
scalar-dereferencing any object, such as with C< ${$obj} >, and this may
perform faster; however, you should only do that for retrieval; mutating an
object by assigning a new value is not supported behaviour.>

I<TODO:  Document collection-type objects et al.>

=head1 DIAGNOSTICS

I<This documentation is pending.>

=head1 CONFIGURATION AND ENVIRONMENT

I<This documentation is pending.>

=head1 DEPENDENCIES

This file requires any version of Perl 5.x.y that is at least 5.8.1.

=head1 INCOMPATIBILITIES

None reported.

=head1 SEE ALSO

Go to L<QDRDBMS> for the majority of distribution-internal references, and
L<QDRDBMS::SeeAlso> for the majority of distribution-external references.

=head1 BUGS AND LIMITATIONS

I<This documentation is pending.>

=head1 AUTHOR

Darren Duncan (C<perl@DarrenDuncan.net>)

=head1 LICENCE AND COPYRIGHT

This file is part of the QDRDBMS framework.

QDRDBMS is Copyright © 2002-2007, Darren Duncan.

See the LICENCE AND COPYRIGHT of L<QDRDBMS> for details.

=head1 ACKNOWLEDGEMENTS

The ACKNOWLEDGEMENTS in L<QDRDBMS> apply to this file too.

=cut
