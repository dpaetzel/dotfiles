(defun fix-flowed ()
  "Format the buffer as format=flowed message according to RFC 3676. This
ensures that appropriate lines should be terminated with a single space, and
that \"> \" quoting prefixes are replaced with \">\". Operates on the current
region if active, otherwise on the whole buffer."
  (interactive)
  (let ((start (if (use-region-p) (region-beginning) (point-min)))
        (end (if (use-region-p) (region-end) (point-max))))
    (save-excursion
      ;; remove all line ending spaces
      (goto-char start)
      (replace-regexp " +$" "")
      ;; collapse quote indicators (this is correct for most mails)
      (goto-char start)
      (while (and (goto-char start) (re-search-forward "^\\(>+\\) +\\(>+\\)" end t))
        (replace-match "\\1\\2" t))
      ;; I like to have one space after the quote indicators (but we need to be
      ;; careful not to suffix empty quote lines with a space)
      (goto-char start)
      (replace-regexp "^\\(>+\\) *\\([^\n]\\)" "\\1 \\2")
      ;; all non-empty lines should end with a space (the user has to indicate
      ;; paragraphs with empty lines; but again, empty quote lines must not be
      ;; suffixed with a space)
      (goto-char start)
      (replace-regexp "^\\(>+ \\)?\\([^>\n].*\\)$" "\\1\\2 ")
      ;; fix signature indicators
      (goto-char start)
      (replace-regexp "^\\(>+ ?\\)?-- *$" "\\1--")
      ;; fix signatures
      (goto-char start)
      (search-forward-regexp "^\\(>+ ?\\)?-- *$")
      (replace-regexp " +$" "")
      ;; collapse multiple spaces at line's end (not required!)
      ;; (goto-char start)
      ;; (while (re-search-forward " +$" end t)
      ;;   (replace-match " "))
      )))


;; https://github.com/aspiers/emacs/blob/23a22af991b35fcc7a96ac12847e1b8723d4c5c2/.emacs.d/init.d/as-editing.el#L29
(defun fix-flowed2646 ()
  "Format the buffer as flowed text according to RFC 2646. This ensures that
appropriate lines should be terminated with a single space, and that \"> \"
quoting prefixes are replaced with \">\". Operates on the current region if
active, otherwise on the whole buffer."
  (interactive)
  (let ((start (if (use-region-p) (region-beginning) (point-min)))
        (end (if (use-region-p) (region-end) (point-max))))
    (save-excursion
      (goto-char start)
      ;; Ensure appropriate lines end with a space
      (while (re-search-forward "^\\(>+ ?\\)?\\S-.*\\S-$" end t)
        (replace-match "\\& " t))

      ;; Replace "> " quoting prefixes with ">"
      (goto-char start)
      (let ((eol)
            (eolm (make-marker)))
        (while (setq eol (re-search-forward "^>.*" end t))
          (set-marker eolm eol)
          (goto-char (match-beginning 0))
          (while (looking-at ">")
            (if (looking-at "> ")
                (replace-match ">")
              (forward-char)))
          (goto-char (marker-position eolm)))))))
