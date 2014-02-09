
(require-package 'coffee-mode)

(--each '("\\.coffee\\'"
          "Cakefile\\'"
          "coffee")
 (add-to-list 'auto-mode-alist `(,it . coffee-mode)))

(setq coffee-tab-width 2)

(provide 'init-coffee-mode)
