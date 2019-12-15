;; @see https://github.com/cyrus-and/zoom
;; @see https://github.com/roman/golden-ratio.el
(use-package zoom
  :ensure t
  :init (zoom-mode t)
  :bind (("C-x +" . zoom)))

(provide 'init-zoom)

;;; init-zoom.el ends here
