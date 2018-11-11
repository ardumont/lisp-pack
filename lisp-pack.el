;;; lisp-pack.el --- Some common setup between the multiple lisp runtime

;;; Commentary:

;;; Code:

;; internal libs
(require 'highlight)
(require 'hideshow)
(require 'paredit)
(require 'lisp-mode)
(require 'files)

;; external
(require 'eval-sexp-fu)
(require 'fold-dwim)

;; Add multiple modes to lispy modes
(dolist (fn '(enable-paredit-mode
	      hs-minor-mode  ;; hideshow
	      (lambda ()
		(local-set-key (kbd "C-c s t") 'fold-dwim-toggle)
		(local-set-key (kbd "C-c s h") 'fold-dwim-hide-all)
		(local-set-key (kbd "C-c s s") 'fold-dwim-show-all))))
  (dolist (lisp-hook '(emacs-lisp-mode-hook
		       lisp-mode-hook
		       inferior-lisp-mode-hook))
    (add-hook lisp-hook fn)))

;; checking parenthesis at save time
(add-hook 'after-save-hook 'check-parens nil t)

(define-key paredit-mode-map (kbd "C-w") 'kill-region)
(define-key paredit-mode-map (kbd "C-M-h") 'backward-kill-sexp)
(define-key paredit-mode-map (kbd "M-s") 'paredit-splice-sexp)
(define-key paredit-mode-map (kbd "M-S") 'paredit-split-sexp)
(define-key paredit-mode-map (kbd "C-h") 'paredit-backward-delete)
(define-key paredit-mode-map (kbd "M-?") nil) ;; unset the help key

(provide 'lisp-pack)
;;; lisp-pack.el ends here
