;; -*- lexical-binding: t -*-
;;; 09-keybindings.el --- Global keybindings and shortcuts

;;; Commentary:
;; Global keybindings, hydras, and custom shortcuts

;;; Code:

;; Global keybindings
(bind-keys
 ;; File operations
 ("C-x C-r" . counsel-recentf)
 ("C-c f" . counsel-git)
 ("C-c F" . counsel-file-jump)
 
 ;; Buffer operations
 ("C-x b" . ivy-switch-buffer)
 ("C-x k" . kill-current-buffer)
 ("C-x K" . kill-buffer-and-window)
 
 ;; Window operations
 ("C-x +" . balance-windows)
 ("C-x -" . fit-window-to-buffer)
 ("C-x |" . split-window-horizontally-and-switch)
 ("C-x _" . split-window-vertically-and-switch)
 
 ;; Search and navigation
 ("C-s" . swiper)
 ("C-r" . swiper-backward)
 ("C-c s" . counsel-grep-or-swiper)
 ("C-c S" . swiper-all)
 
 ;; Project management
 ("C-c p" . projectile-command-map)
 ("C-c P" . counsel-projectile)
 
 ;; Text manipulation
 ("M-%" . anzu-query-replace)
 ("C-M-%" . anzu-query-replace-regexp)
 ("C-=" . er/expand-region)
 ("M-z" . zap-up-to-char)
 
 ;; Editing helpers
 ("C-c d" . duplicate-line)
 ("C-c D" . duplicate-region)
 ("C-c w" . whitespace-cleanup)
 ("C-c W" . delete-trailing-whitespace)
 
 ;; Navigation
 ("M-g g" . goto-line)
 ("M-g i" . imenu)
 ("M-g I" . counsel-imenu)
 
 ;; Help and documentation
 ("C-h a" . counsel-apropos)
 ("C-h b" . counsel-descbinds)
 ("C-h f" . counsel-describe-function)
 ("C-h v" . counsel-describe-variable)
 
 ;; Version control
 ("C-x g" . magit-status)
 ("C-x M-g" . magit-file-dispatch)
 ("C-c g l" . magit-log-current)
 ("C-c g b" . magit-blame)
 
 ;; Org mode
 ("C-c a" . org-agenda)
 ("C-c c" . org-capture)
 ("C-c l" . org-store-link)
 
 ;; Quick access
 ("C-c e" . eshell)
 ("C-c t" . ansi-term)
 ("C-c T" . treemacs)
 
 ;; Misc
 ("C-c r" . ivy-resume)
 ("C-c R" . restart-emacs))

;; Custom functions for keybindings
(defun split-window-horizontally-and-switch ()
  "Split window horizontally and switch to the new window."
  (interactive)
  (split-window-horizontally)
  (other-window 1))

(defun split-window-vertically-and-switch ()
  "Split window vertically and switch to the new window."
  (interactive)
  (split-window-vertically)
  (other-window 1))

(defun duplicate-line ()
  "Duplicate the current line."
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (forward-line 1)
  (yank))

(defun duplicate-region ()
  "Duplicate the current region."
  (interactive)
  (when (use-region-p)
    (let ((content (buffer-substring-no-properties (region-beginning) (region-end))))
      (goto-char (region-end))
      (insert content))))

(defun kill-current-buffer ()
  "Kill the current buffer without prompting."
  (interactive)
  (kill-buffer (current-buffer)))

(defun kill-buffer-and-window ()
  "Kill the current buffer and close its window."
  (interactive)
  (kill-buffer (current-buffer))
  (when (> (length (window-list)) 1)
    (delete-window)))

;; Hydra for window management
(use-package hydra
  :bind ("C-c w" . hydra-window/body)
  :config
  (defhydra hydra-window (:color red :hint nil)
    "
^Split^         ^Switch^        ^Resize^        ^Other^
^─────^─────────^──────^────────^──────^────────^─────^────
_v_ertical      _h_   ←         _<_ shrink-h    _q_uit
_x_ horizontal  _j_   ↓         _>_ enlarge-h   _d_elete
_z_ undo        _k_   ↑         _-_ shrink-v    _D_elete-others
_Z_ reset       _l_   →         _+_ enlarge-v   _o_nly this
^^^^            _a_ce winodw    _=_ balance     _s_wap
^^^^            _s_wap buffer   ^^^^            _SPC_ next layout
"
    ("h" windmove-left)
    ("j" windmove-down)
    ("k" windmove-up)
    ("l" windmove-right)
    ("v" split-window-right)
    ("x" split-window-below)
    ("<" shrink-window-horizontally)
    (">" enlarge-window-horizontally)
    ("-" shrink-window)
    ("+" enlarge-window)
    ("=" balance-windows)
    ("a" ace-window)
    ("s" ace-swap-window)
    ("d" delete-window)
    ("D" delete-other-windows)
    ("o" delete-other-windows)
    ("z" winner-undo)
    ("Z" winner-redo)
    ("SPC" other-window)
    ("q" nil)))

;; Hydra for text scaling
(use-package hydra
  :bind ("C-c z" . hydra-zoom/body)
  :config
  (defhydra hydra-zoom (:color red :hint nil)
    "
^Zoom^           ^Other^
^────^───────────^─────^─────
_+_ zoom in      _q_ quit
_-_ zoom out     _0_ reset
"
    ("+" text-scale-increase "in")
    ("-" text-scale-decrease "out")
    ("0" (text-scale-increase 0) "reset")
    ("q" nil "quit")))

;; Hydra for navigation
(use-package hydra
  :bind ("C-c n" . hydra-navigate/body)
  :config
  (defhydra hydra-navigate (:color blue :hint nil)
    "
^Navigate^           ^Search^           ^Mark^
^────────^───────────^──────^───────────^────^─────
_f_ find file        _s_ swiper         _m_ mark
_r_ recent files     _g_ git grep       _i_ imenu
_p_ project files    _a_ ag/rg          _b_ bookmark
_b_ buffers          _j_ git-jump       _o_ occur
_d_ dired            _l_ lines          _q_ quit
"
    ("f" counsel-find-file)
    ("r" counsel-recentf)
    ("p" counsel-projectile-find-file)
    ("b" ivy-switch-buffer)
    ("d" dired-jump)
    ("s" swiper)
    ("g" counsel-git-grep)
    ("a" counsel-ag)
    ("j" dumb-jump-go)
    ("l" counsel-goto-line)
    ("m" counsel-mark-ring)
    ("i" counsel-imenu)
    ("b" counsel-bookmark)
    ("o" counsel-outline)
    ("q" nil)))

;; Mode-specific keybindings

;; C/C++ mode keybindings
(add-hook 'c-mode-common-hook
          (lambda ()
            (local-set-key (kbd "C-c C-c") 'compile)
            (local-set-key (kbd "C-c C-r") 'gdb)
            (local-set-key (kbd "C-c h") 'man)))

;; Python mode keybindings
(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-c") 'python-shell-send-buffer)
            (local-set-key (kbd "C-c C-r") 'python-shell-send-region)
            (local-set-key (kbd "C-c C-z") 'python-shell-switch-to-shell)
            (local-set-key (kbd "C-c C-d") 'python-describe-at-point)))

;; Lisp mode keybindings
(add-hook 'lisp-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-z") 'slime)
            (local-set-key (kbd "C-c C-c") 'slime-compile-defun)
            (local-set-key (kbd "C-c C-k") 'slime-compile-and-load-file)
            (local-set-key (kbd "C-c h") 'hyperspec-lookup)))

;; Clojure mode keybindings
(add-hook 'clojure-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-j") 'cider-jack-in)
            (local-set-key (kbd "C-c C-z") 'cider-switch-to-repl-buffer)
            (local-set-key (kbd "C-c C-c") 'cider-eval-defun-at-point)
            (local-set-key (kbd "C-c C-k") 'cider-load-buffer)
            (local-set-key (kbd "C-c C-d") 'cider-doc)))

;; Unset problematic default keybindings
(global-unset-key (kbd "C-z"))        ; Suspend frame (annoying)
(global-unset-key (kbd "C-x C-z"))    ; Same
(global-unset-key (kbd "M-ESC ESC"))  ; keyboard-escape-quit (too easy to hit)

(provide '09-keybindings)
;;; 09-keybindings.el ends here