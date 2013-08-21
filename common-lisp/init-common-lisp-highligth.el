
(defmacro define-common-lisp-symbols-highlighter (name selector)
 `(defun ,name (limit)
    (loop

     (unless (re-search-forward "[^() \"\t\n',@]+" limit t)
       (return nil))

     (let ((begin (match-beginning 0))
           (end   (match-end 0)))
      (when (funcall (lambda (symbol-string)
                       (set-text-properties 0 (length symbol-string) nil symbol-string)
                       (destructuring-bind (ignore result)
                           (slime-eval `(swank:eval-and-grab-output ,,selector))
                         (not (string-equal result "NIL"))))
                     (buffer-substring (match-beginning 0) (match-end 0)))
        (set-match-data (list begin end))
        (return t))))))

(define-common-lisp-symbols-highlighter highlight-common-lisp-macro
  (concatenate 'string "(macro-function '" symbol-string ")"))

(eval-after-load "slime"
 `(font-lock-add-keywords 'lisp-mode
    '((highlight-common-lisp-macro . 'font-lock-keyword-face))
    t))

(provide 'init-common-lisp-highligth)
