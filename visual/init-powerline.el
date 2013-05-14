
(add-to-load-path "visual/powerline")

(require 'powerline)

(set-face-attribute 'mode-line nil :background "Gray10" :foreground "White" :box nil :width 'condensed :family "neep")
(set-face-attribute 'mode-line-inactive nil :background "Gray10" :foreground "White" :box nil :width 'condensed :family "neep")

(setq powerline-arrow-shape 'arrow14
      powerline-color2 "Gray10")

(defpowerline gmls (apply 'concat (mapcar #'eval global-mode-string)))

(defpowerline row     "%l")
(defpowerline column  "%c")
(defpowerline percent "%p")

(defpowerline buffer-id (propertize (car (propertized-buffer-identification "%b"))
                                    'face (powerline-make-face color1)))

(setq-default mode-line-format
              (list "%e"
                    '(:eval (concat
                             (powerline-make-text   "   " nil)
                             (powerline-rmw         'left nil)
                             (powerline-buffer-id   'left nil powerline-color1)
                             (powerline-row         'left powerline-color1)
                             (powerline-make-text   " :"  powerline-color1)
                             (powerline-column      'left powerline-color1)
                             (powerline-percent     'left powerline-color1 powerline-color2)
                             (powerline-major-mode  'left powerline-color2)
                             (powerline-minor-modes 'left powerline-color2)
                             (powerline-narrow      'left powerline-color2  powerline-color1)
                             (powerline-gmls        'left powerline-color1  powerline-color2)
                             (powerline-vc          'left powerline-color2)))))

(provide 'init-powerline)
