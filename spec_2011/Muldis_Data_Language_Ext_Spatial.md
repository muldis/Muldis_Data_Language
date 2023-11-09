# NAME

Muldis Data Language Ext Spatial - Muldis Data Language extension for spatial data types and operators

# VERSION

This document is Muldis Data Language Ext Spatial version 0.148.1.

# PREFACE

This document is part of the Muldis Data Language language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document
before you read this one, which provides subservient details.

# DESCRIPTION

Muldis Data Language has a mandatory core set of system-defined (eternally available)
entities, which is referred to as the *Muldis Data Language core* or the *core*; they
are the minimal entities that all Muldis Data Language implementations need to provide;
they are mutually self-describing and are either used to bootstrap the
language or they constitute a reasonable minimum level of functionality for
a practically useable industrial-strength (and fully *TTM*-conforming)
programming language; any entities outside the core, called *Muldis Data Language
extensions*, are non-mandatory and are defined in terms of the core or each
other, but the reverse isn't true.

This current `Spatial` document describes the system-defined *Muldis Data Language
Spatial Extension*, which consists of spatial and/or geometric data types
and operators.

This current document does not describe the polymorphic operators that all
types, or some types including core types, have defined over them; said
operators are defined once for all types in [Core](Muldis_Data_Language_Core.md).

*This documentation is pending.*

# TYPE SUMMARY

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

*This documentation is pending.*

# DATA TYPES FOR SPATIAL ARTIFACTS

These non-core scalar data types describe common kinds of spatial or
geometric figures.  *Of course, dealing with these types in general isn't
a perfect science; they stand to be revised or rewritten.*

## sys.std.Spatial.Type.Geometry

*TODO.*

## sys.std.Spatial.Type.Point

*TODO.*

## sys.std.Spatial.Type.Curve

*TODO.*

## sys.std.Spatial.Type.LineString

*TODO.*

## sys.std.Spatial.Type.CircularString

*TODO.*

## sys.std.Spatial.Type.CompoundCurve

*TODO.*

## sys.std.Spatial.Type.Surface

*TODO.*

## sys.std.Spatial.Type.CurvePolygon

*TODO.*

## sys.std.Spatial.Type.Polygon

*TODO.*

## sys.std.Spatial.Type.GeometryCollection

*TODO.*

## sys.std.Spatial.Type.MultiPoint

*TODO.*

## sys.std.Spatial.Type.MultiCurve

*TODO.*

## sys.std.Spatial.Type.MultiLineString

*TODO.*

## sys.std.Spatial.Type.MultiSurface

*TODO.*

## sys.std.Spatial.Type.MultiPolygon

*TODO.*

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Data Language** (**MDL**).

MDL is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
