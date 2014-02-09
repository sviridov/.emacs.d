
(require-package 'elisp-slime-nav)

(add-hook 'emacs-lisp-mode-hook #'elisp-slime-nav-mode)
(add-hook 'ielm-mode-hook #'elisp-slime-nav-mode)

(provide 'init-elisp-slime-nav)
