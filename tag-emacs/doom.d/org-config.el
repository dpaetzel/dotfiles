;;; ~/.doom.d/org-config.el -*- lexical-binding: t; -*-
   

;; NOTE Not working yet.
(defun org-workday (m1 d1 y1 m2 d2 y2)
  (let* ((date1 (calendar-absolute-from-gregorian (list m1 d1 y1)))
         (date2 (calendar-absolute-from-gregorian (list m2 d2 y2)))
         (d (calendar-absolute-from-gregorian date))
         (h (when skip-weeks (calendar-check-holidays date))))
    (and
     (<= date1 d)
     (<= d date2)
     (member (calendar-day-of-week date) '(1 2 3 4 5))
     entry)))


(after! org
  (setq!
   org-agenda-dim-blocked-tasks nil

   org-agenda-files
   (cons "~/TODO.org" (cons "~/.todo/Workflow.org" (append (butlast
                               (mapcar 'abbreviate-file-name
                                       (split-string
                                        (shell-command-to-string "find ~/1Projekte -maxdepth 2 -name \"TODO.org\"")
                                        "\n")))
                              ;; I don't use org files in ~/Literatur any more.
                              ;; (butlast
                              ;; (mapcar 'abbreviate-file-name
                              ;;         (split-string
                              ;;          (shell-command-to-string "find ~/Literatur -maxdepth 2 -name \"*.org\"")
                              ;;          "\n")))
                              )))

   org-agenda-inhibit-startup t

   ;; org-agenda-skip-function-global
   ;; '(org-agenda-skip-entry-if
   ;;   'todo
   ;;   '("THEN"))

   org-agenda-start-day "+0d"

   org-agenda-custom-commands
   ;; TODO Go over this
   `(("R" "wöchentliches Review"
      ((tags-todo "-wait/WAIT"
                  ((org-agenda-overriding-header "Warten auf")))
       (tags-todo "-wait/NEXT|1|2|3"
                  ((org-agenda-overriding-header "Next Actions")))
       (tags-todo "-wait/TODO"
                  ((org-agenda-overriding-header "andere TODOs (noch nicht als Next Action ausführbares etc.)")))
       (tags-todo "+wait/NEXT|TODO|1|2|3"
                  ((org-agenda-overriding-header "TODOs, die von anderen abhängen")))
       (todo "MAYBE"
             ((org-agenda-overriding-header "Vielleicht/Eines Tages")))
       (tags-todo "-wait/PROJECT"
                  ((org-agenda-overriding-header "Projekte")))
       (tags-todo "+wait/PROJECT"
                  ((org-agenda-overriding-header "Projekte, die von anderen abhängen")))
       (stuck ""
              ((org-agenda-overriding-header "Projekte ohne NEXT oder WAIT")))
       (todo "DONE"
             ((org-agenda-overriding-header "Erledigtes"))))
      nil  ;; settings
      nil) ;; files to write agenda to

     ;; TODO Go over this
     ("p" . "Projekte")
     ("pa" "Projekte (Arbeit)"
      ((tags-todo "+Arbeit-wait/PROJECT" nil)
       (tags-todo "-Arbeit-wait/PROJECT" nil))
      nil ;; settings
      nil) ;; files to write agenda to
     ("pp" "Projekte (nicht Arbeit)"
      ((tags-todo "-Arbeit-wait/PROJECT" nil)
       nil ;; settings
       nil)) ;; files to write agenda to

     ("n" . "Next Actions")
     ("na" "Next Actions (Arbeit)"
      ((tags-todo "+Arbeit-wait/NEXT|1|2|3" nil)
       (tags-todo "-Arbeit-wait/NEXT" nil))
      nil ;; settings
      nil) ;; files to write agenda to
     ("np" "Next Actions (nicht Arbeit)"
      ((tags-todo "-Arbeit-wait/NEXT" nil))
      nil ;; settings
      nil) ;; files to write agenda to

     ("w" . "Workflow")
     ("ww" "Week"
      agenda
      ""
      ((org-agenda-start-on-weekday 1)
       (org-agenda-span 'week)
       (org-agenda-tag-filter-preset '("+Arbeit"))
       ;; This is computed too early; i.e. I have to go `gr' once in order to
       ;; update it to the actual value.
       ;; (org-agenda-overriding-header
       ;;  'my/org-agenda-efforts-noninteractive)
        ;; (concat "Total estimated effort: " (my/org-agenda-calculate-efforts) "\n"))
       )
      nil)
     ("wt" "Today"
      agenda
      ""
      ((org-agenda-start-day "+0d")
       (org-agenda-span 'day)
       (org-deadline-warning-days 0)
       (org-agenda-skip-function
        '(org-agenda-skip-entry-if 'notscheduled))
       (org-agenda-tag-filter-preset '("+Arbeit"))
       ;; This is computed too early; i.e. I have to go `gr' once in order to
       ;; update it to the actual value.
       ;; (org-agenda-overriding-header
       ;;  'my/org-agenda-efforts-noninteractive)
        ;; (concat "Total estimated effort: " (my/org-agenda-calculate-efforts) "\n"))
       )
      nil) ;; files to write agenda to
     ("wo" "Tomorrow"
      agenda
      ""
      ((org-agenda-start-day (org-read-date))
       (org-agenda-span 'day)
       (org-deadline-warning-days 0)
       (org-agenda-skip-function
        '(org-agenda-skip-entry-if 'notscheduled))
       (org-agenda-tag-filter-preset '("+Arbeit"))
       ;; This is computed too early; i.e. I have to go `gr' once in order to
       ;; update it to the actual value.
       ;; (org-agenda-overriding-header
       ;;  'my/org-agenda-efforts-noninteractive)
        ;; (concat "Total estimated effort: " (my/org-agenda-calculate-efforts) "\n"))
       )
      nil)
     ("ws" "Sprint"
      tags
      "+Sprint+Arbeit/!-DONE"
      ;; This is computed too early; i.e. I have to go `gr' once in order to
      ;; update it to the actual value.
      ;; (
       ;; (org-agenda-overriding-header
       ;;  'my/org-agenda-efforts-noninteractive)
        ;; (concat "Total estimated effort: " (my/org-agenda-calculate-efforts) "\n")))
        ;; )
      nil
      nil)
     ("wp" "Sprint"
      tags
      "+Sprint+Arbeit"
      ;; This is computed too early; i.e. I have to go `gr' once in order to
      ;; update it to the actual value.
      ;; (
       ;; (org-agenda-overriding-header
       ;;  'my/org-agenda-efforts-noninteractive)
        ;; (concat "Total estimated effort: " (my/org-agenda-calculate-efforts) "\n")))
        ;; )
      nil
      nil)
     ;; TODO Consider to use refile (i.e. for maybe/someday stuff or something
     ;; like that, or even to manage sprint)
     ;; TODO Add a command to add at once stuff to the current sprint and the current day
     ;; TODO Also add a deadline heading in this daily view
     ;; TODO Write a command to store each day's agenda at the start and end of the day
     ;; TODO Write an end of day command that starts my epilogue (daily, agenda
     ;; storing, maybe compute a few nice stats, drop me to where I'll do
     ;; tomorrow's agenda etc.)
     )
   org-clock-persist 'history

   org-agenda-sorting-strategy
   '((agenda todo-state-up priority-down)
     (todo priority-down category-keep)
     (tags priority-down category-keep)
     (search category-keep))

   org-agenda-prefix-format
   '((agenda . " %i %-20:c%?-12t%-6e% s")
     (todo . " %i %-20:c %-6e %12s")
     (tags . " %i %-20:c %-6e %12s")
     (search . " %i %-20:c %-6e"))

   )

  (require 'cl-lib)

  (defun sumefforts ()
    (interactive)
    (shell-command-on-region (point-min) (point-max) "awk 'NR > 2 && $3 !~ /DONE/ { sum += $2 } END { print \"Sum of the second column:\", sum; print \"Sum divided by 60:\", sum / 60 }'"))

  (add-hook 'org-agenda-finalize-hook 'sumefforts)

  ;; Loosely based on https://emacs.stackexchange.com/a/38500 . Not working any
  ;; more as of 2023-10-23.
  (defun my/org-agenda-calculate-efforts ()
    "Sum the efforts of all agenda entries."
    (interactive)
    (let (total)
      (save-excursion
        (goto-char (point-min))
        (while (< (forward-line) 1)
            (push (org-entry-get (org-get-at-bol 'org-hd-marker) "Effort") total)
          ))
      (org-duration-from-minutes
       (cl-reduce #'+
                  (mapcar #'org-duration-to-minutes
                          (cl-remove-if-not 'identity total))))))


  ;; This is too late, sadly.
  ;; (defun my/org-agenda-efforts ()
  ;;   (setq org-agenda-overriding-header (concat "Totalez estimated effort: " (my/org-agenda-calculate-efforts) "\n")))

  ;; This breaks things.
  ;; (defun my/org-agenda-efforts ()
  ;;   "Insert a string at the end of the current buffer."
  ;;   (save-excursion
  ;;     (goto-char (point-max))
  ;;     (insert (concat "\n" "Total estimated effort: " (my/org-agenda-calculate-efforts) "\n"))))

  (defun my/org-agenda-efforts ()
    (interactive)
    (message (concat "Total estimated effort: " (my/org-agenda-calculate-efforts))))

  (defun my/org-agenda-efforts-noninteractive ()
    (concat "Total estimated effort: " (my/org-agenda-calculate-efforts) "\n"))

  ;; (add-hook 'org-agenda-finalize-hook 'my/org-agenda-efforts)


  (defun nextworkday ()
    "Rather rough approximation at what the next workday is for tomorrow's
    agenda default date."
    (setq workdays '(1 2 3 4 5)) ; Monday to Friday

    ;; Get the current date
    (setq day (calendar-current-date))

    ;; Incraese the current date by 1.
    (setq day (calendar-gregorian-from-absolute (1+ (calendar-absolute-from-gregorian day))))

    ;; Calculate the date for the next work day
    (while (not (member (calendar-day-of-week day) workdays))
      ;; (setq day (calendar-next-day day)))
      (setq day (calendar-gregorian-from-absolute (1+ (calendar-absolute-from-gregorian day)))))

    ;; Format the date as an Org timestamp
    (format-time-string "%Y-%m-%d" (encode-time 0 0 0 (cadr day) (car day) (caddr day)))
    )


  (setq-default

   org-startup-indented nil
   ;; org-agenda-skip-deadline-prewarning-if-scheduled 2
   org-agenda-skip-deadline-prewarning-if-scheduled nil
   org-agenda-skip-scheduled-if-deadline-is-shown 'not-today
   org-agenda-skip-scheduled-if-done nil
   org-agenda-tags-column -90
   org-bullets-bullet-list '("*")
   org-catch-invisible-edits 'error
   org-clock-in-switch-to-state "DOING"
   org-clock-out-switch-to-state "NEXT"
   org-columns-default-format "%TODO %3PRIORITY %Effort %ITEM %TAGS"
   org-hide-leading-stars t
   org-list-allow-alphabetical t
   org-log-into-drawer t
   org-pretty-entities t

   ;; TODO Include DOING here with another color that differs from NEXT
   org-todo-keyword-faces
   '(("TODO" :foreground "dim gray" :weight bold)
     ("WAIT" :foreground "dim gray" :weight bold)
     ("THEN" :foreground "dim gray" :weight bold)
     ("MAYBE" :foreground "dim gray" :weight bold))

   org-use-property-inheritance t

   org-file-apps
   '((auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default)
     ("\\.pdf\\'" . "zathura %s"))

   org-stuck-projects
   '("+TODO=\"PROJECT\""
     ("NEXT" "WAIT")
     ("OK" "wait")
     "")

   ;; TODO Rework this
   org-tag-alist
   '((:startgroup . nil)
     ("Arbeit" . ?a)
     (:endgroup . nil)
     (:startgroup . nil)
     ("Sprint" . ?s)
     (:endgroup . nil)
     (:startgroup . nil)
     ("@daheim" . ?d)
     ("@Lehrstuhl" . ?l)
     (:endgroup . nil)
     ("PC" . ?p)
     )

   org-todo-keywords
   '((sequence "NEXT(n)" "TODO(t)" "DOING(i)" "PROJECT(p)" "WAIT(w!)" "THEN(h!)" "MAYBE(m!)" "|"
      "DONE(d!)")))

  (org-clock-persistence-insinuate)
  )

(map! :map org-mode-map
      :n "C-RET" 'org-insert-heading :after org
      :n "C-S-RET" 'org-insert-todo-heading :after org
      :localleader
      "," 'org-ctrl-c-ctrl-c :after org
      "*" 'org-ctrl-c-star :after org
      "-" 'org-ctrl-c-minus :after org)
;; NOTE Stuff like this *should* work …
;; (:prefix ("i" . "insert")
;;   "l" 'org-insert-link :after org))




(add-hook! 'org-mode-hook
  (defun enable-auto-fill ()
    (auto-fill-mode 1)))
