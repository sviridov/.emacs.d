
(require-package 'company)
(require-package 'slime-company)
(require-package 'company-cider)

(add-hook 'after-init-hook 'global-company-mode)

(eval-after-load "company"
 '(add-to-list 'company-backends 'company-cider))

(provide 'init-company)
