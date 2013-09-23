
(add-load-path "coffeescript/coffee-mode")

(autoload 'coffee-mode "coffee-mode" "Major CoffeeScript mode" t)
(autoload 'coffee-repl "coffee-mode" "Major CoffeeScript REPL mode" t)

(setq coffee-tab-width 2)

(add-to-list 'auto-mode-alist '("\\.coffee\\'" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile\\'" . coffee-mode))
(add-to-list 'interpreter-mode-alist '("coffee" . coffee-mode))

(provide 'init-coffee-mode)
