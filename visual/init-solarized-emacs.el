
(add-to-load-path "visual/solarized-emacs")

(add-to-list 'custom-theme-load-path "~/.emacs.d/visual/solarized-emacs")

(add-to-list 'custom-safe-themes 'solarized-dark)

(load-theme 'solarized-dark t)

(provide 'init-solarized-emacs)
