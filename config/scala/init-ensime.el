
(require-package 'ensime)

(eval-after-load 'ensime
 `(progn
    (setq ensime-default-server-cmd
      (f-join (-first (-partial #'string-match "ensime") load-path) "bin" "server"))
    (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)))

(provide 'init-ensime)
