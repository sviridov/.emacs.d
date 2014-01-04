
(require-package 'browse-kill-ring)
(require-package 'kill-ring-search)

(autoload 'browse-kill-ring "browse-kill-ring" nil t)
(autoload 'kill-ring-search "kill-ring-search" nil t)

(global-set-key (kbd "M-Y"  ) 'browse-kill-ring)
(global-set-key (kbd "M-C-y") 'kill-ring-search)

(provide 'init-kill-ring)
