
(unless (fboundp 'toggle-fullscreen)
  (defun toggle-fullscreen ()
    (interactive)
    (when (eq window-system 'x)
      (set-frame-parameter
       nil 'fullscreen
       (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))))

(global-set-key [f11] 'toggle-fullscreen)

(provide 'init-fullscreen)
