###########################################################################
###########################################################################

module Muldis::Data_Language_Grammar_Reference::PTMD_STD
{
    sub extract_MUON_from_Text(Str:D $text)
    {
        return Muldis::Data_Language_Grammar_Reference::PTMD_STD::Grammar.parse(
            $text,
            :token<Muldis_Data_Language_PTMD_STD>,
            :actions(Muldis::Data_Language_Grammar_Reference::PTMD_STD::Actions.new())
        );
    }
}

###########################################################################
###########################################################################

grammar Muldis::Data_Language_Grammar_Reference::PTMD_STD::Grammar
{

###########################################################################

    token Muldis_Data_Language_PTMD_STD
    {
        ^ <ws>?
            <language_name> <ws>
            [<value> | <depot>]
        <ws>? $
    }

###########################################################################

    token language_name
    {
        <ln_base_name>
        <unspace> ':' <ln_base_authority>
        <unspace> ':' <ln_base_version_number>
        <unspace> ':' <ln_dialect>
        <unspace> ':' <ln_extensions>
    }

    token ln_base_name
    {
        Muldis_Data_Language
    }

    token ln_base_authority
    {
        <ln_elem_str>
    }

    token ln_base_version_number
    {
        <ln_elem_str>
    }

    token ln_dialect
    {
        PTMD_STD
    }

    token ln_elem_str
    {
        <nonquoted_ln_elem_str> | <quoted_ln_elem_str>
    }

    token nonquoted_ln_elem_str
    {
        <[ a..z A..Z 0..9 _ \- \. ]>+
    }

    token quoted_ln_elem_str
    {
        '"'
            [<[\ ..~]-["]> | '\\"']+
        '"'
    }

    token ln_extensions
    {
        '{' <ws>?
            catalog_abstraction_level <ws>? '=>' <ws>? <cat_abstr_level>
            <ws>? ',' <ws>? op_char_repertoire <ws>? '=>' <ws>? <op_cr>
            [<ws>? ',' <ws>? standard_syntax_extensions
                <ws>? '=>' <ws>? <std_syn_ext_list>]?
            [<ws>? ',']?
        <ws>? '}'
    }

    token cat_abstr_level
    {
          the_floor
        | code_as_data
        | plain_rtn_inv
        | rtn_inv_alt_syn
    }

    token op_cr
    {
        basic | extended
    }

    token std_syn_ext_list
    {
        '{' <ws>?
            [<std_syn_ext_list_item>+ % [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'
    }

    token std_syn_ext_list_item
    {
        ''
    }

###########################################################################

    token value
    {
        <value__code_as_data>
    }

    token catalog
    {
        <catalog__plain_rtn_inv>
    }

    token expr
    {
        <expr__rtn_inv_alt_syn>
    }

    token update_stmt
    {
        <update_stmt__rtn_inv_alt_syn>
    }

    token proc_stmt
    {
        <proc_stmt__rtn_inv_alt_syn>
    }

###########################################################################

    token Singleton_payload
    {
        <Singleton_payload__op_cr_extended>
    }

    token Bool_payload
    {
        <Bool_payload__op_cr_extended>
    }

    token nonquoted_name_str
    {
        <nonquoted_name_str__op_cr_extended>
    }

    token maybe_Nothing
    {
        <maybe_Nothing__op_cr_extended>
    }

    token comm_infix_reduce_op
    {
        <comm_infix_reduce_op__op_cr_extended>
    }

    token sym_dyadic_infix_op
    {
        <sym_dyadic_infix_op__op_cr_extended>
    }

    token nonsym_dyadic_infix_op
    {
        <nonsym_dyadic_infix_op__op_cr_extended>
    }

    token monadic_prefix_op
    {
        <monadic_prefix_op__op_cr_extended>
    }

    token proc_nonsym_dyadic_infix_op
    {
        <proc_nonsym_dyadic_infix_op__op_cr_extended>
    }

###########################################################################

    token value__the_floor
    {
          <Int>
        | <List>
    }

    token value__code_as_data
    {
          <opaque_value_literal>
        | <coll_value_selector>
    }

    token opaque_value_literal
    {
          <Singleton>
        | <Bool>
        | <Order>
        | <RoundMeth>
        | <Int>
        | <Rat>
        | <Blob>
        | <Text>
        | <Name>
        | <NameChain>
        | <PNSQNameChain>
        | <RatRoundRule>
    }

    token coll_value_selector
    {
          <Scalar>
        | <Tuple>
        | <Database>
        | <Relation>
        | <Set>
        | <Maybe>
        | <Array>
        | <Bag>
        | <SPInterval>
        | <MPInterval>
        | <List>
    }

###########################################################################

    token x_value
    {
        [
            <value_kind> ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <value_payload>
    }

    token value_kind
    {
          Singleton
        | Bool
        | Order
        | RoundMeth
        | Int | NNInt | PInt
        | Rat | NNRat | PRat
        | Blob | OctetBlob
        | Text
        | Name
        | NameChain
        | PNSQNameChain
        | RatRoundRule
        | DH? Scalar | '$'
        | DH? Tuple | '%'
        | Database
        | DH? Relation | '@'
        | DH? Set
        | DH? [Maybe | Just]
        | DH? Array
        | DH? Bag
        | DH? SPInterval
        | DH? MPInterval
        | List
    }

    token type_name
    {
        <PNSQNameChain_payload>
    }

    token value_payload
    {
          <Singleton_payload>
        | <Bool_payload>
        | <Order_payload>
        | <RoundMeth_payload>
        | <Int_payload>
        | <Rat_payload>
        | <Blob_payload>
        | <Text_payload>
        | <Name_payload>
        | <NameChain_payload>
        | <PNSQNameChain_payload>
        | <RatRoundRule_payload>
        | <Scalar_payload>
        | <Tuple_payload>
        | <Database_payload>
        | <Relation_payload>
        | <Set_payload>
        | <Maybe_payload>
        | <Array_payload>
        | <Bag_payload>
        | <SPInterval_payload>
        | <MPInterval_payload>
        | <List_payload>
    }

###########################################################################

    token Singleton
    {
        [Singleton ':' <unspace>]?
        <Singleton_payload>
    }

    token Singleton_payload__op_cr_basic
    {
        '-Inf' | Inf
    }

    token Singleton_payload__op_cr_extended
    {
          <Singleton_payload__op_cr_basic>
        | '-∞' | '∞'
    }

###########################################################################

    token Bool
    {
        [Bool ':' <unspace>]?
        <Bool_payload>
    }

    token Bool_payload__op_cr_basic
    {
        False | True
    }

    token Bool_payload__op_cr_extended
    {
          <Bool_payload__op_cr_basic>
        | '⊥' | '⊤'
    }

###########################################################################

    token Order
    {
        [Order ':' <unspace>]?
        <Order_payload>
    }

    token Order_payload
    {
        Less | Same | More
    }

###########################################################################

    token RoundMeth
    {
        [
            RoundMeth ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <RoundMeth_payload>
    }

    token RoundMeth_payload
    {
          Down | Up | ToZero | ToInf
        | HalfDown | HalfUp | HalfToZero | HalfToInf
        | HalfEven
    }

###########################################################################

    token Int
    {
        [
            [Int | NNInt | PInt] ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <Int_payload>
    }

    token Int_payload
    {
          <num_max_col_val> '#' <unspace> <int_body>
        | <num_radix_mark> <unspace> <int_body>
        | <d_int_body>
    }

    token num_max_col_val
    {
        <pint_head>
    }

    token num_radix_mark
    {
        0<[bodx]>
    }

    token int_body
    {
        0 | '-'?<pint_body>
    }

    token nnint_body
    {
        0 | <pint_body>
    }

    token pint_body
    {
        <pint_head> <pint_tail>?
    }

    token pint_head
    {
        <[ 1..9 A..Z a..z ]>
    }

    token pint_tail
    {
        [[_?<[ 0..9 A..Z a..z ]>+]+]+ % <splitter>
    }

    token d_int_body
    {
        0 | '-'?<d_pint_body>
    }

    token d_nnint_body
    {
        0 | <d_pint_body>
    }

    token d_pint_body
    {
        <d_pint_head> <d_pint_tail>?
    }

    token d_pint_head
    {
        <[ 1..9 ]>
    }

    token d_pint_tail
    {
        [[_?<[ 0..9 ]>+]+]+ % <splitter>
    }

###########################################################################

    token Rat
    {
        [
            [Rat | NNRat | PRat] ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <Rat_payload>
    }

    token Rat_payload
    {
          <num_max_col_val> '#' <unspace> <rat_body>
        | <num_radix_mark> <unspace> <rat_body>
        | <d_rat_body>
    }

    token rat_body
    {
          <int_body> <unspace> '.' <pint_tail>
        | <int_body> <unspace> '/' <pint_body>
        | <int_body> <unspace> '*' <pint_body> <unspace> '^' <int_body>
    }

    token d_rat_body
    {
          <d_int_body> <unspace> '.' <d_pint_tail>
        | <d_int_body> <unspace> '/' <d_pint_body>
        | <d_int_body> <unspace> '*' <d_pint_body>
            <unspace> '^' <d_int_body>
    }

###########################################################################

    token Blob
    {
        [
            [Blob | OctetBlob] ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <Blob_payload>
    }

    token Blob_payload
    {
          <blob_max_col_val> '#' <unspace> <blob_body>
        | <blob_radix_mark> <unspace> <blob_body>
    }

    token blob_max_col_val
    {
        <[137F]>
    }

    token blob_radix_mark
    {
        0<[box]>
    }

    token blob_body
    {
        '\''
            <[ 0..9 A..F a..f _ \s ]>*
        '\''
    }

###########################################################################

    token Text
    {
        [
            Text ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <Text_payload>
    }

    token Text_payload
    {
        '\''
            [<-[\']> | <escaped_char>]*
        '\''
    }

    token escaped_char
    {
          '\\\\' | '\\\'' | '\\"' | '\\`'
        | '\\t' | '\\n' | '\\f' | '\\r'
        | '\\c<' [
              [<[ A..Z ]>+]+ % ' '
            | [0 | <[ 1..9 ]> <[ 0..9 ]>*]
            | <[ 1..9 A..Z a..z ]> '#'
                [0 | <[ 1..9 A..Z a..z ]> <[ 0..9 A..Z a..z ]>*]
            | 0<[ bodx ]> [0 | <[ 1..9 A..F a..f ]> <[ 0..9 A..F a..f ]>*]
          ] '>'
    }

    token unspace
    {
        '\\' <ws>? '\\'
    }

    token splitter
    {
        '\\' \s* '\\'
    }

    token ws
    {
        \s+ [[<non_value_comment> | <visual_dividing_line>] \s+]*
    }

    token non_value_comment
    {
        '#' \s*
            '`' \s*
                [<-[\`]> | <escaped_char>]*
            \s* '`'
        \s* '#'
    }

    token visual_dividing_line
    {
        '#' ** 2..*
    }

###########################################################################

    token Name
    {
        Name ':' <unspace>
        [<type_name> ':' <unspace>]?
        <Name_payload>
    }

    token Name_payload
    {
        <nonquoted_name_str> | <quoted_name_str>
    }

    token nonquoted_name_str__op_cr_basic
    {
        [<[ a..z A..Z _ ]> <[ a..z A..Z 0..9 _ ]>*]+ % '-'
    }

    token nonquoted_name_str__op_cr_extended
    {
        [<alpha> \w*]+ % '-'
    }

    token quoted_name_str
    {
        '"'
            [<-[\"]> | <escaped_char>]*
        '"'
    }

    token NameChain
    {
        NameChain ':' <unspace>
        [<type_name> ':' <unspace>]?
        <NameChain_payload>
    }

    token NameChain_payload
    {
        <nc_nonempty> | <nc_empty>
    }

    token nc_nonempty
    {
        <Name_payload>+ % [<unspace> '.']
    }

    token nc_empty
    {
        '[]'
    }

    token PNSQNameChain
    {
        PNSQNameChain ':' <unspace>
        [<type_name> ':' <unspace>]?
        <PNSQNameChain_payload>
    }

    token PNSQNameChain_payload
    {
        <nc_nonempty>
    }

###########################################################################

    token RatRoundRule
    {
        RatRoundRule ':' <unspace>
        [<type_name> ':' <unspace>]?
        <RatRoundRule_payload>
    }

    token RatRoundRule_payload
    {
        '[' <ws>?
            <radix> <ws>? ',' <ws>? <min_exp> <ws>? ',' <ws>? <RoundMeth_payload>
        <ws>? ']'
    }

    token radix
    {
        <Int_payload>
    }

    token min_exp
    {
        <Int_payload>
    }

###########################################################################

    token Scalar
    {
        [DH? Scalar | '$'] ':' <unspace>
        <type_name> ':' <unspace>
        <Scalar_payload>
    }

    token Scalar_payload
    {
          <possrep_name> ':' <unspace> <possrep_attrs>
        | <possrep_attrs>
    }

    token possrep_name
    {
        <Name_payload>
    }

    token possrep_attrs
    {
        <tuple_list>
    }

###########################################################################

    token Tuple
    {
        [DH? Tuple | '%'] ':' <unspace>
        [<type_name> ':' <unspace>]?
        <Tuple_payload>
    }

    token Tuple_payload
    {
        <tuple_list> | <tuple_D0>
    }

    token tuple_list
    {
        '{' <ws>?
            [[<nonord_atvl> | <same_named_nonord_atvl>]+
                % [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'
    }

    token nonord_atvl
    {
        <attr_name> <ws>? '=>' <ws>? <expr>
    }

    token attr_name
    {
        <Name_payload>
    }

    token same_named_nonord_atvl
    {
        '=>' <attr_name>
    }

    token tuple_D0
    {
        D0
    }

###########################################################################

    token Database
    {
        Database ':' <unspace>
        [<type_name> ':' <unspace>]?
        <Database_payload>
    }

    token Database_payload
    {
        <Tuple_payload>
    }

###########################################################################

    token Relation
    {
        [DH? Relation | '@'] ':' <unspace>
        [<type_name> ':' <unspace>]?
        <Relation_payload>
    }

    token Relation_payload
    {
          <r_empty_body_payload>
        | <r_nonordered_attr_payload>
        | <r_ordered_attr_payload>
        | <relation_D0>
    }

    token r_empty_body_payload
    {
        '{' <ws>?
            [<attr_name>+ % [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'
    }

    token r_nonordered_attr_payload
    {
        '{' <ws>?
            [<tuple_list>+ % [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'
    }

    token r_ordered_attr_payload
    {
        '[' <ws>?
            [<attr_name>+ % [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? ']'
        ':' <unspace>
        '{' <ws>?
            [<ordered_tuple_attrs>+ % [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'
    }

    token ordered_tuple_attrs
    {
        '[' <ws>?
            [<expr>+ % [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? ']'
    }

    token relation_D0
    {
        D0C0 | D0C1
    }

###########################################################################

    token Set
    {
        [
            DH? Set ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <Set_payload>
    }

    token Set_payload
    {
        '{' <ws>?
            [<expr>+ % [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'
    }

###########################################################################

    token Maybe
    {
        [
            DH? [Maybe | Just] ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <Maybe_payload>
    }

    token Maybe_payload
    {
        <maybe_list> | <maybe_Nothing>
    }

    token maybe_list
    {
        '{' <ws>? <expr> <ws>? '}'
    }

    token maybe_Nothing__op_cr_basic
    {
        Nothing
    }

    token maybe_Nothing__op_cr_extended
    {
          <maybe_Nothing__op_cr_basic>
        | '∅'
    }

###########################################################################

    token Array
    {
        [
            DH? Array ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <Array_payload>
    }

    token Array_payload
    {
        '[' <ws>?
            [<expr>+ % [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? ']'
    }

###########################################################################

    token Bag
    {
        [
            DH? Bag ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <Bag_payload>
    }

    token Bag_payload
    {
          <bag_payload_counted_values>
        | <bag_payload_repeated_values>
    }

    token bag_payload_counted_values
    {
        '{' <ws>?
            [[<expr> <ws>? '=>' <ws>? <count>]+ % [<ws>? ',' <ws>?]
                [<ws>? ',']?]?
        <ws>? '}'
    }

    token count
    {
          <num_max_col_val> '#' <unspace> <pint_body>
        | <num_radix_mark> <unspace> <pint_body>
        | <d_pint_body>
    }

    token bag_payload_repeated_values
    {
        '{' <ws>?
            [<expr>+ % [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'
    }

###########################################################################

    token SPInterval
    {
        [
            DH? SPInterval ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <SPInterval_payload>
    }

    token SPInterval_payload
    {
        '{' <ws>?
            <interval>
        <ws>? '}'
    }

    token interval
    {
        <interval_range> | <interval_single>
    }

    token interval_range
    {
        <min> <ws>? <interval_boundary_kind> <ws>? <max>
    }

    token min
    {
        <expr>
    }

    token max
    {
        <expr>
    }

    token interval_boundary_kind
    {
        '..' | '..^' | '^..' | '^..^'
    }

    token interval_single
    {
        <expr>
    }

    token MPInterval
    {
        [
            DH? MPInterval ':' <unspace>
            [<type_name> ':' <unspace>]?
        ]?
        <MPInterval_payload>
    }

    token MPInterval_payload
    {
        '{' <ws>?
            [<interval>+ % [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'
    }

###########################################################################

    token List
    {
        List ':' <unspace>
        [<type_name> ':' <unspace>]?
        <List_payload>
    }

    token List_payload
    {
        '[' <ws>?
            [<expr>+ % [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? ']'
    }

###########################################################################

    token depot
    {
        <depot_catalog>
        [<ws> <depot_data>]?
    }

    token depot_catalog
    {
        'depot-catalog' <ws> <catalog>
    }

    token depot_data
    {
        'depot-data' <ws> <Database>
    }

    token catalog__code_as_data
    {
        <Database>
    }

    token catalog__plain_rtn_inv
    {
          <catalog__code_as_data>
        | <depot_catalog_payload>
    }

    token depot_catalog_payload
    {
        '{' <ws>?
            [[
                  <subdepot>
                | <named_material>
                | <self_local_dbvar_type>
            ]+ % <ws>]?
        <ws>? '}'
    }

    token subdepot
    {
        subdepot <ws> <subdepot_declared_name> <ws> <depot_catalog_payload>
    }

    token subdepot_declared_name
    {
        <Name_payload>
    }

    token self_local_dbvar_type
    {
        'self-local-dbvar-type' <ws> <PNSQNameChain_payload>
    }

###########################################################################

    token material
    {
          <function>
        | <procedure>
        | <scalar_type>
        | <tuple_type>
        | <relation_type>
        | <domain_type>
        | <subset_type>
        | <mixin_type>
        | <key_constr>
        | <distrib_key_constr>
        | <subset_constr>
        | <distrib_subset_constr>
        | <stim_resp_rule>
    }

###########################################################################

    token x_material
    {
        <named_material> | <anon_material>
    }

    token named_material
    {
        <material_kind> <ws> <material_declared_name>
            <ws> <material_payload>
    }

    token anon_material
    {
        <material_kind> <ws> <material_payload>
    }

    token material_kind
    {
          function
            | 'named-value'
            | 'value-map'
            | 'value-map-unary'
            | 'value-filter'
            | 'value-constraint'
            | 'value-reduction'
            | 'order-determination'
        | procedure
            | 'system-service'
            | transaction
            | recipe
            | updater
        | 'scalar-type'
        | 'tuple-type'
            | 'database-type'
        | 'relation-type'
        | 'domain-type'
        | 'subset-type'
        | 'mixin-type'
        | 'key-constraint'
            | 'primary-key'
        | 'distrib-key-constraint'
            | 'distrib-primary-key'
        | 'subset-constraint'
        | 'distrib-subset-constraint'
        | 'stimulus-response-rule'
    }

    token material_declared_name
    {
        <Name_payload>
    }

    token material_payload
    {
          <function_payload>
        | <procedure_payload>
        | <scalar_type_payload>
        | <tuple_type_payload>
        | <relation_type_payload>
        | <domain_type_payload>
        | <subset_type_payload>
        | <mixin_type_payload>
        | <key_constr_payload>
        | <distrib_key_constr_payload>
        | <subset_constr_payload>
        | <distrib_subset_constr_payload>
        | <stim_resp_rule_payload>
    }

###########################################################################

    token function
    {
        <function_kind>
        <ws> <material_declared_name>
        <ws> <function_payload>
    }

    token function_kind
    {
          function
        | 'named-value'
        | 'value-map'
        | 'value-map-unary'
        | 'value-filter'
        | 'value-constraint'
        | 'value-reduction'
        | 'order-determination'
    }

    token function_payload
    {
        <function_heading> <ws> <function_body>
    }

    token function_heading
    {
        <func_signature> [<ws> <implements_clause>]*
    }

    token func_signature
    {
        '(' <ws>?
            <result_type> <ws>? '<--'
            [<ws>? <func_param>+ % [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? ')'
    }

    token result_type
    {
        <type_name>
    }

    token func_param
    {
        <ro_reg_param>
    }

    token function_body
    {
        <nonempty_function_body> | <empty_function_body>
    }

    token nonempty_function_body
    {
        '{' <ws>?
            [[<with_clause> | <named_expr>] <ws>]*
            <result_expr>
        <ws>? '}'
    }

    token result_expr
    {
        <expr>
    }

    token empty_function_body
    {
        '{' <ws>? '...' <ws>? '}'
    }

###########################################################################

    token procedure
    {
        <procedure_kind>
        <ws> <material_declared_name>
        <ws> <procedure_payload>
    }

    token procedure_kind
    {
        procedure | 'system-service' | transaction | <recipe_kind>
    }

    token recipe_kind
    {
        recipe | updater
    }

    token procedure_payload
    {
        <procedure_heading> <ws> <procedure_body>
    }

    token procedure_heading
    {
        <proc_signature> [<ws> <implements_clause>]*
    }

    token proc_signature
    {
        '(' <ws>?
            [<proc_param>+ % [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? ')'
    }

    token proc_param
    {
          <upd_reg_param>
        | <ro_reg_param>
        | <upd_global_param>
        | <ro_global_param>
    }

    token upd_reg_param
    {
        <upd_sigil> <ro_reg_param>
    }

    token upd_sigil
    {
        '&'
    }

    token ro_reg_param
    {
        <param_name> <param_flag>? <ws>? ':' <ws>? <type_name>
    }

    token param_name
    {
        <lex_entity_name>
    }

    token lex_entity_name
    {
        <Name_payload>
    }

    token param_flag
    {
        <opt_param_flag> | <dispatch_param_flag>
    }

    token opt_param_flag
    {
        '?'
    }

    token dispatch_param_flag
    {
        '@'
    }

    token upd_global_param
    {
        <upd_sigil> <ro_global_param>
    }

    token ro_global_param
    {
        <param_name> <ws>? <infix_bind_op> <ws>? <global_var_name>
    }

    token infix_bind_op
    {
        '::='
    }

    token global_var_name
    {
        <PNSQNameChain_payload>
    }

    token implements_clause
    {
        implements <ws> <routine_name>
    }

    token routine_name
    {
        <PNSQNameChain_payload>
    }

    token procedure_body
    {
          <nonempty_procedure_body> | <empty_procedure_body>
        | <nonempty_recipe_body> | <empty_recipe_body>
    }

    token nonempty_procedure_body
    {
        <nonempty_procedure_body_or_compound_stmt>
    }

    token nonempty_recipe_body
    {
        <nonempty_recipe_body_or_multi_upd_stmt>
    }

    token nonempty_procedure_body_or_compound_stmt
    {
        '[' <ws>?
            [[<with_clause> | <proc_var> | <named_expr> | <proc_stmt>]+
                % <ws>]*
        <ws>? ']'
    }

    token nonempty_recipe_body_or_multi_upd_stmt
    {
        '{' <ws>?
            [[<with_clause> | <named_expr> | <update_stmt>]+ % <ws>]*
        <ws>? '}'
    }

    token with_clause
    {
        with <ws> <named_material>
    }

    token proc_var
    {
        var <ws> <var_name> <ws>? ':' <ws>? <type_name>
    }

    token var_name
    {
        <lex_entity_name>
    }

    token empty_procedure_body
    {
        '[' <ws>? '...' <ws>? ']'
    }

    token empty_recipe_body
    {
        '{' <ws>? '...' <ws>? '}'
    }

###########################################################################

    token scalar_type
    {
        'scalar-type'
        <ws> <material_declared_name>
        <ws> <scalar_type_payload>
    }

    token scalar_type_payload
    {
        '{' <ws>?
            [
                  <with_clause>
                | <composes_clause>
                | <base_type_clause>
                | <subtype_constraint_clause>
                | <possrep>
                | <possrep_map>
                | <default_clause>
            ]+ % <ws>
        <ws>? '}'
    }

    token subtype_constraint_clause
    {
        'subtype-constraint' <ws> <routine_name>
    }

    token possrep
    {
        possrep <ws>
        <possrep_name> <ws>
        '{' <ws>?
            <tuple_type_clause>
            [<ws> <is_base_clause>]?
        <ws>? '}'
    }

    token is_base_clause
    {
        'is-base'
    }

    token possrep_map
    {
        'possrep-map' <ws>
        '{' <ws>?
            <p2> <ws> from <ws> <p1>
            <ws> using <ws> <routine_name>
            <ws> 'reverse-using' <ws> <routine_name>
        <ws>? '}'
    }

    token p1
    {
        <possrep_name>
    }

    token p2
    {
        <possrep_name>
    }

###########################################################################

    token tuple_type
    {
        <tuple_type_kind>
        <ws> <material_declared_name>
        <ws> <tuple_type_payload>
    }

    token tuple_type_kind
    {
        'tuple-type' | 'database-type'
    }

    token tuple_type_payload
    {
        '{' <ws>?
            [
                  <with_clause>
                | <composes_clause>
                | <base_type_clause>
                | <tuple_attr>
                | <virtual_attr_map>
                | <constraint_clause>
                | <default_clause>
            ]+ % <ws>
        <ws>? '}'
    }

    token tuple_attr
    {
        attr <ws> <attr_name_lex> <ws>? ':' <ws>? <type_name>
    }

    token attr_name_lex
    {
        <lex_entity_name>
    }

    token virtual_attr_map
    {
        'virtual-attr-map' <ws>
        '{' <ws>?
            'determinant-attrs' <ws> <aliased_attr_list>
            <ws> 'dependent-attrs' <ws> <aliased_attr_list>
            <ws> 'map-function' <ws> <routine_name>
            [<ws> <is_updateable_clause>]?
        <ws>? '}'
    }

    token aliased_attr_list
    {
        '{' <ws>?
            [[<aliased_attr_pair> | <same_named_nonord_atvl>]+
                % [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'
    }

    token aliased_attr_pair
    {
        <attr_name_lex> <ws>? '=>' <ws>? <attr_nc_lex>
    }

    token is_updateable_clause
    {
        'is-updateable'
    }

###########################################################################

    token relation_type
    {
        'relation-type'
        <ws> <material_declared_name>
        <ws> <relation_type_payload>
    }

    token relation_type_payload
    {
        '{' <ws>?
            [
                  <with_clause>
                | <composes_clause>
                | <base_type_clause>
                | <tuple_type_clause>
                | <constraint_clause>
                | <default_clause>
            ]+ % <ws>
        <ws>? '}'
    }

    token tuple_type_clause
    {
        'tuple-type' <ws> <type_name>
    }

###########################################################################

    token domain_type
    {
        'domain-type'
        <ws> <material_declared_name>
        <ws> <domain_type_payload>
    }

    token domain_type_payload
    {
        '{' <ws>?
            [
                  <with_clause>
                | <composes_clause>
                | <domain_sources>
                | <domain_filters>
                | <constraint_clause>
                | <default_clause>
            ]+ % <ws>
        <ws>? '}'
    }

    token domain_sources
    {
        ['source-union' | 'source-intersection'] <ws>
        '{' <ws>?
            [<type_name> | <type_name>+ % [<ws>? ',' <ws>?] [<ws>? ',']?]
        <ws>? '}'
    }

    token domain_filters
    {
        ['filter-union' | 'filter-intersection'] <ws>
        '{' <ws>?
            [<type_name>+ % [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'
    }

###########################################################################

    token subset_type
    {
        'subset-type'
        <ws> <material_declared_name>
        <ws> <subset_type_payload>
    }

    token subset_type_payload
    {
        <subset_type_pl_long> | <subset_type_pl_short>
    }

    token subset_type_pl_long
    {
        '{' <ws>?
            [
                  <with_clause>
                | <composes_clause>
                | <base_type_clause>
                | <constraint_clause>
                | <default_clause>
            ]+ % <ws>
        <ws>? '}'
    }

    token base_type_clause
    {
        ['base-type' | of] <ws> <type_name>
    }

    token constraint_clause
    {
        [constraint | where] <ws> <constraint_name>
    }

    token constraint_name
    {
        <PNSQNameChain_payload>
    }

    token default_clause
    {
        default <ws> <routine_name>
    }

    token subset_type_pl_short
    {
        <base_type_clause>
        [<ws> <constraint_clause>]?
        [<ws> <default_clause>]?
    }

###########################################################################

    token mixin_type
    {
        'mixin-type'
        <ws> <material_declared_name>
        <ws> <mixin_type_payload>
    }

    token mixin_type_payload
    {
        '{' <ws>?
            [[
                  <with_clause>
                | <composes_clause>
            ]+ % <ws>]?
        <ws>? '}'
    }

    token composes_clause
    {
        composes <ws> <type_name> [<ws> <prov_def_clause>]?
    }

    token prov_def_clause
    {
        'and-provides-its-default'
    }

###########################################################################

    token key_constr
    {
        <key_constr_kind>
        <ws> <material_declared_name>
        <ws> <key_constr_payload>
    }

    token key_constr_kind
    {
        'key-constraint' | 'primary-key'
    }

    token key_constr_payload
    {
        '{' <ws>?
            [<attr_name_lex>+ % [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'
    }

###########################################################################

    token subset_constr
    {
        'subset-constraint'
        <ws> <material_declared_name>
        <ws> <subset_constr_payload>
    }

    token subset_constr_payload
    {
        '{' <ws>?
            parent <ws> <parent> <ws> 'using-key' <ws> <parent_key>
            <ws> child <ws> <child> <ws> 'using-attrs' <ws> <sc_attr_map>
        <ws>? '}'
    }

    token parent
    {
        <attr_nc_lex>
    }

    token attr_nc_lex
    {
        <lex_entity_nc>
    }

    token lex_entity_nc
    {
        <NameChain_payload>
    }

    token parent_key
    {
        <constraint_name>
    }

    token child
    {
        <attr_nc_lex>
    }

    token sc_attr_map
    {
        '{' <ws>?
            [[<sc_attr_pair> | <same_named_nonord_atvl>]+
                % [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? '}'
    }

    token sc_attr_pair
    {
        <child_attr> <ws>? '=>' <ws>? <parent_attr>
    }

    token child_attr
    {
        <attr_name_lex>
    }

    token parent_attr
    {
        <attr_name_lex>
    }

###########################################################################

    token stim_resp_rule
    {
        'stimulus-response-rule'
        <ws> <material_declared_name>
        <ws> <stim_resp_rule_payload>
    }

    token stim_resp_rule_payload
    {
        when <ws> <stimulus> <ws> invoke <ws> <response>
    }

    token stimulus
    {
        'after-mount'
    }

    token response
    {
        <routine_name>
    }

###########################################################################

    token expr__plain_rtn_inv
    {
          <delim_expr>
        | <expr_name>
        | <named_expr>
        | <value>
        | <accessor>
        | <func_invo>
        | <if_else_expr>
        | <given_when_def_expr>
        | <material_ref_sel_expr>
    }

    token expr__rtn_inv_alt_syn
    {
          <expr__plain_rtn_inv>
        | <func_invo_alt_syntax>
    }

    token delim_expr
    {
        '(' <ws>? <expr> <ws>? ')'
    }

    token expr_name
    {
        <lex_entity_name>
    }

    token named_expr
    {
        [let <ws>]? <expr_name> <ws> <infix_bind_op> <ws> <expr>
    }

###########################################################################

    token accessor
    {
        <acc_via_named> | <acc_via_topic> | <acc_via_anon>
    }

    token acc_via_named
    {
        <lex_entity_nc>
    }

    token acc_via_topic
    {
        '.' <NameChain_payload>
    }

    token acc_via_anon
    {
        <expr> <unspace> '.' <nc_nonempty>
    }

###########################################################################

    token func_invo
    {
        <routine_name> <unspace> <func_arg_list>
    }

    token func_arg_list
    {
        '(' <ws>?
            [<func_arg>+ % [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? ')'
    }

    token func_arg
    {
        <named_ro_arg> | <anon_ro_arg> | <same_named_ro_arg>
    }

###########################################################################

    token if_else_expr
    {
          if <ws> <if_expr> <ws> then <ws> <then_expr>
            <ws> else <ws> <else_expr>
        | <if_expr> <ws> '??' <ws> <then_expr> <ws> '!!' <ws> <else_expr>
    }

    token if_expr
    {
        <expr>
    }

    token then_expr
    {
        <expr>
    }

    token else_expr
    {
        <expr>
    }

###########################################################################

    token given_when_def_expr
    {
        given <ws> <given_expr> <ws>
        [when <ws> <when_expr> <ws> then <ws> <then_expr> <ws>]*
        default <ws> <default_expr>
    }

    token given_expr
    {
        <expr>
    }

    token when_expr
    {
        <expr>
    }

    token default_expr
    {
        <expr>
    }

###########################################################################

    token material_ref_sel_expr
    {
          <material_ref>
        | <primed_func>
    }

    token material_ref
    {
        '<' <material_name> '>'
    }

    token material_name
    {
        <PNSQNameChain_payload>
    }

    token primed_func
    {
        <material_ref> <unspace> <func_arg_list>
    }

###########################################################################

    token proc_stmt__plain_rtn_inv
    {
          <stmt_name>
        | <named_stmt>
        | <compound_stmt>
        | <multi_upd_stmt>
        | <proc_invo>
        | <try_catch_stmt>
        | <if_else_stmt>
        | <given_when_def_stmt>
        | <leave_or_iterate_or_loop_stmt>
    }

    token proc_stmt__rtn_inv_alt_syn
    {
          <proc_stmt__plain_rtn_inv>
        | <proc_invo_alt_syntax>
    }

    token update_stmt__plain_rtn_inv
    {
          <stmt_name>
        | <named_stmt>
        | <proc_invo>
    }

    token update_stmt__rtn_inv_alt_syn
    {
          <update_stmt__plain_rtn_inv>
        | <proc_invo_alt_syntax>
    }

    token stmt_name
    {
        <Name_payload>
    }

    token named_stmt
    {
        [let <ws>]? <stmt_name> <ws> <infix_bind_op> <ws> <proc_stmt>
    }

###########################################################################

    token compound_stmt
    {
        <nonempty_procedure_body_or_compound_stmt>
    }

###########################################################################

    token multi_upd_stmt
    {
        <nonempty_recipe_body_or_multi_upd_stmt>
    }

###########################################################################

    token proc_invo
    {
        <routine_name> <unspace> <proc_arg_list>
    }

    token proc_arg_list
    {
        '(' <ws>?
            [<proc_arg>+ % [<ws>? ',' <ws>?] [<ws>? ',']?]?
        <ws>? ')'
    }

    token proc_arg
    {
          <named_upd_arg>
        | <named_ro_arg>
        | <anon_upd_arg>
        | <anon_ro_arg>
        | <same_named_upd_arg>
        | <same_named_ro_arg>
    }

    token named_upd_arg
    {
        <upd_sigil> <named_ro_arg>
    }

    token named_ro_arg
    {
        <invo_param_name> <ws>? '=>' <ws>? <expr>
    }

    token invo_param_name
    {
        <Name_payload>
    }

    token anon_upd_arg
    {
        <upd_sigil> <anon_ro_arg>
    }

    token anon_ro_arg
    {
        <expr>
    }

    token same_named_upd_arg
    {
        <upd_sigil> <same_named_ro_arg>
    }

    token same_named_ro_arg
    {
        '=>' <invo_param_name>
    }

###########################################################################

    token try_catch_stmt
    {
        try <ws> <try_stmt>
        [<ws> catch <ws> <catch_stmt>]?
    }

    token try_stmt
    {
        <proc_stmt>
    }

    token catch_stmt
    {
        <proc_stmt>
    }

###########################################################################

    token if_else_stmt
    {
        if <ws> <if_expr> <ws> then <ws> <then_stmt>
        [<ws> else <ws> <else_stmt>]?
    }

    token then_stmt
    {
        <proc_stmt>
    }

    token else_stmt
    {
        <proc_stmt>
    }

###########################################################################

    token given_when_def_stmt
    {
        given <ws> <given_expr> <ws>
        [when <ws> <when_expr> <ws> then <ws> <then_stmt> <ws>]*
        [default <ws> <default_stmt>]?
    }

    token default_stmt
    {
        <proc_stmt>
    }

###########################################################################

    token leave_or_iterate_or_loop_stmt
    {
          <leave_stmt>
        | <iterate_stmt>
        | <loop_stmt>
    }

    token leave_stmt
    {
        leave [<ws> <stmt_name>]?
    }

    token iterate_stmt
    {
        iterate [<ws> <stmt_name>]?
    }

    token loop_stmt
    {
        loop <ws> <proc_stmt>
    }

###########################################################################

    token func_invo_alt_syntax
    {
          <comm_infix_reduce_op_invo>
        | <noncomm_infix_reduce_op_invo>
        | <sym_dyadic_infix_op_invo>
        | <nonsym_dyadic_infix_op_invo>
        | <monadic_prefix_op_invo>
        | <monadic_postfix_op_invo>
        | <postcircumfix_op_invo>
        | <num_op_invo_with_round>
        | <ord_compare_op_invo>
        | ...
    }

###########################################################################

    token comm_infix_reduce_op_invo
    {
        <expr>+ % [<ws> <comm_infix_reduce_op> <ws>]
    }

    token comm_infix_reduce_op__op_cr_basic
    {
          min | max
        | and | or | xnor | iff | xor
        | '+' | '*'
        | union | intersect | exclude | symdiff
        | join | times | 'cross-join'
        | 'union+' | 'union++' | 'intersect+'
    }

    token comm_infix_reduce_op__op_cr_extended
    {
          <comm_infix_reduce_op__op_cr_basic>
        | '∧' | '∨' | '↔' | '⊻' | '↮'
        | '∪' | '∩' | '∆'
        | '⋈' | '×'
        | '∪+' | '∪++' | '∩+'
    }

###########################################################################

    token noncomm_infix_reduce_op_invo
    {
        <expr>+ % [<ws> <noncomm_infix_reduce_op> <ws>]
    }

    token noncomm_infix_reduce_op
    {
        '[<=>]' | '~' | '//'
    }

###########################################################################

    token sym_dyadic_infix_op_invo
    {
        <expr> <ws> <sym_dyadic_infix_op> <ws> <expr>
    }

    token sym_dyadic_infix_op__op_cr_basic
    {
          '=' | '!='
        | nand | nor
        | '|-|'
        | compose
    }

    token sym_dyadic_infix_op__op_cr_extended
    {
          <sym_dyadic_infix_op__op_cr_basic>
        | '≠'
        | '⊼' | '↑' | '⊽' | '↓'
    }

###########################################################################

    token nonsym_dyadic_infix_op_invo
    {
        <lhs> <ws> <nonsym_dyadic_infix_op> <ws> <rhs>
    }

    token lhs
    {
        <expr>
    }

    token rhs
    {
        <expr>
    }

    token nonsym_dyadic_infix_op__op_cr_basic
    {
          isa | '!isa' | 'not-isa' | as | asserting | assuming
        | '<' | '<=' | '>' | '>='
        | imp | implies | nimp | if | nif
        | '-' | '/' | '^' | exp
        | '~#'
        | where | '!where' | 'not-where'
        | inside | '!inside'|'not-inside' | holds | '!holds'|'not-holds'
        | in | '!in' | 'not-in' | has | '!has' | 'not-has'
        | '{<=}' | '{!<=}' | '{>=}' | '{!>=}'
        | '{<}'  | '{!<}'  | '{>}'  | '{!>}'
        | '{<=}+' | '{!<=}+' | '{>=}+' | '{!>=}+'
        | '{<}+'  | '{!<}+'  | '{>}+'  | '{!>}+'
        | minus | except
        | '!matching' | 'not-matching' | antijoin | semiminus
        | matching | semijoin
        | divideby
        | 'minus+' | 'except+'
        | like | '!like' | 'not-like'
    }

    token nonsym_dyadic_infix_op__op_cr_extended
    {
          <nonsym_dyadic_infix_op__op_cr_basic>
        | '≤' | '≥'
        | '→' | '↛' | '←' | '↚'
        | '∈@' | '∉@' | '@∋' | '@∌'
        | '∈' | '∉' | '∋' | '∌'
        | '⊆' | '⊈' | '⊇' | '⊉'
        | '⊂' | '⊄' | '⊃' | '⊅'
        | '⊆+' | '⊈+' | '⊇+' | '⊉+'
        | '⊂+' | '⊄+' | '⊃+' | '⊅+'
        | '∖' | '⊿' | '⋉' | '÷'
        | '∖+'
    }

###########################################################################

    token monadic_prefix_op_invo
    {
        <monadic_prefix_op_invo_alpha> | <monadic_prefix_op_invo_sym>
    }

    token monadic_prefix_op_invo_alpha
    {
        <monadic_prefix_op_alpha> <ws> <expr>
    }

    token monadic_prefix_op_alpha
    {
        not | abs
    }

    token monadic_prefix_op_invo_sym
    {
        <monadic_prefix_op> <ws>? <expr>
    }

    token monadic_prefix_op__op_cr_basic
    {
        '!' | '#' | '#+' | '%' | '@'
    }

    token monadic_prefix_op__op_cr_extended
    {
          <monadic_prefix_op__op_cr_basic>
        | '¬'
    }

###########################################################################

    token monadic_postfix_op_invo
    {
        <expr> <ws>? <monadic_postfix_op>
    }

    token monadic_postfix_op
    {
        '++' | '--' | '!'
    }

###########################################################################

    token postcircumfix_op_invo
    {
          <pcf_acc_op_invo>
        | <s_pcf_op_invo> | <atb_pcf_op_invo> | <r_pcf_op_invo>
        | <pcf_mbe_op_invo> | <pcf_ary_op_invo>
    }

    token pcf_acc_op_invo
    {
        <pcf_s_acc_op_invo> | <pcf_t_acc_op_invo>
    }

    token pcf_s_acc_op_invo
    {
        <expr> <unspace> '.{' [<ws>? <possrep_name>]? ':' <ws>?
            <attr_name>
        <ws>? '}'
    }

    token pcf_t_acc_op_invo
    {
        <expr> <unspace> '.{' <ws>? <attr_name> <ws>? '}'
    }

    token s_pcf_op_invo
    {
        <expr> <unspace> '{' [<ws>? <possrep_name>]? ':' <ws>?
            [<pcf_projection> | <pcf_cmpl_proj>]
        <ws>? '}'
    }

    token atb_pcf_op_invo
    {
        <expr> <unspace> '{' <ws>?
            [
                  <pcf_rename>
                | <pcf_projection> | <pcf_cmpl_proj>
                | <pcf_wrap> | <pcf_cmpl_wrap>
                | <pcf_unwrap>
            ]
        <ws>? '}'
    }

    token r_pcf_op_invo
    {
        <expr> <unspace> '{' <ws>?
            [
                  <pcf_group> | <pcf_cmpl_group>
                | <pcf_ungroup>
                | <pcf_count_per_group>
            ]
        <ws>? '}'
    }

    token pcf_rename
    {
        <pcf_rename_map>
    }

    token pcf_rename_map
    {
        [<atnm_aft_bef> | <atnm_aft_bef>+ % [<ws>? ',' <ws>?] [<ws>? ',']?]
    }

    token atnm_aft_bef
    {
        <atnm_after> <ws>? '<-' <ws>? <atnm_before>
    }

    token atnm_after
    {
        <attr_name>
    }

    token atnm_before
    {
        <attr_name>
    }

    token pcf_projection
    {
        <pcf_atnms>?
    }

    token pcf_cmpl_proj
    {
        '!' <ws>? <pcf_atnms>
    }

    token pcf_atnms
    {
        [<attr_name> | <attr_name>+ % [<ws>? ',' <ws>?] [<ws>? ',']?]
    }

    token pcf_wrap
    {
        '%' <outer_atnm> <ws>? '<-' <ws>? <inner_atnms>
    }

    token pcf_cmpl_wrap
    {
        '%' <outer_atnm> <ws>? '<-' <ws>? '!' <ws>? <cmpl_inner_atnms>
    }

    token pcf_unwrap
    {
         <inner_atnms> <ws>? '<-' <ws>? '%' <outer_atnm>
    }

    token pcf_group
    {
        '@' <outer_atnm> <ws>? '<-' <ws>? <inner_atnms>
    }

    token pcf_cmpl_group
    {
        '@' <outer_atnm> <ws>? '<-' <ws>? '!' <ws>? <cmpl_inner_atnms>
    }

    token pcf_ungroup
    {
         <inner_atnms> <ws>? '<-' <ws>? '@' <outer_atnm>
    }

    token pcf_count_per_group
    {
        '#@' <count_atnm> <ws>? '<-' <ws>? '!' <ws>? <cmpl_inner_atnms>
    }

    token outer_atnm
    {
        <attr_name>
    }

    token count_atnm
    {
        <attr_name>
    }

    token inner_atnms
    {
        <pcf_atnms>
    }

    token cmpl_inner_atnms
    {
        <pcf_atnms>
    }

    token pcf_mbe_op_invo
    {
        <expr> '.{*}'
    }

    token pcf_ary_op_invo
    {
        <pcf_ary_acc_op_invo> | <pcf_ary_slice_op_invo>
    }

    token pcf_ary_value_op_invo
    {
        <expr> <unspace> '.[' <ws>? <index> <ws>? ']'
    }

    token index
    {
          <num_max_col_val> '#' <unspace> <nnint_body>
        | <num_radix_mark> <unspace> <nnint_body>
        | <d_nnint_body>
    }

    token pcf_ary_slice_op_invo
    {
        <expr> <unspace> '[' <ws>?
            <min_index> <ws>? <interval_boundary_kind> <ws>? <max_index>
        <ws>? ']'
    }

    token min_index
    {
        <index>
    }

    token max_index
    {
        <index>
    }

###########################################################################

    token num_op_invo_with_round
    {
        <num_op_invo> <ws> <rounded_with_meth_or_rule_clause>
    }

    token num_op_invo
    {
          <expr>
        | <infix_num_op_invo>
        | <prefix_num_op_invo>
        | <postfix_num_op_invo>
    }

    token infix_num_op_invo
    {
        <lhs> <ws> <infix_num_op> <ws> <rhs>
    }

    token infix_num_op
    {
        div | mod | '**' | log
    }

    token prefix_num_op_invo
    {
        <expr> <ws> <prefix_num_op>
    }

    token prefix_num_op
    {
        'e**'
    }

    token postfix_num_op_invo
    {
        <expr> <ws> <postfix_num_op>
    }

    token postfix_num_op
    {
        'log-e'
    }

    token rounded_with_meth_or_rule_clause
    {
        round <ws> [<round_meth> | <round_rule>]
    }

    token round_meth
    {
        <expr>
    }

    token round_rule
    {
        <expr>
    }

###########################################################################

    token ord_compare_op_invo
    {
        <lhs> <ws> '<=>' <ws> <rhs>
            [<ws> <assuming_clause>]?
            [<ws> <reversed_clause>]?
    }

###########################################################################

    token proc_invo_alt_syntax
    {
          <proc_monadic_postfix_op_invo>
        | <proc_nonsym_dyadic_infix_op_invo>
        | ...
    }

###########################################################################

    token proc_monadic_postfix_op_invo
    {
        <expr> <ws> <proc_monadic_postfix_op>
    }

    token proc_monadic_postfix_op
    {
        ':=++' | ':=--'
    }

###########################################################################

    token proc_nonsym_dyadic_infix_op_invo
    {
        <lhs> <ws> <proc_nonsym_dyadic_infix_op_invo> <ws> <rhs>
    }

    token proc_nonsym_dyadic_infix_op__op_cr_basic
    {
          ':='
        | ':=union'
        | ':=where' | ':=!where' | ':=not-where'
        | ':=intersect' | ':=minus' | ':=except'
        | ':=!matching' | ':=not-matching' | ':=antijoin' | ':=semiminus'
        | ':=matching' | ':=semijoin'
        | ':=exclude' | ':=symdiff'
    }

    token proc_nonsym_dyadic_infix_op__op_cr_extended
    {
          <proc_nonsym_dyadic_infix_op__op_cr_basic>
        | ':=∪'
        | ':=∩' | ':=∖' | ':=⊿' | ':=⋉'
        | ':=∆'
    }

###########################################################################

}

###########################################################################
###########################################################################

class Muldis::Data_Language_Grammar_Reference::PTMD_STD::Actions
{
}

###########################################################################
###########################################################################
