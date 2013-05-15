
(add-to-load-path "visual/popup")

(require 'popup)

(set-face-attribute 'popup-face     nil :background "Gray10" :foreground "White" )
(set-face-attribute 'popup-tip-face nil :background "Gray10" :foreground "White" )
(set-face-attribute 'popup-scroll-bar-background-face nil :background "Gray10"   )
(set-face-attribute 'popup-scroll-bar-foreground-face nil :background "SteelBlue")

(provide 'init-popup)
