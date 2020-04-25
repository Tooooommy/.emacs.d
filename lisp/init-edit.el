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
  :hook (after-init . global-aggressive-indent-mode))

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
  :ensure t
  :config (rg-enable-default-bindings))

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

;; ibuffer to projectile
(use-package ibuffer-projectile
  :after ibuffer
  :preface
  (defun my/ibuffer-projectile ()
    (ibuffer-projectile-set-filter-groups)
    (unless (eq ibuffer-sorting-mode 'alphabetic)
      (ibuffer-do-sort-by-alphabetic)))
  :hook (ibuffer . my/ibuffer-projectile))


(use-package ibuffer-projectile
  :after ibuffer
  :preface
  (defun my/ibuffer-projectile ()
    (ibuffer-projectile-set-filter-groups)
    (unless (eq ibuffer-sorting-mode 'alphabetic)
      (ibuffer-do-sort-by-alphabetic)))
  :hook (ibuffer . my/ibuffer-projectile))



(provide 'init-edit)
;;; init-edit.el ends here
