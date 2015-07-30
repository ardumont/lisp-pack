;;; lisp-pack.el --- Some common setup between the multiple lisp runtime

;;; Commentary:

;;; Code:

(use-package ediff)
(use-package highlight)
(use-package eval-sexp-fu)
(use-package hideshow)
(use-package paredit)
(use-package fold-dwim)
(use-package smartscan)
(use-package clojure-mode)
(use-package lisp-mode)

;; common-lisp setup

;; Replace "sbcl" with the path to your implementation
;; (setq inferior-lisp-program "sbcl")

;; when using the git repository
;;(add-to-list 'load-path "~/repo/perso/dot-files/slime")
;; (require 'slime-autoloads)
;; (setq slime-net-coding-system 'utf-8-unix)

;; add paredit mode to different lisp modes
(dolist (hook '(emacs-lisp-mode-hook
                clojure-mode-hook
                lisp-mode-hook
                inferior-lisp-mode-hook))

  (add-hook hook
            (lambda ()
              (enable-paredit-mode)
              (hs-minor-mode)
              (local-set-key (kbd "C-c s t") 'fold-dwim-toggle)
              (local-set-key (kbd "C-c s h") 'fold-dwim-hide-all)
              (local-set-key (kbd "C-c s s") 'fold-dwim-show-all)
              (smartscan-mode 1))))

;; checking parenthesis at save time
(use-package files
  :config
  (add-hook 'after-save-hook 'check-parens nil t))

(use-package paredit
  :config
  (define-key paredit-mode-map (kbd "C-w") 'kill-region)
  (define-key paredit-mode-map (kbd "C-M-h") 'backward-kill-sexp)
  (define-key paredit-mode-map (kbd "M-s") 'paredit-splice-sexp)
  (define-key paredit-mode-map (kbd "M-S") 'paredit-split-sexp)
  (define-key paredit-mode-map (kbd "C-h") 'paredit-backward-delete)
  (define-key paredit-mode-map (kbd "M-?") nil)) ;; unset the help key

(provide 'lisp-pack)
;;; lisp-pack.el ends here
