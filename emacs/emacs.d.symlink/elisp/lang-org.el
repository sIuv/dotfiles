;; Org-mode settings
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-font-lock-mode 1)
(setq org-use-fast-todo-selection t)
(setq org-log-done t)
(setq org-todo-keyword-faces
      '(("IN-PROGRESS" . "yellow")("WAITING" . "orange")("UPCOMING" . "deep sky blue")))
(setq org-todo-keywords
      '((sequence "TODO" "IN-PROGRESS" "WAITING" "UPCOMING" "DONE")))
(setq org-directory "~/Documents/org/")
(setq org-agenda-files (list "~/Documents/org/"))
(setq org-default-notes-file "~/Documents/org/general.org"
      initial-buffer-choice org-default-notes-file)
(org-babel-do-load-languages
  'org-babel-load-languages
   '((ditaa . t))) ;; this line activates ditaa


(defvar my/org-meeting-template "** Meeting about %^{something}
SCHEDULED: %(org-insert-time-stamp (org-read-date nil t nil))

*Attendees:*

- [X] Pontus Englund
- [ ] %?


*Agenda:*
-
-

*Notes:*


" "Meeting Template")


(defvar my/org-jenkins-template "** Jenkins check [/]
SCHEDULED: %(org-insert-time-stamp (org-read-date nil t nil))

- [ ] Job 1
- [ ] Job 2
- [ ] ...

" "Jenkins Template")


;; Configure custom capture templates
(setq org-capture-templates
      `(;; Note the backtick here, it's required so that the defvar based tempaltes will work!
        ;;http://comments.gmane.org/gmane.emacs.orgmode/106890

        ("t" "To-do" entry (file+headline "~/Documents/org/todo.org" "Todo")
         "** TODO %^{Task Description}\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t nil))\nCreated From: %a\n" :clock-in t :clock-resume t :prepend t)

        ("m" "Meeting" entry (file+headline "~/Documents/org/meeting_notes.org" "General")
         ,my/org-meeting-template)

	("j" "To-do Jenkins" entry (file+headline "~/Documents/org/todo.org" "Jenkins")
         ,my/org-jenkins-template)
))

(setq org-archive-location
    (concat "~/Documents/org/archive/"
        (format-time-string "%Y-%m" (current-time)) "-%s::* "(format-time-string "%Y-%m-%d" (current-time))))

(provide 'lang-org)
