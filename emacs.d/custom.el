;; Extra packages that the starter kit doesn't give us
(setq starter-kit-packages
      (append starter-kit-packages (list 'yasnippet-bundle
                                         'clojure-mode
                                         'nav
                                         'nxml-mode
                                         'paredit
                                         'haml-mode
                                         'sass-mode)))
(starter-kit-elpa-install)


;; for those of us lacking superhuman eyeballs
(set-cursor-color "black")

;; seriously
(setq kill-whole-line t)
(setq confirm-kill-emacs 'yes-or-no-p)
(random t)                              ; reseed
(server-start)
(global-auto-revert-mode 1)

;; bar cursor
(add-to-list 'load-path "~/.emacs.d/vendor/bar-cursor")
(require 'bar-cursor)
(bar-cursor-mode 1)

;; Mac-specific stuff
(defun make-option-super ()
  (interactive)
  (setq mac-option-modifier 'super))

(defun make-option-meta ()
  (interactive)
  (setq mac-option-modifier 'meta))

(when (eq window-system 'ns)
  (setq mac-command-modifier 'meta)
  (make-option-meta))

;; while I <square box> Unicode as much as the next guy,
;; I want my lambdas left alone.
(remove-hook 'coding-hook 'pretty-lambdas)

;; don't iconify on C-z when running in X
;; or exit emacs (!) when running in Emacs.app
(when window-system (global-unset-key "\C-z"))

;; don't use ESC as a prefix, but rather do the same thing C-g does.
(global-set-key (kbd "<escape>") 'keyboard-quit)

;;;;;; haml
(require 'haml-mode nil t)
;; add-to-list doesn't add it if it's already present.
;; haml-mode is in auto-mode-alist, but before nxhtml-mode, which is
;; associated with basically *.html*, which matches foo.html.haml.
;; nxhtml-mode is no damn good at dealing with haml.
(setq auto-mode-alist
      (cons '("\\.haml$" . haml-mode)
            auto-mode-alist))

(add-hook 'haml-mode-hook
          (lambda ()
            (run-hooks 'coding-hook)))

;; just nice to have everywhere
(add-hook 'coding-hook (lambda () (setq tab-width 2)))

;; hooray hippie-expand
;; and then press control-tab.
(setq hippie-expand-try-functions-list (cons 'yas/hippie-try-expand hippie-expand-try-functions-list))
(global-set-key [(shift tab)] 'hippie-expand)
(global-set-key [(control tab)] 'hippie-expand)

;; Other Random Keybindings
(global-set-key [(kp-delete)] 'delete-char)
(global-set-key [(f6)] 'next-error)
(global-set-key [(shift f6)] 'previous-error)
(global-set-key [(control backspace)] 'backward-kill-word)
(global-set-key [(control kp-delete)] 'kill-word)

;;;;;;;;;; stuff that's not on ELPA. too lazy to upload it.

;;;;;;;; line numbers on the left in a gui
(when window-system
  (add-to-list 'load-path "~/.emacs.d/vendor/linum")
  (require 'linum)
  (global-linum-mode 1))

;;;;;;;; spiffy mode
(add-to-list 'load-path "~/.emacs.d/vendor/spiffy")
(setq spiffy-enable-minor-mode t)
(require 'spiffy)

;;;;;;;; spiffy textmate mode
(require 'spiffy-textmate-mode)
(add-hook 'coding-hook 'spiffy-textmate-mode)
(add-hook 'css-mode-hook 'spiffy-textmate-mode)

;;;;;;;; spiffy macos mode
(autoload 'spiffy-macos-mode "spiffy-macos-mode" nil t)

;; get the tabstops right for spiffy-textmate-mode's indentations
(setq tab-stop-list
      (mapcar (lambda (x) (* 2 x))
              (reverse (spiffy-downfrom 100))))

;;;;;;;; Ruby
(require 'spiffy-ruby-mode)
(add-hook 'ruby-mode-hook 'spiffy-ruby-mode)

(setq ruby-deep-arglist nil)
(setq ruby-deep-indent-paren nil)

(yas/load-directory "~/.emacs.d/snippets")

(defun d-and-autoindent-end (times)
  (interactive "p")
  (insert "d")
  (if (and
       (>= (point)
           (+ 4 (point-min)))
       (looking-back "[[:space:]]end" 4))
      (indent-according-to-mode))
  (if (> times 1)
      (d-and-autoindent-end (1- times))))

(add-hook 'ruby-mode-hook (lambda ()
                            (local-set-key [(?d)] 'd-and-autoindent-end)))

;;;;;;;; color is good - let's actually see ansi-color stuff in color.
(require 'ansi-color)
(require 'comint)
(require 'compile)
(setq ansi-color-for-comint-mode t)
(add-hook 'comint-output-filter-functions 'ansi-color-process-output)

;;;;;;;; keep the path of executed programs synced up with what it is
;;;;;;;; in the shell
(add-hook 'compilation-mode-hook
          (lambda nil
            (setenv "PATH"
                    (shell-command-to-string "$SHELL -l -c 'echo -n $PATH'"))))


;;;;;;;; emacs-lisp development
(add-to-list 'load-path "~/.emacs.d/vendor/el-expectations")
(defun eval-and-execute-expectations-buffer ()
  (interactive)
  (eval-buffer)
  (expectations-execute))

;;;;;;;; color spec output
(defadvice compilation-filter (before ansify-compilation-output activate)
  (with-current-buffer (process-buffer (ad-get-arg 0))
    (let ((colorstr (ansi-color-apply (ad-get-arg 1))))
      (ad-set-arg 1 (font-lock-proof colorstr 0)))))

(defun font-lock-proof (string start)
  (cond
   ((>= start (length string)) "")
   (t
    (let* ((end (next-property-change start string (length string)))
           (s (substring string start end)))
      (set-text-properties 0
                           (length s)
                           (substitute 'font-lock-face 'face (text-properties-at 0 s))
                           s)
      (concat s (font-lock-proof string end))))))

;;;;;;;; feature (cucumber) mode
(add-to-list 'load-path "~/.emacs.d/vendor/cucumber")
(require 'feature-mode)
(add-hook 'feature-mode-hook 'spiffy-textmate-mode)

;; elisp tests
(add-hook
 'emacs-lisp-mode-hook
 (lambda ()
   (local-set-key [(control ?\;) ?r ?t] 'eval-and-execute-expectations-buffer)
   (local-set-key [(return)] 'newline-and-indent)))

;;;;;;;; To launch nav on left side: M-x nav RET
;;;;;;;; To launch nav on right side: C-u M-x nav RET
(defadvice other-window (around other-window-nop))
(defadvice nav (around prefix-nav)
  (if current-prefix-arg
      (ad-activate-regexp "other-window-nop"))
  (unwind-protect
      ad-do-it
    (ad-deactivate-regexp "other-window-nop")))
(ad-activate-regexp "prefix-nav")

;;;;;;;; eopen support
(require 'eopen)
(eopen-launch)

;;;;;;;; TRAMP configuration
;; ssh is faster than scp for the small files we usually edit
;; remotely.
(setq tramp-default-method "ssh")

(require 'windmove)
(windmove-default-keybindings 'super)

;; NB: grep-find-ignored-directories is not limited to just directories.

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(grep-find-ignored-directories (quote ("SCCS" "RCS" "CVS" "MCVS" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "gems" "coverage" "log" "*.dump" "portage.txt" "TAGS"))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))

;; yaml-mode is broken in starter kit
(require 'yaml-mode)
