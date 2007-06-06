use 5.008001;
use utf8;
use strict;
use warnings FATAL => 'all';

###########################################################################
###########################################################################

my $FALSE = (1 == 0);
my $TRUE  = (1 == 1);

###########################################################################
###########################################################################

{ package QDRDBMS::AST; # module
    our $VERSION = 0.000000;
    # Note: This given version applies to all of this file's packages.

    use base 'Exporter';
    our @EXPORT_OK = qw(
        newBoolLit newTextLit newBlobLit newIntLit
        newTupleSel newQuasiTupleSel
        newRelationSel newQuasiRelationSel
        newVarInvo newFuncInvo
        newProcInvo
        newFuncReturn newProcReturn
        newEntityName
        newTypeInvoNQ newTypeInvoAQ
        newTypeDictNQ newTypeDictAQ
        newExprDict
        newFuncDecl newProcDecl
        newHostGateRtn
    );

###########################################################################

sub newBoolLit {
    my ($args) = @_;
    my ($v) = @{$args}{'v'};
    return QDRDBMS::AST::BoolLit->new({ 'v' => $v });
}

sub newTextLit {
    my ($args) = @_;
    my ($v) = @{$args}{'v'};
    return QDRDBMS::AST::TextLit->new({ 'v' => $v });
}

sub newBlobLit {
    my ($args) = @_;
    my ($v) = @{$args}{'v'};
    return QDRDBMS::AST::BlobLit->new({ 'v' => $v });
}

sub newIntLit {
    my ($args) = @_;
    my ($v) = @{$args}{'v'};
    return QDRDBMS::AST::IntLit->new({ 'v' => $v });
}

sub newTupleSel {
    my ($args) = @_;
    my ($heading, $body) = @{$args}{'heading', 'body'};
    return QDRDBMS::AST::TupleSel->new({
        'heading' => $heading, 'body' => $body });
}

sub newQuasiTupleSel {
    my ($args) = @_;
    my ($heading, $body) = @{$args}{'heading', 'body'};
    return QDRDBMS::AST::QuasiTupleSel->new({
        'heading' => $heading, 'body' => $body });
}

sub newRelationSel {
    my ($args) = @_;
    my ($heading, $body) = @{$args}{'heading', 'body'};
    return QDRDBMS::AST::RelationSel->new({
        'heading' => $heading, 'body' => $body });
}

sub newQuasiRelationSel {
    my ($args) = @_;
    my ($heading, $body) = @{$args}{'heading', 'body'};
    return QDRDBMS::AST::QuasiRelationSel->new({
        'heading' => $heading, 'body' => $body });
}

sub newVarInvo {
    my ($args) = @_;
    my ($v) = @{$args}{'v'};
    return QDRDBMS::AST::VarInvo->new({ 'v' => $v });
}

sub newFuncInvo {
    my ($args) = @_;
    my ($func, $ro_args) = @{$args}{'func', 'ro_args'};
    return QDRDBMS::AST::FuncInvo->new({
        'func' => $func, 'ro_args' => $ro_args });
}

sub newProcInvo {
    my ($args) = @_;
    my ($proc, $upd_args, $ro_args)
        = @{$args}{'proc', 'upd_args', 'ro_args'};
    return QDRDBMS::AST::ProcInvo->new({
        'proc' => $proc, 'upd_args' => $upd_args, 'ro_args' => $ro_args });
}

sub newFuncReturn {
    my ($args) = @_;
    my ($v) = @{$args}{'v'};
    return QDRDBMS::AST::FuncReturn->new({ 'v' => $v });
}

sub newProcReturn {
    return QDRDBMS::AST::ProcReturn->new();
}

sub newEntityName {
    my ($args) = @_;
    my ($text, $seq) = @{$args}{'text', 'seq'};
    return QDRDBMS::AST::EntityName->new({
        'text' => $text, 'seq' => $seq });
}

sub newTypeInvoNQ {
    my ($args) = @_;
    my ($kind, $spec) = @{$args}{'kind', 'spec'};
    return QDRDBMS::AST::TypeInvoNQ->new({
        'kind' => $kind, 'spec' => $spec });
}

sub newTypeInvoAQ {
    my ($args) = @_;
    my ($kind, $spec) = @{$args}{'kind', 'spec'};
    return QDRDBMS::AST::TypeInvoAQ->new({
        'kind' => $kind, 'spec' => $spec });
}

sub newTypeDictNQ {
    my ($args) = @_;
    my ($map) = @{$args}{'map'};
    return QDRDBMS::AST::TypeDictNQ->new({ 'map' => $map });
}

sub newTypeDictAQ {
    my ($args) = @_;
    my ($map) = @{$args}{'map'};
    return QDRDBMS::AST::TypeDictAQ->new({ 'map' => $map });
}

sub newExprDict {
    my ($args) = @_;
    my ($map) = @{$args}{'map'};
    return QDRDBMS::AST::ExprDict->new({ 'map' => $map });
}

sub newFuncDecl {
    return QDRDBMS::AST::FuncDecl->new();
}

sub newProcDecl {
    return QDRDBMS::AST::ProcDecl->new();
}

sub newHostGateRtn {
    my ($args) = @_;
    my ($upd_params, $ro_params, $vars, $stmts)
        = @{$args}{'upd_params', 'ro_params', 'vars', 'stmts'};
    return QDRDBMS::AST::HostGateRtn->new({ 'upd_params' => $upd_params,
        'ro_params' => $ro_params, 'vars' => $vars, 'stmts' => $stmts });
}

###########################################################################

} # module QDRDBMS::AST

###########################################################################
###########################################################################

{ package QDRDBMS::AST::Node;
    use Carp;
    use Scalar::Util qw(blessed);

###########################################################################

sub as_perl {
    my ($self) = @_;
    confess q{not implemented by subclass } . (blessed $self);
}

###########################################################################

sub equal_repr {
    my ($self, $args) = @_;
    my ($other) = @{$args}{'other'};

    confess q{equal_repr(): Bad :$other arg; it is not a valid object}
            . q{ of a QDRDBMS::AST::Node-doing class.}
        if !blessed $other or !$other->isa( 'QDRDBMS::AST::Node' );

    return $FALSE
        if blessed $other ne blessed $self;

    return $self->_equal_repr( $other );
}

sub _equal_repr {
    my ($self) = @_;
    confess q{not implemented by subclass } . (blessed $self);
}

###########################################################################

} # role QDRDBMS::AST::Node

###########################################################################
###########################################################################

{ package QDRDBMS::AST::Expr; # role
    use base 'QDRDBMS::AST::Node';
} # role QDRDBMS::AST::Expr

###########################################################################
###########################################################################

{ package QDRDBMS::AST::Lit; # role
    use base 'QDRDBMS::AST::Expr';
} # role QDRDBMS::AST::Lit

###########################################################################
###########################################################################

{ package QDRDBMS::AST::BoolLit; # class
    use base 'QDRDBMS::AST::Lit';

    use Carp;

    my $FALSE_AS_PERL = qq{'$FALSE'};
    my $TRUE_AS_PERL  = qq{'$TRUE'};

    my $ATTR_V = 'v';
        # A p5 Scalar that equals $FALSE|$TRUE.

    my $ATTR_AS_PERL = 'as_perl';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    my ($v) = @{$args}{'v'};

    confess q{new(): Bad :$v arg; Perl 5 does not consider}
            . q{ it to be a canonical boolean value.}
        if !defined $v or ($v ne $FALSE and $v ne $TRUE);

    $self->{$ATTR_V} = $v;

    return $self;
}

###########################################################################

sub as_perl {
    my ($self) = @_;
    if (!defined $self->{$ATTR_AS_PERL}) {
        my $s = $self->{$ATTR_V} ? $TRUE_AS_PERL : $FALSE_AS_PERL;
        $self->{$ATTR_AS_PERL}
            = "QDRDBMS::AST::BoolLit->new({ 'v' => $s })";
    }
    return $self->{$ATTR_AS_PERL};
}

###########################################################################

sub _equal_repr {
    my ($self, $other) = @_;
    return $other->{$ATTR_V} eq $self->{$ATTR_V};
}

###########################################################################

sub v {
    my ($self) = @_;
    return $self->{$ATTR_V};
}

###########################################################################

} # class QDRDBMS::AST::BoolLit

###########################################################################
###########################################################################

{ package QDRDBMS::AST::TextLit; # class
    use base 'QDRDBMS::AST::Lit';

    use Carp;
    use Encode qw(is_utf8);

    my $ATTR_V = 'v';
        # A p5 Scalar that is a text-mode string;
        # it either has true utf8 flag or is only 7-bit bytes.

    my $ATTR_AS_PERL = 'as_perl';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    my ($v) = @{$args}{'v'};

    confess q{new(): Bad :$v arg; Perl 5 does not consider}
            . q{ it to be a canonical character string value.}
        if !defined $v or (!is_utf8 $v and $v =~ m/[^\x00-\x7F]/xs);

    $self->{$ATTR_V} = $v;

    return $self;
}

###########################################################################

sub as_perl {
    my ($self) = @_;
    if (!defined $self->{$ATTR_AS_PERL}) {
        my $s = $self->{$ATTR_V};
        $s =~ s/'/\\'/xs;
        $s = q{'} . $s . q{'};
        $self->{$ATTR_AS_PERL}
            = "QDRDBMS::AST::TextLit->new({ 'v' => $s })";
    }
    return $self->{$ATTR_AS_PERL};
}

###########################################################################

sub _equal_repr {
    my ($self, $other) = @_;
    return $other->{$ATTR_V} eq $self->{$ATTR_V};
}

###########################################################################

sub v {
    my ($self) = @_;
    return $self->{$ATTR_V};
}

###########################################################################

} # class QDRDBMS::AST::TextLit

###########################################################################
###########################################################################

{ package QDRDBMS::AST::BlobLit; # class
    use base 'QDRDBMS::AST::Lit';

    use Carp;
    use Encode qw(is_utf8);

    my $ATTR_V = 'v';
        # A p5 Scalar that is a byte-mode string; it has false utf8 flag.

    my $ATTR_AS_PERL = 'as_perl';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    my ($v) = @{$args}{'v'};

    confess q{new(): Bad :$v arg; Perl 5 does not consider}
            . q{ it to be a canonical byte string value.}
        if !defined $v or is_utf8 $v;

    $self->{$ATTR_V} = $v;

    return $self;
}

###########################################################################

sub as_perl {
    my ($self) = @_;
    if (!defined $self->{$ATTR_AS_PERL}) {
        # TODO: A proper job of encoding/decoding the bit string payload.
        # What you see below is more symbolic of what to do than correct.
        my $hex_digit_text = join q{}, map { unpack 'H2', $_ }
            split q{}, $self->{$ATTR_V};
        my $s = q[(join q{}, map { pack 'H2', $_ }
            split q{}, ] . $hex_digit_text . q[)];
        $self->{$ATTR_AS_PERL}
            = "QDRDBMS::AST::BlobLit->new({ 'v' => $s })";
    }
    return $self->{$ATTR_AS_PERL};
}

###########################################################################

sub _equal_repr {
    my ($self, $other) = @_;
    return $other->{$ATTR_V} eq $self->{$ATTR_V};
}

###########################################################################

sub v {
    my ($self) = @_;
    return $self->{$ATTR_V};
}

###########################################################################

} # class QDRDBMS::AST::BlobLit

###########################################################################
###########################################################################

{ package QDRDBMS::AST::IntLit; # class
    use base 'QDRDBMS::AST::Lit';

    use Carp;

    my $ATTR_V = 'v';
        # A p5 Scalar that is a Perl integer or BigInt or canonical string.

    my $ATTR_AS_PERL = 'as_perl';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    my ($v) = @{$args}{'v'};

    confess q{new(): Bad :$v arg; Perl 5 does not consider}
            . q{ it to be a canonical integer value.}
        if !defined $v or $v !~ m/\A (0|-?[1-9][0-9]*) \z/xs;

    $self->{$ATTR_V} = $v;

    return $self;
}

###########################################################################

sub as_perl {
    my ($self) = @_;
    if (!defined $self->{$ATTR_AS_PERL}) {
        my $s = q{'} . $self->{$ATTR_V} . q{'};
        $self->{$ATTR_AS_PERL}
            = "QDRDBMS::AST::IntLit->new({ 'v' => $s })";
    }
    return $self->{$ATTR_AS_PERL};
}

###########################################################################

sub _equal_repr {
    my ($self, $other) = @_;
    return $other->{$ATTR_V} eq $self->{$ATTR_V};
}

###########################################################################

sub v {
    my ($self) = @_;
    return $self->{$ATTR_V};
}

###########################################################################

} # class QDRDBMS::AST::IntLit

###########################################################################
###########################################################################

{ package QDRDBMS::AST::_Tuple; # role
    use base 'QDRDBMS::AST::Expr';

    use Carp;
    use Scalar::Util qw(blessed);

    my $ATTR_HEADING = 'heading';
    my $ATTR_BODY    = 'body';

    my $ATTR_AS_PERL = 'as_perl';

    my $TYPEDICT_ATTR_MAP_HOA  = 'map_hoa';
    my $EXPRDICT_ATTR_MAP_HOA  = 'map_hoa';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    my ($heading, $body) = @{$args}{'heading', 'body'};

    if ($self->_allows_quasi()) {
        confess q{new(): Bad :$heading arg; it is not a valid object}
                . q{ of a QDRDBMS::AST::TypeDictAQ-doing class.}
            if !blessed $heading
                or !$heading->isa( 'QDRDBMS::AST::TypeDictAQ' );
    }
    else {
        confess q{new(): Bad :$heading arg; it is not a valid object}
                . q{ of a QDRDBMS::AST::TypeDictNQ-doing class.}
            if !blessed $heading
                or !$heading->isa( 'QDRDBMS::AST::TypeDictNQ' );
    }
    my $heading_attrs_map_hoa = $heading->{$TYPEDICT_ATTR_MAP_HOA};

    confess q{new(): Bad :$body arg; it is not a valid object}
            . q{ of a QDRDBMS::AST::ExprDict-doing class.}
        if !blessed $body or !$body->isa( 'QDRDBMS::AST::ExprDict' );
    for my $attr_name_text (keys %{$body->{$EXPRDICT_ATTR_MAP_HOA}}) {
        confess q{new(): Bad :$body arg; at least one its attrs}
                . q{ does not have a corresponding attr in :$heading.}
            if !exists $heading_attrs_map_hoa->{$attr_name_text};
    }

    $self->{$ATTR_HEADING} = $heading;
    $self->{$ATTR_BODY}    = $body;

    return $self;
}

###########################################################################

sub as_perl {
    my ($self) = @_;
    if (!defined $self->{$ATTR_AS_PERL}) {
        my $self_class = blessed $self;
        my $sh = $self->{$ATTR_HEADING}->as_perl();
        my $sb = $self->{$ATTR_BODY}->as_perl();
        $self->{$ATTR_AS_PERL}
            = "$self_class->new({ 'heading' => $sh, 'body' => $sb })";
    }
    return $self->{$ATTR_AS_PERL};
}

###########################################################################

sub _equal_repr {
    my ($self, $other) = @_;
    return ($self->{$ATTR_HEADING}->equal_repr({
            'other' => $other->{$ATTR_HEADING} })
        and $self->{$ATTR_BODY}->equal_repr({
            'other' => $other->{$ATTR_BODY} }));
}

###########################################################################

sub heading {
    my ($self) = @_;
    return $self->{$ATTR_HEADING};
}

sub body {
    my ($self) = @_;
    return $self->{$ATTR_BODY};
}

###########################################################################

sub attr_count {
    my ($self) = @_;
    return $self->{$ATTR_HEADING}->elem_count();
}

sub attr_exists {
    my ($self, $args) = @_;
    my ($attr_name) = @{$args}{'attr_name'};
    return $self->{$ATTR_HEADING}->elem_exists();
}

sub attr_type {
    my ($self, $args) = @_;
    my ($attr_name) = @{$args}{'attr_name'};
    return $self->{$ATTR_HEADING}->elem_value();
}

sub attr_value {
    my ($self, $args) = @_;
    my ($attr_name) = @{$args}{'attr_name'};
    return $self->{$ATTR_BODY}->elem_value();
}

###########################################################################

} # class QDRDBMS::AST::_Tuple

###########################################################################
###########################################################################

{ package QDRDBMS::AST::TupleSel; # class
    use base 'QDRDBMS::AST::_Tuple';
    sub _allows_quasi { return $FALSE; }
} # class QDRDBMS::AST::TupleSel

###########################################################################
###########################################################################

{ package QDRDBMS::AST::QuasiTupleSel; # class
    use base 'QDRDBMS::AST::_Tuple';
    sub _allows_quasi { return $TRUE; }
} # class QDRDBMS::AST::QuasiTupleSel

###########################################################################
###########################################################################

{ package QDRDBMS::AST::_Relation; # role
    use base 'QDRDBMS::AST::Expr';

    use Carp;
    use Scalar::Util qw(blessed);

    my $ATTR_HEADING = 'heading';
    my $ATTR_BODY    = 'body';

    my $ATTR_AS_PERL = 'as_perl';

    my $TYPEDICT_ATTR_MAP_HOA  = 'map_hoa';
    my $EXPRDICT_ATTR_MAP_HOA  = 'map_hoa';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    my ($heading, $body) = @{$args}{'heading', 'body'};

    if ($self->_allows_quasi()) {
        confess q{new(): Bad :$heading arg; it is not a valid object}
                . q{ of a QDRDBMS::AST::TypeDictAQ-doing class.}
            if !blessed $heading
                or !$heading->isa( 'QDRDBMS::AST::TypeDictAQ' );
    }
    else {
        confess q{new(): Bad :$heading arg; it is not a valid object}
                . q{ of a QDRDBMS::AST::TypeDictNQ-doing class.}
            if !blessed $heading
                or !$heading->isa( 'QDRDBMS::AST::TypeDictNQ' );
    }
    my $heading_attrs_map_hoa = $heading->{$TYPEDICT_ATTR_MAP_HOA};

    confess q{new(): Bad :$body arg; it is not an Array.}
        if ref $body ne 'ARRAY';
    for my $tupb (@{$body}) {
        confess q{new(): Bad :$body arg elem; it is not a valid object}
                . q{ of a QDRDBMS::AST::ExprDict-doing class.}
            if !blessed $tupb or !$tupb->isa( 'QDRDBMS::AST::ExprDict' );
        for my $attr_name_text (keys %{$tupb->{$EXPRDICT_ATTR_MAP_HOA}}) {
            confess q{new(): Bad :$body arg elem; at least one its attrs}
                    . q{ does not have a corresponding attr in :$heading.}
                if !exists $heading_attrs_map_hoa->{$attr_name_text};
        }
    }

    $self->{$ATTR_HEADING} = $heading;
    $self->{$ATTR_BODY}    = [@{$body}];

    return $self;
}

###########################################################################

sub as_perl {
    my ($self) = @_;
    if (!defined $self->{$ATTR_AS_PERL}) {
        my $self_class = blessed $self;
        my $sh = $self->{$ATTR_HEADING}->as_perl();
        my $sb = q{[} . (join q{, }, map {
                $_->as_perl()
            } @{$self->{$ATTR_BODY}}) . q{]};
        $self->{$ATTR_AS_PERL}
            = "$self_class->new({ 'heading' => $sh, 'body' => $sb })";
    }
    return $self->{$ATTR_AS_PERL};
}

###########################################################################

sub _equal_repr {
    my ($self, $other) = @_;
    return $FALSE
        if !$self->{$ATTR_HEADING}->equal_repr({
            'other' => $other->{$ATTR_HEADING} });
    my $v1 = $self->{$ATTR_BODY};
    my $v2 = $other->{$ATTR_BODY};
    return $FALSE
        if @{$v2} != @{$v1};
    for my $i (0..$#{$v1}) {
        return $FALSE
            if !$v1->[$i]->equal_repr({ 'other' => $v2->[$i] });
    }
    return $TRUE;
}

###########################################################################

sub heading {
    my ($self) = @_;
    return $self->{$ATTR_HEADING};
}

sub body {
    my ($self) = @_;
    return [@{$self->{$ATTR_BODY}}];
}

###########################################################################

sub attr_count {
    my ($self) = @_;
    return $self->{$ATTR_HEADING}->elem_count();
}

sub attr_exists {
    my ($self, $args) = @_;
    my ($attr_name) = @{$args}{'attr_name'};
    return $self->{$ATTR_HEADING}->elem_exists();
}

sub attr_type {
    my ($self, $args) = @_;
    my ($attr_name) = @{$args}{'attr_name'};
    return $self->{$ATTR_HEADING}->elem_value();
}

sub attr_values {
    my ($self, $args) = @_;
    my ($attr_name) = @{$args}{'attr_name'};
    return [map { $_->elem_value() } @{$self->{$ATTR_BODY}}];
}

###########################################################################

} # class QDRDBMS::AST::_Relation

###########################################################################
###########################################################################

{ package QDRDBMS::AST::RelationSel; # class
    use base 'QDRDBMS::AST::_Relation';
    sub _allows_quasi { return $FALSE; }
} # class QDRDBMS::AST::RelationSel

###########################################################################
###########################################################################

{ package QDRDBMS::AST::QuasiRelationSel; # class
    use base 'QDRDBMS::AST::_Relation';
    sub _allows_quasi { return $TRUE; }
} # class QDRDBMS::AST::QuasiRelationSel

###########################################################################
###########################################################################

{ package QDRDBMS::AST::VarInvo; # class
    use base 'QDRDBMS::AST::Expr';

    use Carp;
    use Scalar::Util qw(blessed);

    my $ATTR_V = 'v';

    my $ATTR_AS_PERL = 'as_perl';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    my ($v) = @{$args}{'v'};

    confess q{new(): Bad :$v arg; it is not a valid object}
            . q{ of a QDRDBMS::AST::EntityName-doing class.}
        if !blessed $v or !$v->isa( 'QDRDBMS::AST::EntityName' );

    $self->{$ATTR_V} = $v;

    return $self;
}

###########################################################################

sub as_perl {
    my ($self) = @_;
    if (!defined $self->{$ATTR_AS_PERL}) {
        my $s = $self->{$ATTR_V}->as_perl();
        $self->{$ATTR_AS_PERL}
            = "QDRDBMS::AST::VarInvo->new({ 'v' => $s })";
    }
    return $self->{$ATTR_AS_PERL};
}

###########################################################################

sub _equal_repr {
    my ($self, $other) = @_;
    return $self->{$ATTR_V}->equal_repr({ 'other' => $other->{$ATTR_V} });
}

###########################################################################

sub v {
    my ($self) = @_;
    return $self->{$ATTR_V};
}

###########################################################################

} # class QDRDBMS::AST::VarInvo

###########################################################################
###########################################################################

{ package QDRDBMS::AST::FuncInvo; # class
    use base 'QDRDBMS::AST::Expr';

    use Carp;
    use Scalar::Util qw(blessed);

    my $ATTR_FUNC    = 'func';
    my $ATTR_RO_ARGS = 'ro_args';

    my $ATTR_AS_PERL = 'as_perl';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    my ($func, $ro_args) = @{$args}{'func', 'ro_args'};

    confess q{new(): Bad :$func arg; it is not a valid object}
            . q{ of a QDRDBMS::AST::EntityName-doing class.}
        if !blessed $func or !$func->isa( 'QDRDBMS::AST::EntityName' );

    confess q{new(): Bad :$ro_args arg; it is not a valid object}
            . q{ of a QDRDBMS::AST::ExprDict-doing class.}
        if !blessed $ro_args or !$ro_args->isa( 'QDRDBMS::AST::ExprDict' );

    $self->{$ATTR_FUNC}    = $func;
    $self->{$ATTR_RO_ARGS} = $ro_args;

    return $self;
}

###########################################################################

sub as_perl {
    my ($self) = @_;
    if (!defined $self->{$ATTR_AS_PERL}) {
        my $sf = $self->{$ATTR_FUNC}->as_perl();
        my $sra = $self->{$ATTR_RO_ARGS}->as_perl();
        $self->{$ATTR_AS_PERL}
            = "QDRDBMS::AST::FuncInvo->new({"
                . " 'func' => $sf, 'ro_args' => $sra })";
    }
    return $self->{$ATTR_AS_PERL};
}

###########################################################################

sub _equal_repr {
    my ($self, $other) = @_;
    return $self->{$ATTR_FUNC}->equal_repr({
            'other' => $other->{$ATTR_FUNC} })
        and $self->{$ATTR_RO_ARGS}->equal_repr({
            'other' => $other->{$ATTR_RO_ARGS} });
}

###########################################################################

sub func {
    my ($self) = @_;
    return $self->{$ATTR_FUNC};
}

sub ro_args {
    my ($self) = @_;
    return $self->{$ATTR_RO_ARGS};
}

###########################################################################

} # class QDRDBMS::AST::FuncInvo

###########################################################################
###########################################################################

{ package QDRDBMS::AST::Stmt; # role
    use base 'QDRDBMS::AST::Node';
} # role QDRDBMS::AST::Stmt

###########################################################################
###########################################################################

{ package QDRDBMS::AST::ProcInvo; # class
    use base 'QDRDBMS::AST::Stmt';

    use Carp;
    use Scalar::Util qw(blessed);

    my $ATTR_PROC     = 'proc';
    my $ATTR_UPD_ARGS = 'upd_args';
    my $ATTR_RO_ARGS  = 'ro_args';

    my $ATTR_AS_PERL = 'as_perl';

    my $EXPRDICT_ATTR_MAP_HOA = 'map_hoa';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    my ($proc, $upd_args, $ro_args)
        = @{$args}{'proc', 'upd_args', 'ro_args'};

    confess q{new(): Bad :$proc arg; it is not a valid object}
            . q{ of a QDRDBMS::AST::EntityName-doing class.}
        if !blessed $proc or !$proc->isa( 'QDRDBMS::AST::EntityName' );

    confess q{new(): Bad :$upd_args arg; it is not a valid object}
            . q{ of a QDRDBMS::AST::ExprDict-doing class.}
        if !blessed $upd_args
            or !$upd_args->isa( 'QDRDBMS::AST::ExprDict' );
    confess q{new(): Bad :$ro_args arg; it is not a valid object}
            . q{ of a QDRDBMS::AST::ExprDict-doing class.}
        if !blessed $ro_args or !$ro_args->isa( 'QDRDBMS::AST::ExprDict' );
    my $upd_args_map_hoa = $upd_args->{$EXPRDICT_ATTR_MAP_HOA};
    for my $an_and_vn (values %{$upd_args_map_hoa}) {
        confess q{new(): Bad :$upd_args arg elem expr; it is not}
                . q{ an object of a QDRDBMS::AST::VarInvo-doing class.}
            if !$an_and_vn->[1]->isa( 'QDRDBMS::AST::VarInvo' );
    }
    confess q{new(): Bad :$upd_args or :$ro_args arg;}
            . q{ they both reference at least 1 same procedure param.}
        if grep {
                exists $upd_args_map_hoa->{$_}
            } keys %{$ro_args->{$EXPRDICT_ATTR_MAP_HOA}};

    $self->{$ATTR_PROC}     = $proc;
    $self->{$ATTR_UPD_ARGS} = $upd_args;
    $self->{$ATTR_RO_ARGS}  = $ro_args;

    return $self;
}

###########################################################################

sub as_perl {
    my ($self) = @_;
    if (!defined $self->{$ATTR_AS_PERL}) {
        my $sp = $self->{$ATTR_PROC}->as_perl();
        my $sua = $self->{$ATTR_UPD_ARGS}->as_perl();
        my $sra = $self->{$ATTR_RO_ARGS}->as_perl();
        $self->{$ATTR_AS_PERL}
            = "QDRDBMS::AST::ProcInvo->new({ 'proc' => $sp"
                . ", 'upd_args' => $sua, 'ro_args' => $sra })";
    }
    return $self->{$ATTR_AS_PERL};
}

###########################################################################

sub _equal_repr {
    my ($self, $other) = @_;
    return $self->{$ATTR_PROC}->equal_repr({
            'other' => $other->{$ATTR_PROC} })
        and $self->{$ATTR_UPD_ARGS}->equal_repr({
            'other' => $other->{$ATTR_UPD_ARGS} })
        and $self->{$ATTR_RO_ARGS}->equal_repr({
            'other' => $other->{$ATTR_RO_ARGS} });
}

###########################################################################

sub proc {
    my ($self) = @_;
    return $self->{$ATTR_PROC};
}

sub upd_args {
    my ($self) = @_;
    return $self->{$ATTR_UPD_ARGS};
}

sub ro_args {
    my ($self) = @_;
    return $self->{$ATTR_RO_ARGS};
}

###########################################################################

} # class QDRDBMS::AST::ProcInvo

###########################################################################
###########################################################################

{ package QDRDBMS::AST::FuncReturn; # class
    use base 'QDRDBMS::AST::Stmt';

    use Carp;
    use Scalar::Util qw(blessed);

    my $ATTR_V = 'v';

    my $ATTR_AS_PERL = 'as_perl';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    my ($v) = @{$args}{'v'};

    confess q{new(): Bad :$v arg; it is not a valid object}
            . q{ of a QDRDBMS::AST::Expr-doing class.}
        if !blessed $v or !$v->isa( 'QDRDBMS::AST::Expr' );

    $self->{$ATTR_V} = $v;

    return $self;
}

###########################################################################

sub as_perl {
    my ($self) = @_;
    if (!defined $self->{$ATTR_AS_PERL}) {
        my $s = $self->{$ATTR_V}->as_perl();
        $self->{$ATTR_AS_PERL}
            = "QDRDBMS::AST::FuncReturn->new({ 'v' => $s })";
    }
    return $self->{$ATTR_AS_PERL};
}

###########################################################################

sub _equal_repr {
    my ($self, $other) = @_;
    return $self->{$ATTR_V}->equal_repr({ 'other' => $other->{$ATTR_V} });
}

###########################################################################

sub v {
    my ($self) = @_;
    return $self->{$ATTR_V};
}

###########################################################################

} # class QDRDBMS::AST::FuncReturn

###########################################################################
###########################################################################

{ package QDRDBMS::AST::ProcReturn; # class
    use base 'QDRDBMS::AST::Stmt';

###########################################################################

sub new {
    my ($class) = @_;
    return bless {}, $class;
}

###########################################################################

sub as_perl {
    return 'QDRDBMS::AST::ProcReturn->new()';
}

###########################################################################

sub _equal_repr {
    return $TRUE;
}

###########################################################################

} # class QDRDBMS::AST::ProcReturn

###########################################################################
###########################################################################

{ package QDRDBMS::AST::EntityName; # class
    use base 'QDRDBMS::AST::Node';

    use Carp;
    use Encode qw(is_utf8);

    my $ATTR_TEXT_POSSREP = 'text_possrep';
        # A p5 Scalar that is a text-mode string;
        # it either has true utf8 flag or is only 7-bit bytes.
    my $ATTR_SEQ_POSSREP  = 'seq_possrep';
        # A p5 Array whose elements are p5 Scalar as per the text possrep.

    my $ATTR_AS_PERL = 'as_perl';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    my ($text, $seq) = @{$args}{'text', 'seq'};

    confess q{new(): Exactly 1 of the args (:$text|:$seq) must be defined.}
        if !(defined $text xor defined $seq);

    if (defined $text) {
        confess q{new(): Bad :$text arg; Perl 5 does not consider}
                . q{ it to be a canonical character string value.}
            if !is_utf8 $text and $text =~ m/[^\x00-\x7F]/xs;
        confess q{new(): Bad :$text arg; it contains charac sequences that}
                . q{ are invalid within the Text possrep of an EntityName.}
            if $text =~ m/ \\ \z/xs or $text =~ m/ \\ [^bp] /xs;

        $self->{$ATTR_TEXT_POSSREP} = $text;
        $self->{$ATTR_SEQ_POSSREP} = [map {
                my $s = $_;
                $s =~ s/ \\ p /./xsg;
                $s =~ s/ \\ b /\\/xsg;
                $s;
            } split /\./, $text];
    }

    else { # defined $seq
        confess q{new(): Bad :$seq arg; it is not an Array}
                . q{, or it has < 1 elem.}
            if ref $seq ne 'ARRAY' or @{$seq} == 0;
        for my $seq_e (@{$seq}) {
            confess q{new(): Bad :$seq arg elem; Perl 5 does not consider}
                    . q{ it to be a canonical character string value.}
                if !defined $seq_e
                    or (!is_utf8 $seq_e and $seq_e =~ m/[^\x00-\x7F]/xs);
        }

        $self->{$ATTR_TEXT_POSSREP} = join q{.}, map {
                my $s = $_;
                $s =~ s/ \\ /\\b/xsg;
                $s =~ s/ \. /\\p/xsg;
                $s;
            } @{$seq};
        $self->{$ATTR_SEQ_POSSREP} = [@{$seq}];
    }

    return $self;
}

###########################################################################

sub as_perl {
    my ($self) = @_;
    if (!defined $self->{$ATTR_AS_PERL}) {
        my $s = $self->{$ATTR_TEXT_POSSREP};
        $s =~ s/'/\\'/xs;
        $s = q{'} . $s . q{'};
        $self->{$ATTR_AS_PERL}
            = "QDRDBMS::AST::EntityName->new({ 'text' => $s })";
    }
    return $self->{$ATTR_AS_PERL};
}

###########################################################################

sub _equal_repr {
    my ($self, $other) = @_;
    return $other->{$ATTR_TEXT_POSSREP} eq $self->{$ATTR_TEXT_POSSREP};
}

###########################################################################

sub text {
    my ($self) = @_;
    return $self->{$ATTR_TEXT_POSSREP};
}

sub seq {
    my ($self) = @_;
    return [@{$self->{$ATTR_SEQ_POSSREP}}];
}

###########################################################################

} # class QDRDBMS::AST::EntityName

###########################################################################
###########################################################################

{ package QDRDBMS::AST::TypeInvo; # role
    use base 'QDRDBMS::AST::Node';

    use Carp;
    use Scalar::Util qw(blessed);

    my $ATTR_KIND = 'kind';
    my $ATTR_SPEC = 'spec';

    my $ATTR_AS_PERL = 'as_perl';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    my ($kind, $spec) = @{$args}{'kind', 'spec'};

    confess q{new(): Bad :$kind arg; it is undefined.}
        if !defined $kind;

    if ($kind eq 'Scalar') {
        confess q{new(): Bad :$spec arg; it needs to be a valid object}
                . q{ of a QDRDBMS::AST::EntityName-doing class}
                . q{ when the :$kind arg is 'Scalar'.}
            if !blessed $spec or !$spec->isa( 'QDRDBMS::AST::EntityName' );
    }

    elsif ($kind eq 'Tuple' or $kind eq 'Relation') {
        confess q{new(): Bad :$spec arg; it needs to be a valid object}
                . q{ of a QDRDBMS::AST::TypeDictNQ-doing class}
                . q{ when the :$kind arg is 'Tuple'|'Relation'.}
            if !blessed $spec or !$spec->isa( 'QDRDBMS::AST::TypeDictNQ' );
    }

    elsif (!$self->_allows_quasi()) {
        confess q{new(): Bad :$kind arg; it needs to be one of}
            . q{ 'Scalar'|'Tuple'|'Relation'.};
    }

    elsif ($kind eq 'QTuple' or $kind eq 'QRelation') {
        confess q{new(): Bad :$spec arg; it needs to be a valid object}
                . q{ of a QDRDBMS::AST::TypeDictAQ-doing class}
                . q{ when the :$kind arg is 'QTuple'|'QRelation'.}
            if !blessed $spec or !$spec->isa( 'QDRDBMS::AST::TypeDictAQ' );
    }

    elsif ($kind eq 'Any') {
        confess q{new(): Bad :$spec arg; it needs to be one of}
                . q{ 'Tuple'|'Relation'|'QTuple'|'QRelation'|'Universal'}
                . q{ when the :$kind arg is 'Any'.}
            if !defined $spec
                or $spec !~ m/\A (Tuple|Relation
                    |QTuple|QRelation|Universal) \z/xs;
    }

    else {
        confess q{new(): Bad :$kind arg; it needs to be}
            . q{ 'Scalar'|'Tuple'|'Relation'|'QTuple'|'QRelation'|'Any'.};
    }

    $self->{$ATTR_KIND} = $kind;
    $self->{$ATTR_SPEC} = $spec;

    return $self;
}

###########################################################################

sub as_perl {
    my ($self) = @_;
    if (!defined $self->{$ATTR_AS_PERL}) {
        my $self_class = blessed $self;
        my $kind = $self->{$ATTR_KIND};
        my $spec = $self->{$ATTR_SPEC};
        my $sk = q{'} . $kind . q{'};
        my $ss = $kind eq 'Any' ? q{'} . $spec . q{'} : $spec->as_perl();
        $self->{$ATTR_AS_PERL}
            = "$self_class->new({ 'kind' => $sk, 'spec' => $ss })";
    }
    return $self->{$ATTR_AS_PERL};
}

###########################################################################

sub _equal_repr {
    my ($self, $other) = @_;
    my $kind = $self->{$ATTR_KIND};
    my $spec = $self->{$ATTR_SPEC};
    return $FALSE
        if $other->{$ATTR_KIND} ne $kind;
    return $kind eq 'Any' ? $other->{$ATTR_SPEC} eq $spec
        : $spec->equal_repr({ 'other' => $other->{$ATTR_SPEC} });
}

###########################################################################

sub kind {
    my ($self) = @_;
    return $self->{$ATTR_KIND};
}

sub spec {
    my ($self) = @_;
    return $self->{$ATTR_SPEC};
}

###########################################################################

} # role QDRDBMS::AST::TypeInvo

###########################################################################
###########################################################################

{ package QDRDBMS::AST::TypeInvoNQ; # class
    use base 'QDRDBMS::AST::TypeInvo';
    sub _allows_quasi { return $FALSE; }
} # class QDRDBMS::AST::TypeInvoNQ

###########################################################################
###########################################################################

{ package QDRDBMS::AST::TypeInvoAQ; # class
    use base 'QDRDBMS::AST::TypeInvo';
    sub _allows_quasi { return $TRUE; }
} # class QDRDBMS::AST::TypeInvoAQ

###########################################################################
###########################################################################

{ package QDRDBMS::AST::TypeDict; # role
    use base 'QDRDBMS::AST::Node';

    use Carp;
    use Scalar::Util qw(blessed);

    my $ATTR_MAP_AOA = 'map_aoa';
    my $ATTR_MAP_HOA = 'map_hoa';

    my $ATTR_AS_PERL = 'as_perl';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    my ($map) = @{$args}{'map'};

    my $allows_quasi = $self->_allows_quasi();

    confess q{new(): Bad :$map arg; it is not an Array.}
        if ref $map ne 'ARRAY';
    my $map_aoa = [];
    my $map_hoa = {};
    for my $elem (@{$map}) {
        confess q{new(): Bad :$map arg elem; it is not a 2-element Array.}
            if ref $elem ne 'ARRAY' or @{$elem} != 2;
        my ($entity_name, $type_invo) = @{$elem};
        confess q{new(): Bad :$map arg elem; its first elem is not}
                . q{ an object of a QDRDBMS::AST::EntityName-doing class.}
            if !blessed $entity_name
                or !$entity_name->isa( 'QDRDBMS::AST::EntityName' );
        my $entity_name_text = $entity_name->text();
        confess q{new(): Bad :$map arg elem; its first elem is not}
                . q{ distinct between the arg elems.}
            if exists $map_hoa->{$entity_name_text};
        if ($allows_quasi) {
            confess q{new(): Bad :$map arg elem; its second elem is not an}
                    . q{ object of a QDRDBMS::AST::TypeInvoAQ-doing class.}
                if !blessed $type_invo
                    or !$type_invo->isa( 'QDRDBMS::AST::TypeInvoAQ' );
        }
        else {
            confess q{new(): Bad :$map arg elem; its second elem is not an}
                    . q{ object of a QDRDBMS::AST::TypeInvoNQ-doing class.}
                if !blessed $type_invo
                    or !$type_invo->isa( 'QDRDBMS::AST::TypeInvoNQ' );
        }
        my $elem_cpy = [$entity_name, $type_invo];
        push @{$map_aoa}, $elem_cpy;
        $map_hoa->{$entity_name_text} = $elem_cpy;
    }

    $self->{$ATTR_MAP_AOA} = $map_aoa;
    $self->{$ATTR_MAP_HOA} = $map_hoa;

    return $self;
}

###########################################################################

sub as_perl {
    my ($self) = @_;
    if (!defined $self->{$ATTR_AS_PERL}) {
        my $s = q{[} . (join q{, }, map {
                q{[} . $_->[0]->as_perl()
                    . q{, } . $_->[1]->as_perl() . q{]}
            } @{$self->{$ATTR_MAP_AOA}}) . q{]};
        $self->{$ATTR_AS_PERL}
            = "QDRDBMS::AST::TypeDict->new({ 'map' => $s })";
    }
    return $self->{$ATTR_AS_PERL};
}

###########################################################################

sub _equal_repr {
    my ($self, $other) = @_;
    return $FALSE
        if @{$other->{$ATTR_MAP_AOA}} != @{$self->{$ATTR_MAP_AOA}};
    my $v1 = $self->{$ATTR_MAP_HOA};
    my $v2 = $other->{$ATTR_MAP_HOA};
    for my $ek (keys %{$v1}) {
        return $FALSE
            if !exists $v2->{$ek};
        return $FALSE
            if !$v1->{$ek}->[1]->equal_repr({
                'other' => $v2->[1]->{$ek} });
    }
    return $TRUE;
}

###########################################################################

sub map {
    my ($self) = @_;
    return [map { [@{$_}] } @{$self->{$ATTR_MAP_AOA}}];
}

sub map_hoa {
    my ($self) = @_;
    my $h = $self->{$ATTR_MAP_HOA};
    return {map { $_ => [@{$h->{$_}}] } keys %{$h}};
}

###########################################################################

sub elem_count {
    my ($self) = @_;
    return 0 + @{$self->{$ATTR_MAP_AOA}};
}

sub elem_exists {
    my ($self, $args) = @_;
    my ($elem_name) = @{$args}{'elem_name'};

    confess q{elem_exists(): Bad :$elem_name arg; it is not an object of a}
            . q{ QDRDBMS::AST::EntityName-doing class.}
        if !blessed $elem_name
            or !$elem_name->isa( 'QDRDBMS::AST::EntityName' );

    return exists $self->{$ATTR_MAP_HOA}->{$elem_name->text()};
}

sub elem_value {
    my ($self, $args) = @_;
    my ($elem_name) = @{$args}{'elem_name'};

    confess q{elem_value(): Bad :$elem_name arg; it is not an object of a}
            . q{ QDRDBMS::AST::EntityName-doing class.}
        if !blessed $elem_name
            or !$elem_name->isa( 'QDRDBMS::AST::EntityName' );

    return $self->{$ATTR_MAP_HOA}->{$elem_name->text()};
}

###########################################################################

} # role QDRDBMS::AST::TypeDict

###########################################################################
###########################################################################

{ package QDRDBMS::AST::TypeDictNQ; # class
    use base 'QDRDBMS::AST::TypeDict';
    sub _allows_quasi { return $FALSE; }
} # class QDRDBMS::AST::TypeDictNQ

###########################################################################
###########################################################################

{ package QDRDBMS::AST::TypeDictAQ; # class
    use base 'QDRDBMS::AST::TypeDict';
    sub _allows_quasi { return $TRUE; }
} # class QDRDBMS::AST::TypeDictAQ

###########################################################################
###########################################################################

{ package QDRDBMS::AST::ExprDict; # class
    use base 'QDRDBMS::AST::Node';

    use Carp;
    use Scalar::Util qw(blessed);

    my $ATTR_MAP_AOA = 'map_aoa';
    my $ATTR_MAP_HOA = 'map_hoa';

    # Note: This type is specific such that values are always some ::Expr,
    # but this type may be later generalized to hold ::Node instead.

    my $ATTR_AS_PERL = 'as_perl';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    my ($map) = @{$args}{'map'};

    confess q{new(): Bad :$map arg; it is not an Array.}
        if ref $map ne 'ARRAY';
    my $map_aoa = [];
    my $map_hoa = {};
    for my $elem (@{$map}) {
        confess q{new(): Bad :$map arg elem; it is not a 2-element Array.}
            if ref $elem ne 'ARRAY' or @{$elem} != 2;
        my ($entity_name, $expr) = @{$elem};
        confess q{new(): Bad :$map arg elem; its first elem is not}
                . q{ an object of a QDRDBMS::AST::EntityName-doing class.}
            if !blessed $entity_name
                or !$entity_name->isa( 'QDRDBMS::AST::EntityName' );
        my $entity_name_text = $entity_name->text();
        confess q{new(): Bad :$map arg elem; its first elem is not}
                . q{ distinct between the arg elems.}
            if exists $map_hoa->{$entity_name_text};
        confess q{new(): Bad :$map arg elem; its second elem is not}
                . q{ an object of a QDRDBMS::AST::Expr-doing class.}
            if !blessed $expr or !$expr->isa( 'QDRDBMS::AST::Expr' );
        my $elem_cpy = [$entity_name, $expr];
        push @{$map_aoa}, $elem_cpy;
        $map_hoa->{$entity_name_text} = $elem_cpy;
    }

    $self->{$ATTR_MAP_AOA} = $map_aoa;
    $self->{$ATTR_MAP_HOA} = $map_hoa;

    return $self;
}

###########################################################################

sub as_perl {
    my ($self) = @_;
    if (!defined $self->{$ATTR_AS_PERL}) {
        my $s = q{[} . (join q{, }, map {
                q{[} . $_->[0]->as_perl()
                    . q{, } . $_->[1]->as_perl() . q{]}
            } @{$self->{$ATTR_MAP_AOA}}) . q{]};
        $self->{$ATTR_AS_PERL}
            = "QDRDBMS::AST::ExprDict->new({ 'map' => $s })";
    }
    return $self->{$ATTR_AS_PERL};
}

###########################################################################

sub _equal_repr {
    my ($self, $other) = @_;
    return $FALSE
        if @{$other->{$ATTR_MAP_AOA}} != @{$self->{$ATTR_MAP_AOA}};
    my $v1 = $self->{$ATTR_MAP_HOA};
    my $v2 = $other->{$ATTR_MAP_HOA};
    for my $ek (keys %{$v1}) {
        return $FALSE
            if !exists $v2->{$ek};
        return $FALSE
            if !$v1->{$ek}->[1]->equal_repr({
                'other' => $v2->[1]->{$ek} });
    }
    return $TRUE;
}

###########################################################################

sub map {
    my ($self) = @_;
    return [map { [@{$_}] } @{$self->{$ATTR_MAP_AOA}}];
}

sub map_hoa {
    my ($self) = @_;
    my $h = $self->{$ATTR_MAP_HOA};
    return {map { $_ => [@{$h->{$_}}] } keys %{$h}};
}

###########################################################################

sub elem_count {
    my ($self) = @_;
    return 0 + @{$self->{$ATTR_MAP_AOA}};
}

sub elem_exists {
    my ($self, $args) = @_;
    my ($elem_name) = @{$args}{'elem_name'};

    confess q{elem_exists(): Bad :$elem_name arg; it is not an object of a}
            . q{ QDRDBMS::AST::EntityName-doing class.}
        if !blessed $elem_name
            or !$elem_name->isa( 'QDRDBMS::AST::EntityName' );

    return exists $self->{$ATTR_MAP_HOA}->{$elem_name->text()};
}

sub elem_value {
    my ($self, $args) = @_;
    my ($elem_name) = @{$args}{'elem_name'};

    confess q{elem_value(): Bad :$elem_name arg; it is not an object of a}
            . q{ QDRDBMS::AST::EntityName-doing class.}
        if !blessed $elem_name
            or !$elem_name->isa( 'QDRDBMS::AST::EntityName' );

    return $self->{$ATTR_MAP_HOA}->{$elem_name->text()};
}

###########################################################################

} # class QDRDBMS::AST::ExprDict

###########################################################################
###########################################################################

{ package QDRDBMS::AST::FuncDecl; # class
    use base 'QDRDBMS::AST::Node';

    use Carp;
    use Scalar::Util qw(blessed);

###########################################################################

sub new {
    confess q{not implemented};
}

###########################################################################

} # class QDRDBMS::AST::FuncDecl

###########################################################################
###########################################################################

{ package QDRDBMS::AST::ProcDecl; # class
    use base 'QDRDBMS::AST::Node';

    use Carp;
    use Scalar::Util qw(blessed);

###########################################################################

sub new {
    confess q{not implemented};
}

###########################################################################

} # class QDRDBMS::AST::ProcDecl

###########################################################################
###########################################################################

{ package QDRDBMS::AST::HostGateRtn; # class
    use base 'QDRDBMS::AST::Node';

    use Carp;
    use Scalar::Util qw(blessed);

    my $ATTR_UPD_PARAMS = 'upd_params';
    my $ATTR_RO_PARAMS  = 'ro_params';
    my $ATTR_VARS       = 'vars';
    my $ATTR_STMTS      = 'stmts';

    my $ATTR_AS_PERL = 'as_perl';

    my $TYPEDICT_ATTR_MAP_HOA = 'map_hoa';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    my ($upd_params, $ro_params, $vars, $stmts)
        = @{$args}{'upd_params', 'ro_params', 'vars', 'stmts'};

    confess q{new(): Bad :$upd_params arg; it is not a valid object}
            . q{ of a QDRDBMS::AST::TypeDict-doing class.}
        if !blessed $upd_params
            or !$upd_params->isa( 'QDRDBMS::AST::TypeDict' );
    confess q{new(): Bad :$ro_params arg; it is not a valid object}
            . q{ of a QDRDBMS::AST::TypeDict-doing class.}
        if !blessed $ro_params
            or !$ro_params->isa( 'QDRDBMS::AST::TypeDict' );
    my $upd_params_map_hoa = $upd_params->{$TYPEDICT_ATTR_MAP_HOA};
    confess q{new(): Bad :$upd_params or :$ro_params arg;}
            . q{ they both reference at least 1 same stmtsedure param.}
        if grep {
                exists $upd_params_map_hoa->{$_}
            } keys %{$ro_params->{$TYPEDICT_ATTR_MAP_HOA}};

    confess q{new(): Bad :$vars arg; it is not a valid object}
            . q{ of a QDRDBMS::AST::TypeDict-doing class.}
        if !blessed $vars or !$vars->isa( 'QDRDBMS::AST::TypeDict' );

    confess q{new(): Bad :$stmts arg; it is not an Array.}
        if ref $stmts ne 'ARRAY';
    for my $stmt (@{$stmts}) {
        confess q{new(): Bad :$stmts arg elem; it is not}
                . q{ an object of a QDRDBMS::AST::Stmt-doing class.}
            if !blessed $stmt or !$stmt->isa( 'QDRDBMS::AST::Stmt' );
    }

    $self->{$ATTR_UPD_PARAMS} = $upd_params;
    $self->{$ATTR_RO_PARAMS}  = $ro_params;
    $self->{$ATTR_VARS}       = $vars;
    $self->{$ATTR_STMTS}      = [@{$stmts}];

    return $self;
}

###########################################################################

sub as_perl {
    my ($self) = @_;
    if (!defined $self->{$ATTR_AS_PERL}) {
        my $sup = $self->{$ATTR_UPD_PARAMS}->as_perl();
        my $srp = $self->{$ATTR_RO_PARAMS}->as_perl();
        my $sv = $self->{$ATTR_VARS}->as_perl();
        my $ss = q{[} . (join q{, }, map {
                $_->as_perl()
            } @{$self->{$ATTR_STMTS}}) . q{]};
        $self->{$ATTR_AS_PERL} = "QDRDBMS::AST::HostGateRtn->new({"
            . " 'upd_params' => $sup, 'ro_params' => $srp"
            . ", 'vars' => $sv, 'stmts' => $ss })";
    }
    return $self->{$ATTR_AS_PERL};
}

###########################################################################

sub _equal_repr {
    my ($self, $other) = @_;
    return $FALSE
        if !$self->{$ATTR_UPD_PARAMS}->equal_repr({
                'other' => $other->{$ATTR_UPD_PARAMS} })
            or !$self->{$ATTR_RO_PARAMS}->equal_repr({
                'other' => $other->{$ATTR_RO_PARAMS} })
            or !$self->{$ATTR_VARS}->equal_repr({
                'other' => $other->{$ATTR_VARS} });
    my $v1 = $self->{$ATTR_STMTS};
    my $v2 = $other->{$ATTR_STMTS};
    return $FALSE
        if @{$v2} != @{$v1};
    for my $i (0..$#{$v1}) {
        return $FALSE
            if !$v1->[$i]->equal_repr({ 'other' => $v2->[$i] });
    }
    return $TRUE;
}

###########################################################################

sub upd_params {
    my ($self) = @_;
    return $self->{$ATTR_UPD_PARAMS};
}

sub ro_params {
    my ($self) = @_;
    return $self->{$ATTR_RO_PARAMS};
}

sub vars {
    my ($self) = @_;
    return $self->{$ATTR_VARS};
}

sub stmts {
    my ($self) = @_;
    return [@{$self->{$ATTR_STMTS}}];
}

###########################################################################

} # class QDRDBMS::AST::HostGateRtn

###########################################################################
###########################################################################

1; # Magic true value required at end of a reusable file's code.
__END__

=pod

=encoding utf8

=head1 NAME

QDRDBMS::AST -
Abstract syntax tree for the QDRDBMS D language

=head1 VERSION

This document describes QDRDBMS::AST version 0.0.0 for Perl 5.

It also describes the same-number versions for Perl 5 of [...].

=head1 SYNOPSIS

I<This documentation is pending.>

    use QDRDBMS::AST qw(newBoolLit newTextLit newBlobLit newIntLit
        newTupleSel newQuasiTupleSel newRelationSel newQuasiRelationSel
        newVarInvo newFuncInvo newProcInvo newFuncReturn newProcReturn
        newEntityName newTypeInvoNQ newTypeInvoAQ newTypeDictNQ
        newTypeDictAQ newExprDict newFuncDecl newProcDecl newHostGateRtn);

    my $truth_value = newBoolLit({ 'v' => (2 + 2 == 4) });
    my $planetoid = newTextLit({ 'v' => 'Ceres' });
    my $package = newBlobLit({ 'v' => (pack 'H2', 'P') });
    my $answer = newIntLit({ 'v' => 42 });

I<This documentation is pending.>

=head1 DESCRIPTION

The native command language of a L<QDRDBMS> DBMS (database management
system) / virtual machine is called B<QDRDBMS D>; see L<QDRDBMS::Language>
for the language's human readable authoritative design document.

QDRDBMS D has 3 closely corresponding main representation formats, which
are catalog relations (what routines inside the DBMS see), hierarchical AST
(abstract syntax tree) nodes (what the application driving the DBMS
typically sees), and string-form QDRDBMS D code that users interacting with
QDRDBMS via a shell interface would use.  The string-form would be parsed
into the AST, and the AST be flattened into the relations; similarly, the
relations can be unflattened into the AST, and string-form code be
generated from the AST if desired.

This library, QDRDBMS::AST ("AST"), provides a few dozen container classes
which collectively implement the AST representation format of QDRDBMS D;
each class is called an I<AST node type> or I<node type>, and an object of
one of these classes is called an I<AST node> or I<node>.

These are all of the roles and classes that QDRDBMS::AST defines (more will
be added in the future), which are visually arranged here in their "does"
or "isa" hierarchy, children indented under parents:

    QDRDBMS::AST::Node (dummy role)
        QDRDBMS::AST::Expr (dummy role)
            QDRDBMS::AST::Lit (dummy role)
                QDRDBMS::AST::BoolLit
                QDRDBMS::AST::TextLit
                QDRDBMS::AST::BlobLit
                QDRDBMS::AST::IntLit
            QDRDBMS::AST::_Tuple (implementing role)
                QDRDBMS::AST::TupleSel
                QDRDBMS::AST::QuasiTupleSel
            QDRDBMS::AST::_Relation (implementing role)
                QDRDBMS::AST::RelationSel
                QDRDBMS::AST::QuasiRelationSel
            QDRDBMS::AST::VarInvo
            QDRDBMS::AST::FuncInvo
        QDRDBMS::AST::Stmt (dummy role)
            QDRDBMS::AST::ProcInvo
            QDRDBMS::AST::FuncReturn
            QDRDBMS::AST::ProcReturn
            # more control-flow statement types would go here
        QDRDBMS::AST::EntityName
        QDRDBMS::AST::TypeInvo (implementing role)
            QDRDBMS::AST::TypeInvoNQ
            QDRDBMS::AST::TypeInvoAQ
        QDRDBMS::AST::TypeDict (implementing role)
            QDRDBMS::AST::TypeDictNQ
            QDRDBMS::AST::TypeDictAQ
        QDRDBMS::AST::ExprDict
        QDRDBMS::AST::FuncDecl
        QDRDBMS::AST::ProcDecl
        # more routine declaration types would go here
        QDRDBMS::AST::HostGateRtn

All QDRDBMS D abstract syntax trees are such in the compositional sense;
that is, every AST node is composed primarily of zero or more other AST
nodes, and so a node is a child of another iff the former is composed into
the latter.  All AST nodes are immutable objects; their values are
determined at construction time, and they can't be changed afterwards.
Therefore, constructing a tree is a bottom-up process, such that all child
objects have to be constructed prior to, and be passed in as constructor
arguments of, their parents.  The process is like declaring an entire
multi-dimensional Perl data structure at the time the variable holding it
is declared; the data structure is actually built from the inside to the
outside.  A consequence of the immutability is that it is feasible to
reuse AST nodes many times, since they won't change out from under you.

An AST node denotes an arbitrarily complex value, that value being defined
by the type of the node and what its attributes are (some of which are
themselves nodes, and some of which aren't).  A node can denote either a
scalar value, or a collection value, or an expression that would evaluate
into a value, or a statement or routine definition that could be later
executed to either return a value or have some side effect.  For all
intents and purposes, a node is a program, and can represent anything that
program code can represent, both values and actions.

The QDRDBMS framework uses QDRDBMS AST nodes for the dual purpose of
defining routines to execute and defining values to use as arguments to and
return values from the execution of said routines.  The C<prepare()> method
of a C<QDRDBMS::Interface::DBMS> object, and by extension the
C<QDRDBMS::Interface::HostGateRtn->new()> constructor function, takes a
C<QDRDBMS::AST::HostGateRtn> node as its primary argument, such that the
AST object defines the source code that is compiled to become the Interface
object.  The C<fetch_ast()> and C<store_ast()> methods of a
C<QDRDBMS::Interface::HostGateVar> object will get or set that object's
primary value attribute, which is any C<QDRDBMS::AST::Node>.  The C<Var>
objects are bound to C<Rtn> objects, and they are the means by which an
executed routine accepts input or provides output at C<execute()> time.

=head2 AST Node Values Versus Representations

In the general case, QDRDBMS AST nodes do not maintain canonical
representations of all QDRDBMS D values, meaning that it is possible and
common to have 2 given AST nodes that logically denote the same value, but
they have different actual compositions.  (Some node types are special
cases for which the aforementioned isn't true; see below.)

For example, a node whose value is just the number 5 can have any number of
representations, each of which is an expression that evaluates to the
number 5 (such as [C<5>, C<2+3>, C<10/2>]).  Another example is a node
whose value is the set C<{3,5,7}>; it can be represented, for example,
either by C<Set(5,3,7,7,7)> or C<Union(Set(3,5),Set(5,7))> or
C<Set(7,5,3)>.  I<These examples aren't actual QDRDBMS AST syntax.>

For various reasons, the QDRDBMS::AST classes themselves do not do any node
refactoring, and their representations differ little if any from the format
of their constructor arguments, which can contain extra information that is
not logically significant in determining the node value.  One reason is
that this allows a semblance of maintaining the actual syntax that the user
specified, which is useful for their debugging purposes.  Another reason is
the desire to keep this library as light-weight as possible, such that it
just implements the essentials; doing refactoring can require a code size
and complexity that is orders of magnitude larger than these essentials,
and that work isn't always helpful.  It should also be noted that any nodes
having references to externally user-defined entities can't be fully
refactored as each of those represents a free variable that a static node
analysis can't decompose; only nodes consisting of just system-defined or
literal entities (meaning zero free variables) can be fully refactored in a
static node analysis (though there are a fair number of those in practice,
particularly as C<Var> values).

A consequence of this is that the QDRDBMS::AST classes in general do not
include do not include any methods for comparing that 2 nodes denote the
same value; to reliably do that, you will have to use means not provided by
this library.  However, each class I<does> provide a C<equal_repr> method,
which compares that 2 nodes have the same representation.

It should be noted that a serialize/unserialize cycle on a node that is
done using the C<as_perl> routine to serialize, and having Perl eval that
to unserialize, is guaranteed to preserve the representation, so
C<equal_repr> will work as expected in that situation.

As an exception to the general case about nodes, the node classes
[C<BoolLit>, C<TextLit>, C<BlobLit>, C<IntLit>, C<EntityName>, C<VarInvo>,
C<ProcReturn>] are guaranteed to only ever have a single representation per
value, and so C<equal_repr> is guaranteed to indicate value equality of 2
nodes of those types.  In fact, to assist the consequence this point, these
node classes also have the C<equal_value> method which is an alias for
C<equal_repr>, so you can use C<equal_value> in your use code to make it
better self documenting; C<equal_repr> is still available for all node
types to assist automated use code that wants to treat all node types the
same.  It should also be noted that a C<BoolLit> node can only possibly be
of one of 2 values, and C<ProcReturn> is a singleton.

It is expected that multiple third party utility modules will become
available over time whose purpose is to refactor a QDRDBMS AST node, either
as part of a static analysis that considers only the node in isolation (and
any user-defined entity references have to be treated as free variables and
not generally be factored out), or as part of an Engine implementation that
also considers the current virtual machine environment and what
user-defined entities exist there (and depending on the context,
user-defined entity references don't have to be free variables).

=head1 INTERFACE

The interface of QDRDBMS::AST is fundamentally object-oriented; you use it
by creating objects from its member classes, usually invoking C<new()> on
the appropriate class name, and then invoking methods on those objects.
All of their attributes are private, so you must use accessor methods.

QDRDBMS::AST also provides wrapper subroutines for all member class
constructors, 1 per each, where each subroutine has identical parameters to
the constructor it wraps, and the name of each subroutine is equal to the
trailing part of the class name, specifically the C<Foo> of
C<QDRDBMS::AST::Foo>, but with a C<new> prefix (so that Perl doesn't
confuse a fully-qualified sub name with a class name).  All of these
subroutines are exportable, but are not exported by default, and exist
solely as syntactic sugar to allow user code to have more brevity.  I<TODO:
 Reimplement these as lexical aliases or compile-time macros instead, to
avoid the overhead of extra routine calls.>

The usual way that QDRDBMS::AST indicates a failure is to throw an
exception; most often this is due to invalid input.  If an invoked routine
simply returns, you can assume that it has succeeded, even if the return
value is undefined.

=head2 The QDRDBMS::AST::BoolLit Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::TextLit Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::BlobLit Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::IntLit Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::TupleSel Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::QuasiTupleSel Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::RelationSel Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::QuasiRelationSel Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::VarInvo Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::FuncInvo Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::ProcInvo Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::FuncReturn Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::ProcReturn Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::EntityName Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::TypeInvoNQ Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::TypeInvoAQ Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::TypeDictNQ Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::TypeDictAQ Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::ExprDict Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::FuncDecl Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::ProcDecl Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::HostGateRtn Class

I<This documentation is pending.>

=head1 DIAGNOSTICS

I<This documentation is pending.>

=head1 CONFIGURATION AND ENVIRONMENT

I<This documentation is pending.>

=head1 DEPENDENCIES

This file requires any version of Perl 5.x.y that is at least 5.8.1.

=head1 INCOMPATIBILITIES

None reported.

=head1 SEE ALSO

Go to L<QDRDBMS> for the majority of distribution-internal references, and
L<QDRDBMS::SeeAlso> for the majority of distribution-external references.

=head1 BUGS AND LIMITATIONS

For design simplicity in the short term, all AST arguments that are
applicable must be explicitly defined by the user, even if it might be
reasonable for QDRDBMS to figure out a default value for them, such as
"same as self".  This limitation will probably be removed in the future.
All that said, a few arguments may be exempted from this limitation.

I<This documentation is pending.>

=head1 AUTHOR

Darren Duncan (C<perl@DarrenDuncan.net>)

=head1 LICENSE AND COPYRIGHT

This file is part of the QDRDBMS framework.

QDRDBMS is Copyright © 2002-2007, Darren Duncan.

See the LICENSE AND COPYRIGHT of L<QDRDBMS> for details.

=head1 ACKNOWLEDGEMENTS

The ACKNOWLEDGEMENTS in L<QDRDBMS> apply to this file too.

=cut
