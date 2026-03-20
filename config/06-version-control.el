;; -*- lexical-binding: t -*-
;;; 06-version-control.el --- Git and version control integration

;;; Commentary:
;; Comprehensive Git integration with Magit and related tools

;;; Code:

;; Magit - the best Git interface
(use-package magit
  :bind
  (("C-x g" . magit-status)
   ("C-x M-g" . magit-dispatch)
   ("C-c g b" . magit-blame-addition)
   ("C-c g l" . magit-log-buffer-file)
   ("C-c g p" . magit-pull))
  :config
  (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1
        magit-repository-directories '(("~/code-projects/" . 1)
                                       ("~/repos/" . 1))
        magit-save-repository-buffers 'dontask
        magit-revision-show-gravatars '("^Author:     " . "^Commit:     ")
        magit-diff-refine-hunk 'all))

;; Enhanced Git commit interface
(use-package git-commit
  :hook (git-commit-mode . (lambda ()
                            (setq fill-column 72)
                            (turn-on-auto-fill))))

;; Show Git info in modeline
(use-package git-modes)

;; Git gutter for showing changes
(use-package git-gutter-fringe
  :hook (after-init . global-git-gutter-mode)
  :config
  (setq git-gutter:update-interval 0.1
        git-gutter:modified-sign "│"
        git-gutter:added-sign "│"
        git-gutter:deleted-sign "│")
  (set-face-foreground 'git-gutter:modified "orange")
  (set-face-foreground 'git-gutter:added "green")
  (set-face-foreground 'git-gutter:deleted "red"))

;; Git timemachine for browsing history
(use-package git-timemachine
  :bind ("C-c g t" . git-timemachine))

;; Enhanced blame with git-messenger
(use-package git-messenger
  :bind ("C-c g m" . git-messenger:popup-message)
  :config
  (setq git-messenger:show-detail t
        git-messenger:use-magit-popup t))

;; Browse GitHub/GitLab/etc from Emacs
(use-package browse-at-remote
  :bind ("C-c g r" . browse-at-remote))

;; Git link generation
(use-package git-link
  :bind
  (("C-c g L" . git-link)
   ("C-c g C" . git-link-commit)
   ("C-c g H" . git-link-homepage))
  :config
  (setq git-link-open-in-browser t))

;; Diff highlighting
(use-package diff-hl
  :hook ((magit-pre-refresh . diff-hl-magit-pre-refresh)
         (magit-post-refresh . diff-hl-magit-post-refresh))
  :config
  (global-diff-hl-mode))

;; Resolve merge conflicts with smerge
(use-package smerge-mode
  :ensure nil
  :hook (prog-mode . (lambda ()
                      (save-excursion
                        (goto-char (point-min))
                        (when (re-search-forward "^<<<<<<< " nil t)
                          (smerge-mode 1)))))
  :bind
  (:map smerge-mode-map
   ("C-c m RET" . smerge-keep-current)
   ("C-c m a" . smerge-keep-all)
   ("C-c m b" . smerge-keep-base)
   ("C-c m l" . smerge-keep-lower)
   ("C-c m n" . smerge-next)
   ("C-c m p" . smerge-prev)
   ("C-c m r" . smerge-resolve)
   ("C-c m u" . smerge-keep-upper)))

;; GitHub integration
(use-package forge
  :after magit
  :config
  (setq forge-add-default-bindings nil))

;; GitLab CI support
(use-package gitlab-ci-mode)

;; Conventional commits
(use-package conventional-commit
  :hook (git-commit-mode . conventional-commit-setup))

(provide '06-version-control)
;;; 06-version-control.el ends here