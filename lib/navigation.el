;;; navigation

(use-package smex)

(use-package avy
  :config
  (setq avy-background t)
  :bind
  (("C-;" . avy-goto-char-2)))

(use-package ivy
  :bind
  (("C-s" . swiper))

  :init
  (setq ivy-use-virtual-buffers 1)
  (setq ivy-count-format "[%d/%d] ")
  (setq ivy-extra-directories ())

  :config
  (define-key ivy-minibuffer-map (kbd "C-j") #'ivy-immediate-done)
  (define-key ivy-minibuffer-map (kbd "RET") #'ivy-alt-done)
  (ivy-mode 1))

(use-package counsel
  :bind
  (("M-x" . counsel-M-x)
   ("C-x m" . counsel-M-x)
   ("C-x C-m" . counsel-M-x)
   ("C-x C-f" . counsel-find-file)
   ("C-x b" . counsel-switch-buffer)
   ("C-c s" . counsel-rg))

  :init
  (setq counsel-describe-function-function #'helpful-callable)
  (setq counsel-describe-variable-function #'helpful-variable)

  :config
  (defun my/yank-pop (orig-fun &rest args)
    "If last action was not a yank, run `counsel-yank-pop' instead."
    (interactive "*p")
    (if (eq last-command 'yank)
        (apply orig-fun args)
      (counsel-yank-pop)))
  (advice-add 'yank-pop :around #'my/yank-pop))

(use-package projectile
  :bind-keymap
  ("s-p" . projectile-command-map)
  ("C-c p" . projectile-command-map)

  :init
  (setq projectile-completion-system 'ivy)
  (setq projectile-git-use-fd nil)

  :config
  (projectile-mode 1)
  (remove-hook 'buffer-list-update-hook #'projectile-track-known-projects-find-file-hook))

(use-package projectile-rails
  :config
  (projectile-rails-global-mode)
  (define-key projectile-rails-mode-map (kbd "s-r") 'projectile-rails-command-map)
  (define-key projectile-rails-mode-map (kbd "C-c C-p") 'projectile-rails-command-map))

(defun ibuffer-update-with-vc-refresh ()
  (interactive)
  (vc-refresh-all-buffers)
  (ibuffer-update nil))

(use-package ibuffer-vc
  :config
  (add-hook 'ibuffer-hook
            (lambda ()
              (ibuffer-vc-set-filter-groups-by-vc-root)
              (unless (eq ibuffer-sorting-mode 'filename/process)
                (ibuffer-do-sort-by-filename/process))))
  :init
  (setq ibuffer-show-empty-filter-groups nil)
  (setq ibuffer-formats
        '((mark modified read-only vc-status-mini
                " "
                (name 32 32 :left :elide)
                " "
                (mode 16 16 :left :elide)
                " "
                filename-and-process)))

  :bind
  (:map ibuffer-mode-map
        ("G" . ibuffer-update-with-vc-refresh)))

(setq vc-follow-symlinks t)

;; dired

(require 'ls-lisp)
(setq ls-lisp-dirs-first t)
(setq ls-lisp-use-insert-directory-program nil)

(setq dired-listing-switches "-alh")

(use-package dired-subtree
  :after dired
  :init
  (setq dired-subtree-use-backgrounds nil)
  :bind
  (:map dired-mode-map
              ("TAB" . dired-subtree-toggle)
              ("DEL" . dired-up-directory)))

(provide 'navigation)
