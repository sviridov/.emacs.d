
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

(setq display-time-day-and-date t
      display-time-24hr-format  t)

(display-time)

(column-number-mode 1)

(setq scroll-step 1)

(require 'init-color-theme)
(require 'init-powerline)
(require 'init-popup)
(require 'init-font)

(unless (fboundp 'toggle-fullscreen)
  (defun toggle-fullscreen ()
    (interactive)
    (when (eq window-system 'x)
      (set-frame-parameter
       nil 'fullscreen
       (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))))

(global-set-key [f11] 'toggle-fullscreen)

(setq-default show-trailing-whitespace t)

(provide 'init-visual)
