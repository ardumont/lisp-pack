;;; lisp-pack.el --- Some common setup between the multiple lisp runtime

;; Copyright (C) 2018  Antoine R. Dumont (@ardumont)
;; Author: Antoine R. Dumont (@ardumont) <antoine.romain.dumont@gmail.com>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; This file is NOT part of GNU Emacs.

;;; Commentary:

;;; Code:

;; internal libs
(require 'highlight)
(require 'hideshow)
(require 'paredit)
(require 'lisp-mode)
(require 'files)
(require 'paren)

;; external
(require 'eval-sexp-fu)
(require 'fold-dwim)

(define-key paredit-mode-map (kbd "C-w") 'kill-region)
(define-key paredit-mode-map (kbd "C-M-h") 'backward-kill-sexp)
(define-key paredit-mode-map (kbd "M-s") 'paredit-splice-sexp)
(define-key paredit-mode-map (kbd "M-S") 'paredit-split-sexp)
(define-key paredit-mode-map (kbd "C-h") 'paredit-backward-delete)
(define-key paredit-mode-map (kbd "M-?") nil) ;; unset the help key

;; Add multiple modes to lispy modes
(dolist (fn '(enable-paredit-mode
	      hs-minor-mode  ;; hideshow
	      show-paren-mode
	      (lambda ()
		(local-set-key (kbd "C-c s t") 'fold-dwim-toggle)
		(local-set-key (kbd "C-c s h") 'fold-dwim-hide-all)
		(local-set-key (kbd "C-c s s") 'fold-dwim-show-all))))
  (dolist (lisp-hook '(emacs-lisp-mode-hook
		       lisp-mode-hook
		       inferior-lisp-mode-hook))
    (add-hook lisp-hook fn)))

;; checking parenthesis at save time
(add-hook 'before-save-hook 'check-parens nil t)

(provide 'lisp-pack)
;;; lisp-pack.el ends here
