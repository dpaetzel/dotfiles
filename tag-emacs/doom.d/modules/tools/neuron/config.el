;;; tools/neuron/config.el -*- lexical-binding: t; -*-

(setq
 neuron-default-zettelkasten-directory (expand-file-name "~/Zettels")
 )

(defun search-zettelkasten ()
  "Search zettels by content."
  (interactive)
  (progn
    (+ivy-file-search :in (neuron-zettelkasten) :recursive nil :prompt "Search Zettelkasten: ")
    (neuron-mode)))

(use-package! neuron-mode
  :config
  (map! :leader
        (:prefix ("z" . "zettel")
                 "z" #'neuron-new-zettel
                 "e" #'neuron-edit-zettel
                 ;; "s" #'neuron-select-zettelkasten
                 "w" #'neuron-rib-watch
                 "g" #'neuron-rib-generate
                 "o" #'neuron-open-zettel
                 "O" #'neuron-open-index
                 "r" #'neuron-refresh
                 
          ;;; Alternatively, bind all rib commands in a separate prefix
                 ;; (:prefix ("r" . "rib")
                 ;;   "w" #'neuron-rib-watch
                 ;;   "g" #'neuron-rib-generate
                 ;;   "s" #'neuron-rib-serve
                 ;;   "o" #'neuron-rib-open-zettel
                 ;;   "z" #'neuron-rib-open-z-index
                 ;;   "k" #'neuron-rib-kill
                 ;;   )
                 )
        )

  (map! :map neuron-mode-map
        :localleader
        ;; Override markdown-mode's default behavior
        :desc "Follow thing at point" "o" #'neuron-follow-thing-at-point
        ;; You can also remove the "z" prefix but
        ;; be careful not to override default
        ;; markdown-mode bindings.
        ;; (:prefix ("z" . "zettel")
        :desc "New Zettel" "z" #'neuron-new-zettel
        :desc "Edit Zettel" "e" #'neuron-edit-zettel
        :desc "Insert tag" "t" #'neuron-insert-tag
        :desc "Query tags" "T" #'neuron-query-tags
        :desc "Open current zettel" "o" #'neuron-open-current-zettel
        :desc "Link Zettel" "l" #'neuron-insert-zettel-link
        :desc "Link and create new Zettel" "L" #'neuron-insert-new-zettel
        :desc "Insert static link" "s" #'neuron-insert-static-link
                 ;; )
        )

  ;; (map! :leader :desc "Search Zettelkasten" "sz" #'search-zettelkasten)
  )
