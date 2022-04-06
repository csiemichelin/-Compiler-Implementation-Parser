# Implementation of a Parser
## 目錄
 - [環境設置與使用方法](#環境設置與使用方法)
 - [介紹](#介紹)
 - [Demo](#Demo)  
## 環境設置與使用方法
**1. 環境設置**  
&emsp;Ubuntu平臺下面Lex和Yacc開發環境所需要安裝的程序：    
&emsp;&emsp;* **Lex(flex.exe)和Yacc(bison.exe)環境**        
&emsp;&emsp;&emsp;```sudo apt-get install flex bison```    
&emsp;&emsp;* **C/C++編譯器**      
&emsp;&emsp;&emsp;```sudo apt-get update```      
&emsp;&emsp;&emsp;```sudo apt-get upgrade```      
&emsp;&emsp;&emsp;```sudo apt-get install build-essential```        
&emsp;&emsp;&emsp;```sudo apt-get install libc6-dev``  
**2. 使用方法**  
&emsp;&emsp;<img src="https://github.com/csiemichelin/Compiler-Implementation-Parser/blob/main/bison.jpg" width="500" height="250">    
&emsp;&emsp;根據以上圖示去執行但這裡使用makefile簡化步驟，只要在terminal上輸入```make```即可。

## 介紹
**1.** In this assignment you are requested to use the tool Bison to write an LALR(1) parser for the small language Sunflower. The grammar for the small language Sunflower is as follows:  
&emsp;program → **Program Identifier Begin** declarations statements **End** 
&emsp;declarations → declarations **Var Identifier** | **ε**  
&emsp;statements → statements statement | **ε**  
&emsp;statement → **Set Identifier** = arithmeticExpression  
&emsp;&emsp;| **If** booleanExpression **Then** statements **EndIf**  
&emsp;&emsp;| **If** booleanExpression **Then** statements **Else** statements **EndIf**  
&emsp;&emsp;| **While** booleanExpression **Do** statements **EndWhile**  
&emsp;&emsp;| **Read Identifier**  
&emsp;&emsp;| **Write** arithmeticExpression   
&emsp;&emsp;| **Exit**   
&emsp;booleanExpression → booleanExpression **Or** booleanTerm   
&emsp;&emsp;| booleanTerm   
&emsp;booleanTerm → booleanTerm **And** booleanFactor   
&emsp;&emsp;| booleanFactor   
&emsp;booleanFactor → **Not** booleanFactor | relationExpression  
&emsp;relationExpression → arithmeticExpression **==** arithmeticExpression   
&emsp;&emsp;| arithmeticExpression **<>** arithmeticExpression   
&emsp;&emsp;| arithmeticExpression **>** arithmeticExpression   
&emsp;&emsp;| arithmeticExpression **>=** arithmeticExpression   
&emsp;&emsp;| arithmeticExpression **<** arithmeticExpression   
&emsp;&emsp;| arithmeticExpression **<=** arithmeticExpression   
&emsp;arithmeticExpression → arithmeticExpression **+** arithmeticTerm   
&emsp;&emsp;| arithmeticExpression **–** arithmeticTerm    
&emsp;&emsp;| arithmeticTerm   
&emsp;arithmeticTerm → arithmeticTerm ***** arithmeticFactor   
&emsp;&emsp;| arithmeticTerm **/** arithmeticFactor   
&emsp;&emsp;| arithmeticTerm **%** arithmeticFactor   
&emsp;&emsp;| arithmeticFactor   
&emsp;arithmeticFactor → **-** arithmeticFactor | primaryExpression  
&emsp;primaryExpression → **IntConst** | **Identifier** | ( arithmeticExpression )  

**2.** The parser needs to parse a program written in **Sunflower** defined above. The parser should be able to trace the parsing process by using the option “-p” to print each production reduced by the parser. The format for printing productions is as follows:  
&emsp;No syntax error recovery is needed. Each syntax error message should include the line number where the error is detected. The format of the error message is as follows:  
&emsp;Syntax error: line %d  

## Demo
**1.**  
**Input : test1.txt**
``` 
// A program to sum 1 to n 
Program sum Begin 
    Var    n 
    Var    s 
 
    Read n 
    If n < 0 Then 
        Write -1 
        Exit 
    Else 
        Set s = 0 
    EndIf 
    While n > 0 Do 
        Set s = s + n 
        Set n = n – 1 
    EndWhile 
    Write s 
End
```
**Output**
The stdout output of test1 using –p option is as follows:  
declarations -> empty  
declarations -> declarations Var Identifier   
declarations -> declarations Var Identifier   
statements -> empty   
statement -> Read Identifier   
statements -> statements statement      
primaryExpression -> Identifier   
arithmeticFactor -> primaryExpression   
arithmeticTerm -> arithmeticFactor    
arithmeticExpression -> arithmeticTerm     
primaryExpression -> IntConst      
arithmeticFactor -> primaryExpression    
arithmeticTerm -> arithmeticFactor    
arithmeticExpression -> arithmeticTerm      
relationExpression -> arithmeticExpression < arithmeticExpression     
booleanFactor -> relationExpression      
booleanTerm -> booleanFactor        
booleanExpression -> booleanTerm       
statements -> empty       
primaryExpression -> IntConst     
arithmeticFactor -> primaryExpression    
arithmeticFactor -> - arithmeticFactor    
arithmeticTerm -> arithmeticFactor     
arithmeticExpression -> arithmeticTerm      
statement -> Write arithmeticExpression     
statements -> statements statement     
statement -> Exit    
statements -> statements statement    
statements -> empty     
primaryExpression -> IntConst    
arithmeticFactor -> primaryExpression    
arithmeticTerm -> arithmeticFactor     
arithmeticExpression -> arithmeticTerm     
statement -> Set Identifier = arithmeticExpression    
statements -> statements statement     
statement -> If booleanExpression Then statements Else statements EndIf    
statements -> statements statement    
primaryExpression -> Identifier   
arithmeticFactor -> primaryExpression    
arithmeticTerm -> arithmeticFactor   
arithmeticExpression -> arithmeticTerm     
primaryExpression -> IntConst    
arithmeticFactor -> primaryExpression    
arithmeticTerm -> arithmeticFactor    
arithmeticExpression -> arithmeticTerm    
relationExpression -> arithmeticExpression > arithmeticExpression     
booleanFactor -> relationExpression    
booleanTerm -> booleanFactor    
booleanExpression -> booleanTerm    
statements -> empty    
primaryExpression -> Identifier    
arithmeticFactor -> primaryExpression    
arithmeticTerm -> arithmeticFactor   
arithmeticExpression -> arithmeticTerm    
primaryExpression -> Identifier    
arithmeticFactor -> primaryExpression     
arithmeticTerm -> arithmeticFactor     
arithmeticExpression -> arithmeticExpression + arithmeticTerm     
statement -> Set Identifier = arithmeticExpression     
statements -> statements statement     
primaryExpression -> Identifier     
arithmeticFactor -> primaryExpression    
arithmeticTerm -> arithmeticFactor    
arithmeticExpression -> arithmeticTerm     
primaryExpression -> IntConst     
arithmeticFactor -> primaryExpression    
arithmeticTerm -> arithmeticFactor     
arithmeticExpression -> arithmeticExpression - arithmeticTerm     
statement -> Set Identifier = arithmeticExpression    
statements -> statements statement     
statement -> While booleanExpression Do statements EndWhile    
statements -> statements statement      
primaryExpression -> Identifier      
arithmeticFactor -> primaryExpression     
arithmeticTerm -> arithmeticFactor    
arithmeticExpression -> arithmeticTerm      
statement -> Write arithmeticExpression     
statements -> statements statement     
program -> Program Identifier Begin declarations statements End    

**2.**  
**Input : test2.txt**  
```
// A program to sum 1 to n   
Program sum Begin 
End;  
``` 
**Output**  
The stdout output of test2 using –p option is as follows:   
Syntax error: line 2  

**3.**  
**Input : test3.txt**  
```
// A program to sum 1 to n   
Program sum Begin 
end 
``` 
**Output**  
The stdout output of test2 using –p option is as follows:   
Syntax error: line 3
