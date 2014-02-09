
(require-package 'inf-ruby)

(eval-after-load 'inf-ruby
 '(inf-ruby-switch-setup))

(eval-after-load 'ruby-mode
 `(add-hook 'ruby-mode-hook 'inf-ruby-minor-mode))

(provide 'init-inf-ruby)
