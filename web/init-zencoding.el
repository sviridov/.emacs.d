
(add-to-list 'load-path "~/.emacs.d/web/zencoding/")

(autoload 'zencoding-mode "zencoding-mode" "Minor Zencoding mode." t)

(add-hook 'sgml-mode-hook 'zencoding-mode)

(eval-after-load "zencoding-mode"
 `(define-key zencoding-mode-keymap (kbd "C-j") #'newline-and-indent))

(provide 'init-zencoding)
