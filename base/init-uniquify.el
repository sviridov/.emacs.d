
(require 'uniquify)

(setq uniquify-buffer-name-style 'reverse
      uniquify-separator "/"
      uniquify-after-kill-buffer-p t
      uniquify-ignore-buffers-re "^\\*"
      post-forward-angle-brackets 'post-forward-angle-brackets)

(provide 'init-uniquify)
