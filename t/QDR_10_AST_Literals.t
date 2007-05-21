use 5.008001;
use utf8;
use strict;
use warnings FATAL => 'all';

use Test::More;

use QDRDBMS::AST qw(newLitBool newLitText newLitBlob newLitInt);

main();

######################################################################

sub main {

    plan( 'tests' => 62 ); # 17 more than Perl 6 version, which has 45

    print "#### Starting test of QDRDBMS::AST Literals ####\n";

    test_LitBool();
    test_LitText();
    test_LitBlob();
    test_LitInt();

    print "#### Finished test of QDRDBMS::AST Literals ####\n";

    return;
}

######################################################################

sub test_LitBool {

    my ($in, $node, $out);

    $in = undef;
    eval {
        $node = newLitBool({ 'v' => $in });
    };
    ok( $@, q{LitBool rejects invalid payload undef} );

    $in = (2 + 2 == 3);
    $node = newLitBool({ 'v' => $in });
    pass( q{LitBool accepts valid payload Bool:False} );
    isa_ok( $node, 'QDRDBMS::AST::LitBool' );
    $out = $node->v();
    is( $out, $in, q{LitBool preserves valid payload} );

    $in = (2 + 2 == 4);
    $node = newLitBool({ 'v' => $in });
    pass( q{LitBool accepts valid payload Bool:True} );
    isa_ok( $node, 'QDRDBMS::AST::LitBool' );
    $out = $node->v();
    is( $out, $in, q{LitBool preserves valid payload} );

    $in = 'foo';
    eval {
        $node = newLitBool({ 'v' => $in });
    };
    ok( $@, q{LitBool rejects invalid payload 'foo'} );

    $in = 42;
    eval {
        $node = newLitBool({ 'v' => $in });
    };
    ok( $@, q{LitBool rejects invalid payload 42} );

    return;
}

######################################################################

sub test_LitText {

    my ($in, $node, $out);

    $in = undef;
    eval {
        $node = newLitText({ 'v' => $in });
    };
    ok( $@, q{LitText rejects invalid payload undef} );

    $in = '';
    $node = newLitText({ 'v' => $in });
    pass( q{LitText accepts valid payload ''} );
    isa_ok( $node, 'QDRDBMS::AST::LitText' );
    $out = $node->v();
    is( $out, $in, q{LitText preserves valid payload} );

    $in = 'Ceres';
    $node = newLitText({ 'v' => $in });
    pass( q{LitText accepts valid payload ASCII 'Ceres'} );
    isa_ok( $node, 'QDRDBMS::AST::LitText' );
    $out = $node->v();
    is( $out, $in, q{LitText preserves valid payload} );

    $in = 'サンプル';
    $node = newLitText({ 'v' => $in });
    pass( q{LitText accepts valid payload Unicode 'サンプル'} );
    isa_ok( $node, 'QDRDBMS::AST::LitText' );
    $out = $node->v();
    is( $out, $in, q{LitText preserves valid payload} );

    $in = pack 'H2', '\xCC';
    eval {
        $node = newLitText({ 'v' => $in });
    };
    ok( $@, q{LitText rejects invalid payload pack 'H2', '\xCC'} );

    return;
}

######################################################################

sub test_LitBlob {

    my ($in, $node, $out);

    $in = undef;
    eval {
        $node = newLitBlob({ 'v' => $in });
    };
    ok( $@, q{LitBlob rejects invalid payload undef} );

    $in = '';
    $node = newLitBlob({ 'v' => $in });
    pass( q{LitBlob accepts valid payload ''} );
    isa_ok( $node, 'QDRDBMS::AST::LitBlob' );
    $out = $node->v();
    is( $out, $in, q{LitBlob preserves valid payload} );

    $in = 'Ceres';
    $node = newLitBlob({ 'v' => $in });
    pass( q{LitBlob accepts valid payload ASCII 'Ceres'} );
    isa_ok( $node, 'QDRDBMS::AST::LitBlob' );
    $out = $node->v();
    is( $out, $in, q{LitBlob preserves valid payload} );

    $in = 'サンプル';
    eval {
        $node = newLitBlob({ 'v' => $in });
    };
    ok( $@, q{LitBlob rejects invalid payload Unicode 'サンプル'} );

    $in = pack 'H2', '\xCC';
    $node = newLitBlob({ 'v' => $in });
    pass( q{LitBlob accepts valid payload pack 'H2', '\xCC'} );
    isa_ok( $node, 'QDRDBMS::AST::LitBlob' );
    $out = $node->v();
    is( $out, $in, q{LitBlob preserves valid payload} );

    return;
}

######################################################################

sub test_LitInt {

    my ($in, $node, $out);

    $in = undef;
    eval {
        $node = newLitInt({ 'v' => $in });
    };
    ok( $@, q{LitInt rejects invalid payload undef} );

    $in = '';
    eval {
        $node = newLitInt({ 'v' => $in });
    };
    ok( $@, q{LitInt rejects invalid payload ''} );

    $in = 0;
    $node = newLitInt({ 'v' => $in });
    pass( q{LitInt accepts valid payload 0} );
    isa_ok( $node, 'QDRDBMS::AST::LitInt' );
    $out = $node->v();
    is( $out, $in, q{LitInt preserves valid payload} );

    $in = '0';
    $node = newLitInt({ 'v' => $in });
    pass( q{LitInt accepts valid payload '0'} );
    isa_ok( $node, 'QDRDBMS::AST::LitInt' );
    $out = $node->v();
    is( $out, $in, q{LitInt preserves valid payload} );

    $in = '0.0';
    eval {
        $node = newLitInt({ 'v' => $in });
    };
    ok( $@, q{LitInt rejects invalid payload '0.0'} );

    $in = '00';
    eval {
        $node = newLitInt({ 'v' => $in });
    };
    ok( $@, q{LitInt rejects invalid payload '00'} );

    $in = '-0';
    eval {
        $node = newLitInt({ 'v' => $in });
    };
    ok( $@, q{LitInt rejects invalid payload '-0'} );

    $in = 42;
    $node = newLitInt({ 'v' => $in });
    pass( q{LitInt accepts valid payload 42} );
    isa_ok( $node, 'QDRDBMS::AST::LitInt' );
    $out = $node->v();
    is( $out, $in, q{LitInt preserves valid payload} );

    $in = '42';
    $node = newLitInt({ 'v' => $in });
    pass( q{LitInt accepts valid payload '42'} );
    isa_ok( $node, 'QDRDBMS::AST::LitInt' );
    $out = $node->v();
    is( $out, $in, q{LitInt preserves valid payload} );

    $in = -42;
    $node = newLitInt({ 'v' => $in });
    pass( q{LitInt accepts valid payload 42} );
    isa_ok( $node, 'QDRDBMS::AST::LitInt' );
    $out = $node->v();
    is( $out, $in, q{LitInt preserves valid payload} );

    $in = '-42';
    $node = newLitInt({ 'v' => $in });
    pass( q{LitInt accepts valid payload '-42'} );
    isa_ok( $node, 'QDRDBMS::AST::LitInt' );
    $out = $node->v();
    is( $out, $in, q{LitInt preserves valid payload} );

    $in = '042';
    eval {
        $node = newLitInt({ 'v' => $in });
    };
    ok( $@, q{LitInt rejects invalid payload '042'} );

    $in = '420';
    $node = newLitInt({ 'v' => $in });
    pass( q{LitInt accepts valid payload '420'} );
    isa_ok( $node, 'QDRDBMS::AST::LitInt' );
    $out = $node->v();
    is( $out, $in, q{LitInt preserves valid payload} );

    $in = 'foo';
    eval {
        $node = newLitInt({ 'v' => $in });
    };
    ok( $@, q{LitInt rejects invalid payload 'foo'} );

    $in = ' 3';
    eval {
        $node = newLitInt({ 'v' => $in });
    };
    ok( $@, q{LitInt rejects invalid payload ' 3'} );

    $in = 4.5;
    eval {
        $node = newLitInt({ 'v' => $in });
    };
    ok( $@, q{LitInt rejects invalid payload 4.5} );

    $in = '4.5';
    eval {
        $node = newLitInt({ 'v' => $in });
    };
    ok( $@, q{LitInt rejects invalid payload '4.5'} );

    return;
}

######################################################################

1; # Magic true value required at end of a reuseable file's code.
