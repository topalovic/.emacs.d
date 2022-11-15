;;; development

;; asdf tool version manager

(let* ((asdf-path "$HOME/.asdf")
       (path (substitute-env-vars (concat asdf-path "/shims:" asdf-path "/bin:$PATH"))))
  (setenv "PATH" path)
  (setq exec-path
        (append
         (split-string-and-unquote path ":")
         exec-path)))

;; eglot

(use-package eglot)

;; ruby

(use-package inf-ruby
  :config
  (add-hook 'ruby-mode-hook 'inf-ruby-minor-mode))

(use-package rspec-mode
  :config
  (setq rspec-primary-source-dirs '("app"))

  (eval-after-load 'rspec-mode
    '(rspec-install-snippets)))

(use-package rubocop
  :config
  (setq rubocop-autocorrect-command "rubocop -A --format emacs")
  (add-hook 'ruby-mode-hook 'rubocop-mode))

(add-hook 'ruby-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-u") 'string-inflection-ruby-style-cycle)))

(setq ruby-insert-encoding-magic-comment nil)

;; clj

(use-package clojure-mode)
(use-package cider)

;; rust

(use-package rust-mode)

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

(use-package dockerfile-mode
  :mode "Dockerfile")

(use-package smartparens
  :config
  (smartparens-global-mode 1))

(use-package rainbow-delimiters
  :config
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'scheme-mode-hook 'rainbow-delimiters-mode))

(use-package smart-compile
  :bind
  (("C-c c" . smart-compile)))

(use-package string-inflection
  :bind
  (("C-c C-u" . string-inflection-all-cycle)))

(use-package company
  :bind
  (("<C-tab>" . company-complete)
   :map company-active-map
   ("<tab>" . company-complete-common-or-cycle)
   ("C-p" . company-select-previous)
   ("C-n" . company-select-next)
   :map company-search-map
   ("C-p" . company-select-previous)
   ("C-n" . company-select-next))

  :hook
  (after-init . global-company-mode)

  :config
  (setq company-transformers '(company-sort-by-backend-importance)
        company-dabbrev-downcase nil
        company-dabbrev-ignore-case nil
        company-idle-delay 0.75
        company-minimum-prefix-length 2
        company-require-match nil
        company-show-numbers t
        company-tooltip-align-annotations t))

;; indentation

(setq-default c-basic-offset 4)
(setq-default sh-basic-offset 2)
(setq-default js-indent-level 2)
(setq-default css-indent-offset 2)

(provide 'development)
