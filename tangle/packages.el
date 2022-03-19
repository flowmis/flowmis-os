;; Um ein neues Packet zu installieren muss man es hier einfügen und doomsync ausführen & restarten
;; Von MELPA, ELPA or emacsmirror kann man Packete installieren indem man some-package ersetzt mit dem gewünschten Packet:
;(package! some-package)

;; Man kann aber auch von remote git repo installieren indem man folgendes beachtet
;; Mit `:recipe' arbeiten. Dokumentation was beachtet werden muss: https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; Ist dort kein PACKAGENAME.el im repo enthalten, oder in subdirectory muss man mit :files genauer spezifizieren
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; Mit `:disable' kann man ein in Doom beinhaltetes Paket ausschalten:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)
(package! gitconfig-mode
	  :recipe (:host github :repo "magit/git-modes"
			 :files ("gitconfig-mode.el")))
(package! gitignore-mode
	  :recipe (:host github :repo "magit/git-modes"
			 :files ("gitignore-mode.el")))
(package! flycheck-aspell)
(package! async)
(package! calfw)
(package! calfw-org)
(package! dashboard)
(package! dired-open)
(package! elpher)
(package! emojify)
(package! evil-tutor)
(package! ivy-posframe)
(package! org-bullets)
(package! ox-gemini)
(package! peep-dired)
(package! password-store)
(package! rainbow-mode)
(package! resize-window)
(package! tldr)
(package! wc-mode)
(package! hide-mode-line)
(package! org-tree-slide)
(package! ox-reveal)
(package! org-ref)
(package! ivy-bibtex)
(package! org-roam)
(unpin! org-roam)
(package! org-roam-ui)
(package! org-noter)
(package! org-pdftools)
