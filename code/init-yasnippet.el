
(add-to-load-path "code/yasnippet")

(require 'yasnippet)

(setq yas-prompt-functions '(yas-ido-prompt)
      yas-snippet-dirs (list (concat user-emacs-directory "code/snippets")))

(yas/global-mode 1)

(provide 'init-yasnippet)
