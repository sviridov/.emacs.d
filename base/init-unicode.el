
(defvar unicode-shortnames-table (make-hash-table :test 'equal))

(dolist (shortname '(("inf" . "infinity")
                     ("eps" . "latin capital letter epsilon")

                     ("zz" . "double-struck z")
                     ("nn" . "double-struck n")
                     ("rr" . "double-struck r")
                     ("qq" . "double-struck q")
                     ("cc" . "double-struck c")

                     ("union"        . "union")
                     ("intersection" . "intersection")

                     ("right arrow" . "right arrow")
                     ("left arrow"  . "left arrow")
                     ("lt" . "less-than or equal to")
                     ("gt" . "greater-than or equal to")

                     ("Ss" . "section sign")))

  (setf (gethash (car shortname) unicode-shortnames-table) (cdr shortname)))

(defun insert-unicode-char (arg)
  (interactive "P")
  (let ((charname (gethash
                   (completing-read "Insert character (Unicode name or hex):"
                     (cl-loop for key being the hash-key in unicode-shortnames-table
                              collect key))
                   unicode-shortnames-table)))
    (when arg
      (insert "\\"))
    (insert-char (cdr (assoc-string charname (ucs-names) t)))))

(global-set-key (kbd "M-<insert>") #'insert-unicode-char)
(global-set-key (kbd "C-M-<insert>") #'insert-char)

(provide 'init-unicode)
