
(add-load-path "javascript/js2-mode")

(autoload 'js2-mode "js2-mode" "Major mode for editing JavaScript code." t)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(provide 'init-js2-mode)
