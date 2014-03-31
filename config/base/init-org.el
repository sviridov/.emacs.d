
(eval-after-load "org"
 '(progn
    (require 'org-protocol)
    (setq org-startup-indented t)))

(require-package 'org-trello)

(add-hook 'org-mode-hook 'org-trello-mode)

(defadvice org-trello/install-board-and-lists-ids (around force-resize-mini-windows)
  (let ((resize-mini-windows t))
    ad-do-it))

(provide 'init-org)
