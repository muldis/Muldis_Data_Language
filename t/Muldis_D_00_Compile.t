use 5.008001;
use utf8;
use strict;
use warnings FATAL => 'all';

use version 0.74;

use Test::More;

plan( 'tests' => 2 );

use_ok( 'Muldis::D' );
is( $Muldis::D::VERSION, qv('0.56.0'),
    'Muldis::D is the correct version' );

1; # Magic true value required at end of a reusable file's code.
