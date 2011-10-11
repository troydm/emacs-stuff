;;; buffcycle.el --- Buffer cycling for Emacs

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

;;; Commentary:
;;; Simple Buffer cycling for Emacs between file buffers only using C-tab
;;; and killing buffer using C-q
;;; To use add 
;;; (require 'buffcycle) 
;;; to your .emacs

;; Buffer Cycling
(defvar *buffcycle-ibuffer-time* 0.5)
(defvar *buffcycle-last-time* (float-time))

(defun next-buffer-cycle()
  (interactive)
  (let ((cur-buffer (buffer-name))
	(time-diff 0.0))
    (progn (setq time-diff (- (float-time) *buffcycle-last-time*))
	   (if (>= *buffcycle-ibuffer-time* time-diff)
	       (progn (setq *buffcycle-last-time* (float-time))
		      (ibuffer)))
	   (next-buffer)
	   (while (and (booleanp (buffer-file-name)) (not (string= (buffer-name) cur-buffer)))
	     (next-buffer))
	   (setq *buffcycle-last-time* (float-time)) 
	   (if (string= cur-buffer (buffer-name))
	       (ibuffer)))))

(defun kill-this-buffer-if-not-scratch()
  (interactive)
  (if (window-dedicated-p (selected-window))
      (message "this is dedicated window")
  (if (not (string= (buffer-name) "*scratch*"))
      (kill-this-buffer)
    (message "this is scratch unkillable"))))

;; Buffer Cycling keybindings
(global-set-key (kbd "<C-tab>") 'next-buffer-cycle)
(global-set-key (kbd "C-q") 'kill-this-buffer-if-not-scratch)

(provide 'buffcycle)

