
(require-package 'fancy-narrow)

(global-set-key (kbd "C-x n n") #'fancy-narrow-to-region)
(global-set-key (kbd "C-x n w") #'fancy-widen)

(provide 'init-fancy-narrow)
