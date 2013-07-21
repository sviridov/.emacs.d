
(add-to-load-path "visual/solarized-emacs")

(add-to-list 'custom-theme-load-path (concat user-emacs-directory "visual/solarized-emacs"))

(add-to-list 'custom-safe-themes 'solarized-dark)

(load-theme 'solarized-dark t)

(copy-face 'mode-line 'mode-line-inactive)

(provide 'init-solarized-emacs)
