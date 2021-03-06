
(require-package 'slime)

(eval-after-load "slime"
 '(progn
    (slime-setup '(slime-repl slime-fancy slime-fuzzy slime-company
                   slime-fancy-inspector slime-indentation))

    (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol
          common-lisp-hyperspec-root (concat "/home/" (user-login-name) "/.emacs.d/common-lisp/HyperSpec/"))

    (define-key slime-mode-map (kbd "TAB")
      'slime-indent-and-complete-symbol)

    (global-set-key [f12] 'slime-selector)))

(defmacro defslime-start (name lisp)
 `(defun ,name ()
    (interactive)
    (slime ,lisp)))

(setq inferior-lisp-program "sbcl")

(defslime-start sbcl "sbcl")
(defslime-start ccl "ccl")

(defun slime-remote ()
  (interactive)
  (slime-connect "127.0.0.1" 4005))

(provide 'init-common-lisp-slime)
