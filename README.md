<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>

<p align="center">
<b>Звіт з лабораторної роботи 2</b><br/>
"Рекурсія"<br/>
дисципліни "Вступ до функціонального програмування"
</p>

<p align="right"><b>Студент</b>: Гармаш Дмитро Олегович КВ-13</p>
<p align="right"><b>Рік</b>: 2024</p>

## Загальне завдання

Реалізуйте дві рекурсивні функції, що виконують деякі дії з вхідним(и) списком(-ами), за
можливості/необхідності використовуючи різні види рекурсії. Функції, які необхідно
реалізувати, задаються варіантом (п. 2.1.1). Вимоги до функцій:

1. Зміна списку згідно із завданням має відбуватись за рахунок конструювання нового
   списку, а не зміни наявного (вхідного).
2. Не допускається використання функцій вищого порядку чи стандартних функцій
   для роботи зі списками, що не наведені в четвертому розділі навчального
   посібника.
3. Реалізована функція не має бути функцією вищого порядку, тобто приймати функції
   в якості аргументів.
4. Не допускається використання псевдофункцій (деструктивного підходу).
5. Не допускається використання циклів.
   Кожна реалізована функція має бути протестована для різних тестових наборів. Тести
   мають бути оформленні у вигляді модульних тестів

## Варіант 3

1. Написати функцію group-pairs, яка групує послідовні пари елементів у списки:

```lisp
CL-USER> (group-pairs '(a b c d e f g))
((A B) (C D) (E F) (G))
```

2. Написати функцію list-set-union, яка визначає об'єднання двох множин,
заданих списками атомів:

```lisp
CL-USER> (list-set-union '(1 2 3) '(2 3 4))
(1 2 3 4) ; порядок може відрізнятись
```

## Лістинг функції group-pairs

```lisp
(defun group-pairs (lst)
  (cond
    ((second lst)
     (cons (list (first lst) (second lst)) (group-pairs (cddr lst))))
    ((first lst)
     (cons (list (first lst)) nil))))
```

### Тестові набори

```lisp
(defun test-group-pairs ()
  (check-group-pairs "test 1" '(a b c d e f) '((A B) (C D) (E F)))
  (check-group-pairs "test 2" '(a b c) '((A B) (C)))
  (check-group-pairs "test 3" nil nil))
```

### Тестування

```lisp
passed... test 1
passed... test 2
passed... test 3
```

## Лістинг функції list-set-union

```lisp
(defun contains (keys value)
  (cond 
    ((null keys) nil)
    ((equalp (first keys) value) t)
    (t (contains (cdr keys) value))))

(defun generate-keys (first-lst second-lst keys)
  (if (and (null first-lst) (null second-lst))
      keys
      (generate-keys (cdr first-lst) (cdr second-lst) (append-if-not-key (first second-lst) (append-if-not-key (first first-lst) keys)))))

(defun append-if-not-key (value keys) 
  (if (contains keys value) keys (if (null value) keys (cons value keys))))

(defun list-set-union (first-lst second-lst)
  (generate-keys first-lst second-lst '()))
```

### Тестові набори

```lisp
(defun test-list-set-union ()
  (check-list-set-union "test 1" '(1 2 3) '(2 3 4) '(1 2 3 4))
  (check-list-set-union "test 2" '(a b) '(b c) '(a b c))
  (check-list-set-union "test 3" nil nil nil))
```

### Тестування

```lisp
passed... test 1
passed... test 2
passed... test 3
```
