
(require-package 'robe)

(add-hook 'ruby-mode-hook 'robe-mode)

(eval-after-load "company"
 '(push 'company-robe company-backends))

(provide 'init-robe)
