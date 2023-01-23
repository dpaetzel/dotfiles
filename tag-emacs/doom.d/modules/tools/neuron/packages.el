;; -*- no-byte-compile: t; -*-
;;; tools/neuron/packages.el

;; (package! neuron-mode)
(package! neuron-mode
  :recipe (:local-repo "/home/david/Code/neuron-mode"

           ;; With this you can avoid having to run 'doom sync' every time you
           ;; change the package.
           :build (:not compile)))


;; For more reproducibility, pin the repo:
;; (package! neuron-mode :pin e1b3e12c71)
;; or run M-x doom/update-pinned-package-form to have the latest commit
