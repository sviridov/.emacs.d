
(eval-after-load "org"
 '(progn
    (require 'org-protocol)
    (setq org-startup-indented t)))

(require-package 'org-trello)

(add-hook 'org-mode-hook 'org-trello-mode)

(provide 'init-org)
