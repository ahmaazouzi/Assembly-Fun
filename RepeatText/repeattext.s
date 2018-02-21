.data
  # Kody wywołań systemowych
  SYS_EXIT = 1
  SYS_WRITE = 4
  SYS_READ = 3
  # Kody wejścia / wyjścia
  STDIN = 0
  STDOUT = 1
  # Kod wyjścia
  EXIT_SUCCES = 0
  # Rozmiar bufora przechowującego wpisany tekst
  bufferSize = 2048
  # Zmienna przechowująca długość wpisanego tekstu
  textSize: .int

# Deklaracja zmiennej general-purpose
# Będzie ona przechowywała input użytkownika
.bss
  .comm input, bufferSize

.text
  .globl _start

# Funkcja startowa, wywołuje skok do polecania _read_word
_start:
  jmp _read_word

# Metoda wczytująca słowo od użytkownika
# Po wczytaniu, wartość tekstowa umieszczona zostaje w buforze input
# A ilość wczytanych znaków w rejestrze RAX
# SYSREAD(wejście, miejsce przechowania tekstu, romiar miejsca przechowującego)
_read_word:
  # Kod metody SYSREAD
  movl $SYS_READ, %eax
  # Kod wejścia STD IN
  movl $STDIN, %ebx
  # Określenie bufora wejściowego
  movl $input, %ecx
  # Określenie rozmiaru bufora wejścia
  movl $bufferSize, %edx
  # Przerwanie
  int $0x80

# Metoda przenosi długość wczytanego słowa z rejestru RAX
# Do zmiennej zadeklarowanej wcześniej
_store_input_length:
  # Przeniesienie z rejestru do zmiennej
  movl %eax, textSize

# Metoda wypisuje wczytane słowo na ekran
# SYSWRITE(wyjście, tekst, długość tekstu)
_print_word:
  # Kod metody SYSRWRITE
  movl $SYS_WRITE, %eax
  # Kod wyjścia STD OUT
  movl $STDOUT, %ebx
  # Bufor zawierający wczytany tekst
  movl $input, %ecx
  # Długość tekstu
  movl $textSize, %edx
  int $0x80

# Finish
_end:
  movl $SYS_EXIT, %eax
  movl $EXIT_SUCCES, %ebx
  int $0x80
