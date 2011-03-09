(defun eopen-launch ()
  "If EOPEN_DIR is defined in the environment, then change to that directory.
If EOPEN_FILE is defined in the environment, then open that file."
  (let ((dir (getenv "EOPEN_DIR"))
        (file (getenv "EOPEN_FILE")))
    (if dir
        (cd dir))
    (if file
        (find-file file))))

(provide 'eopen)
