###########################################################################
###########################################################################

module Muldis::Data_Language_Grammar_Reference::Plain_Text
{
    sub extract_MUON_from_Text(Str:D $text)
    {
        return Muldis::Data_Language_Grammar_Reference::Plain_Text::Grammar.parse(
            $text,
            :token<Muldis_Data_Language_Plain_Text>,
            :actions(Muldis::Data_Language_Grammar_Reference::Plain_Text::Actions.new())
        );
    }
}

###########################################################################
###########################################################################

grammar Muldis::Data_Language_Grammar_Reference::Plain_Text::Grammar
{

###########################################################################

    token Muldis_Data_Language_Plain_Text
    {
        ^ <parsing_unit> $
    }

    token parsing_unit
    {
        <shebang_line>? <sp> <parsing_unit_subject>
    }

###########################################################################

    token shebang_line
    {
        '#!' <shebang_directive> <shebang_whitespace_break>
    }

    token shebang_directive
    {
        ...
    }

    token shebang_whitespace_break
    {
        ...
    }

###########################################################################

    token parsing_unit_subject
    {
        <expr>
    }

###########################################################################

    token enumerated_char
    {
          <alphanumeric_char>
        | <quoting_char>
        | <bracketing_char>
        | <symbolic_char>
        | <whitespace_char>
        | <illegal_char>
    }

    token alphanumeric_char
    {
        <alpha_char> | <digit_char>
    }

    token alpha_char
    {
        <[ A..Z _ a..z ]>
    }

    token digit_char
    {
        <[ 0..9 ]>
    }

    token quoting_char
    {
        <["'`]>
    }

    token bracketing_char
    {
        '(' | ')' | '[' | ']' | '{' | '}'
    }

    token symbolic_char
    {
        <special_symbolic_char> | <regular_symbolic_char>
    }

    token special_symbolic_char
    {
        ',' | ':' | ';' | '\\'
    }

    token regular_symbolic_char
    {
        <regular_symbolic_char_ASCII> | <regular_symbolic_char_nonASCII>
    }

    token regular_symbolic_char_ASCII
    {
          '!' | '#' | '$' | '%' | '&' | '*' | '+' | '-' | '.' | '/'
        | '<' | '=' | '>' | '?' | '@' | '^' | '|' | '~'
    }

    token regular_symbolic_char_nonASCII
    {
          '¬' | '±' | '×' | '÷'
        | 'π' | 'ρ' | 'σ'
        | '←' | '↑' | '→' | '↓' | '↔' | '↚' | '↛' | '↮'
        | '∀' | '∃' | '∄' | '∅' | '∆' | '∈' | '∉' | '∋' | '∌' | '−' | '∕'
        | '∖' | '∞' | '∧' | '∨' | '∩' | '∪' | '≠' | '≤' | '≥' | '⊂' | '⊃'
        | '⊄' | '⊅' | '⊆' | '⊇' | '⊈' | '⊉' | '⊎' | '⊤' | '⊥' | '⊻' | '⊼'
        | '⊽' | '⊿' | '⋊' | '⋈' | '⋉'
        | '▷' | '⟕' | '⟖' | '⟗' | '⨝' | '⨯'
    }

    token whitespace_char
    {
        <ws_unrestricted_char> | <ws_restricted_outside_char>
    }

    token ws_unrestricted_char
    {
        ' '
    }

    token ws_restricted_outside_char
    {
        '\t' | '\n' | '\r'
    }

    token illegal_char
    {
        <[ \x[0]..\x[8] \x[B]..\x[C] \x[E]..\x[1F] \x[80]..\x[9F] ]>
    }

    token unrestricted_char
    {
          <alphanumeric_char>
        | <bracketing_char>
        | <symbolic_char>
        | <ws_unrestricted_char>
    }

    token restricted_outside_char
    {
        <unrestricted_char> | <ws_restricted_outside_char>
    }

    token restricted_inside_char
    {
        <-quoting_char -illegal_char -ws_restricted_outside_char>
    }

###########################################################################

    token escaped_char
    {
          '\\q' | '\\a' | '\\g'
        | '\\b'
        | '\\t' | '\\n' | '\\r'
        | ['\\c<' <nonsigned_int> '>']
    }

###########################################################################

    token sp
    {
        [<whitespace> | <quoted_sp_comment_str>]*
    }

    token whitespace
    {
        <whitespace_char>+
    }

    token quoted_sp_comment_str
    {
        '`' <-[`]>* '`'
    }

###########################################################################

    token alphanumeric_name
    {
        <alpha_char> <alphanumeric_char>*
    }

    token symbolic_name
    {
        <symbolic_char>+
    }

    token quoted_name
    {
        <quoted_name_seg>+ % <sp>
    }

    token quoted_name_seg
    {
        '\'' <qnots_content> '\''
    }

    token generic_name
    {
        <alphanumeric_name> | <quoted_name>
    }

    token fixed_name
    {
        <alphanumeric_name> | <symbolic_name>
    }

    token attr_name
    {
        <nonord_attr_name> | <ord_attr_name>
    }

    token nonord_attr_name
    {
        <generic_name>
    }

    token ord_attr_name
    {
        <nonsigned_int>
    }

    token nesting_attr_names
    {
        <attr_name>+ % [<sp> '::' <sp>]
    }

    token expr_name
    {
        <generic_name>
    }

    token var_name
    {
        <generic_name>
    }

    token stmt_name
    {
        <generic_name>
    }

    token pkg_entity_name
    {
          <absolute_name>
        | <relative_name>
        | <floating_name>
    }

    token absolute_name
    {
        '::' <sp> <floating_name>
    }

    token relative_name
    {
        <digit_char>+ [<sp> '::' <sp> <floating_name>]?
    }

    token floating_name
    {
        <generic_name>+ % [<sp> '::' <sp>]
    }

    token folder_name
    {
        <absolute_name>
    }

    token material_name
    {
        <absolute_name>
    }

    token generic_func_name
    {
        <pkg_entity_name>
    }

    token generic_proc_name
    {
        <pkg_entity_name>
    }

    token entry_point_rtn_name
    {
        <absolute_name>
    }

###########################################################################

    token expr
    {
        <expr_name> | <naming_expr> | <annotating_expr> | <anon_expr>
    }

    token naming_expr
    {
        <expr_name> <sp> '::=' <sp> <named_expr>
    }

    token named_expr
    {
        <expr>
    }

    token annotating_expr
    {
        <annotated_expr> note <annotation_expr>
    }

    token annotated_expr
    {
        <expr>
    }

    token annotation_expr
    {
        <expr>
    }

    token anon_expr
    {
          <delimiting_expr>
        | <source_expr>
        | <literal_expr>
        | <opaque_literal_expr>
        | <collection_selector_expr>
        | <collection_accessor_expr>
        | <invocation_expr>
        | <conditional_expr>
        | <fail_expr>
        | ...
    }

    token delimiting_expr
    {
        '(' <sp> [
            <naming_expr> | <result_expr> | ''
        ]+ % [<sp> ';' <sp>] <sp> ')'
    }

    token result_expr
    {
          [returns <sp> <expr>]
        | <expr_name>
        | <annotating_expr>
        | <anon_expr>
    }

    token source_expr
    {
        args
    }

    token literal_expr
    {
        literal <expr>
    }

    token fail_expr
    {
        fail
    }

###########################################################################

    token opaque_literal_expr
    {
          <Boolean>
        | <Integer>
        | <Fraction>
        | <Bits>
        | <Blob>
        | <Text>
        | <Simple_Excuse>
        | <Attr_Name>
        | <Nesting>
        | <Heading>
        | <Renaming>
        | <Identifier>
        | <Identity_Identifier>
    }

    token collection_selector_expr
    {
          <Array>
        | <Set>
        | <Bag>
        | <Tuple>
        | <Tuple_Array>
        | <Relation>
        | <Tuple_Bag>
        | <Article>
        | <Excuse>
        | <Function_Call>
    }

###########################################################################

    token Boolean
    {
        ['\\?' <sp>]? [False | True]
    }

###########################################################################

    token Integer
    {
        <nonquoted_int> | <quoted_int>
    }

    token nonquoted_int
    {
        ['\\+' <sp>]? <asigned_int>
    }

    token asigned_int
    {
        <num_sign>? <nonsigned_int>
    }

    token num_sign
    {
        '+' | '-'
    }

    token nonsigned_int
    {
        <num_radix_mark>? <num_seg>
    }

    token num_radix_mark
    {
        0 <[bodx]>
    }

    token num_seg
    {
        <num_char>+
    }

    token num_char
    {
        <nc2> | <nc8> | <nc10> | <nc16>
    }

    token nc2
    {
        <[ 0..1 _ ]>
    }

    token nc8
    {
        <[ 0..7 _ ]>
    }

    token nc10
    {
        <[ 0..9 _ ]>
    }

    token nc16
    {
        <[ 0..9 A..F _ a..f ]>
    }

    token quoted_int
    {
        <qu_num_head> <qu_asigned_int> <qu_num_tail>
    }

    token qu_num_head
    {
        '\\+' <sp> '"'
    }

    token qu_asigned_int
    {
        <asigned_int> <qu_num_mid>?
    }

    token qu_num_mid
    {
        <num_seg>+ % <qu_num_sp>
    }

    token qu_num_sp
    {
        '"' <sp> '"'
    }

    token qu_num_tail
    {
        '"'
    }

###########################################################################

    token Fraction
    {
        <nonquoted_frac> | <quoted_frac>
    }

    token nonquoted_frac
    {
        <nonquoted_int> <frac_div> <num_seg>
    }

    token frac_div
    {
        '.' | '/'
    }

    token quoted_frac
    {
        <qu_num_head> <qu_asigned_int> <frac_div> <qu_num_mid> <qu_num_tail>
    }

###########################################################################

    token Bits
    {
        '\\~?' <sp> [
              [['"' ['0b'? <nc2>* ]? '"']+ % <sp>]
            | [['"' ['0o'  <nc8>* ]? '"']+ % <sp>]
            | [['"' ['0x'  <nc16>*]? '"']+ % <sp>]
        ]
    }

###########################################################################

    token Blob
    {
        '\\~+' <sp> [
              [['"' ['0b'  <nc2>* ]? '"']+ % <sp>]
            | [['"' ['0x'? <nc16>*]? '"']+ % <sp>]
        ]
    }

###########################################################################

    token Text
    {
        ['\\~' <sp>]? [<Text_seg>+ % <sp>]
    }

    token Text_seg
    {
        '"' <qnots_content> '"'
    }

    token qnots_content
    {
        <qns_nonescaped_content> | <qns_escaped_content>
    }

    token qnots_nonescaped_content
    {
        [<+restricted_inside_char-[\\]> <restricted_inside_char>*]?
    }

    token qnots_escaped_content
    {
        '\\' [<+restricted_inside_char-[\\]> | <escaped_char>]*
    }

###########################################################################

    token Array
    {
        ['\\~' <sp>]? <ord_member_commalist>
    }

    token ord_member_commalist
    {
        '[' <sp> <member_commalist> <sp> ']'
    }

###########################################################################

    token Set
    {
        ['\\?' <sp>]? <nonord_member_commalist>
    }

###########################################################################

    token Bag
    {
        ['\\+' <sp>]? <nonord_member_commalist>
    }

    token nonord_member_commalist
    {
        '{' <sp> <member_commalist> <sp> '}'
    }

    token member_commalist
    {
        [<single_member> | <multiplied_member> | '']+ % [<sp> ',' <sp>]
    }

    token single_member
    {
        <member_expr>
    }

    token multiplied_member
    {
        <member_expr> <sp> ':' <sp> <multiplicity_expr>
    }

    token member_expr
    {
        <expr>
    }

    token multiplicity_expr
    {
        <expr>
    }

###########################################################################

    token Tuple
    {
        ['\\%' <sp>]? <delim_attr_commalist>
    }

    token delim_attr_commalist
    {
        '(' <sp> <attr_commalist> <sp> ')'
    }

    token attr_commalist
    {
        [<anon_attr> | <named_attr> | <nested_named_attr>
            | <same_named_attr> | <same_named_var> | '']+ % [<sp> ',' <sp>]
    }

    token anon_attr
    {
        <attr_asset_expr>
    }

    token named_attr
    {
        <attr_name> <sp> ':' <sp> <attr_asset_expr>
    }

    token nested_named_attr
    {
        <nesting_attr_names> <sp> ':' <sp> <attr_asset_expr>
    }

    token same_named_attr
    {
        ':' <sp> <attr_name>
    }

    token same_named_var
    {
        ':&' <sp> <attr_name>
    }

    token attr_asset_expr
    {
        <expr>
    }

###########################################################################

    token Tuple_Array
    {
        '\\~%' <sp> [<delim_attr_name_commalist> | <ord_member_commalist>]
    }

###########################################################################

    token Relation
    {
        '\\?%' <sp> [<delim_attr_name_commalist> | <nonord_member_commalist>]
    }

###########################################################################

    token Tuple_Bag
    {
        '\\+%' <sp> [<delim_attr_name_commalist> | <nonord_member_commalist>]
    }

###########################################################################

    token Article
    {
        ['\\:' <sp>]? '(' <sp> <c_label_expr> <sp> ':' <sp> <c_attrs_expr> <sp> ')'
    }

    token c_label_expr
    {
        <expr>
    }

    token c_attrs_expr
    {
        <expr>
    }

###########################################################################

    token Excuse
    {
        '\\!' <sp> <delim_attr_commalist>
    }

###########################################################################

    token Simple_Excuse
    {
        '\\!' <sp> <attr_name>
    }

###########################################################################

    token Nesting
    {
        '\\\$' <sp> <nesting_attr_names>
    }

###########################################################################

    token Attr_Name
    {
        '\\' <sp> <attr_name>
    }

    token Heading
    {
        '\\\$' <sp> <delim_attr_name_commalist>
    }

    token delim_attr_name_commalist
    {
        '(' <sp> <attr_name_commalist> <sp> ')'
    }

    token attr_name_commalist
    {
        [<attr_name> | <ord_attr_name_range> | '']+ % [<sp> ',' <sp>]
    }

    token ord_attr_name_range
    {
        <min_ord_attr> <sp> '..' <sp> <max_ord_attr>
    }

    token min_ord_attr
    {
        <ord_attr_name>
    }

    token max_ord_attr
    {
        <ord_attr_name>
    }

###########################################################################

    token Renaming
    {
        '\\\$:' <sp> '(' <sp> <renaming_commalist> <sp> ')'
    }

    token renaming_commalist
    {
        [<anon_attr_rename> | <named_attr_rename> | '']+ % [<sp> ',' <sp>]
    }

    token anon_attr_rename
    {
          ['->' <sp> <attr_name_after>]
        | [<attr_name_after> <sp> '<-']
        | [<attr_name_before> <sp> '->']
        | ['<-' <sp> <attr_name_before>]
    }

    token named_attr_rename
    {
          [<attr_name_before> <sp> '->' <sp> <attr_name_after>]
        | [<attr_name_after> <sp> '<-' <sp> <attr_name_before>]
    }

    token attr_name_before
    {
        <nonord_attr_name>
    }

    token attr_name_after
    {
        <nonord_attr_name>
    }

###########################################################################

    token Identifier
    {
        ...
    }

    token Identity_Identifier
    {
        ...
    }

###########################################################################

    token Function_Call
    {
        <long_arrowed_func_invo_sel> | <postcircumfixed_func_invo_sel>
    }

    token long_arrowed_func_invo_sel
    {
          [<generic_func_args> <sp> '\\-->' <sp> <generic_func_call>]
        | [<generic_func_call> <sp> '\\<--' <sp> <generic_func_args>]
    }

    token postcircumfixed_func_invo_sel
    {
        '\\' <postcircumfixed_func_invo_expr>
    }

###########################################################################

    token collection_accessor_expr
    {
          <Tuple_at>
        | <Article_label>
        | <Article_attrs>
        | <Article_at>
        | <Variable_current>
        | <Variable_at>
    }

    token Tuple_at
    {
        <expr> <sp> ':.' <sp> <expr>
    }

    token Article_label
    {
        <expr> <sp> ':<'
    }

    token Article_attrs
    {
        <expr> <sp> ':>'
    }

    token Article_at
    {
        <expr> <sp> ':>.' <sp> <expr>
    }

    token Variable_current
    {
        <expr> <sp> ':&'
    }

    token Variable_at
    {
        <expr> <sp> ':&.' <sp> <expr>
    }

###########################################################################

    token invocation_expr
    {
          <generic_func_invo_expr>
        | <fixed_func_invo_expr>
    }

###########################################################################

    token generic_func_invo_expr
    {
        <primed_func_invo_expr> | <postcircumfixed_func_invo_expr>
    }

    token primed_func_invo_expr
    {
        evaluates <sp> <primed_func_call>
    }

    token primed_func_call
    {
        <expr>
    }

    token postcircumfixed_func_invo_expr
    {
        <generic_func_name> <sp> '::'? <sp> <Tuple>
    }

###########################################################################

    token fixed_func_invo_expr
    {
        ...
    }

    token infix_func_invo_expr
    {
        ...
    }

    token infix_func_name_or_op_same
    {
        <special_infix_op_same> | <regular_infix_func_name>
    }

    token special_infix_op_same
    {
        '='
    }

###########################################################################

    token conditional_expr
    {
          <if_else_expr>
        | <and_then_expr>
        | <or_else_expr>
        | <given_when_def_expr>
        | <guard_expr>
    }

###########################################################################

    token ps1
    {
        ^ <shebang_line>? <ps2> $
    }

###########################################################################

    token ps2
    {
        <ps2_non_backtick_quoted>+ % <ps2_backtick_quoted>
    }

    token ps2_non_backtick_quoted
    {
        <ps2_nonquoted>+ % <ps2_double_or_single_quoted>
    }

    token ps2_nonquoted
    {
        <-quoting_char>*
    }

    token ps2_double_or_single_quoted
    {
        <ps2_double_quoted> | <ps2_single_quoted>
    }

    token ps2_double_quoted
    {
        '"' <-quoting_char>* '"'
    }

    token ps2_single_quoted
    {
        '\'' <-quoting_char>* '\''
    }

    token ps2_backtick_quoted
    {
        '`' <-[`]>* '`'
    }

###########################################################################

    token ps3_nonquoted
    {
          <alphanumeric_char>
        | <bracketing_char>
        | <symbolic_char>
        | <whitespace_char>
    }

###########################################################################

    token ps5_nonquoted_symbolic_grouping
    {
          ','
        | '::='
        | '::'
        | ':'
        | ';'
        | '\\'
    }

###########################################################################

    token ps8_quoted_sans_delimiters
    {
        <ps8_chars_nonescaped> | <ps8_chars_escaped>
    }

    token ps8_chars_nonescaped
    {
        [<-[\\]> .*]?
    }

    token ps8_chars_escaped
    {
        '\\' [<-[\\]> | <escaped_char>]*
    }

###########################################################################

    token ps9_numeric
    {
        <ps9_nonquoted_numeric> | <ps9_quoted_numeric>
    }

    token ps9_nonquoted_numeric
    {
        <num_sign>? <digit_char> <alphanumeric_char>*
            [<frac_div> <alphanumeric_char>]?
    }

    token ps9_quoted_numeric
    {
        '\\+' <sp> <ps2_single_quoted>+ % <sp>
    }

###########################################################################

}

###########################################################################
###########################################################################

class Muldis::Data_Language_Grammar_Reference::Plain_Text::Actions
{
}

###########################################################################
###########################################################################
