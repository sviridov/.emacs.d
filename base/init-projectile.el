
(require-package 'projectile)

(projectile-global-mode)

(setq projectile-known-projects-file (concat user-emacs-directory ".projectile-bookmarks")
      projectile-switch-project-action 'projectile-dired)

(provide 'init-projectile)
