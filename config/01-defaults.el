;; -*- lexical-binding: t -*-
;;; 01-defaults.el --- Core Emacs defaults

;;; Commentary:
;; Sensible defaults for a modern Emacs experience

;;; Code:

;; General settings
(setq-default
 ;; Performance
 read-process-output-max (* 1024 1024) ; 1MB
 
 ;; Encoding
 buffer-file-coding-system 'utf-8-unix
 default-file-name-coding-system 'utf-8-unix
 default-keyboard-coding-system 'utf-8-unix
 default-process-coding-system '(utf-8-unix . utf-8-unix)
 default-sendmail-coding-system 'utf-8-unix
 default-terminal-coding-system 'utf-8-unix
 
 ;; Files
 backup-directory-alist `((".*" . ,(expand-file-name "backups/" user-emacs-directory)))
 auto-save-file-name-transforms `((".*" ,(expand-file-name "auto-saves/" user-emacs-directory) t))
 backup-by-copying t
 version-control t
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 
 ;; Editing
 tab-width 4
 indent-tabs-mode nil
 require-final-newline t
 truncate-lines nil
 word-wrap t
 
 ;; Interface
 inhibit-startup-screen t
 initial-scratch-message nil
 ring-bell-function 'ignore
 use-dialog-box nil
 use-file-dialog nil
 
 ;; Security
 auth-sources '("~/.authinfo.gpg")
 password-cache-expiry (* 15 60)) ; 15 minutes

;; Enable useful features
(progn
  ;; File/buffer management
  (global-auto-revert-mode 1)
  (save-place-mode 1)
  (savehist-mode 1)
  (recentf-mode 1)
  
  ;; Text editing
  (delete-selection-mode 1)
  (electric-pair-mode 1)
  (electric-indent-mode 1)
  (show-paren-mode 1)
  (column-number-mode 1)
  (size-indication-mode 1)
  
  ;; Better scrolling
  (pixel-scroll-precision-mode 1)
  
  ;; Dired improvements
  (setq dired-listing-switches "-alh"
        dired-kill-when-opening-new-dired-buffer t)
  
  ;; Recent files
  (setq recentf-max-saved-items 100
        recentf-exclude '("/tmp/" "/ssh:" "/sudo:" "COMMIT_EDITMSG"))
  
  ;; History
  (setq history-length 1000
        history-delete-duplicates t
        savehist-additional-variables '(search-ring regexp-search-ring))
  
  ;; Better scrolling behavior
  (setq scroll-margin 0
        scroll-conservatively 100000
        scroll-preserve-screen-position 'always
        auto-window-vscroll nil))

;; macOS specific settings
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'meta
        mac-command-modifier 'super
        mac-right-option-modifier 'none
        delete-by-moving-to-trash t))

;; Create backup and auto-save directories
(let ((backup-dir (expand-file-name "backups/" user-emacs-directory))
      (auto-save-dir (expand-file-name "auto-saves/" user-emacs-directory)))
  (unless (file-directory-p backup-dir)
    (make-directory backup-dir t))
  (unless (file-directory-p auto-save-dir)
    (make-directory auto-save-dir t)))

(provide '01-defaults)
;;; 01-defaults.el ends here