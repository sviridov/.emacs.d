
(add-to-list 'load-path "~/.emacs.d/web/zencoding/")

(autoload 'zencoding-mode "zencoding-mode" "Minor Zencoding mode." t)

(add-hook 'sgml-mode-hook 'zencoding-mode)

(provide 'init-zencoding)
