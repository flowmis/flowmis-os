
;;; package --- setup-settings-basics.el
;;; Commentary:
;; Paketmanager elpaca + use-package support + evil keys...
;;; Code:
(defvar elpaca-installer-version 0.7)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                 ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                 ,@(when-let ((depth (plist-get order :depth)))
                                                     (list (format "--depth=%d" depth) "--no-single-branch"))
                                                 ,(plist-get order :repo) ,repo))))
                 ((zerop (call-process "git" nil buffer t "checkout"
                                       (or (plist-get order :ref) "--"))))
                 (emacs (concat invocation-directory invocation-name))
                 ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                       "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                 ((require 'elpaca))
                 ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Install use-package support
(elpaca elpaca-use-package
  ;; Enable :elpaca use-package keyword.
  (elpaca-use-package-mode)
  ;; Assume :elpaca t unless otherwise specified.
  (setq elpaca-use-package-by-default t))

;; Block until current queue processed.
(elpaca-wait)

;;When installing a package which modifies a form used at the top-level
;;(e.g. a package which adds a use-package key word),
;;use `elpaca-wait' to block until that package has been installed/configured.
;;For example:
;;(use-package general :demand t)
;;(elpaca-wait)

;;Turns off elpaca-use-package-mode current declartion
;;Note this will cause the declaration to be interpreted immediately (not deferred).
;;Useful for configuring built-in emacs features.
;;(use-package emacs :elpaca nil :config (setq ring-bell-function #'ignore))

;; Don't install anything. Defer execution of BODY
;;(elpaca nil (message "deferred"))
;; Expands to: (elpaca evil (use-package evil :demand t))
(use-package evil
    :init      ;; tweak evil's configuration before loading it
    (setq evil-want-integration t) ;;This is optional since it's already set to t by default.
    (setq evil-want-keybinding nil) ;;Ermöglicht der evil collection die richtigen Keybinds zu setzen ohne das meine Einstellungen zu fehlern führen
    (setq evil-vsplit-window-right t)
    (setq evil-split-window-below t)
    (evil-mode 1))

(use-package evil-collection
    :after evil
    :config
    (setq evil-collection-mode-list '(dashboard dired ibuffer)) 
    (evil-collection-init))

(use-package evil-tutor)

;; Unmap keys in 'evil-maps if not done, (setq org-return-follows-link t) will not work
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil))
;; Setting RETURN key in org-mode to follow links
  (setq org-return-follows-link  t)

(use-package general
  :config
  (general-evil-setup)  ;; 'SPC' als globaler leader key
  (general-create-definer mane-leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC") ;; access leader in insert mode
  (mane-leader-keys
    ;;Allgemeines
    "." '(find-file :which-key "Find file")
    "=" '(perspective-map :wk "Perspective") ;; Lists all the perspective keybindings
    "TAB TAB" '(comment-line :wk "Comment lines")
    "SPC" '(evil-window-next :wk "Goto next window")
    "<right>" '(end-of-line :wk "zum Ende der Zeile springen")
    "<left>" '(beginning-of-line :wk "zum Start der Zeile springen")
    "<up>" '(evil-scroll-page-up :wk "Page up")
    "<down>" '(evil-scroll-page-down :wk "Page down")
    
    ;; Buffer & Windows
    "b" '(:ignore t :wk "Buffer-Keybindings")
    "b b" '(consult-buffer :wk "Switch to Buffer/File,... mit preview")
    "b c" '(delete-window :wk "Close Window") ;Unterschied zu evil-window-delete?
    "b f" '(delete-other-windows :wk "Fokus auf aktuelles Window")
    "b h" '(evil-window-left :wk "Window left")
    "b H" '(buf-move-left :wk "Buffer move left")
    "b i" '(ibuffer :wk "Liste offener Buffer")
    "b j" '(evil-window-down :wk "Window down")
    "b J" '(buf-move-down :wk "Buffer move down")
    "b k" '(evil-window-up :wk "Window up")
    "b K" '(buf-move-up :wk "Buffer move up")
    "b l" '(evil-window-right :wk "Window right")
    "b L" '(buf-move-right :wk "Buffer move right")
    "b n" '(next-buffer :wk "Nächster Buffer")
    "b N" '(evil-window-new :wk "New window")
    "b r" '(revert-buffer :wk "Reload Buffer")
    "b S" '(evil-window-split :wk "Horizontal split window")
    "b s" '(evil-window-vsplit :wk "Vertical split window")
    "b v" '(previous-buffer :wk "Vorheriger Buffer")
    "b x" '(kill-this-buffer :wk "Kill Buffer")
    "b y" '(copy-current-path-to-clipboard :wk "Copy Path to this Buffer")

    ;; Checker
    "c" '(:ignore t :wk "Check")
    "c c" '(languagetool-check :wk "Check Buffer - Grammatik und Rechtschreibung")
    "c b" '(languagetool-correct-buffer :wk "Buffer mit den im check erkannten Fehlern korrigieren")
    "c p" '(languagetool-correct-at-point :wk "Buffer mit den im check erkannten Fehlern korrigieren")
    
    ;; Dired & Decrypt
    "d" '(:ignore t :wk "Dired & Decrypt/Encrypt - Verschlüsselung")
    "d d" '(dired :wk "Open dired")
    "d t" '(dired-sidebar-toggle-sidebar :wk "Dired als Sidebar")
    "d e" '(epa-dired-do-encrypt :wk "Dired markierte Datei verschlüsseln")
    "d E" '(epa-dired-do-decrypt :wk "Dired markierte Datei entschlüsseln")
    "d o" '(org-decrypt-entry :wk "Entry entschlüsseln")
    "d O" '(org-encrypt-entry :wk "Entry verschlüsseln")
    "d p" '(peep-dired :wk "Peep-dired")
    
    ;; Download
    "D" '(:ignore t :wk "Download")
    "D s" '(org-download-screenshot :wk "org-download-screenshot")
    "D c" '(org-download-clipboard :wk "org-download-toggle")
    "D R" '(org-download-rename-at-point :wk "org-download-rename-at-point")
    "D r" '(org-download-rename-last-file :wk "org-download-rename-last-file")
    "D w" '(org-download-yank) ;;Bildadresse aus Browser kopiert wird in originalqualität und mit quelle in org mode eingefügt! :wk "org-download-aus-bildadresse"
    "D d" '(org-download-delete :wk "org-download-delete-at-point")
    
    ;; Eshell & Eval
    "e" '(:ignore t :wk "Eshell & Evaluate")
    "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
    "e d" '(eval-defun :wk "Evaluate defun containing or after point")
    "e e" '(eval-last-sexp :wk "Evaluate the last expression")
    "e E" '(eval-expression :wk "Evaluate an elisp expression")
    "e h" '(counsel-esh-history :wk "Eshell history")
    "e r" '(eval-region :wk "Evaluate elisp in region")
    "e s" '(eshell :which-key "Eshell")
    
    ;; Files
    "f" '(:ignore t :wk "find-file bzw. go to file")
    "f c" '((lambda () (interactive) (find-file "~/flowmis-os/flowmis/.config/emacs/config.org")) :wk "Gehe zur emacs config")
    "f C" '((lambda () (interactive) (find-file "~/.config/emacs/config.org")) :wk "Gehe zur aktuellen emacs config")
    "f f" '(consult-find :wk "Find file")
    "F" '((lambda () (interactive) (find-file "~/flowmis-os/flowmis-os.org")) :wk "Gehe zu flowmis-os")
    "f h" '((lambda () (interactive) (find-file "/home/flowmis/cloud/life/raum/pkb/20240207T133915==mh--home__crypt_h_pkb.org")) :wk "Gehe zur emacs config")
    "f r" '(consult-recent-file :wk "Find recent files")
    "f s" '((lambda () (interactive) (find-file "~/.config/emacs/start.org")) :wk "Gehe zur Startseite")
    "f w" '((lambda () (interactive) (find-file "/home/flowmis/cloud/life/raum/pkb/20240212T121907==mh--work__crypt_pkb_w.org")) :wk "Gehe zur emacs config")
    
    ;; Git
    "g" '(:ignore t :wk "Git")
    "g /" '(magit-displatch :wk "Magit dispatch")
    "g ." '(magit-file-displatch :wk "Magit file dispatch")
    "g b" '(magit-branch-checkout :wk "Switch branch")
    "g c" '(:ignore t :wk "Create")
    "g c b" '(magit-branch-and-checkout :wk "Create branch and checkout")
    "g c c" '(magit-commit-create :wk "Create commit")
    "g c f" '(magit-commit-fixup :wk "Create fixup commit")
    "g C" '(magit-clone :wk "Clone repo")
    "g f" '(:ignore t :wk "Find")
    "g f c" '(magit-show-commit :wk "Show commit")
    "g f f" '(magit-find-file :wk "Magit find file")
    "g f g" '(magit-find-git-config-file :wk "Find gitconfig file")
    "g F" '(magit-fetch :wk "Git fetch")
    "g g" '(magit-status :wk "Magit status")
    "g i" '(magit-init :wk "Initialize git repo")
    "g l" '(magit-log-buffer-file :wk "Magit buffer log")
    "g r" '(vc-revert :wk "Git revert file")
    "g s" '(magit-stage-file :wk "Git stage file")
    "g t" '(git-timemachine :wk "Git time machine")
    "g u" '(magit-stage-file :wk "Git unstage file")
    
    ;; Help
    "h" '(:ignore t :wk "Help")
    "h f" '(describe-function :wk "Describe function")
    "h v" '(describe-variable :wk "Describe variable")
    "h t" '(tldr :wk "Lookup TLDR docs for a command")
    "h r r" '((lambda () (interactive)(load-file "~/.config/emacs/init.el")(ignore (elpaca-process-queues))) :wk "Reload emacs config")
    
    ;; Kalender
    "k" '(:ignore t :wk "Kalender")
    "k s" '(org-caldav-sync :wk "Sync Kalender mit Cloud")
    
    ;; Multi-Edit
    "m" '(:ignore t :wk "Edit with multiple cursors etc.")
    "m m" '(evil-multiedit-match-all :wk "Match All")
    "m M" '(evil-multiedit--marker :wk "Marker")
    "m m" '(evil-multiedit-match-and-next :wk "Match Next")

    ;; Notes
    "n" '(:ignore t :wk "Denote")
    "n n" '(denote :wk "Neue Note")
    "n t" '(denote-type :wk "Neue Note in nicht Standarddateiformat - .md .txt .org ...")
    "n r" '(denote-dired-rename-files :wk "Rename with file nameing konvention")
    "n l" '(denote-link :wk "Link a Note")
    "n b" '(denote-link-backlinks :wk "Minibuffer mit Backlinks")
    "n f" '(denote-link-find-file :wk "Find a Note")
    "n i" '(denote-link-after-creating-with-command :wk "Insert Link to new file without visiting it - kann dann später ergänzt werden")
    "n o" '(denote-open-or-create :wk "Note öffnen")
    
    ;; org-mode
    "o" '(:ignore t :wk "Org")
    "o a" '(org-agenda :wk "Org agenda")
    "o A" '(org-archive-subtree :wk "Archive Org Subtree")
    "o b" '(org-babel-tangle :wk "Org babel tangle")
    "o E" '(org-export-dispatch :wk "Org export dispatch")
    "o e" '(mane-export-to-pdf-and-clean :wk "Export pdf + clean dir from .tex... files")
    "o d" '(:ignore t :wk "Date/deadline")
    "o d t" '(org-time-stamp :wk "Org time stamp")
    "o i" '(org-toggle-item :wk "Org toggle item")
    "o l" '(org-store-link :wk "Speichert Link to this Point")
    "o L" '(org-insert-link :wk "Fügt gespeicherten Link ein")
    "o s" '(org-table-shrink :wk "Shrink Table")
    "o S" '(org-table-expand :wk "Expand Table")
    "o t" '(org-todo :wk "Org todo")
    "o T" '(org-todo-list :wk "Org todo list")
    
    ;; Paste
    "p" '(yank-from-kill-ring :wk "Einfügen aus kill-ring")
    
    ;; Register & Referenzierung
    "r" '(:ignore t :wk "Register")
    "R" '(:ignore t :wk "Referenzieren mit org-ref")
    "R l" '(org-ref-insert-link :wk "Quelle einfügen")
    "R o" '(org-ref-open-bibtex-notes :wk "Notiz zur Quelle öffnen")
    "R O" '(org-ref-open-bibtex-notes :wk "pdf zur Quelle öffnen")
    "r w" '(window-configuration-to-register :wk "Window configuration to register")
    "r f" '(frameset-to-register :wk "Frameset to register")
    "r j" '(jump-to-register :wk "Jump to register")
    "r l" '(list-registers :wk "List registers")
    "r v" '(view-register :wk "View a register")
    "r p" '(point-to-register :wk "Point to register")
    
    ;; Suche & Ediff
    "s" '(:ignore t :wk "Search")
    "S" '(consult-ripgrep t :wk "Search for line in files") ;geht auch mit consult-grep
    "s s" '(consult-line :wk "Suche")
    "s S" '(consult-outline :wk "Suche nach Headings/Funktionen,...")
    "s q" '(query-replace :wk "Finden und ersetzen")
    "s i" '(imenu :wk "imenu")
    "s l" '(imenu-list :wk "imenu-list")
    "s d" '(ediff-files :wk "Diffs zwischen 2 Dateien")
    "s D" '(ediff-buffers :wk "Diffs zwischen offenen Buffern")
    "s m" '(dired-mark-files-regexp :wk "Markiere mit regexp")
    "s r" '(rg :wk "ripgrep - Inhalt in Dateien suchen")
    "s R" '(mane-change-to-wgrep-and-evil-insert :wk "Bearbeiten des ripgrep Buffer")
    
    ;; Toggle & Theme
    "t" '(:ignore t :wk "Toggle")
    "T" '(load-theme :wk "Load a Theme")
    "t 1" '(mane-toggle-org-block-delimiters :wk "sourc-block start und Ende anzeigen")
    "t 2" '(org-toggle-link-display :wk "Toggle show full links")
    "t d" '(load-theme-mane-2 :wk "Load dark Theme")
    "t h" '(load-theme-mane-1 :wk "Load light Theme")
    "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
    "t L" '(visual-line-mode :wk "Toggle truncated lines")
    "t m" '(feebleline-mode :wk "Toggle minimal modeline")
    "t t" '(org-transclusion-mode :wk "org-transclusion-aktivieren")
    "t T" '(org-transclusion-add :wk "org-transclusion-aktivieren")
    "t v" '(vterm-toggle :wk "Toggle vterm")
))
(use-package sudo-edit   ;;https://github.com/nflath/sudo-edit
  :config
    (mane-leader-keys
      "fu" '(sudo-edit-find-file :wk "Sudo find file")
      "fU" '(sudo-edit :wk "Sudo edit file")))

(defun emacs-counsel-launcher ()
  "Erstellt einen minibuffer/frame mit dem Name emacs-counsel-launcher welcher über qtile mit dem Namen angesprochen werden kann und zu den floating windows hinzugefügt werden kann.  Ist nicht so gut wie der app-launcher, da die Inhalte direkt aus dem /bin direktory gezogen werden und bezüglich Name nicht so klar sind."
  (interactive)
  (with-selected-frame
    (make-frame '((name . "emacs-run-launcher")
                  (minibuffer . only)
                  (fullscreen . 0) ; no fullscreen
                  (undecorated . t) ; remove title bar
                  ;;(auto-raise . t) ; focus on this frame
                  ;;(tool-bar-lines . 0)
                  ;;(menu-bar-lines . 0)
                  (internal-border-width . 10)
                  (width . 80)
                  (height . 11)))
                  (unwind-protect
                    (counsel-linux-app)
                    (delete-frame))))

(use-package app-launcher ;;ACHTUNG: Mit helm funktioniert es nicht mehr bzw. brauche ich dann zwei funktionen um es kurfristig zu deaktivieren und danach direkt wieder zu aktivieren und diese Funktionen muss ich dann in emacs-run-launcher einfügen - aktuell nutze ich kein helm!
  :ensure t
'(app-launcher :host github :repo "SebastienWae/app-launcher"))
;; create a global keyboard shortcut with the following code
;; emacsclient -cF "((visibility . nil))" -e "(emacs-run-launcher)"

(defun emacs-run-launcher ()
  "Erstellt einen minibuffer der emacs-run-launcher heißt und die hier angegebene Größe hat. Mit ihm kann man ähnlich zu rofi und dmenu Apps öffnen."
  (interactive)
  (with-selected-frame
      (make-frame '((name . "emacs-run-launcher")
                    (minibuffer . only)
                    (fullscreen . 0) ; no fullscreen
                    (undecorated . t) ; remove title bar
                    (internal-border-width . 10)
                    (width . 80)
                    (height . 11)))
    (unwind-protect
        (app-launcher-run-app)
      (delete-frame))))

(use-package all-the-icons  ;This is an icon set that can be used with dashboard, dired, ibuffer and other Emacs programs.
  :ensure t
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(require 'windmove)

;;;###autoload
(defun buf-move-up ()
  "Swap the current buffer and the buffer above the split.
If there is no split, ie now window above the current one, an
error is signaled."
;;  "Switches between the current buffer, and the buffer above the
;;  split, if possible."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'up))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No window above this one")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

;;;###autoload
(defun buf-move-down ()
"Swap the current buffer and the buffer under the split.
If there is no split, ie now window under the current one, an
error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'down))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (or (null other-win) 
            (string-match "^ \\*Minibuf" (buffer-name (window-buffer other-win))))
        (error "No window under this one")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

;;;###autoload
(defun buf-move-left ()
"Swap the current buffer and the buffer on the left of the split.
If there is no split, ie now window on the left of the current
one, an error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'left))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No left split")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

;;;###autoload
(defun buf-move-right ()
"Swap the current buffer and the buffer on the right of the split.
If there is no split, ie now window on the right of the current
one, an error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'right))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No right split")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))
;;Sinnvolle Einstellungen
(setq user-full-name "Markus Hoffmann"
      confirm-kill-emacs nil ;kein nerviges nachfragen ob Emacs wirklich geschlossen werden soll
      auth-sources '((:source "~/.authinfo.gpg"))
      org-confirm-babel-evaluate nil
      use-short-answers t  ;statt der Eingabe yes und no reicht ein einfaches y und n!
      auto-save-file-name-transforms `((".*" ,"/home/flowmis/cloud/life/zeit/papierkorb/emacs/" t))
      backup-directory-alist '((".*" . "/home/flowmis/cloud/life/zeit/papierkorb/emacs/")))  ;;Standardmäßig werden beim bearbeiten von .org Dateien temporäre Dateien erzeugt um im Notfall ein Backup zu haben, aber da es nervt diese Dateien immer in den Verzeichnissen angezeigt bekommen stelle ich hier ein, dass dies im Papierkorb gespeichert werden, sodass ich zur Not dort für ein Backup schauen kann.
;; (set-face-attribute 'default nil :height 100) ; Schriftgröße einstellen ; Schriftgröße einstellen
(global-set-key [escape] 'keyboard-escape-quit)  ;;By default, Emacs requires you to hit ESC three times to escape quit the minibuffer.  
(delete-selection-mode 1)    ;; You can select text and delete it by typing.
(electric-indent-mode -1)    ;; Turn off the weird indenting that Emacs does by default.
(electric-pair-mode 1)       ;; Turns on automatic parens pairing
(global-auto-revert-mode t)  ;; Automatically show changes if the file has changed
(global-display-line-numbers-mode -1) ;; Display line numbers
(global-visual-line-mode t)  ;; Enable truncated lines
(menu-bar-mode -1)           ;; Disable the menu bar 
(scroll-bar-mode -1)         ;; Disable the scroll bar
(tool-bar-mode -1)           ;; Disable the tool bar
(blink-cursor-mode -1)           ;; Disable the tool bar

(use-package tldr)           ;; Hier kann ich gekürzte Infos über Terminalbefehle bekommen

;;Display the actual color as a background for any hex color value (ex. #ffffff).  The code block below enables rainbow-mode in all programming modes (prog-mode) as well as org-mode, which is why rainbow works in this document.  
(use-package rainbow-mode
  :hook 
  ((org-mode prog-mode) . rainbow-mode))
(use-package rainbow-delimiters ;;Adding rainbow coloring to parentheses.
  :hook ((emacs-lisp-mode . rainbow-delimiters-mode)
         (clojure-mode . rainbow-delimiters-mode)))

(provide 'setup-settings-basics)
;;; setup-settings-basics.el ends here
