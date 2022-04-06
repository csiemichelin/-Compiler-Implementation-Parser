%{
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
extern int yylex();
extern int yylineno;
extern FILE *yyin;
void yyerror ( char const *s);
bool flag_show = false;

%}
%union {
        int number;
        char *string;
}


%token  Program
%token  Begin
%token  End
%token  Var
%token  Set
%token  If
%token  Then
%token  Else
%token  Endif
%token  While
%token  Do
%token  Endwhile
%token  Read
%token  Write
%token  Exit
%token ' '
%token '='
%token Or
%token And
%token Not

%token Equal
%token Less_greater
%token Greater
%token GreaterEqual
%token Less
%token LessEqual
%token Assign
%token Add
%token Minus
%token Mul
%token Div
%token Rem
%token L_parentheses
%token R_parentheses
%token Negative

%left Add Minus
%left Mul Div
%right Negative

%token Intconst
%token Identifier

%start program


%%

program 
        : Program Identifier Begin declarations statements End {if(flag_show)printf("program -> Program Identifier Begin declarations statements End\n");}
        ;

declarations
        : declarations Var Identifier {if(flag_show)printf("declarations -> declarations Var Identifier\n");}
        | {if(flag_show)printf("declarations -> empty\n");}
        ;

statements
        : statements statement {if(flag_show)printf("statements -> statements statement\n");}
        | {if(flag_show)printf("statements -> empty\n");}
        ;

statement
        : Set Identifier Assign arithmeticExpression {if(flag_show)printf("statement -> Set Identifier = arithmeticExpression\n");}
        | If booleanExpression Then statements Endif {if(flag_show)printf("statement -> If booleanExpression Then statements EndIf\n");}
        | If booleanExpression Then statements Else statements Endif {if(flag_show)printf("statement -> If booleanExpression Then statements Else statements EndIf\n");}
        | While booleanExpression Do statements Endwhile {if(flag_show)printf("statement -> While booleanExpression Do statements EndWhile\n");}
        | Read Identifier {if(flag_show)printf("statement -> Read Identifier\n");}
        | Write arithmeticExpression {if(flag_show)printf("statement -> Write arithmeticExpression\n");}
        | Exit {if(flag_show)printf("statement -> Exit\n");}
        ;

booleanExpression
        : booleanExpression Or booleanTerm {if(flag_show)printf("booleanExpression -> booleanExpression Or booleanTerm\n");}
        | booleanTerm {if(flag_show)printf("booleanExpression -> booleanTerm\n");}
        ;

booleanTerm
        : booleanTerm And booleanFactor {if(flag_show)printf("booleanTerm -> booleanTerm And booleanFactor\n");}
        | booleanFactor {if(flag_show)printf("booleanTerm -> booleanFactor\n");}
        ;

booleanFactor
        : Not booleanFactor {if(flag_show)printf("booleanFactor -> Not booleanFactor\n");}
        | relationExpression {if(flag_show)printf("booleanFactor -> relationExpression\n");}
        ;

relationExpression
        : arithmeticExpression Equal arithmeticExpression {if(flag_show)printf("relationExpression -> arithmeticExpression == arithmeticExpression\n");}
        | arithmeticExpression Less_greater arithmeticExpression {if(flag_show)printf("relationExpression -> arithmeticExpression <> arithmeticExpression\n");}
        | arithmeticExpression Greater arithmeticExpression {if(flag_show)printf("relationExpression -> arithmeticExpression > arithmeticExpression\n");}
        | arithmeticExpression GreaterEqual arithmeticExpression {if(flag_show)printf("relationExpression -> arithmeticExpression >= arithmeticExpression\n");}
        | arithmeticExpression Less arithmeticExpression {if(flag_show)printf("relationExpression -> arithmeticExpression < arithmeticExpression\n");}
        | arithmeticExpression LessEqual arithmeticExpression {if(flag_show)printf("relationExpression -> arithmeticExpression <= arithmeticExpression\n");}
        ;

arithmeticExpression
        : arithmeticExpression Add arithmeticTerm {if(flag_show)printf("arithmeticExpression -> arithmeticExpression + arithmeticTerm\n");}
        | arithmeticExpression Minus arithmeticTerm {if(flag_show)printf("arithmeticExpression -> arithmeticExpression - arithmeticTerm\n");}
        | arithmeticTerm {if(flag_show)printf("arithmeticExpression -> arithmeticTerm\n");}
        ;

arithmeticTerm
        : arithmeticTerm Mul arithmeticFactor {if(flag_show)printf("arithmeticTerm -> arithmeticTerm * arithmeticFactor\n");}
        | arithmeticTerm Div arithmeticFactor {if(flag_show)printf("arithmeticTerm -> arithmeticTerm / arithmeticFactor\n");}
        | arithmeticTerm Rem arithmeticFactor {if(flag_show)printf("%s","arithmeticTerm -> arithmeticTerm % arithmeticFactor\n");}
        | arithmeticFactor {if(flag_show)printf("arithmeticTerm -> arithmeticFactor\n");}
        ;

arithmeticFactor
        : Minus arithmeticFactor {if(flag_show)printf("arithmeticFactor -> -arithmeticFactor\n");}
        | primaryExpression {if(flag_show)printf("arithmeticFactor -> primaryExpression\n");}
        ;

primaryExpression 
        : Intconst {if(flag_show)printf("primaryExpression -> IntConst\n");}
        | Identifier {if(flag_show)printf("primaryExpression -> Identifier\n");}
        | L_parentheses arithmeticExpression R_parentheses {if(flag_show)printf("primaryExpression -> ( arithmeticExpression )\n");}
        ;

%%

void yyerror (char const *s){
    //fprintf(stderr, "%s\n", s);
    fprintf(stderr, "Syntax error: line %d\n",yylineno);
}

int main(int argc, char *argv[])
{
    if(strcmp("-p",argv[1]) == 0)
        flag_show = true;       
   
    yyin = fopen(argv[2],"r");
    yyparse();	//開始檢查文法動作
    return 0;
}

