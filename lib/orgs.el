;;; org

(require 'org)

;; go get organized!

(setq org-agenda-files '("~/org/todo")
      org-agenda-use-time-grid nil
      org-agenda-time-grid '((daily today require-timed)
                             (800 1000 1200 1400 1600 1800 2000)
                             " ..... " "")
      org-agenda-window-setup 'current-window
      org-modules '(org-habit)
      org-priority-lowest ?D
      org-priority-default ?C
      org-habit-following-days 2
      org-habit-show-all-today t
      org-return-follows-link t
      org-hide-leading-stars t
      org-adapt-indentation t
      org-startup-folded 'showall
      calendar-week-start-day 1)

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

;; src blocks

(setq org-confirm-babel-evaluate nil)
(setq org-edit-src-content-indentation 0)

;; html

(setq org-html-checkbox-type 'html)

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

;; hide emphasis markers unless under cursor

(setq org-hide-emphasis-markers t)

(use-package org-appear
  :config
  (add-hook 'org-mode-hook 'org-appear-mode))

;; presenting from org

(use-package org-present)

(provide 'orgs)
