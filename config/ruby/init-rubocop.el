
(require-package 'rubocop)

(eval-after-load "ruby-mode"
 '(progn
    (require 'rubocop)
    (add-hook 'ruby-mode-hook 'rubocop-mode)))

(provide 'init-rubocop)
