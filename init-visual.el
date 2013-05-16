
(add-to-load-path "visual")

(require 'init-bars)
(require 'init-color-theme)
(require 'init-powerline)
(require 'init-popup)
(require 'init-font)
(require 'init-fullscreen)
(require 'init-highlight)

(setq-default inhibit-startup-buffer-menu nil
              inhibit-startup-screen        t
              initial-buffer-choice       nil
              initial-scratch-message     nil)

(setq scroll-step 1)

(provide 'init-visual)
