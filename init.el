
(defun add-to-load-path (path)
  (add-to-list 'load-path (concat user-emacs-directory path)))

(add-to-load-path "")

(require 'init-visual)
(require 'init-base)
(require 'init-code)
(require 'init-network)
(require 'init-cl)
(require 'init-elisp)
(require 'init-clojure)
(require 'init-js)
(require 'init-web)
