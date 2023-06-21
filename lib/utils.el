;;; utils

(defun vc-refresh-all-buffers ()
  "Run vc-refresh-state on all buffers"
  (interactive)
  (dolist (b (buffer-list))
    (with-current-buffer b (vc-refresh-state))))

(defun rename-buffer-and-file ()
  "Rename the current buffer and the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (rename-buffer (read-from-minibuffer "New name: " (buffer-name)))
      (let ((new-name (read-file-name "New name: " filename)))
        (rename-file filename new-name t)
        (set-visited-file-name new-name t t)))))

(defun delete-buffer-and-file ()
  "Kill the current buffer and delete the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (when (y-or-n-p (format "Are you sure you want to delete %s? " filename))
        (delete-file filename)
        (message "Deleted file %s" filename)
        (kill-buffer)))))

(defun duplicate-current-line (&optional arg)
  "Duplicate the current line, optionally [arg] times."
  (interactive "p")
  (save-excursion
    (let ((n (or arg 1))
          (current-line (thing-at-point 'line)))
      (when (or (= 1 (forward-line 1)) (eq (point) (point-max)))
        (newline))
      (dotimes (_ n)
        (insert current-line)))))

(defun unfill-paragraph (&optional region)
  "Take a multi-line paragraph and make it into a single line of text."
  (interactive (progn (barf-if-buffer-read-only) '(t)))
  (let ((fill-column (point-max))
        (emacs-lisp-docstring-fill-column t))
    (fill-paragraph nil region)))

(defun swap-windows ()
  "Swaps windows, if there are only 2 of them."
  (interactive)
  (if (/= (count-windows) 2)
      (message "You need exactly 2 windows to do this.")
    (let* ((w1 (car (window-list)))
           (w2 (cadr (window-list)))
           (b1 (window-buffer w1))
           (b2 (window-buffer w2))
           (s1 (window-start w1))
           (s2 (window-start w2)))
      (set-window-buffer w1 b2)
      (set-window-buffer w2 b1)
      (set-window-start w1 s2)
      (set-window-start w2 s1)))
  (other-window 1))

(defun smart-shell-command (command arg)
  "Switch between `shell-command' and `shell-command-on-region', depending on region."
  (interactive (list (read-from-minibuffer "Shell command: " nil nil nil 'shell-command-history)
                     current-prefix-arg))
  (let ((p (if mark-active (region-beginning) 0))
        (m (if mark-active (region-end) 0)))
    (if (= p m)
        ;; No active region
        (if (eq arg nil)
            (shell-command command)
          (shell-command command t))
      ;; Active region
      (if (eq arg nil)
          (shell-command-on-region p m command)
        (shell-command-on-region p m command t t)))))

(defun mark-whole-word (&optional arg allow-extend)
  "Like `mark-word', but selects whole words and skips over whitespace.
if you use a negative prefix arg then select words backward.
otherwise select them forward.

If cursor starts in the middle of word then select that whole word.

If the command is repeated or the mark is active, select the next
NUM words, where NUM is the numeric prefix argument. (Negative
NUM selects backward.)"
  (interactive "P\np")
  (let ((num (prefix-numeric-value arg)))
    (unless (eq last-command this-command)
      (if (natnump num)
          (skip-syntax-forward "\\s-")
        (skip-syntax-backward "\\s-")))
    (unless (or (eq last-command this-command)
                (if (natnump num)
                    (looking-at "\\b")
                  (looking-back "\\b")))
      (if (natnump num)
          (left-word)
        (right-word)))
    (mark-word arg allow-extend)))

;; backported from emacs 29
(defmacro with-undo-amalgamate (&rest body)
  "Like `progn' but perform BODY with amalgamated undo barriers.

This allows multiple operations to be undone in a single step.
When undo is disabled this behaves like `progn'."
  (declare (indent 0) (debug t))
  (let ((handle (make-symbol "--change-group-handle--")))
    `(let ((,handle (prepare-change-group))
           ;; Don't truncate any undo data in the middle of this,
           ;; otherwise Emacs might truncate part of the resulting
           ;; undo step: we want to mimic the behavior we'd get if the
           ;; undo-boundaries were never added in the first place.
           (undo-outer-limit nil)
           (undo-limit most-positive-fixnum)
           (undo-strong-limit most-positive-fixnum))
       (unwind-protect
           (progn
             (activate-change-group ,handle)
             ,@body)
         (progn
           (accept-change-group ,handle)
           (undo-amalgamate-change-group ,handle))))))

(defun unsmarten ()
  "Replace smart quotes with ASCII ones."
  (interactive)
  (save-excursion
    (save-restriction
      (with-undo-amalgamate
        (let ((replace-char-fold t))
          (when (use-region-p) (narrow-to-region (region-beginning) (region-end)))
          (replace-string "\"" "\"" nil (point-min) (point-max))
          (replace-string "'" "'" nil (point-min) (point-max)))))))

(provide 'utils)
