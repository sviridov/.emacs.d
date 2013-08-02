
(add-load-path "web/closure-template-html-mode")

(autoload 'closure-template-html-mode "closure-template-html-mode"
  "Major mode for editing Closure Template code." t)

(add-to-list 'auto-mode-alist '("\\.tmpl$" . closure-template-html-mode))

(provide 'init-closure-template-html-mode)
