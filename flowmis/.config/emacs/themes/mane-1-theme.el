;;; mane-1-theme.el --- mane-1
;;; Version: 1.0
;;; Commentary:
;;; A theme called mane-1
;;; Code:

(defvar mane-colors-alist-hell
  '(("bg1" .   "#f5f5dc") ;bg1 und bg2 müssen sehr ähnlich sein und bg3 kann etwas Kontrast haben, da sie als Markierfarbe dient
    ("bg2" .   "#f5f5dc")
    ("bg3" .   "#DBDBBB")
    ("fg1" .   "#462111")
    ("fg2" .   "#2A3131")
    ("fg3" .   "#003b46")
    ("org1" .  "#008BCD")
    ("org2" .  "#3595A0")
    ("org3" .  "#01B4CD")
    ("org4" .  "#32484B")
    ("org5" .  "#CCB054")     ;Kommentare
    ("check" . "#F50191")))

(defun mane-get-color-h (name)
  "Retrieve a color value by name."
  (cdr (assoc name mane-colors-alist-hell)))

(deftheme mane-1 "DOCSTRING for mane-1")

(custom-theme-set-faces 'mane-1
  `(default ((t (:foreground ,(mane-get-color-h "fg1") :background ,(mane-get-color-h "bg1")))))
  `(cursor ((t (:background ,(mane-get-color-h "fg1")))))
  `(fringe ((t (:background ,(mane-get-color-h "bg2"))))) ; Rand Links & rechts vom Buffer
  `(mode-line ((t (:foreground ,(mane-get-color-h "fg2") :background ,(mane-get-color-h "bg2")))))
  `(region ((t (:background ,(mane-get-color-h "bg3"))))) ;Markierfarbe
  ;; Spezifisch für Org-Mode
  `(font-lock-function-name-face ((t (:foreground ,(mane-get-color-h "org1"))))) ;org-header level 1
  `(font-lock-variable-name-face ((t (:foreground ,(mane-get-color-h "org2"))))) ;org-header Level 2
  `(font-lock-keyword-face ((t (:foreground ,(mane-get-color-h "org3"))))) ;org-header level 3
  `(font-lock-comment-face ((t (:foreground ,(mane-get-color-h "org5"))))) ;Kommentare und org-header-level 4
  `(font-lock-type-face ((t (:foreground ,(mane-get-color-h "org5"))))) ;org-header level 5
  `(font-lock-constant-face ((t (:foreground ,(mane-get-color-h "org5"))))) ;org-header level 6
  `(org-link ((t (:foreground ,(mane-get-color-h "org2") :underline t)))) ;; Farbe und Stil für Links
  `(org-table ((t (:foreground ,(mane-get-color-h "org2") :background ,(mane-get-color-h "bg2"))))) ;; Farbe und Hintergrund für Tabellen
  `(org-drawer ((t (:foreground ,(mane-get-color-h "org2"))))) ;; Farbe für Drawers
  `(org-block ((t (:background ,(mane-get-color-h "bg1"))))) ;; Hintergrundfarbe für Source Blocks
  `(org-block-begin-line ((t (:foreground ,(mane-get-color-h "fg1") :background ,(mane-get-color-h "bg1"))))) ;; Farbe und Hintergrund für die Anfangszeile von Source Blocks
  `(org-block-end-line ((t (:foreground ,(mane-get-color-h "fg1") :background ,(mane-get-color-h "bg1"))))) ;; Farbe und Hintergrund für die Endzeile von Source Blocks
  `(secondary-selection ((t (:background ,(mane-get-color-h "check"))))) ;?
  ;;ab hier für org-mode weniger relevant
  `(font-lock-builtin-face ((t (:foreground ,(mane-get-color-h "org1"))))) ;Schrift wie hier :foreground etc.
  `(font-lock-string-face ((t (:foreground ,(mane-get-color-h "org2") )))) ;Documentation Strings für Funktionen und Anführungszeichen in Code-Dateien
  `(minibuffer-prompt ((t (:foreground ,(mane-get-color-h "org3") :bold t ))))
  `(font-lock-warning-face ((t (:foreground ,(mane-get-color-h "org4") :bold t ))))
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
