;; -*- lexical-binding: t -*-
;;; 05-navigation.el --- Buffer and window navigation

;;; Commentary:
;; Enhanced navigation, window management, and workspace organization

;;; Code:

;; Winner mode for window configuration undo
(use-package winner
  :ensure nil
  :hook (after-init . winner-mode)
  :bind
  (("C-c <left>" . winner-undo)
   ("C-c <right>" . winner-redo)))

;; Window management with ace-window
(use-package ace-window
  :bind ("M-o" . ace-window)
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)
        aw-scope 'frame
        aw-background nil))

;; Better buffer switching
(use-package ibuffer
  :ensure nil
  :bind ("C-x C-b" . ibuffer)
  :config
  (setq ibuffer-saved-filter-groups
        '(("Default"
           ("Programming" (or (derived-mode . prog-mode)
                              (mode . ess-mode)
                              (mode . compilation-mode)))
           ("Text" (and (derived-mode . text-mode)
                        (not (starred-name))))
           ("TeX" (or (derived-mode . tex-mode)
                      (mode . latex-mode)
                      (mode . context-mode)
                      (mode . ams-tex-mode)
                      (mode . bibtex-mode)))
           ("Directories" (mode . dired-mode))
           ("Org" (or (mode . org-mode)
                      (mode . org-agenda-mode)))
           ("Gnus" (or (mode . message-mode)
                       (mode . bbdb-mode)
                       (mode . mail-mode)
                       (mode . gnus-group-mode)
                       (mode . gnus-summary-mode)
                       (mode . gnus-article-mode)
                       (name . "^\\.bbdb$")
                       (name . "^\\.newsrc-dribble")))
           ("Web" (or (mode . web-mode)
                      (mode . js2-mode)
                      (mode . css-mode)
                      (mode . html-mode)))
           ("Emacs" (or (name . "^\\*scratch\\*$")
                        (name . "^\\*Messages\\*$")
                        (name . "^\\*Warnings\\*$")
                        (name . "^\\*Compile-Log\\*$")
                        (name . "^\\*Help\\*$"))))))
  :hook (ibuffer . (lambda () (ibuffer-switch-to-saved-filter-groups "Default"))))

;; Ibuffer enhancements
(use-package nerd-icons-ibuffer
  :after ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

;; Better dired
(use-package dired
  :ensure nil
  :bind (:map dired-mode-map
         ("RET" . dired-find-alternate-file)
         ("^" . (lambda () (interactive) (find-alternate-file ".."))))
  :config
  (setq dired-recursive-deletes 'always
        dired-recursive-copies 'always
        dired-dwim-target t
        dired-auto-revert-buffer #'dired-directory-changed-p
        dired-listing-switches "-alh"))

;; Dired icons
(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

;; Dired collapse
(use-package dired-collapse
  :hook (dired-mode . dired-collapse-mode))

;; Dired hide details by default
(use-package dired-hide-details-mode
  :ensure nil
  :hook (dired-mode . dired-hide-details-mode))

;; Bookmark management
(use-package bookmark
  :ensure nil
  :config
  (setq bookmark-save-flag 1
        bookmark-default-file (expand-file-name "bookmarks" user-emacs-directory)))

;; Workspaces with perspective
(use-package perspective
  :bind
  (("C-x C-b" . persp-list-buffers)
   ("C-x b" . persp-switch-to-buffer*)
   ("C-x k" . persp-kill-buffer*))
  :custom
  (persp-mode-prefix-key (kbd "C-c M-p"))
  :init
  (persp-mode))

;; Centaur tabs for buffer tabs
(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  (setq centaur-tabs-style "bar"
        centaur-tabs-height 32
        centaur-tabs-set-icons t
        centaur-tabs-set-modified-marker t
        centaur-tabs-show-navigation-buttons t
        centaur-tabs-set-bar 'left
        centaur-tabs-gray-out-icons 'buffer
        centaur-tabs-show-count nil)
  :bind
  (("C-<prior>" . centaur-tabs-backward)
   ("C-<next>" . centaur-tabs-forward)
   ("C-c t s" . centaur-tabs-counsel-switch-group)
   ("C-c t p" . centaur-tabs-group-by-projectile-project)
   ("C-c t g" . centaur-tabs-group-buffer-groups)))

;; Treemacs for file tree
(use-package treemacs
  :bind
  (("M-0" . treemacs-select-window)
   ("C-x t 1" . treemacs-delete-other-windows)
   ("C-x t t" . treemacs)
   ("C-x t B" . treemacs-bookmark)
   ("C-x t C-t" . treemacs-find-file)
   ("C-x t M-t" . treemacs-find-tag))
  :config
  (setq treemacs-collapse-dirs 3
        treemacs-deferred-git-apply-delay 0.5
        treemacs-directory-name-transformer #'identity
        treemacs-display-in-side-window t
        treemacs-eldoc-display 'simple
        treemacs-file-event-delay 5000
        treemacs-file-extension-regex treemacs-last-period-regex-value
        treemacs-file-follow-delay 0.2
        treemacs-file-name-transformer #'identity
        treemacs-follow-after-init t
        treemacs-git-command-pipe ""
        treemacs-goto-tag-strategy 'refetch-index
        treemacs-indentation 2
        treemacs-indentation-string " "
        treemacs-is-never-other-window nil
        treemacs-max-git-entries 5000
        treemacs-missing-project-action 'ask
        treemacs-no-png-images nil
        treemacs-no-delete-other-windows t
        treemacs-project-follow-cleanup nil
        treemacs-persist-file (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
        treemacs-position 'left
        treemacs-recenter-distance 0.1
        treemacs-recenter-after-file-follow nil
        treemacs-recenter-after-tag-follow nil
        treemacs-recenter-after-project-jump 'always
        treemacs-recenter-after-project-expand 'on-distance
        treemacs-show-cursor nil
        treemacs-show-hidden-files t
        treemacs-silent-filewatch nil
        treemacs-silent-refresh nil
        treemacs-sorting 'alphabetic-asc
        treemacs-space-between-root-nodes t
        treemacs-tag-follow-cleanup t
        treemacs-tag-follow-delay 1.5
        treemacs-width 35))

(use-package treemacs-projectile
  :after (treemacs projectile))

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once))

(provide '05-navigation)
;;; 05-navigation.el ends here