%{
#include <stdlib.h>
%}
%option yylineno

VARIABLE [a-z_]+
IDENTIFIER [A-Z][a-zA-z]+
STRING \".*\"
INTEGER [0-9]+
NEWLINE [\n | \r]

%%

ShowOnMap 			{return BLTIN_SHOW_ON_MAP;}
SearchLocation 		{return BLTIN_SEARCH_LOCATION;}
GetRoadSpeed 		{return BLTIN_GET_ROAD_SPEED;}
GetLocation 		{return BLTIN_GET_LOCATION;}
ShowTarget 			{return BLTIN_SHOW_TARGET;}
ShowCrossRoad 		{return BLTIN_SHOW_CROSS_ROAD;}
Print 				{return BLTIN_PRINT;}

INT 				{return INT_TYPE;}
STR 				{return STRING_TYPE;}
ARRAY 				{return ARRAY_TYPE;}
GRAPH 				{return GRAPH_TYPE;}

ADDRESS 			{return IRCE_ADDRESS;}
ROAD 				{return IRCE_ROAD;}
USER 				{return IRCE_USER;}
LONGITUDE 			{return IRCE_LONGITUDE;}
LATITUDE 			{return IRCE_LATITUDE;}
CROSSROAD 			{return IRCE_CROSSROAD;}

FUNC 				{return IRCE_FUNC;}
ENDFUNC 			{return IRCE_END_FUNC;}
CALL 				{return IRCE_CALL_FUNC;}

\= 					{return OPERATOR_EQUAL;}
\+ 					{return OPERATOR_SUM;}
\- 					{return OPERATOR_SUB;}
\* 					{return OPERATOR_MULT;}
\/ 					{return OPERATOR_DIV;}

\!\= 				{return COMPARATOR_NOT_EQUAL;}
\=\= 				{return COMPARATOR_EQUAL;}
\> 					{return COMPARATOR_GREATER;}
\< 					{return COMPARATOR_SMALLER;}
\>\= 				{return COMPARATOR_GREATER_EQUAL;}
\<\= 				{return COMPARATOR_SMALLER_EQUAL;}

\( 					{return LEFT_PAR;}
\) 					{return RIGHT_PAR;}
\, 					{return COMMA;}
\. 					{return DOT;}
\: 					{return COLON;}
\; 					{return SEMICOLON;}

IS 					{return TOKEN_IS;}
RETURN 				{return TOKEN_RETURN;}
NOTHING 			{return TOKEN_NOTHING;}
IF 					{return TOKEN_IF;}
ELSE 				{return TOKEN_ELSE;}
ENDIF 				{return TOKEN_ENDIF;}
WHILE 				{return TOKEN_WHILE;}
ENDWHILE 			{return TOKEN_END_WHILE;}
FOR 				{return TOKEN_FOR;}
ENDFOR 				{return TOKEN_END_FOR;}

START 				{return TOKEN_START;}
END 				{return TOKEN_END;}

TRUE 				{return BOOLEAN;}
FALSE 				{return BOOLEAN;}

AND 				{return AND;}
OR 					{return OR;}
NOT 				{return NOT;}

{INTEGER} 			{return INTEGER;}
{VARIABLE} 			{return VARIABLE;}
{IDENTIFIER} 		{return IDENTIFIER;}
{STRING} 			{return STRING;}

[ \t] ;
\n ;
%%

int yywrap()		{return 1;}

void yyerror( char *s){ 
	fprintf(stderr, "%s on line %d\n",s,yylineno);
} 
