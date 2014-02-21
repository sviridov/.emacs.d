
(require-package 'rvm)

(add-hook 'ruby-mode-hook #'rvm-activate-corresponding-ruby)

(provide 'init-rvm)
