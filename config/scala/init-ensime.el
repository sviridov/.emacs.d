
(require-package 'ensime)

(autoload 'ensime "ensime" "The ENhanced Scala Interaction Mode for Emacs" t)

(eval-after-load 'ensime
 `(progn
    (setq ensime-default-server-cmd
      (f-join (-first (-partial #'string-match "ensime") load-path) "bin" "server"))
    (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)))

(provide 'init-ensime)
