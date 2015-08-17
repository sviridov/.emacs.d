
(add-config-load-path "javascript")

(add-hook 'js-mode-hook (lambda () (setq js-indent-level 2)))

(require 'init-js2-mode)
(require 'init-js2-refactor)
(require 'init-skewer-mode)

(provide 'init-javascript)
