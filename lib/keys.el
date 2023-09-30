;;; keys

;; disable intrusive OS keys
(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "s-t") nil)
(global-set-key (kbd "s-q") nil)
(global-set-key (kbd "s-w") nil)

;; buffer list & cycling
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x C-o") 'swap-windows)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;; rename and delete buffers & files
(global-set-key (kbd "C-c r") 'rename-buffer-and-file)
(global-set-key (kbd "C-c d") 'delete-buffer-and-file)

;; marking & killing
(global-set-key (kbd "M-o") 'mark-whole-word)
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-x C-k") 'kill-region)
(global-set-key (kbd "C-c C-k") 'kill-region)

;; editing
(global-set-key (kbd "C-r") 'query-replace-regexp)
(global-set-key (kbd "C-|") 'string-insert-rectangle)
(global-set-key (kbd "C-S-d") 'duplicate-current-line)
(global-set-key (kbd "M-Q") 'unfill-paragraph)

;; tools
(global-set-key (kbd "M-i") 'imenu)
(global-set-key (kbd "M-n") 'flymake-goto-next-error)
(global-set-key (kbd "C-c g") 'magit-status)
(global-set-key (kbd "C-c b") 'magit-blame-addition)
(global-set-key (kbd "C-c \\") 'smart-shell-command)
(global-set-key (kbd "C-c a") 'org-agenda)

;; input
(define-key input-decode-map [?\s-2] [?€])

(provide 'keys)
