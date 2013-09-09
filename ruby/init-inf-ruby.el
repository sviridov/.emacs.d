
(add-load-path "ruby/inf-ruby")

(autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
(autoload 'inf-ruby-setup-keybindings "inf-ruby" "Keybindings for interacting with inferior Ruby process" t)

(eval-after-load 'inf-ruby
 '(inf-ruby-switch-setup))

(eval-after-load 'ruby-mode
 `(progn
    (require 'inf-ruby)
    (add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)
    (add-hook 'ruby-mode-hook 'inf-ruby-setup-keybindings)))

(provide 'init-inf-ruby)
