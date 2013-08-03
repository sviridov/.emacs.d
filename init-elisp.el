
(add-load-path "elisp")

(defun eval-and-replace ()
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(global-set-key (kbd "C-c C-e") 'eval-and-replace)

(eval-after-load "ielm"
  '(define-key ielm-map (kbd "C-c C-e")
     'eval-and-replace))

(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(add-hook 'ielm-mode-hook 'eldoc-mode)

(require 'init-elisp-slime-nav)
(require 'init-elisp-highlight)
(require 'init-litable)

(provide 'init-elisp)
