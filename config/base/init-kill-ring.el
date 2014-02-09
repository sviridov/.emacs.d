
(require-package 'browse-kill-ring)
(require-package 'kill-ring-search)

(global-set-key (kbd "M-Y"  ) 'browse-kill-ring)
(global-set-key (kbd "M-C-y") 'kill-ring-search)

(provide 'init-kill-ring)
