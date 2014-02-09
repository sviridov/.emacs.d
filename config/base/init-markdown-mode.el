
(require-package 'markdown-mode)

(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)

(dolist (pattern '("\\.text\\'" "\\.markdown\\'" "\\.md\\'"))
  (add-to-list 'auto-mode-alist `(,pattern . markdown-mode)))

(provide 'init-markdown-mode)
