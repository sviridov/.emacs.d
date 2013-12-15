
(add-load-path "base/phi-search")

(autoload 'phi-search "phi-search" nil t)

(global-set-key (kbd "C-s") 'phi-search)

(provide 'init-phi-search)
