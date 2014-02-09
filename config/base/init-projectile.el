
(require-package 'projectile)

(setq projectile-known-projects-file "~/.projectile-bookmarks"
      projectile-switch-project-action 'projectile-dired)

(projectile-global-mode)

(provide 'init-projectile)
