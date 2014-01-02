
(require-package 'smart-forward)

(dolist (function '(smart-up
                    smart-down
                    smart-backward
                    smart-forward))
  (autoload function "smart-forward" nil t))

(global-set-key (kbd "M-<up>") 'smart-up)
(global-set-key (kbd "M-<down>") 'smart-down)
(global-set-key (kbd "M-<left>") 'smart-backward)
(global-set-key (kbd "M-<right>") 'smart-forward)

(provide 'init-smart-forward)
