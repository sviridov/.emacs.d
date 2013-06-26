
(add-to-list 'load-path "/usr/local/lib/ensime/elisp")

(autoload 'ensime "ensime" "The ENhanced Scala Interaction Mode for Emacs" t)

(eval-after-load 'ensime
 `(progn
    (setq ensime-default-server-cmd "/usr/local/lib/ensime/bin/server")
    (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)))

(provide 'init-ensime)
