;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;;INIT AFTER ORG;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(after! org
  :init
  (setq user-full-name "Markus Hoffmann"
        user-mail-address "manemarkushoffmann@gmail.com"                                                        ;GPG configuration, email clients, file templates and snippets,... can use this information - ist optional
        undo-tree-auto-save-history t
        undo-tree-history-directory-alist '(("." . "~/Dropbox/emacs/undo-tree-history"))
        save-interprogram-paste-before-kill t                                                                   ;Speichert kopierte Inhalte ausserhalb Emacs in den kill ring und macht es leichter bei zwischenzeitlichem löschen innerhalb Emacs das kopierte doch einzufügen
        org-log-into-drawer 1                                                                                   ;Notes mit <C-c C-z> werden direkt in den Drawer :LOGBOOK: geschrieben wenn dieser vorhanden ist
        yas-snippet-dirs '("~/Dropbox/emacs/yasnippets/")
        yas-global-mode 1
        doom-scratch-initial-major-mode 'lisp-interaction-mode                                                  ;scratch buffer automatisch im elisp mode um Dinge zu testen
        org-startup-folded 'show2levels                                                                         ;beim Start werden Header bis zum 2 Level angezeigt
        confirm-kill-emacs nil                                                                                  ;kein nerviges nachfragen ob Emacs wirklich geschlossen werden soll
        org-publish-use-timestamps-flag nil                                                                     ;exportiert alles - macht Export leichter nachzuvollziehen
        org-export-with-broken-links t                                                                          ;macht auch einen Export wenn nicht alles passt - sometimes better than nothing
        org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js"                                                ;"file:///home/flowmi/Git/pres/reveal" -> ist lokaler Pfad?
        org-reveal-mathjax t                                                                                    ;brauch ich es oder geht es auch ohne?
        eshell-rc-script "~/.config/doom/eshell/profile"
        eshell-aliases-file "~/.config/doom/eshell/aliases"
        eshell-buffer-maximum-lines 5000
        eshell-scroll-to-bottom-on-input t
        org-directory "~/Dropbox/emacs/org-roam/Notizen/"
        org-agenda-files '("~/Dropbox/emacs/org-roam/Notizen/orga/agenda.org"
                           "~/FlowmisOS/FlowmisOS.org"
                           "~/Dropbox/emacs/org-roam/Notizen/orga/20220808171101-Home.org"
                           "~/Dropbox/emacs/org-roam/Notizen/20220416144259-dlt.org"
                           "~/Dropbox/emacs/org-roam/Notizen/20220322102912-bucher.org")))
;;;Dashboard;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(after! org
  :dashboard
  (let ((alternatives '("banner1.png"
                        "banner2.png"
                        "banner3.png"
                        "banner4.png"
                        "banner5.png"
                        "banner6.png"
                        "banner7.png"
                        "banner8.png")))
    (setq fancy-splash-image
          (concat "~/.config/doom/banner/"
                  (nth (random (length alternatives)) alternatives))))
  (setq +doom-dashboard-name "*Startscreen*"
        +doom-dashboard-menu-sections (cl-subseq +doom-dashboard-menu-sections 0 3)
        doom-fallback-buffer-name "*Startscreen*"))
;;;CONFIG AFTER ORG;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(after! org
  :config
  (beacon-mode 1)                                                                                               ;hilft den Cursor schnell zu finden durch aufblinken
  ;; (setq display-line-numbers-type 'visual)                                                                   ;Einstellung falls ich Zeilennummern angezeigt bekommen will
  (setq display-line-numbers-type nil                                                                           ;schaltet Zeilennummern aus
        doom-theme 'doom-molokai                                                                                ;setzt das Theme (Mit <Spc ht> neue ausprobieren)
        doom-font (font-spec :family "Source Code Pro" :size 13)                                                ;setzt Schriftart etc.
        doom-variable-pitch-font (font-spec :family "Fira Code" :size 13)                                       ;wird mit variable-pitch-mode aktiviert -> Man kann auch einstellen dass beide Schriftarten in Org Datei für unterschiedliche Elemente verwendet werden
        doom-big-font (font-spec :family "Source Code Pro" :size 20)                                            ;gut für Präsentationen (Schriftgröße etc noch anpassen)
        doom-unicode-font (font-spec :family "Source Code Pro" :size 13)
        doom-serif-font (font-spec :family "Source Code Pro" :size 10)
        org-superstar-headline-bullets-list '(" ")                                                              ;wird mit +pretty flag in init.el installiert und erlaubt mir die Einstellung der Punkte vor Org-Headern
        ;; org-superstar-headline-bullets-list '("◉" "○" "✿")                                                      ;wenn ich Bullets will hier deren Erscheinungsform einstellen (Anzahl egal da es durch Liste cycled)
        org-ellipsis " ▼ "                                                                                      ;Zeigt an das unter diesem Punkt eingefaltete Information liegt
        org-hide-emphasis-markers t                                                                             ;Markierungssymbole um kursiv, dick, unterstrichen,... unsichtbar (~-_/*= um Wörter werden ausgeblendet)
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-log-done 'time
        org-journal-dir "~/Dropbox/emacs/org-roam/Notizen/orga/journal/"
        org-journal-date-format "%B %d, %Y (%A) "
        org-journal-file-format "%Y-%m-%d.org"
        org-tag-alist (quote ((:startgroup)
                              ("@Work" . ?w)                                                                  ;@ macht es zu mutual exclusiv tags die weggehen wenn anderer tag eingestellt wird
                              ("@Home" . ?h)
                              ("@Ökonomie" . ?o)
                              ("@Gesundheit" . ?g)
                              (:endgroup)
                              ("noexport" . ?n)
                              ("Buch" . ?b)
                              ("Volleyball" . ?v)
                              ("Sport" . ?s)
                              ("History" . ?H)
                              ("LehrenLernen" . ?l)
                              ("Programmieren" . ?p)
                              ("Schule" . ?S)
                              ("Weisheit" . ?W)
                              ("Organisation" . ?O)))
        org-todo-keywords '((sequence
                             "EILIG(e)"
                             "ZEITNAH(z)"
                             "IRGENDWANN(i)"
                             "PAUSIERT(p@/!)"
                             "|"                                                                                ;pipe separiert "active" states and "inactive" states -> Emacs checkt es dann
                             "BEENDET(b@/!)"
                             "ABGEBROCHEN(a@/!)"
                             "DELEGIERT(d@/!)"))
        org-todo-keyword-faces
                (quote (("EILIG" :foreground "red" :weight bold)
                        ("ZEITNAH" :foreground "magenta" :weight bold)
                        ("IRGENDWANN" :foreground "yellow" :weight bold)
                        ("PAUSIERT" :foreground "light blue" :weight bold)
                        ("BEENDET" :foreground "black" :weight bold)
                        ("ABGEBROCHEN" :foreground "black" :weight bold)
                        ("DELEGIERT" :foreground "grey" :weight bold)))
        org-capture-templates '(("1" "Eilig" checkitem
                                 (file+headline "~/Dropbox/emacs/org-roam/Notizen/orga/20220808171101-Home.org" "Eilig"))
                                ("2" "Zeitnah" checkitem
                                 (file+headline "~/Dropbox/emacs/org-roam/Notizen/orga/20220808171101-Home.org" "Zeitnah"))
                                ("3" "Irgendwann" checkitem
                                 (file+headline "~/Dropbox/emacs/org-roam/Notizen/orga/20220808171101-Home.org" "Irgendwann"))
                                ("4" "Einkaufsliste Mane" checkitem
                                 (file+headline "~/Dropbox/emacs/org-roam/Notizen/orga/20220808171101-Home.org" "Einkaufsliste Mane"))
                                ("5" "Einkaufsliste Joana" checkitem
                                 (file+headline "~/Dropbox/emacs/org-roam/Notizen/orga/20220808171101-Home.org" "Einkaufsliste Joana"))
                                ("6" "Gemeinsame Einkaufsliste" checkitem
                                 (file+headline "~/Dropbox/emacs/org-roam/Notizen/orga/20220808171101-Home.org" "Gemeinsame Einkaufsliste"))
                                ("7" "Wunschliste Mane" checkitem
                                 (file+headline "~/Dropbox/emacs/org-roam/Notizen/orga/20220808171101-Home.org" "Wunschliste Mane"))
                                ("8" "Neue Abrechnung" table-line
                                 (file+headline "~/Dropbox/emacs/org-roam/Notizen/orga/20220808171101-Home.org" "Abrechnungen Jo"))
                                ("t" "Gedanken und Sonstiges" entry
                                 (file+datetree "~/Dropbox/emacs/org-roam/Notizen/orga/20220415105725-journal.org")
                                 "* %^{Description}      Hinzugefügt am: %U      %^g"))
        org-roam-directory "~/Dropbox/emacs/org-roam/Notizen"
        org-roam-db-autosync-mode 1
        org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t
        org-roam-capture-templates '(("b" "book notes" plain (file "~/Dropbox/emacs/org-roam/templates/BookTemplate.org")
                                      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
                                      :unnarrowed t)
                                     ("n" "normal/einfach nur mit Datum" plain (file "~/Dropbox/emacs/org-roam/templates/normal.org")
                                      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
                                      :unnarrowed t)
                                     ("z" "Zitate/Prinzipien/Weisheiten/Definitionen" plain (file "~/Dropbox/emacs/org-roam/templates/Zitate.org")
                                      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
                                      :unnarrowed t))
        ;; org-fancy-priorities-list '((?A . "⏰")                                                              ;wird mit +pretty flag in init.el installiert, aber macht es finde ich hässlich
        ;;                             (?B . "🐶")
        ;;                             (?C . "🌞")
        ;;                             (?D . "⏰")
        ;;                             (?1 . "🍽")
        ;;                             (?2 . "☕")
        ;;                             (?I . "Important"))
        )
  (set-frame-parameter (selected-frame) 'alpha '(95 . 70))                                                      ;Zahl 1 nach alpha gibt Transparenz des aktiven Bildschirms und Zahl 2 gibt Transparenz wenn anderes Window im Focus ist
  (custom-set-faces '(org-level-1 ((t (:inherit outline-1 :height 1.28 :underline nil))))
                    '(org-level-2 ((t (:inherit outline-2 :height 1.22 :underline nil))))
                    '(org-level-3 ((t (:inherit outline-3 :height 1.16 :underline nil))))
                    '(org-level-4 ((t (:inherit outline-4 :height 1.10 :underline nil))))
                    '(org-level-5 ((t (:inherit outline-5 :height 1.04 :underline nil)))))
  (custom-set-faces!
        '(font-lock-comment-face :slant italic)                                                                 ;Macht Kommentare wie diesen kursiv
        '(font-lock-keyword-face :slant italic)))                                                               ;Macht Keywords wie setq, after! ... kursiv
;;;DIRED;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(after! dired
  :hook
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
  :config
  (setq dired-open-extensions '(("gif" . "vlc")                                                                 ;Enter(oder l) in Dired auf Datei mit dieser angegebenen Endung öffnet externes angegebenes Programm
                                ("jpg" . "pinta")
                                ("png" . "pinta")
                                ("mkv" . "vlc")
                                ("html" . "brave")
                                ("mp4" . "vlc"))))
(require 'ox-reveal)                                                                                            ;Macht das ox-reveal funktioniert - geht glaub auch über init.el - langfristig anpassen auf meine Lieblingseinstellungen oder hier raus werfen

(global-set-key (kbd "M-v") 'er/expand-region) ;markiert bei jeder Wiederholung immer weiter nach aussen --> Macht es einem leicht bestimmte logische Bereiche schnell zu markieren
(global-set-key (kbd "M-p") 'yank-from-kill-ring) ;zeigt kill ring - man kann auswählen was man von dem zuvor gekilltem einfügen will
(map! :leader
       :desc "Org babel tangle" "m B" #'org-babel-tangle
       :desc "Clone indirect buffer other window" "b c" #'clone-indirect-buffer-other-window
       :desc "Eshell" "e s" #'eshell
       :desc "Counsel eshell history" "e h" #'counsel-esh-history
      (:prefix ("-" . "open file")
       :desc "Edit agenda file" "a" #'(lambda () (interactive) (find-file "~/Dropbox/emacs/org-roam/Notizen/orga/agenda.org"))
       :desc "Edit FlowmisOs.org" "f" #'(lambda () (interactive) (find-file "~/FlowmisOS/FlowmisOS.org"))
       :desc "Edit eshell aliases" "e a" #'(lambda () (interactive) (find-file "~/.config/doom/eshell/aliases"))
       :desc "Edit eshell aliases" "e p" #'(lambda () (interactive) (find-file "~/.config/doom/eshell/profile"))
       :desc "Edit qtile config" "q" #'(lambda () (interactive) (find-file "~/.config/qtile/config.py"))
       :desc "Edit Home" "h" #'(lambda () (interactive) (find-file "~/Dropbox/emacs/org-roam/Notizen/orga/20220808171101-Home.org"))
       :desc "Edit Work" "w" #'(lambda () (interactive) (find-file "~/Dropbox/emacs/org-roam/Notizen/orga/20220817132032-Work.org"))
       :desc "Edit Bücher" "b" #'(lambda () (interactive) (find-file "~/Dropbox/emacs/org-roam/Notizen/20220322102912-bücher.org"))
       :desc "Edit local/tangled doom config.el" "c" #'(lambda () (interactive) (find-file "~/.config/doom/config.el"))
       :desc "Edit local/tangled doom init.el" "i" #'(lambda () (interactive) (find-file "~/.config/doom/init.el"))
       :desc "Edit local/tangled doom packages.el" "p" #'(lambda () (interactive) (find-file "~/.config/doom/packages.el")))
      (:prefix ("e". "evaluate/EWW")
       :desc "Evaluate elisp in buffer" "b" #'eval-buffer
       :desc "Evaluate defun" "d" #'eval-defun
       :desc "Evaluate elisp expression" "e" #'eval-expression
       :desc "Evaluate last sexpression" "l" #'eval-last-sexp
       :desc "Evaluate elisp in region" "r" #'eval-region)
      (:prefix ("w" . "window")
       :desc "Winner undo" "<left>" #'winner-undo ;schaut was die letzte Window configuration war und geht dahin zurück
       :desc "Winner redo" "<right>" #'winner-redo) ;geht in andere Richtung wie winner-undo
      (:prefix ("d" . "dired")
       :desc "Open dired" "d" #'dired
       :desc "Dired jump to current" "j" #'dired-jump)
       :desc "Comment or uncomment lines" "TAB TAB" #'comment-line
      (:prefix ("t" . "toggle")
       :desc "Toggle line numbers" "l" #'doom/toggle-line-numbers
       :desc "Toggle line highlight in frame" "h" #'hl-line-mode
       :desc "Toggle line highlight globally" "H" #'global-hl-line-mode
       :desc "Toggle truncate lines" "t" #'toggle-truncate-lines)
      (:prefix ("r" . "registers")
       :desc "Window configuration to register" "w" #'window-configuration-to-register
       :desc "Frameset to register" "f" #'frameset-to-register
       :desc "Jump to register" "j" #'jump-to-register
       :desc "List registers" "l" #'list-registers
       :desc "View a register" "v" #'view-register
       :desc "Point to register" "SPC" #'point-to-register)
      (:prefix ("b". "buffer")
       :desc "List bookmarks" "L" #'list-bookmarks
       :desc "Save current bookmarks to bookmark file" "w" #'bookmark-save)
      (:prefix ("v". "Manes Funktionen")
       :desc "Capture Today - Daily Journaling?" "d" #'org-roam-dailies-capture-today
       :desc "org-roam-buffer-toggle" "u" #'org-roam-ui-open
       :desc "find node/new node" "f" #'org-roam-node-find
       :desc "insert node" "i" #'org-roam-node-insert
       :desc "make ditaa work" "d" #'activate-ditaa-path
       :desc "Starte Präsentationsmodus" "p" #'pres-start
       :desc "Beende Präsentationsmodus" "P" #'pres-end))
(evil-define-key 'normal dired-mode-map
  (kbd "M-RET") 'dired-display-file
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-open-file ; use dired-find-file instead of dired-open.
  (kbd "m") 'dired-mark
  (kbd "t") 'dired-toggle-marks
  (kbd "u") 'dired-unmark
  (kbd "C") 'dired-do-copy
  (kbd "D") 'dired-do-delete
  (kbd "J") 'dired-goto-file
  (kbd "M") 'dired-chmod
  (kbd "O") 'dired-chown
  (kbd "P") 'dired-do-print
  (kbd "R") 'dired-rename
  (kbd "T") 'dired-do-touch
  (kbd "Y") 'dired-copy-filenamecopy-filename-as-kill ; copies filename to kill ring.
  (kbd "+") 'dired-create-directory
  (kbd "-") 'dired-up-directory
  (kbd "% l") 'dired-downcase
  (kbd "% u") 'dired-upcase
  (kbd "; d") 'epa-dired-do-decrypt
  (kbd "; e") 'epa-dired-do-encrypt)
;; (defun prefer-horizontal-split ()
;;   (set-variable 'split-height-threshold nil t)
;;   (set-variable 'split-width-threshold 40 t)) ; make this as low as needed
;; (add-hook 'markdown-mode-hook 'prefer-horizontal-split)

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
