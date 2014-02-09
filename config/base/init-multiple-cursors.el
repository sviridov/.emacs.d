
(require-package 'multiple-cursors)

(dolist (function '(set-rectangular-region-anchor
                    mc/mark-previous-like-this
                    mc/mark-next-like-this
                    mc/mark-all-like-this))
  (autoload function "multiple-cursors" nil t))

(global-set-key (kbd "S-SPC") 'set-rectangular-region-anchor)

(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-*") 'mc/mark-all-like-this)

(provide 'init-multiple-cursors)
