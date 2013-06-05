
(defun add-to-load-path (&optional path)
  (add-to-list 'load-path (concat user-emacs-directory path)))

(add-to-load-path)

(require 'init-visual)
(require 'init-base)
(require 'init-code)
(require 'init-network)
(require 'init-common-lisp)
(require 'init-elisp)
(require 'init-clojure)
(require 'init-javascript)
(require 'init-web)
