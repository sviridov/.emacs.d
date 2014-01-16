
(require-package 'flycheck)

(add-hook 'after-init-hook #'global-flycheck-mode)

(eval-after-load "flycheck"
 '(setq flycheck-check-syntax-automatically '(save mode-enabled)
        flycheck-idle-change-delay 0.8))

(provide 'init-flycheck)
