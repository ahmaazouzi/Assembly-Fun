repeattext:	repeattext.o
	ld -melf_i386 -o repeattext repeattext.o

repeattext.o:	repeattext.s
	as --32 -o repeattext.o repeattext.s

clean:
	rm repeattext.o repeattext
