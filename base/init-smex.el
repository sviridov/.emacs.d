
(add-load-path "base/smex")

(require 'smex)

(setq-default smex-save-file "~/.smex")

(smex-initialize)

(global-set-key (kbd "M-x"    ) 'smex                    )
(global-set-key (kbd "M-X"    ) 'smex-major-mode-commands)
(global-set-key (kbd "C-c M-x") 'execute-extended-command)

(provide 'init-smex)
