;;; lisp-pack.el --- Some common setup between the multiple lisp runtime

;;; Commentary:

;;; Code:

(install-packs '(ediff
                 hideshow
                 paredit
                 fold-dwim
                 smartscan
                 clojure-mode
                 clojurescript-mode
                 highlight
                 eval-sexp-fu))

(require 'hideshow)
(require 'paredit)
(require 'fold-dwim)
(require 'smartscan)
(require 'clojure-mode)
(require 'clojurescript-mode)
(require 'eval-sexp-fu)

;; common-lisp setup

;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "/usr/bin/sbcl")

;; add paredit mode to different lisp modes
(dolist (hook '(emacs-lisp-mode-hook
                clojure-mode-hook
                clojurescript-mode-hook
                lisp-mode-hook
                inferior-lisp-mode-hook))

  (add-hook hook
            (lambda ()
              (enable-paredit-mode)
              (hs-minor-mode)
              (local-set-key (kbd "C-c s t") 'fold-dwim-toggle)
              (local-set-key (kbd "C-c s h") 'fold-dwim-hide-all)
              (local-set-key (kbd "C-c s s") 'fold-dwim-show-all)
              (define-key paredit-mode-map (kbd "M-?") nil) ;; unset the help key
              (smartscan-mode)
              (eval-sexp-fu-flash-mode))))

(setq slime-net-coding-system 'utf-8-unix)

;; checking parenthesis at save time
(add-hook 'after-save-hook 'check-parens nil t)

(eval-after-load 'paredit
  '(progn
    (define-key paredit-mode-map (kbd "C-w") 'kill-region)
    (define-key paredit-mode-map (kbd "C-M-h") 'backward-kill-sexp)
    (define-key paredit-mode-map (kbd "M-s") 'paredit-splice-sexp)
    (define-key paredit-mode-map (kbd "M-S") 'paredit-split-sexp)
    (define-key paredit-mode-map (kbd "C-h") 'paredit-backward-delete)
    (define-key paredit-mode-map (kbd "M-)") 'paredit-forward-slurp-sexp)
    (define-key paredit-mode-map (kbd "M-(") 'paredit-backward-slurp-sexp)))

;;; lisp-pack ends here
