
;; Emacs Nav fix to open files only in right upper window
;; ---------------------------
;; |      |  Right           |
;; |  NAV |  Upper Window    |
;; |      |------------------|
;; |      |  Other | Another |
;; |--------------------------

(defun nav-open-file-other-window (filename)
  "Opens a file or directory from Nav."
  (interactive "FFilename:")
  (if (file-directory-p filename)
      (nav-push-dir filename)
    (let ((filebuffer (find-file-noselect filename)))
      (progn 
	(if (not (string= (buffer-name) nav-buffer-name))
	    (switch-to-buffer-other-window (get-buffer-create nav-buffer-name)))
	(condition-case err 
	    (windmove-right)(error))
	(condition-case err 
	    (loop (windmove-up))(error))
	(switch-to-buffer filebuffer)))))

(provide 'nav-open-fix)
