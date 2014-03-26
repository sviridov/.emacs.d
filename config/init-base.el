
(add-config-load-path "base")

(setq scroll-step 1
      make-pointer-invisible t)

(setq-default make-backup-files nil
	      auto-save-defaults  t
	      indent-tabs-mode  nil)

(put 'narrow-to-region 'disabled nil)

(require 'init-startup)
(require 'init-smex)
(require 'init-org)
(require 'init-ido)
(require 'init-uniquify)
(require 'init-saveplace)
(require 'init-magit)
(require 'init-dired)
(require 'init-libraries)
(require 'init-multiple-cursors)
(require 'init-phi-search)
(require 'init-ace-jump-mode)
(require 'init-quick-repl-history-search)
(require 'init-dictem)
(require 'init-minibuffer)
(require 'init-windmove)
(require 'init-markdown-mode)
(require 'init-unicode)
(require 'init-kill-ring)
(require 'init-projectile)
(require 'init-editorconfig)

(provide 'init-base)
