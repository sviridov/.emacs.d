
(require-package 'ido-ubiquitous)
(require-package 'flx-ido)

(require 'ido-ubiquitous)
(require 'flx-ido)

(setq ido-enable-flex-matching t
      ido-everywhere t
      ido-save-directory-list-file "~/.ido.last"
      ido-use-faces nil)

(ido-mode 1)
(ido-ubiquitous-mode 1)
(flx-ido-mode 1)

(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

(provide 'init-ido)
