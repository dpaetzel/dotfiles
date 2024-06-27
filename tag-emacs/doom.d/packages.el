;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; This is where you install packages, by declaring them with the `package!'
;; macro, then running 'doom refresh' on the command line. You'll need to
;; restart Emacs for your changes to take effect! Or at least, run M-x
;; `doom/reload'.
;;
;; WARNING: Don't disable core packages listed in ~/.emacs.d/core/packages.el.
;; Doom requires these, and disabling them may have terrible side effects.
;;
;; Here are a couple examples:


;; All of Doom's packages are pinned to a specific commit, and updated from
;; release to release. To un-pin all packages and live on the edge, do:
;(setq doom-pinned-packages nil)

;; ...but to unpin a single package:
;(package! pinned-package :pin nil)


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a particular repo, you'll need to specify
;; a `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, for whatever reason,
;; you can do so here with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))


(package! transient :pin "c2bdf7e12c530eb85476d3aef317eb2941ab9440")
(package! with-editor :pin "391e76a256aeec6b9e4cbd733088f30c677d965b")


(package! helm-nixos-options
  :recipe (:host github :repo "travisbhartwell/nix-emacs"))


(package! yapfify)


(package! python-black)


;; (package! julia-mode) ;; you probably already have this line
(package! julia-formatter
  :recipe (:host codeberg :repo "FelipeLema/julia-formatter.el"
           :files ( "julia-formatter.el" ;; main script executed by Emacs
                    "formatter_service.jl" ;; script executed by Julia
                    "Manifest.toml" "Project.toml" ;; project files
                    )))



;; (package! flycheck-mypy)

(package! anaconda-mode :disable t)
(package! conda :disable t)
(package! poetry :disable t)
(package! nose :disable t)
(package! python-pytest :disable t)
(package! pipenv :disable t)
(package! pyvenv-mode :disable t)


(package! stan-mode)
(package! flycheck-stan)


(package! gitmoji
  :recipe (:host github
           :repo "janusvm/emacs-gitmoji"
           :files ("*.el" "data")))


;; Seems to be required for gitmoji?
(package! emojify
  :recipe (:host github
           :repo "iqbalansari/emacs-emojify"
           :files ("*.el" "data")))
