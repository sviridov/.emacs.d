
(setq-default resize-mini-windows nil
              enable-recursive-minibuffers t)

(fset 'yes-or-no-p 'y-or-n-p)

(add-hook 'eval-expression-minibuffer-setup-hook #'eldoc-mode)

(provide 'init-minibuffer)
