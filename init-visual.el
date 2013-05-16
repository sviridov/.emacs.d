
(add-to-load-path "visual")

(require 'init-bars)
(require 'init-color-theme)
(require 'init-powerline)
(require 'init-popup)
(require 'init-font)
(require 'init-fullscreen)

(setq-default inhibit-startup-buffer-menu nil
              inhibit-startup-screen        t
              initial-buffer-choice       nil
              initial-scratch-message     nil)

(global-hl-line-mode 1)

(show-paren-mode 1)

(setq scroll-step 1)

(setq-default show-trailing-whitespace t)

(provide 'init-visual)
