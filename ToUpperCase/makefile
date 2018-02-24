touppercase:	touppercase.o
	ld -melf_i386 -o touppercase touppercase.o

touppercase.o:	touppercase.s
	as --32 -o touppercase.o touppercase.s

clean:
	rm touppercase.o touppercase
