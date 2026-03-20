;; -*- lexical-binding: t -*-
;;; 04-completion.el --- Advanced completion and fuzzy finding

;;; Commentary:
;; Ivy/Counsel/Swiper ecosystem for fuzzy completion and navigation

;;; Code:

;; Ivy completion framework
(use-package ivy
  :hook (after-init . ivy-mode)
  :bind
  (("C-c C-r" . ivy-resume)
   ("C-c v" . ivy-push-view)
   ("C-c s" . ivy-switch-view)
   ("C-c V" . ivy-pop-view))
  :config
  (setq ivy-use-virtual-buffers t
        ivy-count-format "(%d/%d) "
        ivy-height 15
        ivy-wrap t
        ivy-fixed-height-minibuffer t
        ivy-use-selectable-prompt t
        ivy-initial-inputs-alist nil
        ivy-re-builders-alist
        '((ivy-bibtex . ivy--regex-ignore-order)
          (t . ivy--regex-plus))))

;; Enhanced counsel commands
(use-package counsel
  :hook (after-init . counsel-mode)
  :bind
  (("M-x" . counsel-M-x)
   ("C-x C-f" . counsel-find-file)
   ("C-x C-r" . counsel-recentf)
   ("C-c f" . counsel-git)
   ("C-c j" . counsel-git-grep)
   ("C-c k" . counsel-ag)
   ("C-c l" . counsel-locate)
   ("C-h f" . counsel-describe-function)
   ("C-h v" . counsel-describe-variable)
   ("C-h b" . counsel-descbinds)
   ("C-h a" . counsel-apropos)
   ("C-h S" . counsel-info-lookup-symbol))
  :config
  (setq counsel-find-file-ignore-regexp "\\(?:^[#.]\\)\\|\\(?:[#~]$\\)\\|\\(?:^Icon?\\)"))

;; Ivy rich for better descriptions
(use-package ivy-rich
  :hook (ivy-mode . ivy-rich-mode)
  :config
  (setq ivy-rich-path-style 'abbrev
        ivy-virtual-abbreviate 'full))

;; Ivy icons
(use-package nerd-icons-ivy-rich
  :after ivy-rich
  :hook (ivy-mode . nerd-icons-ivy-rich-mode))

;; Prescient for intelligent sorting
(use-package prescient
  :config
  (prescient-persist-mode 1))

(use-package ivy-prescient
  :after (ivy prescient)
  :hook (ivy-mode . ivy-prescient-mode)
  :config
  (setq ivy-prescient-enable-filtering t
        ivy-prescient-enable-sorting t
        ivy-prescient-retain-classic-highlighting t))

;; Projectile for project management
(use-package projectile
  :hook (after-init . projectile-mode)
  :bind-keymap ("C-c p" . projectile-command-map)
  :config
  (setq projectile-completion-system 'ivy
        projectile-project-search-path '("~/code-projects/" "~/repos/")
        projectile-switch-project-action #'projectile-dired
        projectile-enable-caching t
        projectile-file-exists-remote-cache-expire nil
        projectile-require-project-root nil
        projectile-dynamic-mode-line nil))

;; Counsel integration with projectile
(use-package counsel-projectile
  :after (counsel projectile)
  :hook (projectile-mode . counsel-projectile-mode)
  :bind
  (("C-c C-p" . counsel-projectile)
   ("C-c p f" . counsel-projectile-find-file)
   ("C-c p s" . counsel-projectile-ag)))

;; Better grep with deadgrep
(use-package deadgrep
  :bind ("C-c g" . deadgrep))

;; Ripgrep integration
(use-package rg
  :config
  (rg-enable-default-bindings))

;; File/buffer switcher
(use-package ivy-posframe
  :if (display-graphic-p)
  :after ivy
  :hook (ivy-mode . ivy-posframe-mode)
  :config
  (setq ivy-posframe-display-functions-alist
        '((swiper          . ivy-posframe-display-at-point)
          (complete-symbol . ivy-posframe-display-at-point)
          (counsel-M-x     . ivy-display-function-fallback)
          (counsel-find-file . ivy-display-function-fallback)
          (t               . ivy-posframe-display-at-frame-center))
        ivy-posframe-parameters
        '((left-fringe . 8)
          (right-fringe . 8))))

;; Orderless completion style
(use-package orderless
  :config
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(provide '04-completion)
;;; 04-completion.el ends here