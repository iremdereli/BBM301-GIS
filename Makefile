irce:	y.tab.c lex.yy.c
	gcc -o parser y.tab.c

y.tab.c: irce.y lex.yy.c
	yacc irce.y

lex.yy.c: irce.l
	lex irce.l

clean:	rm -f lex.yy.c y.tab.c irce