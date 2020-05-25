;; Org-mode settings
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-font-lock-mode 1)
(setq org-log-done t)
(setq org-todo-keyword-faces
      '(("IN-PROGRESS" . "yellow")("WAITING" . "orange")("UPCOMING" . "deep sky blue")))
(setq org-todo-keywords
      '((sequence "TODO" "IN-PROGRESS" "WAITING" "UPCOMING" "DONE")))
(setq org-default-notes-file "~/org-files/todo.org"
      initial-buffer-choice org-default-notes-file)
(org-babel-do-load-languages
  'org-babel-load-languages
   '((ditaa . t))) ;; this line activates ditaa

(provide 'lang-org)
