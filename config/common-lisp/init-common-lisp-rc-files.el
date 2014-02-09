
(dolist (pattern '("stumpwmrc"
                   "sbclrc"))
 (add-to-list 'auto-mode-alist `(,pattern . lisp-mode)))

(provide 'init-common-lisp-rc-files)
