;; -*- lexical-binding: t -*-
;;; 02-ui.el --- User interface configuration

;;; Commentary:
;; Modern, clean UI setup with themes and visual improvements

;;; Code:

;; Clean up the UI
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Better frame title
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))
        " - Emacs"))

;; Themes
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

;; Modeline
(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-height 25
        doom-modeline-bar-width 3
        doom-modeline-project-detection 'auto
        doom-modeline-buffer-file-name-style 'truncate-except-project
        doom-modeline-icon t
        doom-modeline-major-mode-icon t
        doom-modeline-major-mode-color-icon t
        doom-modeline-buffer-state-icon t
        doom-modeline-buffer-modification-icon t
        doom-modeline-unicode-fallback nil
        doom-modeline-minor-modes nil
        doom-modeline-enable-word-count nil
        doom-modeline-buffer-encoding nil
        doom-modeline-indent-info nil
        doom-modeline-checker-simple-format t
        doom-modeline-number-limit 99
        doom-modeline-vcs-max-length 12
        doom-modeline-workspace-name t
        doom-modeline-persp-name t
        doom-modeline-display-default-persp-name nil
        doom-modeline-persp-icon t
        doom-modeline-lsp t
        doom-modeline-github nil
        doom-modeline-github-interval (* 30 60)
        doom-modeline-env-version t
        doom-modeline-env-enable-python t
        doom-modeline-env-enable-ruby t
        doom-modeline-env-enable-perl t
        doom-modeline-env-enable-go t
        doom-modeline-env-enable-elixir t
        doom-modeline-env-enable-rust t
        doom-modeline-env-python-executable "python3"
        doom-modeline-env-load-string "..."
        doom-modeline-mu4e nil
        doom-modeline-gnus nil
        doom-modeline-irc nil
        doom-modeline-time t
        doom-modeline-display-misc-in-all-mode-lines nil))

;; Icons
(use-package nerd-icons
  :config
  (when (and (display-graphic-p)
             (not (find-font (font-spec :name nerd-icons-font-family))))
    (nerd-icons-install-fonts t)))

;; Better window divider
(use-package frame
  :ensure nil
  :config
  (setq window-divider-default-right-width 1
        window-divider-default-bottom-width 1
        window-divider-default-places t)
  (window-divider-mode 1))

;; Dashboard
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo
        dashboard-center-content t
        dashboard-show-shortcuts nil
        dashboard-items '((recents  . 5)
                         (projects . 5)
                         (bookmarks . 5))
        dashboard-footer-messages '("Happy coding, Nathan! (>_<)")
        dashboard-footer-icon (nerd-icons-octicon "nf-oct-rocket"
                                                  :height 1.1
                                                  :v-adjust -0.05
                                                  :face 'font-lock-keyword-face)))

;; Line numbers
(use-package display-line-numbers
  :ensure nil
  :hook ((prog-mode text-mode) . display-line-numbers-mode)
  :config
  (setq display-line-numbers-type 'relative
        display-line-numbers-width-start t))

;; Highlight current line
(use-package hl-line
  :ensure nil
  :hook (after-init . global-hl-line-mode))

;; Rainbow delimiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Rainbow mode for colors
(use-package rainbow-mode
  :hook ((css-mode html-mode) . rainbow-mode))

;; Whitespace visualization
(use-package whitespace
  :ensure nil
  :hook ((prog-mode text-mode) . whitespace-mode)
  :config
  (setq whitespace-style '(face tabs empty trailing)))

;; Better help windows
(use-package helpful
  :bind
  (("C-h f" . helpful-callable)
   ("C-h v" . helpful-variable)
   ("C-h k" . helpful-key)
   ("C-h C" . helpful-command)
   ("C-c C-d" . helpful-at-point)))

;; Which-key for keybinding hints
(use-package which-key
  :hook (after-init . which-key-mode)
  :config
  (setq which-key-idle-delay 0.3
        which-key-popup-type 'side-window
        which-key-side-window-location 'bottom
        which-key-side-window-max-height 0.25
        which-key-max-description-length 25
        which-key-allow-imprecise-window-fit nil
        which-key-separator " → "))

(provide '02-ui)
;;; 02-ui.el ends here