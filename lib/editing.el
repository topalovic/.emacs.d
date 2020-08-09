;;; editing

;; disable backups & auto-save
(setq backup-inhibited 1)
(setq auto-save-default nil)

;; revert buffers upon changes on disk
(global-auto-revert-mode 1)
(setq auto-revert-verbose nil)

;; plain text in scratch
(setq default-major-mode 'text-mode)

;; replace selection on keypress
(delete-selection-mode 1)

;; newline at the end of file
(setq-default require-final-newline t)

;; spaces for indentation
(setq-default indent-tabs-mode nil)

;; single space ends a sentence
(setq sentence-end-double-space nil)

;; treat camel case as separate words
(global-subword-mode 1)

(setq-default fill-column 79)

;; delete trailing whitespace on save
(add-hook 'before-save-hook
          (lambda ()
            (unless (derived-mode-p 'special-mode 'ses-mode)
              (delete-trailing-whitespace))))

(use-package wgrep
  :init
  (setq wgrep-auto-save-buffer t))

(use-package wgrep-ag)

(use-package whitespace
  :init
  (setq whitespace-style '(face tabs trailing))
  :config
  (global-whitespace-mode 1))

(use-package yasnippet-snippets
  :config
  (defun my/yas-expand (orig-fun &optional field)
    "Restrict expansion to whitespace points."
    (if (or (looking-at "[[:space:]\n]") (eq (point) (point-max)))
        (apply orig-fun field)
      (yas--fallback)))

  (advice-add 'yas-expand :around #'my/yas-expand)

  (yas-global-mode 1))

(provide 'editing)
