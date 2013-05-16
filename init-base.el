
(add-to-load-path "base")

(setq-default inhibit-startup-buffer-menu nil
              inhibit-startup-screen        t
              initial-buffer-choice       nil
              initial-scratch-message     nil)

(setq scroll-step 1)

(setq-default make-backup-files nil
	      auto-save-defaults  t
	      indent-tabs-mode  nil
              resize-mini-windows t
              enable-recursive-minibuffers t)

(fset 'yes-or-no-p 'y-or-n-p)

(put 'narrow-to-region 'disabled nil)

(require 'init-smex)
(require 'init-org)
(require 'init-ido)
(require 'init-uniquify)
(require 'init-russian-computer)
(require 'init-saveplace)
(require 'init-magit)
(require 'init-dired)
(require 'init-libraries)
(require 'init-multiple-cursors)
(require 'init-phi-search)
(require 'init-ace-jump-mode)
(require 'init-quick-repl-history-search)
(require 'init-dictem)

(provide 'init-base)
