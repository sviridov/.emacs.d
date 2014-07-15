
(defun in-user-emacs-directory (&rest paths)
  (apply #'concat user-emacs-directory paths))

(defun add-load-path (&rest paths)
  (add-to-list 'load-path (apply #'in-user-emacs-directory paths)))

(defun add-config-load-path (&rest paths)
  (apply #'add-load-path "config/" paths))

(add-config-load-path)

(require 'init-package)
(require 'init-visual)
(require 'init-base)
(require 'init-code)
(require 'init-network)
(require 'init-common-lisp)
(require 'init-elisp)
(require 'init-clojure)
(require 'init-javascript)
(require 'init-coffeescript)
(require 'init-scala)
(require 'init-ruby)
(require 'init-web)
