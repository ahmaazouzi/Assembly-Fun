hello_world:	hello_world.o
	ld -melf_i386 -o hello_world hello_world.o

hello_world.o:	hello_world.s
	as --32 -o hello_world.o hello_world.s

clean:
	rm hello_world.o hello_world
