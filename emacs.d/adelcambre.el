(color-theme-twilight)
(defun textmate-project-root ()
  (spiffy-tm-project-root-for (buffer-file-name)))
(define-key minibuffer-local-map [(escape)] 'minibuffer-keyboard-quit)
(add-to-list 'load-path "~/.emacs.d/vendor/")
(require 'peepopen)
(setq ns-pop-up-frames nil)
(define-key *spiffy-tm-keymap* [(meta ?t)] 'peepopen-goto-file-gui)

(defun open (project) (interactive (list (read-directory-name "Peepopen for project (default awsm): " "~/p/" "~/p/awsm")))
  (flet ((textmate-project-root () (file-truename project)))
    (peepopen-goto-file-gui)))

(global-set-key [(meta ?o)] 'open)
;; (require 'ack-in-project)

