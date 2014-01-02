
(require-package 'clojure-mode)

(autoload 'clojure-mode "clojure-mode" "Major mode for editing Clojure code." t)

(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

(provide 'init-clojure-mode)
