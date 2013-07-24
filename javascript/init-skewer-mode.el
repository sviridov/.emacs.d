
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

(defun js2-eval-friendly-node-p (n)
  (or (and (js2-stmt-node-p n) (not (js2-block-node-p n)))
      (and (js2-function-node-p n) (js2-function-node-name n))))

(defun skewer-eval-last-expression-and-replace ()
  (interactive)
  (let ((node (js2r--closest 'js2-eval-friendly-node-p)))
    (skewer-eval-last-expression t)
    (delete-region (js2-node-abs-pos node)
                   (+ 1 (js2-node-abs-end node)))
    (sleep-for 0 50)
    (backward-char)))

(eval-after-load "skewer-mode"
 `(progn
    (define-key skewer-mode-map (kbd "C-c C-e") 'skewer-eval-last-expression-and-replace)

    (require 'skewer-css)
    (require 'skewer-html)

    (add-hook 'css-mode-hook  'skewer-css-mode)
    (add-hook 'sgml-mode-hook 'skewer-html-mode)))

(provide 'init-skewer-mode)
