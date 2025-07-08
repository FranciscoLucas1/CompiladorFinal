all: compilador.l compilador.y
	flex compilador.l
	bison -d compilador.y
	gcc compilador.tab.c lex.yy.c -o compilador -lm
	./compilador

clean:
	rm -f compilador lex.yy.c compilador.tab.c compilador.tab.h	