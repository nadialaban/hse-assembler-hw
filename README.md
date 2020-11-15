## Курс "Архитектура вычислительных систем"
Абу Аль Лабан Надя, БПИ 198

### Домашнее задание 1. Примеры программ на FASM
Найти в различных источниках информации не менее пяти примеров консольных программ разной сложности, написанных на изучаемом Ассемблере.
Скомпилировать и запустить их с различными тестовыми наборами данных.
Предоставить отчет о проделанной работе.
- Программа 1. Калькулятор
- Программа 2. Вывод текста из файла в консоль
- Программа 3. Приветствие
- Программа 4. Массив случайных чисел
- Программа 5. Логические операции

### Домашнее задание 2. Работа с массивами
В соответствии с вариантом задания разработать программу, осуществляющую обработку одномерных массивов. При создании программы использовать подпрограммы для отдельных подзадач (ввода, вывода массивов, обработки данных).
#### Вариант 1   
Массив В из положительных элементов А

### Микропроект 1. Индивидуальное задание.
Необходимо разработать программу и отладить в соответвии с выданным заданием. Результаты работы оформляются в виде пояснительной записки.
#### Вариант   
Программа вычисления даты православной Пасхалии

### Домашнее задание 3. Парадигмы параллельного программирования.
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
