;;; mane-2-theme.el --- mane-2
;;; Version: 1.0
;;; Commentary:
;;; A theme called mane-2
;;; Code:

(defvar mane-colors-alist-dunkel
  '(("bg1" .   "#3E3E3E")
    ("bg2" .   "#444444")
    ("bg3" .   "#666666")
    ("fg1" .   "#fffbef")
    ("fg2" .   "#fffbdf")
    ("fg3" .   "#E7E1E5")
    ("org1" .  "#ddbbaa")
    ("org2" .  "#75B8C8")
    ("org3" .  "#77CBB9")
    ("org4" .  "#B89E97")
    ("org5" .  "#C492B1")
    ("check" . "#C412FF")))

(defun mane-get-color-d (name)  ;brauche ich hier glaub nicht da ich es ja schon in theme 1 habe
  "Retrieve a color value by name."
  (cdr (assoc name mane-colors-alist-dunkel)))

(deftheme mane-2 "DOCSTRING for mane-2")

(custom-theme-set-faces 'mane-2
  `(default ((t (:foreground ,(mane-get-color-d "fg1") :background ,(mane-get-color-d "bg1")))))
  `(cursor ((t (:background ,(mane-get-color-d "fg1")))))
  `(fringe ((t (:background ,(mane-get-color-d "bg2"))))) ; Rand Links & rechts vom Buffer
  `(mode-line ((t (:foreground ,(mane-get-color-d "fg2") :background ,(mane-get-color-d "bg2")))))
  `(region ((t (:background ,(mane-get-color-d "bg3"))))) ;Markierfarbe
  ;; Spezifisch für Org-Mode
  `(font-lock-function-name-face ((t (:foreground ,(mane-get-color-d "org1"))))) ;org-header level 1
  `(font-lock-variable-name-face ((t (:foreground ,(mane-get-color-d "org2"))))) ;org-header Level 2
  `(font-lock-keyword-face ((t (:foreground ,(mane-get-color-d "org3"))))) ;org-header level 3
  `(font-lock-comment-face ((t (:foreground ,(mane-get-color-d "org4"))))) ;Kommentare und org-header-level 4
  `(font-lock-type-face ((t (:foreground ,(mane-get-color-d "org5"))))) ;org-header level 5
  `(font-lock-constant-face ((t (:foreground ,(mane-get-color-d "org5"))))) ;org-header level 6
  `(org-link ((t (:foreground ,(mane-get-color-d "org2") :underline t)))) ;; Farbe und Stil für Links
  `(org-table ((t (:foreground ,(mane-get-color-d "org2") :background ,(mane-get-color-d "bg2"))))) ;; Farbe und Hintergrund für Tabellen
  `(org-drawer ((t (:foreground ,(mane-get-color-d "org2"))))) ;; Farbe für Drawers
  `(org-block ((t (:background ,(mane-get-color-d "bg2"))))) ;; Hintergrundfarbe für Source Blocks
  `(org-block-begin-line ((t (:foreground ,(mane-get-color-d "fg1") :background ,(mane-get-color-d "bg1"))))) ;; Farbe und Hintergrund für die Anfangszeile von Source Blocks
  `(org-block-end-line ((t (:foreground ,(mane-get-color-d "fg1") :background ,(mane-get-color-d "bg1"))))) ;; Farbe und Hintergrund für die Endzeile von Source Blocks
  `(secondary-selection ((t (:background ,(mane-get-color-d "check"))))) ;?
  ;;ab hier für org-mode weniger relevant
  `(font-lock-builtin-face ((t (:foreground ,(mane-get-color-d "org1"))))) ;Schrift wie hier :foreground etc.
  `(font-lock-string-face ((t (:foreground ,(mane-get-color-d "org2") )))) ;Documentation Strings für Funktionen und Anführungszeichen in Code-Dateien
  `(minibuffer-prompt ((t (:foreground ,(mane-get-color-d "org3") :bold t ))))
  `(font-lock-warning-face ((t (:foreground ,(mane-get-color-d "org4") :bold t ))))
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
