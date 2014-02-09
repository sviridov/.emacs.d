
(require-package 'markdown-mode)

(--each '("\\.text\\'" "\\.markdown\\'" "\\.md\\'")
  (add-to-list 'auto-mode-alist `(,it . markdown-mode)))

(provide 'init-markdown-mode)
