use 5.008001;
use utf8;
use strict;
use warnings FATAL => 'all';

use Test::More;

use Muldis::DB::AST
    qw(newBoolLit newOrderLit newIntLit newBlobLit newTextLit);

main();

######################################################################

sub main {

    plan( 'tests' => 62 ); # 17 more than Perl 6 version, which has 45

    print "#### Starting test of Muldis::DB::AST Literals ####\n";

    test_BoolLit();
    test_OrderLit();
    test_IntLit();
    test_BlobLit();
    test_TextLit();

    print "#### Finished test of Muldis::DB::AST Literals ####\n";

    return;
}

######################################################################

sub test_BoolLit {

    my ($in, $node, $out);

    $in = undef;
    eval {
        $node = newBoolLit({ 'v' => $in });
    };
    ok( $@, q{BoolLit rejects invalid payload undef} );

    $in = (2 + 2 == 3);
    $node = newBoolLit({ 'v' => $in });
    pass( q{BoolLit accepts valid payload Bool:False} );
    isa_ok( $node, 'Muldis::DB::AST::BoolLit' );
    $out = $node->v();
    is( $out, $in, q{BoolLit preserves valid payload} );

    $in = (2 + 2 == 4);
    $node = newBoolLit({ 'v' => $in });
    pass( q{BoolLit accepts valid payload Bool:True} );
    isa_ok( $node, 'Muldis::DB::AST::BoolLit' );
    $out = $node->v();
    is( $out, $in, q{BoolLit preserves valid payload} );

    $in = 'foo';
    eval {
        $node = newBoolLit({ 'v' => $in });
    };
    ok( $@, q{BoolLit rejects invalid payload 'foo'} );

    $in = 42;
    eval {
        $node = newBoolLit({ 'v' => $in });
    };
    ok( $@, q{BoolLit rejects invalid payload 42} );

    return;
}

######################################################################

sub test_OrderLit {
    return;
}

######################################################################

sub test_IntLit {

    my ($in, $node, $out);

    $in = undef;
    eval {
        $node = newIntLit({ 'v' => $in });
    };
    ok( $@, q{IntLit rejects invalid payload undef} );

    $in = '';
    eval {
        $node = newIntLit({ 'v' => $in });
    };
    ok( $@, q{IntLit rejects invalid payload ''} );

    $in = 0;
    $node = newIntLit({ 'v' => $in });
    pass( q{IntLit accepts valid payload 0} );
    isa_ok( $node, 'Muldis::DB::AST::IntLit' );
    $out = $node->v();
    is( $out, $in, q{IntLit preserves valid payload} );

    $in = '0';
    $node = newIntLit({ 'v' => $in });
    pass( q{IntLit accepts valid payload '0'} );
    isa_ok( $node, 'Muldis::DB::AST::IntLit' );
    $out = $node->v();
    is( $out, $in, q{IntLit preserves valid payload} );

    $in = '0.0';
    eval {
        $node = newIntLit({ 'v' => $in });
    };
    ok( $@, q{IntLit rejects invalid payload '0.0'} );

    $in = '00';
    eval {
        $node = newIntLit({ 'v' => $in });
    };
    ok( $@, q{IntLit rejects invalid payload '00'} );

    $in = '-0';
    eval {
        $node = newIntLit({ 'v' => $in });
    };
    ok( $@, q{IntLit rejects invalid payload '-0'} );

    $in = 42;
    $node = newIntLit({ 'v' => $in });
    pass( q{IntLit accepts valid payload 42} );
    isa_ok( $node, 'Muldis::DB::AST::IntLit' );
    $out = $node->v();
    is( $out, $in, q{IntLit preserves valid payload} );

    $in = '42';
    $node = newIntLit({ 'v' => $in });
    pass( q{IntLit accepts valid payload '42'} );
    isa_ok( $node, 'Muldis::DB::AST::IntLit' );
    $out = $node->v();
    is( $out, $in, q{IntLit preserves valid payload} );

    $in = -42;
    $node = newIntLit({ 'v' => $in });
    pass( q{IntLit accepts valid payload 42} );
    isa_ok( $node, 'Muldis::DB::AST::IntLit' );
    $out = $node->v();
    is( $out, $in, q{IntLit preserves valid payload} );

    $in = '-42';
    $node = newIntLit({ 'v' => $in });
    pass( q{IntLit accepts valid payload '-42'} );
    isa_ok( $node, 'Muldis::DB::AST::IntLit' );
    $out = $node->v();
    is( $out, $in, q{IntLit preserves valid payload} );

    $in = '042';
    eval {
        $node = newIntLit({ 'v' => $in });
    };
    ok( $@, q{IntLit rejects invalid payload '042'} );

    $in = '420';
    $node = newIntLit({ 'v' => $in });
    pass( q{IntLit accepts valid payload '420'} );
    isa_ok( $node, 'Muldis::DB::AST::IntLit' );
    $out = $node->v();
    is( $out, $in, q{IntLit preserves valid payload} );

    $in = 'foo';
    eval {
        $node = newIntLit({ 'v' => $in });
    };
    ok( $@, q{IntLit rejects invalid payload 'foo'} );

    $in = ' 3';
    eval {
        $node = newIntLit({ 'v' => $in });
    };
    ok( $@, q{IntLit rejects invalid payload ' 3'} );

    $in = 4.5;
    eval {
        $node = newIntLit({ 'v' => $in });
    };
    ok( $@, q{IntLit rejects invalid payload 4.5} );

    $in = '4.5';
    eval {
        $node = newIntLit({ 'v' => $in });
    };
    ok( $@, q{IntLit rejects invalid payload '4.5'} );

    return;
}

######################################################################

sub test_BlobLit {

    my ($in, $node, $out);

    $in = undef;
    eval {
        $node = newBlobLit({ 'v' => $in });
    };
    ok( $@, q{BlobLit rejects invalid payload undef} );

    $in = '';
    $node = newBlobLit({ 'v' => $in });
    pass( q{BlobLit accepts valid payload ''} );
    isa_ok( $node, 'Muldis::DB::AST::BlobLit' );
    $out = $node->v();
    is( $out, $in, q{BlobLit preserves valid payload} );

    $in = 'Ceres';
    $node = newBlobLit({ 'v' => $in });
    pass( q{BlobLit accepts valid payload ASCII 'Ceres'} );
    isa_ok( $node, 'Muldis::DB::AST::BlobLit' );
    $out = $node->v();
    is( $out, $in, q{BlobLit preserves valid payload} );

    $in = 'サンプル';
    eval {
        $node = newBlobLit({ 'v' => $in });
    };
    ok( $@, q{BlobLit rejects invalid payload Unicode 'サンプル'} );

    $in = pack 'H2', '\xCC';
    $node = newBlobLit({ 'v' => $in });
    pass( q{BlobLit accepts valid payload pack 'H2', '\xCC'} );
    isa_ok( $node, 'Muldis::DB::AST::BlobLit' );
    $out = $node->v();
    is( $out, $in, q{BlobLit preserves valid payload} );

    return;
}

######################################################################

sub test_TextLit {

    my ($in, $node, $out);

    $in = undef;
    eval {
        $node = newTextLit({ 'v' => $in });
    };
    ok( $@, q{TextLit rejects invalid payload undef} );

    $in = '';
    $node = newTextLit({ 'v' => $in });
    pass( q{TextLit accepts valid payload ''} );
    isa_ok( $node, 'Muldis::DB::AST::TextLit' );
    $out = $node->v();
    is( $out, $in, q{TextLit preserves valid payload} );

    $in = 'Ceres';
    $node = newTextLit({ 'v' => $in });
    pass( q{TextLit accepts valid payload ASCII 'Ceres'} );
    isa_ok( $node, 'Muldis::DB::AST::TextLit' );
    $out = $node->v();
    is( $out, $in, q{TextLit preserves valid payload} );

    $in = 'サンプル';
    $node = newTextLit({ 'v' => $in });
    pass( q{TextLit accepts valid payload Unicode 'サンプル'} );
    isa_ok( $node, 'Muldis::DB::AST::TextLit' );
    $out = $node->v();
    is( $out, $in, q{TextLit preserves valid payload} );

    $in = pack 'H2', '\xCC';
    eval {
        $node = newTextLit({ 'v' => $in });
    };
    ok( $@, q{TextLit rejects invalid payload pack 'H2', '\xCC'} );

    return;
}

######################################################################

1; # Magic true value required at end of a reusable file's code.
