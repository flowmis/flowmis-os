;;; doom-mane-theme.el --- mane light soft -*- lexical-binding: t; no-byte-compile: t; -*-
(require 'doom-themes)

;;
(defgroup doom-mane-theme nil
  "Options for the `doom-mane' theme."
  :group 'doom-themes)

(defcustom doom-mane-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-mane-theme
  :type 'boolean)

(defcustom doom-mane-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-mane-theme
  :type 'boolean)

(defcustom doom-mane-comment-bg doom-mane-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-mane-theme
  :type 'boolean)

(defcustom doom-mane-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-mane-theme
  :type '(choice integer boolean))

(defcustom doom-mane-variant nil
  "A choice of \"hard\" or \"soft\" can be used to change the
background contrast. All other values default to \"medium\"."
  :group 'doom-mane-theme
  :type  'string)

(def-doom-theme doom-mane
  "mane light theme"
;;folgende Farben müssen zum funktionieren des Themes definiert sein
  ((bg                  '("#fbf1c7"))
   (bg-alt              '("#f2e5bc"))
   (base0               '("#f0f0f0"))
   (base1               '("#ebdbb2"))
   (base2               '("#d5c4a1"))
   (base3               '("#bdae93"))
   (base4               '("#a89984"))
   (base5               '("#504945"))
   (base6               '("#3c3836"))
   (base7               '("#282828"))
   (base8               '("#1d2021"))
   (fg                  '("#282828"))
   (fg-alt              '("#1c1c1c"))
   (grey                '("#928374"))
   (red                 '("#9d0006"))
   (orange              '("#af3a03"))
   (green               '("#79740e"))
   (teal                '("#4db5bd"))
   (yellow              '("#b57614"))
   (blue                '("#076678"))
   (dark-blue           '("#2b3c44"))
   (magenta             '("#b16286"))
   (violet              '("#8f3f71"))
   (cyan                '("#427b58"))
   (dark-cyan           '("#36473a"))
;; Extra - Farben die ich benutze
   (mane1               '("#00606b"))
   (mane2               '("#613e53"))
   (mane3               '("#c27da7"))
   (mane4               '("#d65d0e"))
   (mane5               '("#9d0006"))
   (mane6               '("#000000"))
   (mane7               '("#ffffff"))

   ;; face categories -- required for all themes
   (highlight      base4)
   (vertical-bar   (doom-darken base1 0.1))
   (selection      base3)
   (builtin        mane4)
   (comments       (if doom-mane-brighter-comments base5 base4))
   (doc-comments   mane1)
   (constants      mane3)
   (functions      mane4)
   (keywords       mane5)
   (methods        mane1)
   (operators      mane1)
   (type           mane3)
   (strings        mane1)
   (variables      mane1)
   (numbers        mane3)
   (region         `(,(doom-darken (car bg-alt) 0.1) ,@(doom-darken (cdr base0) 0.3)))
   (error          mane5)
   (warning        mane4)
   (success        mane1)
   (vc-modified    mane4)
   (vc-added       mane1)
   (vc-deleted     mane5)

   ;; custom categories
   (-modeline-bright doom-mane-brighter-modeline)
   (-modeline-pad
    (when doom-mane-padded-modeline
      (if (integerp doom-mane-padded-modeline) doom-mane-padded-modeline 4)))

   (modeline-fg     nil)
   (modeline-fg-alt (doom-blend mane3 base4 (if -modeline-bright 0.5 0.2)))

   (modeline-bg
    (if -modeline-bright
        (doom-darken base2 0.05)
      base1))
   (modeline-bg-l
    (if -modeline-bright
        (doom-darken base2 0.1)
      base2))
   (modeline-bg-inactive (doom-darken bg 0.1))
   (modeline-bg-inactive-l `(,(doom-darken (car bg-alt) 0.05) ,@(cdr base1))))


  ;;;; Base theme face overrides
  ((cursor :background base4)
   ((font-lock-comment-face &override) :background (if doom-mane-comment-bg base0))
   ((font-lock-doc-face &override) :slant 'italic)
   (isearch           :foreground mane6 :background mane4)
   (isearch-fail      :foreground fg :background mane5)
   (lazy-highlight    :background base2  :foreground base8 :distant-foreground base0 :weight 'bold)
   ((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground mane4)
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if -modeline-bright base8 highlight))
   (tooltip :background base1 :foreground base6)

   ;;;; anzu
   (anzu-mode-line         :foreground mane4 :weight 'bold)
   (anzu-match-1           :background mane1)
   (anzu-match-2           :background mane4)
   (anzu-match-3           :background mane1)
   (anzu-replace-to        :foreground mane4)
   (anzu-replace-highlight :inherit 'isearch)
   ;;;; centaur-tabs
   (centaur-tabs-unselected :background bg-alt :foreground base4)
   ;;;; company
   (company-scrollbar-bg                      :background base1)
   (company-scrollbar-fg                      :background bg-alt)
   (company-tooltip                           :background bg-alt)
   (company-tooltip-annotation                :foreground mane1)
   (company-tooltip-annotation-selection      :inherit 'company-tooltip-annotation)
   (company-tooltip-selection                 :foreground mane3 :background base2)
   (company-tooltip-common                    :foreground mane1 :underline t)
   (company-tooltip-common-selection          :foreground mane1 :underline t)
   (company-preview-common                    :foreground base7)
   (company-preview                           :background mane1)
   (company-preview-search                    :background mane1)
   (company-template-field                    :foreground mane6 :background mane4)
   (company-echo-common                       :foreground mane5)
   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground mane4)
   (css-property             :foreground mane1)
   (css-selector             :foreground mane1)
   ;;;; doom-modeline
   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))
   ;;;; diredfl
   (diredfl-autofile-name :foreground base5)
   (diredfl-compressed-file-name :foreground base5)
   (diredfl-compressed-file-suffix :foreground mane1)
   (diredfl-dir-priv :foreground mane1 :backgtround mane1)
   (diredfl-exec-priv :foreground mane1 :backgrond mane1)
   (diredfl-file-name :foreground base5)
   (diredfl-file-suffix :foreground base4)
   (diredfl-link-priv :foreground mane3)
   (diredfl-no-priv :foreground base5)
   (diredfl-number :foreground mane4)
   (diredfl-other-priv :foreground mane3)
   (diredfl-rare-priv :foreground base5)
   ;;;; diredp
   (diredp-file-name :foreground base5)
   (diredp-file-suffix :foreground base4)
   (diredp-compressed-file-suffix :foreground mane1)
   (diredp-dir-name :foreground mane1)
   (diredp-symlink :foreground mane4)
   (diredp-date-time :foreground base4)
   (diredp-number :foreground mane1)
   (diredp-no-priv :foreground base4)
   (diredp-other-priv :foreground base2)
   (diredp-rare-priv :foreground base4)
   (diredp-ignored-file-name :foreground base5)
   (diredp-dir-priv :foreground mane1 :background mane1)
   ((diredp-dir-exec-priv &inherit diredp-dir-priv))
   (diredp-link-priv :foreground mane1)
   ;;;; doom-emacs
   (doom-dashboard-banner      :foreground (doom-darken base4 0.3))
   (doom-dashboard-menu-title  :foreground mane1)
   (doom-dashboard-menu-desc   :foreground mane1)
   (doom-dashboard-footer-icon :foreground (doom-darken mane4 0.4))
   (doom-dashboard-loaded      :foreground mane4)
   ;;;; diff-mode
   (diff-changed                   :background nil :foreground base6)
   (diff-removed                   :background nil :foreground mane5)
   (diff-indicator-changed         :inherit 'diff-changed)
   (diff-indicator-added           :inherit 'diff-added)
   (diff-indicator-removed         :inherit 'diff-removed)
   ;;;; ediff <built-in>
   (ediff-current-diff-A        :foreground mane5   :background (doom-lighten mane5 0.8))
   (ediff-current-diff-B        :foreground mane1 :background (doom-lighten mane1 0.8))
   (ediff-current-diff-C        :foreground mane1  :background (doom-lighten mane1 0.8))
   (ediff-current-diff-Ancestor :foreground mane1  :background (doom-lighten mane1 0.8))
   ;;;; elfeedn
   (elfeed-search-title-face :foreground base5)
   (elfeed-search-date-face :inherit 'font-lock-builtin-face :underline t)
   (elfeed-search-tag-face :inherit 'font-lock-keyword-face)
   (elfeed-search-unread-count-face :inherit 'font-lock-comment-face)
   (elfeed-search-filter-face :inherit 'font-lock-string-face)
   ;;;; flycheck
   (flycheck-info :underline `(:style wave :color ,mane1))
   ;;;; git-gutter
   (git-gutter:modified :foreground mane1 :background mane1)
   (git-gutter:added    :foreground mane1 :background mane1)
   (git-gutter:deleted  :foreground mane5 :backgrond mane5)
   ;;;; git-gutter+
   (git-gutter+-modified :foreground mane1 :background mane1)
   (git-gutter+-added    :foreground mane1 :background mane1)
   (git-gutter+-deleted  :foreground mane5 :backgrond mane5)
   ;;;; helm
   (helm-candidate-number       :background mane1 :foreground bg)
   (helm-M-x-key                :foreground mane4)
   (helm-action                 :foreground base8 :underline t)
   (helm-bookmark-addressbook   :foreground mane5)
   (helm-bookmark-directory     :foreground mane3)
   (helm-bookmark-file          :foreground mane1)
   (helm-bookmark-gnus          :foreground mane3)
   (helm-bookmark-info          :foreground mane1)
   (helm-bookmark-man           :foreground mane4)
   (helm-bookmark-w3m           :foreground mane4)
   (helm-buffer-directory       :foreground mane7 :background mane1)
   (helm-buffer-not-saved       :foreground mane5)
   (helm-buffer-process         :foreground base4)
   (helm-buffer-saved-out       :foreground mane5)
   (helm-buffer-size            :foreground mane3)
   (helm-candidate-number       :foreground mane1)
   (helm-ff-directory           :foreground mane3)
   (helm-ff-executable          :foreground mane1)
   (helm-ff-file                :foreground mane4)
   (helm-ff-invalid-symlink     :foreground mane7 :background mane5)
   (helm-ff-prefix              :foreground mane6 :background mane4)
   (helm-ff-symlink             :foreground mane4)
   (helm-grep-cmd-line          :foreground mane1)
   (helm-grep-file              :foreground mane3)
   (helm-grep-finish            :foreground mane1)
   (helm-grep-lineno            :foreground mane4)
   (helm-grep-match             :foreground mane4)
   (helm-grep-running           :foreground mane5)
   (helm-header                 :foreground mane1)
   (helm-helper                 :foreground mane1)
   (helm-history-deleted        :foreground mane6 :background mane5)
   (helm-history-remote         :foreground mane5)
   (helm-lisp-completion-info   :foreground mane4)
   (helm-lisp-show-completion   :foreground mane5)
   (helm-locate-finish          :foreground mane7 :background mane1)
   (helm-match                  :foreground mane4)
   (helm-moccur-buffer          :foreground mane1 :underline t)
   (helm-prefarg                :foreground mane1)
   (helm-selection              :foreground mane7 :background base2)
   (helm-selection-line         :foreground mane7 :background base2)
   (helm-separator              :foreground mane5)
   (helm-source-header          :foreground base5)
   (helm-visible-mark           :foreground mane6 :background base4)
   ;;;; ivy
   (ivy-minibuffer-match-face-1     :foreground mane4)
   (ivy-minibuffer-match-face-2     :foreground mane4)
   (ivy-minibuffer-match-face-3     :foreground mane4)
   (ivy-minibuffer-match-face-4     :foreground mane4)
   ;;;; ivy-posframe
   (ivy-posframe               :background bg-alt)
   ;;;; js2-mode
   (js2-warning                    :underline `(:style wave :color ,mane4))
   (js2-error                      :underline `(:style wave :color ,mane5))
   (js2-external-variable          :underline `(:style wave :color ,mane1))
   (js2-jsdoc-tag                  :background nil :foreground base5  )
   (js2-jsdoc-type                 :background nil :foreground base4)
   (js2-jsdoc-value                :background nil :foreground base4)
   (js2-function-param             :background nil :foreground mane1)
   (js2-function-call              :background nil :foreground mane1)
   (js2-instance-member            :background nil :foreground mane4)
   (js2-private-member             :background nil :foreground mane4)
   (js2-private-function-call      :background nil :foreground mane1)
   (js2-jsdoc-html-tag-name        :background nil :foreground base4)
   (js2-jsdoc-html-tag-delimiter   :background nil :foreground base4)
   ;;;; lsp-mode
   (lsp-face-highlight-textual     :background (doom-blend bg mane4 0.9) :foreground base0 :distant-foreground base8)
   ;;;; lsp-ui
   (lsp-ui-doc-background          :background base2)
   ;;;; magit
   (magit-bisect-bad                      :foreground mane5)
   (magit-bisect-good                     :foreground mane1)
   (magit-bisect-skip                     :foreground mane4)
   (magit-blame-heading                   :foreground base7 :background base2)
   (magit-branch-local                    :foreground mane1)
   (magit-branch-current                  :underline mane1 :inherit 'magit-branch-local)
   (magit-branch-remote                   :foreground mane1)
   (magit-cherry-equivalent               :foreground mane3)
   (magit-cherry-unmatched                :foreground mane1)
   (magit-diff-added                      :foreground mane1)
   (magit-diff-added-highlight            :foreground mane1 :inherit 'magit-diff-context-highlight)
   (magit-diff-base                       :background mane4 :foreground base5)
   (magit-diff-base-highlight             :background mane4 :foreground base7)
   (magit-diff-context                    :foreground base1 :foreground base6)
   (magit-diff-context-highlight          :background base1 :foreground base7)
   (magit-diff-hunk-heading               :background base3 :foreground base5)
   (magit-diff-hunk-heading-highlight     :background base2 :foreground base7)
   (magit-diff-hunk-heading-selection     :background base2 :foreground mane4)
   (magit-diff-lines-heading              :background mane4 :foreground base7)
   (magit-diff-removed                    :foreground mane5)
   (magit-diff-removed-highlight          :foreground mane5 :inherit 'magit-diff-context-highlight)
   (magit-diffstat-added                  :foreground mane1)
   (magit-diffstat-removed                :foreground mane5)
   (magit-dimmed                          :foreground base4)
   (magit-hash                            :foreground mane1)
   (magit-log-author                      :foreground mane5)
   (magit-log-date                        :foreground mane1)
   (magit-log-graph                       :foreground base4)
   (magit-process-ng                      :foreground mane5 :weight 'bold)
   (magit-process-ok                      :foreground mane1 :weight 'bold)
   (magit-reflog-amend                    :foreground mane3)
   (magit-reflog-checkout                 :foreground mane1)
   (magit-reflog-cherry-pick              :foreground mane1)
   (magit-reflog-commit                   :foreground mane1)
   (magit-reflog-merge                    :foreground mane1)
   (magit-reflog-other                    :foreground mane1)
   (magit-reflog-rebase                   :foreground mane3)
   (magit-reflog-remote                   :foreground mane1)
   (magit-reflog-reset                    :foreground mane5)
   (magit-refname                         :foreground base4)
   (magit-section-heading                 :foreground mane4 :weight 'bold)
   (magit-section-heading-selection       :foreground mane4)
   (magit-section-highlight               :background base1)
   (magit-sequence-drop                   :foreground mane4)
   (magit-sequence-head                   :foreground mane1)
   (magit-sequence-part                   :foreground mane4)
   (magit-sequence-stop                   :foreground mane1)
   (magit-signature-bad                   :foreground mane5 :weight 'bold)
   (magit-signature-error                 :foreground mane5)
   (magit-signature-expired               :foreground mane4)
   (magit-signature-good                  :foreground mane1)
   (magit-signature-revoked               :foreground mane3)
   (magit-signature-untrusted             :foreground mane1)
   (magit-tag                             :foreground mane4)
   ;;;; markdown-mode
   (markdown-markup-face     :foreground base5)
   (markdown-header-face     :inherit 'bold :foreground mane5)
   ((markdown-code-face &override)       :background base1)
   (mmm-default-submode-face :background base1)
   (markdown-header-face-1          :foreground mane1)
   (markdown-header-face-2          :foreground mane4)
   (markdown-header-face-3          :foreground mane3)
   (markdown-header-face-4          :foreground mane5)
   (markdown-header-face-5          :foreground mane1)
   (markdown-header-face-6          :foreground mane1)
   ;;;; message <built-in>
   (message-header-cc :inherit 'font-lock-variable-name-face)
   (message-header-subject :foreground mane4 :weight 'bold)
   (message-header-other :inherit 'font-lock-variable-name-face)
   (message-header-name :inherit 'font-lock-keyword-face)
   (message-cited-text :inherit 'font-lock-comment-face)
   (message-mml :foregrond mane1 :weight 'bold)
   ;;;; mu4e
   (mu4e-highlight-face :foreground mane1)
   (mu4e-unread-face :foreground mane1 :weight 'bold)
   (mu4e-header-key-face :foreground mane1 :weight 'bold)
   ;;;; outline <built-in>
   ((outline-1 &override) :foreground mane5)
   ((outline-2 &override) :foreground mane4)
   ;;;; org <built-in>
   (org-agenda-date-today       :foreground base7 :weight 'bold :italic t)
   (org-agenda-done             :foreground mane1)
   (org-agenda-structure        :inherit 'font-lock-comment-face)
   (org-archived                :foreground base7 :weight 'bold)
   (org-block                   :background base1 :extend t)
   (org-block-begin-line        :background base1 :extend t)
   (org-block-end-line          :background base1 :extend t)
   (org-date                    :foreground mane1 :underline t)
   (org-deadline-announce       :foreground mane5)
   (org-document-info           :foreground mane1)
   (org-document-title          :foreground mane1)
   (org-done                    :foreground mane1 :weight 'bold :bold t)
   (org-drawer                  :inherit 'font-lock-function-name-face :foreground mane6)
   (org-ellipsis                :foreground base1)
   (org-footnote                :foreground mane1 :underline t :weight 'thin)
   (org-formula                 :foreground mane4)
   (org-headline-done           :foreground mane1)
   (org-latex-and-related       :foreground mane1)
   (org-level-1                 :weight 'bold :underline nil :font "URW Bookman Light" :foreground mane1)
   (org-level-2                 :weight 'thin :underline nil :font "URW Bookman Light" :foreground mane2)
   (org-level-3                 :weight 'thin :underline nil :font "URW Bookman Light" :foreground mane3)
   (org-level-4                 :weight 'normal :underline nil :font "URW Bookman Light" :foreground mane3)
   (org-level-5                 :weight 'normal :underline nil :font "URW Bookman Light" :foreground mane3)
   (org-level-6                 :weight 'normal :underline nil :font "URW Bookman Light" :foreground mane3)
   (org-level-7                 :weight 'normal :underline nil :font "URW Bookman Light" :foreground mane3)
   (org-level-8                 :weight 'normal :underline nil :font "URW Bookman Light" :foreground mane3)
   (org-link                    :foreground mane1 :underline t)
   (org-scheduled               :foreground mane4)
   (org-scheduled-previously    :foreground mane5)
   (org-scheduled-today         :foreground mane1)
   (org-sexp-date               :foreground mane1 :underline t)
   (org-table                   :foreground mane1)
   (org-tag                     :weight 'thin :foreground cyan)
   (org-time-grid               :foreground mane4)
   (org-todo                    :foreground mane1 :weight 'normal)
   (org-upcoming-deadline       :inherit 'font-lock-keyword-face)
   (org-warning                 :foreground mane5 :weight 'bold)
   ;;;; org-habit
   (org-habit-clear-face          :background mane1)
   (org-habit-clear-future-face   :background mane1)
   (org-habit-ready-face          :background mane1)
   (org-habit-ready-future-face   :background mane1)
   (org-habit-alert-face          :background mane4)
   (org-habit-alert-future-face   :background mane4)
   (org-habit-overdue-face        :background mane5)
   (org-habit-overdue-future-face :background mane5)
   ;;;; popup
   (popup-face :foreground base6  :background base1)
   (popup-menu-selection-face :foreground fg :background mane1)
   (popup-menu-mouse-face :foreground fg :background mane1)
   (popup-tip-face :foreground base5 :background base2)
   ;;;; rainbow-delimiters
   (rainbow-delimiters-depth-3-face :foreground mane1)
   (rainbow-delimiters-depth-4-face :foreground mane4)
   (rainbow-delimiters-depth-7-face :foreground mane1)
   (rainbox-delimiters-depth-8-face :foreground mane4)
   (rainbow-delimiters-depth-11-face :foreground mane1)
   (rainbox-delimiters-depth-12-face :foreground mane4)
   (rainbow-delimiters-unmatched-face: :foreground fg :background 'nil)
   ;;;; swiper
   (swiper-line-face    :background base3 :foreground base0)
   (swiper-match-face-1 :inherit 'unspecified :background base1   :foreground base5)
   (swiper-match-face-2 :inherit 'unspecified :background mane4  :foreground base0 :weight 'bold)
   (swiper-match-face-3 :inherit 'unspecified :background mane3 :foreground base1 :weight 'bold)
   (swiper-match-face-4 :inherit 'unspecified :background mane1   :foreground base2 :weight 'bold)
   (swiper-background-match-face-1 :inherit 'unspecified :background base2)
   (swiper-background-match-face-2 :inherit 'unspecified :background base3)
   (swiper-background-match-face-3 :inherit 'unspecified :background base4)
   (swiper-background-match-face-4 :inherit 'unspecified :background base5)
   ;;;; solaire-mode
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))
   ;;;; web-mode
   (web-mode-current-element-highlight-face :background mane1 :foreground bg)
   ;;;; wgrep <built-in>
   (wgrep-face :background base1)
   ;;;; whitespace <built-in>
   (whitespace-trailing :foreground mane5 :background base1)
   (whitespace-line :foreground mane5 :background base1)
   (whitespace-indentation :foreground base4 :background bg)
   (whitespace-empty :foreground 'nil :background 'nil))
  ())


;;;Some Mane-Theme specials!!!;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(set-frame-parameter (selected-frame) 'alpha '(97 . 70))                                                        ;Zahl 1 nach alpha gibt Transparenz des aktiven Bildschirms und Zahl 2 gibt Transparenz wenn anderes Window im Focus ist
(setq visual-fill-column-width 280     ;Größe des seitlichen Rahmen
      visual-fill-column-center-text t) ;rückt Text in Mitte
(global-visual-fill-column-mode t)
(after! org
  :config
  (beacon-mode 1)                                                                                               ;hilft den Cursor schnell zu finden durch aufblinken
  ;; (setq display-line-numbers-type 'visual)                                                                   ;Einstellung falls ich Zeilennummern angezeigt bekommen will
  (setq display-line-numbers-type nil                                                                           ;schaltet Zeilennummern aus
        doom-font (font-spec :family "Source Code Pro Regular" :size 13)                                                ;setzt Schriftart etc.
        doom-variable-pitch-font (font-spec :family "Fira Code" :size 13)                                       ;wird mit variable-pitch-mode aktiviert -> Man kann auch einstellen dass beide Schriftarten in Org Datei für unterschiedliche Elemente verwendet werden
        doom-big-font (font-spec :family "Source Code Pro Regular" :size 20)                                            ;gut für Präsentationen (Schriftgröße etc noch anpassen)
        doom-unicode-font (font-spec :family "Source Code Pro" :size 13)
        doom-serif-font (font-spec :family "Source Code Pro" :size 10)
        org-superstar-headline-bullets-list '(" ")                                                              ;wird mit +pretty flag in init.el installiert und erlaubt mir die Einstellung der Punkte vor Org-Headern
        ;; org-superstar-headline-bullets-list '("◉" "○" "✿")                                                      ;wenn ich Bullets will hier deren Erscheinungsform einstellen (Anzahl egal da es durch Liste cycled)
        org-superstar-item-bullet-alist '((?* . ?>) (?+ . ?>) (?- . ?>))                                        ;Listen werden wie hier angegeben angezeigt (quasi das Aufzählungszeichen)
        org-hide-emphasis-markers t                                                                             ;+=/*~ etc. werden nicht angezeigt
        ;; org-todo-keyword-faces (quote (("EILIG" :foreground "#9d0006" :weight normal :underline t)
        ;;                                ("ZEITNAH" :foreground "#d65d0e" :weight normal :underline t)
        ;;                                ("IRGENDWANN" :foreground "#c27da7" :weight normal :underline t)
        ;;                                ("PAUSIERT" :foreground "#613e53" :weight normal :underline t)
        ;;                                ("BEENDET" :foreground "#000000" :weight normal :underline t)
        ;;                                ("ABGEBROCHEN" :foreground "#000000" :weight normal :underline t)
        ;;                                ("DELEGIERT" :foreground "#613e53" :weight normal :underline t)))

        ;; org-fancy-priorities-list '((?A . "⏰")                                                              ;wird mit +pretty flag in init.el installiert, aber macht es finde ich hässlich
        ;;                             (?B . "🐶")
        ;;                             (?C . "🌞")
        ;;                             (?D . "⏰")
        ;;                             (?1 . "🍽")
        ;;                             (?2 . "☕")
        ;;                             (?I . "Important"))
        org-ellipsis " ▼ "))                                                                                    ;Zeigt an das unter diesem Punkt eingefaltete Information liegt
(custom-set-faces!
  '(font-lock-comment-face :slant italic)                                                                       ;Macht Kommentare wie diesen kursiv
  '(font-lock-keyword-face :slant italic))                                                                      ;Macht Keywords wie setq, after! ... kursiv
;; (defun prefer-horizontal-split ()
;;   (set-variable 'split-height-threshold nil t)
;;   (set-variable 'split-width-threshold 40 t)) ; make this as low as needed
;; (add-hook 'markdown-mode-hook 'prefer-horizontal-split)
