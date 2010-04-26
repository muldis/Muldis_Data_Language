use 5.006;
use strict;
use warnings;

use Test;

BEGIN { plan tests => 2 }

use Muldis::D;
ok(1);

ok( $Muldis::D::VERSION, 0.122000 );

1;
