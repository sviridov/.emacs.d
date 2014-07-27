
(global-hl-line-mode 1)

(setq-default show-trailing-whitespace t)

(defmacro hide-trailing-whitespace (package-name mode)
 `(eval-after-load ,package-name
   '(defadvice ,mode (after hide-trailing-whitespace activate)
      (setq show-trailing-whitespace nil))))

(hide-trailing-whitespace "inf-ruby" inf-ruby-mode)
(hide-trailing-whitespace "eshell" eshell-mode)
(hide-trailing-whitespace "eww" eww-mode)

(provide 'init-highlight)
