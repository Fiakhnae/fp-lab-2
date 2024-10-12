(defun group-pairs (lst)
  (cond
    ((second lst)
      (cons (list (first lst) (second lst)) (group-pairs (cddr lst))))
    ((first lst)
      (cons (list (first lst)) nil))
  ))

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


(defun check-group-pairs (name input expected)
  "Checks the `group-pairs` function on the given input and expected result."
  (format t "~:[FAILED~;passed~]... ~a~%"
          (equal (group-pairs input) expected)
          name))

(defun test-group-pairs ()
  (check-group-pairs "test 1" '(a b c d e f) '((A B) (C D) (E F)))
  (check-group-pairs "test 2" '(a b c) '((A B) (C)))
  (check-group-pairs "test 3" nil nil))


(defun check-list-set-union (name first-lst second-lst expected)
  "Tests the `list-set-union` function on two lists and the expected result."
  (let ((result (list-set-union first-lst second-lst)))
    (format t "~:[FAILED~;passed~]... ~a~%"
            (and (every #'(lambda (x) (member x expected)) result)
                 (every #'(lambda (x) (member x result)) expected))
            name)))

(defun test-list-set-union ()
  (check-list-set-union "test 1" '(1 2 3) '(2 3 4) '(1 2 3 4))
  (check-list-set-union "test 2" '(a b) '(b c) '(a b c))
  (check-list-set-union "test 3" nil nil nil))

(test-group-pairs)
(test-list-set-union)