
(require 'dired)

(setq dired-listing-switches "-alh"
      dired-recursive-copies 'always
      dired-recursive-deletes 'top
      dired-dwim-target t)

(put 'dired-find-alternate-file 'disabled nil)

(global-set-key (kbd "C-x C-j") 'dired-jump)

(provide 'init-dired)
