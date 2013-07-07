
(require 'dired)

(setq dired-listing-switches "-alh"
      dired-recursive-copies 'always
      dired-recursive-deletes 'top
      dired-dwim-target t)

(global-set-key (kbd "C-x C-j") 'dired-jump)

(put 'dired-find-alternate-file 'disabled nil)

(provide 'init-dired)
