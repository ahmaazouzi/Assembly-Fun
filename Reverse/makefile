reverse:	reverse.o
	ld -melf_i386 -o reverse reverse.o

reverse.o:	reverse.s
	as -g --32 -o reverse.o reverse.s

clean:
	rm reverse.o reverse
