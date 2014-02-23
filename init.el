(install-packs '(;; to code in common-lisp
                 ediff
                 hideshow))

(require 'hideshow)

;; common-lisp setup

;;(load (expand-file-name "~/repo/perso/dot-files/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "/usr/bin/sbcl")

;; add paredit mode to different lisp modes
(dolist (hook '(emacs-lisp-mode-hook
                clojure-mode-hook
                clojurescript-mode-hook
                lisp-mode-hook
                inferior-lisp-mode-hook))
  (add-hook hook (lambda () (paredit-mode +1))))

;; add paredit mode to different lisp modes

(dolist (hook '(emacs-lisp-mode-hook
                clojure-mode-hook
                clojurescript-mode-hook
                lisp-mode-hook
                inferior-lisp-mode-hook))
  (add-hook hook 'hs-minor-mode))

(setq slime-net-coding-system 'utf-8-unix)

;; checking parenthesis at save time
(add-hook 'after-save-hook 'check-parens nil t)

;; other bindings that uses personal functions
;; Load bindings config
(live-load-config-file "bindings.el")