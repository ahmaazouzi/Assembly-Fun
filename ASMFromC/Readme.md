# Zadanie 3

## Treść Zadania:
Wywołać z C++ funkcję w języku assemblera, która zwróci ilość ticków procesora (własna wersja funkcji cpuid, nazwana w kodzie my_cpuid). Do funkcji przekazywany jest parametr typu int, który:
	0 -> Wywołaj 10 razy polecenie rtdsc, wykorzystując do iteracji zmienną lokalną
	1 -> Wywołaj raz cpuid, a następnie zwróć wartość rtdsc
	else -> Zwróć wartość rtdsc

## Uruchomienie programu:
Aby uruchomic program, należy zbudować go, a nastepnie uruchomić otrzymany plik wykonywalny w gdb przy pomocy komendy
```bash
make && ./countTicks
```

## Efekt działania programu:
Program znajduje ilość ticków procesora, jakie mijają w czasie inicjalizacji zmiennej int x = 0; w kodzie C++
