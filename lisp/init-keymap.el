;; https://github.com/justbur/emacs-which-key
(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  (which-key-setup-side-window-bottom)
  :config
  (setq
   which-key-show-early-on-C-h t
   which-key-idle-delay 0.5
   which-key-idle-secondary-delay 0.5
   which-key-popup-type 'side-window
   which-key-side-window-location 'bottom
   which-key-side-window-max-width 0.33
   which-key-side-window-max-height 0.25
   which-key-separator " → "
   which-key-prefix-prefix "+"
   which-key-show-prefix 'left
   which-key-show-remaining-keys t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; vim keymap
;; @see https://github.com/Triagle/emacs/blob/4e60068814735b38055c79d3bad7cb06f9e4322b/configuration.org
;; @see https://github.com/noctuid/general.el
(use-package general
  :ensure t
  :config
  (general-evil-setup)
  (general-create-definer leader-key :prefix "SPC" :states '(normal visual motion) :keymaps 'override :wk "leader"))
  
;; emacs key bind like
(general-define-key [f11] 'helpers/fullscreen)
(general-define-key "M-x" 'helm-M-x :keymaps 'override) ;; 重新绑定
(general-define-key "M-;" 'evilnc-comment-or-uncomment-lines :wk "comment")


;; space ==> helm
(leader-key "SPC" '(helm-M-x :wk "command line"))
(leader-key "0" '(treemacs-select-window :wk "select treemacs"))
(leader-key "1" '(winum-select-window-1 :wk "select window1"))
(leader-key "2" '(winum-select-window-2 :wk "select window2"))
(leader-key "3" '(winum-select-window-3 :wk "select window3"))
(leader-key "4" '(winum-select-window-4 :wk "select window4"))
(leader-key "5" '(winum-select-window-5 :wk "select window5"))
(leader-key "6" '(winum-select-window-6 :wk "select window6"))
(leader-key "7" '(winum-select-window-7 :wk "select window7"))
(leader-key "8" '(winum-select-window-8 :wk "select window8"))
(leader-key "9" '(winum-select-window-9 :wk "select window9"))

;; comments
(leader-key "c" '(:wk "comment")
  "cc" '(evilnc-comment-or-uncomment-lines :wk "lines")
  "ci" '(evilnc-quick-comment-or-uncomment-to-the-line :wk "quick")
  "cl" '(evilnc-comment-or-uncomment-to-the-line :wk "line")
  "cp" '(evilnc-comment-or-uncomment-paragraphs :wk "paragraphs")
  "cr" '(comment-or-uncomment-region :wk "region"))

;; buffers
(leader-key "b" '(:wk "buffer")
  "bb" '(helm-buffers-list :wk "list")
  "bn" '(evil-next-buffer :wk "next")
  "bp" '(evil-prev-buffer :wk "previous")
  "bc" '(evil-buffer-new :wk "create")
  "bd" '(evil-delete-buffer :wk "delete")
  "br" '(rename-buffer :wk "rename")
  "bm" '(helpers/kill-other-buffer :wk "kill other"))

;; edit
(leader-key "e" '(:wk "edit")
  "ea" '(evil-mc-make-all-cursors :wk "mc all cursor")
  "eu" '(evil-mc-undo-all-cursors :wk "mc undo all cursor")
  "ed" '(evil-mc-undo-last-added-cursor :wk "mc undo last cursor")
  "ek" '(evil-mc-make-and-goto-prev-cursor :wk "mc prev cursor")
  "ej" '(evil-mc-make-and-goto-next-cursor :wk "mc next cursor")
  "eh" '(evil-mc-skip-and-goto-prev-cursor :wk "mc skip prev cursor")
  "el" '(evil-mc-skip-and-goto-next-cursor :wk "mc skip next cursor")
  "ep" '(evil-mc-make-and-goto-prev-match :wk "mc prev match")
  "en" '(evil-mc-make-and-goto-next-match :wk "mc next match")
  "eb" '(evil-mc-skip-and-goto-prev-match :wk "mc prev match")
  "ef" '(evil-mc-skip-and-goto-next-match :wk "mc next match")
  "e0" '(evil-mc-make-and-goto-first-cursor :wk "mc first cursor")
  "e$" '(evil-mc-make-and-goto-last-cursor :wk "mc last cursor")
  "eh" '(evil-mc-make-cursor-here :wk "mc here")
  "ep" '(evil-mc-pause-cursors :wk "mc pause cursor")
  "er" '(evil-mc-resume-cursors :wk "mc resume cursor"))

;; files
(leader-key "f" '(:wk "file")
  "ff" '(helm-find-files :wk "find")
  "fa" '(helm-ag-this-file :wk "ag search")
  "fs" '(save-buffer :wk "save")
  "ft" '(treemacs :wk "tree")
  "fr" '(helm-recentf :wk "recentf")
  "fe" '(helpers/open-init-file :wk "init.el")
  "fy" '(helm-show-kill-ring :wk "kill ring")
  "fm" '(helm-mini :wk "mini")
  "fo" '(helm-occur :wk "occur")
  "fi" '(helm-register :wk "register")
  "fb" '(:wk "bookmark")
  "fbb" '(helm-bookmarks :wk "list")
  "fbs" '(bookmark-set :wk "set")
  "fbS" '(bookmark-save :wk "save")
  "fbd" '(bookmark-delete :wk "delete")
  "fbl" '(bookmark-load :wk "load")
  "fbj" '(bookmark-jump :wk "jump"))

;; help
(leader-key "h" '(:wk "help")
  "hh" '(helpers/helpful-at-point-dwim :wk "here")
  "hk" '(helpful-key :wk "key")
  "hf" '(helpful-symbol :wk "function")
  "hm" '(helpful-macro :wk "macro")
  "hv" '(helpful-variable :wk "variable"))

;; windows
(leader-key "w" '(:wk "window")
  "wc" '(helpers/increase-window :wk "increase") 
  "wd" '(helpers/decrease-window :wk "decrease")
  "wm" '(maximize-window :wk "max")
  "ws" '(evil-window-split :wk "split")
  "wv" '(evil-window-vsplit :wk "vsplit")
  "wc" '(evil-window-delete :wk "close")
  "wn" '(evil-window-new :wk "new")
  "wl" '(evil-window-right :wk "right")
  "wh" '(evil-window-left :wk "left")
  "wj" '(evil-window-bottom :wk "bottom")
  "wk" '(evil-window-up :wk "up") ;;; 
  "wo" '(other-window :wk "other window") ;;; 跳转到其他的窗口
  "wf" '(helpers/fullscreen :wk "fullscreen") ;;; 满屏
  "w0" '(treemacs-select-window :wk "treemacs")
  "w1" '(winum-select-window-1 :wk "window 1")
  "w2" '(winum-select-window-2 :wk "window 2")
  "w3" '(winum-select-window-3 :wk "window 3")
  "w4" '(winum-select-window-4 :wk "window 4")
  "w5" '(winum-select-window-5 :wk "window 5")
  "w6" '(winum-select-window-6 :wk "window 6")
  "w7" '(winum-select-window-7 :wk "window 7")
  "w8" '(winum-select-window-8 :wk "window 8")
  "w9" '(winum-select-window-9 :wk "window 9"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; language
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; golang
(leader-key "m" '(:wk "language")
  :keymaps 'go-mode-map ;; golang

  "mi" '(:wk "import")
  "mig" '(go-goto-imports :wk "goto imports")
  "mia" '(go-import-add :wk "add import")
  "mir" '(go-remove-unused-imports :wk "remove unused import")

  "mx" '(:wk "action")
  "mxx" '(go-run :wk "run")
  "mxt" '(go-test-current-test :wk "test")
  "mxf" '(gofmt :wk "format")
  "mxr" '(godoctor-rename :wk "rename")
  "mxc" '(go-coverage :wk "coverage")
  "mxb" '(go-play-buffer :wk "play buffer")
  "mxe" '(go-play-region :wk "play region")
  "mxh" '(godoc-at-point :wk "godoc")
  "mxi" '(go-impl :wk "impl")
  "mxs" '(go-fill-struct :wk "fill struct")
  "mxa" '(go-tag-add :wk "add tag")
  "mxd" '(go-tag-remove :wk "remove tag")
  "mxu" '(go-tag-refresh :wk "update tag")

  "mt" '(:wk "test")
  "mtt" '(go-test-current-test :wk "current test")
  "mtf" '(go-test-current-file :wk "current file")
  "mtp" '(go-test-current-project :wk "current project")
  "mtc" '(go-test-current-coverage :wk "current coverage")

  "mb" '(:wk "benchmark")
  "mbb" '(go-test-current-benchmark :wk "current benchmark")
  "mbf" '(go-test-current-file-benchmarks :wk "current benchmark")
  "mbp" '(go-test-current-project-benchmarks :wk "current project")

  "mg" '(:wk "jump")
  "mgg" '(godef-describe :wk "describe")
  "mgj" '(godef-jump :wk "jump")
  "mgo" '(godef-jump-other-window :wk "jump other window"))

;; rust
(leader-key "m" '(:wk "rust")
  :keymaps 'rust-mode-map
  "mx" '(:wk "action")
  "mxx" '(rust-run :wk "run")
  "mxt" '(rust-test :wk "test")
  "mxc" '(rust-compile :wk "compile"))

(provide 'init-keymap)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-keymap.el ends here
