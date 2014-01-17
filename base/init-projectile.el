
(require-package 'projectile)

(setq projectile-known-projects-file (in-user-emacs-directory ".projectile-bookmarks")
      projectile-switch-project-action 'projectile-dired)

(projectile-global-mode)

(provide 'init-projectile)
