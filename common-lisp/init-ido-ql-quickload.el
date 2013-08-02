
(add-load-path "common-lisp/ido-ql-quickload")

(autoload 'ql:quickload "ido-ql-quickload" "ido-ql-quickload command" t)

(eval-after-load 'ido-ql-quickload
 `(progn
    (setf ido-ql-quickload-save-file (concat user-emacs-directory ".quickload"))
    (ido-ql-quickload-initialize)))

(provide 'init-ido-ql-quickload)
