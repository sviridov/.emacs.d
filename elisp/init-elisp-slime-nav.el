
(add-load-path "elisp/elisp-slime-nav")

(autoload 'elisp-slime-nav-mode "elisp-slime-nav" nil t)

(add-hook 'emacs-lisp-mode-hook #'elisp-slime-nav-mode)
(add-hook 'ielm-mode-hook #'elisp-slime-nav-mode)

(provide 'init-elisp-slime-nav)
