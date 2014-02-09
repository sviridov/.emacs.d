
(--each '("stumpwmrc"
          "sbclrc")
 (add-to-list 'auto-mode-alist `(,it . lisp-mode)))

(provide 'init-common-lisp-rc-files)
