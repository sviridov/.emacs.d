
(add-to-list 'load-path "~/.emacs.d/common-lisp")

(add-to-list 'auto-mode-alist '("stumpwmrc" . lisp-mode))

(require 'init-common-lisp-slime)

(provide 'init-common-lisp)
