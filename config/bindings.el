(define-key nrepl-interaction-mode-map
  (kbd "C-c C-e") 'nrepl-eval-expression-at-point)

;; To show/hide block of code
(require 'fold-dwim)
(global-set-key (kbd "C-c j") 'fold-dwim-toggle)
(global-set-key (kbd "C-c l") 'fold-dwim-hide-all)
(global-set-key (kbd "C-c ;") 'fold-dwim-show-all)
