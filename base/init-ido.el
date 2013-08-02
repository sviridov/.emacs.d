
(add-load-path "base/ido-ubiquitous")

(require 'ido)
(require 'ido-ubiquitous)

(setq ido-enable-flex-matching t
      ido-everywhere t
      ido-save-directory-list-file (concat user-emacs-directory ".ido.last"))

(ido-mode 1)
(ido-ubiquitous-mode 1)

(defmacro ido-ubiquitous-use-new-completing-read (cmd package)
  `(eval-after-load ,package
     '(defadvice ,cmd (around ido-ubiquitous-new activate)
        (let ((ido-ubiquitous-enable-compatibility nil))
          ad-do-it))))

(ido-ubiquitous-use-new-completing-read webjump 'webjump)
(ido-ubiquitous-use-new-completing-read yas/expand 'yasnippet)
(ido-ubiquitous-use-new-completing-read yas/visit-snippet-file 'yasnippet)

(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

(provide 'init-ido)
