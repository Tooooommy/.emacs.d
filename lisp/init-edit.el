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
  (sp-local-pair 'lisp-interaction-mode "'" nil :actions nil))

;; @see https://github.com/xcodebuild/nlinum-relative
(use-package nlinum-relative
  :ensure t
  :hook (prog-mode . nlinum-relative-mode)
  :init (nlinum-relative-setup-evil)
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
  :init (global-aggressive-indent-mode t))

;; paren
(use-package paren
  :ensure t
  :init (show-paren-mode)
  :config
  (setq show-paren-when-point-inside-paren t
        show-paren-when-point-in-periphery t))

;; Highlight the current line
(use-package hl-line
  :ensure nil
  :hook ((after-init . global-hl-line-mode)
         ((dashboard-mode eshell-mode shell-mode term-mode vterm-mode) .
          (lambda () (setq-local global-hl-line-mode nil)))))

(provide 'init-edit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-edit.el ends here
