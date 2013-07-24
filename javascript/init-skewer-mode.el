
(add-to-load-path "javascript/skewer-mode")

(autoload 'run-skewer "skewer-mode" "REPL for JavaScript development" t)

(defmacro defskewer-start (name browser)
 `(defun ,name ()
    (interactive)
    (let ((browse-url-browser-function 'browse-url-generic)
          (browse-url-generic-program ,browser))
      (run-skewer))))

(defskewer-start conkeror "conkeror")
(defskewer-start firefox  "firefox" )
(defskewer-start chrome   "google-chrome")

(add-hook 'js2-mode-hook  'skewer-mode)
(add-hook 'css-mode-hook  'skewer-css-mode)
(add-hook 'sgml-mode-hook 'skewer-html-mode)

(provide 'init-skewer-mode)
