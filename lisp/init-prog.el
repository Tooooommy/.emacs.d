;; @see https://github.com/syohex/emacs-quickrun
(use-package quickrun
  :ensure t
  :bind (("C-<f5>" . quickrun)
         ("C-c x" . quickrun)))

;; @see https://github.com/jacktasia/dumb-jump
(use-package dumb-jump
  :ensure t
  :after evil
  :hook (after-init . dumb-jump-mode)
  :bind
  (:map evil-visual-state-map
   ("g d" . dumb-jump-go)
   ("g b" . dumb-jump-back)
   ("g o" . dumb-jump-go-other-window)
   ("g e" . dumb-jump-go-prefer-external)
   ("g x" . dumb-jump-go-prefer-external-other-window)
   ("g i" . dumb-jump-go-prompt)
   ("g l" . dumb-jump-quick-look)
   :map evil-motion-state-map
   ("g d" . dumb-jump-go)
   ("g b" . dumb-jump-back)
   ("g o" . dumb-jump-go-other-window)
   ("g e" . dumb-jump-go-prefer-external)
   ("g x" . dumb-jump-go-prefer-external-other-window)
   ("g i" . dumb-jump-go-prompt)
   ("g l" . dumb-jump-quick-look)
   :map evil-normal-state-map
   ("g d" . dumb-jump-go)
   ("g b" . dumb-jump-back)
   ("g o" . dumb-jump-go-other-window)
   ("g e" . dumb-jump-go-prefer-external)
   ("g x" . dumb-jump-go-prefer-external-other-window)
   ("g i" . dumb-jump-go-prompt)
   ("g l" . dumb-jump-quick-look))
  :config (setq ;;dumb-jump-prefer-searcher 'rg
           dumb-jump-selector 'helm))

(provide 'init-prog)
;;; init-prog.el ends here
