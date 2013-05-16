
(add-to-load-path "network/w3m")

(autoload 'w3m-browse-url "w3m" "w3m browser function" t)

(setq browse-url-browser-function 'w3m-browse-url)

(global-set-key "\C-xm" 'browse-url-at-point)

(provide 'init-w3m)
