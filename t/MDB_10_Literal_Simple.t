use 5.008001;
use utf8;
use strict;
use warnings FATAL => 'all';

use Test::More;

use Muldis::DB::Literal;

main();

###########################################################################

sub main {

    plan( 'tests' => 62 ); # 17 more than Perl 6 version, which has 45

    print "#### Starting test of Muldis::DB::Literal Simple ####\n";

    test_Literal_Bool();
    test_Literal_Order();
    test_Literal_Int();
    test_Literal_Blob();
    test_Literal_Text();

    print "#### Finished test of Muldis::DB::Literal Simple ####\n";

    return;
}

###########################################################################

sub test_Literal_Bool {

    my ($in, $node, $out);

    $in = undef;
    eval {
        $node = Muldis::DB::Literal::Bool->new({ 'v' => $in });
    };
    ok( $@, q{Literal::Bool rejects invalid payload undef} );

    $in = (2 + 2 == 3);
    $node = Muldis::DB::Literal::Bool->new({ 'v' => $in });
    pass( q{Literal::Bool accepts valid payload Bool:False} );
    isa_ok( $node, 'Muldis::DB::Literal::Bool' );
    $out = $node->v();
    is( $out, $in, q{Literal::Bool preserves valid payload} );

    $in = (2 + 2 == 4);
    $node = Muldis::DB::Literal::Bool->new({ 'v' => $in });
    pass( q{Literal::Bool accepts valid payload Bool:True} );
    isa_ok( $node, 'Muldis::DB::Literal::Bool' );
    $out = $node->v();
    is( $out, $in, q{Literal::Bool preserves valid payload} );

    $in = 'foo';
    eval {
        $node = Muldis::DB::Literal::Bool->new({ 'v' => $in });
    };
    ok( $@, q{Literal::Bool rejects invalid payload 'foo'} );

    $in = 42;
    eval {
        $node = Muldis::DB::Literal::Bool->new({ 'v' => $in });
    };
    ok( $@, q{Literal::Bool rejects invalid payload 42} );

    return;
}

###########################################################################

sub test_Literal_Order {
    return;
}

###########################################################################

sub test_Literal_Int {

    my ($in, $node, $out);

    $in = undef;
    eval {
        $node = Muldis::DB::Literal::Int->new({ 'v' => $in });
    };
    ok( $@, q{Literal::Int rejects invalid payload undef} );

    $in = '';
    eval {
        $node = Muldis::DB::Literal::Int->new({ 'v' => $in });
    };
    ok( $@, q{Literal::Int rejects invalid payload ''} );

    $in = 0;
    $node = Muldis::DB::Literal::Int->new({ 'v' => $in });
    pass( q{Literal::Int accepts valid payload 0} );
    isa_ok( $node, 'Muldis::DB::Literal::Int' );
    $out = $node->v();
    is( $out, $in, q{Literal::Int preserves valid payload} );

    $in = '0';
    $node = Muldis::DB::Literal::Int->new({ 'v' => $in });
    pass( q{Literal::Int accepts valid payload '0'} );
    isa_ok( $node, 'Muldis::DB::Literal::Int' );
    $out = $node->v();
    is( $out, $in, q{Literal::Int preserves valid payload} );

    $in = '0.0';
    eval {
        $node = Muldis::DB::Literal::Int->new({ 'v' => $in });
    };
    ok( $@, q{Literal::Int rejects invalid payload '0.0'} );

    $in = '00';
    eval {
        $node = Muldis::DB::Literal::Int->new({ 'v' => $in });
    };
    ok( $@, q{Literal::Int rejects invalid payload '00'} );

    $in = '-0';
    eval {
        $node = Muldis::DB::Literal::Int->new({ 'v' => $in });
    };
    ok( $@, q{Literal::Int rejects invalid payload '-0'} );

    $in = 42;
    $node = Muldis::DB::Literal::Int->new({ 'v' => $in });
    pass( q{Literal::Int accepts valid payload 42} );
    isa_ok( $node, 'Muldis::DB::Literal::Int' );
    $out = $node->v();
    is( $out, $in, q{Literal::Int preserves valid payload} );

    $in = '42';
    $node = Muldis::DB::Literal::Int->new({ 'v' => $in });
    pass( q{Literal::Int accepts valid payload '42'} );
    isa_ok( $node, 'Muldis::DB::Literal::Int' );
    $out = $node->v();
    is( $out, $in, q{Literal::Int preserves valid payload} );

    $in = -42;
    $node = Muldis::DB::Literal::Int->new({ 'v' => $in });
    pass( q{Literal::Int accepts valid payload 42} );
    isa_ok( $node, 'Muldis::DB::Literal::Int' );
    $out = $node->v();
    is( $out, $in, q{Literal::Int preserves valid payload} );

    $in = '-42';
    $node = Muldis::DB::Literal::Int->new({ 'v' => $in });
    pass( q{Literal::Int accepts valid payload '-42'} );
    isa_ok( $node, 'Muldis::DB::Literal::Int' );
    $out = $node->v();
    is( $out, $in, q{Literal::Int preserves valid payload} );

    $in = '042';
    eval {
        $node = Muldis::DB::Literal::Int->new({ 'v' => $in });
    };
    ok( $@, q{Literal::Int rejects invalid payload '042'} );

    $in = '420';
    $node = Muldis::DB::Literal::Int->new({ 'v' => $in });
    pass( q{Literal::Int accepts valid payload '420'} );
    isa_ok( $node, 'Muldis::DB::Literal::Int' );
    $out = $node->v();
    is( $out, $in, q{Literal::Int preserves valid payload} );

    $in = 'foo';
    eval {
        $node = Muldis::DB::Literal::Int->new({ 'v' => $in });
    };
    ok( $@, q{Literal::Int rejects invalid payload 'foo'} );

    $in = ' 3';
    eval {
        $node = Muldis::DB::Literal::Int->new({ 'v' => $in });
    };
    ok( $@, q{Literal::Int rejects invalid payload ' 3'} );

    $in = 4.5;
    eval {
        $node = Muldis::DB::Literal::Int->new({ 'v' => $in });
    };
    ok( $@, q{Literal::Int rejects invalid payload 4.5} );

    $in = '4.5';
    eval {
        $node = Muldis::DB::Literal::Int->new({ 'v' => $in });
    };
    ok( $@, q{Literal::Int rejects invalid payload '4.5'} );

    return;
}

###########################################################################

sub test_Literal_Blob {

    my ($in, $node, $out);

    $in = undef;
    eval {
        $node = Muldis::DB::Literal::Blob->new({ 'v' => $in });
    };
    ok( $@, q{Literal::Blob rejects invalid payload undef} );

    $in = '';
    $node = Muldis::DB::Literal::Blob->new({ 'v' => $in });
    pass( q{Literal::Blob accepts valid payload ''} );
    isa_ok( $node, 'Muldis::DB::Literal::Blob' );
    $out = $node->v();
    is( $out, $in, q{Literal::Blob preserves valid payload} );

    $in = 'Ceres';
    $node = Muldis::DB::Literal::Blob->new({ 'v' => $in });
    pass( q{Literal::Blob accepts valid payload ASCII 'Ceres'} );
    isa_ok( $node, 'Muldis::DB::Literal::Blob' );
    $out = $node->v();
    is( $out, $in, q{Literal::Blob preserves valid payload} );

    $in = 'サンプル';
    eval {
        $node = Muldis::DB::Literal::Blob->new({ 'v' => $in });
    };
    ok( $@, q{Literal::Blob rejects invalid payload Unicode 'サンプル'} );

    $in = pack 'H2', '\xCC';
    $node = Muldis::DB::Literal::Blob->new({ 'v' => $in });
    pass( q{Literal::Blob accepts valid payload pack 'H2', '\xCC'} );
    isa_ok( $node, 'Muldis::DB::Literal::Blob' );
    $out = $node->v();
    is( $out, $in, q{Literal::Blob preserves valid payload} );

    return;
}

###########################################################################

sub test_Literal_Text {

    my ($in, $node, $out);

    $in = undef;
    eval {
        $node = Muldis::DB::Literal::Text->new({ 'v' => $in });
    };
    ok( $@, q{Literal::Text rejects invalid payload undef} );

    $in = '';
    $node = Muldis::DB::Literal::Text->new({ 'v' => $in });
    pass( q{Literal::Text accepts valid payload ''} );
    isa_ok( $node, 'Muldis::DB::Literal::Text' );
    $out = $node->v();
    is( $out, $in, q{Literal::Text preserves valid payload} );

    $in = 'Ceres';
    $node = Muldis::DB::Literal::Text->new({ 'v' => $in });
    pass( q{Literal::Text accepts valid payload ASCII 'Ceres'} );
    isa_ok( $node, 'Muldis::DB::Literal::Text' );
    $out = $node->v();
    is( $out, $in, q{Literal::Text preserves valid payload} );

    $in = 'サンプル';
    $node = Muldis::DB::Literal::Text->new({ 'v' => $in });
    pass( q{Literal::Text accepts valid payload Unicode 'サンプル'} );
    isa_ok( $node, 'Muldis::DB::Literal::Text' );
    $out = $node->v();
    is( $out, $in, q{Literal::Text preserves valid payload} );

    $in = pack 'H2', '\xCC';
    eval {
        $node = Muldis::DB::Literal::Text->new({ 'v' => $in });
    };
    ok( $@, q{Literal::Text rejects invalid payload pack 'H2', '\xCC'} );

    return;
}

###########################################################################

1; # Magic true value required at end of a reusable file's code.
