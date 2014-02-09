
(require-package 'rhtml-mode)

(autoload 'rhtml-mode "rhtml-mode" nil t)

(add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))
(add-to-list 'auto-mode-alist '("\\.rjs\\'" . rhtml-mode))

(provide 'init-rhtml)
