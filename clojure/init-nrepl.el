
(add-load-path "clojure/nrepl")

(autoload 'nrepl-jack-in "nrepl" "Launch an nREPL server and a nREPL client" t)
(autoload 'nrepl "nrepl" "Connect to an already-running nREPL server" t)

(eval-after-load "nrepl"
 '(progn
    (add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
    (setq nrepl-popup-stacktraces-in-repl t)))

(provide 'init-nrepl)
