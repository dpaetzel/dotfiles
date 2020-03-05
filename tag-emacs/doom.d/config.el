;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "David Pätzel"
      user-mail-address "david.paetzel@posteo.de")


;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font "Inconsolata-14")


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-one)


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


(setq doom-localleader-key ",")


(defun alternate-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer)))


(map!
 :leader "w/" #'evil-window-vsplit
 :leader "w-" #'evil-window-split
 :leader :desc "Save all open files" "fS" #'evil-write-all
 :leader :desc "Mark buffer as done and close" "fq" #'server-edit
 :leader "TAB" #'alternate-buffer)

(map!
 :nvm "j" #'next-line
 :nvm "k" #'previous-line)


(setq-default
   whitespace-style '(face trailing tabs))


(add-hook 'focus-out-hook (lambda () (evil-write-all nil)))


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
  :hook
  (python-mode . yapf-mode)
  (before-save . (lambda ()
                   (when (eq major-mode 'python-mode)
                     (yapfify-buffer)))))


;; mode-specific settings


(setq-default
  flycheck-disabled-checkers '(haskell-stack-ghc haskell-ghc haskell-lint))
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


(load! "latex-config.el")


(load! "org-config.el")
