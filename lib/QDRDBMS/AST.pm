use 5.008001;
use utf8;
use strict;
use warnings FATAL => 'all';

###########################################################################
###########################################################################

{ package QDRDBMS::AST; # module
    our $VERSION = 0.000000;
    # Note: This given version applies to all of this file's packages.

    use base 'Exporter';
    our @EXPORT_OK = qw(
        LitBool LitText LitBlob LitInt
        SetSel SeqSel BagSel
        EntityName ExprDict TypeDict
        VarInvo FuncInvo
        ProcInvo
        FuncReturn ProcReturn
        FuncDecl ProcDecl
        HostGateRtn
    );

###########################################################################

sub LitBool {
    my ($args) = @_;
    my ($v) = @{$args}{'v'};
    return QDRDBMS::AST::LitBool->new({ 'v' => $v });
}

sub LitText {
    my ($args) = @_;
    my ($v) = @{$args}{'v'};
    return QDRDBMS::AST::LitText->new({ 'v' => $v });
}

sub LitBlob {
    my ($args) = @_;
    my ($v) = @{$args}{'v'};
    return QDRDBMS::AST::LitBlob->new({ 'v' => $v });
}

sub LitInt {
    my ($args) = @_;
    my ($v) = @{$args}{'v'};
    return QDRDBMS::AST::LitInt->new({ 'v' => $v });
}

sub SetSel {
    my ($args) = @_;
    my ($v) = @{$args}{'v'};
    return QDRDBMS::AST::SetSel->new({ 'v' => $v });
}

sub SeqSel {
    my ($args) = @_;
    my ($v) = @{$args}{'v'};
    return QDRDBMS::AST::SeqSel->new({ 'v' => $v });
}

sub BagSel {
    my ($args) = @_;
    my ($v) = @{$args}{'v'};
    return QDRDBMS::AST::BagSel->new({ 'v' => $v });
}

sub EntityName {
    my ($args) = @_;
    my ($text, $seq) = @{$args}{'text', 'seq'};
    return QDRDBMS::AST::EntityName->new({
        'text' => $text, 'seq' => $seq });
}

sub ExprDict {
    my ($args) = @_;
    my ($map) = @{$args}{'map'};
    return QDRDBMS::AST::ExprDict->new({ 'map' => $map });
}

sub TypeDict {
    my ($args) = @_;
    my ($map) = @{$args}{'map'};
    return QDRDBMS::AST::TypeDict->new({ 'map' => $map });
}

sub VarInvo {
    my ($args) = @_;
    my ($v) = @{$args}{'v'};
    return QDRDBMS::AST::VarInvo->new({ 'v' => $v });
}

sub FuncInvo {
    my ($args) = @_;
    my ($func, $ro_args) = @{$args}{'func', 'ro_args'};
    return QDRDBMS::AST::FuncInvo->new({
        'func' => $func, 'ro_args' => $ro_args });
}

sub ProcInvo {
    my ($args) = @_;
    my ($proc, $upd_args, $ro_args)
        = @{$args}{'proc', 'upd_args', 'ro_args'};
    return QDRDBMS::AST::ProcInvo->new({
        'proc' => $proc, 'upd_args' => $upd_args, 'ro_args' => $ro_args });
}

sub FuncReturn {
    my ($args) = @_;
    my ($v) = @{$args}{'v'};
    return QDRDBMS::AST::FuncReturn->new({ 'v' => $v });
}

sub ProcReturn {
    return QDRDBMS::AST::ProcReturn->new();
}

sub FuncDecl {
    return QDRDBMS::AST::FuncDecl->new();
}

sub ProcDecl {
    return QDRDBMS::AST::ProcDecl->new();
}

sub HostGateRtn {
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

    sub as_perl {
        my ($self) = @_;
        confess q{not implemented by subclass } . (blessed $self);
    }

    sub equal_repr {
        my ($self) = @_;
        confess q{not implemented by subclass } . (blessed $self);
    }

} # role QDRDBMS::AST::Node

###########################################################################
###########################################################################

{ package QDRDBMS::AST::Expr; # role
    use base 'QDRDBMS::AST::Node';
} # role QDRDBMS::AST::Expr

###########################################################################
###########################################################################

{ package QDRDBMS::AST::LitBool; # class
    use base 'QDRDBMS::AST::Expr';

    use Carp;

    my $FALSE = (1 == 0);
    my $TRUE  = (1 == 1);

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
            = "QDRDBMS::AST::LitBool->new({ 'v' => $s });";
    }
    return $self->{$ATTR_AS_PERL};
}

###########################################################################

sub v {
    my ($self) = @_;
    return $self->{$ATTR_V};
}

###########################################################################

} # class QDRDBMS::AST::LitBool

###########################################################################
###########################################################################

{ package QDRDBMS::AST::LitText; # class
    use base 'QDRDBMS::AST::Expr';

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
            = "QDRDBMS::AST::LitText->new({ 'v' => $s });";
    }
    return $self->{$ATTR_AS_PERL};
}

###########################################################################

sub v {
    my ($self) = @_;
    return $self->{$ATTR_V};
}

###########################################################################

} # class QDRDBMS::AST::LitText

###########################################################################
###########################################################################

{ package QDRDBMS::AST::LitBlob; # class
    use base 'QDRDBMS::AST::Expr';

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
            = "QDRDBMS::AST::LitBlob->new({ 'v' => $s });";
    }
    return $self->{$ATTR_AS_PERL};
}

###########################################################################

sub v {
    my ($self) = @_;
    return $self->{$ATTR_V};
}

###########################################################################

} # class QDRDBMS::AST::LitBlob

###########################################################################
###########################################################################

{ package QDRDBMS::AST::LitInt; # class
    use base 'QDRDBMS::AST::Expr';

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
            = "QDRDBMS::AST::LitInt->new({ 'v' => $s });";
    }
    return $self->{$ATTR_AS_PERL};
}

###########################################################################

sub v {
    my ($self) = @_;
    return $self->{$ATTR_V};
}

###########################################################################

} # class QDRDBMS::AST::LitInt

###########################################################################
###########################################################################

{ package QDRDBMS::AST::ListSel; # role
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

    confess q{new(): Bad :$v arg; it is not an Array.}
        if ref $v ne 'ARRAY';
    foreach my $ve (@{$v}) {
        confess q{new(): Bad :$v arg elem; it is not}
                . q{ an object of a QDRDBMS::AST::Expr-doing class.}
            if !blessed $ve or !$ve->isa( 'QDRDBMS::AST::Expr' );
    }

    $self->{$ATTR_V} = [@{$v}];

    return $self;
}

###########################################################################

sub v {
    my ($self) = @_;
    return [@{$self->{$ATTR_V}}];
}

###########################################################################

} # role QDRDBMS::AST::ListSel

###########################################################################
###########################################################################

{ package QDRDBMS::AST::SetSel; # class
    use base 'QDRDBMS::AST::ListSel';
} # class QDRDBMS::AST::SetSel

###########################################################################
###########################################################################

{ package QDRDBMS::AST::SeqSel; # class
    use base 'QDRDBMS::AST::ListSel';
} # class QDRDBMS::AST::SeqSel

###########################################################################
###########################################################################

{ package QDRDBMS::AST::BagSel; # class
    use base 'QDRDBMS::AST::ListSel';
} # class QDRDBMS::AST::BagSel

###########################################################################
###########################################################################

{ package QDRDBMS::AST::EntityName; # class
    use base 'QDRDBMS::AST::Node';

    use Carp;

    my $ATTR_TEXT_POSSREP = 'text_possrep';
    my $ATTR_SEQ_POSSREP  = 'seq_possrep';

    my $LISTSEL_ATTR_V = 'v';

    my $ATTR_AS_PERL = 'as_perl';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    my ($text, $seq) = @{$args}{'text', 'seq'};

    die q{new(): Exactly 1 of the args (:$text|:$seq) must be defined.}
        if !(defined $text xor defined $seq);

    if (defined $text) {
        die q{new(): Bad :$text arg; it is not a valid object}
                . q{ of a QDRDBMS::AST::LitText-doing class.}
            if !$text->isa( 'QDRDBMS::AST::LitText' );
        my $text_v = $text->v();
        die q{new(): Bad :$text arg; it contains character sequences that}
                . q{ are invalid within the Text possrep of an EntityName.}
            if $text_v =~ m/ \\ \z/xs or $text_v =~ m/ \\ [^bp] /xs;

        $self->{$ATTR_TEXT_POSSREP} = $text;
        $self->{$ATTR_SEQ_POSSREP} = QDRDBMS::AST::SeqSel->new({ 'v' => (
                [map {
                        my $s = $_;
                        $s =~ s/ \\ p /./xsg;
                        $s =~ s/ \\ b /\\/xsg;
                        QDRDBMS::AST::LitText->new({ 'v' => $s });
                    } split /\./, $text_v]
            ) });
    }

    else { # defined $seq
        die q{new(): Bad :$v arg; it is not an object of a}
                . q{ QDRDBMS::AST::SeqSel-doing class.}
            if !$seq->isa( 'QDRDBMS::AST::SeqSel' );
        my $seq_elems = $seq->{$LISTSEL_ATTR_V};
        for my $seq_e (@{$seq_elems}) {
            die q{new(): Bad :$seq arg elem; it is not}
                    . q{ an object of a QDRDBMS::AST::LitText-doing class.}
                if !$seq_e->isa( 'QDRDBMS::AST::LitText' );
        }

        $self->{$ATTR_TEXT_POSSREP} = QDRDBMS::AST::LitText->new({ 'v' => (
                join q{.}, map {
                        my $s = $_->v();
                        $s =~ s/ \\ /\\b/xsg;
                        $s =~ s/ \. /\\p/xsg;
                        $s;
                    } @{$seq_elems}
            ) });
        $self->{$ATTR_SEQ_POSSREP} = $seq;
    }

    return $self;
}

###########################################################################

sub text {
    my ($self) = @_;
    return $self->{$ATTR_TEXT_POSSREP};
}

###########################################################################

sub seq {
    my ($self) = @_;
    return $self->{$ATTR_SEQ_POSSREP};
}

###########################################################################

} # class QDRDBMS::AST::EntityName

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
    foreach my $elem (@{$map}) {
        confess q{new(): Bad :$map arg elem; it is not a 2-element Array.}
            if ref $elem ne 'ARRAY' or @{$elem} != 2;
        my ($entity_name, $expr) = @{$elem};
        confess q{new(): Bad :$map arg elem; its first elem is not}
                . q{ an object of a QDRDBMS::AST::EntityName-doing class.}
            if !blessed $entity_name
                or !$entity_name->isa( 'QDRDBMS::AST::EntityName' );
        my $entity_name_text_v = $entity_name->text()->v();
        confess q{new(): Bad :$map arg elem; its first elem is not}
                . q{ distinct between the arg elems.}
            if exists $map_hoa->{$entity_name_text_v};
        confess q{new(): Bad :$map arg elem; its second elem is not}
                . q{ an object of a QDRDBMS::AST::Expr-doing class.}
            if !blessed $expr or !$expr->isa( 'QDRDBMS::AST::Expr' );
        my $elem_cpy = [$entity_name, $expr];
        push @{$map_aoa}, $elem_cpy;
        $map_hoa->{$entity_name_text_v} = $elem_cpy;
    }

    $self->{$ATTR_MAP_AOA} = $map_aoa;
    $self->{$ATTR_MAP_HOA} = $map_hoa;

    return $self;
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

} # class QDRDBMS::AST::ExprDict

###########################################################################
###########################################################################

{ package QDRDBMS::AST::TypeDict; # class
    use base 'QDRDBMS::AST::Node';

    use Carp;
    use Scalar::Util qw(blessed);

    my $ATTR_MAP_AOA = 'map_aoa';
    my $ATTR_MAP_HOA = 'map_hoa';

    # Note: This type may be generalized later to allow ::TypeDict values
    # and not just EntityName values; also, the latter will probably be
    # made more strict, to just be type names.

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
    foreach my $elem (@{$map}) {
        confess q{new(): Bad :$map arg elem; it is not a 2-element Array.}
            if ref $elem ne 'ARRAY' or @{$elem} != 2;
        my ($entity_name, $type_name) = @{$elem};
        confess q{new(): Bad :$map arg elem; its first elem is not}
                . q{ an object of a QDRDBMS::AST::EntityName-doing class.}
            if !blessed $entity_name
                or !$entity_name->isa( 'QDRDBMS::AST::EntityName' );
        my $entity_name_text_v = $entity_name->text()->v();
        confess q{new(): Bad :$map arg elem; its first elem is not}
                . q{ distinct between the arg elems.}
            if exists $map_hoa->{$entity_name_text_v};
        confess q{new(): Bad :$map arg elem; its second elem is not}
                . q{ an object of a QDRDBMS::AST::EntityName-doing class.}
            if !blessed $type_name
                or !$type_name->isa( 'QDRDBMS::AST::EntityName' );
        my $elem_cpy = [$entity_name, $type_name];
        push @{$map_aoa}, $elem_cpy;
        $map_hoa->{$entity_name_text_v} = $elem_cpy;
    }

    $self->{$ATTR_MAP_AOA} = $map_aoa;
    $self->{$ATTR_MAP_HOA} = $map_hoa;

    return $self;
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

} # class QDRDBMS::AST::TypeDict

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
        die q{new(): Bad :$upd_args arg elem expr; it is not}
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
    sub new {
        my ($class) = @_;
        return bless {}, $class;
    }
} # class QDRDBMS::AST::ProcReturn

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
    foreach my $stmt (@{$stmts}) {
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

1; # Magic true value required at end of a reuseable file's code.
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

    use QDRDBMS::AST qw(LitBool LitText LitBlob LitInt SetSel SeqSel BagSel
        EntityName ExprDict TypeDict VarInvo FuncInvo ProcInvo FuncReturn
        ProcReturn FuncDecl ProcDecl HostGateRtn);

    my $truth_value = LitBool({ 'v' => (2 + 2 == 4) });
    my $planetoid = LitText({ 'v' => 'Ceres' });
    my $package = LitBlob({ 'v' => (pack 'H2', 'P') });
    my $answer = LitInt({ 'v' => 42 });

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
        QDRDBMS::AST::EntityName
        QDRDBMS::AST::ExprDict
        QDRDBMS::AST::TypeDict
        QDRDBMS::AST::Expr (dummy role)
            QDRDBMS::AST::LitBool
            QDRDBMS::AST::LitText
            QDRDBMS::AST::LitBlob
            QDRDBMS::AST::LitInt
            QDRDBMS::AST::ListSel (implementing role)
                QDRDBMS::AST::SetSel
                QDRDBMS::AST::SeqSel
                QDRDBMS::AST::BagSel
            QDRDBMS::AST::VarInvo
            QDRDBMS::AST::FuncInvo
        QDRDBMS::AST::Stmt (dummy role)
            QDRDBMS::AST::ProcInvo
            QDRDBMS::AST::FuncReturn
            QDRDBMS::AST::ProcReturn
            # more control-flow statement types would go here
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
executed routine obtains input or returns output at C<execute()> time.

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
that this allows a semblence of maintaining the actual syntax that the user
specified, which is useful for their debugging purposes.  Another reason is
the desire to keep this library as light-weight as possible, such that it
just implements the essentials; doing refactoring can require a code size
and complexity that is orders of magnitude larger than these essentials,
and that work isn't always helpful.  It should also be noted that any nodes
having references to externally user-defined entities can't be fully
refactored as each of those represents a free variable that a static node
analysis can't decompose; only nodes consisting of just system-defined or
literal entities (meaning zero free variables) can be fully refactored in a
static node analysys (though there are a fair number of those in practice,
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
[C<LitBool>, C<LitText>, C<LitBlob>, C<LitInt>, C<EntityName>, C<VarInvo>,
C<ProcReturn>] are guaranteed to only ever have a single representation per
value, and so C<equal_repr> is guaranteed to indicate value equality of 2
nodes of those types.  In fact, to assist the consequence this point, these
node classes also have the C<equal_value> method which is an alias for
C<equal_repr>, so you can use C<equal_value> in your use code to make it
better self documenting; C<equal_repr> is still available for all node
types to assist automated use code that wants to treat all node types the
same.  It should also be noted that a C<LitBool> node can only possibly be
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
C<QDRDBMS::AST::Foo>.  All of these subroutines are exportable, but are not
exported by default, and exist soley as syntactic sugar to allow user code
to have more brevity.  I<TODO:  Reimplement these as lexical aliases or
compile-time macros instead, to avoid the overhead of extra routine calls.>

The usual way that QDRDBMS::AST indicates a failure is to throw an
exception; most often this is due to invalid input.  If an invoked routine
simply returns, you can assume that it has succeeded, even if the return
value is undefined.

=head2 The QDRDBMS::AST::LitBool Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::LitText Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::LitBlob Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::LitInt Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::SetSel Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::SeqSel Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::BagSel Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::EntityName Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::ExprDict Class

I<This documentation is pending.>

=head2 The QDRDBMS::AST::TypeDict Class

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

=head1 LICENCE AND COPYRIGHT

This file is part of the QDRDBMS framework.

QDRDBMS is Copyright © 2002-2007, Darren Duncan.

See the LICENCE AND COPYRIGHT of L<QDRDBMS> for details.

=head1 ACKNOWLEDGEMENTS

The ACKNOWLEDGEMENTS in L<QDRDBMS> apply to this file too.

=cut
