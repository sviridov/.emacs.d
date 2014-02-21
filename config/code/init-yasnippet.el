
(require-package 'yasnippet)

(eval-after-load "yasnippet"
 '(setq yas-prompt-functions '(yas-ido-prompt)
        yas-snippet-dirs (list (in-user-emacs-directory "config/code/snippets"))))

(--each '("c-mode"
          "c++-mode"
          "rhtml-mode"
          "ruby-mode"
          "slime-repl-mode")
  (eval-after-load it
    (add-hook (intern (concat it "-hook"))
              (lambda () (yas-global-mode 1)))))

(add-hook 'after-init-hook
  (lambda ()
    (add-hook 'lisp-mode-hook
      (lambda () (yas-global-mode 1)))))

(provide 'init-yasnippet)
