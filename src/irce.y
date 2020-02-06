%token BLTIN_SHOW_ON_MAP
%token BLTIN_SEARCH_LOCATION
%token BLTIN_GET_ROAD_SPEED
%token BLTIN_GET_LOCATION
%token BLTIN_SHOW_TARGET
%token BLTIN_SHOW_CROSS_ROAD
%token BLTIN_PRINT

%token INT_TYPE
%token STRING_TYPE
%token ARRAY_TYPE
%token GRAPH_TYPE
%token IRCE_ADDRESS
%token IRCE_ROAD
%token IRCE_USER
%token IRCE_CROSSROAD
%token IRCE_LONGITUDE
%token IRCE_LATITUDE
%token IRCE_FUNC
%token IRCE_END_FUNC
%token IRCE_CALL_FUNC

%token OPERATOR_EQUAL
%token OPERATOR_SUM
%token OPERATOR_SUB
%token OPERATOR_MULT
%token OPERATOR_DIV

%token COMPARATOR_NOT_EQUAL
%token COMPARATOR_EQUAL
%token COMPARATOR_GREATER
%token COMPARATOR_SMALLER
%token COMPARATOR_GREATER_EQUAL
%token COMPARATOR_SMALLER_EQUAL

%token LEFT_PAR
%token RIGHT_PAR
%token COMMA
%token DOT
%token COLON
%token SEMICOLON

%token TOKEN_RETURN
%token TOKEN_IS
%token TOKEN_IF
%token TOKEN_ELSE
%token TOKEN_ENDIF
%token TOKEN_WHILE
%token TOKEN_END_WHILE
%token TOKEN_FOR
%token TOKEN_END_FOR
%token TOKEN_NOTHING

%token TOKEN_START
%token TOKEN_END

%token BOOLEAN

%token AND
%token OR
%token NOT

%token INTEGER
%token VARIABLE
%token IDENTIFIER
%token STRING

%%

program                     : TOKEN_START statement_list TOKEN_END {printf("Input program is valid\n"); exit(0);};

statement_list              : statement SEMICOLON
                            | statement SEMICOLON statement_list
	                        ;

statement                   : assignment_statement
                            | array_statement
                            | graph_statement
                            | if_statement
                            | while_statement
                            | function_define_statement
                            | function_call_statement
	                        | return_statement
	                        | expression;

assignment_statement        : type VARIABLE TOKEN_IS expression
                            | type VARIABLE TOKEN_IS function_call_statement
                            | type VARIABLE TOKEN_IS logic_expression;

array_statement             : ARRAY_TYPE type VARIABLE TOKEN_IS LEFT_PAR array_elements RIGHT_PAR;

array_elements              :   INTEGER         | INTEGER array_elements
                            |   VARIABLE        | VARIABLE array_elements
                            |   IRCE_CROSSROAD  | IRCE_CROSSROAD array_elements
                            |   IRCE_ROAD       | IRCE_ROAD array_elements
                            |   IRCE_ADDRESS    | IRCE_ADDRESS array_elements
                            ;

graph_statement             :   GRAPH_TYPE type type VARIABLE TOKEN_IS graph_elements;

graph_elements              :   LEFT_PAR longitude COMMA latitude RIGHT_PAR
                            |   LEFT_PAR longitude COMMA latitude RIGHT_PAR graph_elements

if_statement                : TOKEN_IF logic_expression COLON statement_list TOKEN_ELSE statement_list TOKEN_ENDIF
                            | TOKEN_IF logic_expression COLON statement_list TOKEN_ENDIF
                            ;

logic_expression            : term logic_operator term | BOOLEAN;

expression                  : term operator expression
                            | term;

term                        : INTEGER
                            | VARIABLE
                            | STRING;

                    
while_statement             :   TOKEN_WHILE logic_expression COLON statement_list TOKEN_END_WHILE
                            ;

function_define_statement   :   IRCE_FUNC IDENTIFIER LEFT_PAR define_parameter_list RIGHT_PAR COLON statement_list IRCE_END_FUNC
                            |   IRCE_FUNC IDENTIFIER LEFT_PAR RIGHT_PAR COLON statement_list IRCE_END_FUNC
                            ;

function_call_statement     :   IRCE_CALL_FUNC IDENTIFIER LEFT_PAR parameter_list RIGHT_PAR
                            |   IRCE_CALL_FUNC IDENTIFIER LEFT_PAR RIGHT_PAR
                            |   IRCE_CALL_FUNC BLTIN_SHOW_ON_MAP LEFT_PAR longitude COMMA latitude RIGHT_PAR 
                            |   IRCE_CALL_FUNC BLTIN_SEARCH_LOCATION LEFT_PAR address RIGHT_PAR
                            |   IRCE_CALL_FUNC BLTIN_GET_ROAD_SPEED LEFT_PAR road RIGHT_PAR
                            |   IRCE_CALL_FUNC BLTIN_GET_LOCATION LEFT_PAR user RIGHT_PAR
                            |   IRCE_CALL_FUNC BLTIN_SHOW_TARGET LEFT_PAR address RIGHT_PAR
                            |   IRCE_CALL_FUNC BLTIN_SHOW_CROSS_ROAD LEFT_PAR crossroad RIGHT_PAR
			                | 	IRCE_CALL_FUNC BLTIN_PRINT LEFT_PAR term RIGHT_PAR
                            ;

return_statement            :   TOKEN_RETURN expression
                            |   TOKEN_NOTHING
                            ;

define_parameter_list	    :	type term
			                |	type term define_parameter_list;

parameter_list              :  	term
                            |   term parameter_list
                            ;

operator                    :   OPERATOR_SUM
                            |   OPERATOR_SUB
                            |   OPERATOR_MULT
                            |   OPERATOR_DIV
			                |	OPERATOR_EQUAL
                            ;

logic_operator              :   COMPARATOR_GREATER
                            |   COMPARATOR_GREATER_EQUAL
                            |   COMPARATOR_SMALLER
                            |   COMPARATOR_SMALLER_EQUAL
                            |   COMPARATOR_NOT_EQUAL
			                | 	COMPARATOR_EQUAL
                            |   AND
                            |   OR
                            |   NOT
                            ;
                        
type                        : INT_TYPE
                            | STRING_TYPE
                            | IRCE_ADDRESS
                            | IRCE_LATITUDE
                            | IRCE_LONGITUDE
                            | IRCE_ROAD
                            | IRCE_USER
                            | IRCE_CROSSROAD;

longitude                   :   INTEGER INTEGER INTEGER;

latitude                    :   INTEGER INTEGER INTEGER;

address                     :   STRING;

road                        :   STRING | INTEGER;

user                        :   VARIABLE;

crossroad                   :   STRING | INTEGER;

%%

#include "lex.yy.c"

main()
{
	yyparse();
}
