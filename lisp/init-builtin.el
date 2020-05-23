;; 初始化画面	
(defun scratch-buffer-message ()
  (interactive)
  (concat ";; Happy hacking "	
          (or user-login-name "")	
          " - Emacs love you!\n\n"))

(setq-default initial-scratch-message (scratch-buffer-message))
(setq initial-major-mode 'fundamental-mode)

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
(setq frame-title-format '("Tooooommy Emacs - %b")
      icon-title-format frame-title-format)

;; 初始化调整窗口
(setq frame-inhibit-implied-resize t
      frame-resize-pixelwise t)

;; 显示窗口
(setq window-divider-default-places t
      window-divider-default-bottom-width 1
      window-divider-default-right-width 1)
(add-hook 'window-setup-hook #'window-divider-mode)

;; 删除某些buffer
(defvar *protected-buffers* '("*scratch*" "*Messages*")
  "Buffers that cannot be killed.")

(defun my/protected-buffers ()
  "Protects some buffers from being killed."
  (dolist (buffer *protected-buffers*)
    (with-current-buffer buffer
      (emacs-lock-mode 'kill))))

(add-hook 'after-init-hook #'my/protected-buffers)

;; vc 
;;(setq auto-revert-check-vc-info t)
(setq auto-revert-mode 1)

;; ido
(use-package ido
  :ensure nil
  :init (ido-mode 1))

;; ibuffer
(use-package ibuffer
  :ensure nil)

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

;; so-long
(when (not (version< emacs-version "27"))
  (use-package so-long
    :ensure nil
    :hook (after-init .global-so-long-mode)))

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

;; windmove
(use-package windmove
  :ensure nil)

(provide 'init-builtin)
;;; init-builtin.el nends here
