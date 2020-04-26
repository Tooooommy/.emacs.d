;; 初始化画面
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

;; 默认配置
(setq-default
 ad-redefinition-action 'accept                   ; Silence warnings for redefinition
 cursor-in-non-selected-windows t                 ; Hide the cursor in inactive windows
 fill-column 80                                   ; Set width for automatic line breaks
 help-window-select t                             ; Focus new help windows when opened
 kill-ring-max 128                                ; Maximum length of kill ring
 load-prefer-newer t                              ; Prefers the newest version of a file
 mark-ring-max 128                                ; Maximum length of mark ring
 scroll-conservatively most-positive-fixnum       ; Always scroll by one line
 select-enable-clipboard t                        ; Merge system's and Emacs' clipboard
 tab-width 4                                      ; Set width for tabs
 user-full-name "Tooooommy"                       ; Set the full name of the current user
 user-mail-address "tooooommy@163.com"            ; Set the email address of the current user
 vc-follow-symlinks t                             ; Always follow the symlinks
 view-read-only t                                 ; Always open read-only buffers in view-mode
 delete-by-moving-to-trash t
 visible-bell t
 inhibit-compacting-font-caches t
 use-package-always-ensure t
 make-backup-files nil
 auto-save-default nil
 uniquify-buffer-name-style 'post-forward-angle-brackets ; Show path if names are same
 adaptive-fill-regexp "[ t]+|[ t]*([0-9]+.|*+)[ t]*"
 adaptive-fill-first-line-regexp "^* *$"
 sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*"
 sentence-end-double-space nil
 indicate-empty-lines t
 initial-major-mode 'fundamental-mode
 )

;; 显示设置
(cd "~/")                                         ; 切换到主目录
(display-time-mode 1)                             ; 在modeline 加上时间
(fset 'yes-or-no-p 'y-or-n-p)                     ; 改变询问字符

;; Suppress GUI features
(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)

;; 系统编码
(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)

;; 字体设置
;; (set-face-attribute 'default  nil :font "Source Code Pro Medium")
;; (set-fontset-font t 'latin "Noto Sans")
(set-frame-font "Source Code Pro 12")

;; 编辑器标题
(setq frame-title-format '("Tommy Emacs - %b")
      icon-title-format frame-title-format)

;; 初始化调整窗口
(setq frame-inhibit-implied-resize t
      frame-resize-pixelwise t)

;; 显示窗口
;; (setq window-divider-default-places t
;;       window-divider-default-bottom-width 1
;;       window-divider-default-right-width 1)
;; (add-hook 'window-setup-hook #'window-divider-mode)

;; 删除某些buffer
(defvar *protected-buffers* '("*scratch*" "*Messages*")
  "Buffers that cannot be killed.")

(defun my/protected-buffers ()
  "Protects some buffers from being killed."
  (dolist (buffer *protected-buffers*)
    (with-current-buffer buffer
      (emacs-lock-mode 'kill))))

(add-hook 'after-init-hook #'my/protected-buffers)


;; ido
(use-package ido
  :ensure nil
  :init (ido-mode 1))

;; ibuffer
(use-package ibuffer
  :ensure nil
  :bind ("C-x C-b" . ibuffer))

;; winner
(use-package winner
  :ensure nil
  :hook (after-init . winner-mode))

;; ediff
(use-package ediff
  :ensure nil
  :hook (ediff-quit . winner-undo))

;; saveplace
(use-package save-place
  :ensure nil
  :hook (after-init . save-place-mode))

;; hl-line // 高亮当前行
(use-package hl-line
  :ensure nil
  :hook(after-init . global-hl-line-mode))

;; hideshow
(use-package hideshow
  :ensure nil
  :diminish hs-minor-mode
  :bind
  (:map prog-mode-map
   ("M--" . hs-toggle-hiding)
   ("M-_" . hs-hide-all)
   ("M-+" . hs-show-all))
  :hook (prog-mode . hs-minor-mode)
  :custom
  (hs-special-modes-alist
   (mapcar 'purecopy
           '((c-mode "{" "}" "/[*/]" nil nil)
             (c++-mode "{" "}" "/[*/]" nil nil)
             (rust-mode "{" "}" "/[*/]" nil nil)
             (go-mode "{" "}" "/[*/]" nil nil)))))

;; so-long
;; (use-package so-long
;;   :ensure nil
;;   :hook (after-init .global-so-long-mode))

;; subword
(use-package subword
  :ensure nil
  :hook (after-init . global-subword-mode))

;; paren
(use-package paren
  :ensure nil
  :hook (after-init . show-paren-mode)
  :config
  (setq show-paren-when-point-inside-paren t
        show-paren-when-point-in-periphery t))

;; autorevert
(use-package autorevert
  :ensure nil
  :hook (after-init . global-auto-revert-mode))

;; recentf
(use-package recentf
  :ensure nil
  :hook (after-init . recentf-mode)
  :bind
  ("C-x C-r" . recentf-open-files)
  :config
  ;; (run-at-time nil (* 5 60) 'recentf-save-list)
  (setq recentf-max-menu-items 25)
  (setq recentf-max-saved-items 25))

;; windmove
(use-package windmove
  :ensure nil
  :bind
  ("C-c h" . 'windmove-left)
  ("C-c j" . 'windmove-down)
  ("C-c k" . 'windmove-up)
  ("C-c l" . 'windmove-right))

;; imenu
(use-package imenu
  :ensure nil)

;; eldoc
(use-package eldoc
  :ensure nil
  :diminish)

;; flymake
(use-package flymake
  :ensure nil
  :hook (eglot-mode . flymake-mode))

(provide 'init-builtin)
;;; init-builtin.el nends here
