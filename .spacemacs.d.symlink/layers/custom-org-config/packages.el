;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defvar custom-org-config-packages
  '(
    org-plus-contrib
    (org :location built-in)
    (org-ac :location built-in)
    cdlatex
    ;; package custom-org-configs go here
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar custom-org-config-excluded-packages '()
  "List of packages to exclude.")

;; For each package, define a function custom-org-config/init-<package-custom-org-config>
;;

(defun custom-org-config/post-init-org-plus-contrib ())

(defun custom-org-config/init-cdlatex())

(defun custom-org-config/init-org-ac()
  (use-package org-ac
    :defer t
    :config
    (progn
      (org-ac/config-default))))

(defun custom-org-config/pre-init-org ()
;;   "Initialize my package"
  (use-package org
    :defer t
    :commands (org-mode
               org-edit-src-exit
               org-agenda
               org-capture
               org-toggle-latex-fragment
               org-store-link
               org-agenda
               org-iswitchb
               org-clock-goto
               org-clock-in))

  (spacemacs|use-package-add-hook org

    :post-init
    (progn
      (spacemacs/set-leader-keys "m'" 'org-edit-src-exit)

      (spacemacs/set-leader-keys "oo" 'org-agenda)
      (spacemacs/set-leader-keys "oc" 'org-capture)
      (spacemacs/set-leader-keys "or" 'org-refile)
      (spacemacs/set-leader-keys "oi" 'org-iswitchb)

      (spacemacs/set-leader-keys "ols" 'org-store-link)
      (spacemacs/set-leader-keys "oli" 'org-insert-link)

      (spacemacs/set-leader-keys "odn" 'deft-new-file)
      (spacemacs/set-leader-keys "odN" 'deft-new-file-named)
      (spacemacs/set-leader-keys "odf" 'deft-find-file)
      (spacemacs/set-leader-keys "odd" 'deft-delete-file)
      (spacemacs/set-leader-keys "odr" 'deft-rename-file)
      (spacemacs/set-leader-keys "oda" 'deft-archive-file)
      (spacemacs/set-leader-keys "odg" 'deft-refresh)
      (spacemacs/set-leader-keys "odo" 'deft-open-file-other-window)

      (spacemacs/set-leader-keys "osa" 'org-toggle-archive-tag)

      (spacemacs/set-leader-keys "oTh" 'org-toggle-heading)

      (spacemacs/set-leader-keys "oar" 'org-agenda-clockreport-mode)
      (spacemacs/set-leader-keys "oas" 'org-agenda-sunrise-sunset)
      (spacemacs/set-leader-keys "oat" 'spacemacs/org-agenda-transient-state/body)
      (spacemacs/set-leader-keys "oak" 'org-agenda-show-clocking-issues)
      (spacemacs/set-leader-keys "oan" 'org-agenda-next-line)
      (spacemacs/set-leader-keys "oag" 'org-agenda-toggle-time-grid)
      (spacemacs/set-leader-keys "oafr" 'org-agenda-filter-remove-all)
      (spacemacs/set-leader-keys "oaft" 'org-agenda-filter-by-tag)

      ;; (spacemacs/set-leader-keys "oks" 'org-clock-in)
      (spacemacs/set-leader-keys "oki" 'org-clock-in)
      (spacemacs/set-leader-keys "oko" 'org-clock-out)
      (spacemacs/set-leader-keys "okc" 'org-clock-cancel)
      (spacemacs/set-leader-keys "oke" 'org-set-effort)
      (spacemacs/set-leader-keys "okg" 'org-clock-goto)
      (spacemacs/set-leader-keys "okr" 'org-clock-report)
      (spacemacs/set-leader-keys "okd" 'org-clock-mark-default-task)
      (spacemacs/set-leader-keys "okk" 'org-clock-display)

      (spacemacs/set-leader-keys "own" 'org-wiki-insert-new)
      (spacemacs/set-leader-keys "owh" 'org-wiki-helm)
      (spacemacs/set-leader-keys "owi" 'org-wiki-index)
      (spacemacs/set-leader-keys "ows" 'org-wiki-search)
      (spacemacs/set-leader-keys "owl" 'org-wiki-insert-link)
      (spacemacs/set-leader-keys "owr" 'org-wiki-switch-root)
      (spacemacs/set-leader-keys "owao" 'org-wiki-asset-open)
      (spacemacs/set-leader-keys "owai" 'org-wiki-asset-insert)

      (spacemacs/set-leader-keys-for-major-mode 'org-mode "C-l" 'org-toggle-latex-fragment))

    :post-config
    (progn

      (setq org-wiki-location-list '("~/ownCloud/org/wiki"
                                     "~/ownCloud/org/studies"))
      (setq org-wiki-location (car org-wiki-location-list))

      (setq org-journal-dir "~/ownCloud/org/journal/")
      (setq org-journal-file-format "%Y-%m")
      (setq org-journal-date-prefix "#+TITLE: ")
      (setq org-journal-date-format "%B %Y")
      (setq org-journal-time-format "%m-%d")

      ;; (add-hook 'org-agenda-mode-hook
      ;;           '(lambda () (org-defkey org-agenda-mode-map "R" 'org-agenda-refile))
      ;;           'append)

      (setq org-src-fontify-natively 1)
      (setq org-agenda-span 'day)
      (setq org-default-notes-file "~/ownCloud/org/refile.org")
      (setq org-directory "~/ownCloud/org")
      (setq org-agenda-files (list "~/ownCloud/org"
                                   "~/ownCloud/org/studies"))

      (setq org-agenda-persistent-filter t)

      (require 'ox-odt)
      (require 'ox-texinfo)
      (require 'ox-beamer)
      (require 'ox-html)
      (require 'ox-md)

      ;; If idle for more than 15 minutes, resolve the things by asking what to do
      ;; with the clock time
      ;; (setq org-clock-idle-time 15)

      ;; log into the LOGBOOK drawer. Also stores notes there.
      (setq org-log-into-drawer t)

      ;; any headline with level <= 2 is a target
      (setq org-refile-targets '((nil :maxlevel . 5)
                                      ; all top-level headlines in the
                                      ; current buffer are used (first) as a
                                      ; refile target
                                 (org-agenda-files :maxlevel . 5)))

      ;; provide refile targets as paths, including the file name
      ;; (without directory) as level 1 of the path
      (setq org-refile-use-outline-path 'file)

      ;; allow to create new nodes (must be confirmed by the user) as
      ;; refile targets
      (setq org-refile-allow-creating-parent-nodes 'confirm)

      ;; refile only within the current buffer
      (defun my/org-refile-within-current-buffer ()
        "Move the entry at point to another heading in the current buffer."
        (interactive)
        (let ((org-refile-targets '((nil :maxlevel . 5))))
          (org-refile)))

      ;; enable helm org refile into subsection of agenda file
      (setq org-outline-path-complete-in-steps nil)

      ;;(add-hook 'org-mode-hook 'turn-on-org-cdlatex)
      (add-hook 'org-mode-hook 'org-indent-mode)
      (add-hook 'org-mode-hook 'auto-fill-mode)

      (require 'ox-latex)
      (setq org-latex-listings 'minted)
      ;; setup minted to have frame, small text and line numbers
      (setq org-latex-minted-options
                 '(("frame" "lines")
                   ("fontsize" "\\scriptsize")
                   ("linenos" "")))

      ;; setup org-cdlatex minor mode
      (add-hook 'org-mode-hook 'turn-on-org-cdlatex)

      (setq org-latex-pdf-process (list
                                   "latexmk -pdflatex='%latex -shell-escape -interaction nonstopmode' -pdf -output-directory=%o %f"))

      (setq org-latex-with-hyperref nil)
      (setq org-latex-table-caption-above nil)
      (setq org-html-table-caption-above nil)

      ;; remove "inputenc" from default packages as it clashes with xelatex
      ;; (setf org-latex-default-packages-alist
      ;;       (remove '("AUTO" "inputenc" t) org-latex-default-packages-alist))

      ;; Set a nicer default style for the hyperref package
      ;; (setf org-latex-default-packages-alist
      ;;       (remove '("" "hyperref" nil) org-latex-default-packages-alist))

      ;; (add-to-list 'org-latex-default-packages-alist
      ;;              `("colorlinks=true, linkcolor=teal, urlcolor=teal, citecolor=darkgray, anchorcolor=teal", "hyperref" nil))

      ;; add fontspec package for utf8 characters with xelatex
      ;; (add-to-list 'org-latex-default-packages-alist
      ;;              `("", "fontspec" nil) t)

      (add-to-list 'org-latex-classes
        '("koma-article"
        "\\documentclass{scrartcl}"
        ("\\section{%s}" . "\\section*{%s}")
        ("\\subsection{%s}" . "\\subsection*{%s}")
        ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
        ("\\paragraph{%s}" . "\\paragraph*{%s}")
        ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

      (add-to-list 'org-latex-classes
        '("koma-report"
          "\\documentclass{scrreprt}"
          ("\\section{%s}" . "\\section*{%s}")
          ("\\subsection{%s}" . "\\subsection*{%s}")
          ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
          ("\\paragraph{%s}" . "\\paragraph*{%s}")
          ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

      (setq org-ditaa-jar-path "~/ownCloud/org/ditaa-0.11.jar")
      (setq org-plantuml-jar-path "~/ownCloud/org/plantuml.jar")

      (org-babel-do-load-languages
       'org-babel-load-languages
       '((python . t)
         (ditaa . t)
         (plantuml . t)
         ;; (sh . t)
         (dot . t)
         (ruby . t)
         (R . t)
         (gnuplot . t)
         (latex . t))
       )

      (setq org-confirm-babel-evaluate nil)

      (setq org-todo-keywords
            (quote ((sequence "TODO(t)" "DOING(o@/!)" "|" "DONE(d!)")
                    (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELED(c@/!)"))))

      ;; (setq org-todo-keyword-faces
      ;;       '(("TODO" . org-warning) ("STARTED" . "yellow")
      ;;         ("CANCELED" . (:foreground "blue" :weight bold))))

      ;; (setq org-enforce-todo-dependencies t)

      (setq org-use-fast-todo-selection t)
      ;; if state is changed using shift then no dates or notes are recorded

      (setq org-treat-S-cursor-todo-selection-as-state-change nil)
      ;; set tags according to state of the task

      (setq org-todo-state-tags-triggers
            (quote (("CANCELLED" ("DOING") ("CANCELLED" . t))
                    (done ("HOLD"))
                    ("TODO" ("CANCELLED") ("DOING") ("HOLD") )
                    ("DONE" ("CANCELLED") ("DOING") ("HOLD") )
                    ("DOING" ("DOING" . t))
                    ("HOLD" ("CANCELLED") ("DOING") ("HOLD" . t)))))

      (setq org-tags-exclude-from-inheritance '("PROJECT")
            org-stuck-projects '("+PROJECT/-DONE" ("TODO") ()))

      (setq org-agenda-diary-file "~/ownCloud/org/diary.org")

      ;; Diary
      (require 'holidays)
      (setq holiday-austria-holidays '((holiday-fixed  1  1 "Neujahr")
                                       (holiday-fixed  1  6 "Heilige Drei Könige")
                                       (holiday-easter-etc 1 "Ostermontag")
                                       (holiday-fixed  5  1 "Staatsfeiertag")
                                       (holiday-easter-etc 39 "Christi Himmelfahrt")
                                       (holiday-easter-etc 50 "Pfingstmontag")
                                       (holiday-easter-etc 60 "Fronleichnam")
                                       (holiday-fixed  8 15 "Mariä Himmelfahrt")
                                       (holiday-fixed 10 26 "Nationalfeiertag")
                                       (holiday-fixed 11  1 "Allerheiligen")
                                       (holiday-fixed 12  8 "Maria Empfängnis")
                                       (holiday-fixed 12 24 "Heilig Abend")
                                       (holiday-fixed 12 25 "Weihnachten")
                                       (holiday-fixed 12 26 "Stefanitag")))

      (setq holiday-local-holidays holiday-austria-holidays)
      (setq calendar-holidays (append holiday-local-holidays holiday-other-holidays))

      (setq org-capture-templates
            (quote (("t" "todo" entry (file "~/ownCloud/org/refile.org")
                     "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
                    ("n" "note" entry (file "~/ownCloud/org/refile.org")
                     "* %? :NOTE:\n%U\n%a\n")
                    ("h" "hsaf journal" entry (file+olp+datetree "~/ownCloud/org/hsaf.org" "Diary")
                     "* %?\n%U\n")
                    ("j" "journal" entry (file+olp+datetree "~/ownCloud/org/diary.org")
                     "* %?\n%U\n" :clock-in t :clock-resume t)
                    ("d" "all day journal" entry (file+olp+datetree "~/ownCloud/org/diary.org")
                     "* %?\n%t\n")
                    ("e" "event" entry (file "~/ownCloud/org/calender.org")
                     "* %^{Description}\n%^t\n%?")
                    ("m" "meeting" entry (file "~/ownCloud/org/refile.org")
                     "* %? :MEETING:\n%U" :clock-in t :clock-resume t)
                    ("p" "phone call" entry (file "~/ownCloud/org/refile.org")
                     "* %? :PHONE:\n%U" :clock-in t :clock-resume t)
                    ("a" "habit" entry (file "~/ownCloud/org/refile.org")
                     "* TODO %?\n%U\n%a\nSCHEDULED: %(format-time-string \"<%Y-%m-%d %a .+1d/3d>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: TODO\n:END:\n"))))

      ;; Do not dim blocked tasks
      (setq org-agenda-dim-blocked-tasks nil)

      ;; Compact the block agenda view
      (setq org-agenda-compact-blocks t)

      ; Enable habit tracking (and a bunch of other modules)
      (setq org-modules (quote (org-bbdb
                                org-bibtex
                                org-crypt
                                org-gnus
                                org-id
                                org-info
                                org-habit
                                org-inlinetask
                                org-irc
                                ;; org-mew
                                org-mhe
                                org-protocol
                                org-rmail
                                ;; org-vm
                                ;; org-wl
                                org-w3m)))

      (require 'org-habit)

      (setq org-show-entry-below (quote ((default))))

      ;; Limit restriction lock highlighting to the headline only
      (setq org-agenda-restriction-lock-highlight-subtree nil)

      ;; Always highlight the current agenda line
      (add-hook 'org-agenda-mode-hook
                '(lambda () (hl-line-mode 1))
                'append)

      ;; Keep tasks with dates on the global todo lists
      (setq org-agenda-todo-ignore-with-date nil)

      ;; Keep tasks with deadlines on the global todo lists
      (setq org-agenda-todo-ignore-deadlines nil)

      ;; Keep tasks with scheduled dates on the global todo lists
      (setq org-agenda-todo-ignore-scheduled nil)

      ;; Keep tasks with timestamps on the global todo lists
      (setq org-agenda-todo-ignore-timestamp nil)

      ;; Remove completed deadline tasks from the agenda view
      (setq org-agenda-skip-deadline-if-done t)

      ;; Remove completed scheduled tasks from the agenda view
      (setq org-agenda-skip-scheduled-if-done t)

      ;; Remove completed items from search results
      (setq org-agenda-skip-timestamp-if-done t)

      (setq org-archive-mark-done nil)
      (setq org-archive-location "%s_archive::* Archived Tasks")

      (setq org-agenda-start-with-log-mode '(closed clock state))

      ;; Priority settings: A, B, C, D
      (setq org-highest-priority ?A)
      (setq org-lowerst-priority ?D)
      (setq org-lowest-priority ?D)
      (setq org-default-priority ?D)

      ;; Switch entry to DONE when all subentries are done, to TODO otherwise.
      (defun org-summary-todo (n-done n-not-done)
        "Switch entry to DONE when all subentries are done, to TODO otherwise."
        (let (org-log-done org-log-states)   ; turn off logging
          (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

      (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

      (setq org-agenda-tags-todo-honor-ignore-options t)

      ;; Custom agenda command definitions
      (setq org-agenda-custom-commands
            (quote (("N" "Notes" tags "NOTE"
                     ((org-agenda-overriding-header "Notes")
                      (org-tags-match-list-sublevels t)))

                    ("d" "Upcoming deadlines"
                       ((agenda "")
                       ((org-agenda-time-grid nil)
                        (org-deadline-warning-days 365)
                        (org-agenda-entry-types '(:deadline))
                        )))

                    ("e" "Eisenhower matrix"
                     ((agenda "" nil)
                      (tags-todo "PRIORITY=\"A\""
                                ((org-agenda-overriding-header "Urgent and Important (kitchen fire)")
                                 (org-agenda-skip-function 'bh/skip-project-tasks)
                                  (org-agenda-sorting-strategy '(category-keep))))
                      (tags-todo "PRIORITY=\"B\""
                                ((org-agenda-overriding-header "Important (end data, personally)")
                                 (org-agenda-skip-function 'bh/skip-project-tasks)
                                  (org-agenda-sorting-strategy '(category-keep))))
                      (tags-todo "PRIORITY=\"C\""
                                 ((org-agenda-overriding-header "Urgent (interruptions, delegate)")
                                  (org-agenda-skip-function 'bh/skip-project-tasks)
                                  (org-agenda-sorting-strategy '(category-keep))))
                      (tags-todo "PRIORITY=\"D\""
                                 ((org-agenda-overriding-header "Time waster")
                                  (org-agenda-skip-function 'bh/skip-project-tasks)
                                  (org-agenda-sorting-strategy '(category-keep))))))

                    ("h" "Habits" tags-todo "STYLE=\"habit\""
                     ((org-agenda-overriding-header "Habits")
                      (org-agenda-sorting-strategy
                       '(todo-state-down effort-up category-keep))))

                    ("k" "Kanban agenda"
                     ((agenda "")
                      (tags "REFILE"
                            ((org-agenda-overriding-header "Tasks to Refile")
                            (org-tags-match-list-sublevels nil)))
                      (todo "TODO"
                              ((org-agenda-overriding-header "Todo")
                                (org-agenda-todo-list-sublevels nil)
                                (org-agenda-skip-function 'bh/skip-project-tasks)
                                (org-agenda-sorting-strategy '(priority-down))))
                      (todo "DOING"
                            ((org-agenda-overriding-header "Doing")
                              (org-agenda-todo-list-sublevels nil)
                              (org-agenda-sorting-strategy '(priority-down))))
                      (todo "WAITING"
                            ((org-agenda-overriding-header "Waiting")
                             (org-agenda-todo-list-sublevels nil)
                             (org-agenda-sorting-strategy '(priority-down))))
                      (todo "HOLD"
                            ((org-agenda-overriding-header "Hold")
                             (org-agenda-todo-list-sublevels nil)
                             (org-agenda-sorting-strategy '(priority-down))))
                    )))))

      (defun bh/skip-project-tasks ()
        "Show non-project tasks.
        Skip project and sub-project tasks, habits, and project related tasks."
        (save-restriction
          (widen)
          (let* ((subtree-end (save-excursion (org-end-of-subtree t))))
            (cond
             ((bh/is-project-subtree-p)
              subtree-end)
             (t
              nil)))))

      (defun bh/find-project-task ()
        "Move point to the parent (project) task if any"
        (save-restriction
          (widen)
          (let ((parent-task (save-excursion (org-back-to-heading 'invisible-ok) (point))))
            (while (org-up-heading-safe)
              (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
                (setq parent-task (point))))
            (goto-char parent-task)
            parent-task)))

      (defun bh/is-project-subtree-p ()
        "Any task with a todo keyword that is in a project subtree.
        Callers of this function already widen the buffer view."
        (let ((task (save-excursion (org-back-to-heading 'invisible-ok)
                                    (point))))
          (save-excursion
            (bh/find-project-task)
            (if (equal (point) task)
                nil
              t))))

      ;; Include agenda archive files when searching for things
      (setq org-agenda-text-search-extra-files (quote (agenda-archives)))

      ;; Show all future entries for repeating tasks
      (setq org-agenda-repeating-timestamp-show-all t)

      ;; Show all agenda dates - even if they are empty
      (setq org-agenda-show-all-dates t)

      ;; Sorting order for tasks on the agenda
      (setq org-agenda-sorting-strategy
            (quote ((agenda habit-down time-up user-defined-up effort-up category-keep)
                    (todo category-up effort-up)
                    (tags category-up effort-up)
                    (search category-up))))

      ;; Start the weekly agenda on Monday
      (setq org-agenda-start-on-weekday 1)

      ;; Enable display of the time grid so we can see the marker for the current time
      ;; (setq org-agenda-time-grid (quote ((daily today remove-match)
      ;;                                    #("----------------" 0 16 (org-heading t))
      ;;                                    (0900 1100 1300 1500 1700))))

      (setq org-agenda-time-grid '((daily today)
                                  (800 1000 1200 1400 1600 1800 2000)
                                  "......" "----------------"))

      ;; Display tags farther right
      (setq org-agenda-tags-column -102)

      ;; Use sticky agenda's so they persist
      (setq org-agenda-sticky t)

      ;; Resume clocking task when emacs is restarted
      (org-clock-persistence-insinuate)

      ;; Show lot of clocking history so it's easy to pick items off the C-F11 list
      (setq org-clock-history-length 23)

      ;; Resume clocking task on clock-in if the clock is open
      (setq org-clock-in-resume t)

      ;; Change tasks to NEXT when clocking in
      ;; (setq org-clock-in-switch-to-state 'bh/clock-in-to-next)
      ;; (setq org-clock-in-switch-to-state "DOING")

      ;; Separate drawers for clocking and logs
      (setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))

      ;; Save clock data and state changes and notes in the LOGBOOK drawer
      (setq org-clock-into-drawer t)

      ;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
      (setq org-clock-out-remove-zero-time-clocks t)

      ;; Clock out when moving task to a done state
      (setq org-clock-out-when-done t)

      ;; Save the running clock and all clock history when exiting Emacs, load it on startup
      (setq org-clock-persist t)

      ;; Do not prompt to resume an active clock
      (setq org-clock-persist-query-resume nil)

      ;; Enable auto clock resolution for finding open clocks
      (setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))

      ;; Include current clocking task in clock reports
      (setq org-clock-report-include-clocking-task t)

      (require 'org-id)

      (setq org-time-stamp-rounding-minutes (quote (1 1)))

      (setq org-agenda-clock-consistency-checks
            (quote (:max-duration "4:00"
                    :min-duration 0
                    :max-gap 0
                    :gap-ok-around ("4:00"))))

      ;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
      (setq org-clock-out-remove-zero-time-clocks t)

      ;; Agenda clock report parameters
      (setq org-agenda-clockreport-parameter-plist
            (quote (:link t :maxlevel 5 :fileskip0 t :compact t :narrow 80)))
    )))

;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
