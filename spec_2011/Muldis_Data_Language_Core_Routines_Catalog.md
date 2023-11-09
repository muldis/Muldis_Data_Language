# NAME

Muldis::D::Core::Routines_Catalog - Muldis D data definition routines

# VERSION

This document is Muldis::D::Core::Routines_Catalog version 0.148.1.

# PREFACE

This document is part of the Muldis D language specification, whose root
document is [Muldis_Data_Language](Muldis_Data_Language.md); you should read that root document before
you read this one, which provides subservient details.  Moreover, you
should read the [Muldis_Data_Language_Core](Muldis_Data_Language_Core.md) document before this current
document, as that forms its own tree beneath a root document branch.

# DESCRIPTION

These core routines are more special-purpose in nature and are intended for
use in working with the system catalog.

# FUNCTIONS FOR SIMPLE GENERIC SCALAR TYPES

## sys.std.Core.Cat.Order.reverse

`function reverse (Order <-- topic : Order) {...}`

This function results in the reverse value of its argument; an
`Order:Less` or `Order:More` argument results in the other one of
the two; an `Order:Same` argument results in itself.

## sys.std.Core.Cat.Order.conditional_reverse

`function conditional_reverse (Order <--
topic : Order, is_reverse_order : Bool) {...}`

This function results in the reverse value of its `topic` argument as per
`Order.reverse` iff its `is_reverse_order` argument is `Bool:True`;
otherwise this function simply results in `topic` itself.  This function
is intended for use in the definition of `order-determination` functions
where the definer wants to expend the minimal coding effort while
supporting the mandatory `is_reverse_order` parameter; they can just write
the fundamental function body once, for the normal ascending algorithm, and
pass the result of that algorithm through `Order.conditional_reverse`.

## sys.std.Core.Cat.Order.reduction

`function reduction (Order <-- topic? : array_of.Order) {...}`

This function results in the lowest-indexed of its N input element values
that isn't equal to `Order:Same`, if there is such an input value, and
otherwise it results in `Order:Same`.  It is a reduction operator that
recursively takes each consecutive pair of input values, for each pair
picking the lower-indexed one if that isn't equal to `Order:Same` and
otherwise picking the higher-indexed one (a process which is associative),
until just one is left, which is the result.  If `topic` has zero values,
then `Order.reduction` results in `Order:Same`, which is the identity
value for this operation.  The purpose of this function is to provide a
canonical terse way to chain invocations of multiple `order-determination`
functions to derive a larger such function, such as when you want to define
an `order-determination` function for a tuple type, which would then be
your control for sorting a relation as per a SQL "ORDER BY" or "RANK".
Note that this operation is also known as *reduction over order* or
`[<=>]`.

# ROUTINES FOR INVOKING ROUTINES

## sys.std.Core.Cat.func_invo

`function func_invo (Universal <--
function : APFunctionNC, args? : Tuple) {...}`

This function results in the result of invoking the other function named in
its `function` argument with arguments supplied by this function's `args`
argument; each attribute name of `args` is mapped to a parameter name of
the invoked function, and the corresponding attribute value is the
corresponding argument for the function invocation.  This function will
fail if the invoked function has any non-optional parameters such that
there aren't any corresponding attributes in `args`, or if there are any
attributes in `args` that don't have corresponding parameters, or if any
attribute values aren't of the declared types of the corresponding
parameters.  The purpose of `func_invo` is to support invocation of any
function whose name or parameters potentially aren't known until runtime;
it forms the foundation of all other system-defined functions that want to
invoke a function whose name they take as an argument.  The `args`
parameter is optional and defaults to the zero-attribute tuple if no
explicit argument is given to it.

## sys.std.Core.Cat.primed_func_invo

`function primed_func_invo (Universal <--
function : PrimedFuncNC) {...}`

This function is a simple wrapper for `func_invo` that has the latter's 2
parameters combined into a single binary tuple parameter.  It is likely
that `primed_func_invo` will see the most use in practice, as
`PrimedFuncNC` would be the type of choice for higher-order function
parameters of other routines.

## sys.std.Core.Cat.primed_func_static_exten

`function primed_func_static_exten (PrimedFuncNC <--
function : PrimedFuncNC, args : Tuple)`

This function results in the `PrimedFuncNC` value that is the same as its
`function` argument except that the value's `args` attribute has been
extended with the attributes given in the `args` argument.  This function
will fail if its `function` and `args` arguments have any same-named
arguments for the primed function.  Note that this operation is also known
as `assuming`.

## sys.std.Core.Cat.proc_invo

`procedure proc_invo (procedure : APProcedureNC,
&upd_args? : Tuple, ro_args? : Tuple) {...}`

This procedure has the same purpose and features as
`sys.std.Core.Cat.func_invo` but that it invokes a procedure rather than a
function; there is no result to deal with, and there are both
subject-to-update parameters and read-only parameters of the invoked
procedure to bind to; they are bound with the attributes of this
procedure's `upd_args` and `ro_args` arguments, respectively.  The
`ro_args` parameter is optional and defaults as per the `args` parameter
of `func_invo`; the `upd_args` parameter is non-optional if the invoked
is an updater, because an updater must always be invoked with at least one
subject-to-update argument, and it is optional otherwise.

# PROCEDURES FOR WORKING WITH EXCEPTIONS

## sys.std.Core.Cat.fail

`procedure fail (topic? : Exception) {...}`

This procedure will throw the exception given as its argument; this results
in the call stack unwinding, and transaction rollbacks, until it is caught.

# ROUTINES FOR SPECIAL ENTITY REFERENCE DEFAULT VALUES

These routines are defined primarily for use in the definitions of several
reference types that are references to routines; each one is an example
routines of an appropriate structure such that the reference types can use
references to these routines as their default values.

## sys.std.Core.Cat.pass_topic

`function pass_topic (Bool <-- topic : Universal) {...}`

This `value-filter` function unconditionally results in `Bool:True`
regardless of the values of its arguments.

## sys.std.Core.Cat.map_to_topic

`function map_to_topic (Universal <-- topic : Universal) {...}`

This `value-map` function unconditionally results in its `topic` argument
regardless of the values of its arguments.

## sys.std.Core.Cat.reduce_to_v1

`function reduce_to_v1 (Universal <-- v1 : Universal,
v2 : Universal) {...}`

This `value-reduction` function unconditionally results in its `v1`
argument regardless of the values of its arguments.

# RECIPES FOR BOOTSTRAPPING A MULDIS D PROGRAM OR DATABASE

These recipes comprise a set of commonly useful system-defined data
definition routines, which simplify some tasks of manipulating the Muldis D
system catalog dbvars.  The following recipes can do the following:
create|mount and drop|unmount depots,
create|drop subdepots, create|drop user-defined routines and
data types; they can not create or drop relvars.

# Recipes For Defining Depot Mounts

## sys.std.Core.Cat.create_depot_mount

`recipe create_depot_mount (name : Name,
scm_comment? : Comment, is_temporary? : Bool, create_on_mount? : Bool,
delete_on_unmount? : Bool, we_may_update? : Bool,
allow_auto_run? : Bool, details? : SysScaValExprNodeSet,
&mounts ::= mnt.cat.mounts) {...}`

This recipe is an abstraction over inserting a tuple into the catalog
relvar `mnt.cat.mounts`.  It will create a new depot mount in the DBMS
whose name is given by the `name` argument and whose other mount control
details match the other arguments; the mount may be for either an existing
depot or for a newly created one.  This recipe is analogous to a SQL
CONNECT statement or SQLite ATTACH statement.

## sys.std.Core.Cat.drop_depot_mount

`recipe drop_depot_mount (name : Name,
&mounts ::= mnt.cat.mounts) {...}`

This recipe is an abstraction over deleting a tuple from the catalog
relvar `mnt.cat.mounts`.  It will drop an existing depot mount from the
DBMS whose name is given by the argument; the depot behind the mount may
then either cease to exist or persist on.  This recipe is analogous to a
SQL DISCONNECT statement or SQLite DETACH statement.

## sys.std.Core.Cat.alter_depot_mount_so_we_may_not_update

`recipe alter_depot_mount_so_we_may_not_update
(name : Name, &mounts ::= mnt.cat.mounts) {...}`

This recipe is an abstraction over updating a tuple of the catalog
relvar `mnt.cat.mounts` such that its `we_may_update` attribute is made
`Bool:False`.

# Recipes For Defining In-Depot Namespaces

## sys.std.Core.Cat.create_subdepot

`recipe create_subdepot (depot : Name,
parent? : NameChain, name : Name, scm_comment? : Comment,
scm_vis_ord? : NNInt, &cat ::= fed.cat, &data ::= fed.data) {...}`

This recipe is an abstraction over inserting a tuple into the catalog
relvar `fed.cat.mounts{name=depot}.depot.subdepots`.  It will create a
new subdepot, in the depot mounted under the name given by the `depot`
argument, whose name and other details match the other arguments.  This
recipe is analogous to a SQL CREATE SCHEMA statement or an Oracle CREATE
PACKAGE statement.

## sys.std.Core.Cat.drop_subdepot

`recipe drop_subdepot (depot : Name,
parent? : NameChain, name : Name,
&cat ::= fed.cat, &data ::= fed.data) {...}`

This recipe is an abstraction over deleting a tuple from the catalog
relvar `fed.cat.mounts{name=depot}.depot.subdepots`.  It will drop an
existing subdepot.  This recipe is analogous to a SQL DROP SCHEMA
statement or an Oracle DROP PACKAGE statement.

# Recipes For Defining Depot Materials

## sys.std.Core.Cat.create_function

`recipe create_function (depot : Name,
subdepot? : NameChain, name : Name,
scm_comment? : Comment, scm_vis_ord? : NNInt,
material : Function, &cat ::= fed.cat, &data ::= fed.data) {...}`

This recipe is an abstraction over inserting a tuple into the catalog
relvar `fed.cat.mounts{name=depot}.depot.functions`.  It will create a
new function, in the depot mounted under the name given by the `depot`
argument, whose name and other details match the other arguments.  This
recipe is analogous to a SQL CREATE FUNCTION statement.

## sys.std.Core.Cat.drop_function

`recipe drop_function (depot : Name,
subdepot? : NameChain, name : Name,
&cat ::= fed.cat, &data ::= fed.data) {...}`

This recipe is an abstraction over deleting a tuple from the catalog relvar
`fed.cat.mounts{name=depot}.depot.functions`.  It will drop an existing
depot function.  This recipe is analogous to a SQL DROP FUNCTION statement.

## sys.std.Core.Cat.create_procedure

`recipe create_procedure (depot : Name,
subdepot? : NameChain, name : Name,
scm_comment? : Comment, scm_vis_ord? : NNInt,
material : Procedure, &cat ::= fed.cat) {...}`

This recipe is an abstraction over inserting a tuple into the catalog
relvar `fed.cat.mounts{name=depot}.depot.procedures`.
It will create a new procedure, in the depot mounted under
the name given by the `depot` argument, whose name and other details match
the other arguments.  This recipe is analogous to a SQL CREATE PROCEDURE
statement.

## sys.std.Core.Cat.drop_procedure

`recipe drop_procedure (depot : Name,
subdepot? : NameChain, name : Name, &cat ::= fed.cat) {...}`

This recipe is an abstraction over deleting a tuple from the catalog relvar
`fed.cat.mounts{name=depot}.depot.procedures`.  It will
drop an existing depot procedure.  This recipe is analogous
to a SQL DROP PROCEDURE statement.

## sys.std.Core.Cat.create_[scalar|tuple|relation|domain|subset|mixin]_type

`recipe create_[scalar|tuple|relation|domain|subset|mixin]_type
(depot : Name, subdepot? : NameChain, name : Name,
scm_comment? : Comment, scm_vis_ord? : NNInt,
material : [Scalar|Tuple|Relation|Domain|Subset|Mixin]Type,
&cat ::= fed.cat, &data ::= fed.data) {...}`

This recipe is an abstraction over inserting a tuple into the catalog
relvar `fed.cat.mounts{name=depot}.depot
.[scalar|tuple|relation|domain|subset|mixin]_types`.
It will create a new type, in the depot mounted under the name given by the
`depot` argument, whose name and other details match the other arguments.
This recipe is analogous to a SQL CREATE TYPE|DOMAIN statement.

## sys.std.Core.Cat.drop_[scalar|tuple|relation|domain|subset|mixin]_type

`recipe drop_[scalar|tuple|relation|domain|subset|mixin]_type
(depot : Name, subdepot? : NameChain, name : Name,
&cat ::= fed.cat, &data ::= fed.data) {...}`

This recipe is an abstraction over deleting a tuple from the catalog relvar
`fed.cat.mounts{name=depot}.depot
.[scalar|tuple|relation|domain|subset|mixin]_types`.
It will drop an existing depot type.  This recipe is analogous to a SQL
DROP TYPE|DOMAIN statement.

## sys.std.Core.Cat.create_[|distrib_][key|subset]_constr

`recipe create_[|distrib_][key|subset]_constr
(depot : Name, subdepot? : NameChain, name : Name,
scm_comment? : Comment, scm_vis_ord? : NNInt,
material : [|Distrib][Key|Subset]Constr,
&cat ::= fed.cat, &data ::= fed.data) {...}`

This recipe is an abstraction over inserting a tuple into the catalog
relvar
`fed.cat.mounts{name=depot}.depot.[|distrib_][key|subset]_constrs`.
It will create a new constraint, in the depot mounted under the name given
by the `depot` argument, whose name and other details match the other
arguments.

## sys.std.Core.Cat.drop_[|distrib_][key|subset]_constr

`recipe drop_[|distrib_][key|subset]_constr
(depot : Name, subdepot? : NameChain, name : Name,
&cat ::= fed.cat, &data ::= fed.data) {...}`

This recipe is an abstraction over deleting a tuple from the catalog relvar
`fed.cat.mounts{name=depot}.depot.[|distrib_][key|subset]_constrs`.
It will drop an existing depot constraint.

## sys.std.Core.Cat.create_stim_resp_rule

`recipe create_stim_resp_rule (depot : Name,
subdepot? : NameChain, name : Name, scm_comment? : Comment,
scm_vis_ord? : NNInt, material : StimRespRule, &cat ::= fed.cat) {...}`

This recipe is an abstraction over inserting a tuple into the catalog
relvar `fed.cat.mounts{name=depot}.depot.stim_resp_rules`.  It will
create a new stimulus-response rule, in the depot mounted under the name
given by the `depot` argument, whose name and other details match the
other arguments.  This recipe is analogous to a SQL CREATE TRIGGER
statement.

## sys.std.Core.Cat.drop_stim_resp_rule

`recipe drop_stim_resp_rule (depot : Name,
subdepot? : NameChain, name : Name, &cat ::= fed.cat) {...}`

This recipe is an abstraction over deleting a tuple from the catalog relvar
`fed.cat.mounts{name=depot}.depot.stim_resp_rules`.  It will drop an
existing depot stimulus-response rule.  This recipe is analogous to a SQL
DROP TRIGGER statement.

# SYSTEM-DEFINED CONSTRAINT MATERIALS

## sys.std.Core.Cat.nil_key_constr

`key-constraint nil_key_constr {}`

This is a unique key constraint or candidate key, for a relation type,
which ranges over zero attributes, and is not designated a *primary key*.
This exists as a `key-constraint` material as a convenience for the
definition of relation types whose values are allowed to have at most one
tuple (`Maybe` being an example).

## sys.std.Core.Cat.nil_prim_key

`key-constraint nil_prim_key {}`

This is exactly the same as `sys.std.Core.Cat.nil_key_constr`, a key over
zero attributes, but that it *is* designated a *primary key*.

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification of the Muldis D language.

Muldis D is Copyright © 2002-2011, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Muldis_Data_Language](Muldis_Data_Language.md) for details.
