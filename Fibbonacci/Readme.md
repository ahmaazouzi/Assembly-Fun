# Zadanie 2

## Treść Zadania:
Należy obliczyć n-ty wyraz ciągu Fibonnaciego w konwencji BIG ENDIAN. Maksymalnie liczba ma się mieścić na 256 bajtach.

## Uruchomienie programu:
Aby uruchomic program, należy zbudować go, a nastepnie uruchomić otrzymany plik wykonywalny w gdb przy pomocy komendy
```bash
make && gdb ./fibbonacci
```
## Sprawdzenie wyniku
W gdb należy ustawić breakpoint na linię 130 poleceniem
```bash
break 130
```
Następnie program należy uruchomić wewnątrz gdb poleceniem
```bash
run
```
Aby wyświetlić wynik, należy skorzystać z polecenia
```bash
x /256bx & liczba
```
Gdzie "liczba"" to "numberA" dla parzystego wyrazu ciągu, a "numberB" dla nieparzystego

## Efekt działania programu:
Program poprawnie oblicza zadany element ciągu, przechowując go na 256-bajtowym buforze
