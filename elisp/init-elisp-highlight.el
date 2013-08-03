
(defmacro define-emacs-lisp-symbols-highlighter (name selector)
 `(defun ,name (limit)
    (loop

     (unless (re-search-forward "[^() \"\t\n',@]+" limit t)
       (return nil))

     (when (funcall (lambda (symbol) ,selector) (intern-soft (buffer-substring (match-beginning 0) (match-end 0))))
       (set-match-data (list (match-beginning 0) (match-end 0)))
       (return t)))))

(define-emacs-lisp-symbols-highlighter highlight-emacs-lisp-macro
  (eq 'macro (car-safe (symbol-function symbol))))

(define-emacs-lisp-symbols-highlighter highlight-emacs-lisp-function
  (eq 'lambda (car-safe (symbol-function symbol))))

(define-emacs-lisp-symbols-highlighter highlight-emacs-lisp-compiled-or-primitive-function
  (or (subrp (symbol-function symbol))
      (eq 'compiled-function (type-of (symbol-function symbol)))))

;(define-emacs-lisp-symbols-highlighter highlight-emacs-lisp-global-variable
;  (and (boundp symbol)
;       (not (or (eq symbol t)
;                (eq symbol nil)
;                ))))

(dolist (mode '(emacs-lisp-mode inferior-emacs-lisp-mode))
  (font-lock-add-keywords mode
    '((highlight-emacs-lisp-macro . 'font-lock-keyword-face)
      (highlight-emacs-lisp-function . 'font-lock-function-name-face)
      (highlight-emacs-lisp-compiled-or-primitive-function . 'font-lock-builtin-face)
  ;   (highlight-emacs-lisp-global-variable . 'font-lock-variable-name-face)
      )))

(provide 'init-elisp-highlight)
