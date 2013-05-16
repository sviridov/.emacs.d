
(add-to-load-path "visual")

(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(setq-default inhibit-startup-buffer-menu nil
              inhibit-startup-screen        t
              initial-buffer-choice       nil
              initial-scratch-message     nil)

(global-hl-line-mode 1)

(show-paren-mode 1)

(setq scroll-step 1)

(require 'init-color-theme)
(require 'init-powerline)
(require 'init-popup)
(require 'init-font)
(require 'init-fullscreen)

(setq-default show-trailing-whitespace t)

(provide 'init-visual)
