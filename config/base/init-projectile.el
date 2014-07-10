
(require-package 'projectile)
(require-package 'projectile-rails)

(setq projectile-known-projects-file "~/.projectile-bookmarks"
      projectile-switch-project-action 'projectile-dired)

(projectile-global-mode)

(add-hook 'projectile-mode-hook 'projectile-rails-on)

(push '(projectile-tags-command . "ripper-tags -R -f") safe-local-variable-values)

(provide 'init-projectile)
