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
   which-key-show-prefix 'left which-key-show-remaining-keys t))

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
(general-define-key "C-x C-f" 'helm-find-files :keymaps 'override)
(general-define-key "M-;" 'evilnc-comment-or-uncomment-lines :wk "comment")
(general-define-key "gd" 'xref-find-definitions :states '(normal visual motion) :keymaps 'override :wk "jump")
(general-define-key "gb" 'xref-pop-marker-stack :states '(normal visual motion) :keymaps 'override :wk "back")

;; space leader
(leader-key "SPC" '(helm-M-x :wk "command line"))
(leader-key "0" '(treemacs-select-window :wk "select treemacs"))
;; comments
(leader-key "c" '(:wk "comment")
  "cc" '(evilnc-comment-or-uncomment-lines :wk "lines")
  "ci" '(evilnc-quick-comment-or-uncomment-to-the-line :wk "quick")
  "cl" '(evilnc-comment-or-uncomment-to-the-line :wk "line")
  "cp" '(evilnc-comment-or-uncomment-paragraphs :wk "paragraphs")
  "cr" '(comment-or-uncomment-region :wk "region"))

;; buffers
(leader-key "b" '(:wk "buffer & bookmarks")
  "bb" '(helm-mini :wk "buffers")
  "bn" '(evil-next-buffer :wk "next buffer")
  "bp" '(evil-prev-buffer :wk "prev buffer")
  "bc" '(evil-buffer-new :wk "new buffer")
  "bd" '(evil-delete-buffer :wk "del buffer")
  "bm" '(helm-bookmarks :wk "bookmarks")
  "br" '(helm-bookmark-rename :wk "rename bookmark")
  "bs" '(bookmark-set :wk "set bookmark")
  "bk" '(bookmark-delete :wk "delete bookmark")
  "bf" '(helm-filtered-bookmarks :wk "filter bookmarks")
  )

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
(leader-key "f" '(:wk "file & helm")
  "ff" '(helm-find-files :wk "find")
  "fr" '(helm-recentf :wk "recentf")
  "fs" '(save-buffer :wk "save")
  "ft" '(treemacs :wk "treemacs")
  "fw" '(helm-swoop :wk "swoop")
  "fm" '(helm-mt :wk "multi term")

  ;; fold
  "fo" '(hs-toggle-hiding :wk "fold")
  "f+" '(hs-show-all :wk "show all")
  "f-" '(hs-hide-all :wk "hide all")

  ;; imenu
  "fa" '(helm-imenu-anywhere :wk "helm imenu")
  "fi" '(imenu-list-smart-toggle :wk "imenu list")

  ;; git
  "fg" '(helm-ls-git-ls :wk "git")
  "f." '(helm-gitignore :wk "gitignore")

  ;; help
  "fy" '(quickrun :wk "quickrun"))

;; help
(leader-key "h" '(:wk "help")
  "hh" '(helpers/helpful-at-point-dwim :wk "here")
  "hk" '(helpful-key :wk "key")
  "hf" '(helpful-symbol :wk "function")
  "hm" '(helpful-macro :wk "macro")
  "hv" '(helpful-variable :wk "variable")
  "hd" '(helm-descbinds :wk "descbinds")
  "ha" '(helm-apropos :wk "apropos")
  )

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

;; dumb
(leader-key "g" '("dumb jump")
  "gd" '(dumb-jump-go :wk "go")
  "go" '(dumb-jump-back :wk "back")
  "gw" '(dumb-jump-go-other-window :wk "go other window")
  "gc" '(dumb-jump-go-current-window :wk "go current window"))

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
  "mxr" '(godoctor-rename :wk "rename")
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

;; version control
(leader-key "v" '(:wk "version control")
  "vv" '(:wk "operator") 
  "vvi" '(magit-init :wk "init")
  "vva" '(magit-stage-modified :wk "add all")
  "vvb" '(magit-checkout :wk "checkout")
  "vvc" '(magit-commit-create :wk "commit")
  "vvd" '(magit-checkout-stage :wk "checkout stage")
  "vve" '(magit-ediff :wk "ediff")
  "vvf" '(magit-stage-file :wk "add file")
  "vvs" '(magit-status-here :wk "status")
  "vvo" '(magit-clone :wk "clone")
  "vv." '(magit-gitignore-in-topdir :wk "ignore")
  "vvv" '(magit-version :wk "version")

  "vb" '(:wk "git branch") ;; branch
  "vbo" '(magit-branch-checkout :wk "checkout")
  "vbc" '(magit-branch-create :wk "create")
  "vbd" '(magit-branch-delete :wk "delete")
  "vbr" '(magit-branch-rename :wk "rename")

  "vt" '(:wk "git tag") ;; tag
  "vtc" '(magit-tag-create :wk "create")
  "vtd" '(magit-tag-delete :wk "delete")
  "vtr" '(magit-tag-release :wk "release")
  "vtp" '(magit-tag-prune :wk "push")

  "vm" '(:wk "merge & rebase") ;; merge
  "vmi" '(magit-merge-into :wk "merge into")
  "vmq" '(magit-merge-abort :wk "merge abort")
  "vmv" '(magit-merge-preview :wk "merge preview")
  "vme" '(magit-rebase-edit :wk "rebase edit")
  "vms" '(magit-rebase-skip :wk "rebase skip")
  "vma" '(magit-rebase-abort :wk "rebase abort")
  "vmc" '(magit-rebase-continue :wk "rebase continue")
  "vma" '(magit-rebase-interactive :wk "rebase interactive")

  "vl" '(:wk "log") ;; log
  "vla" '(magit-log-all :wk "all")
  "vlh" '(magit-log-head :wk "head")

  "vp" '(:wk "pull & push & fetch")
  "vpb" '(magit-pull-branch :wk "pull branch")
  "vps" '(magit-pull-from-upstream :wk "pull upstream")
  "vpc" '(magit-push-current :wk "push current")
  "vpo" '(magit-push-other :wk "push other")
  "vpt" '(magit-push-tag :wk "push tag")
  "vpa" '(magit-fetch-all :wk "fetch all")
  "vpe" '(magit-fetch-branch :wk "fetch branch")

  "vr" '(:wk "reset & revert")
  "vrh" '(magit-reset-hard :wk "reset hard")
  "vrs" '(magit-reset-soft :wk "reset soft")
  "vrm" '(magit-reset-mixed :wk "reset mixed")
  "vrc" '(magit-revert-and-commit :wk "revert commit")
  "vrn" '(magit-revert-no-commit :wk "revert no commit")

  "vh" '(:wk "helpinfo")
  "vhb" '(magit-branch :wk "branch")
  "vhc" '(magit-commit :wk "commit")
  "vhd" '(magit-dispatch :wk "dispatch")
  "vhe" '(magit-rebase :wk "rebase")
  "vhf" '(magit-fetch :wk "fetch")
  "vhl" '(magit-log :wk "log")
  "vhm" '(magit-merge :wk "merge")
  "vhp" '(magit-pull :wk "pull")
  "vhr" '(magit-reset :wk "reset")
  "vht" '(magit-tag :wk "tag")
  "vhu" '(magit-push :wk "push")
  "vhv" '(magit-revert :wk "revert")
  )

(leader-key "p" '(:wk "project")
  "pp" '(helm-projectile :wk "projectile")
  "pa" '(helm-projectile-ack :wk "ack")
  "pg" '(helm-projectile-grep :wk "grep")
  "pr" '(helm-projectile-recentf :wk "recentf")
  "ps" '(helm-projectile-switch-project :wk "switch")
  "pr" '(helm-projectile-rg :wk "rg")
  "pf" '(helm-projectile-find-file :wk "file")
  "pd" '(helm-projectile-find-dir :wk "dir")
  )

(leader-key "o" '(:wk "org")
  "ow" '(org-refile :wk "refile")
  "og" '(helpers/org-refile-to-datetree :wk "refile to gtd")
  "oa" '(helm-org-agenda-files-headings :wk "agenda")
  "oc" '(helm-org-capture-templates :wk "capture")
  "oh" '(helm-org-in-buffer-headings :wk "headings")
  "op" '(org-pomodoro :wk "pomodoro")
  )

(provide 'init-keymap)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-keymap.el ends here
