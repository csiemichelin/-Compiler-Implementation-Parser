CC:=gcc
obj_flex = Sunflower.l
obj_bison = Sunflower.y

all: $(obj)
	bison $(obj_bison) -d 
	flex $(obj_flex) 
	$(CC) lex.yy.c Sunflower.tab.c -lfl -o parser 

clean:
	rm parser lex.yy.c Sunflower.tab.c Sunflower.tab.h 
