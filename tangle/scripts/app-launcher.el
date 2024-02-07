
;;; package --- app-launcher.el
;;; Commentary - Emacs als App Launcher -> floating Minibuffer mit qtile: Name "emacs-run-launcher" als floating in qtile setzen. Den Emacs Deamon aktivieren und Keybinding für entsprechenden Terminal Befehl (emacsclient -cF "((visibility . nil))" -e "(emacs-counsel-launcher)" ODER: emacsclient -cF "((visibility . nil))" -e "(emacs-run-launcher)") einrichten.
;; Mit Counsel-Linux-App hat man eine Funktion die ähnlich zu einem App-Launcher wie Rofi funktioniert. Mit =counsel-linux-app= Linux apps starten - zeigt die Apps etsprechend ihrer bin commands und ist da diese nicht ganz klar erkennen lassen um welche App es sich handelt nicht immer ganz ideal.
;;; Code:
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
;; Das Paket =app-launcher= ist eine Verbesserung, da es die desktop applications im System findet und darstellt (Über den Namen sind die Programme hier leichter zu finden - oft auch filemanager oder ähnliches ausreichend um Programme dafür zu finden)
(use-package app-launcher
  :elpaca '(app-launcher :host github :repo "SebastienWae/app-launcher"))
;; create a global keyboard shortcut with the following code
;; emacsclient -cF "((visibility . nil))" -e "(emacs-run-launcher)"

(elpaca-wait)

(defun emacs-run-launcher ()
  "Create and select a frame called emacs-run-launcher which consists only of a minibuffer and has specific dimensions. Runs app-launcher-run-app on that frame, which is an emacs command that prompts you to select an app and open it in a dmenu like behaviour. Delete the frame after that command has exited"
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
                    (app-launcher-run-app)
                    (delete-frame))))
(provide 'app-launcher)
;;; app-launcher.el ends here
