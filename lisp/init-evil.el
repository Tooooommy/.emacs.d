;; @see https://github.com/emacs-evil/evil
(use-package evil
  :ensure t 
  :defer 3
  :init (setq evil-want-keybinding nil
              evil-ex-substitute-global t
              evil-escape-mode 1)
  :hook (after-init . evil-mode)
  :bind
  (:map evil-motion-state-map
   ("C-u" . scroll-down-command)
   :map evil-insert-state-map
   ([escape] . evil-normal-state)
   :map evil-visual-state-map
   ([escape] . evil-normal-state))

  :config 
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
        evil-want-fine-undo t))

;; @see https://github.com/emacs-evil/evil-surround
(use-package evil-surround
  :ensure t
  :defer 3
  :config
  (global-evil-surround-mode 1)
  (add-hook 'emacs-lisp-mode-hook (lambda ()
                                    (push '(?` . ("`" . "'")) evil-surround-pairs-alist))))

;; @see https://github.com/redguardtoo/evil-nerd-commenter
(use-package evil-nerd-commenter
  :ensure t
  :defer 3
  )

;; @see https://github.com/syl20bnr/evil-escape
(use-package evil-escape
  :ensure t 
  :defer 3
  :diminish
  :demand t
  :init(evil-escape-mode 1)
  :bind ("C-g" . evil-escape)
  :config (progn
            (setq-default evil-escape-key-sequence "jk")
            (setq-default evil-escape-delay 0.2)))

;; @see https://github.com/gabesoft/evil-mc
(use-package evil-mc
  :ensure t
  :defer 3
  :after evil
  :init (global-evil-mc-mode 1)
  :config
  (evil-define-key 'visual evil-mc-key-map
    "A" #'evil-mc-make-cursor-in-visual-selection-end
    "I" #'evil-mc-make-cursor-in-visual-selection-beg))

(provide 'init-evil)
;; init-evil.el
