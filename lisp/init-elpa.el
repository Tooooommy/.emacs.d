;; 配置包的安装源
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
                         ("org"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))

(setq package-enable-at-startup nil)
(package-initialize) ;; 初始化

;; 按照use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; 配置为总是

;; Update GPG keyring for GNU ELPA
;; (use-package gnu-elpa-keyring-update :ensure t)

;; @see https://github.com/jwiegley/emacs-async
(use-package async :ensure t)

;; @see https://github.com/auto-complete/popup-el
(use-package popup :ensure t)

;; @see https://github.com/domtronn/all-the-icons.el
(use-package all-the-icons :ensure t)

;; Environment
(use-package exec-path-from-shell
  :ensure t
  :init
  (setq exec-path-from-shell-check-startup-files nil
        exec-path-from-shell-variables '("PATH" "MANPATH")
        exec-path-from-shell-arguments '("-l"))
  (exec-path-from-shell-initialize))

;; @see https://github.com/rranelli/auto-package-update.el
(use-package auto-package-update
  :ensure t
  :init
  (setq auto-package-update-delete-old-versions t
        auto-package-update-hide-results t)
  (defalias 'upgrade-packages #'auto-package-update-now))

;; about tools lib 
;; @see https://github.com/magnars/dash.el
;; @see https://github.com/kiwanami/emacs-deferred
;; @see https://github.com/emacsorphanage/ov
;; @see https://github.com/Malabarba/names
;; @see https://github.com/rejeep/f.el
;; @see https://github.com/Wilfred/ht.el
;; @see https://github.com/magnars/s.el
;; @see https://github.com/jwiegley/alert
;; @see https://github.com/sigma/gh.el
;; @see https://github.com/tkf/emacs-request
;; @see https://www.emacswiki.org/emacs/PosTip

;; @see https://github.com/emacscollective/no-littering
;; @see https://github.com/jschaf/esup
;; @see https://github.com/rranelli/auto-package-update.el
;; @see https://github.com/iqbalansari/restart-emacs

(provide 'init-elpa)

;;; init-elpa.el ends here
