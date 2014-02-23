(install-packs '(;; to code in common-lisp
                 ediff
                 hideshow
                 paredit
                 fold-dwim))

(require 'hideshow)
(require 'paredit)
(require 'fold-dwim)

;; common-lisp setup

;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "/usr/bin/sbcl")

;; add paredit mode to different lisp modes
(dolist (hook '(emacs-lisp-mode-hook
                clojure-mode-hook
                clojurescript-mode-hook
                lisp-mode-hook
                inferior-lisp-mode-hook))
  (add-hook hook 'enable-paredit-mode)
  (add-hook hook 'hs-minor-mode))

(setq slime-net-coding-system 'utf-8-unix)

;; checking parenthesis at save time
(add-hook 'after-save-hook 'check-parens nil t)

(eval-after-load 'paredit
  '(progn
    (define-key paredit-mode-map (kbd "C-w") 'kill-region)
    (define-key paredit-mode-map (kbd "M-s") 'paredit-splice-sexp)
    (define-key paredit-mode-map (kbd "M-S") 'paredit-split-sexp)))

(global-set-key (kbd "C-c s t") 'fold-dwim-toggle)
(global-set-key (kbd "C-c s h") 'fold-dwim-hide-all)
(global-set-key (kbd "C-c s s") 'fold-dwim-show-all)
