%{
  #include <cstdio>
  #include <iostream>
  using namespace std;

  // stuff from flex that bison needs to know about:
  extern "C" int yylex();
  extern int yyparse();
  extern FILE *yyin;
  extern int line_num;

  void yyerror(const char *s);
%}

%union {
    int ival;
    float fval;
    char *sval;
}

%token LBRACKET RBRACKET EQUAL IF ELSE DURING TILDE OR AND EQ GT LT PLUS MINUS MULT DIVIDE POWER VARIABLE INT_T STRING_T PRINT SCANF ENDL OTHER NOT LPAR RPAR QUOTEMARK

%token <ival> INT
%token <fval> FLOAT
%token <sval> IDENTIFIER

%%
// this is the actual grammar that bison will parse, but for right now it's just
// something silly to echo to the screen what bison gets from flex.  We'll
// make a real one shortly: 
program: /* empty */ | program statement;

statement_list: /* empty */ | statement_list statement;

block: LBRACKET ENDL statement_list RBRACKET;

string_p: QUOTEMARK IDENTIFIER QUOTEMARK;

assignment: IDENTIFIER EQUAL boolexpression;

statement: assignment ENDL | print ENDL | if_stmt ENDL | during ENDL | declaration ENDL;

declaration: | VARIABLE IDENTIFIER type | VARIABLE IDENTIFIER type EQUAL boolexpression;

if_stmt: IF boolexpression block | IF boolexpression block ELSE block;

during: DURING TILDE boolexpression TILDE block;

boolexpression: boolterm | boolexpression OR boolterm;

boolterm: relexpression | boolterm AND relexpression;

relexpression: expression | relexpression EQUAL expression | relexpression GT expression | relexpression LT expression;

expression: term | expression PLUS term | expression MINUS term;

term: factor | term DIVIDE factor | term MULT factor | term POWER factor;

factor: | PLUS factor | MINUS factor | NOT factor | INT | string_p | LPAR boolexpression RPAR | scan | IDENTIFIER;

type: | INT_T | STRING_T;

print: PRINT LPAR expression RPAR;

scan: SCANF LPAR RPAR;
%%

int main(int argc, char* argv[]) {
  // Check if a filename is provided as a command line argument
  if (argc != 2) {
    std::cerr << "Usage: " << argv[0] << " <filename>" << std::endl;
    return -1;
  }

  // open a file handle to a particular file:
  FILE *myfile = fopen(argv[1], "r");
  
  // make sure it is valid:
  if (!myfile) {
    cout << "I can't open a.staylang.file!" << endl;
    return -1;
  }

  // Set flex to read from it instead of defaulting to STDIN:
  yyin = myfile;
  
  // Parse through the input:
  yyparse();

  cout << "Code is correct!" << endl;
}

void yyerror(const char *s) {
  cout << "EEK, parse error on line " << line_num << "!  Message: " << s << endl;
  // might as well halt now:
  exit(-1);
}