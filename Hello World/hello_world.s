.data
STDOUT = 1
SYSWRITE = 1
SYSEXIT = 60
EXIT_SUCCESS = 0
tekst: .ascii "Hello World\n"
tekst_len = .-tekst

.text
.globl _start

_start:
# Wywołanie SYSWRITE
  # Definicja metody
  movq $SYSWRITE, %rax
  # Definicja parametru 1: opcja OUT
  movq $STDOUT, %rdi
  # Definicja parametru 2: wartość tesktowa
  movq $tekst, %rsi
  # Definicja parametru 3: długość parametru 2
  movq $tekst_len, %rdx
  # Wykonanie metody
  syscall

# Wywołanie EXIT
mov $SYSEXIT, %rax
mov $EXIT_SUCCESS, %rdi
syscall
