
(defun prepare-common-lisp-slime ()
  (interactive)

  (load "~/quicklisp/slime-helper.el")

  (require 'slime)

  (slime-setup '(slime-repl slime-fancy slime-fuzzy slime-fancy-inspector slime-indentation))

  (setq slime-complete-symbol*-fancy t
	common-lisp-hyperspec-root (concat "file:///home/"
                                           (user-login-name)
                                           "/.emacs.d/common-lisp/HyperSpec/"))

  (defun slime-complete-symbol ()
    (interactive)
    (slime-fuzzy-complete-symbol))

  (define-key slime-mode-map (kbd "TAB")
    'slime-indent-and-complete-symbol)

  (define-key slime-repl-mode-map (kbd "TAB")
    'slime-indent-and-complete-symbol)

 ; (slime-define-keys slime-repl-mode-map
 ;   ("\C-m"   nil)
 ;   ([return] nil))

  (global-set-key [f12] 'slime-selector)

  (add-to-list 'load-path "~/.emacs.d/common-lisp/ido-ql-quickload/")

  (require 'ido-ql-quickload)

  (setf ido-ql-quickload-save-file "~/.emacs.d/.quickload")

  (ido-ql-quickload-initialize)

;  (define-key slime-repl-mode-map (kbd "C-c C-e")
;    'slime-eval-and-replace)

;  (define-key slime-mode-map (kbd "C-c C-e")
;    'slime-eval-and-replace)
  )

(defmacro defslime-start (name lisp)
 `(defun ,name ()
    (interactive)
    (prepare-common-lisp-slime)
    (slime ,lisp)))

(setq inferior-lisp-program "sbcl")

(defslime-start sbcl "sbcl")
(defslime-start ccl "ccl")

(defun slime-remote ()
  (interactive)
  (slime-connect "127.0.0.1" 4005))

(provide 'init-common-lisp-slime)
