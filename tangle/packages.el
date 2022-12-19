;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (package! gitconfig-mode
;;      :recipe (       :host github :repo "magit/git-modes"
;;                      :files ("gitconfig-mode.el"             )))
;; (package! gitignore-mode
;;      :recipe (       :host github :repo "magit/git-modes"
;;                      :files ("gitignore-mode.el"             )))
;; (package! dashboard)
(package! dired-open)
(package! org-tree-slide)
(package! ox-reveal)
(package! beacon)
(package! centered-cursor-mode) ;für zentrales scrollen im Präsi Modus
(package! org-drill) ;für zentrales scrollen im Präsi Modus
(package! rg)
(package! org-roam)
(unpin! org-roam) ;macht es stabiler da es nicht wirklich geupdated wird - siehe Info zu unpin!
(package! org-roam-ui)
(package! graphviz-dot-mode)
(package! org-fancy-priorities :disable t)
(package! nano-modeline)
(package! org-download)
;; (package! olivetti)
;; (package! org-bullets)
;; (package! flycheck-aspell)
;; (package! async)
;; (package! calfw)
;; (package! calfw-org)
;; (package! elpher)
;; (package! emojify)
;; (package! evil-tutor)
;; (package! ivy-posframe)
;; (package! ox-man)
;; (package! ox-gemini)
;; (package! ox-publish)
;; (package! peep-dired)
;; (package! password-store)
;; (package! rainbow-mode)
;; (package! resize-window)
;; (package! tldr)
;; (package! wc-mode)
;; (package! hide-mode-line)
;; (package! org-ref)
;; (package! ivy-bibtex)
;; (package! org-noter)
;; (package! org-pdftools)
;; (package! org-super-agenda)
;; (package! eyebrowse)
;; (package! powerthesaurus) ;geht bisher nur auf Englisch
;; (package! synosaurus) ;geht bisher nicht
