
(add-to-load-path "scala/scala-mode2")

(autoload 'scala-mode "scala-mode2" "Major mode for editing Scala code" t)

(add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))

(eval-after-load 'scala-mode
 `(progn
    (setq scala-indent:default-run-on-strategy scala-indent:eager-strategy
          scala-indent:align-parameters t)))

(provide 'init-scala-mode2)
