
(require-package 'gap-mode)

(setq gap-executable "gap")

(add-to-list 'auto-mode-alist '("\\.gap\\'" . gap-mode))

(provide 'init-gap-mode)
