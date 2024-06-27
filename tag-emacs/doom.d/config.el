;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
;; (setq user-full-name "David Pätzel"
;;       user-mail-address "david.paetzel@posteo.de")


;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font "Inconsolata-14")
(setq doom-font (font-spec :family "Fira Code Nerd Font" :size 16 :style "Retina"))


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-solarized-dark)


;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.


;; Fish (and possibly other non-POSIX shells) is known to inject garbage
;;   output into some of the child processes that Emacs spawns. Many Emacs
;;   packages/utilities will choke on this output, causing unpredictable
;;   issues. To get around this, either:
;;
;;     - Add the following to $DOOMDIR/config.el:
(setq shell-file-name (executable-find "bash"))


(load "server")
(unless (server-running-p) (server-start))


(setq doom-localleader-key ",")


(setq shell-file-name "/bin/sh")


(defun alternate-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer)))


(map!
 :leader "w/" #'evil-window-vsplit
 :leader "w-" #'evil-window-split
 :leader :desc "Save all open files" "fS" #'evil-write-all
 :leader :desc "Mark buffer as done and close" "fq" #'server-edit
 :leader "TAB" #'alternate-buffer
 :leader "/" #'+default/search-project
 )

(defun spacemacs/alternate-window ()
  "Switch back and forth between current and last window in the
current frame."
  (interactive)
  (let (;; switch to first window previously shown in this frame
        (prev-window (get-mru-window nil t t)))
    ;; Check window was not found successfully
    (unless prev-window (user-error "Last window not found."))
    (select-window prev-window)))

(map!
 :nv "j" #'next-line
 :nv "k" #'previous-line)


(setq-default
   whitespace-style '(face trailing tabs))


(add-hook 'focus-out-hook (lambda () (evil-write-all nil)))


;; Fix not being able to input accented letters such as è.
(require 'iso-transl)


;; package-specific settings


(use-package! avy)
(map! :leader "j" 'evil-avy-goto-char :after avy)


(use-package! evil-surround)
(map! :map evil-surround-mode-map :v "s" 'evil-embrace-evil-surround-region)
(setq-default
 evil-surround-pairs-alist
 (append
  evil-surround-pairs-alist
  '((?„ . ("„" . "“"))
    (?“ . ("“" . "”"))
    (?‚ . ("‚" . "‘"))
    (?‘ . ("‘" . "’"))))
 ;; in order for evil-surround to work, I also have to instruct evil-embrace to
 ;; pass these keys through
 evil-embrace-evil-surround-keys
 (append
  evil-embrace-evil-surround-keys
  '(?„
    ?“
    ?‚
    ?‘)))


(use-package! yapfify
  ;; :hook
  ;; (python-mode . yapf-mode)
  ;; (before-save . (lambda ()
  ;;                  (when (eq major-mode 'python-mode)
  ;;                    (yapfify-buffer))))
  )
(use-package! python-black
  :demand t
  :after python
  :config
  (add-hook! 'python-mode-hook #'python-black-on-save-mode)
  ;; Feel free to throw your own personal keybindings here
  (map! :leader :desc "Blacken Buffer" "m b b" #'python-black-buffer)
  (map! :leader :desc "Blacken Region" "m b r" #'python-black-region)
  (map! :leader :desc "Blacken Statement" "m b s" #'python-black-statement)
)


;; Broken as of 2024-03-14 (hangs in iterations)
;;
;; (require 'julia-formatter)
;; (add-hook 'julia-mode-hook #'julia-formatter-mode)
;;
;; Custom.
(defun run-formatter-on-file ()
  "Run JuliaFormatter on the current file, handling TRAMP paths appropriately."
  (let* ((file-name (buffer-file-name))
         (formatter-path "~/5Code/JuliaFormatter.jl/compiled/bin/JuliaFormatter")
         (command (format "%s %s" formatter-path (shell-quote-argument file-name))))
    (if (file-remote-p file-name)
        (let* ((vec (tramp-dissect-file-name file-name))
               ;; (user (tramp-file-name-user vec))
               ;; (host (tramp-file-name-host vec))
               (localname (tramp-file-name-localname vec))
               (remote-command (format "%s %s" formatter-path (shell-quote-argument localname))))
          (message "Running remote command: %s" remote-command)
          (shell-command remote-command)
          (revert-buffer t t t)  ;; Revert buffer to reflect changes
          (message "Remote command executed and buffer reverted."))
      (progn
        (message "Running local command: %s" command)
        (shell-command command)
        (revert-buffer t t t)  ;; Revert buffer to reflect changes
        (message "Local command executed and buffer reverted.")))))

(defun add-juliaformatter-on-save-hook ()
  "Add a hook to run JuliaFormatter on save."
  (add-hook 'after-save-hook
            (lambda ()
              (when (string-match "\\.jl\\'" (buffer-file-name))
                (run-formatter-on-file)))
            nil t))  ; 't' makes the hook buffer-local, so it's only added for this specific mode
(add-hook 'julia-mode-hook 'add-juliaformatter-on-save-hook)
;; Local-only version I used before doing TRAMP stuff.
;; (defun add-juliaformatter-on-save-hook ()
;;   "Add a hook to run JuliaFormatter on save"
;;   (add-hook 'after-save-hook
;;             (lambda ()
;;               (when (string-match "\\.jl\\'" (buffer-file-name))
;;                 (let ((command (format "~/5Code/JuliaFormatter.jl/compiled/bin/JuliaFormatter %s" (shell-quote-argument (buffer-file-name)))))
;;                   (shell-command command))))
;;             nil t)) ; 't' makes the hook buffer-local, so it's only added for this specific mode
;; (add-hook 'julia-mode-hook 'add-juliaformatter-on-save-hook)



;; trying this out for Christoph, not sure whether it works
;; (use-package! flycheck-mypy)


(use-package! stan-mode)
(use-package! flycheck-stan)
(add-hook 'stan-mode-hook (lambda () (setq comment-start "//"
                                           comment-end   ""
                                           comment-continue "//")))


;; mode-specific settings


;; (setq-hook! python-mode
;;    pyimport-pyflakes-path "/home/david/.nix-profile/bin/pyflakes")


(setq-default
 flycheck-disabled-checkers '(haskell-stack-ghc
                              haskell-ghc
                              haskell-lint
                              python-flake8
                              python-pylint
                              python-pycompile
                              python-pyright
                              python-mypy
                              ))
(defun haskell-mode-ormolu-buffer ()
      (interactive)
      (save-buffer)
      (shell-command (concat "ormolu --mode inplace "
                              (buffer-file-name (current-buffer))))
      (kill-buffer "*Shell Command Output*")
      (revert-buffer nil 1))
(add-hook 'haskell-mode-hook
          (lambda ()
            (map!
             :map haskell-mode-map :localleader "F"  'haskell-mode-ormolu-buffer)))


(map!
 :map ledger-mode-map :localleader "F"  'ledger-mode-clean-buffer :after ledger)


;; I use neuron far more often than Markdown mode
(add-to-list 'auto-mode-alist '("\\.md\\'" . neuron-mode))
(add-hook! 'neuron-mode-hook
  (defun enable-auto-fill ()
    (auto-fill-mode 1)))


;; (setq-default 'truncate-lines t)


(load! "latex-config.el")


(load! "org-config.el")


;; from layers/+distributions/spacemacs-bootstrap/packages.el
;;  (spacemacs|define-transient-state paste
;;    :title "Pasting Transient State"
;;    :doc "\n[%s(length kill-ring-yank-pointer)/%s(length kill-ring)] \
;; [_C-j_/_C-k_] cycles through yanked text, [_p_/_P_] pastes the same text \
;; above or below. Anything else exits."
;;    :bindings
;;    ("C-j" evil-paste-pop)
;;    ("C-k" evil-paste-pop-next)
;;    ("p" evil-paste-after)
;;    ("P" evil-paste-before)
;;    ("0" spacemacs//transient-state-0))
;; (when dotspacemacs-enable-paste-transient-state
;;   (define-key evil-normal-state-map
;;     "p" 'spacemacs/paste-transient-state/evil-paste-after)
;;   (define-key evil-normal-state-map
;;     "P" 'spacemacs/paste-transient-state/evil-paste-before))


(defadvice! fix-exclude-agenda-buffers-from-recentf-advice (orig-fn file)
  :override #'+org--exclude-agenda-buffers-from-recentf-a
  (let ((recentf-exclude (list (lambda (_file) t)))
        find-file-hook)
    (funcall orig-fn file)))

(require 'f)
(defun open-file-with-timestamp-and-insert-filename ()
  "Open a file in the specified directory with a timestamp and insert its filename in double brackets [[ ]]."
  (interactive)
  (let* ((file-name (f-base (f-no-ext (buffer-file-name))))
         (timestamp (format-time-string "%Y%m%d_%H%M%S"))
         (new-file-name (concat "/home/david/Zettels/static/" timestamp "_" file-name)))
    (insert (concat "[[" (f-base new-file-name) "]] "))
    (find-file new-file-name)))



(defun insert-screenshot ()
  "Take a screenshot into a time-stamped unique-named file in the same directory
  as the current buffer and insert an embedding Obsidian link to this file.

  Taken from https://orgmode.org/worg/org-hacks.html#org1eba0c6 ."
  (interactive)
  (let* ((id
        (make-temp-name
         (concat
          (f-base (f-no-ext (buffer-file-name)))
          "_"
          (format-time-string "%Y%m%d_%H%M%S_")))
        )
        (filename
         (concat
          "/home/david/Zettels/static/"
          id
          ".png")))
      (call-process "import" nil nil nil filename)
      (insert (concat "![[" id ".png]]"))))


(defun insert-file ()
  "Copy a file to a time-stamped unique-named file in the same directory as
  the current buffer and insert an embedding Obsidian link to this file."
  (interactive)
  (let* ((file-name (f-base (f-no-ext (buffer-file-name))))
         (timestamp (format-time-string "%Y%m%d_%H%M%S"))
         (source-file-path (read-file-name "Select file to copy: "))
         (source-base-name (file-name-nondirectory source-file-path))
         (new-file-name (concat "/home/david/Zettels/static/" file-name "_" timestamp "_" source-base-name)))
    (copy-file source-file-path new-file-name t)
    (insert (concat "![[" (file-name-nondirectory new-file-name) "]] "))))


(defun archive-zettel ()
  "Archive the current Zettel.
  Maintains the subdirectory structure from the original path but replaces
  the root."
  (interactive)
  (let*
      ((file-name (buffer-file-name))
       (new-file-name
        (replace-regexp-in-string
         "Zettels/[^/]*/" "Zettels/4Archive/" file-name)))
    (make-directory (file-name-directory new-file-name) t)
    (rename-file file-name new-file-name)
    ;; Update buffer to point to the new file location.
    (set-visited-file-name new-file-name)
    (set-buffer-modified-p nil)
    (message (concat "Moved " file-name " to " new-file-name))))


(defun scrum-daily ()
  (interactive)
  (let ((file-path (concat "~/.todo/dailies/" (format-time-string "%Y-%m-%d") ".txt")))
    (find-file file-path)
    (unless (file-exists-p file-path)
      (insert "\n\nConcentration:\nProductivity:\nFun:\nStress:\nMood:\nHappiness:\n\nTime:\n")
      (save-buffer))))


(require 'org)
(defun scrum-tomorrow ()
  (interactive)
(let* ((current-date (current-time))
       (next-weekday (org-read-date nil nil nil "Next weekday"))
       (next-weekday-date (org-time-string-to-time next-weekday))
       (next-weekday-string (format-time-string "%Y-%m-%d" next-weekday-date)))
        (find-file (concat "~/.todo/CURRENTSPRINT/" next-weekday-string ".org"))))


(defun scrum-today ()
  (interactive)
  (let ((date (format-time-string "%Y-%m-%d")))
    (find-file (concat "~/.todo/CURRENTSPRINT/" date ".org"))))


(defun scrum-sprint ()
  (interactive)
  (find-file (concat "~/.todo/CURRENTSPRINT/Sprint.org")))


(defun scrum-retro ()
  (interactive)
  (find-file (concat "~/.todo/CURRENTSPRINT/Retrospective.md")))


;; (defun open-kanban ()
;;   "Open multiple files in side-by-side windows."
;;   (interactive)
;;   (delete-other-windows)  ;; Optional: Clear other windows if any
;;   (find-file "a.txt")  ;; Open a.txt in the first window
;;   (split-window-horizontally)  ;; Split the window into two
;;   (find-file "b.txt")  ;; Open b.txt in the new window
;;   (other-window 1)  ;; Switch to the first window
;;   (split-window-horizontally)  ;; Split the window into three
;;   (find-file "c.txt")  ;; Open c.txt in the new window
;;   (balance-windows))  ;; Optional: Balance the window sizes



;; Does not work yet.
;; (setq hs-special-modes-alist
;;       (append
;;        '((neuron-mode "{{{" "}}}"))
;;       hs-special-modes-alist)
;;  )


;; https://github.com/doomemacs/doomemacs/issues/581#issuecomment-895462086
(defun dlukes/ediff-doom-config (file)
  "ediff the current config with the examples in doom-emacs-dir

There are multiple config files, so FILE specifies which one to
diff.
"
  (interactive
    (list (read-file-name "Config file to diff: " doom-private-dir)))
  (let* ((stem (file-name-base file))
          (customized-file (format "%s.el" stem))
          (template-file-regex (format "^%s.example.el$" stem)))
    (ediff-files
      (concat doom-private-dir customized-file)
      (car (directory-files-recursively
             doom-emacs-dir
             template-file-regex
             nil
             (lambda (d) (not (string-prefix-p "." (file-name-nondirectory d)))))))))


(defun open-pdf-from-markdown-heading ()
  "Open the PDF file corresponding to the ID in the first markdown heading."
  (interactive)
  (save-excursion
    ;; Go to the beginning of the buffer
    (goto-char (point-min))
    ;; Search for the first heading
    (if (re-search-forward "^# \\([^:]+\\):" nil t)
        (let ((id (match-string 1)))
          ;; Construct the shell command
          (let ((command (concat "zathura ~/Literatur/" id "/*.pdf")))
            ;; Execute the shell command in the background
            (start-process "open-pdf" nil "sh" "-c" command)))
      (message "No valid heading found in the current buffer"))))


(map! :map neuron-mode-map :localleader :desc "Open associated literature" "b" #'open-pdf-from-markdown-heading)


(defun open-pdf-from-word ()
  "Open the PDF file corresponding to the word under the cursor."
  (interactive)
  (let* ((word (thing-at-point 'word t))
         (pdf-path (concat "~/Literatur/" word "/*.pdf")))
    (if (and word (file-expand-wildcards pdf-path))
          (let ((command (concat "zathura " pdf-path)))
            ;; Execute the shell command in the background
            (start-process "open-pdf" nil "sh" "-c" command))
      (message "No PDF found for the word under the cursor"))))

(map! :map neuron-mode-map :localleader :desc "Open literature under cursor" "B" #'open-pdf-from-word)
