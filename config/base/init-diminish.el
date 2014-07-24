
(require-package 'diminish)

(defmacro rename-modeline (package-name mode new-name)
 `(eval-after-load ,package-name
   '(defadvice ,mode (after rename-modeline activate)
      (setq mode-name ,new-name))))

(defmacro rename-minor-mode (package mode new-name)
 `(eval-after-load ,package
   '(diminish ',mode ,new-name)))

(add-hook 'emacs-lisp-mode-hook (lambda() (setq mode-name "ELISP")))

(rename-minor-mode "company" company-mode "CMP")
(rename-minor-mode "eldoc" eldoc-mode "DOC")
(rename-minor-mode "elisp-slime-nav" elisp-slime-nav-mode "NAV")

(eval-after-load "flycheck"
 '(setq flycheck-mode-line-lighter " FC"))

(setq-default projectile-mode-line-lighter "PRJ")

(provide 'init-diminish)
