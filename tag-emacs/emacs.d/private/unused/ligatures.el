;; NOTE I cut the following from dotspacemacs/user-config


  ;; ligature setup, from https://github.com/Profpatsch/dotfiles/blob/katara/spacemacs/.spacemacs
  (defun my-correct-symbol-bounds (pretty-alist)
    "Prepend a TAB character to each symbol in this alist, this way
compose-region called by prettify-symbols-mode will use the correct width of the
symbols instead of the width measured by char-width."
    (mapcar (lambda (el)
              (setcdr el (string ?\t (cdr el)))
              el)
            pretty-alist))

  (defun my-ligature-list (ligatures codepoint-start)
    "Create an alist of strings to replace with codepoints starting from
codepoint-start."
    (let ((codepoints (-iterate '1+ codepoint-start (length ligatures))))
      (-zip-pair ligatures codepoints)))

                                        ; list can be found at https://github.com/i-tu/Hasklig/blob/master/GlyphOrderAndAliasDB#L1588
  (setq my-hasklig-ligatures
        (let* ((ligs '("&&" "***" "*>" "\\\\" "||" "|>" "::"
                       "==" "===" "==>" "=>" "=<<" "!!" ">>"
                       ">>=" ">>>" ">>-" ">-" "->" "-<" "-<<"
                       "<*" "<*>" "<|" "<|>" "<$>" "<>" "<-"
                       "<<" "<<<" "<+>" ".." "..." "++" "+++"
                       "/=" ":::" ">=>" "->>" "<=>" "<=<" "<->")))
          (my-correct-symbol-bounds (my-ligature-list ligs #Xe100))))
  (setq my-fira-code-ligatures
        (let* ((ligs '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\"
                       "{-" "[]" "::" ":::" ":=" "!!" "!=" "!==" "-}"
                       "--" "---" "-->" "->" "->>" "-<" "-<<" "-~"
                       "#{" "#[" "##" "###" "####" "#(" "#?" "#_" "#_("
                       ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*"
                       "/**" "/=" "/==" "/>" "//" "///" "&&" "||" "||="
                       "|=" "|>" "^=" "$>" "++" "+++" "+>" "=:=" "=="
                       "===" "==>" "=>" "=>>" "<=" "=<<" "=/=" ">-" ">="
                       ">=>" ">>" ">>-" ">>=" ">>>" "<*" "<*>" "<|" "<|>"
                       "<$" "<$>" "<!--" "<-" "<--" "<->" "<+" "<+>" "<="
                       "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<" "<~"
                       "<~~" "</" "</>" "~@" "~-" "~=" "~>" "~~" "~~>" "%%"
                       "x" ":" "+" "+" "*")))
          (my-correct-symbol-bounds (my-ligature-list ligs #Xe100))))
  ;; (setq my-additional-ligatures '((" . " . (string ?\s #X2218 ?\s))))
  ;; (setq my-additional-ligatures '((" . " . (string " ∘ "))))
  ;; (setq my-additional-ligatures '((" . " . (?\s #X2218 ?\s))))
  ;; (setq my-additional-ligatures '((" . " . (string ?\s ?∘ ?\s))))
  ;; nice glyphs for haskell with hasklig
  (defun my-set-hasklig-ligatures ()
    "Add hasklig ligatures for use with prettify-symbols-mode."
    (setq prettify-symbols-alist
          (append my-hasklig-ligatures prettify-symbols-alist))
    (prettify-symbols-mode))
  (defun my-set-fira-code-ligatures ()
    "Add fira code ligatures for use with prettify-symbols-mode."
    (setq prettify-symbols-alist
          (append my-fira-code-ligatures prettify-symbols-alist))
    (prettify-symbols-mode))
  ;; (defun my-set-additional-ligatures ()
  ;;   "Add additional ligatures for use with prettify-symbols-mode."
  ;;   (setq prettify-symbols-alist
  ;;         (append my-additional-ligatures prettify-symbols-alist))
  ;;   (prettify-symbols-mode))
  ;; TODO not working currently b/c stuff gets replaced by wrong Inconsolata Nerd Font symbols
  ;; (add-hook 'haskell-mode-hook 'my-set-hasklig-ligatures)
  ;; (add-hook 'haskell-mode-hook 'my-set-additional-ligatures)


