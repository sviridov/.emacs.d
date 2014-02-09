
(require-package 'expand-region)

(autoload 'er/expand-region "expand-region" nil t)

(global-set-key (kbd "C-=") 'er/expand-region)

(provide 'init-expand-region)
