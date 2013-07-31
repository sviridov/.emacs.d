
(add-to-load-path "visual/solarized-emacs")

(add-to-list 'custom-theme-load-path (concat user-emacs-directory "visual/solarized-emacs"))

(add-to-list 'custom-safe-themes 'solarized-dark)

(load-theme 'solarized-dark t)

(set-face-attribute 'mode-line-inactive nil :box '(:line-width 1 :color "#93a1a1"))

(copy-face 'mode-line 'mode-line-inactive)

(provide 'init-solarized-emacs)
