;;; ~/.doom.d/org-config.el -*- lexical-binding: t; -*-


(setq-default
 org-agenda-files
 (cons "~/TODO.org" (append
                     (mapcar 'abbreviate-file-name
                             (split-string
                              (shell-command-to-string "find ~/Projekte -name \"*.org\"")
                              "\n"))
                     (mapcar 'abbreviate-file-name
                             (split-string
                              (shell-command-to-string "find ~/Literatur -name \"*.org\"")
                              "\n")))))


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


(after! org

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

   org-stuck-projects
   '("+TODO=\"PROJECT\"" ("NEXT" "WAIT" "1" "2" "3") nil "OK")

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
     ("OK")
     ":OK:")

   org-tag-alist
   '((:startgroup)
     ("Arbeit" . 97)
     ("daheim" . 100)
     (:endgroup))

   org-todo-keywords
   '((sequence "NEXT(n)" "TODO(t)" "PROJECT(p)" "WAIT(w)" "THEN(h)" "MAYBE(m)" "1(1)" "2(2)" "3(3)" "DONE(d!)")))

  (setq!

   org-agenda-skip-function-global
   '(org-agenda-skip-entry-if
     'todo
     '("THEN"))

   org-agenda-start-day "+0d"

   org-agenda-custom-commands
   '(("R" "wöchentliches Review"
      ((todo "WAIT"
             ((org-agenda-overriding-header "Warten auf")))
       (todo "NEXT|1|2|3"
             ((org-agenda-overriding-header "Next Actions")))
       (todo "TODO"
             ((org-agenda-overriding-header "andere TODOs (noch nicht als Next Action ausführbares etc.)")))
       (todo "THEN"
             ((org-agenda-overriding-header "TODOs, die von anderen abhängen")))
       (todo "MAYBE"
             ((org-agenda-overriding-header "Vielleicht/Eines Tages")))
       (todo "PROJECT"
             ((org-agenda-overriding-header "Projekte")))
       (stuck ""
              ((org-agenda-overriding-header "Projekte ohne NEXT oder WAIT")))
       (todo "DONE"
             ((org-agenda-overriding-header "Erledigtes"))))
      nil  ;; settings
      nil) ;; files to write agenda to

     ("p" "Projekte (Arbeit)"
      ((tags-todo "+TODO=\"PROJECT\"-daheim" nil)
       (tags-todo "+TODO=\"PROJECT\"+daheim" nil))
      ((org-agenda-start-day "+0d"))
      nil) ;; files to write agenda to

     ("w" "Mein Workflow"
      tags
      "+Promotion"
      ((org-agenda-start-day "+0d")
       (org-agenda-skip-function
        '(org-agenda-skip-entry-if
          'notscheduled)))
      nil) ;; files to write agenda to

     ("N" "Alle Next Actions"
      tags-todo
      "+TODO=\"NEXT\"-lesen|TODO=\"1\"|TODO=\"2\"|TODO=\"3\""
      ((org-agenda-start-day "+0d"))
      nil) ;; files to write agenda to

     ("n" "Alle Next Actions (Arbeit)"
      tags-todo
      "+TODO=\"NEXT\"-lesen-daheim|TODO=\"1\"|TODO=\"2\"|TODO=\"3\""
      ((org-agenda-start-day "+0d"))
      nil) ;; files to write agenda to

     ("A" "Agenda (Arbeit)"
      ((agenda ""
               ((org-agenda-overriding-header "Arbeit")
                (org-agenda-span
                 'day)
                (org-agenda-skip-function
                 '(org-agenda-skip-subtree-if
                   'regexp
                   ":daheim:"))))
       (agenda ""
               ((org-agenda-overriding-header "daheim")
                (org-agenda-span
                 'day)
                (org-agenda-skip-function
                 '(org-agenda-skip-subtree-if
                   'notregexp
                   ":daheim:")))))
      ;; nil
      ((org-agenda-start-day "+0d"))
      nil) ;; files to write agenda to

     ("y" "Theory"
      tags
      "+theory-notes"
      ((org-agenda-start-day "+0d"))
      nil) ;; files to write agenda to

     ("l" "zu lesende Paper"
      ((todo "1" nil)
       (todo "2" nil)
       (todo "3" nil))
      ((org-agenda-start-day "+0d"))
      nil)))) ;; files to write agenda to
