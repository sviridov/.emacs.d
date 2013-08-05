
(require 'windmove)

(windmove-default-keybindings 'super)

(defun toggle-windows--function-symbol (direction)
  (intern (concat "toggle-windows-" direction)))

(defmacro define-toggle-windows-function (direction)
 `(defun ,(toggle-windows--function-symbol direction) ()
    (interactive)
    (let ((previous-window (selected-window))
          (previous-buffer (current-buffer)))
      (funcall #',(intern (concat "windmove-" direction)))
      (set-window-buffer previous-window (current-buffer))
      (set-window-buffer (selected-window) previous-buffer))))

(define-toggle-windows-function "up")
(define-toggle-windows-function "down")
(define-toggle-windows-function "left")
(define-toggle-windows-function "right")

(dolist (direction '("up" "down" "left" "right"))
  (global-set-key (kbd (concat "s-M-<" direction ">"))
    (symbol-function (toggle-windows--function-symbol direction))))

(provide 'init-windmove)
