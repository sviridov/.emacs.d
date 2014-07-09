
(require-package 'git-gutter)

(global-git-gutter-mode 1)

(setq git-gutter:window-width 2
      git-gutter:lighter ""
      git-gutter:added-sign "✎"
      git-gutter:deleted-sign "☠"
      git-gutter:modified-sign "⚒")

(set-face-foreground 'git-gutter:deleted "red")
(set-face-foreground 'git-gutter:modified "yellow")

(provide 'init-git-gutter)
