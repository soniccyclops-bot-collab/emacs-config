;; -*- lexical-binding: t -*-
;;; 03-editing.el --- Text editing enhancements

;;; Commentary:
;; Better text editing, movement, and manipulation tools

;;; Code:

;; Multiple cursors
(use-package multiple-cursors
  :bind
  (("C-S-c C-S-c" . mc/edit-lines)
   ("C->" . mc/mark-next-like-this)
   ("C-<" . mc/mark-previous-like-this)
   ("C-c C-<" . mc/mark-all-like-this)
   ("C-S-<mouse-1>" . mc/add-cursor-on-click)))

;; Expand region
(use-package expand-region
  :bind ("C-=" . er/expand-region))

;; Move text
(use-package move-text
  :bind
  (("M-p" . move-text-up)
   ("M-n" . move-text-down)))

;; Better undo with undo-tree
(use-package undo-tree
  :hook (after-init . global-undo-tree-mode)
  :bind ("C-x u" . undo-tree-visualize)
  :config
  (setq undo-tree-visualizer-timestamps t
        undo-tree-visualizer-diff t
        undo-tree-auto-save-history t
        undo-tree-history-directory-alist
        `((".*" . ,(expand-file-name "undo-tree/" user-emacs-directory)))))

;; Smart parentheses
(use-package smartparens
  :hook (after-init . smartparens-global-mode)
  :config
  (require 'smartparens-config)
  (setq sp-highlight-pair-overlay nil
        sp-highlight-wrap-overlay nil
        sp-highlight-wrap-tag-overlay nil))

;; Auto-completion
(use-package company
  :hook (after-init . global-company-mode)
  :bind
  (:map company-active-map
   ("C-n" . company-select-next)
   ("C-p" . company-select-previous)
   ("C-d" . company-show-doc-buffer)
   ("<tab>" . company-complete-selection))
  :config
  (setq company-minimum-prefix-length 2
        company-idle-delay 0.2
        company-tooltip-limit 20
        company-show-numbers t
        company-tooltip-align-annotations t
        company-require-match 'never
        company-global-modes '(not eshell-mode comint-mode erc-mode message-mode help-mode gud-mode)))

;; Company box for better popup
(use-package company-box
  :if (display-graphic-p)
  :hook (company-mode . company-box-mode)
  :config
  (setq company-box-icons-alist 'company-box-icons-nerd-icons
        company-box-show-single-candidate t
        company-box-max-candidates 50
        company-box-doc-delay 0.3))

;; Yasnippet
(use-package yasnippet
  :hook ((prog-mode text-mode) . yas-minor-mode)
  :config
  (setq yas-snippet-dirs `(,(expand-file-name "snippets/" user-emacs-directory)))
  (yas-reload-all))

(use-package yasnippet-snippets
  :after yasnippet)

;; Auto-insert templates
(use-package autoinsert
  :ensure nil
  :hook (after-init . auto-insert-mode)
  :config
  (setq auto-insert-directory (expand-file-name "templates/" user-emacs-directory)
        auto-insert-query nil)
  (auto-insert-mode 1))

;; Aggressive indent for some modes
(use-package aggressive-indent
  :hook ((emacs-lisp-mode lisp-mode clojure-mode scheme-mode) . aggressive-indent-mode))

;; Hungry delete
(use-package hungry-delete
  :hook (after-init . global-hungry-delete-mode)
  :config
  (setq hungry-delete-chars-to-skip " \t\f\v"))

;; Better search with swiper
(use-package swiper
  :bind
  (("C-s" . swiper)
   ("C-r" . swiper-backward)))

;; Avy for quick navigation
(use-package avy
  :bind
  (("C-:" . avy-goto-char)
   ("C-'" . avy-goto-char-2)
   ("M-g f" . avy-goto-line)
   ("M-g w" . avy-goto-word-1)))

;; String manipulation
(use-package s)

;; Better search/replace
(use-package anzu
  :hook (after-init . global-anzu-mode)
  :bind
  (("M-%" . anzu-query-replace)
   ("C-M-%" . anzu-query-replace-regexp))
  :config
  (setq anzu-mode-lighter ""
        anzu-search-threshold 1000
        anzu-replace-threshold 50
        anzu-replace-to-string-separator " => "))

;; Goto last change
(use-package goto-chg
  :bind
  (("C-." . goto-last-change)
   ("C-," . goto-last-change-reverse)))

;; Visual regex builder
(use-package visual-regexp
  :bind
  (("C-c r" . vr/replace)
   ("C-c q" . vr/query-replace)))

(provide '03-editing)
;;; 03-editing.el ends here