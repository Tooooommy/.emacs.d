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


(provide 'init-ido)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-ido.el ends here



