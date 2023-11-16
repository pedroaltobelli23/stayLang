%{
    #include "staylang.tab.h"
    int line_num = 1;
%}
%%
[ \t]       ; 
"["             { return LBRACKET; }
"]"             { return RBRACKET; }
"("             { return LPAR; }
")"             { return RPAR; }
"="             { return EQUAL; }
if              { return IF; }
else            { return ELSE; }
during          { return DURING; }
"~"             { return TILDE; }
"||"            { return OR; }
"&&"            { return AND; }
"=="            { return EQ; }
">"             { return GT; }
"<"             { return LT; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MULT; }
"/"             { return DIVIDE; }
"^"             { return POWER; }
"!"             { return NOT;}
variable        { return VARIABLE; }
int             { return INT_T; }
string          { return STRING_T; }
Log             { return PRINT; }
scanf           { return SCANF; }
\n              { ++line_num; return ENDL; } 
[0-9]+\.[0-9]+  { yylval.fval = atof(yytext); return FLOAT; }
[0-9]+          { yylval.ival = atoi(yytext); return INT; }
[a-zA-Z0-9]+    { yylval.sval = strdup(yytext);return IDENTIFIER;}
%%

int yywrap() {
    return 1;
}