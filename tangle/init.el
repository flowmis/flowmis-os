(org-babel-load-file
 (expand-file-name
  "config.org"
  user-emacs-directory))
;; beim start/init wird hierdurch  auf die config.org als Konfigurationsdatei verwiesen wodurch dann die config.org automatisch in eine config.el umgewandelt wird!
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("88f7ee5594021c60a4a6a1c275614103de8c1435d6d08cc58882f920e0cec65e" "56044c5a9cc45b6ec45c0eb28df100d3f0a576f18eef33ff8ff5d32bac2d9700" "281e53e7b3d9be5aa622d9d43f0ad893e1ec76c7e2afddfd37ebf27ef79d04ba" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)
