use 5.008001;
use utf8;
use strict;
use warnings FATAL => 'all';

use Test::More;

plan( 'tests' => 12 );

use_ok( 'Muldis::DB::Literal' );
is( $Muldis::DB::Literal::VERSION, 0.002000,
    'Muldis::DB::Literal is the correct version' );

use_ok( 'Muldis::DB::Interface' );
is( $Muldis::DB::Interface::VERSION, 0.002000,
    'Muldis::DB::Interface is the correct version' );

use_ok( 'Muldis::DB::Validator' );
is( $Muldis::DB::Validator::VERSION, 0.002000,
    'Muldis::DB::Validator is the correct version' );

use_ok( 'Muldis::DB::Engine::Example::PhysType' );
is( $Muldis::DB::Engine::Example::PhysType::VERSION, 0.002000,
    'Muldis::DB::Engine::Example::PhysType is the correct version' );

use_ok( 'Muldis::DB::Engine::Example::Operators' );
is( $Muldis::DB::Engine::Example::Operators::VERSION, 0.002000,
    'Muldis::DB::Engine::Example::Operators is the correct version' );

use_ok( 'Muldis::DB::Engine::Example' );
is( $Muldis::DB::Engine::Example::VERSION, 0.002000,
    'Muldis::DB::Engine::Example is the correct version' );

1; # Magic true value required at end of a reusable file's code.
