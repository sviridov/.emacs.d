
(add-load-path "base/smex")

(autoload 'smex "smex" nil t)
(autoload 'smex-major-mode-commands "smex" nil t)
(autoload 'execute-extended-command "smex" nil t)

(setq-default smex-save-file "~/.smex")

(eval-after-load "smex"
 '(smex-initialize))

(global-set-key (kbd "M-x"    ) 'smex                    )
(global-set-key (kbd "M-X"    ) 'smex-major-mode-commands)
(global-set-key (kbd "C-c M-x") 'execute-extended-command)

(provide 'init-smex)
