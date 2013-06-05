;;;; ido-ql-quickload.el
;;;;
;;;; ido-ql-quickload is available under the MIT license;
;;;; see LICENSE for details
;;;;
;;;; For a detailed introduction see: README.md
;;;;
;;;; Copyright (C) 2013 Sviridov Alexander <sviridov.vmi@gmail.com>
;;;;
;;;; Change Log:
;;;;
;;;; 1.0 First released
;;;; 1.1 Added `ido-ql-quickload-suppress-output'

(require 'ido)
(require 'cl)
(require 'slime)
(require 'slime-repl)

;;;=================================================================================================

(defgroup ido-ql-quickload nil
  "ql:quickload interface with Ido-style fuzzy matching and ranking heuristics"
  :group 'slime
  :version "1.1"
  :link '(emacs-library-link :tag "Lisp File" "ido-ql-quickload.el"))

(defcustom ido-ql-quickload-save-file "~/.ido-ql-quickload"
  "File in which the ido-ql-quickload state is saved between Emacs sessions"
  :type 'string
  :group 'ido-ql-quickload)

(defvar ido-ql-quickload--statistics (make-hash-table :test 'equal)
  "Variable in which the ido-ql-quickload statistics is stored")

(defvar ido-ql-quickload--history nil
  "Variable in which the ido-ql-quickload history is stored")

(defcustom ido-ql-quickload-max-history-size 5
  "Variable that defines the ido-ql-quickload history maximum size"
  :type 'integer
  :group 'ido-ql-quickload)

(defcustom ido-ql-quickload-ignore-local-projects-priority nil
  "If `ido-ql-quickload-ignore-local-projects-priority' is T then `ql:quickload' doesn't
   take into account the location of the projects"
  :type 'boolean
  :group 'ido-ql-quickload)

(defcustom ido-ql-quickload-suppress-output nil
  "If `ido-ql-quickload-suppress-output' is T then `ql:quickload' doesn't
   switch to `slime-repl' buffer and doesn't print (ql:quickload ...) into it"
  :type 'boolean
  :group 'ido-ql-quickload)

(defvar ido-ql-quickload--initialized-p nil)

;;;=================================================================================================

(defun ido-ql-quickload-drop-extra-history-items ()
  "Drops extra items from tail of `ido-ql-quickload--history'"
  (when (< ido-ql-quickload-max-history-size (length ido-ql-quickload--history))
    (setf ido-ql-quickload--history
          (butlast ido-ql-quickload--history
                   (- (length ido-ql-quickload--history)
                      (max 0 ido-ql-quickload-max-history-size))))))

;;;=================================================================================================

(defun ido-ql-quickload-initialize ()
  "Reads the contents of the `ido-ql-quickload-save-file'
   into `ido-ql-quickload--history' and `ido-ql-quickload--statistics'"
  (when (and (file-readable-p ido-ql-quickload-save-file)
             (not ido-ql-quickload--initialized-p))
    (with-temp-buffer
      (insert-file-contents ido-ql-quickload-save-file)
      (setf ido-ql-quickload--history (read (current-buffer))
            ido-ql-quickload--statistics (read (current-buffer))
            ido-ql-quickload--initialized-p t))

    ;; In case the user has reduced the value of the `ido-ql-quickload-max-history-size'
    ;; between sessions
    (ido-ql-quickload-drop-extra-history-items)))

;;;=================================================================================================

(defun ido-ql-quickload-update-system-score (system)
  "Increments `system' score.
   For new `system' sets score to 1"
  (incf (gethash system ido-ql-quickload--statistics 0)))

;;;=================================================================================================

(defun ido-ql-quickload-update-history (system)
  "Moves `system' to first position at `ido-ql-quickload--history'.
   If (`length' `ido-ql-quickload--history') = `ido-ql-quickload-max-history-size'
   and (`not' (`member' `system' `ido-ql-quickload--history')) drops the last item of
   `ido-ql-quickload--history'"
  (when (plusp ido-ql-quickload-max-history-size)
    (setf ido-ql-quickload--history (cons system (remove system ido-ql-quickload--history)))
    (ido-ql-quickload-drop-extra-history-items)))

;;;=================================================================================================

(defun ido-ql-quickload-save-to-file ()
  "Saves `ido-ql-quickload--history' and `ido-ql-quickload--statistics'
   into `ido-ql-quickload-save-file'"
  (interactive)
  (ido-ql-quickload-drop-extra-history-items)
  (with-temp-file (expand-file-name ido-ql-quickload-save-file)
    (print ido-ql-quickload--history (current-buffer))
    (print ido-ql-quickload--statistics (current-buffer))))
    
(add-hook 'kill-emacs-hook 'ido-ql-quickload-save-to-file)

;;;=================================================================================================

(defun ido-ql-quickload-sort-systems-names (systems-names)
  "Sorts `systems-names' list by:
   1. Score
   2. Aplhabet"
  (let ((grouped-by-score-names-table (make-hash-table))
        (result nil))
    (dolist (system-name systems-names)
      (push system-name
            (gethash (gethash system-name ido-ql-quickload--statistics 0)
                     grouped-by-score-names-table)))
    (maphash (lambda (score names)
               (push (cons score (sort names #'string-lessp)) result))
      grouped-by-score-names-table)
    (mapcan #'rest 
      (sort result (lambda (prev next) (> (car prev) (car next)))))))

;;;=================================================================================================

(defun ido-ql-quickload-select-system ()
  "Asks the user to select `system' to `ql:quickload' with `ido'.
   Systems by default are sorted in order:
   1. `ido-ql-quickload-max-history-size' number of last selected systems
   2. Quicklisp local systems sorted by score and name
   3. Other Quicklisp systems sorted by score and name"
  (ido-ql-quickload-drop-extra-history-items)
  (let* ((ido-enable-flex-matching t)
         
         (local-systems (nset-difference (slime-eval '(ql:list-local-systems))
                                         ido-ql-quickload--history
                                         :test #'string-equal))

         (quicklisp-systems (nset-difference
                             (slime-eval '(cl:mapcar (cl:function ql-dist:name) 
                                                     (ql:system-list)))
                             (append ido-ql-quickload--history
                                     local-systems)
                             :test #'string-equal))

         (systems-list (if ido-ql-quickload-ignore-local-projects-priority
                           (append ido-ql-quickload--history
                                   (ido-ql-quickload-sort-systems-names
                                     (append local-systems quicklisp-systems)))
                           (append ido-ql-quickload--history
                                   (ido-ql-quickload-sort-systems-names local-systems)
                                   (ido-ql-quickload-sort-systems-names quicklisp-systems))))

         (system (ido-completing-read "" systems-list)))

    (ido-ql-quickload-update-system-score system)
    (ido-ql-quickload-update-history system)

    system))

;;;=================================================================================================

(defun ql:quickload ()
  (interactive)
  (if ido-ql-quickload-suppress-output

      (slime-eval-async 
       `(cl:with-open-stream (cl:*standard-output* (cl:make-broadcast-stream))
          (ql:quickload ,(ido-ql-quickload-select-system)))
        (lambda (system)
          (message "Loaded: %s" (first system))))

    (let ((slime-buffer (find-if (lambda (buffer) (string-match-p "slime-repl" (buffer-name buffer))) 
                                 (buffer-list)))
          (buffer (current-buffer)))
      (switch-to-buffer slime-buffer)
      (end-of-buffer)
      (slime-repl-kill-input)
      (insert "(ql:quickload :")
      (condition-case err
          (let ((system (ido-ql-quickload-select-system)))
            (end-of-line)
            (insert system) 
            (insert ")")
            (slime-repl-return))
        (quit (when (string-equal (buffer-substring (- (point) 15) (point))
                                  "(ql:quickload :")
                (backward-delete-char 15))))
      (switch-to-buffer buffer))))

;;;=================================================================================================

(provide 'ido-ql-quickload)

;;;=================================================================================================
