;; ido
(use-package ido
  :init (ido-mode 1))

;; @see https://github.com/nonsequitur/smex/
(use-package smex
  :ensure t
  :init (smex-initialize)
  :bind
  (("M-x" . smex)
   ("M-X" . smex-major-mode-commands)))

;; @see https://github.com/jacktasia/dumb-jump
(use-package dumb-jump
  :ensure t
  :after evil
  :init (dumb-jump-mode 1)
  :bind
  (:map evil-visual-state-map
   ("g d" . dumb-jump-go)
   ("g b" . dumb-jump-back)
   :map evil-motion-state-map
   ("g d" . dumb-jump-go)
   ("g b" . dumb-jump-back)
   :map evil-normal-state-map
   ("g d" . dumb-jump-go)
   ("g b" . dumb-jump-back))
  :config (setq dumb-jump-selector 'helm))

;;;; @see https://github.com/manateelazycat/snails
;;(use-package snails
;; :load-path "~/.emacs.d/github/snails"
;; :bind ("C-p" . snails-search-point)
;; :config (require 'snails))

(provide 'init-ido)

;;; init-ido.el ends here
