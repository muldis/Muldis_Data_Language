=pod

=encoding utf8

=head1 NAME

Muldis::D::Ext::Spatial - Muldis D extension for spatial data types and operators

=head1 VERSION

This document is Muldis::D::Ext::Spatial version 0.148.1.

=head1 PREFACE

This document is part of the Muldis D language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document
before you read this one, which provides subservient details.

=head1 DESCRIPTION

Muldis D has a mandatory core set of system-defined (eternally available)
entities, which is referred to as the I<Muldis D core> or the I<core>; they
are the minimal entities that all Muldis D implementations need to provide;
they are mutually self-describing and are either used to bootstrap the
language or they constitute a reasonable minimum level of functionality for
a practically useable industrial-strength (and fully I<TTM>-conforming)
programming language; any entities outside the core, called I<Muldis D
extensions>, are non-mandatory and are defined in terms of the core or each
other, but the reverse isn't true.

This current C<Spatial> document describes the system-defined I<Muldis D
Spatial Extension>, which consists of spatial and/or geometric data types
and operators.

This current document does not describe the polymorphic operators that all
types, or some types including core types, have defined over them; said
operators are defined once for all types in [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md).

I<This documentation is pending.>

=head1 TYPE SUMMARY

Following are all the data types described in this document, arranged in a
type graph according to their proper sub|supertype relationships:

    sys.std.Core.Type.Universal
        sys.std.Core.Type.Scalar
            sys.std.Core.Type.DHScalar

                # The following are all regular non-ordered scalar types.

                sys.std.Spatial.Type.Geometry
                    sys.std.Spatial.Type.Point
                    sys.std.Spatial.Type.Curve
                        sys.std.Spatial.Type.LineString
                        sys.std.Spatial.Type.CircularString
                        sys.std.Spatial.Type.CompoundCurve
                    sys.std.Spatial.Type.Surface
                        sys.std.Spatial.Type.CurvePolygon
                            sys.std.Spatial.Type.Polygon
                    sys.std.Spatial.Type.GeometryCollection
                        sys.std.Spatial.Type.MultiPoint
                        sys.std.Spatial.Type.MultiCurve
                            sys.std.Spatial.Type.MultiLineString
                        sys.std.Spatial.Type.MultiSurface
                            sys.std.Spatial.Type.MultiPolygon

I<This documentation is pending.>

=head1 DATA TYPES FOR SPATIAL ARTIFACTS

These non-core scalar data types describe common kinds of spatial or
geometric figures.  I<Of course, dealing with these types in general isn't
a perfect science; they stand to be revised or rewritten.>

=head2 sys.std.Spatial.Type.Geometry

I<TODO.>

=head2 sys.std.Spatial.Type.Point

I<TODO.>

=head2 sys.std.Spatial.Type.Curve

I<TODO.>

=head2 sys.std.Spatial.Type.LineString

I<TODO.>

=head2 sys.std.Spatial.Type.CircularString

I<TODO.>

=head2 sys.std.Spatial.Type.CompoundCurve

I<TODO.>

=head2 sys.std.Spatial.Type.Surface

I<TODO.>

=head2 sys.std.Spatial.Type.CurvePolygon

I<TODO.>

=head2 sys.std.Spatial.Type.Polygon

I<TODO.>

=head2 sys.std.Spatial.Type.GeometryCollection

I<TODO.>

=head2 sys.std.Spatial.Type.MultiPoint

I<TODO.>

=head2 sys.std.Spatial.Type.MultiCurve

I<TODO.>

=head2 sys.std.Spatial.Type.MultiLineString

I<TODO.>

=head2 sys.std.Spatial.Type.MultiSurface

I<TODO.>

=head2 sys.std.Spatial.Type.MultiPolygon

I<TODO.>

=head1 AUTHOR

Darren Duncan (C<darren@DarrenDuncan.net>)

=head1 LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.

=cut
