
(add-load-path "web/haml-mode")

(autoload 'haml-mode "haml-mode" nil t)

(add-to-list 'auto-mode-alist '("\\.haml\\'" . haml-mode))

(provide 'init-haml-mode)
