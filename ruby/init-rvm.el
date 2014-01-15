
(require-package 'rvm)

(eval-after-load "ruby-mode"
 '(progn
    (require 'rvm)
    (rvm-use-default)))

(provide 'init-rvm)
