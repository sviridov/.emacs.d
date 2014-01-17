
(require-package 'projectile)

(projectile-global-mode)

(setq projectile-known-projects-file
  (concat user-emacs-directory ".projectile-bookmarks"))

(provide 'init-projectile)
