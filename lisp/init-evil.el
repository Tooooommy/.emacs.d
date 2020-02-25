;; @see https://github.com/emacs-evil/evil
(use-package evil
  :ensure t 
  :init (setq evil-want-keybinding nil
              evil-ex-substitute-global t)
  :hook (after-init . evil-mode)
  :bind (:map evil-motion-state-map ("C-u" . scroll-down-command)
         :map evil-insert-state-map ([escape] . evil-normal-state))

  :config 
  (evil-define-key 'normal go-mode-map "gd" 'godef-jump)
  (evil-define-key 'normal go-mode-map "gp" 'godef-describe)
  (evil-define-key 'normal go-mode-map "go" 'godef-jump-other-window)

  (setq evil-emacs-state-cursor '("red" box)
        evil-normal-state-cursor '("green" box)
        evil-visual-state-cursor '("orange" box)
        evil-insert-state-cursor '("red" bar)
        evil-replace-state-cursor '("red" bar)
        evil-operator-state-cursor '("red" hollow)
        evil-auto-indent t
        evil-ex-complete-emacs-commands t
        evil-magic 'very-magic
        evil-search-module 'evil-search
        evil-shift-width 2
        evil-toggle-key "C-M-z"
        evil-want-C-w-delete nil
        evil-want-C-w-in-emacs-state nil
        evil-want-fine-undo t)

  ;; @see https://github.com/emacs-evil/evil-surround
  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode 1)
    (add-hook 'emacs-lisp-mode-hook (lambda ()
                                      (push '(?` . ("`" . "'")) evil-surround-pairs-alist))))

  ;; @see https://github.com/redguardtoo/evil-nerd-commenter
  (use-package evil-nerd-commenter
    :ensure t)

  ;; @see https://github.com/syl20bnr/evil-escape evil-escape
  (use-package evil-escape
    :ensure t 
    :diminish
    :demand t
    :after evil
    :bind ("C-g" . evil-escape)
    :init (evil-escape-mode +1)
    :config (progn
              (setq-default evil-escape-exclude-states '(normal visual multiedit emacs motion))
              (setq-default evil-escape-exclude-major-modes '(neotree-mode))
              (setq-default evil-escape-key-sequence "jk")
              (setq-default evil-escape-delay 0.2)))

  ;; @see https://github.com/gabesoft/evil-mc
  (use-package evil-mc
    :ensure t
    :after evil
    :init (global-evil-mc-mode 1)
    :config
    (evil-define-key 'visual evil-mc-key-map
      "A" #'evil-mc-make-cursor-in-visual-selection-end
      "I" #'evil-mc-make-cursor-in-visual-selection-beg)))

;; @see https://github.com/emacs-evil/evil-collection
;;(use-package evil-collection
;;  :ensure t
;;  :after evil
;;  :config (evil-collection-init))

(provide 'init-evil)

;; init-evil.el ends here
