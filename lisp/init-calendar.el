;; calendar
;; @see https://github.com/xwl/cal-china-x
(use-package cal-china-x
  :ensure t
  :after calendar
  :commands cal-china-x-setup
  :config
  ;; 成都
  (setq calendar-location-name "Chengdu"
        calendar-latitude 30.67
        calendar-longitude 104.06)
  ;; 节假日
  (setq calendar-mark-holidays-flag t)
  (setq cal-china-x-important-holidays cal-china-x-chinese-holidays)
  (setq cal-china-x-general-holidays
        '((holidays-lunar 1 15 "元宵节")
          (holidays-lunnar 7 7 "七夕节")
          (holidays-fixed 3 8 "妇女节")
          (holidays-fixed 3 12 "植树节")
          (holidays-fixed 5 4 "青年节")
          (holidays-fixed 6 1 "儿童节")
          (holidays-fixed 9 10 "教师节")))
  (setq holiday-other-holidays
        '((holidays-fixed 2 14 "情人节")
          (holidays-fixed 4 1 "愚人节")
          (holidays-fixed 12 25 "圣诞节")
          (holidays-fixed 5 0 2 "母亲节")
          (holidays-fixed 6 0 3 "父亲节")
          (holidays-fixed 11 4 4 "感恩节")))
  (setq calendar-holidays
        (append cal-china-x-important-holidays
                cal-china-x-general-holidays
                holiday-other-holidays)))

(provide 'init-calendar)
;;; init-calendar.el ends here
