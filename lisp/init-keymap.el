;; https://github.com/justbur/emacs-which-key
(use-package which-key
  :ensure t
  :defer 3
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
  :defer 3
  :config
  (general-evil-setup)
  (general-create-definer leader-key :prefix "SPC" :states '(normal visual motion) :keymaps 'override :wk "leader")

  
  ;; emacs key bind like
  (general-define-key [f11] 'helpers/fullscreen)
  (general-define-key "M-x" 'helm-M-x :keymaps 'override) ;; 重新绑定
  (general-define-key "C-x C-f" 'helm-find-files :keymaps 'override)
  (general-define-key "gd" 'xref-find-definitions :states '(normal visual motion) :keymaps 'override :wk "jump")
  (general-define-key "gb" 'xref-pop-marker-stack :states '(normal visual motion) :keymaps 'override :wk "back")
  (general-define-key "C-o" 'xref-pop-marker-stack :states '(normal visual motion) :keymaps 'override :wk "back")

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

    ;; git
    "fg" '(helm-ls-git-ls :wk "git")
    "f." '(helm-gitignore :wk "gitignore")

    ;; run
    "fy" '(quickrun :wk "quickrun")
    )


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
  (leader-key "g" '(:wk "dumb jump")
    "gd" '(dumb-jump-go :wk "go")
    "go" '(dumb-jump-back :wk "back")
    "gw" '(dumb-jump-go-other-window :wk "go other window")
    "gc" '(dumb-jump-go-current-window :wk "go current window"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; language
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (leader-key "i" '(:wk "init")
    "ir" '(:wk "rust & cargo")
    "iri" '(cargo-process-init :wk "init")
    "irn" '(cargo-process-new :wk "new"))

  (leader-key "l" '(:wk "lsp")
    "lm" '(lsp-ui-imenu :wk "imenu")
    "lr" '(lsp-rename :wk "rename")
    "ld" '(lsp-find-definition :wk "definition")
    "lf" '(lsp-find-references :wk "references")
    "li" '(lsp-find-implementation :wk "implementation")
    "lw" '(lsp-find-workspace :wk "workspace")

    "lp" '(:wk "peek")
    "lpd" '(lsp-ui-peek-find-definitions :wk "definitions")
    "lpf" '(lsp-ui-peek-find-references :wk "references")
    "lpi" '(lsp-ui-peek-find-implementation :wk "implementation")
    "lpw" '(lsp-ui-peek-find-workspace-symbol :wk "workspace-symbol"))

  ;; golang
  (leader-key "m" '(:wk "golang")
    :keymaps 'go-mode-map 
    "mm" '(go-run :wk "run")
    "mi" '(go-import-add :wk "add")
    "mf" '(go-fill-struct :wk "fill struct")

    "ma" '(:wk "tag")
    "maa" '(go-tag-add :wk "add")
    "mad" '(go-tag-remove :wk "remove")
    "mar" '(go-tag-refresh :wk "refresh")

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
  (leader-key "r" '(:wk "rust & cargo")
    :keymaps 'rust-mode-map
    "mm" '(rust-run :wk "run")
    "mc" '(rust-compile :wk "build")
    "mi" '(cargo-process-add :wk "add")

    "ru" '(:wk "run")
    "rub" '(cargo-process-run-bin :wk "bin")
    "ruc" '(cargo-process-build :wk "compile")
    "rue" '(cargo-process-run-example :wk "example")
    "ruu" '(cargo-process-run :wk "run")

    "rt" '(:wk "test")
    "rtt" '(cargo-process-test :wk "test")
    "rtc" '(cargo-process-current-test :wk "current")
    "rtf" '(cargo-process-current-file-tests :wk "file")

    "rb" '(cargo-process-bench :wk "bench")
    )
  ;; version control
  (leader-key "v" '(:wk "version control")
    "va" '(magit-stage :wk "stage")
    "vb" '(magit-branch :wk "branch")
    "vc" '(magit-commit :wk "commit")
    "vd" '(magit-stash :wk "stash")
    "ve" '(magit-reset :wk "reset")
    "vf" '(magit-fetch :wk "fetch")
    "vs" '(magit-status :wk "status")
    "vn" '(magit-init :wk "init")
    "vg" '(magit-checkout :wk "checkout")
    "vo" '(magit-clone :wk "clone")
    "v." '(magit-gitignore :wk "ignore")
    "vt" '(magit-tag :wk "tag") 
    "vm" '(magit-merge :wk "merge")
    "mr" '(magit-rebase :wk "rebase")
    "vl" '(magit-log :wk "log")
    "vp" '(magit-pull :wk "push")
    "vu" '(magit-push :wk "push")
    "vk" '(magit-revert :wk "revert")
    "vv" '(magit-version :wk "version")
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
    ))

(provide 'init-keymap)
;;; init-keymap.el ends here
