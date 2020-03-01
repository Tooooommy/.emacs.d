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
(leader-key "0" '(treemacs-select-window :wk "treemacs window"))

;; comments
(leader-key "c" '(:wk "comment")
  "cc" '(evilnc-comment-or-uncomment-lines :wk "lines")
  "ci" '(evilnc-quick-comment-or-uncomment-to-the-line :wk "quick")
  "cl" '(evilnc-comment-or-uncomment-to-the-line :wk "line")
  "cp" '(evilnc-comment-or-uncomment-paragraphs :wk "paragraphs")
  "cr" '(evilnc--comment-or-uncomment-region :wk "region")
  "c." '(evilnc-copy-and-comment-operator :wk "operator"))

;; buffers
(leader-key "b" '(:wk "buffer")
  "bb" '(helm-buffers-list :wk "list")
  "bn" '(evil-next-buffer :wk "next")
  "bp" '(evil-prev-buffer :wk "previous")
  "bc" '(evil-buffer-new :wk "create")
  "bd" '(evil-delete-buffer :wk "delete")
  "br" '(rename-buffer :wk "rename")
  "bn" '(helpers/kill-other-buffer :wk "kill other"))

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
  "wc" '(evil-window-new :wk "create")
  "wk" '(evil-window-delete :wk "kill")
  "wn" '(evil-window-next :wk "next")
  "wp" '(evil-window-prev :wk "previous")
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

;; language
(leader-key "m" '(:wk "languages")
  :keymaps '(markdown-mode-map gfm-mode-map) ;; markdown
  "mi" '(:wk "insert")
  "mia" '(markdown-insert-header :wk "header")
  "mib" '(markdown-insert-bold :wk "bold")
  "mic" '(markdown-insert-code :wk "code") ;;d
  "mif" '(markdown-insert-footnote :wk "footnote")
  "mig" '(markdown-insert-image :wk "image")
  "mih" '(markdown-insert-hr :wk "hr") ;;
  "mii" '(markdown-insert-italic :wk "italic")
  "mit" '(markdown-insert-table :wk "table")
  "miu" '(markdown-insert-uri :wk "uri")
  "mik" '(markdown-insert-kbd :wk "kbd")
  "mip" '(markdown-insert-pre :wk "pre")
  "mil" '(markdown-insert-link :wk "link")
  "miw" '(markdown-insert-wiki-link :wk "wiki link")
  "mim" '(markdown-insert-list-item :wk "list item")
  "miq" '(markdown-insert-blockquote :wk "blockquote")
  "mis" '(markdown-insert-strike-through :wk "strike through")
  "mi0" '(markdown-insert-header :wk "header")
  "mi1" '(markdown-insert-header-atx-1 :wk "header 1")
  "mi2" '(markdown-insert-header-atx-2 :wk "header 2")
  "mi3" '(markdown-insert-header-atx-3 :wk "header 3")
  "mi4" '(markdown-insert-header-atx-4 :wk "header 4")
  "mi5" '(markdown-insert-header-atx-4 :wk "header 5")
  "mi6" '(markdown-insert-header-atx-4 :wk "header 6")

  "mp" '(markdown-preview :wk "preview")
  "me" '(markdown-export :wk "export")
  "mo" '(markdown-export-and-preview :wk "export and preview") ;; output
  "ml" '(markdown-live-preview-mode :wk "preview on buffer") ;; live
  "mm" '(markdown-toc-generate-toc :wk "generate outline")   ;; generate
  :keymaps 'go-mode-map ;; golang
  "mh" '(:wk "help")
  "mhh" '(godoc-at-point :wk "godoc at point")
  "mi" '(:wk "import")
  "mia" '(go-import-add :wk "add import")
  "mig" '(go-goto-imports :wk "goto imports")
  "mir" '(go-remove-unused-imports :wk "remove unused import")
  "me" '(:wk "execute")
  "meb" '(go-play-buffer :wk "play buffer")
  "mer" '(go-play-region :wk "play region")
  "med" '(go-playground-download :wk "download play")
  "mx" '(:wk "action")
  "mxx" '(go-run :wk "run")
  "mxf" '(gofmt :wk "format")
  "mxi" '(go-impl :wk "impl")
  "mxt" '(go-test--go-test :wk "test")
  "mxc" '(go-coverage :wk "coverage")
  "mg" '(:wk "jump")
  "mgg" '(godef-describe :wk "describe")
  "mgj" '(godef-jump :wk "jump")
  "mgo" '(godef-jump-other-window :wk "jump other window")
  "mt" '(:wk "test")
  "md" '(:wk "doctor")
  "mdr" '(godoctor-rename :wk "rename")
  "mde" '(godoctor-extract :wk "extract")
  "mdd" '(godoctor-godoc :wk "document")
  "mdt" '(godoctor-toggle :wk "toggle"))

(provide 'init-keymap)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-keymap.el ends here
