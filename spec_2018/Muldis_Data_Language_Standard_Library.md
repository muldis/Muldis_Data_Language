# NAME

Muldis Data Language Standard Library (MDSL) - Muldis Data Language common core vocabulary for regular users

# VERSION

This document is Muldis Data Language Standard Library (MDSL) version 0.300.0.

# DESCRIPTION

This document is the human readable authoritative formal specification of
the **Muldis Data Language Standard Library** (**MDSL**)
primary component of **Muldis Data Language**.
The fully-qualified name of this document and the specification
it contains is `Muldis_Data_Language_Standard_Library https://muldis.com 0.300.0`.

See also [Muldis_Data_Language](Muldis_Data_Language.md)
to read the **Muldis Data Language** meta-specification.

The **Muldis Data Language Standard Library** specification comprises a documented
library written entirely in Muldis Data Language which provides its common core
vocabulary, the system-defined data types and operators that regular users
of the language would employ directly in their applications and schemas.
It corresponds to the "standard library" that is intrinsic to or bundled
with typical general purpose application programming languages or SQL
DBMSs.  It is the bulk portion of Muldis Data Language that is self-hosted and can be
shared by all Muldis Data Language implementations, though the latter can choose to
internally substitute behaviour-maintaining host-native versions for
performance.  It comprises a set of Muldis Data Language *packages* (compilation
units) that users can choose from as dependencies of their applications and
schemas.  None are mandatory, and users can choose alternatives, but they
are recommended as the default options for their functionality.

# PACKAGES

The **Muldis Data Language Standard Library**
comprises these Muldis Data Language packages:

* `System https://muldis.com 0.300.0` -
[Package_System](Muldis_Data_Language_Package_System.md) - Provides the common primary
system-defined data types and operators that regular users of the language
would employ directly in their applications and schemas.

Other packages will be added later, such as `System::Math`.

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification of the **Muldis Data Language Standard
Library** (**MDSL**) primary component of the **Muldis Data Language**
specification.  MDSL substantially comprises executable code as well.

MDSL is Copyright © 2002-2018, Muldis Data Systems, Inc.

<https://muldis.com>

MDSL is free software;
you can redistribute it and/or modify it under the terms of the Apache
License, Version 2.0 (AL2) as published by the Apache Software Foundation
(<https://apache.org>).  You should have received a copy of the
AL2 as part of the MDSL distribution, in the file
[LICENSE/Apache-2.0.txt](../LICENSE/Apache-2.0.txt); if not, see
<https://apache.org/licenses/LICENSE-2.0>.

Any versions of MDSL that you modify and distribute must carry prominent
notices stating that you changed the files and the date of any changes, in
addition to preserving this original copyright notice and other credits.
MDSL is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE.

While it is by no means required, the copyright holder of MDSL
would appreciate being informed any time you create a modified version of
MDSL that you are willing to distribute, because that is a
practical way of suggesting improvements to the standard version.
