
(add-load-path "code/paredit")

(autoload 'enable-paredit-mode "paredit" nil t)

(add-hook 'emacs-lisp-mode-hook                  #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook                        #'enable-paredit-mode)
(add-hook 'lisp-mode-hook                        #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook            #'enable-paredit-mode)
(add-hook 'scheme-mode-hook                      #'enable-paredit-mode)

(eval-after-load "nrepl"
  '(add-hook 'nrepl-mode-hook #'enable-paredit-mode))

(eval-after-load "paredit"
 '(progn
    (require 'eldoc)

    (eldoc-add-command
      'paredit-backward-delete
      'paredit-close-round)

    (defun override-slime-repl-bindings-with-paredit ()
      (define-key slime-repl-mode-map
        (read-kbd-macro paredit-backward-delete-key) nil))

    (add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)
    (add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))

    (defun paredit-barf-all-the-way-backward ()
      (interactive)
      (paredit-split-sexp)
      (paredit-backward-down)
      (paredit-splice-sexp))

    (defun paredit-barf-all-the-way-forward ()
      (interactive)
      (paredit-split-sexp)
      (paredit-forward-down)
      (paredit-splice-sexp)
      (if (eolp) (delete-horizontal-space)))

    (defun paredit-slurp-all-the-way-backward ()
      (interactive)
      (catch 'done
        (while (not (bobp))
          (save-excursion
            (paredit-backward-up)
            (if (eq (char-before) ?\()
                (throw 'done t)))
          (paredit-backward-slurp-sexp))))

    (defun paredit-slurp-all-the-way-forward ()
      (interactive)
      (catch 'done
        (while (not (eobp))
          (save-excursion
            (paredit-forward-up)
            (if (eq (char-after) ?\))
                (throw 'done t)))
          (paredit-forward-slurp-sexp))))

    (nconc paredit-commands
           '("Extreme Barfage & Slurpage"
             (("C-M-)")
              paredit-slurp-all-the-way-forward
              ("(foo (bar |baz) quux zot)"
               "(foo (bar |baz quux zot))")
              ("(a b ((c| d)) e f)"
               "(a b ((c| d)) e f)"))
             (("C-M-}")
              paredit-barf-all-the-way-forward
              ("(foo (bar |baz quux) zot)"
               "(foo (bar|) baz quux zot)"))
             (("C-M-(")
              paredit-slurp-all-the-way-backward
              ("(foo bar (baz| quux) zot)"
               "((foo bar baz| quux) zot)")
              ("(a b ((c| d)) e f)"
               "(a b ((c| d)) e f)"))
             (("C-M-{")
              paredit-barf-all-the-way-backward
              ("(foo (bar baz |quux) zot)"
               "(foo bar baz (|quux) zot)"))))

    (paredit-define-keys)
    (paredit-annotate-mode-with-examples)
    (paredit-annotate-functions-with-examples)))

(provide 'init-paredit)
