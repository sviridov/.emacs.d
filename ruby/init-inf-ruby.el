
(require-package 'inf-ruby)

(autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
(autoload 'inf-ruby-console-auto "inf-ruby" "Run an inferior project-specific Ruby process" t)

(eval-after-load 'inf-ruby
 '(inf-ruby-switch-setup))

(eval-after-load 'ruby-mode
 `(progn
    (require 'inf-ruby)
    (add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)))

(provide 'init-inf-ruby)
