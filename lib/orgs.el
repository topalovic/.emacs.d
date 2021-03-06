;;; org

(require 'org)

(setq org-hide-leading-stars t)

;; go get organized!

(setq org-agenda-files '("~/org/life")
      org-agenda-use-time-grid nil
      org-agenda-window-setup 'current-window
      org-modules '(org-habit)
      org-return-follows-link 1
      org-startup-folded 'showall
      calendar-week-start-day 1)

;; organon

(use-package deft
  :config
  (setq deft-extensions '("org" "md")
        deft-directory "~/org/anon"
        deft-use-filename-as-title t
        deft-auto-save-interval 0))

;; babel

(org-babel-do-load-languages
 'org-babel-load-languages
 '((C . t)
   (clojure . t)
   (emacs-lisp . t)
   (js . t)
   (latex . t)
   (makefile . t)
   (org . t)
   (python . t)
   (R . t)
   (ruby . t)
   (scheme . t)
   (shell . t)
   (sql . t)))

;; latex

;; to be inserted in every latex header
(setq org-latex-packages-alist
      '(("" "indentfirst" nil)))

(setq org-preview-latex-default-process 'imagemagick)

(setq org-format-latex-options
      (plist-put org-format-latex-options :scale 1.4))

(setq org-latex-hyperref-template
      "\\hypersetup{pdfauthor={%a},pdftitle={%t},hidelinks}")

(setq org-export-with-author nil)
(setq org-export-with-date nil)

(provide 'orgs)
