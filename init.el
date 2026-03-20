;; -*- lexical-binding: t -*-
;;; init.el --- Nathan's Emacs Configuration

;;; Commentary:
;; Modern Emacs configuration supporting C/C++, Python, Common Lisp, and Clojure
;; Built for fast startup, clean interface, and productive development workflow

;;; Code:

;; Performance optimizations for startup
(defvar file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil
      gc-cons-threshold 402653184
      gc-cons-percentage 0.6)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq file-name-handler-alist file-name-handler-alist-original
                  gc-cons-threshold 16777216
                  gc-cons-percentage 0.1)))

;; Core configuration directory
(defvar config-dir (expand-file-name "config/" user-emacs-directory)
  "Directory for modular configuration files.")

;; Ensure config directory exists
(unless (file-directory-p config-dir)
  (make-directory config-dir t))

;; Package management setup
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(package-initialize)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t
      use-package-verbose t)

;; Load configuration modules
(defun load-config (filename)
  "Load configuration file from config directory."
  (let ((file (expand-file-name filename config-dir)))
    (when (file-exists-p file)
      (load file))))

;; Load core modules in order
(load-config "01-defaults.el")
(load-config "02-ui.el")
(load-config "03-editing.el")
(load-config "04-completion.el")
(load-config "05-navigation.el")
(load-config "06-version-control.el")
(load-config "07-programming.el")
(load-config "08-languages.el")
(load-config "09-keybindings.el")

;; Custom file setup
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Local configuration (not tracked in git)
(let ((local-config (expand-file-name "local.el" user-emacs-directory)))
  (when (file-exists-p local-config)
    (load local-config)))

(provide 'init)
;;; init.el ends here