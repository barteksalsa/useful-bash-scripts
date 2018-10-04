;; Convenient package handling in emacs

(require 'package)
;; use packages from marmalade
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;; and the old elpa repo
(add-to-list 'package-archives '("elpa-old" . "http://tromey.com/elpa/"))
;; and automatically parsed versiontracking repositories.
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))

;; Make sure a package is installed
(defun package-require (package)
  "Install a PACKAGE unless it is already installed 
or a feature with the same name is already active.

Usage: (package-require 'package)"
  ; try to activate the package with at least version 0.
  (package-activate package '(0))
  ; try to just require the package. Maybe the user has it in his local config

  (condition-case nil
      (require package)
    ; if we cannot require it, it does not exist, yet. So install it.
    (error (progn
             (package-install package)
             (require package)))))

;; Initialize installed packages
(package-initialize)  
;; package init not needed, since it is done anyway in emacs 24 after reading the init
;; but we have to load the list of available packages, if it is not available, yet.
(when (not package-archive-contents)
  (with-timeout (15 (message "updating package lists failed due to timeout"))
    (package-refresh-contents)))



;; C SETTINGS
;; You can determine which offset to edit by hitting [ctrl-c ctrl-s] on any line. On the first line with a brace after the if it will say substatement-open
(setq-default c-basic-offset 2)
;;(c-set-style bsd)
(defun my-c-mode-hook()
  (c-set-style "bsd")
  (setq c-basic-offset 4))

(add-hook 'c-mode-common-hook 'my-c-mode-hook)

;; CSCOPE
(setq cscope-do-not-update-database t)
;(setq cscope-option-kernel-mode t)
(load-file "/usr/share/emacs/site-lisp/xcscope/xcscope.el")
(require 'xcscope)

;; ===== Set the highlight current line minor mode ===== 
;; In every buffer, the line which contains the cursor will be fully
;; highlighted
(global-hl-line-mode 1)

;;
;; Emacs normally uses both tabs and spaces to indent lines. If you
;; prefer, all indentation can be made from spaces only. To request this,
;; set `indent-tabs-mode' to `nil'. This is a per-buffer variable;
;; altering the variable affects only the current buffer, but it can be
;; disabled for all buffers.
;;
;; Use (setq ...) to set value locally to a buffer
;; Use (setq-default ...) to set value globally 
;;
;;(setq-default indent-tabs-mode nil) 

(define-key global-map [(f12)] 'cscope-find-global-definition)
(define-key global-map [(f11)] 'cscope-find-functions-calling-this-function)
(define-key global-map [(f9)] 'cscope-find-this-symbol)
(define-key global-map [(f8)] 'cscope-find-this-text-string)
(define-key global-map [(f7)] 'cscope-find-called-functions)
(define-key global-map [(f6)] 'cscope-pop-mark)

(define-key global-map [(control f3)] 'cscope-set-initial-directory) 
(define-key global-map [(control f4)] 'cscope-find-this-file)
(define-key global-map [(control f11)] 'cscope-display-buffer) 
(column-number-mode t)
(show-paren-mode t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#e0dfde" :foreground "#141312" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))


;;________________________________________________________________
;;    Font lock
;;________________________________________________________________

;; Use font-lock everywhere.
(global-font-lock-mode t)

;; We have CPU to spare; highlight all syntax categories.
(setq font-lock-maximum-decoration t)

;; It is much more pleasant and less tiring to use a dark background.
(set-foreground-color "black")
(set-background-color "white")

;; Set cursor and mouse colours:
;;(set-cursor-color "yellow")
;;(set-mouse-color "white")

(global-set-key [s-f12] 'goto-line)

;;________________________________________________________________
;;    Don't display initial logo
;;________________________________________________________________

(setq inhibit-startup-message t)


;;________________________________________________________________
;;    scroll-left is disabled by default; enable it.
;;________________________________________________________________
(put 'scroll-left 'disabled nil)

(put 'set-goal-column 'disabled nil)

;;________________________________________________________________
;;    Highlighting - Enable hi lock globally
;;________________________________________________________________


;; hi lock is only available since Emacs 22.
(when (>= emacs-major-version 22)
  (global-hi-lock-mode 1)
  (setq hi-lock-file-patterns-policy t)
)

;; remove tabs
(setq-default indent-tabs-mode nil)
(setq tab-width 4)

;; ========== Line by line scrolling ========== 

;; This makes the buffer scroll by only a single line when the up or
;; down cursor keys push the cursor (tool-bar-mode) outside the
;; buffer. The standard emacs behaviour is to reposition the cursor in
;; the center of the screen, but this can make the scrolling confusing

(setq scroll-step 1)

;show more info in taskbar/icon than just "Emacs"
(setq-default frame-title-format (list "Emacs:%65b %f"))
(setq-default icon-title-format (list "Emacs:%b"))

;make the y or n suffice for a yes or no question
(fset 'yes-or-no-p 'y-or-n-p)

(tool-bar-mode -1)                       ;; turn-off toolbar 

(setq search-highlight t                 ;; highlight when searching... 
  query-replace-highlight t)             ;; ...and replacing


;; hl-line: highlight the current line
(when (fboundp 'global-hl-line-mode)
  (global-hl-line-mode t)) ;; turn it on for all modes by default

;; http://www.emacswiki.org/cgi-bin/wiki/ShowParenMode
(when (fboundp 'show-paren-mode)
  (show-paren-mode t)
  (setq show-paren-style 'parenthesis))


; untabify a file
(defun untabify-buffer ()
  "Untabify the whole buffer."
  (interactive)
  (untabify (point-min) (point-max))
  (princ "Untabified buffer.")
)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


; The titles of windows of GNU Emacs normally look pretty useless (just stating emacs@host), but it’s easy to make them display useful information: 
;; Set the frame title as by http://www.emacswiki.org/emacs/FrameTitle
(setq frame-title-format (list "%b ☺ " (user-login-name) "@" (system-name) "%[ - GNU %F " emacs-version)
      icon-title-format (list "%b ☻ " (user-login-name) "@" (system-name) " - GNU %F " emacs-version))


;; Highlight TODO and FIXME in comments 
(package-require 'fic-ext-mode)
(defun add-something-to-mode-hooks (mode-list something)
  "helper function to add a callback to multiple hooks"
  (dolist (mode mode-list)
    (add-hook (intern (concat (symbol-name mode) "-mode-hook")) something)))

(add-something-to-mode-hooks '(c++ tcl emacs-lisp python text markdown latex) 'fic-ext-mode)




; save the place in files
(require 'saveplace)
(setq-default save-place t)




;; Flycheck: On the fly syntax checking
(package-require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
; stronger error display
(defface flycheck-error
  '((t (:foreground "red" :underline (:color "Red1" :style wave) :weight bold)))
  "Flycheck face for errors"
  :group "flycheck")


; To select a file in a huge directory, just type a few letters from that file in the correct order, leaving out the non-identifying ones. Darn cool! 
; use ido mode for file and buffer Completion when switching buffers
(require 'ido)
(ido-mode t)

; Code folding is pretty cool to get an overview of a complex structure. So why shouldn’t you be able to do that with any kind of structured data? 
; use allout minor mode to have outlining everywhere.
(allout-mode)


; Add proper word wrapping
(global-visual-line-mode t)




;; Org-mode is that kind of simple thing which evolves to a way of life when you realize that most of your needs actually are simple - and that the complex things can be done in simple ways, too.
;; It provides simple todo-lists, inline-code evaluation (as in this file) and a full-blown literate programming, reproducible research publishing platform. All from the same simple basic structure.
;; It might change your life… and it is the only planning solution which ever prevailed against my way of life and organization. 

; Activate org-mode
(require 'org)
; and some more org stuff
; http://orgmode.org/guide/Activation.html#Activation
; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))



;; git message display

(require 'git-messenger) ;; You need not to load if you install with package.el
(global-set-key (kbd "C-x v p") 'git-messenger:popup-message)

(define-key git-messenger-map (kbd "m") 'git-messenger:copy-message)

;; Use magit-show-commit for showing status/diff commands
(custom-set-variables
 '(git-messenger:use-magit-popup t))


;;; Another method for vi emulation of the % command
;;; You could also bind a modified version of the first command to the “%” key:
(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis, otherwise insert %.
vi style of % jumping to matching brace."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

(global-set-key (kbd "%") 'goto-match-paren)

