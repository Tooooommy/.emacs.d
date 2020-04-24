;; sql
(use-package sql-indent
  :after (:any sql sql-interactive-mode)
  :delight sql-mode "Σ ")

;; lua
(use-package lua-mode
  :delight "Λ "
  :mode "\\.lua\\'"
  :interpreter ("lua" . lua-mode))

;; yaml
(use-package yaml-mode
  :delight "ψ "
  :mode "\\.yml\\'"
  :interpreter ("yml" . yml-mode))

;; xml
(use-package xml-mode
  :ensure nil
  :mode ("\\.wsdl\\'" "\\.xsd\\'"))

;; json
(use-package json-mode
  :delight "J "
  :mode "\\.json\\'"
  :hook (before-save . my/json-mode-before-save-hook)
  :preface
  (defun my/json-mode-before-save-hook ()
    (when (eq major-mode 'json-mode)
      (json-pretty-print-buffer))))

;; restclient
;; @see https://github.com/pashky/restclient.el
(use-package restclient
  :ensure t
  :mode ("//.http//'" . restclient-mode)
  :config
  ;; @see https://github.com/iquiw/company-restclient
  (use-package company-restclient
    :ensure t
    :ensure t
    :config (add-to-list 'company-backends 'company-restclient)))

;; elnode
;; @see https://github.com/nicferrier/elnode
(use-package elnode
  :ensure t)

;; editconfig
(use-package editorconfig
  :defer 0.3
  :config (editorconfig-mode 1))

;; dockerfile
;; @see https://github.com/spotify/dockerfile-mode
(use-package dockerfile-mode
  :ensure t
  :mode ("Dockerfile\\'" . dockerfile-mode)
  :config (setq dockerfile-mode-command "docker"))



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
