
;;; package --- setup-settings-basics.el
;;; Commentary:
;; Paketmanager elpaca + use-package support + evil keys...
;;; Code:
(defvar elpaca-installer-version 0.6)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil
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
                 ((zerop (call-process "git" nil buffer t "clone"
                                       (plist-get order :repo) repo)))
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
    (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
    (setq evil-want-keybinding nil)
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
    "." '(find-file :which-key "Find file")
    "=" '(perspective-map :wk "Perspective") ;; Lists all the perspective keybindings
    "TAB TAB" '(comment-line :wk "Comment lines")
    "SPC" '(lambda () (interactive) (find-file "~/.config/emacs/start.org") :wk "Zum Dashboard")
    "b" '(:ignore t :wk "Buffer-Keybindings")
    "b b" '(switch-to-buffer :wk "Switch Buffer")
    "b k" '(kill-this-buffer :wk "Kill Buffer")
    "b n" '(next-buffer :wk "Nächster Buffer")
    "b v" '(previous-buffer :wk "Vorheriger Buffer")
    "b r" '(revert-buffer :wk "Reload Buffer")
    "b i" '(ibuffer :wk "Liste offener Buffer")
    "b y" '(copy-current-path-to-clipboard :wk "Copy Path to this Buffer")
    "d" '(:ignore t :wk "Dired")
    "d d" '(dired :wk "Open dired")
    "d j" '(dired-jump :wk "Dired jump to current")
    "d n" '(neotree-dir :wk "Open directory in neotree")
    "d p" '(peep-dired :wk "Peep-dired")
    "e" '(:ignore t :wk "Eshell & Evaluate")
    "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
    "e d" '(eval-defun :wk "Evaluate defun containing or after point")
    "e e" '(eval-last-sexp :wk "Evaluate the last expression")
    "e E" '(eval-expression :wk "Evaluate an elisp expression")
    "e h" '(counsel-esh-history :wk "Eshell history")
    "e r" '(eval-region :wk "Evaluate elisp in region")
    "e s" '(eshell :which-key "Eshell")
    "f c" '((lambda () (interactive) (find-file "~/flowmis-os/emacs/config.org")) :wk "Gehe zur emacs config")
    "f C" '((lambda () (interactive) (find-file "~/.config/emacs/config.org")) :wk "Gehe zur aktuellen emacs config")
    "f f" '((lambda () (interactive) (find-file "~/flowmis-os/flowmis-os.org")) :wk "Gehe zu flowmis-os")
    "f r" '(counsel-recentf :wk "Find recent files")
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
    "h" '(:ignore t :wk "Help")
    "h f" '(describe-function :wk "Describe function")
    "h v" '(describe-variable :wk "Describe variable")
    "h t" '(tldr :wk "Lookup TLDR docs for a command")
    "h r r" '((lambda () (interactive)(load-file "~/.config/emacs/init.el")(ignore (elpaca-process-queues))) :wk "Reload emacs config")
    ;; Note taking
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
    "o e" '(org-export-dispatch :wk "Org export dispatch")
    "o i" '(org-toggle-item :wk "Org toggle item")
    "o t" '(org-todo :wk "Org todo")
    "o B" '(org-babel-tangle :wk "Org babel tangle")
    "o T" '(org-todo-list :wk "Org todo list")
    "o b" '(:ignore t :wk "Tables")
    "o b -" '(org-table-insert-hline :wk "Insert hline in table")
    "o d" '(:ignore t :wk "Date/deadline")
    "o d t" '(org-time-stamp :wk "Org time stamp")
    ;; search
    "s" '(:ignore t :wk "Search")
    "s s" '(helm-swoop :wk "Toggle")
    "s i" '(imenu :wk "imenu")
    "s l" '(imenu-list :wk "imenu-list")
    ;; Toggle & Theme
    "t" '(:ignore t :wk "Toggle")
    "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
    "t t" '(org-transclusion-mode :wk "org-transclusion-aktivieren")
    "t T" '(org-transclusion-add :wk "org-transclusion-aktivieren")
    "t L" '(visual-line-mode :wk "Toggle truncated lines")
    "t v" '(vterm-toggle :wk "Toggle vterm")
    "t h" '(load-theme-mane-1 :wk "Load light Theme")
    "t n" '(neotree-toggle :wk "Toggle neotree file viewer")
    "t d" '(load-theme-mane-2 :wk "Load dark Theme")
    "T" '(load-theme :wk "Load a Theme")
    ;; Window splits
    "w" '(:ignore t :wk "Windows")
    "w c" '(evil-window-delete :wk "Close window")
    "w n" '(evil-window-new :wk "New window")
    "w s" '(evil-window-split :wk "Horizontal split window")
    "w v" '(evil-window-vsplit :wk "Vertical split window")
    ;; Window motions
    "w h" '(evil-window-left :wk "Window left")
    "w j" '(evil-window-down :wk "Window down")
    "w k" '(evil-window-up :wk "Window up")
    "w l" '(evil-window-right :wk "Window right")
    "w w" '(evil-window-next :wk "Goto next window")
    ;; Move Windows
    "w H" '(buf-move-left :wk "Buffer move left")
    "w J" '(buf-move-down :wk "Buffer move down")
    "w K" '(buf-move-up :wk "Buffer move up")
    "w L" '(buf-move-right :wk "Buffer move right")
))
(use-package sudo-edit   ;;https://github.com/nflath/sudo-edit
  :config
    (mane-leader-keys
      "fu" '(sudo-edit-find-file :wk "Sudo find file")
      "fU" '(sudo-edit :wk "Sudo edit file")))

(defun emacs-counsel-launcher ()
  "Create and select a frame called emacs-counsel-launcher which consists only of a minibuffer and has specific dimensions. Runs counsel-linux-app on that frame, which is an emacs command that prompts you to select an app and open it in a dmenu like behaviour. Delete the frame after that command has exited"
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

(defun disable-helm-temporarily ()
  "Temporarily disable helm mode."
  (helm-mode -1))

(defun reenable-helm ()
  "Re-enable helm mode."
  (helm-mode 1))

(use-package app-launcher
  :ensure t
'(app-launcher :host github :repo "SebastienWae/app-launcher"))
;; create a global keyboard shortcut with the following code
;; emacsclient -cF "((visibility . nil))" -e "(emacs-run-launcher)"

(defun emacs-run-launcher ()
  "Create and select a frame called emacs-run-launcher which consists only of a minibuffer and has specific dimensions. Runs app-launcher-run-app on that frame, which is an emacs command that prompts you to select an app and open it in a dmenu like behaviour. Delete the frame after that command has exited"
  (interactive)
  (disable-helm-temporarily) ; Deaktiviere helm vor dem Ausführen
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
      (delete-frame)
      (reenable-helm)))) ; Reaktiviere helm nach dem Ausführen

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
