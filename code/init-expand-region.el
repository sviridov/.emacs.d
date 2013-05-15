
(add-to-load-path "code/expand-region")

(require 'expand-region)

(global-set-key (kbd "C-=") 'er/expand-region)

(provide 'init-expand-region)
