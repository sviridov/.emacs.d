
(add-load-path "base/ace-jump-mode")

(autoload 'ace-jump-mode "ace-jump-mode" "Emacs quick move minor mode" t)
(autoload 'ace-jump-mode-pop-mark "ace-jump-mode" "Ace jump back:-)" t)

(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))

(global-set-key (kbd "C-,") 'ace-jump-mode)
(global-set-key (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

(provide 'init-ace-jump-mode)
