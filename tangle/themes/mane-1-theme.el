;;; mane-1-theme.el --- mane-1
;;; Version: 1.0
;;; Commentary:
;;; A theme called mane-1
;;; Code:

(deftheme mane-1 "DOCSTRING for mane-1")
  (custom-theme-set-faces 'mane-1
   '(default ((t (:foreground "#333c43" :background "#fffbef" ))))
   '(cursor ((t (:background "#fffbef" ))))
   '(fringe ((t (:background "#eef0f0" ))))
   '(mode-line ((t (:foreground "#ffffff" :background "#6f8784" ))))
   '(region ((t (:background "#738aa1" ))))
   '(secondary-selection ((t (:background "#cddbec" ))))
   '(font-lock-builtin-face ((t (:foreground "#738aa1" ))))
   '(font-lock-comment-face ((t (:foreground "#7d827d" ))))
   '(font-lock-function-name-face ((t (:foreground "#846358" ))))
   '(font-lock-keyword-face ((t (:foreground "#105163" ))))
   '(font-lock-string-face ((t (:foreground "#4c7685" ))))
   '(font-lock-type-face ((t (:foreground "#157c99" ))))
   '(font-lock-constant-face ((t (:foreground "#375a0d" ))))
   '(font-lock-variable-name-face ((t (:foreground "#ac8d4b" ))))
   ;; '(minibuffer-prompt ((t (:foreground "#EBEBFF" :bold t ))))
   '(minibuffer-prompt ((t (:foreground "#00000F" :bold t ))))
   '(font-lock-warning-face ((t (:foreground "#730000" :bold t ))))
   )

;;;###autoload
(and load-file-name
    (boundp 'custom-theme-load-path)
    (add-to-list 'custom-theme-load-path
                 (file-name-as-directory
                  (file-name-directory load-file-name))))
;; Automatically add this theme to the load path

(provide-theme 'mane-1)

;;; mane-1-theme.el ends here
