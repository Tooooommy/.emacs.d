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
  :ensure t)

;; @see https://github.com/jacktasia/dumb-jump
(use-package dumb-jump
  :ensure t
  :after evil
  :hook (after-init . dumb-jump-mode)
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g b" . dumb-jump-back)
         ("M-g i" . dumb-jump-go-prompt)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config (setq dumb-jump-prefer-searcher 'rg
                dumb-jump-selector 'rg))

;; @see https://github.com/technomancy/better-defaults
(use-package better-defaults
  :ensure t)

;; @see https://github.com/Fuco1/smartparens
(use-package smartparens
  :ensure t
  :init (smartparens-global-mode t)
  :config 
  (require 'smartparens-config)
  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
  (sp-local-pair 'lisp-interaction-mode "'" nil :actions nil)
  (sp-with-modes '(c-mode c++-mode)
    (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET")))
    (sp-local-pair "/*" "*/" :post-handlers '(("| " "SPC") ("* ||\n[i]" "RET"))))
  )

;; @see https://github.com/xcodebuild/nlinum-relative
(use-package nlinum-relative
  :ensure t
  :hook
  ((prog-mode . nlinum-relative-mode)
   (after-init . nlinum-relative-setup-evil))
  :config 
  (setq nlinum-relative-offset 0
        nlinum-relative-redisplay-delay 0
        nlinum-relative-current-symbol "->"))

;; @see https://github.com/emacsmirror/rainbow-mode
;; @see https://github.com/Fanael/rainbow-delimiters
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; @see https://github.com/bbatsov/super-save
(use-package super-save
  :ensure t
  :hook (prog-mode . super-save-mode)
  :config 
  (super-save-mode +1)
  (setq auto-save-default nil
        super-save-auto-save-when-idle t))

;; @see https://github.com/malabarba/aggressive-indent-mode
(use-package aggressive-indent
  :ensure t 
  :hook (after-init . global-aggressive-indent-mode)
  :config
  (add-to-list
   'aggressive-indent-dont-indent-if
   '(and (derived-mode-p 'c++-mode)
         (null (string-match "\\([;{}]\\|\\b\\(if\\|for\\|while\\)\\b\\)"
                             (thing-at-point 'line))))))

;; smex M-x
;; @see https://github.com/nonsequitur/smex/
(use-package smex
  :ensure t
  :hook (after-init . smex-initialize)
  :bind
  (("M-x" . smex)
   ("M-X" . smex-major-mode-commands)
   ("C-c C-c M-x" . execute-extended-command)))

;; rg search
;; @see https://github.com/dajva/rg.el
(use-package rg
  :ensure t)
;; :config (rg-enable-default-bindings))

;; undo-tree 
;; @see http://www.dr-qubit.org/git/undo-tree.git
;; @see https://github.com/emacsmirror/undo-tree
(use-package undo-tree
  :load-path "~/.emacs.d/github/undo-tree-20170706.246"
  :diminish
  :config
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist `(("." . "~/.emacs.d/undotree")))
  (setq delete-old-versions t
        backup-directory-alist `(("." . "~/.emacs.d/saves"))
        backup-by-copying t
        kept-new-versions 6
        kept-old-versions 2
        version-control t))

;; @see https://github.com/nonsequitur/smex/
(use-package smex
  :ensure t
  :init (smex-initialize)
  :bind
  (("M-x" . smex)
   ("M-X" . smex-major-mode-commands)))

;; @see https://github.com/Wilfred/helpful
(use-package helpful
  :ensure t
  :bind (([remap describe-variable] . helpful-variable)
         ([remap describe-function] . helpful-callable)
         ([remap describe-key] . helpful-key)
         :map emacs-lisp-mode-map
         ("C-c C-d" . helpers/helpful-at-point-dwim))

  :init
  (setq helpful-max-buffers 10))

;; @see https://github.com/bmag/imenu-list
(use-package imenu-list
  :ensure t
  :bind
  (:map prog-mode-map
   ("C-'" . imenu-list-smart-toggle)))

;; @see https://github.com/meqif/flymake-diagnostic-at-point
(use-package flymake-diagnostic-at-point
  :ensure t
  :after flymake
  :config
  (add-hook 'flymake-mode-hook #'flymake-diagnostic-at-point-mode))

;; @see https://github.com/TatriX/pomidor
(use-package pomidor
  :ensure t
  :bind
  (("<f12>" . pomidor))
  :config
  (setq pomidor-sound-tick nil
        pomidor-sound-tack nil)
  :hook (pomidor-mode . (lambda ()
                          (display-line-numbers-mode -1)
                          (setq left-fringe-width 0 right-fringe-width 0)
                          (setq left-margin-width 2 right-margin-width 0)
                          (set-window-buffer nil (current-buffer)))))

(provide 'init-prog)
;;; init-prog.el ends here
