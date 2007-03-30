use 5.008001;
use utf8;
use strict;
use warnings FATAL => 'all';

use Test::More;

plan( 'tests' => 14 );

use_ok( 'QDRDBMS::Util' );
is( $QDRDBMS::Util::VERSION, 0.000,
    'QDRDBMS::Util is the correct version' );

use_ok( 'QDRDBMS::Value' );
is( $QDRDBMS::Value::VERSION, 0.000,
    'QDRDBMS::Value is the correct version' );

use_ok( 'QDRDBMS::Model' );
is( $QDRDBMS::Model::VERSION, 0.000,
    'QDRDBMS::Model is the correct version' );

use_ok( 'QDRDBMS' );
is( $QDRDBMS::VERSION, 0.000,
    'QDRDBMS is the correct version' );

use_ok( 'QDRDBMS::Validator' );
is( $QDRDBMS::Validator::VERSION, 0.000,
    'QDRDBMS::Validator is the correct version' );

use_ok( 'QDRDBMS::Engine::Example::PhysType' );
is( $QDRDBMS::Engine::Example::PhysType::VERSION, 0.000,
    'QDRDBMS::Engine::Example::PhysType is the correct version' );

use_ok( 'QDRDBMS::Engine::Example' );
is( $QDRDBMS::Engine::Example::VERSION, 0.000,
    'QDRDBMS::Engine::Example is the correct version' );

1; # Magic true value required at end of a reuseable file's code.
