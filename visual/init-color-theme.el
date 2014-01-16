
(require-package 'spacegray-theme)

(load-theme 'spacegray t)

(eval-after-load "popup"
 '(progn
    (set-face-attribute 'popup-face     nil :foreground "#ffffff" :background "#1c1f26")
    (set-face-attribute 'popup-tip-face nil :foreground "#ffffff" :background "#1c1f26")
    (set-face-attribute 'popup-scroll-bar-background-face nil     :background "#1c1f26")
    (set-face-attribute 'popup-scroll-bar-foreground-face nil     :background "#343d46")))

(provide 'init-color-theme)
