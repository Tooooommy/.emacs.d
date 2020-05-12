;; yaml
(use-package yaml-mode
  :delight "Y "
  :mode "\\.yml\\'"
  :interpreter ("yml" . yml-mode))

;; xml
(use-package xml-mode
  :delight "X "
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

;; toml
(use-package toml-mode
  :delight "T "
  :ensure t
  :mode
  (("\\.conf\\'" . conf-toml-mode)
   ("\\.toml\\'" . toml-mode)))

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

;; @see https://github.com/syohex/emacs-quickrun
(use-package quickrun
  :ensure t)

;; @see https://github.com/jacktasia/dumb-jump
(use-package dumb-jump
  :ensure t
  :hook (after-init . dumb-jump-mode)
  :config
  (setq dumb-jump-selector 'helm))

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
  :hook (after-init . smex-initialize))

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

;; @see https://github.com/Wilfred/helpful
(use-package helpful
  :ensure t
  :init
  (setq helpful-max-buffers 10))

;; @see https://github.com/bmag/imenu-list
(use-package imenu-list
  :ensure t)

;; @see https://github.com/meqif/flymake-diagnostic-at-point
(use-package flymake-diagnostic-at-point
  :ensure t
  :after flymake
  :config
  (add-hook 'flymake-mode-hook #'flymake-diagnostic-at-point-mode))

(provide 'init-prog)
;;; init-prog.el ends here
