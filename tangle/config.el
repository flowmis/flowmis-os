;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;;INIT AFTER ORG;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(after! org
  :init
  (setq user-full-name "Markus Hoffmann"
        undo-tree-auto-save-history t
        undo-tree-history-directory-alist '(("." . "~/Dropbox/2nd-brain/undo-tree-history/"))
        save-interprogram-paste-before-kill t                                                                   ;Speichert kopierte Inhalte ausserhalb Emacs in den kill ring und macht es leichter bei zwischenzeitlichem löschen innerhalb Emacs das kopierte doch einzufügen
        org-log-into-drawer 1                                                                                   ;Notes mit <C-c C-z> werden direkt in den Drawer :LOGBOOK: geschrieben wenn dieser vorhanden ist
        doom-scratch-initial-major-mode 'lisp-interaction-mode                                                  ;scratch buffer automatisch im elisp mode um Dinge zu testen
        org-startup-folded 'show3levels                                                                         ;beim Start werden Header bis zum 3 Level angezeigt
        confirm-kill-emacs nil                                                                                  ;kein nerviges nachfragen ob Emacs wirklich geschlossen werden soll
        org-publish-use-timestamps-flag nil                                                                     ;exportiert alles - macht Export leichter nachzuvollziehen
        org-export-with-broken-links t                                                                          ;macht auch einen Export wenn nicht alles passt - sometimes better than nothing
        org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js"                                                ;"file:///home/flowmis/pages/reveal" -> ist lokaler Pfad?
        org-reveal-mathjax t                                                                                    ;brauch ich es oder geht es auch ohne?
        eshell-rc-script "~/.config/doom/eshell/profile"
        eshell-aliases-file "~/.config/doom/eshell/aliases"
        eshell-buffer-maximum-lines 5000
        eshell-scroll-to-bottom-on-input t
        org-directory "~/Dropbox/2nd-brain/org-roam-notes/"
        ))
;;;CONFIG AFTER ORG;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(after! org
  :config
  (setq doom-theme 'doom-mane                                                                                   ;setzt das Theme (Mit <Spc ht> neue ausprobieren)
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-log-done 'time
        delete-by-moving-to-trash t     ;oder 'move-file-to-trash t'??
        trash-directory "~/.papierkorb/" ;muss den Ordner manuell erstellen in Windows? Wenn etwas aus diesem Ordner gelöscht wird geht es glaub in den Systemtrash - also dann nicht mehr mein Papierkorb
        ;; org-journal-dir "~/Dropbox/2nd-brain/org-roam-notes/roam-orga/journal/"
        org-journal-date-format "%B %d, %Y (%A) "
        org-journal-file-format "%Y-%m-%d.org"
        org-tag-alist (quote ((:startgroup) ("@Work" . ?w) ("@Home" . ?h) ("@Projekt" . ?p) ("@Ökonomie" . ?o) ("@Gesundheit" . ?g)       ;@ macht es zu mutual exclusiv tags die weggehen wenn anderer tag eingestellt wird
                              (:endgroup) ("noexport" . ?n) ("Mane" . ?M) ("Joana" . ?J) ("Schule" . ?S)))
        org-capture-templates '(("1" "TODO" entry (file+headline "~/Dropbox/2nd-brain/org-roam-notes/roam-orga/home.org" "Aufgaben")"** %? [/] \n %a")
                                ("2" "Einkaufsliste" checkitem (file+headline "~/Dropbox/2nd-brain/org-roam-notes/roam-orga/home.org" "Einkaufsliste"))
                                ("3" "Wunschliste" checkitem (file+headline "~/Dropbox/2nd-brain/org-roam-notes/roam-orga/home.org" "Wunschliste"))
                                ("4" "Neue Abrechnung" table-line (file+headline "~/Dropbox/2nd-brain/org-roam-notes/roam-orga/work.org" "Abrechnungen Jo"))
                                ("a" "Appointment" entry (file  "~/Dropbox/2nd-brain/org-roam-notes/roam-orga/gcal.org") "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
                                ("j" "Daily Journal" entry (file+olp+datetree "~/Dropbox/2nd-brain/org-roam-notes/roam-orga/home.org" "Journal") "* %^{Description}      Hinzugefügt am: %U      %^g\n%?"))))
;;;Sonstiges;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ox-reveal)                                                                                            ;Macht das ox-reveal funktioniert - geht glaub auch über init.el - langfristig anpassen auf meine Lieblingseinstellungen oder hier raus werfen

;;;Test;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq imenu-list-focus-after-activation t)

(set-face-attribute 'default nil :height 100) ; Schriftgröße einstellen ; Schriftgröße einstellen

;;;Test;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar mane-block-markup-hidden nil
  "Variable to track the state of block markup visibility.")
(defun mane-toggle-block-markup ()
  "Toggle visibility of Org mode block markup."
  (interactive)
  (setq mane-block-markup-hidden (not mane-block-markup-hidden))
  (if mane-block-markup-hidden
      (mane-hide-block-markup)
    (remove-overlays)))
(defun mane-hide-block-markup ()
  "Hide Org mode block markup."
  (interactive)
  (save-excursion
    (beginning-of-buffer)
    (while (re-search-forward "^\\(#\\+begin\\|#\\+end\\)_src" nil t)
      (let ((overlay (make-overlay (line-beginning-position) (line-end-position))))
        (overlay-put overlay 'invisible t)))))
(add-hook 'org-mode-hook #'mane-hide-block-markup)
(map! :leader
:desc "begin und end block Kennzeichnung wird ausgeblendet"
"t 1" #'mane-toggle-block-markup)

(setq mane-toggle-block-markup nil)

(use-package! gptel
 :config
 (setq! gptel-api-key ""))

(setq initial-buffer-choice "~/.config/doom/start.org")
(define-minor-mode start-mode
  "Provide functions for custom start page."
  :lighter " start"
  :keymap (let ((map (make-sparse-keymap)))
          ;;(define-key map (kbd "M-z") 'eshell)
            (evil-define-key 'normal start-mode-map
              (kbd "1") '(lambda () (interactive) (find-file "~/Dropbox/2nd-brain/org-roam-notes/home.org"))
              (kbd "2") '(lambda () (interactive) (find-file "~/Dropbox/2nd-brain/org-roam-notes/work.org"))
              (kbd "3") '(lambda () (interactive) (find-file "~/Dropbox/2nd-brain/org-roam-notes/work/2022-12-15-schule.org"))
              (kbd "4") '(lambda () (interactive) (find-file "~/Dropbox/2nd-brain/org-roam-notes/bildung-wissen/2022-12-15-bildung-wissen.org"))
              (kbd "5") '(lambda () (interactive) (find-file "~/.config/doom/init.el"))
              (kbd "6") '(lambda () (interactive) (find-file "~/.config/doom/packages.el"))
              (kbd "7") '(lambda () (interactive) (find-file "~/.config/doom/config.el"))
              (kbd "8") '(lambda () (interactive) (find-file "~/flowmis-os/flowmis-os-install.org"))
              (kbd "9") '(lambda () (interactive) (find-file "~/.config/qtile/config.py")))
          map))
(add-hook 'start-mode-hook 'read-only-mode) ;; make start.org read-only; use 'SPC t r' to toggle off read-only.
(provide 'start-mode)

(after! evil
(fset 'mane-export-ka (kmacro-lambda-form [?\C-x ?r ?m ?1 return ?  ?s ?b ?# ?  ?# ?+ ?s ?e ?t ?u ?p ?f ?i ?l ?e ?: ?  ?~ ?d ?r ?o ?p ?b ?o ?x ?/ ?2 ?n ?d ?- ?b ?r ?a ?i ?n ?/ ?l ?a ?t ?e ?x ?/ ?k ?a ?- ?v ?o ?r ?l ?a ?g ?e ?. ?o ?r ?g return ?V down down ?  ?  ?\C-x ?r ?b ?1 return ?V ?\C-x ?n ?n escape tab down ?V ?G ?\C-x ?n ?n escape ?  ?m ?e ?l ?p ?g ?g ?\C-x ?n ?w up tab ?\C-x ?r ?m ?1 return ?  ?s ?b ?# ?  ?# ?+ ?s ?e ?t ?u ?p ?f ?i ?l ?e ?: ?  ?~ ?d ?r ?o ?p ?b ?o ?x ?/ ?2 ?n ?d ?- ?b ?r ?a ?i ?n ?/ ?l ?a ?t ?e ?x ?/ ?k ?a ?- ?v ?o ?r ?l ?a ?g ?e ?. ?o ?r ?g return ?V down down ?  ?  ?\C-x ?r ?b ?1 return] 0 "%d")))
(after! evil
(fset 'export-ch-presentation (kmacro-lambda-form [?\C-x ?n ?n escape tab down ?V ?G ?\C-x ?n ?n escape ?g ?g ?O ?< ?p ?e ?x ?c tab escape ?  ?m ?e ?l ?p ?u ?\C-x ?n ?w up tab ?\C-l] 0 "%d"))
(fset 'export-ch-zus (kmacro-lambda-form [?\C-x ?n ?n escape tab down ?V ?G ?\C-x ?n ?n escape ?g ?g ?O ?< ?p ?e ?x ?a ?4 tab escape ?  ?m ?e ?l ?p ?u ?\C-x ?n ?w up tab ?\C-l] 0 "%d"))
(fset 'export-ch-ib (kmacro-lambda-form [?\C-x ?n ?n escape tab down ?V ?G ?\C-x ?n ?n escape ?g ?g ?O ?< ?p ?e ?x ?i ?b tab ?1 ?0 ?\C-x ?q tab escape ?  ?m ?e ?l ?p ?u ?\C-x ?n ?w up tab ?\C-l] 0 "%d"))
(fset 'export-ch-svp (kmacro-lambda-form [?\C-x ?n ?n escape tab down ?V ?G ?\C-x ?n ?n escape ?g ?g ?O ?< ?p ?e ?x ?s ?v ?p ?c tab ?1 ?0 ?\C-x ?q tab escape ?  ?m ?e ?l ?p ?u ?\C-x ?n ?w up tab ?\C-l] 0 "%d"))
(fset 'export-ch-ab (kmacro-lambda-form [?\C-x ?n ?n escape tab down ?V ?G ?\C-x ?n ?n escape ?g ?g ?O ?< ?p ?e ?x ?a ?b tab ?1 ?0 ?\C-x ?q tab escape ?  ?m ?e ?l ?p ?u ?\C-x ?n ?w up tab ?\C-l] 0 "%d")))

(after! org
  (add-to-list 'org-latex-classes
               '("maneart"
                 "\\documentclass{article}
                  [NO-DEFAULT-PACKAGES]
                  [PACKAGES]
                  [EXTRA]"
                  ; [NO-DEFAULT-PACKAGES] verhindert das Laden der Standard-Latex-Pakete, [PACKAGES] ermöglicht das Laden zusätzlicher Pakete und [EXTRA] enthält zusätzlichen LaTeX-Code, der in der Kopfzeile der Dokumentklasse platziert wird.
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  (add-to-list 'org-latex-classes
               '("manepres"
                 "\\documentclass{beamer}
                  [NO-DEFAULT-PACKAGES]
                  [PACKAGES]
                  [EXTRA]"
                  ; [NO-DEFAULT-PACKAGES] verhindert das Laden der Standard-Latex-Pakete, [PACKAGES] ermöglicht das Laden zusätzlicher Pakete und [EXTRA] enthält zusätzlichen LaTeX-Code, der in der Kopfzeile der Dokumentklasse platziert wird.
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  )

(setq org-latex-hyperref-template nil)

(doom-modeline-mode 1)

;;;org-download;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'org-download)
(setq-default org-download-image-dir "~/Dropbox/2nd-brain/org-roam-notes/bilder/org-download")
(add-hook 'dired-mode-hook 'org-download-enable)
(setq-default org-download-screenshot-method "flameshot gui --raw > %s")
(setq-default org-download-heading-lvl nil) ;falls ich das nicht habe wird ein Ordner erstellt mmit dem Namen des Headers unter den das Bild eingefügt wird - so kommt kein zusätzlicher Ordner
(setq-default org-download-timestamp "%Y-%m-%d-%H-%M-%S-")

;;;Agenda;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(after! org
  :config
  (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "BIN DRAN(D)" "DELEGIERT(d@/!)" "|" "BEENDET(b@/!)" "ABGEBROCHEN(a@/!)"))    ;pipe separiert "active" states and "inactive" states -> Emacs checkt es dann
        org-agenda-files '("~/flowmis-os/flowmis-os.org"
                           "~/Dropbox/2nd-brain/org-roam-notes/roam-orga/gcal.org"
                           "~/Dropbox/2nd-brain/org-roam-notes/roam-orga/home.org"
                           "~/Dropbox/2nd-brain/org-roam-notes/roam-orga/work.org"
                           )
        org-agenda-custom-commands
        '(("d" "Daily agenda and all TODOs"
           ((tags "PRIORITY=\"A\""
                  ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                   (org-agenda-overriding-header "Es eilt:")))
            (agenda "" ((org-agenda-start-day "-1d")
                        (org-agenda-span 4)
                        (org-agenda-overriding-header "Agenda:")
                        ))
            (alltodo ""
                     ((org-agenda-skip-function '(or (mane-skip-subtree-if-habit)
                                                     (mane-skip-subtree-if-priority ?A)
                                                     (org-agenda-skip-if nil '(scheduled deadline))))
                      (org-agenda-overriding-header "Irgendwann erledigen:"))))
           ;((org-agenda-compact-blocks t))     ;Falls ich keine Trennlinie angezeigt bekommen will
           )))
  (defun mane-skip-subtree-if-priority (priority)
    "Skip agenda subtree."
    (let ((subtree-end (save-excursion (org-end-of-subtree t)))
          (pri-value (* 1000 (- org-lowest-priority priority)))
          (pri-current (org-get-priority (thing-at-point 'line t))))
      (if (= pri-value pri-current)
          subtree-end
        nil)))
  (defun mane-skip-subtree-if-habit ()
    "Skip an agenda entry if it has a STYLE property equal to \"habit\"."
    (let ((subtree-end (save-excursion (org-end-of-subtree t))))
      (if (string= (org-entry-get nil "STYLE") "habit")
          subtree-end
        nil))))

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
(map! :leader
      (:prefix ("d" . "dired")
       :desc "Open dired" "d" #'dired
       :desc "Dired jump to current" "j" #'dired-jump))
(evil-define-key 'normal dired-mode-map
  (kbd "M-RET") 'dired-display-file     ;benutzen um Bildervorschau in Splitbuffer zu zeigen, aber weiter in dired navigieren
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-open-file
  (kbd "m") 'dired-mark                 ;Mit %m kann man nach einer regular expression bestimmte Dateien markieren
  (kbd "u") 'dired-unmark               ;Mit U kann man alles unmarken
  (kbd "t") 'dired-toggle-marks         ;wenn zuvor 2 Datein markiert waren kann man mit t diese unmarken und alle anderen die unmarked waren marken -> sinnvoll wenn man viele Dateien bis auf ein paar wenige markieren will
  (kbd "H") 'dired-do-kill-lines        ;markierte Dateien ausblenden (werden nicht gelöscht, aber bei Bearbeitungen hilfreich) -> Mit <g r> - revert Buffer kann man sie sich wieder anzeigen lassen
  (kbd "C") 'dired-do-copy
  (kbd "D") 'dired-do-delete
  (kbd "J") 'dired-goto-file
  (kbd "M") 'dired-chmod
  (kbd "O") 'dired-chown
  (kbd "P") 'dired-do-print
  (kbd "R") 'dired-rename
  (kbd "T") 'dired-do-touch
  (kbd "Y") 'dired-copy-filename-as-kill ; copies filename to kill ring.
  (kbd "+") 'dired-create-directory
  ;(kbd "% l") 'dired-downcase
  ;(kbd "% u") 'dired-upcase
  ;(kbd "; d") 'epa-dired-do-decrypt
  ;(kbd "; e") 'epa-dired-do-encrypt
  )

;;;ROAM;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(after! org
  :config
  (setq org-roam-directory "~/Dropbox/2nd-brain/org-roam-notes"
        org-roam-db-autosync-mode t   ;Falls Probleme manuell <M-x org-roam-db-sync> um neu angelegte files in roam zu finden
        org-roam-ui-sync-theme t      ;Falls Probleme manuell <M-x org-roam-ui-sync-theme> und dann neustart des ui-mode um Brain im Browser zu navigieren (nun im gleichen Theme wie Emacs)
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t
        org-roam-capture-templates '(("b" "book notes" plain (file "~/Dropbox/2nd-brain/templates/BookTemplate.org")
                                      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
                                      :unnarrowed t)
                                     ("n" "normal/einfach nur mit Datum" plain (file "~/Dropbox/2nd-brain/templates/normal.org")
                                      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
                                      :unnarrowed t)
                                     ("z" "Zitate/Prinzipien/Weisheiten/Definitionen" plain (file "~/Dropbox/2nd-brain/templates/Zitate.org")
                                      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
                                      :unnarrowed t))))
(org-roam-db-sync)

;;;Snippets;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'yasnippet)
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(setq yas-snippet-dirs '("~/Dropbox/2nd-brain/yasnippets/"))
(yas-global-mode 1)

;;;Keybindings;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "M-v") 'er/expand-region) ;markiert bei jeder Wiederholung immer weiter nach aussen --> Macht es einem leicht bestimmte logische Bereiche schnell zu markieren
(global-set-key (kbd "M-p") 'yank-from-kill-ring) ;zeigt kill ring - man kann auswählen was man von dem zuvor gekilltem einfügen will
;;leader ist in Doom <SPC> -> prefix der andernorts vergeben ist und hier nicht verwendet werden sollte "d" - dired
(setq doom-localleader-key "<delete>")
;(map! :localleader
;       :desc "toggle imenu-list" "SPC" #'imenu-list-smart-toggle)              ;geht auch mit <Fn rechts> bei aktuellem Laptop

(map! :leader
      :desc "Comment or uncomment lines" "SPC" #'comment-line)



(map! :localleader
      :desc "Export the folded :svp: tagged Stundenverlaufsplan at point" "1" #'mane-export-svp
      :desc "Export the folded :pres: tagged Presentation at point" "2" #'mane-export-presentation
      :desc "Export the folded :ab: tagged Arbeitsblatt at point" "3" #'mane-export-ab
      :desc "Export the folded :ib: tagged Infomaterial at point" "4" #'mane-export-info
      :desc "Export the folded :zusatz: tagged Infomaterial at point" "5" #'mane-export-zusatz
      :desc "Export the folded :ka: tagged Infomaterial at point" "6" #'mane-export-ka
      :desc "toggle imenu-list" "i" #'imenu-list-smart-toggle              ;geht auch mit <Fn rechts> bei aktuellem Laptop
      :desc "end of line" "<right>" #'end-of-line              ;geht auch mit <Fn rechts> bei aktuellem Laptop
      :desc "start of line" "<left>" #'beginning-of-line       ;geht auch mit <Fn links> bei aktuellem Laptop
      :desc "page down" "<down>" #'evil-scroll-page-down       ;geht auch mit <Fn hoch> bei aktuellem Laptop - auch <Strg hoch> oft sinnvoller Sprung
      :desc "page up" "<up>" #'evil-scroll-page-up            ;geht auch mit <Fn runter> bei aktuellem Laptop - auch <Strg runter> oft sinnvoller Sprung
      :desc "Org babel tangle" "b" #'org-babel-tangle
      :desc "Eshell" "e s" #'eshell
      :desc "Counsel eshell history" "e h" #'counsel-esh-history
      :desc "Gehe zum Dashboard" "<delete>" #'(lambda () (interactive) (find-file "~/.config/doom/start.org"))
      :desc "Edit local/tangled doom config.el" "c" #'(lambda () (interactive) (find-file "~/.config/doom/config.el"))
      :desc "Evaluate elisp in buffer" "e b" #'eval-buffer
      :desc "Evaluate defun" "e d" #'eval-defun
      :desc "Evaluate elisp expression" "e e" #'eval-expression
      :desc "Evaluate last sexpression" "e l" #'eval-last-sexp
      :desc "Evaluate elisp in region" "e r" #'eval-region
      :desc "Kalenderansicht öffnen" "k o" #'cfw:open-org-calendar
      :desc "Kalender sync" "k s" #'org-gcal-sync
      :desc "Kalendereintrag an GoogleKalender schicken" "k p" #'org-gcal-post-at-point
      :desc "Kalendereintrag bei GoogleKalender löschen" "k d" #'org-gcal-delete-at-point
      :desc "Winner undo" "w <left>" #'winner-undo ;schaut was die letzte Window configuration war und geht dahin zurück
      :desc "Winner redo" "w <right>" #'winner-redo ;geht in andere Richtung wie winner-undo
      :desc "Toggle line numbers" "t l" #'doom/toggle-line-numbers
      :desc "Toggle line highlight in frame" "t h" #'hl-line-mode
      :desc "Toggle line highlight globally" "t H" #'global-hl-line-mode
      :desc "Toggle truncate lines" "t t" #'toggle-truncate-lines
      :desc "Window configuration to register" "r w" #'window-configuration-to-register
      :desc "Frameset to register" "r f" #'frameset-to-register
      :desc "Jump to register" "r j" #'jump-to-register
      :desc "List registers" "r l" #'list-registers
      :desc "View a register" "r v" #'view-register
      :desc "Point to register" "r SPC" #'point-to-register
      :desc "org-roam-buffer-toggle" "x s" #'org-download-screenshot
      :desc "org-roam-buffer-toggle" "x S" #'org-download-clipboard
      :desc "org-roam-buffer-toggle" "x r" #'org-download-rename-at-point
      :desc "org-roam-buffer-toggle" "x u" #'org-roam-ui-open
      :desc "find node/new node" "x f" #'org-roam-node-find
      :desc "insert node" "x i" #'org-roam-node-insert
      :desc "make ditaa work" "x d" #'activate-ditaa-path
      :desc "expand table" "x e" #'org-table-shrink
      :desc "expand table" "x E" #'org-table-expand
      :desc "Starte Präsentationsmodus" "x p" #'pres-start
      :desc "Beende Präsentationsmodus" "x P" #'pres-end)

(defun mane-rezepte-export-org-to-html ()
  "Rezeptdateien als html an entsprechenden Ort exportieren."
  (interactive)
  (let* ((source-dir "~/Dropbox/2nd-brain/org-roam-notes/rezepte/")
         (org-files (directory-files-recursively source-dir "\\.org$")))
    (dolist (file org-files)
      (with-current-buffer (find-file-noselect file)
        (org-html-export-to-html nil nil nil nil nil)))))
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
  (olivetti-mode 1)
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
  "Paar Anpassungen - interaktiv ein-ausschalten."
  (interactive)
  ;; (setq text-scale-mode-amount 1)
  ;; (text-scale-mode 1)
  (custom-theme-set-faces               ;<M-x describe-theme> um Einblick in Möglichkeiten zu bekommen
   'user
   '(org-level-1 ((t (:inherit outline-1 :font "URW Bookman Light" :height 2.3 ))))
   '(org-level-2 ((t (:inherit outline-2 :height 2.0 ))))
   '(org-level-3 ((t (:inherit outline-3 :height 1.7 ))))
   '(org-level-4 ((t (:inherit outline-4 :height 1.4 ))))
   '(org-level-5 ((t (:inherit outline-5 :height 1.2 ))))
   '(org-block ((t (:inherit fixed-pitch))))
   '(org-code ((t (:inherit (shadow fixed-pitch)))))
   '(org-document-info ((t (:height 1.2))))
   '(org-document-title ((t (:height 3.0))))
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
(add-hook 'after-init-hook #'mane-theme-zusatzeinstellungen) ;'after-init-ui-hook auch gute Möglichkeit um Aussehensvariablen zu überschreiben
