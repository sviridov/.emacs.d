
(require-package 'clj-refactor)

(add-hook 'clojure-mode-hook
  (lambda ()
    (clj-refactor-mode 1)
    (cljr-add-keybindings-with-prefix "C-c r")))

(provide 'init-clj-refactor)
