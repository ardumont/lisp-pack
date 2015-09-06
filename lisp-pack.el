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
(use-package slime)

;; common-lisp setup

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

(require 'cl-lib)
(require 'info)

;; Adapted from Dimitri Fontaine's, thanks dude!

(require 'slime)

(defvar *lisp-pack-quicklisp-home* (or (getenv "QUICKLISP_HOME") "~/quicklisp")
  "Quicklisp's home.")

(slime-setup '(slime-fancy slime-repl))

(-when-let (quicklisp-slime-helper-file (expand-file-name (format "%s/slime-helper.el" *lisp-pack-quicklisp-home*)))
  (when (file-exists-p quicklisp-slime-helper-file)
    (load quicklisp-slime-helper-file)))

(custom-set-variables '(slime-net-coding-system 'utf-8-unix))

;; http://common-lisp.net/project/slime/doc/html/Multiple-Lisps.html
;; (setq slime-lisp-implementations
;;       '((cmucl ("cmucl" "-quiet"))
;;         (sbcl ("/opt/sbcl/bin/sbcl") :coding-system utf-8-unix)))
;; (NAME (PROGRAM PROGRAM-ARGS...) &key CODING-SYSTEM INIT INIT-FUNCTION ENV)

(defun lisp-pack-lookup-lisp-binary (paths)
  "Lookup PATHS until one binary is found.
If none is found, the last one is used."
  (cl-loop for path in paths
           until (file-exists-p path)
           finally return path))

;; discover the installed lisp
(let* ((sbcl (lisp-pack-lookup-lisp-binary '("/usr/local/bin/sbcl"
                                             "/usr/bin/sbcl")))
       (ccl  (lisp-pack-lookup-lisp-binary '("/usr/local/bin/ccl64"
                                             "/usr/bin/ccl64")))
       (clisp (lisp-pack-lookup-lisp-binary '("/usr/local/bin/clisp"
                                              "/usr/bin/clisp")))
       (ecl   (lisp-pack-lookup-lisp-binary '("/usr/local/bin/ecl"
                                              "/usr/bin/ecl"))))

  (setq slime-lisp-implementations `((sbcl (,sbcl)             :coding-system utf-8-unix)
                                     (ccl  (,ccl "-K" "utf-8") :coding-system utf-8-unix)
                                     (clisp (,clisp)           :coding-system utf-8-unix)
                                     (ecl (,ecl)               :coding-system utf-8-unix))
        slime-default-lisp 'sbcl
        inferior-lisp-program (caar (assoc-default 'sbcl slime-lisp-implementations))))

;; add path to documentation
;; (cl-loop for p in '("~/dev/CL/dpans2texi-1.05"
;;                     "~/dev/CL/cl-yacc"
;;                     "~/dev/CL/asdf/doc")
;;          do (add-to-list 'Info-directory-list p))

(defun lisp-pack-slime-new-repl (&optional new-port)
  "Create additional REPL for the current Lisp connection.
NEW-PORT is optionally the port to change."
  (interactive)
  (if (slime-current-connection)
      (let ((port (or new-port (slime-connection-port (slime-connection)))))
        (slime-eval `(swank:create-server :port ,port))
        (slime-connect slime-lisp-host port))
    (error "Not connected")))

;;
;; Fix some SLIME indentation shortcomings.
;;
(put 'handling-pgsql-notices 'common-lisp-indent-function
     (get 'unwind-protect 'common-lisp-indent-function))
(put 'task-handler-bind 'common-lisp-indent-function
     (get 'let 'common-lisp-indent-function))
(put 'bind 'common-lisp-indent-function
     (get 'let 'common-lisp-indent-function))
(put 'register-groups-bind 'common-lisp-indent-function 2)
(put 'with-prefixed-accessors 'common-lisp-indent-function 2)
(put 'with-pgsql-connection 'common-lisp-indent-function 1)
(put 'with-stats-collection 'common-lisp-indent-function 2)

;;
;; Fix some weird bug
;;
(eldoc-add-command 'slime-space)


(provide 'lisp-pack)
;;; lisp-pack.el ends here
