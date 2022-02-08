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
;; (setq doom-font "Inconsolata-14")
(setq doom-font (font-spec :family "Fira Code Nerd Font" :size 18 :style "Retina"))


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


(load "server")
(unless (server-running-p) (server-start))


(setq doom-localleader-key ",")


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


;; trying this out for Christoph, not sure whether it works
(use-package! flycheck-mypy)


;; mode-specific settings


(setq-hook! python-mode
   pyimport-pyflakes-path "/home/david/.nix-profile/bin/pyflakes")


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
