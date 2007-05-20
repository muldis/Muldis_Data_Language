use 5.008001;
use utf8;
use strict;
use warnings FATAL => 'all';

use Test::More;

use QDRDBMS::AST qw(LitBool LitText LitBlob LitInt SetSel SeqSel BagSel
    QuasiSetSel QuasiSeqSel QuasiBagSel EntityName ExprDict TypeDict
    VarInvo FuncInvo ProcInvo FuncReturn ProcReturn FuncDecl ProcDecl
    HostGateRtn);

main();

######################################################################

sub main {

    plan( 'tests' => 62 ); # 17 more than Perl 6 version, which has 45

    print "#### Starting test of QDRDBMS::AST ####\n";

    simple_literals();

    print "#### Finished test of QDRDBMS::AST ####\n";
}

######################################################################

sub simple_literals {

    my ($in, $node, $out);

    # LitBool

    $in = undef;
    eval {
        $node = LitBool({ 'v' => $in });
    };
    ok( $@, q{LitBool rejects invalid payload undef} );

    $in = (2 + 2 == 3);
    $node = LitBool({ 'v' => $in });
    pass( q{LitBool accepts valid payload Bool:False} );
    isa_ok( $node, 'QDRDBMS::AST::LitBool' );
    $out = $node->v();
    is( $out, $in, q{LitBool preserves valid payload} );

    $in = (2 + 2 == 4);
    $node = LitBool({ 'v' => $in });
    pass( q{LitBool accepts valid payload Bool:True} );
    isa_ok( $node, 'QDRDBMS::AST::LitBool' );
    $out = $node->v();
    is( $out, $in, q{LitBool preserves valid payload} );

    $in = 'foo';
    eval {
        $node = LitBool({ 'v' => $in });
    };
    ok( $@, q{LitBool rejects invalid payload 'foo'} );

    $in = 42;
    eval {
        $node = LitBool({ 'v' => $in });
    };
    ok( $@, q{LitBool rejects invalid payload 42} );

    # LitText

    $in = undef;
    eval {
        $node = LitText({ 'v' => $in });
    };
    ok( $@, q{LitText rejects invalid payload undef} );

    $in = '';
    $node = LitText({ 'v' => $in });
    pass( q{LitText accepts valid payload ''} );
    isa_ok( $node, 'QDRDBMS::AST::LitText' );
    $out = $node->v();
    is( $out, $in, q{LitText preserves valid payload} );

    $in = 'Ceres';
    $node = LitText({ 'v' => $in });
    pass( q{LitText accepts valid payload ASCII 'Ceres'} );
    isa_ok( $node, 'QDRDBMS::AST::LitText' );
    $out = $node->v();
    is( $out, $in, q{LitText preserves valid payload} );

    $in = 'サンプル';
    $node = LitText({ 'v' => $in });
    pass( q{LitText accepts valid payload Unicode 'サンプル'} );
    isa_ok( $node, 'QDRDBMS::AST::LitText' );
    $out = $node->v();
    is( $out, $in, q{LitText preserves valid payload} );

    $in = pack 'H2', '\xCC';
    eval {
        $node = LitText({ 'v' => $in });
    };
    ok( $@, q{LitText rejects invalid payload pack 'H2', '\xCC'} );

    # LitBlob

    $in = undef;
    eval {
        $node = LitBlob({ 'v' => $in });
    };
    ok( $@, q{LitBlob rejects invalid payload undef} );

    $in = '';
    $node = LitBlob({ 'v' => $in });
    pass( q{LitBlob accepts valid payload ''} );
    isa_ok( $node, 'QDRDBMS::AST::LitBlob' );
    $out = $node->v();
    is( $out, $in, q{LitBlob preserves valid payload} );

    $in = 'Ceres';
    $node = LitBlob({ 'v' => $in });
    pass( q{LitBlob accepts valid payload ASCII 'Ceres'} );
    isa_ok( $node, 'QDRDBMS::AST::LitBlob' );
    $out = $node->v();
    is( $out, $in, q{LitBlob preserves valid payload} );

    $in = 'サンプル';
    eval {
        $node = LitBlob({ 'v' => $in });
    };
    ok( $@, q{LitBlob rejects invalid payload Unicode 'サンプル'} );

    $in = pack 'H2', '\xCC';
    $node = LitBlob({ 'v' => $in });
    pass( q{LitBlob accepts valid payload pack 'H2', '\xCC'} );
    isa_ok( $node, 'QDRDBMS::AST::LitBlob' );
    $out = $node->v();
    is( $out, $in, q{LitBlob preserves valid payload} );

    # LitInt

    $in = undef;
    eval {
        $node = LitInt({ 'v' => $in });
    };
    ok( $@, q{LitInt rejects invalid payload undef} );

    $in = '';
    eval {
        $node = LitInt({ 'v' => $in });
    };
    ok( $@, q{LitInt rejects invalid payload ''} );

    $in = 0;
    $node = LitInt({ 'v' => $in });
    pass( q{LitInt accepts valid payload 0} );
    isa_ok( $node, 'QDRDBMS::AST::LitInt' );
    $out = $node->v();
    is( $out, $in, q{LitInt preserves valid payload} );

    $in = '0';
    $node = LitInt({ 'v' => $in });
    pass( q{LitInt accepts valid payload '0'} );
    isa_ok( $node, 'QDRDBMS::AST::LitInt' );
    $out = $node->v();
    is( $out, $in, q{LitInt preserves valid payload} );

    $in = '0.0';
    eval {
        $node = LitInt({ 'v' => $in });
    };
    ok( $@, q{LitInt rejects invalid payload '0.0'} );

    $in = '00';
    eval {
        $node = LitInt({ 'v' => $in });
    };
    ok( $@, q{LitInt rejects invalid payload '00'} );

    $in = '-0';
    eval {
        $node = LitInt({ 'v' => $in });
    };
    ok( $@, q{LitInt rejects invalid payload '-0'} );

    $in = 42;
    $node = LitInt({ 'v' => $in });
    pass( q{LitInt accepts valid payload 42} );
    isa_ok( $node, 'QDRDBMS::AST::LitInt' );
    $out = $node->v();
    is( $out, $in, q{LitInt preserves valid payload} );

    $in = '42';
    $node = LitInt({ 'v' => $in });
    pass( q{LitInt accepts valid payload '42'} );
    isa_ok( $node, 'QDRDBMS::AST::LitInt' );
    $out = $node->v();
    is( $out, $in, q{LitInt preserves valid payload} );

    $in = -42;
    $node = LitInt({ 'v' => $in });
    pass( q{LitInt accepts valid payload 42} );
    isa_ok( $node, 'QDRDBMS::AST::LitInt' );
    $out = $node->v();
    is( $out, $in, q{LitInt preserves valid payload} );

    $in = '-42';
    $node = LitInt({ 'v' => $in });
    pass( q{LitInt accepts valid payload '-42'} );
    isa_ok( $node, 'QDRDBMS::AST::LitInt' );
    $out = $node->v();
    is( $out, $in, q{LitInt preserves valid payload} );

    $in = '042';
    eval {
        $node = LitInt({ 'v' => $in });
    };
    ok( $@, q{LitInt rejects invalid payload '042'} );

    $in = '420';
    $node = LitInt({ 'v' => $in });
    pass( q{LitInt accepts valid payload '420'} );
    isa_ok( $node, 'QDRDBMS::AST::LitInt' );
    $out = $node->v();
    is( $out, $in, q{LitInt preserves valid payload} );

    $in = 'foo';
    eval {
        $node = LitInt({ 'v' => $in });
    };
    ok( $@, q{LitInt rejects invalid payload 'foo'} );

    $in = ' 3';
    eval {
        $node = LitInt({ 'v' => $in });
    };
    ok( $@, q{LitInt rejects invalid payload ' 3'} );

    $in = 4.5;
    eval {
        $node = LitInt({ 'v' => $in });
    };
    ok( $@, q{LitInt rejects invalid payload 4.5} );

    $in = '4.5';
    eval {
        $node = LitInt({ 'v' => $in });
    };
    ok( $@, q{LitInt rejects invalid payload '4.5'} );

    return;
}

######################################################################

1; # Magic true value required at end of a reuseable file's code.
