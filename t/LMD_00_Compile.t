use 5.008001;
use utf8;
use strict;
use warnings FATAL => 'all';

use Test::More;

plan( 'tests' => 2 );

use_ok( 'Language::MuldisD' );
is( $Language::MuldisD::VERSION, 0.010000,
    'Language::MuldisD is the correct version' );

1; # Magic true value required at end of a reusable file's code.
