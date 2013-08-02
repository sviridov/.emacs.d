
(global-set-key (kbd "M-j") (lambda ()
                              (interactive)
                              (join-line -1)))

(global-unset-key (kbd "M-t"))

(global-set-key (kbd "M-t l") 'transpose-lines)
(global-set-key (kbd "M-t w") 'transpose-words)
(global-set-key (kbd "M-t s") 'transpose-sexps)
(global-set-key (kbd "M-t c") 'transpose-chars)

(provide 'init-code-editing-keybindings)
