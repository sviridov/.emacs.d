
(require-package 'spacegray-theme)

(load-theme 'spacegray t)

(eval-after-load "company"
 '(progn
    (set-face-attribute 'company-tooltip           nil :foreground "#ffffff" :background "#1c1f26")
    (set-face-attribute 'company-tooltip-selection nil :foreground "#ffffff" :background "#343d46")
    (set-face-attribute 'company-scrollbar-bg nil :background "#1c1f26")
    (set-face-attribute 'company-scrollbar-fg nil :background "#343d46")))

(provide 'init-color-theme)
