
(require-package 'multiple-cursors)

(global-set-key (kbd "S-SPC") 'set-rectangular-region-anchor)

(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-*") 'mc/mark-all-like-this)

(provide 'init-multiple-cursors)
