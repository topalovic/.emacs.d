;;; boot

;; gc

(setq gc-cons-threshold 100000000)

;; package

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

;; keep config tidy

(use-package no-littering)
(setq custom-file (make-temp-file "emacs-custom"))

(provide 'boot)
