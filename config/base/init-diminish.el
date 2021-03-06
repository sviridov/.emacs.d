
(require-package 'diminish)

(defmacro rename-major-mode (package-name mode new-name)
 `(eval-after-load ,package-name
   '(defadvice ,mode (after rename-modeline activate)
      (setq mode-name ,new-name))))

(defmacro rename-minor-mode (package mode new-name)
 `(eval-after-load ,package
   '(diminish ',mode ,new-name)))

(rename-major-mode "ruby-mode" ruby-mode "RUBY")

(add-hook 'emacs-lisp-mode-hook (lambda() (setq mode-name "ELISP")))

(rename-minor-mode "company" company-mode "CMP")
(rename-minor-mode "eldoc" eldoc-mode "DOC")
(rename-minor-mode "elisp-slime-nav" elisp-slime-nav-mode "NAV")
(rename-minor-mode "robe" robe-mode nil)
(rename-minor-mode "rubocop" rubocop-mode nil)
(rename-minor-mode "yasnippet" yas-minor-mode " Y")
(rename-minor-mode "subword" subword-mode nil)

(setq-default projectile-mode-line
 '(:eval (format " PRJ[%s]" (projectile-project-name))))

(provide 'init-diminish)
