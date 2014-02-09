
(require-package 'cider)

(eval-after-load "cider"
 '(progn
    (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
    (setq cider-popup-stacktraces t)))

(provide 'init-cider)
