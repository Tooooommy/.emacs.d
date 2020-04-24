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
(general-define-key "M-x" 'smex :keymaps 'override) ;; 重新绑定
(general-define-key "M-;" 'evilnc-comment-or-uncomment-lines :wk "comment")
(general-define-key "gd" 'xref-find-definitions :states '(normal visual motion) :keymaps 'override :wk "jump")
(general-define-key "gb" 'xref-pop-marker-stack :states '(normal visual motion) :keymaps 'override :wk "back")

;; space leader
(leader-key "SPC" '(smex :wk "command line"))
(leader-key "0" '(treemacs-select-window :wk "select treemacs"))

;; comments
(leader-key "c" '(:wk "comment")
  "cc" '(evilnc-comment-or-uncomment-lines :wk "lines")
  "ci" '(evilnc-quick-comment-or-uncomment-to-the-line :wk "quick")
  "cl" '(evilnc-comment-or-uncomment-to-the-line :wk "line")
  "cp" '(evilnc-comment-or-uncomment-paragraphs :wk "paragraphs")
  "cr" '(comment-or-uncomment-region :wk "region"))

;; buffers
(leader-key "b" '(:wk "buffer")
  "bb" '(ibuffer :wk "list")
  "bn" '(evil-next-buffer :wk "next")
  "bp" '(evil-prev-buffer :wk "previous")
  "bc" '(evil-buffer-new :wk "create")
  "bd" '(evil-delete-buffer :wk "delete")
  "bg" '(ibuffer-jump :wk "jump")
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
  "ff" '(ido-find-file :wk "find")
  "fs" '(save-buffer :wk "save")
  "ft" '(treemacs :wk "tree")
  "fr" '(recentf-open-files :wk "recentf")
  "fe" '(helpers/open-init-file :wk "init.el")
  "fm" '(smex :wk "smex")
  "fb" '(:wk "bookmark")
  "fbb" '(list-bookmarks :wk "list")
  "fbm" '(bookmark-set :wk "mark")
  "fbs" '(bookmark-save :wk "save")
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
  "wi" '(helpers/increase-window :wk "increase") 
  "wd" '(helpers/decrease-window :wk "decrease")
  "wm" '(maximize-window :wk "max")
  "ws" '(evil-window-split :wk "split")
  "wv" '(evil-window-vsplit :wk "vsplit")
  "wc" '(evil-window-delete :wk "close")
  "wn" '(evil-window-new :wk "new")
  "wh" '(evil-window-left :wk "left")
  "wj" '(evil-window-bottom :wk "bottom")
  "wk" '(evil-window-up :wk "up") ;;; 
  "wl" '(evil-window-right :wk "right")
  "wo" '(other-window :wk "other window")
  "wf" '(helpers/fullscreen :wk "fullscreen") ;;; 满屏
  "ww" '(treemacs-select-window :wk "treemacs"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; language
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; golang
(leader-key "m" '(:wk "golang")
  :keymaps 'go-mode-map 

  "mi" '(:wk "import")
  "mig" '(go-goto-imports :wk "goto imports")
  "mia" '(go-import-add :wk "add import")
  "mir" '(go-remove-unused-imports :wk "remove unused import")

  "mx" '(:wk "action")
  "mxx" '(go-run :wk "run")
  "mxt" '(go-test-current-test :wk "test")
  "mxf" '(go-run :wk "format")
  "mxr" '(eglot-rename :wk "rename")
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
  "mbp" '(go-test-current-project-benchmarks :wk "current project"))

;; rust
(leader-key "m" '(:wk "rust")
  :keymaps 'rust-mode-map
  "mx" '(:wk "action")
  "mxx" '(cargo-process-run :wk "run")
  "mxt" '(cargo-process-test :wk "test")
  "mxf" '(cargo-process-fmt :wk "format")
  "mxr" '(eglot-rename :wk "rename")
  "mxh" '(cargo-process-doc-open :wk "doc")
  "mxc" '(rust-compile :wk "compile"))

(provide 'init-keymap)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-keymap.el ends here