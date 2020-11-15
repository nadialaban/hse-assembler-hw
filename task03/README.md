## Курс "Архитектура вычислительных систем", ДЗ 3
Абу Аль Лабан Надя, БПИ 198

### Задание
1. Выбрать модель приложения, наиболее точно отвечающую
специфике задачи или применить указанную. Изучить используемую
модельпо дополнительным источники информации.
2. Разработать алгоритм решения задания, с учетом разделения
вычислений между несколькими потоками. Избегать ситуаций
неуправляемого изменения одних и тех же общих данных несколькими
потоками. Если же избежать этого невозможно, необходимо использовать
мьютексы и критические секции.
3. Разработать программу с применением функций библиотеки POSIX
Threads или стандартной библиотеки C++ и протестировать ее на
нескольких примерах.
#### Вариант 1
Вычислить векторное произведение квадратных матриц А и B.
Входные данные: произвольные квадратные матрицы А и В одинаковой
размерности. Размер матриц задается входным параметром. Количество
потоков является входным параметром, при этом размерность матриц может
быть не кратна количеству потоков.