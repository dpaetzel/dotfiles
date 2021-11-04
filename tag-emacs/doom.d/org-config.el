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
   (cons "~/TODO.org" (append (butlast
                               (mapcar 'abbreviate-file-name
                                       (split-string
                                        (shell-command-to-string "find ~/Projekte -name \"*.org\"")
                                        "\n")))
                              (butlast
                               (mapcar 'abbreviate-file-name
                                       (split-string
                                        (shell-command-to-string "find ~/Literatur -name \"*.org\"")
                                        "\n")))))

   org-agenda-inhibit-startup t

   org-agenda-skip-function-global
   '(org-agenda-skip-entry-if
     'todo
     '("THEN"))

   org-agenda-start-day "+0d"

   org-agenda-custom-commands
   '(("R" "wöchentliches Review"
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

     ;; ("w" "Mein Workflow"
     ;;  tags
     ;;  "+Promotion"
     ;;  ((org-agenda-start-day "+0d")
     ;;   (org-agenda-skip-function
     ;;    '(org-agenda-skip-entry-if
     ;;      'notscheduled)))
     ;;  nil) ;; files to write agenda to
     ))


  (setq-default

   org-startup-indented nil
   org-agenda-skip-deadline-prewarning-if-scheduled 2
   org-agenda-skip-scheduled-if-done t
   org-agenda-tags-column -90
   org-bullets-bullet-list '("*")
   org-catch-invisible-edits 'error
   org-hide-leading-stars t
   org-list-allow-alphabetical t
   org-log-into-drawer t
   org-pretty-entities t

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
     ("NEXT" "WAIT" "1" "2" "3")
     ("OK" "wait")
     "")

   org-tag-alist
   '((:startgroup . nil)
     ("Arbeit" . ?a)
     (:endgroup . nil)
     (:startgroup . nil)
     ("@daheim" . ?d)
     ("@Lehrstuhl" . ?l)
     (:endgroup . nil)
     ("PC" . ?p)
     )

   org-todo-keywords
   '((sequence "NEXT(n)" "TODO(t)" "PROJECT(p)" "WAIT(w)" "THEN(h)" "MAYBE(m)" "1(1)" "2(2)" "3(3)" "DONE(d!)")))

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
