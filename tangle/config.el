(defun activate-ditaa-path ()
 (interactive)
 (setq org-ditaa-jar-path "/usr/share/java/ditaa/ditaa-0.11.jar"))

(defun pres-start ()
  "Starte org-tree-slide presentation"
  (interactive)
  (org-tree-slide-mode 1)
  (load-theme 'doom-henna)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (hide-mode-line-mode 1)
  (beacon-mode -1)
  (centered-cursor-mode 1)
  (org-display-inline-images)           ;<M-x org-toggle-inline-images> sollte vor dem öffnen des Präsentationsmodus <M-x org-tree-slide-mode> ausgeführt um sicher zu sein dass alle Bilder angezeigt werde und dieser code sorgt dafür dass dies der Fall ist  -> alternativ vll auch mal org-startup-with-inline-images anschauen
  (setq text-scale-mode-amount 3)
  (text-scale-mode 1)
  (setq visual-fill-column-width 80     ;Größe des seitlichen Rahmen
        visual-fill-column-center-text t) ;rückt Text in Mitte
  (visual-fill-column-mode 1)           ;braucht man um seitlichen Rahmen zu füllen (hier nichts umstellen)
  (display-line-numbers-mode -1)        ;schaltet line-numbers aus
  (visual-line-mode t)                  ;sorgt dafür dass alles an Text sichtbar ist (umgebrochen wird)
  (set-face-attribute 'org-document-title nil :font "Fira Code" :weight 'bold :height 1.4) ;Einstellungen Titel Präsi
  (set-frame-parameter (selected-frame) 'alpha '(85 . 50)))

(defun pres-end ()
  "Beende org-tree-slide presentation"
  (interactive)
  (org-tree-slide-mode -1)
  (load-theme 'doom-molokai)
  (doom-modeline-mode 1)
  (beacon-mode 1)
  (centered-cursor-mode -1)
  (org-display-inline-images -1)
  (setq visual-fill-column-width 110    ;Größe des seitlichen Rahmen
        visual-fill-column-center-text nil) ;rückt Text in Mitte
  (visual-fill-column-mode -1)          ;braucht man um seitlichen Rahmen zu füllen (hier nichts umstellen)
  (display-line-numbers-mode 1)         ;schaltet line-numbers aus
  (text-scale-mode -1)
  (set-frame-parameter (selected-frame) 'alpha '(95 . 70)))

(defun mane-theme-zusatzeinstellungen ()
  "Paar Anpassungen von mir die ich mit dieser Funktion in der config, oder interaktiv ein-ausschalten kann"
  (interactive)
  ;; (setq text-scale-mode-amount 1)
  ;; (text-scale-mode 1)
  (custom-theme-set-faces               ;<M-x describe-theme> um Einblick in Möglichkeiten zu bekommen
   'user
   '(org-level-1 ((t (:inherit outline-1 :font "URW Bookman Light" :height 1.8 ))))
   '(org-level-2 ((t (:inherit outline-2 :height 1.5 ))))
   '(org-level-3 ((t (:inherit outline-3 :height 1.3 ))))
   '(org-level-4 ((t (:inherit outline-4 :height 1.1 ))))
   '(org-level-5 ((t (:inherit outline-5 :height 1.0 ))))
   '(org-block ((t (:inherit fixed-pitch))))
   '(org-code ((t (:inherit (shadow fixed-pitch)))))
   '(org-document-info ((t (:height 1.1))))
   '(org-document-title ((t (:height 2.1))))
   '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
   ;; '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
   ;; '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   ;; '(org-property-value ((t (:inherit fixed-pitch))) t)
   ;; '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   ;; '(org-table ((t (:inherit fixed-pitch))))
   ;; '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 1.4 :foreground "#00606b"))))
   ;; '(org-verbatim ((t (:inherit (shadow fixed-pitch) :foreground "#ff0000" :height 1.4 :weight bold))))                         ;Farbe und Größe etc. von markiertem Text durch umgebende =
   ))
;;;Hook der Funktionen nach starten von Doom automatisch aktiviert!
(add-hook 'after-init-hook #'mane-theme-zusatzeinstellungen)
