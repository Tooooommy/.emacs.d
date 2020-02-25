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
  (setq auto-save-default nil
        auto-save-interval 100
        super-save-idle-duration 1
        super-save-auto-save-when-idle t))

;; @see https://github.com/malabarba/aggressive-indent-mode
(use-package aggressive-indent
  :ensure t 
  :config
  (global-aggressive-indent-mode 1)
  (add-to-list 'aggressive-indent-excluded-modes 'html-mode))

;; paren
(use-package paren
  :ensure t
  :init (show-paren-mode)
  :config
  (setq show-paren-when-point-inside-paren t
	show-paren-when-point-in-periphery t))


(provide 'init-edit)
;;; init-edit.el ends here
