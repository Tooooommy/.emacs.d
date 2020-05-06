;; @see https://orgmode.org
(use-package org
  :ensure t
  :bind (("C-c a" . org-agenda)
         ("C-c b" . org-switchb))
  :config
  ;; Babel
  (setq org-confirm-babel-evaluate nil
        org-src-fontify-natively t
        org-src-tab-acts-natively t)

  (defvar load-language-list '((emacs-lisp . t)
                               (perl . t)
                               (python . t)
                               (ruby . t)
                               (js . t)
                               (css . t)
                               (sass . t)
                               (C . t)
                               (java . t)
                               (plantuml . t)))

  (use-package ob-go
    :ensure t
    :init (cl-pushnew '(go . t) load-language-list))

  (use-package ob-rust
    :ensure t
    :init (cl-pushnew '(rust . t) load-language-list))

  (use-package ob-ipython
    :ensure t
    :if (executable-find "jupyter")     ; DO NOT remove
    :init (cl-pushnew '(ipython . t) load-language-list))

  (org-babel-do-load-languages 'org-babel-load-languages
                               load-language-list)

  ;; @see https://github.com/integral-dw/org-superstar-mode
  (use-package org-superstar
    :ensure t
    :defer t
    :hook (org-mode . org-superstar-mode)
    :init
    (setq org-superstar-prettify-item-bullets t
          org-superstar-headline-bullets-list '("◉" "✸" "⚫" "○" "•")
          org-superstar-leading-bullet ?\s
          org-hide-leading-stars t
          org-superstar-item-bullet-alist        '((?* . ?●)
                                                   (?+ . ?➤)
                                                   (?- . ?—))))

  (use-package evil-org
    :ensure t
    :defer t
    :after org evil
    :config
    (add-hook 'org-mode-hook 'evil-org-mode)
    (add-hook 'evil-org-mode-hook
              (lambda ()
                (evil-org-set-key-theme)))
    (require 'evil-org-agenda)
    (evil-org-agenda-set-keys))

  ;; @see https://github.com/louietan/anki-editor
  (use-package anki-editor
    :ensure t
    :defer t
    :hook (org-mode . anki-editor-mode)
    :custom
    (anki-editor-create-decks t))

  ;; @see https://github.com/kaushalmodi/ox-hugo
  (use-package ox-hugo
    :ensure t
    :after ox)

  ;; @see https://github.com/abo-abo/org-download
  (use-package org-download
    :ensure t
    :config
    (setq org-download-image-dir "~/Documents/org/images/"))

  ;; @see https://github.com/alphapapa/org-ql
  (use-package org-ql
    :ensure t
    :defer t)

  ;; @see https://github.com/alphapapa/org-super-agenda
  (use-package org-super-agenda
    :ensure t
    :config
    (let ((org-super-agenda-groups
           '(;; Each group has an implicit boolean OR operator between its selectors.
             (:name "Today"  ; Optionally specify section name
              :time-grid t  ; Items that appear on the time grid
              :todo "TODAY")  ; Items that have this TODO keyword
             (:name "Important"
              ;; Single arguments given alone
              :tag "bills"
              :priority "A")
             ;; Set order of multiple groups at once
             (:order-multi (2 (:name "Shopping in town"
                               ;; Boolean AND group matches items that match all subgroups
                               :and (:tag "shopping" :tag "@town"))
                              (:name "Food-related"
                               ;; Multiple args given in list with implicit OR
                               :tag ("food" "dinner"))
                              (:name "Personal"
                               :habit t
                               :tag "personal")
                              (:name "Space-related (non-moon-or-planet-related)"
                               ;; Regexps match case-insensitively on the entire entry
                               :and (:regexp ("space" "NASA")
                                     ;; Boolean NOT also has implicit OR between selectors
                                     :not (:regexp "moon" :tag "planet")))))
             ;; Groups supply their own section names when none are given
             (:todo "WAITING" :order 8)  ; Set order of this section
             (:todo ("SOMEDAY" "TO-READ" "CHECK" "TO-WATCH" "WATCHING")
              ;; Show this group at the end of the agenda (since it has the
              ;; highest number). If you specified this group last, items
              ;; with these todo keywords that e.g. have priority A would be
              ;; displayed in that group instead, because items are grouped
              ;; out in the order the groups are listed.
              :order 9)
             (:priority<= "B"
              ;; Show this section after "Today" and "Important", because
              ;; their order is unspecified, defaulting to 0. Sections
              ;; are displayed lowest-number-first.
              :order 1)
             ;; After the last group, the agenda will display items that didn't
             ;; match any of these groups, with the default order position of 99
             )))
      (org-agenda nil "a")))

  ;; @see https://github.com/Kungsgeten/org-brain
  (use-package org-brain
    :ensure t
    :init
    (setq org-brain-path "~/Documents/org/brain/")
    ;; For Evil users
    (with-eval-after-load 'evil
      (evil-set-initial-state 'org-brain-visualize-mode 'emacs))
    :config
    (setq org-id-track-globally t)
    (setq org-id-locations-file "~/.emacs.d/.org-id-locations")
    (add-hook 'before-save-hook #'org-brain-ensure-ids-in-buffer)
    (push '("b" "Brain" plain (function org-brain-goto-end)
            "* %i%?" :empty-lines 1)
          org-capture-templates)
    (setq org-brain-visualize-default-choices 'all)
    (setq org-brain-title-max-length 12)
    (setq org-brain-include-file-entries nil
          org-brain-file-entries-use-title nil))

  ;; Rich text clipboard
  ;; @see https://github.com/unhammer/org-rich-yank
  (use-package org-rich-yank
    :ensure t
    :bind (:map org-mode-map
           ("C-M-y" . org-rich-yank)))

  ;; Table of contents
  ;; @see https://github.com/snosov1/toc-org
  (use-package toc-org
    :ensure t
    :hook (org-mode . toc-org-mode))

  ;; Preview
  ;; @see https://github.com/lujun9972/org-preview-html
  (use-package org-preview-html
    :ensure t
    :diminish))

(provide 'init-org)

;;; init-org.el ends here
