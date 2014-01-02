
(require-package 'scss-mode)

(setq css-indent-offset 2)

(autoload 'scss-mode "scss-mode" "Major mode for SCSS writing" t)

(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

(provide 'init-css)
