
(when (and (not (daemonp))
           (find-font (font-spec :name "Ubuntu Mono-13")))
  (set-frame-font "Ubuntu Mono-13" nil t))

(provide 'init-font)
