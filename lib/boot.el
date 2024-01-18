;;; boot

(require 'package)

(setq package-enable-at-startup nil)

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

;; use-package

(eval-when-compile
  (require 'use-package))

(require 'use-package-ensure)
(setq use-package-always-ensure t)
(setq use-package-compute-statistics t)

(use-package auto-package-update
  :config
  (setq auto-package-update-interval 5
        auto-package-update-delete-old-versions t
        auto-package-update-last-update-day-path (expand-file-name "var/auto-package-update-timestamp" user-emacs-directory))
  (auto-package-update-maybe))

;; keep config tidy

(use-package no-littering)
(setq custom-file (make-temp-file "emacs-custom"))

(provide 'boot)
