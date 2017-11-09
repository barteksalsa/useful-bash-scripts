;; Change the indentation amount to 4 spaces instead of 2.
;; You have to do it in this complicated way because of the
;; strange way the cc-mode initializes the value of `c-basic-offset'.
(add-hook 'c-mode-hook (lambda () (setq c-basic-offset 4)))


(setq cscope-do-not-update-database t)
(setq cscope-option-kernel-mode t)
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
;;(set-foreground-color "white")
;;(set-background-color "black")

;; Set cursor and mouse colours:
;;(set-cursor-color "yellow")
;;(set-mouse-color "white")

(global-set-key [s-f1] 'goto-line)

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
