
(require-package 'rubocop)

(eval-after-load "ruby-mode"
 '(add-hook 'ruby-mode-hook 'rubocop-mode))

(provide 'init-rubocop)
