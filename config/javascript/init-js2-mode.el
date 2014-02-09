
(require-package 'js2-mode)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(add-hook 'js2-mode-hook  #'(lambda () (setf js2-basic-offset 2
                                             js2-bounce-indent-p t)))

(provide 'init-js2-mode)
