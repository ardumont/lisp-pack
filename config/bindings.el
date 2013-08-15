(define-key nrepl-interaction-mode-map
  (kbd "C-c C-e") 'nrepl-eval-expression-at-point)

;; To show/hide block of code
(require 'fold-dwim)
(global-set-key (kbd "C-c s t") 'fold-dwim-toggle)
(global-set-key (kbd "C-c s h") 'fold-dwim-hide-all)
(global-set-key (kbd "C-c s s") 'fold-dwim-show-all)
