;;; mane-2-theme.el --- mane-2
;;; Version: 1.0
;;; Commentary:
;;; A theme called mane-2
;;; Code:

(deftheme mane-2 "DOCSTRING for mane-2")
  (custom-theme-set-faces 'mane-2
   '(default ((t (:foreground "#fdf4c1" :background "#282828" ))))
   '(cursor ((t (:background "#fdf4c1" ))))
   '(fringe ((t (:background "#282828" ))))
   '(mode-line ((t (:foreground "#282828" :background "#7c6f64" ))))
   '(region ((t (:background "#504945" ))))
   '(secondary-selection ((t (:background "#3e3834" ))))
   '(font-lock-builtin-face ((t (:foreground "#fe8019" ))))
   '(font-lock-comment-face ((t (:foreground "#7c6f64" ))))
   '(font-lock-function-name-face ((t (:foreground "#b8bb26" ))))
   '(font-lock-keyword-face ((t (:foreground "#fb4934" ))))
   '(font-lock-string-face ((t (:foreground "#b8bb26" ))))
   '(font-lock-type-face ((t (:foreground "#d3869b" ))))
   '(font-lock-constant-face ((t (:foreground "#d3869b" ))))
   '(font-lock-variable-name-face ((t (:foreground "#83a598" ))))
   '(minibuffer-prompt ((t (:foreground "#b8bb26" :bold t ))))
   '(font-lock-warning-face ((t (:foreground "red" :bold t ))))
   )

;;;###autoload
(and load-file-name
    (boundp 'custom-theme-load-path)
    (add-to-list 'custom-theme-load-path
                 (file-name-as-directory
                  (file-name-directory load-file-name))))
;; Automatically add this theme to the load path

(provide-theme 'mane-2)

;;; mane-2-theme.el ends here
