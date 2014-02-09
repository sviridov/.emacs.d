
(require-package 'js2-refactor)

(eval-after-load "js2-mode"
 '(js2r-add-keybindings-with-prefix "C-c C-m"))

(provide 'init-js2-refactor)
