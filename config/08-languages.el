;; -*- lexical-binding: t -*-
;;; 08-languages.el --- Language-specific configurations

;;; Commentary:
;; Configuration for C/C++, Python, Common Lisp, and Clojure

;;; Code:

;;; C/C++ Configuration
(use-package cc-mode
  :ensure nil
  :hook ((c-mode c++-mode) . (lambda ()
                              (setq c-basic-offset 4
                                    tab-width 4
                                    indent-tabs-mode nil)))
  :config
  (setq c-default-style "linux"
        c-basic-offset 4))

;; Modern C++ support
(use-package modern-cpp-font-lock
  :hook (c++-mode . modern-c++-font-lock-mode))

;; C/C++ LSP server (clangd)
(use-package lsp-mode
  :hook ((c-mode c++-mode) . lsp-deferred)
  :config
  (setq lsp-clients-clangd-args '("--header-insertion=never"
                                  "--cross-file-rename"
                                  "--clang-tidy"
                                  "--completion-style=detailed")))

;; CMake support
(use-package cmake-mode
  :mode (("CMakeLists\\.txt\\'" . cmake-mode)
         ("\\.cmake\\'" . cmake-mode)))

(use-package cmake-font-lock
  :after cmake-mode
  :hook (cmake-mode . cmake-font-lock-activate))

;; Company backend for CMake
(use-package company-cmake
  :after (cmake-mode company)
  :config
  (add-to-list 'company-backends 'company-cmake))

;;; Python Configuration
(use-package python
  :ensure nil
  :hook (python-mode . (lambda ()
                        (setq python-indent-offset 4
                              python-indent-guess-indent-offset-verbose nil
                              python-shell-interpreter "python3")))
  :config
  (setq python-shell-completion-native-enable nil
        python-shell-completion-native-disabled-interpreters '("python3")))

;; Enhanced Python IDE features
(use-package elpy
  :hook (python-mode . elpy-enable)
  :config
  (setq elpy-rpc-python-command "python3"
        elpy-rpc-virtualenv-path 'current
        elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Python virtual environments
(use-package pyvenv
  :after python
  :config
  (pyvenv-mode 1))

;; Python formatting with black
(use-package python-black
  :after python
  :hook (python-mode . python-black-on-save-mode-enable-dwim))

;; Python imports
(use-package py-isort
  :after python
  :hook (python-mode . (lambda ()
                        (add-hook 'before-save-hook 'py-isort-before-save))))

;; Poetry support
(use-package poetry
  :hook (python-mode . poetry-tracking-mode))

;;; Common Lisp Configuration
(use-package slime
  :config
  (setq inferior-lisp-program "sbcl"
        slime-contribs '(slime-fancy)
        slime-default-lisp 'sbcl
        slime-lisp-implementations
        '((sbcl ("sbcl" "--dynamic-space-size" "2048"))
          (ccl ("ccl"))
          (ecl ("ecl"))))
  :hook (lisp-mode . (lambda ()
                      (slime-mode 1)
                      (eldoc-mode 1))))

;; Enhanced SLIME
(use-package slime-company
  :after (slime company)
  :config
  (setq slime-company-completion 'fuzzy))

;; Common Lisp HyperSpec lookup
(use-package hyperspec
  :bind (:map lisp-mode-map
         ("C-c h" . hyperspec-lookup)))

;; Lisp editing enhancements
(use-package paredit
  :hook ((lisp-mode slime-repl-mode) . paredit-mode))

;;; Clojure Configuration
(use-package clojure-mode
  :mode (("\\.clj\\'" . clojure-mode)
         ("\\.cljs\\'" . clojurescript-mode)
         ("\\.cljc\\'" . clojurec-mode)
         ("\\.edn\\'" . clojure-mode))
  :config
  (define-clojure-indent
    (defroutes 'defun)
    (GET 2)
    (POST 2)
    (PUT 2)
    (DELETE 2)
    (HEAD 2)
    (ANY 2)
    (OPTIONS 2)
    (PATCH 2)
    (rfn 2)
    (let-routes 1)
    (context 2)))

;; CIDER for Clojure REPL
(use-package cider
  :hook ((clojure-mode clojurescript-mode clojurec-mode) . cider-mode)
  :bind (:map clojure-mode-map
         ("C-c C-j" . cider-jack-in)
         ("C-c C-k" . cider-load-buffer)
         ("C-c C-d" . cider-doc)
         ("C-c M-." . cider-find-var)
         ("C-c M-," . cider-pop-back))
  :config
  (setq cider-repl-display-help-banner nil
        cider-repl-pop-to-buffer-on-connect 'display-only
        cider-show-error-buffer t
        cider-auto-select-error-buffer t
        cider-repl-history-file "~/.emacs.d/cider-history"
        cider-repl-wrap-history t
        cider-repl-history-size 3000
        cider-repl-use-clojure-font-lock t
        cider-prompt-for-symbol nil
        cider-font-lock-dynamically '(macro core function var)
        cider-overlays-use-font-lock t
        cider-eval-result-prefix ";; => "
        cider-preferred-build-tool 'lein
        cider-save-file-on-load 'always-save
        nrepl-buffer-name-separator "-"
        nrepl-buffer-name-show-port t
        cider-use-overlays t))

;; Clojure refactoring
(use-package clj-refactor
  :after clojure-mode
  :hook (clojure-mode . (lambda ()
                         (clj-refactor-mode 1)
                         (yas-minor-mode 1)
                         (cljr-add-keybindings-with-prefix "C-c C-m")))
  :config
  (setq cljr-suppress-middleware-warnings t
        cljr-assume-language-context t))

;; Better Clojure indentation
(use-package aggressive-indent
  :hook (clojure-mode . aggressive-indent-mode))

;; Clojure syntax checking
(use-package flycheck-clj-kondo
  :after clojure-mode)

;; Clojure paredit
(use-package paredit
  :hook ((clojure-mode clojurescript-mode clojurec-mode cider-repl-mode) . paredit-mode))

;; Rainbow parens for Lisps
(use-package rainbow-delimiters
  :hook ((lisp-mode clojure-mode clojurescript-mode clojurec-mode slime-repl-mode cider-repl-mode) . rainbow-delimiters-mode))

;; ClojureScript specific
(use-package clojurescript-mode
  :ensure clojure-mode
  :mode "\\.cljs\\'"
  :config
  (setq cljr-clojure-test-declaration "[cljs.test :as t :include-macros true]"))

;; Kibit for Clojure suggestions
(use-package kibit-helper
  :bind (:map clojure-mode-map
         ("C-x C-`" . kibit-accept-proposed-change)))

;; Leiningen support
(use-package lein
  :bind (:map clojure-mode-map
         ("C-c l r" . lein-run)
         ("C-c l t" . lein-test)
         ("C-c l c" . lein-clean)
         ("C-c l u" . lein-uberjar)))

(provide '08-languages)
;;; 08-languages.el ends here