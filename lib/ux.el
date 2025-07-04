;;; ux

(setq use-short-answers t)

(setq large-file-warning-threshold 50000000)

;; suppress some warnings
(add-to-list 'warning-suppress-types '(org-element org-element-parser))

;; key assistance
(use-package which-key
  :config
  (which-key-mode))

;; better help buffer
(use-package helpful
  :bind
  (("C-h f" . helpful-callable))
  (("C-h v" . helpful-variable))
  (("C-h k" . helpful-key))
  (("C-h ," . helpful-at-point)))

;; blank scratch buffer
(setq inhibit-splash-screen 1)
(setq initial-scratch-message nil)
(setq initial-major-mode 'text-mode)

;; no toolbar & menu
(tool-bar-mode -1)
(menu-bar-mode -1)

;; no beeping & blinking
(setq ring-bell-function 'ignore)
(blink-cursor-mode -1)

;; scrolling
(scroll-bar-mode -1)
(setq scroll-margin 1)
(setq scroll-conservatively 101)

;; turn on line numbers
(use-package nlinum)
(global-nlinum-mode 1)
(column-number-mode 1)

;; highlight the current line
(global-hl-line-mode 1)

;; highlight parens
(show-paren-mode 1)

;; don't highlight clickables
(setq mouse-highlight nil)

;; no tooltips
(tooltip-mode -1)

;; use pulse for momentary highlighting
(setq pulse-flag t)
(setq pulse-delay 0.05)

;; do not display continuation lines
(setq-default truncate-lines 1)

;; prefer side-by-side split
(setq split-height-threshold nil)
(setq split-width-threshold 200)

;; titlebar
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . 1))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

(setq frame-title-format nil)
(setq ns-use-proxy-icon nil)

;; start maximized
(add-to-list 'default-frame-alist
             '(fullscreen . maximized))

;; tame popup buffers
(use-package popper
  :bind (("M-`" . popper-cycle)
         ("C-M-`" . popper-toggle-type))

  :init
  (setq popper-mode-line nil
        popper-reference-buffers
        '("\\*Messages\\*"
          "Output\\*$"
          "\\*Async Shell Command\\*"
          help-mode
          compilation-mode
          rspec-compilation-mode))

  (popper-mode 1)
  (popper-echo-mode 1))

;; folding
(use-package yafolding
  :config
  (add-hook 'prog-mode-hook 'yafolding-mode))

;; font
(add-to-list 'default-frame-alist '(font . "Fira Mono for Powerline-11"))

;; theme
(use-package doom-themes
  :init
  (load-theme 'doom-spacegrey t)

  :config
  (doom-themes-org-config)

  (set-face-attribute 'font-lock-string-face nil :foreground "#d2b4a0")

  (with-eval-after-load 'org
    (set-face-attribute 'org-level-1 nil :height 1.0)
    (set-face-attribute 'org-date nil :foreground (doom-darken (doom-color 'yellow) 0.12))
    (set-face-attribute 'org-block nil :background (doom-darken (doom-color 'bg-alt) 0.04) :extend t)
    (set-face-attribute 'org-scheduled nil :foreground (doom-color 'base7))
    (set-face-attribute 'org-scheduled-today nil :foreground (doom-color 'fg))
    (set-face-attribute 'org-agenda-date-weekend nil :inherit 'org-agenda-date :foreground 'unspecified))

  (with-eval-after-load 'spaceline
    (set-face-attribute 'spaceline-highlight-face nil :foreground (doom-color 'bg) :background (doom-color 'fg))))

(use-package all-the-icons)
(use-package all-the-icons-dired
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

(use-package spaceline
  :init
  (setq spaceline-byte-compile nil)) ; speeds up startup time greatly

(use-package spaceline-all-the-icons
  :after spaceline

  :init
  (setq spaceline-all-the-icons-slim-render 1
        spaceline-all-the-icons-separator-scale 1.5)

  :config
  (spaceline-toggle-all-the-icons-region-info-off)
  (spaceline-toggle-all-the-icons-vc-icon-off)
  (spaceline-toggle-all-the-icons-hud-off)
  (spaceline-toggle-all-the-icons-time-off)
  (spaceline-toggle-all-the-icons-projectile-off)
  (spaceline-all-the-icons-theme))

(provide 'ux)
