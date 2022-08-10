;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq user-full-name "Markus Hoffmann"
      user-mail-address "manemarkushoffmann@gmail.com" ;GPG configuration, email clients, file templates and snippets,... can use this information - ist optional
      eshell-rc-script "~/.config/doom/eshell/profile"
      eshell-aliases-file "~/.config/doom/eshell/aliases"
      eshell-buffer-maximum-lines 5000
      eshell-scroll-to-bottom-on-input t)
(after! org
  (setq
      org-directory "~/Dropbox/emacs/org-roam/Notizen/"
      org-agenda-files '("~/Dropbox/emacs/org-roam/Notizen/orga/agenda.org")
      org-default-notes-file (expand-file-name "notes.org" org-directory)
      org-ellipsis " ▼ "
      org-log-done 'time
      org-journal-dir "~/Dropbox/emacs/org-roam/Notizen/orga/journal/"
      org-journal-date-format "%B %d, %Y (%A) "
      org-journal-file-format "%Y-%m-%d.org"
      org-hide-emphasis-markers t ;;macht dass Markierungssymbole um kursiv, dick, unterstrichen,... zu schreiben (~-_/*=) ausgeblendet werden
      org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list welche man mit <K> aufrufen kann
        '(("google" . "http://www.google.com/search?q=")                ;default
          ("doom-repo" . "https://github.com/doomemacs/doomemacs/%s")   ;default
          ("doomdir" . "/home/flowmis/.doom.d/%s")                      ;default
          ("emacsdir" . "/home/flowmis/.emacs.d/%s")                    ;default
          ("doom" . "https://github.com/hlissner/doom-emacs/%s")        ;default
          ("wolfram" . "https://wolframalpha.com/input/?i=%s")          ;default
          ("wikipedia" . "https://en.wikipedia.org/wiki/%s")            ;default
          ("duckduckgo" . "https://duckduckgo.com/?q=%s")               ;default
          ("gmap" . "https://maps.google.com/maps?q=%s")                ;default
          ("gimages" . "https://google.com/images?q=%s")                ;default
          ("youtube" . "https://youtube.com/watch?v=%s")                ;default
          ("github" . "https://github.com/%s")                          ;default
          ("arch-wiki" . "https://wiki.archlinux.org/index.php/"))      ;selbst hinzugefügt
      org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
        '((sequence
           "TODO(t@!)"
           "EILIG(e@/!)"
           "PAUSIERT(p@/!)"
           "|"                 ; The pipe necessary to separate "active" states and "inactive" states
           "BEENDET(b@/!)"
           "ABGEBROCHEN(a@/!)"
           "DELEGIERT(d@/!)"))))
(after! yas
  :config
  (yas/initialize)
  (setq yas/root-directory "~/Dropbox/emacs/yasnippets/")
  (yas/load-directory yas/root-directory)
  (add-to-list 'load-path "~/Dropbox/emacs/yasnippets/")
  (require 'yasnippet)
  (setq yas-snippet-dirs '("~/Dropbox/emacs/yasnippets/"))             ;gleichen Dropbox Ordner angeben wie für Orga.org um dort die Snippets zu speichern
  (yas-global-mode 1))
(after! org
  :init      ;; tweak dashboard config before loading it
  (setq dashboard-set-heading-icons t)
  (setq display-line-numbers nil)
  (setq dashboard-set-file-icons t)
  ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq dashboard-startup-banner "~/.config/doom/banner/banner.png")  ;; use custom image as banner
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (agenda . 5)
                          (bookmarks . 3)
                          (projects . 3)))
  (setq doom-fallback-buffer-name "*dashboard*")
  :config
  (dashboard-setup-startup-hook)
  (dashboard-modify-heading-icons '((recents . "file-text")
                                    (bookmarks . "book"))))
(after! dired
  :hook
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; With dired-open plugin, you can launch external programs for certain extensions
;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
  :config
  (setq dired-open-extensions '(("gif" . "vlc")           ;Mit Enter auf Datei in dired mit dieser Endung wird angegebenes externes Programm zum öffnen verwendet!
                              ("jpg" . "pinta")
                              ("png" . "viewnior")
                              ("mkv" . "vlc")
                              ("mp4" . "vlc"))))

(setq doom-font (font-spec :family "Source Code Pro" :size 13)
     doom-variable-pitch-font (font-spec :family "Fira Code" :size 13)
     doom-big-font (font-spec :family "Source Code Pro" :size 20)
     doom-unicode-font (font-spec :family "Source Code Pro" :size 10)
     doom-serif-font (font-spec :family "Source Code Pro" :size 10)
     )
(setq doom-theme 'doom-molokai)
(custom-set-faces!
  '(font-lock-comment-face :slant italic)       ;Macht Kommentare wie diesen kursiv
  '(font-lock-keyword-face :slant italic))      ;Macht Keywords wie setq, after! ... kursiv
(after! doom-themes
      :config
      (beacon-mode 1)                 ;hilft den Cursor schnell zu finden durch aufblinken
      (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
      (set-frame-parameter (selected-frame) 'alpha '(95 . 70))   ;Zahl 1 nach alpha gibt Transparenz des aktiven Bildschirms und Zahl 2 gibt Transparenz wenn anderes Window im Focus ist
      (custom-set-faces '(org-level-1 ((t (:inherit outline-1 :height 1.0))))
                        '(org-level-2 ((t (:inherit outline-2 :height 1.0))))
                        '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
                        '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
                        '(org-level-5 ((t (:inherit outline-5 :height 1.0)))))
      ;; (setq display-line-numbers-type 'visual)
      (setq display-line-numbers-type nil)
      )

(global-set-key (kbd "M-v") 'er/expand-region) ;markiert bei jeder Wiederholung immer weiter nach aussen --> Macht es einem leicht bestimmte logische Bereiche schnell zu markieren
(global-set-key (kbd "M-p") 'yank-from-kill-ring) ;zeigt kill ring - man kann auswählen was man von dem zuvor gekilltem einfügen will
(map! :leader
       :desc "Org babel tangle" "m B" #'org-babel-tangle
       :desc "Clone indirect buffer other window" "b c" #'clone-indirect-buffer-other-window
       :desc "Eshell" "e s" #'eshell
       :desc "Counsel eshell history" "e h" #'counsel-esh-history
      (:prefix ("-" . "open file")
       :desc "Edit agenda file" "a" #'(lambda () (interactive) (find-file "~/Dropbox/emacs/org-roam/Notizen/orga/agenda.org"))
       :desc "Edit doom config.org" "f" #'(lambda () (interactive) (find-file "~/FlowmisOS/FlowmisOS.org"))
       :desc "Edit eshell aliases" "e a" #'(lambda () (interactive) (find-file "~/.config/doom/eshell/aliases"))
       :desc "Edit eshell aliases" "e p" #'(lambda () (interactive) (find-file "~/.config/doom/eshell/profile"))
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
       :desc "Copy to register" "c" #'copy-to-register
       :desc "Frameset to register" "f" #'frameset-to-register
       :desc "Insert contents of register" "i" #'insert-register
       :desc "Jump to register" "j" #'jump-to-register
       :desc "List registers" "l" #'list-registers
       :desc "Number to register" "n" #'number-to-register
       :desc "Interactively choose a register" "r" #'counsel-register
       :desc "View a register" "v" #'view-register
       :desc "Window configuration to register" "w" #'window-configuration-to-register
       :desc "Increment register" "+" #'increment-register
       :desc "Point to register" "SPC" #'point-to-register)
      (:prefix ("b". "buffer")
       :desc "List bookmarks" "L" #'list-bookmarks
       :desc "Save current bookmarks to bookmark file" "w" #'bookmark-save)
)
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

;; (use-package! websocket
;;     :after org-roam)

;; (use-package! org-roam-ui
;;     :after org-roam ;; or :after org
;; ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;; ;;         a hookable mode anymore, you're advised to pick something yourself
;; ;;         if you don't care about startup time, use
;; ;;  :hook (after-init . org-roam-ui-mode)
;;     :config
;;     (setq org-roam-ui-sync-theme t
;;           org-roam-ui-follow t
;;           org-roam-ui-update-on-save t
;;           org-roam-ui-open-on-start t))
;; ;;org roam
;; (use-package org-roam
;;   :ensure t
;;   :custom
;;   (org-roam-directory "~/Dropbox/emacs/org-roam/Notizen")
;;   :bind (("C-c n l" . org-roam-buffer-toggle)
;;          ("C-c n f" . org-roam-node-find)
;;          ("C-c n i" . org-roam-node-insert))
;;   :config
;;   (org-roam-setup))
;; (setq org-roam-capture-templates
;;         '(("b" "book notes" plain (file "~/Dropbox/emacs/org-roam/templates/BookTemplate.org")
;;            :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
;;            :unnarrowed t)
;;           ("n" "normal/einfach nur mit Datum" plain (file "~/Dropbox/emacs/org-roam/templates/normal.org")
;;            :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
;;            :unnarrowed t)
;;           ("z" "Zitate/Prinzipien/Weisheiten/Definitionen" plain (file "~/Dropbox/emacs/org-roam/templates/Zitate.org")
;;            :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
;;            :unnarrowed t)
;;           ))
;; (global-set-key (kbd "C-c n d") 'org-roam-dailies-capture-today)
;; (setq org-capture-templates '(
;;     ("1" "Schnell Erledigen" checkitem
;;         (file+headline "~/Dropbox/emacs/org-roam/Notizen/orga/20220415105725-orga.org" "Eilig"))
;;     ("2" "Zeitnah Erledigen" checkitem
;;         (file+headline "~/Dropbox/emacs/org-roam/Notizen/orga/20220415105725-orga.org" "Zeitnah"))
;;     ("3" "Irgendwann Erledigen" checkitem
;;         (file+headline "~/Dropbox/emacs/org-roam/Notizen/orga/20220415105725-orga.org" "Irgendwann"))
;;     ("4" "Einkaufsliste Mane" checkitem
;;         (file+headline "~/Dropbox/emacs/org-roam/Notizen/orga/20220415105725-orga.org" "Einkaufsliste Mane"))
;;     ("5" "Einkaufsliste Joana" checkitem
;;         (file+headline "~/Dropbox/emacs/org-roam/Notizen/orga/20220415105725-orga.org" "Einkaufsliste Joana"))
;;     ("6" "Gemeinsame Einkaufsliste" checkitem
;;         (file+headline "~/Dropbox/emacs/org-roam/Notizen/orga/20220415105725-orga.org" "Gemeinsame Einkaufsliste"))
;;     ("7" "Wunschliste Mane" checkitem
;;         (file+headline "~/Dropbox/emacs/org-roam/Notizen/orga/20220415105725-orga.org" "Wunschliste Mane"))
;;     ("8" "Neue Abrechnung" table-line
;;         (file+headline "~/Dropbox/emacs/org-roam/Notizen/orga/20220415105725-orga.org" "Abrechnungen Jo"))
;;     ("t" "Gedanken und Sonstiges" entry
;;         (file+datetree "~/Dropbox/emacs/org-roam/Notizen/orga/20220415105725-journal.org")
;;         "* %^{Description}      Hinzugefügt am: %U      %^g")
;; ))

(setq org-log-into-drawer 1)    ;Notes mit <C-c C-z> werden direkt in den Drawer :LOGBOOK: geschrieben wenn dieser vorhanden ist

(defun pres-start ()
  (load-theme 'doom-henna)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (hide-mode-line-mode 1)
  (beacon-mode -1)
  (centered-cursor-mode 1)
  (org-display-inline-images)                                           ;<M-x org-toggle-inline-images> sollte vor dem öffnen des Präsentationsmodus <M-x org-tree-slide-mode> ausgeführt um sicher zu sein dass alle Bilder angezeigt werde und dieser code sorgt dafür dass dies der Fall ist  -> alternativ vll auch mal org-startup-with-inline-images anschauen
  (setq text-scale-mode-amount 3)
  (text-scale-mode 1)
  (setq visual-fill-column-width 80      ;Größe des seitlichen Rahmen
        visual-fill-column-center-text t)   ;rückt Text in Mitte
  (visual-fill-column-mode 1)             ;braucht man um seitlichen Rahmen zu füllen (hier nichts umstellen)
  (display-line-numbers-mode -1)          ;schaltet line-numbers aus
  (visual-line-mode t)                    ;sorgt dafür dass alles an Text sichtbar ist (umgebrochen wird)
  (set-face-attribute 'org-document-title nil :font "Fira Code" :weight 'bold :height 1.4) ;Einstellungen Titel Präsi
  (set-frame-parameter (selected-frame) 'alpha '(85 . 50)))

(defun pres-end ()
  (load-theme 'doom-molokai)
  (doom-modeline-mode 1)
  (beacon-mode 1)
  (centered-cursor-mode -1)
  (org-display-inline-images -1)
  (setq visual-fill-column-width 110      ;Größe des seitlichen Rahmen
        visual-fill-column-center-text nil)   ;rückt Text in Mitte
  (visual-fill-column-mode -1)             ;braucht man um seitlichen Rahmen zu füllen (hier nichts umstellen)
  (display-line-numbers-mode 1)          ;schaltet line-numbers aus
  (text-scale-mode -1)
  (set-frame-parameter (selected-frame) 'alpha '(95 . 70)))

(use-package org-tree-slide
  :hook ((org-tree-slide-play . pres-start)
         (org-tree-slide-stop . pres-end)))

;; (setq bibtex-completion-bibliography '("~/Dropbox/emacs/bib/references.bib")
;; 	bibtex-completion-library-path '("~/Dropbox/emacs/bib/bibtex-pdfs/")
;; 	bibtex-completion-notes-path "~/Dropbox/emacs/bib/notes/"
;; 	bibtex-completion-notes-template-multiple-files "* ${author-or-editor}, ${title}, ${journal}, (${year}) :${=type=}: \n\nSee [[cite:&${=key=}]]\n"
;; 	bibtex-completion-additional-search-fields '(keywords)
;; 	bibtex-completion-display-formats
;; 	'((article       . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${journal:40}")
;; 	  (inbook        . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} Chapter ${chapter:32}")
;; 	  (incollection  . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
;; 	  (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
;; 	  (t             . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*}"))
;; 	bibtex-completion-pdf-open-function
;; 	(lambda (fpath)
;; 	  (call-process "open" nil 0 nil fpath)))
;; (require 'bibtex)
;; (setq bibtex-autokey-year-length 4
;; 	bibtex-autokey-name-year-separator "-"
;; 	bibtex-autokey-year-title-separator "-"
;; 	bibtex-autokey-titleword-separator "-"
;; 	bibtex-autokey-titlewords 2
;; 	bibtex-autokey-titlewords-stretch 1
;; 	bibtex-autokey-titleword-length 5
;; 	org-ref-bibtex-hydra-key-binding (kbd "H-b"))
;; (define-key bibtex-mode-map (kbd "H-b") 'org-ref-bibtex-hydra/body)
;;  (require 'org-ref-ivy)
;; (setq org-ref-insert-link-function 'org-ref-insert-link-hydra/body
;;       org-ref-insert-cite-function 'org-ref-cite-insert-ivy
;;       org-ref-insert-label-function 'org-ref-insert-label-link
;;       org-ref-insert-ref-function 'org-ref-insert-ref-link
;;       org-ref-cite-onclick-function (lambda (_) (org-ref-citation-hydra/body)))
;; (setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f"))

(defun activate-ditaa-path ()
 (interactive)
 (setq org-ditaa-jar-path "/usr/share/java/ditaa/ditaa-0.11.jar"))
(global-set-key (kbd "C-c m a") 'activate-ditaa-path)

(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist '(("." . "~/Dropbox/emacs/undo-tree-history")))

(pdf-tools-install t)                   ; Vll brauch ich es nicht, aber sollte dafür sorgen dass statt docview der pdfview aktiviert ist beim öffnen von pdfs sodass ich suchen, markieren etc. kann mit den pdf-tools!

(setq save-interprogram-paste-before-kill t) ; Speichert kopierte Inhalte ausserhalb Emacs in den kill ring und macht es leichter bei zwischenzeitlichem löschen innerhalb Emacs das kopierte doch einzufügen

;; (use-package multiple-cursors        ;Habe das Paket von hlissner in init.el aktiviert weil ich es besser finde!
;;   :config
;;   (setq mc/always-run-for-all 1)
;;   (global-set-key (kbd "C-c m m") 'mc/mark-next-like-this)
;;   (global-set-key (kbd "C-c m M") 'mc/mark-all-dwim)
;;   (global-set-key (kbd "C-c m a") 'mc/edit-lines)
;;   (global-set-key (kbd "C-c m q") 'mc/keyboard-quit)
;;   (global-set-key (kbd "C-c m n") 'mc/skip-to-next-like-this)
;;   (global-set-key (kbd "C-c m p") 'mc/skip-to-previous-like-this)
;;   (define-key mc/keymap (kbd "<return>") nil))

;; (setq ispell-program-name "aspell")   ;<z=> mit Cursor über Wort sagt dir schnell ob es richtig geschrieben ist! Kann aber auch wie folgt ein Keybinding für diese Funktion einrichten (habe in arch aspell(das neue ispell) installiert mit entsprechendem Wörterbuch)
;; (global-set-key (kbd "C-c f") 'ispell-word)  ;mit diesem Befehl kann man leicht keybindings setzen für alle Funktionen die man mit <M-x> finden kann -> man muss jedoch

;; ;; Rechtschreibprüfung vorerst aus weil noch nicht auf deutsch
;; (remove-hook 'text-mode-hook #'spell-fu-mode)
;; (setq global-spell-fu-mode 0)



;; (after! neotree
;;   (setq neo-smart-open t
;;         neo-window-fixed-size nil))
;; (after! doom-themes
;;   (setq doom-neotree-enable-variable-pitch t))
;; (map! :leader
;;       :desc "Toggle neotree file viewer" "t n" #'neotree-toggle
;;       :desc "Open directory in neotree" "d n" #'neotree-dir)

;; (setq centaur-tabs-set-bar 'over
;;       centaur-tabs-set-icons t
;;       centaur-tabs-gray-out-icons 'buffer
;;       centaur-tabs-height 24
;;       centaur-tabs-set-modified-marker t
;;       centaur-tabs-style "bar"
;;       centaur-tabs-modified-marker "•")
;; (map! :leader
;;       :desc "Toggle tabs globally" "t c" #'centaur-tabs-mode
;;       :desc "Toggle tabs local display" "t C" #'centaur-tabs-local-mode)
;; (evil-define-key 'normal centaur-tabs-mode-map (kbd "g <right>") 'centaur-tabs-forward        ; default Doom binding is 'g t'
;;                                                (kbd "g <left>")  'centaur-tabs-backward       ; default Doom binding is 'g T'
;;                                                (kbd "g <down>")  'centaur-tabs-forward-group
;;                                                (kbd "g <up>")    'centaur-tabs-backward-group)

;; (setq ivy-posframe-display-functions-alist
;;       '((swiper                     . ivy-posframe-display-at-point)
;;         (complete-symbol            . ivy-posframe-display-at-point)
;;         (counsel-M-x                . ivy-display-function-fallback)
;;         (counsel-esh-history        . ivy-posframe-display-at-window-center)
;;         (counsel-describe-function  . ivy-display-function-fallback)
;;         (counsel-describe-variable  . ivy-display-function-fallback)
;;         (counsel-find-file          . ivy-display-function-fallback)
;;         (counsel-recentf            . ivy-display-function-fallback)
;;         (counsel-register           . ivy-posframe-display-at-frame-bottom-window-center)
;;         (nil                        . ivy-posframe-display))
;;       ivy-posframe-height-alist
;;       '((swiper . 20)
;;         (t . 10)))
;; (ivy-posframe-mode 1) ; 1 enables posframe-mode, 0 disables it.

;; (map! :leader
;;       (:prefix ("v" . "Ivy")
;;        :desc "Ivy push view" "v p" #'ivy-push-view
;;        :desc "Ivy switch view" "v s" #'ivy-switch-view))

;HTML PRÄSENTATIONEN
(use-package ox-reveal
:ensure ox-reveal) ;Kann ich weglassen wenn ich Paket in packages.el lade?
(setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js") ;"file:///home/flowmi/Git/pres/reveal" -> ist lokaler Pfad falls ich mein pres Repo ofline geclont habe
(setq org-reveal-mathjax t)    ;math type ermöglicht - genauer einlesen
(use-package htmlize
:ensure t)                    ;sorgt dafür dass Syntax highlighting etc in der HTML angezeigt wird ----beim evaluieren kommt aber irgendwie dass es ignoriert wird also kein Plan?
;Sonstige Exporteinstellungen
(setq org-publish-use-timestamps-flag nil)
(setq org-export-with-broken-links t)
