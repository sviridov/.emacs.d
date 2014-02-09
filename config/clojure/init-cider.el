
(add-config-load-path "clojure/cider")

(autoload 'cider-jack-in "cider" "Launch an nREPL server and a Cider client" t)
(autoload 'cider "cider" "Connect to an already-running nREPL server" t)

(eval-after-load "cider"
 '(progn
    (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
    (setq cider-popup-stacktraces t)))

(provide 'init-cider)
