
(add-to-load-path "base/popup")

(require 'popup)

(set-face-attribute 'popup-scroll-bar-background-face nil :background "#073642")
(set-face-attribute 'popup-scroll-bar-foreground-face nil :background "#073642" :box '(:line-width 1 :style none))

(provide 'init-popup)
