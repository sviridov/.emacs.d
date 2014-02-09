
(add-config-load-path "base/dictem")

(--each '(dictem-run-en-en
          dictem-run-en-ru
          dictem-run-ru-en
          dictem-run-ru-ru)
  (autoload it "dictem" nil t))

(defun dictem-ensure-buffer ()
  (let* ((dictem-buffer (get-buffer-create dictem-buffer-name))
         (dictem-window (get-buffer-window dictem-buffer))
         (window-configuration (current-window-configuration))
         (selected-window (frame-selected-window)))

    (if (window-live-p dictem-window)
        (select-window dictem-window)
        (switch-to-buffer-other-window dictem-buffer))

    (when (dictem-mode-p)
      (if dictem-use-content-history
          (setq dictem-content-history
                (cons (list (buffer-substring (point-min) (point-max))
                            (point))
                      dictem-content-history)))
      (setq buffer-read-only nil)
      (erase-buffer))

    (unless (dictem-mode-p)
      (dictem-mode)
      (make-local-variable 'dictem-window-configuration)
      (make-local-variable 'dictem-selected-window)
      (make-local-variable 'dictem-content-history)
      (setq dictem-window-configuration window-configuration)
      (setq dictem-selected-window selected-window))))

(defun dictem-run-define-at-point (from-to)
  (interactive)
  (let* ((default-word (thing-at-point 'symbol))
         (selected-window (frame-selected-window))
         (dictem-query (s-trim default-word)))

    (unless (zerop (length dictem-query))
      (dictem-run 'dictem-base-search from-to dictem-query ".")
      (select-window selected-window))))

(eval-after-load "dictem"
 '(progn
    (setq dictem-use-existing-buffer t
          dictem-use-user-databases-only t)

    (setq dictem-server "dict.mova.org"
          dictem-exclude-databases '("ger-" "-ger" "fra-" "-fra"))

    (add-hook 'dictem-postprocess-match-hook
              'dictem-postprocess-match)

    (add-hook 'dictem-postprocess-definition-hook
              'dictem-postprocess-definition-separator)

    (add-hook 'dictem-postprocess-definition-hook
              'dictem-postprocess-definition-hyperlinks)

    (add-hook 'dictem-postprocess-show-info-hook
              'dictem-postprocess-definition-hyperlinks)

    (add-hook 'dictem-postprocess-definition-hook
              'dictem-postprocess-each-definition)

    (setq dictem-user-databases-alist
      '(("_en-ru"  . ("mueller7" "korolew_en-ru" "en-ru"))
        ("_en-en"  . ("foldoc"))
        ("_ru-ru"  . ("beslov" "ushakov" "ozhegov" "brok_and_efr"))
        ("_ru-en"  . ("ru-en"))))

    (define-key dictem-mode-map [tab] 'dictem-next-link)
    (define-key dictem-mode-map [(backtab)] 'dictem-previous-link)

    (defun dictem-run-ru-en ()
      (interactive)
      (dictem-run-define-at-point "_ru-en"))

    (defun dictem-run-ru-ru ()
      (interactive)
      (dictem-run-define-at-point "_ru-ru"))

    (defun dictem-run-en-ru ()
      (interactive)
      (dictem-run-define-at-point "_en-ru"))

    (defun dictem-run-en-en ()
      (interactive)
      (dictem-run-define-at-point "_en-en"))

    (dictem-initialize)))

(global-unset-key (kbd "C-t"))

(global-set-key (kbd "C-t e") 'dictem-run-en-en)
(global-set-key (kbd "C-t r") 'dictem-run-ru-ru)
(global-set-key (kbd "C-t t") 'dictem-run-en-ru)
(global-set-key (kbd "C-t y") 'dictem-run-ru-en)

(provide 'init-dictem)
