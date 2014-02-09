
(when (and (not (daemonp))
           (find-font (font-spec :name "Ubuntu Mono-13")))
  (set-frame-font "Ubuntu Mono-13" nil t)
  (set-face-attribute 'mode-line nil :family "Ubuntu Mono"))

(provide 'init-font)
