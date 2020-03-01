;; open config
(defun helpers/open-config (&optional name)
  "open config like init.el or lisp/init-helpers.el"
  (unless name "init.el")
  (find-file (format "~/.emacs.d/%s", name)))


(defun helpers/open-init-file ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun helpers/increase-window (&optional size) 
  "increase window width and height"
  (interactive)
  (unless size (setq size 25))
  (progn (evil-window-increase-width size)
         (evil-window-increase-height size)))

(defun helpers/decrease-window (&optional size)
    "decrease window width and height"
    (interactive)
    (unless size (setq size 25))
    (progn (evil-window-decrease-width size)
           (evil-window-decrease-height size)))

(defun helpers/set-window (&optional size)
    "set window width and height"
    (interactive)
    (unless size 25)
    (progn (evil-window-set-width size)
           (evil-window-set-height size)))

(defun helpers/max-window ()
    "set max window"
    (interactive)
    (helpers/set-window 100))

(defun helpers/min-window ()
  "set min window"
  (interactive)
  (helpers/set-window 0))

;;; buffer
(defun helpers/kill-other-buffer (&optional buf)
  "Close all of other buffer."
  (interactive)
  (unless buf (setq buf (current-buffer)))
  (dolist (buffer (delq buf (buffer-list))) (kill-buffer buffer)))


;; help
(defun helpers/helpful-at-point-dwim ()
  (interactive)
  (let ((symbol (symbol-at-point)))
    (if symbol (helpful-symbol symbol)
      (call-interactively #'helpful-symbol))))

;; fullscreen
(defun helpers/fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
                       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

(provide 'init-helpers)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-helpers.el ends here 
