;;; org

(require 'org)

(setq org-agenda-files '("~/org/"))
(setq org-modules '(org-habit))
(setq org-startup-folded 'showall)
(setq org-agenda-use-time-grid nil)
(setq org-agenda-window-setup 'current-window)

(provide 'zorg)
