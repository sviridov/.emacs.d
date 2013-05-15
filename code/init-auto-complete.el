
(add-to-load-path "code/auto-complete")

(require 'auto-complete)
(require 'auto-complete-config)
;  (require 'ac-slime)

(global-auto-complete-mode t)

(setq ac-auto-start  t
      ac-dictionary-directories (list (concat user-emacs-directory "code/auto-complete/dict"))
      ac-comphist-file          (concat user-emacs-directory ".comphist.dat"))

(ac-config-default)

;(eval-after-load "auto-complete"
;  '(progn
;     (add-hook 'slime-repl-mode-hook (lambda () (set-up-slime-ac t)))
;     (add-hook 'slime-mode-hook      (lambda () (set-up-slime-ac t)))
;     (add-hook 'slime-mode-hook      'auto-complete-mode)))
;
;  (add-to-list 'ac-modes 'slime-repl-mode)
;
;  (defun complete-or-newline (&optional arg)
;    (interactive "*P")
;    (case major-mode
;      (slime-repl-mode (slime-repl-return))
;      (t (newline-and-indent))))
;
;  (define-key ac-mode-map (kbd "RET") 'complete-or-newline))

(provide 'init-auto-complete)
