
(require-package 'js2-mode)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(setq-default js2-basic-offset 2
              js2-bounce-indent-p t)

(add-hook 'js2-mode-hook
          (lambda ()
            (electric-indent-mode -1)

            (define-key js2-mode-map (kbd "M-j")
              (lambda ()
                (interactive)
                (join-line -1)))))

(provide 'init-js2-mode)
