
(add-load-path "gap/gap-mode")

(autoload 'gap-mode "gap-mode" "Gap editing mode" t)
(autoload 'gap "gap-process" "Run GAP in emacs buffer" t)

(setq gap-executable "gap")

(add-to-list 'auto-mode-alist '("\\.gap\\'" . gap-mode))

(provide 'init-gap-mode)
