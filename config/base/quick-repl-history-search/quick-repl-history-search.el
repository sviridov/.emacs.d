;;;; quick-repl-history-search.el
;;;;
;;;; quick-repl-history-search is available under the MIT license;
;;;; see LICENSE for details
;;;;
;;;; For a detailed introduction see: README.md
;;;;
;;;; Copyright (C) 2013 Sviridov Alexander <sviridov.vmi@gmail.com>
;;;;
;;;; Change Log:
;;;;
;;;; 1.0 First released.
;;;;     Added SLiME support
;;;; 1.1 Added Eshell support
;;;; 1.2 Added IELM support
;;;; 1.3 Added Skewer support
;;;; 1.4 Added nREPL support
;;;; 1.5 Added Comint major-mode support
;;;;     Tested Coffee-repl

(require 'cl)

;;;=================================================================================================

(defgroup quick-repl-history-search nil
  "Quick history search for any Emacs REPL"
  :group 'emacs
  :version "1.5"
  :link '(emacs-library-link :tag "Lisp File" "quick-repl-history-search.el"))

(defcustom quick-repl-history-search-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-s") 'quick-repl-history-search-next)
    (define-key map (kbd "C-r") 'quick-repl-history-search-previous)
    (define-key map (kbd "C-g") 'quick-repl-history-search-abort)
    (define-key map (kbd "RET") 'quick-repl-history-search-complete-and-send)
    (define-key map (kbd "C-<return>") 'quick-repl-history-search-complete)
    (define-key map (kbd "C-SPC") 'quick-repl-history-search-start/stop-after-change-update)
    map)
  "Keymap for the quick-repl-history-search prompt buffers"
  :group 'quick-repl-history-search)

(defcustom quick-repl-history-search-simple-search-key (kbd "C-r")
  "Default key for REPL mode-map to start `quick-repl-history-search'"
  :group 'quick-repl-history-search)

(defcustom quick-repl-history-search-regexp-search-key (kbd "C-M-r")
  "Default key for REPL mode-map to start `quick-repl-history-regexp-search'"
  :group 'quick-repl-history-search)

;;;=================================================================================================

(defvar quick-repl-history-search-mode nil
  "Minor mode for quick-repl-history-search prompt buffer")

(make-variable-buffer-local 'quick-repl-history-search-mode)

(add-to-list 'minor-mode-alist '(quick-repl-history-search-mode " QuickSearch"))
(add-to-list 'minor-mode-map-alist `(quick-repl-history-search-mode . ,quick-repl-history-search-mode-map))

(defvar quick-repl-history-search--mode-line-format
  '(" *quick-repl-history-search*")) ;; TODO: Add more information

;;;=================================================================================================

(defvar quick-repl-history-search--repls-table (make-hash-table)
  "Contains different information about REPLs.
   Information represented as a plist.
   Plist keys:
    `:get-history-function'
    `:kill-input-function'
    `:send-input-function'")

(defmacro quick-repl-history-search--defgetter (name getter)
  "Provides defining of `quick-repl-history-search--repls-table' access functions"
 `(defun ,name ()
    (funcall (getf (gethash major-mode quick-repl-history-search--repls-table) ,getter))))

(quick-repl-history-search--defgetter quick-repl-history-search--get-history :get-history-function)
(quick-repl-history-search--defgetter quick-repl-history-search--kill-input  :kill-input-function)
(quick-repl-history-search--defgetter quick-repl-history-search--send-input  :send-input-function)

;;;=================================================================================================

(defvar quick-repl-history-search--target nil
  "The target (window . buffer) which this prompt buffer is for")

(make-variable-buffer-local 'quick-repl-history-search--target)

(defmacro quick-repl-history-search--with-target-buffer (&rest body)
  "Eval BODY with the QUICK-REPL-HISTORY-SEARCH--TARGET buffer selected"
  (let ((target (gensym "TARGET")))
    `(progn

       ;; assert that window and buffer live
       (cond ((null quick-repl-history-search--target)
              (error "quick-repl-history-search: unexpected error (quick-repl-history-search--target is nil)"))
             ((not (window-live-p (car quick-repl-history-search--target)))
              (error "quick-repl-history-search: target window is deleted"))
             ((not (buffer-live-p (cdr quick-repl-history-search--target)))
              (error "quick-repl-history-search: target buffer is killed")))

       (let ((,target quick-repl-history-search--target))
         (with-selected-window (car ,target)
           ;; if buffer is switched, switch back to the QUICK-REPL-HISTORY-SEARCH--TARGET
           (unless (eq (current-buffer) (cdr ,target))
             (switch-to-buffer (cdr ,target))
             (message "quick-repl-history-search: buffer is switched"))

           ,@body)))))

;;;=================================================================================================

(defvar quick-repl-history-search--regexp-search-p nil
  "Variable which affects the matching algorithm of `quick-repl-history-search--find-next'
   and `quick-repl-history-search--find-prev'")

(make-variable-buffer-local 'quick-repl-history-search--regexp-search-p)

(defvar quick-repl-history-search--history nil
  "Current REPL history (represented as a list) from newest to oldest.
   At start is whole REPL history.
   After calling `quick-repl-history-search--find-next' or `quick-repl-history-search--find-prev'
   is REPL history before (older) `quick-repl-history-search--current-history-item'")

(make-variable-buffer-local 'quick-repl-history-search--history)

(defvar quick-repl-history-search--history-reversed nil
  "Current REPL history (represented as a list) from oldest to newest.
   At start is NIL.
   After calling `quick-repl-history-search--find-next' or `quick-repl-history-search--find-prev'
   is REPL history after (newer) `quick-repl-history-search--current-history-item'")

(make-variable-buffer-local 'quick-repl-history-search--history-reversed)

(defvar quick-repl-history-search--current-history-item nil
  "Current element of REPL history.
   At start is NIL")

(make-variable-buffer-local 'quick-repl-history-search--current-history-item)

(defvar quick-repl-history-search--search-direction-is-next-p nil
  "Last search direction. Used in `quick-repl-history-search--update'")

(make-variable-buffer-local 'quick-repl-history-search--search-direction-is-next-p)

(defmacro quick-repl-history-search--define-find-function (name direction-is-next-p)
  "Provides defining of history finding funtions"
  (let ((push-list (if direction-is-next-p 'quick-repl-history-search--history 'quick-repl-history-search--history-reversed))
        (pop-list  (if direction-is-next-p 'quick-repl-history-search--history-reversed 'quick-repl-history-search--history)))
   `(defun ,name (query)
      (setf quick-repl-history-search--search-direction-is-next-p ,direction-is-next-p)
      (unless quick-repl-history-search--regexp-search-p
        (setf query (regexp-quote query)))
      (loop
       (unless ,pop-list
         ;; don't use `error' because of behavior of after-change-functions
         (message "No matches")
         (return))
       (when quick-repl-history-search--current-history-item
        (push quick-repl-history-search--current-history-item ,push-list))
       (setf quick-repl-history-search--current-history-item (pop ,pop-list))
       (when (string-match-p query quick-repl-history-search--current-history-item)
         (return quick-repl-history-search--current-history-item))))))

(quick-repl-history-search--define-find-function quick-repl-history-search--find-next t)
(quick-repl-history-search--define-find-function quick-repl-history-search--find-prev nil)

;;;=================================================================================================

(defvar quick-repl-history-search--kill-ring-backup nil
  "Backup of kill ring to restore after QUICK-REPL-HISTORY-SEARCH")

(make-variable-buffer-local 'quick-repl-history-search--kill-ring-backup)

(defun quick-repl-history-search--initialize (&optional regexp-search-p)
  "Initializes quick-repl-history-search buffer and buffer-local variables"
  (end-of-buffer)
  (let ((kill-ring-copy (copy-list kill-ring)) ;; FIXME
        (target (cons (selected-window) (current-buffer)))
        ;; if REPL has input, kill it
        (has-input-p (/= (point)
                         (progn
                           (quick-repl-history-search--kill-input)
                           (point)))))

    ;; quick-repl-history-search buffer initialization
    (select-window (split-window-vertically -4))
    (switch-to-buffer (generate-new-buffer "*quick-repl-history-search*"))

    ;; quick-repl-history-search buffer-local variables initialization
    (setf quick-repl-history-search--target target
          quick-repl-history-search-mode t
          quick-repl-history-search--history (quick-repl-history-search--with-target-buffer
                                              (quick-repl-history-search--get-history))
          quick-repl-history-search--history-reversed nil
          quick-repl-history-search--current-history-item nil
          quick-repl-history-search--kill-ring-backup kill-ring-copy
          quick-repl-history-search--regexp-search-p regexp-search-p
          mode-line-format quick-repl-history-search--mode-line-format)

    ;; if REPL has input, yank it into quick-repl-history-search buffer
    (when has-input-p
      (yank))))

(defun quick-repl-history-search--clean ()
  "Finalize quick-repl-history-search buffer"
  (setf kill-ring quick-repl-history-search--kill-ring-backup) ;; FIXME
  (let ((window (car quick-repl-history-search--target)))
    (kill-buffer (current-buffer))
    (delete-window (selected-window))
    (select-window window)))

;;;=================================================================================================

;;;###autoload
(defun quick-repl-history-search ()
  (interactive)
  (quick-repl-history-search--initialize))

;;;###autoload
(defun quick-repl-history-regexp-search ()
  (interactive)
  (quick-repl-history-search--initialize t))

(defun quick-repl-history-search-next ()
  (interactive)
  (let ((result (quick-repl-history-search--find-next (buffer-string))))
    (when result
      (quick-repl-history-search--with-target-buffer
       (quick-repl-history-search--kill-input)
       (insert result)))))

(defun quick-repl-history-search-previous ()
  (interactive)
  (let ((result (quick-repl-history-search--find-prev (buffer-string))))
    (when result
      (quick-repl-history-search--with-target-buffer
       (quick-repl-history-search--kill-input)
       (insert result)))))

(defun quick-repl-history-search-complete ()
  (interactive)
  (quick-repl-history-search--clean))

(defun quick-repl-history-search-complete-and-send ()
  (interactive)
  (quick-repl-history-search-complete)
  (quick-repl-history-search--send-input))

(defun quick-repl-history-search-abort ()
  (interactive)
  (let ((query (buffer-string)))
    (quick-repl-history-search--with-target-buffer
     (quick-repl-history-search--kill-input)
     (insert query))
    (quick-repl-history-search-complete)))

;;;=================================================================================================

(defvar quick-repl-history-search--after-change-update-p t
  "Variable that affects the automatic after-change update of target buffer")

(make-variable-buffer-local 'quick-repl-history-search--after-change-update-p)

(defun quick-repl-history-search--update (&rest _)
  (when (and quick-repl-history-search-mode
             quick-repl-history-search--after-change-update-p)
    (unless (and quick-repl-history-search--current-history-item
                 (string-match-p (buffer-string) quick-repl-history-search--current-history-item))
      (if quick-repl-history-search--search-direction-is-next-p
          (quick-repl-history-search-next)
          (quick-repl-history-search-previous)))))

(add-hook 'after-change-functions 'quick-repl-history-search--update)

(defun quick-repl-history-search-start/stop-after-change-update ()
  (interactive)
  (if quick-repl-history-search--after-change-update-p
      (message "Stoping after-change update")
      (message "Starting after-change update"))
  (setq quick-repl-history-search--after-change-update-p (not quick-repl-history-search--after-change-update-p)))

;;;=================================================================================================

(defun quick-repl-history-search--get-history-from-ring (ring)
  (destructuring-bind (end-position number-of-elements . history)
      ring
    (setf history (coerce history 'list))
    (let* ((length (length history))
           (length-minus-end-postion (- length end-position)))
      (nreverse
       (if (< number-of-elements length-minus-end-postion)
           (subseq history end-position (+ end-position number-of-elements))
           (nconc
            (subseq history end-position (+ end-position length-minus-end-postion))
            (subseq history 0 (- number-of-elements length-minus-end-postion))))))))

;;;=================================================================================================

(cl-defmacro quick-repl-history-search-add-repl (major-mode history-form
                                                      &key (prefix (substring (symbol-name major-mode) 0
                                                                              (- (length (symbol-name major-mode)) 5)))
                                                           (kill-input-function (intern (concat prefix "-kill-input")))
                                                           (send-input-function (intern (concat prefix "-send-input")))
                                                           (mode-hook (intern (concat prefix "-mode-hook")))
                                                           (mode-map  (intern (concat prefix "-mode-map" )))
                                                           (simple-search-key quick-repl-history-search-simple-search-key)
                                                           (regexp-search-key quick-repl-history-search-regexp-search-key))
  `(progn
     (setf (gethash ',major-mode quick-repl-history-search--repls-table)
           (list
            :get-history-function (lambda () ,history-form)
            :kill-input-function #',kill-input-function
            :send-input-function #',send-input-function))

     ,(if mode-hook
          `(add-hook ',mode-hook
             (lambda ()
               (define-key ,mode-map ,simple-search-key 'quick-repl-history-search)
               (define-key ,mode-map ,regexp-search-key 'quick-repl-history-regexp-search)))
        `(define-key ,mode-map ,simple-search-key 'quick-repl-history-search)
        `(define-key ,mode-map ,regexp-search-key 'quick-repl-history-regexp-search))))

;;;=================================================================================================

(cl-defmacro quick-repl-history-search-add-comint-repl (major-mode &rest args &key prefix
                                                                                   kill-input-function
                                                                                   send-input-function
                                                                                   mode-hook
                                                                                   mode-map
                                                                                   simple-search-key
                                                                                   regexp-search-key)

  (setf (getf args :kill-input-function) (getf args :kill-input-function #'comint-kill-input)
        (getf args :send-input-function) (getf args :send-input-function #'comint-send-input))

 `(quick-repl-history-search-add-repl ,major-mode
    (quick-repl-history-search--get-history-from-ring comint-input-ring)
    ,@args))

;;;=================================================================================================

(eval-after-load "comint"
 '(quick-repl-history-search-add-comint-repl comint-mode))

(eval-after-load "eshell"
 '(quick-repl-history-search-add-repl eshell-mode
    (quick-repl-history-search--get-history-from-ring eshell-history-ring)))

(eval-after-load "ielm"
 '(quick-repl-history-search-add-comint-repl inferior-emacs-lisp-mode
    :prefix "ielm"
    :send-input-function ielm-send-input
    :mode-map ielm-map))

(eval-after-load "nrepl"
 '(quick-repl-history-search-add-repl nrepl-mode
    nrepl-input-history))

(eval-after-load "skewer-repl"
 '(quick-repl-history-search-add-comint-repl skewer-repl-mode))

(eval-after-load "slime-repl"
 '(quick-repl-history-search-add-repl slime-repl-mode
    slime-repl-input-history :send-input-function slime-repl-return))

;;;=================================================================================================

(provide 'quick-repl-history-search)

;;;=================================================================================================
