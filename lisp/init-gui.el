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

;; Suppress GUI features
(setq use-file-dialog nil
      use-dialog-box nil
      inhibit-startup-screen t
      inhibit-startup-echo-area-message t)

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

;; Menu/Tool/Scroll bars
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; Use fixed pitch where it's sensible
(use-package mixed-pitch
  :ensure t
  :diminish)

;; Display dividers between windows
(setq window-divider-default-places t
      window-divider-default-bottom-width 1
      window-divider-default-right-width 1)
(add-hook 'window-setup-hook #'window-divider-mode)

;; @see https://github.com/hlissner/emacs-doom-themes
(use-package doom-themes
  :ensure t
  :init (load-theme 'doom-one t)
  :config
  (setq  
   doom-themes-enable-bold t
   doom-themes-enable-italic t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;;(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
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

;; Title
(setq frame-title-format '("Tommy Emacs - %b")
      icon-title-format frame-title-format)

;; Inhibit resizing frame
(setq frame-inhibit-implied-resize t
      frame-resize-pixelwise t)

;; font 
(set-frame-font "Source Code Pro 12")

(provide 'init-gui)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-gui.el ends here
