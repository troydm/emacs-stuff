;;; nav-open-fix.el --- Buffer cycling for Emacs

;; Copyright (C) 2011 Dmitry Geurkov

;; Author: Dmitry Geurkov <dmitry_627@mail.ru>

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; Emacs Nav fix to open files only in right upper window
;; ---------------------------
;; |      |  Right           |
;; |  NAV |  Upper Window    |
;; |      |------------------|
;; |      |  Other | Another |
;; |--------------------------
;; To use just add (require 'nav-open-fix) after (require 'nav) to your .emacs

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
	(condition-case err 
	    (switch-to-buffer-here filebuffer)(error (switch-to-buffer filebuffer)))))))

(provide 'nav-open-fix)
