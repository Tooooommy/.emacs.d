;; package initialize
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

(setq package-enable-at-startup nil)
(package-initialize) ;; You might already have this line


(defun require-package (package &optional min-version no-refresh)
  "Ask elpa to install package"
  (cond
   ((package-installed-p package min-version)
    t)
   ((or (assoc package package-archive-contents) no-refresh)
    (package-install package))
   (t
    (package-refresh-contents)
    (require-package package min-version t))))

;; @see https://github.com/raxod502/straight.el
(require-package 'use-package)

;; @see https://github.com/jwiegley/emacs-async
(use-package async :ensure t)

;; @see https://github.com/auto-complete/popup-el
(use-package popup
  :ensure t)

;; @see https://github.com/dholm/benchmark-init-el
(use-package benchmark-init
  :ensure t)

;; @see https://github.com/domtronn/all-the-icons.el
(use-package all-the-icons
  :ensure t)

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