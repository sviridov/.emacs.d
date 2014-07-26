
(require-package 'projectile)
(require-package 'projectile-rails)

(setq projectile-known-projects-file "~/.projectile-bookmarks"
      projectile-switch-project-action 'projectile-dired)

(projectile-global-mode)

(add-hook 'projectile-mode-hook 'projectile-rails-on)

(provide 'init-projectile)
