;; startup page 
(defun show-scratch-buffer-message ()
  "Open the initial-scratch-message"
  (interactive)
  (let* ((fortune-prog (or (executable-find "fortune-zh")
                           (executable-find "fortune"))))
    (cond
     (fortune-prog
      (format
       ";; %s\n\n"
       (replace-regexp-in-string
        "\n" "\n;; " ; comment each line
        (replace-regexp-in-string
         "\\(\n$\\|\\|\\[m *\\|\\[[0-9][0-9]m *\\)" ""    ; remove trailing linebreak
         (shell-command-to-string fortune-prog)))))
     (t
      (concat ";; Happy hacking "
              (or user-login-name "")
              " - Emacs love you!\n\n")))))

(setq-default initial-scratch-message (show-scratch-buffer-message))

;; @see https://github.com/emacs-dashboard/emacs-dashboard

;; Suppress GUI features

(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)
(setq line-number-mode t)
(setq column-number-mode t)

;; Show a marker in the left fringe for lines not in the buffer
(setq indicate-empty-lines t)
(setq-default initial-major-mode 'fundamental-mode)

;; NO tool bar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
;; no scroll bar
(if (fboundp 'set-scroll-bar-mode) (set-scroll-bar-mode nil))
;; no menu bar
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; @see https://github.com/ema2159/centaur-tabs
(use-package centaur-tabs
  :ensure t
  :after evil
  :init (centaur-tabs-mode t)
  :bind (:map evil-normal-state-map
         ("g t" . centaur-tabs-forward)
         ("g T" . centaur-tabs-backward))
  :config
  (add-hook 'dired-mode-hook 'centaur-tabs-local-mode)
  (setq
   centaur-tabs-style "box"
   centaur-tabs-height 25
   centaur-tabs-set-icons t
   centaur-tabs-set-modified-marker t
   centaur-tabs-gray-out-icons 'buffer
   centaur-tabs-set-bar 'left
   x-underline-at-descent-line t
   centaur-tabs-set-close-button "X"
   uniquify-separator "/"
   uniquify-buffer-name-style 'forward
   centaur-tabs-cycle-scope 'tabs
   centaur-tabs-adjust-buffer-order t)
  (centaur-tabs-headline-match)
  (centaur-tabs-group-by-projectile-project)
  (centaur-tabs-group-buffer-groups))


;; @see https://github.com/hlissner/emacs-doom-themes
(use-package doom-themes
  :ensure t
  :init (load-theme 'doom-one t)
  :config
  (setq  
   doom-themes-enable-bold t
   doom-themes-enable-italic t
   doom-themes--colors t
   doom-themes-treemacs-theme t)
  (doom-themes-visual-bell-config)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

;; @see https://github.com/seagle0128/doom-modeline
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-icon nil
        doom-modeline-irc t
        doom-modeline-mu4e t
        doom-modeline-project-detection 'project
        doom-modeline-lsp t
        doom-modeline-major-mode-icon nil
        doom-modeline-minor-modes (featurep 'minions)
        doom-modeline-height 25
        doom-modeline-bar-width 3
        doom-modeline-buffer-encoding t
        doom-modeline-indent-info nil
        doom-modeline-env-version t))

(provide 'init-gui)

;;; init-gui.el ends here
