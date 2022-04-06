%{
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "Sunflower.tab.h"
%}

%s comment

%option yylineno

Program  "Program"
Begin "Begin"
End "End"
Var "Var"
Set "Set"
If "If"
Then "Then"
Else "Else"
Endif "EndIf"
While "While"
Do "Do"
Endwhile "EndWhile"
Read "Read"
Write "Write"
Exit "Exit"

Equal "=="
Less_greater "<>"
Greater ">"
GreaterEqual ">="
Less "<"
LessEqual "<="
Assign "="
Add "+"
Minus "-"
Mul "*"
Div "/"
Rem "%"
L_parentheses "("
R_parentheses ")"
Or "Or"
And "And"
Not "Not"

comment "//"

delim [ \t]
ws {delim}+
Digit [0-9]
Intconst [1-9]{Digit}*|[0]
letter  [A-Za-z]
underscores "_"

Identifier ({letter}|{underscores})({letter}|{Digit}|{underscores})*
Illegal [.\S]*


%%
{comment} {BEGIN(comment);}
<comment>[^\n]* {}
<comment>[\n] {BEGIN(INITIAL);}

{Program} {return Program;}
{Begin} {return Begin;}
{End} {return End;}
{Var} {return Var;}
{Set} {return Set;}
{If} {return If;}
{Then} {return Then;}
{Else} {return Else;}
{Endif} {return Endif;}
{While} {return While;}
{Do} {return Do;}
{Endwhile} {return Endwhile;}
{Read} {return Read;}
{Write} {return Write;}
{Exit} {return Exit;}
{And} {return And;}
{Not} {return Not;}
{Or} {return Or;}

{Equal} {return Equal;}
{Less_greater} {return Less_greater;}
{Greater} {return Greater;}
{GreaterEqual} {return GreaterEqual;}
{Less} {return Less;}
{LessEqual} {return LessEqual;}
{Assign} {return Assign;}
{Add} {return Add;}
{Minus} {return Minus;}
{Mul} {return Mul;}
{Div} {return Div;}
{Rem} {return Rem;}
{L_parentheses} {return L_parentheses;}
{R_parentheses} {return R_parentheses;}
{Intconst} {yylval.number=atoi(yytext);return Intconst;}
{Identifier} {yylval.string=strdup(yytext);return Identifier;}

" "          {}
\n           {}
\t           {}

<<EOF>>      {return(EOF);}
%%

int yywarp()
{
    return 1;
}
