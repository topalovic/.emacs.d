;;; development

;; ruby

(use-package inf-ruby
  :config
  (add-hook 'ruby-mode-hook 'inf-ruby-minor-mode))

(use-package robe
  :config
  (add-hook 'ruby-mode-hook 'robe-mode))

(use-package rspec-mode
  :config
  (eval-after-load 'rspec-mode
    '(rspec-install-snippets)))

(add-hook 'ruby-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-u") 'string-inflection-ruby-style-cycle)))

(setq ruby-insert-encoding-magic-comment nil)

;; clj

(use-package clojure-mode)
(use-package cider)

;; markup / frontend

(use-package markdown-mode
  :init
  (setq markdown-enable-wiki-links t)

  :mode
  ("\\.md\\'" . gfm-mode))

(use-package json-mode)
(use-package yaml-mode)
(use-package slim-mode)
(use-package coffee-mode)

;; LaTeX

(use-package tex-site
  :ensure auctex
  :mode
  ("\\.tex\\'" . latex-mode)
  :config
  (setq TeX-parse-self t))

;; misc

(use-package magit)

(use-package smartparens
  :config
  (smartparens-global-mode 1))

(use-package smart-compile
  :bind
  (("C-c c" . smart-compile)))

(use-package string-inflection
  :bind
  (("C-c C-u" . string-inflection-all-cycle)))

;; indentation

(setq-default c-basic-offset 4)
(setq-default sh-basic-offset 2)
(setq-default js-indent-level 2)
(setq-default css-indent-offset 2)

(provide 'development)
