# Implementation of a Parser
## 目錄
 - [環境設置與使用方法](#環境設置與使用方法)
 - [介紹](#介紹)
 - [Demo](#Demo)  
## 環境設置與使用方法
**1. 環境設置**  
**2. 使用方法**  
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
