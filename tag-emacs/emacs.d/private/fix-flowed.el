;; TODO: not sure where I got this file---I did NOT write it myself!
;;   "^--$"
(defun fix-flowed ()
  "Reformat comments in a format=flowed fashion"
  (interactive)
  (save-excursion
    (beginning-of-buffer)
    ;; " add spaces on the end of every line
    ;; silent! %s/\v([^]> :])\ze\n\>[> ]*[^> ]/\1 /ge
    (save-excursion
      (replace-regexp "\\([^]> :]\\)\\(\n>[> ]*[^>\n\t]\\)" "\\1 \\2"))
    ;; " remove extra space
    ;; silent! %s/\v +\ze\n[> ]*$//e
    (save-excursion
      (replace-regexp " +\\(\n[> ]*$\\)" "\\1"))
    ;; " only ONE space per line ending
    ;; silent! %s/\v {2,}$/ /e
    (save-excursion
      (replace-regexp "  +$" " "))
    ;; " fix > spacing from the text
    ;; silent! %s/\v^[> ]*\>\ze[^> ]/& /e
    (save-excursion
      (replace-regexp "^\\([> ]*>\\)\\([^> \n\t]\\)" "\\1 \\2"))
    ;; " compress multiple >
    ;; while search ('\v^\>+ \>', 'w') > 0
    ;;     silent! s/\v^\>+\zs \>/>/e
    ;; endwhile
    (while
        (save-excursion
          (re-search-forward "^\\(>+\\) +>" nil t))
      (save-excursion
        (replace-match "\\1>")))))
;; (defun asdf ()
;;   "asdf"
;;   (interactive)
;;   (save-excursion
;;     (replace-regexp "\\(On\\)" "ASDF \\1"))
;;   (save-excursion
;;     (replace-regexp "\\(ASDF\\)" "QWER \\1")))
