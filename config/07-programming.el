;; -*- lexical-binding: t -*-
;;; 07-programming.el --- General programming support

;;; Commentary:
;; Language-agnostic programming features: LSP, debugging, formatting, etc.

;;; Code:

;; Language Server Protocol
(use-package lsp-mode
  :hook ((c-mode c++-mode python-mode) . lsp-deferred)
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (setq lsp-auto-guess-root t
        lsp-prefer-flymake nil
        lsp-file-watch-threshold 2000
        lsp-eldoc-render-all nil
        lsp-idle-delay 0.5
        lsp-enable-symbol-highlighting t
        lsp-enable-on-type-formatting nil
        lsp-signature-auto-activate nil
        lsp-signature-render-documentation t
        lsp-completion-provider :capf
        lsp-completion-show-detail t
        lsp-completion-show-kind t
        lsp-headerline-breadcrumb-enable t
        lsp-semantic-tokens-enable t
        lsp-enable-folding nil
        lsp-enable-imenu t
        lsp-enable-snippet nil
        lsp-restart 'auto-restart
        lsp-keep-workspace-alive nil)
  
  ;; Performance optimizations
  (setq read-process-output-max (* 1024 1024) ;; 1MB
        lsp-log-io nil
        lsp-print-performance nil))

;; LSP UI enhancements
(use-package lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :bind
  (:map lsp-ui-mode-map
   ("C-c l ." . lsp-ui-peek-find-definitions)
   ("C-c l ?" . lsp-ui-peek-find-references)
   ("C-c l i" . lsp-ui-imenu)
   ("C-c l s" . lsp-ui-sideline-mode)
   ("C-c l d" . lsp-ui-doc-mode))
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-use-childframe t
        lsp-ui-doc-position 'top
        lsp-ui-doc-include-signature t
        lsp-ui-doc-delay 0.5
        lsp-ui-sideline-enable t
        lsp-ui-sideline-ignore-duplicate t
        lsp-ui-sideline-show-hover t
        lsp-ui-sideline-show-code-actions t
        lsp-ui-sideline-update-mode 'point
        lsp-ui-sideline-delay 0.5
        lsp-ui-peek-always-show t
        lsp-ui-flycheck-enable t))

;; LSP Ivy integration
(use-package lsp-ivy
  :after (lsp-mode ivy)
  :commands lsp-ivy-workspace-symbol)

;; LSP Treemacs integration
(use-package lsp-treemacs
  :after (lsp-mode treemacs)
  :commands lsp-treemacs-errors-list)

;; Debugging with DAP
(use-package dap-mode
  :after lsp-mode
  :hook ((c-mode c++-mode python-mode) . dap-mode)
  :config
  (dap-auto-configure-mode)
  (setq dap-auto-configure-features '(sessions locals tooltip)))

;; Syntax checking with Flycheck
(use-package flycheck
  :hook (after-init . global-flycheck-mode)
  :config
  (setq flycheck-check-syntax-automatically '(save idle-change mode-enabled)
        flycheck-idle-change-delay 0.8
        flycheck-display-errors-delay 0.9
        flycheck-highlighting-mode 'symbols
        flycheck-indication-mode 'left-fringe
        flycheck-standard-error-navigation t
        flycheck-deferred-syntax-check nil))

;; Flycheck popup
(use-package flycheck-popup-tip
  :after flycheck
  :hook (flycheck-mode . flycheck-popup-tip-mode)
  :config
  (setq flycheck-popup-tip-delete-timeout 5))

;; Code formatting
(use-package format-all
  :hook (prog-mode . format-all-mode)
  :config
  (setq format-all-show-errors 'warnings))

;; Compilation
(use-package compile
  :ensure nil
  :bind
  (("C-c C-c" . compile)
   ("C-c C-k" . kill-compilation))
  :config
  (setq compilation-scroll-output 'first-error
        compilation-window-height 12
        compilation-auto-jump-to-first-error t))

;; Eldoc for documentation
(use-package eldoc
  :ensure nil
  :hook (prog-mode . eldoc-mode)
  :config
  (setq eldoc-idle-delay 0.4))

;; Highlight TODO/FIXME/etc
(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        '(("TODO"   . "#FF0000")
          ("FIXME"  . "#FF0000")
          ("DEBUG"  . "#A020F0")
          ("GOTCHA" . "#FF4500")
          ("STUB"   . "#1E90FF"))))

;; Code folding
(use-package origami
  :hook (prog-mode . origami-mode)
  :bind
  (:map origami-mode-map
   ("C-c f" . origami-recursively-toggle-node)
   ("C-c F" . origami-toggle-all-nodes)))

;; Indentation guides
(use-package highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character
        highlight-indent-guides-character ?\┊
        highlight-indent-guides-responsive 'top
        highlight-indent-guides-delay 0))

;; Rainbow delimiters for nested parens
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Better comments
(use-package comment-dwim-2
  :bind ("M-;" . comment-dwim-2))

;; Quickrun for executing code snippets
(use-package quickrun
  :bind
  (("C-c q q" . quickrun)
   ("C-c q l" . quickrun-with-arg)
   ("C-c q r" . quickrun-region)
   ("C-c q s" . quickrun-shell)))

;; Project-local variables
(use-package project-local-variables
  :hook (hack-local-variables . project-local-variables-apply))

;; EditorConfig support
(use-package editorconfig
  :hook (after-init . editorconfig-mode))

;; Makefile mode
(use-package make-mode
  :ensure nil
  :mode (("Makefile\\'" . makefile-mode)
         ("\\.mk\\'" . makefile-mode)))

;; Dockerfile mode
(use-package dockerfile-mode
  :mode "Dockerfile\\'")

;; YAML mode
(use-package yaml-mode
  :mode "\\.ya?ml\\'")

;; JSON mode
(use-package json-mode
  :mode "\\.json\\'")

;; Markdown mode
(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :config
  (setq markdown-command "multimarkdown"))

(provide '07-programming)
;;; 07-programming.el ends here