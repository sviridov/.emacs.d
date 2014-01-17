
(require 'package)

(add-to-list 'package-archives '("melpa"     . "http://melpa.milkbox.net/packages/" ) t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)

(package-initialize)

(dolist (archive '("gnu" "melpa" "marmalade"))
  (unless (file-exists-p (in-user-emacs-directory (concat "elpa/archives/" archive)))
    (package-refresh-contents)))

(defun require-package (package &optional no-refresh)
  (cond ((package-installed-p package) t)
        ((or (assoc package package-archive-contents) no-refresh) (package-install package))
        (t (package-refresh-contents)
           (require-package package t))))

(provide 'init-package)
