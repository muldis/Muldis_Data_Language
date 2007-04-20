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
        EntityName
        VarNameExpr FuncInvoExpr
        ControlStmt ProcInvoStmt MultiProcInvoStmt
        Func Proc
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

sub VarNameExpr {
    my ($args) = @_;
    my ($var) = @{$args}{'var'};
    return QDRDBMS::AST::VarNameExpr->new({ 'var' => $var });
}

sub FuncInvoExpr {
    my ($args) = @_;
    my ($func, $func_args) = @{$args}{'func', 'func_args'};
    return QDRDBMS::AST::FuncInvoExpr->new({
        'func' => $func, 'func_args' => $func_args });
}

sub ControlStmt {
    return QDRDBMS::AST::ControlStmt->new();
}

sub ProcInvoStmt {
    my ($args) = @_;
    my ($proc, $proc_args) = @{$args}{'proc', 'proc_args'};
    return QDRDBMS::AST::ProcInvoStmt->new({
        'proc' => $proc, 'proc_args' => $proc_args });
}

sub MultiProcInvoStmt {
    return QDRDBMS::AST::MultiProcInvoStmt->new();
}

sub Func {
    return QDRDBMS::AST::Func->new();
}

sub Proc {
    return QDRDBMS::AST::Proc->new();
}

###########################################################################

} # module QDRDBMS::AST

###########################################################################
###########################################################################

{ package QDRDBMS::AST::Node; sub _dummy {} } # role

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

    my $ATTR_V = 'v';
        # A p5 Scalar that equals $FALSE|$TRUE.

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

    sub v {
        my ($self) = @_;
        return $self->{$ATTR_V};
    }

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

    sub v {
        my ($self) = @_;
        return $self->{$ATTR_V};
    }

} # class QDRDBMS::AST::LitText

###########################################################################
###########################################################################

{ package QDRDBMS::AST::LitBlob; # class
    use base 'QDRDBMS::AST::Expr';

    use Carp;
    use Encode qw(is_utf8);

    my $ATTR_V = 'v';
        # A p5 Scalar that is a byte-mode string; it has false utf8 flag.

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

    sub v {
        my ($self) = @_;
        return $self->{$ATTR_V};
    }

} # class QDRDBMS::AST::LitBlob

###########################################################################
###########################################################################

{ package QDRDBMS::AST::LitInt; # class
    use base 'QDRDBMS::AST::Expr';

    use Carp;

    my $ATTR_V = 'v';
        # A p5 Scalar that is a Perl integer or BigInt or canonical string.

    sub new {
        my ($class, $args) = @_;
        my $self = bless {}, $class;
        my ($v) = @{$args}{'v'};

        confess q{new(): Bad :$v arg; Perl 5 does not consider}
                . q{ it to be a canonical integer value.}
            if !defined $v or $v !~ m/(0|-?[1-9][0-9]*)/xs;

        $self->{$ATTR_V} = $v;

        return $self;
    }

    sub v {
        my ($self) = @_;
        return $self->{$ATTR_V};
    }

} # class QDRDBMS::AST::LitInt

###########################################################################
###########################################################################

{ package QDRDBMS::AST::ListSel; # role
    use base 'QDRDBMS::AST::Expr';

    use Carp;
    use Scalar::Util qw(blessed);

    my $ATTR_V = 'v';

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

    use Carp;

    my $ATTR_TEXT_POSSREP = 'text_possrep';
    my $ATTR_SEQ_POSSREP  = 'seq_possrep';

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
        $self->{$ATTR_TEXT_POSSREP} = $text;
        $self->{$ATTR_SEQ_POSSREP} = QDRDBMS::AST::SeqSel->new({ 'v' => (
                [map {
                        my $s = $_;
                        $s =~ s/ \\ \[pd\] /./xsg;
                        $s =~ s/ \\ \[bh\] /\\/xsg;
                        QDRDBMS::AST::LitText->new({ 'v' => $s });
                    } split /\./, $text->v()]
            ) });
    }

    else { # defined $seq
        die q{new(): Bad :$v arg; it is not an object of a}
                . q{ QDRDBMS::AST::SeqSel-doing class.}
            if !$seq->isa( 'QDRDBMS::AST::SeqSel' );
        my $seq_elems = $seq.v();
        for my $seq_e (@{$seq_elems}) {
            die q{new(): Bad :$seq arg elem; it is not}
                    . q{ an object of a QDRDBMS::AST::LitText-doing class.}
                if !$seq_e->isa( 'QDRDBMS::AST::LitText' );
        }
        $self->{$ATTR_TEXT_POSSREP} = QDRDBMS::AST::LitText->new({ 'v' => (
                join q{.}, map {
                        my $s = $_->v();
                        $s =~ s/ \\ /\\[bh]/xsg;
                        $s =~ s/ \. /\\[pd]/xsg;
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

{ package QDRDBMS::AST::VarNameExpr; # class
    use base 'QDRDBMS::AST::Expr';

    use Carp;
    use Scalar::Util qw(blessed);

    my $ATTR_VAR_NAME = 'var_name';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    my ($var_name) = @{$args}{'var'};

    confess q{new(): Bad :$var arg; it is not a valid object}
            . q{ of a QDRDBMS::AST::EntityName-doing class.}
        if !blessed $var_name
            or !$var_name->isa( 'QDRDBMS::AST::EntityName' );
    $self->{$ATTR_VAR_NAME} = $var_name;

    return $self;
}

###########################################################################

sub var {
    my ($self) = @_;
    return $self->{$ATTR_VAR_NAME};
}

###########################################################################

} # class QDRDBMS::AST::VarNameExpr

###########################################################################
###########################################################################

{ package QDRDBMS::AST::FuncInvoExpr; # class
    use base 'QDRDBMS::AST::Expr';

    use Carp;
    use Scalar::Util qw(blessed);

    my $ATTR_FUNC_NAME     = 'func_name';
    my $ATTR_FUNC_ARGS_AOA = 'func_args_aoa';
    my $ATTR_FUNC_ARGS_HOA = 'func_args_hoa';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    my ($func_name, $func_args) = @{$args}{'func', 'func_args'};

    confess q{new(): Bad :$func arg; it is not a valid object}
            . q{ of a QDRDBMS::AST::EntityName-doing class.}
        if !blessed $func_name
            or !$func_name->isa( 'QDRDBMS::AST::EntityName' );
    $self->{$ATTR_FUNC_NAME} = $func_name;

    confess q{new(): Bad :$func_args arg; it is not an Array.}
        if ref $func_args ne 'ARRAY';
    my $func_args_aoa = [];
    my $func_args_hoa = {};
    foreach my $elem (@{$func_args}) {
        confess q{new(): Bad :$func_args arg elem;}
                . q{ it is not a 2-element Array.}
            if ref $elem ne 'ARRAY' or @{$elem} != 2;
        my ($param_name, $expr_ast) = @{$elem};
        confess q{new(): Bad :$func_args arg elem; its first elem is not}
                . q{ an object of a QDRDBMS::AST::EntityName-doing class.}
            if !blessed $param_name
                or !$param_name->isa( 'QDRDBMS::AST::EntityName' );
        my $param_name_text = ${$param_name->text()};
        confess q{new(): Bad :$func_args arg elem; its first elem is not}
                . q{ distinct between the arg elems.}
            if exists $func_args_hoa->{$param_name_text};
        confess q{new(): Bad :$func_args arg elem; its second elem is not}
                . q{ an object of a QDRDBMS::AST::Expr-doing class.}
            if !blessed $expr_ast
                or !$expr_ast->isa( 'QDRDBMS::AST::Expr' );
        my $elem_cpy = [$param_name, $expr_ast];
        push @{$func_args_aoa}, $elem_cpy;
        $func_args_hoa->{$param_name_text} = $elem_cpy;
    }
    $self->{$ATTR_FUNC_ARGS_AOA} = $func_args_aoa;
    $self->{$ATTR_FUNC_ARGS_HOA} = $func_args_hoa;

    return $self;
}

###########################################################################

sub func {
    my ($self) = @_;
    return $self->{$ATTR_FUNC_NAME};
}

sub func_args {
    my ($self) = @_;
    return [map { [@{$_}] } @{$self->{$ATTR_FUNC_ARGS_AOA}}];
}

sub func_args_hoa {
    my ($self) = @_;
    my $h = $self->{$ATTR_FUNC_ARGS_HOA};
    return {map { $_ => [@{$h->{$_}}] } keys %{$h}};
}

###########################################################################

} # class QDRDBMS::AST::FuncInvoExpr

###########################################################################
###########################################################################

{ package QDRDBMS::AST::Stmt; sub _dummy {} }

###########################################################################
###########################################################################

{ package QDRDBMS::AST::ControlStmt; # class
    use base 'QDRDBMS::AST::Stmt';

    use Carp;
    use Scalar::Util qw(blessed);



###########################################################################




###########################################################################

} # class QDRDBMS::AST::ControlStmt

###########################################################################
###########################################################################

{ package QDRDBMS::AST::ProcInvoStmt; # class
    use base 'QDRDBMS::AST::Stmt';

    use Carp;
    use Scalar::Util qw(blessed);

    my $ATTR_PROC_NAME     = 'proc_name';
    my $ATTR_PROC_ARGS_AOA = 'proc_args_aoa';
    my $ATTR_PROC_ARGS_HOA = 'proc_args_hoa';

###########################################################################

sub new {
    my ($class, $args) = @_;
    my $self = bless {}, $class;
    my ($proc_name, $proc_args) = @{$args}{'proc', 'proc_args'};

    confess q{new(): Bad :$proc arg; it is not a valid object}
            . q{ of a QDRDBMS::AST::EntityName-doing class.}
        if !blessed $proc_name
            or !$proc_name->isa( 'QDRDBMS::AST::EntityName' );
    $self->{$ATTR_PROC_NAME} = $proc_name;

    confess q{new(): Bad :$proc_args arg; it is not an Array.}
        if ref $proc_args ne 'ARRAY';
    my $proc_args_aoa = [];
    my $proc_args_hoa = {};
    foreach my $elem (@{$proc_args}) {
        confess q{new(): Bad :$proc_args arg elem;}
                . q{ it is not a 2-element Array.}
            if ref $elem ne 'ARRAY' or @{$elem} != 2;
        my ($param_name, $expr_ast) = @{$elem};
        confess q{new(): Bad :$proc_args arg elem; its first elem is not}
                . q{ an object of a QDRDBMS::AST::EntityName-doing class.}
            if !blessed $param_name
                or !$param_name->isa( 'QDRDBMS::AST::EntityName' );
        my $param_name_text = ${$param_name->text()};
        confess q{new(): Bad :$proc_args arg elem; its first elem is not}
                . q{ distinct between the arg elems.}
            if exists $proc_args_hoa->{$param_name_text};
        confess q{new(): Bad :$proc_args arg elem; its second elem is not}
                . q{ an object of a QDRDBMS::AST::Expr-doing class.}
            if !blessed $expr_ast
                or !$expr_ast->isa( 'QDRDBMS::AST::Expr' );
        my $elem_cpy = [$param_name, $expr_ast];
        push @{$proc_args_aoa}, $elem_cpy;
        $proc_args_hoa->{$param_name_text} = $elem_cpy;
    }
    $self->{$ATTR_PROC_ARGS_AOA} = $proc_args_aoa;
    $self->{$ATTR_PROC_ARGS_HOA} = $proc_args_hoa;

    return $self;
}

###########################################################################

sub proc {
    my ($self) = @_;
    return $self->{$ATTR_PROC_NAME};
}

sub proc_args {
    my ($self) = @_;
    return [map { [@{$_}] } @{$self->{$ATTR_PROC_ARGS_AOA}}];
}

sub proc_args_hoa {
    my ($self) = @_;
    my $h = $self->{$ATTR_PROC_ARGS_HOA};
    return {map { $_ => [@{$h->{$_}}] } keys %{$h}};
}

###########################################################################

} # class QDRDBMS::AST::ProcInvoStmt

###########################################################################
###########################################################################

{ package QDRDBMS::AST::MultiProcInvoStmt; # class
    use base 'QDRDBMS::AST::Stmt';

    use Carp;
    use Scalar::Util qw(blessed);



###########################################################################




###########################################################################

} # class QDRDBMS::AST::MultiProcInvoStmt

###########################################################################
###########################################################################

{ package QDRDBMS::AST::Func; # class

    use Carp;
    use Scalar::Util qw(blessed);



###########################################################################




###########################################################################

} # class QDRDBMS::AST::Func

###########################################################################
###########################################################################

{ package QDRDBMS::AST::Proc; # class

    use Carp;
    use Scalar::Util qw(blessed);



###########################################################################




###########################################################################

} # class QDRDBMS::AST::Proc

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

    use QDRDBMS::AST qw(LitBool LitText LitBlob LitInt);

    my $truth_value = LitBool({ 'v' => (2 + 2 == 4) });
    my $planetoid = LitText({ 'v' => 'Ceres' });
    my $package = LitBlob({ 'v' => (pack 'H2', 'P') });
    my $answer = LitInt({ 'v' => 42 });

I<This documentation is pending.>

=head1 DESCRIPTION

I<This documentation is pending.>

=head1 INTERFACE

The interface of QDRDBMS::AST is a combination of functions, objects, and
overloading.

The usual way that QDRDBMS::AST indicates a failure is to throw an
exception; most often this is due to invalid input.  If an invoked routine
simply returns, you can assume that it has succeeded, even if the return
value is undefined.

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
