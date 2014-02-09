
(require-package 'w3m)

(setq browse-url-browser-function 'w3m-browse-url)

(global-set-key "\C-xm" 'browse-url-at-point)

(provide 'init-w3m)
