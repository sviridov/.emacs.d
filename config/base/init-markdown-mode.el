
(require-package 'markdown-mode)

(dolist (pattern '("\\.text\\'" "\\.markdown\\'" "\\.md\\'"))
  (add-to-list 'auto-mode-alist `(,pattern . markdown-mode)))

(provide 'init-markdown-mode)
