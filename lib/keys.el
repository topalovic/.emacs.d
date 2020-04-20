;;; keys

;; disable frame killers
(global-set-key (kbd "s-q") nil)
(global-set-key (kbd "s-w") nil)

;; buffer list & cycling
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x C-o") 'swap-windows)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;; rename and delete buffers & files
(global-set-key (kbd "C-c r") 'rename-buffer-and-file)
(global-set-key (kbd "C-c d") 'delete-buffer-and-file)

;; word & region killing
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-x C-k") 'kill-region)
(global-set-key (kbd "C-c C-k") 'kill-region)

;; editing
(global-set-key (kbd "C-r") 'query-replace-regexp)
(global-set-key (kbd "C-S-d") 'duplicate-current-line)
(global-set-key (kbd "M-Q") 'unfill-paragraph)
(global-set-key (kbd "<C-tab>") 'hippie-expand)

;; tools
(global-set-key (kbd "M-i") 'imenu)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-c \\") 'smart-shell-command)
(global-set-key (kbd "C-c a") 'org-agenda)

(provide 'keys)
