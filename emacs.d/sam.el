;; clojure + slime
(add-to-list 'load-path "~/.emacs.d/vendor/swank-clojure")
(require 'swank-clojure-autoload)
(swank-clojure-config
 (setq swank-clojure-extra-vm-args '("-Xmx1g"))
 (setq swank-clojure-jar-path "~/clojure/clojure.jar")
 (setq swank-clojure-extra-classpaths '("~/clojure-contrib/clojure-contrib.jar" "~/euler/lib")))

(add-to-list 'load-path "~/.emacs.d/vendor/slime")
(set-language-environment "UTF-8")
(setq slime-net-coding-system 'utf-8-unix)

(require 'slime)
(slime-setup)

(defun sliem (&rest args)
  (interactive)
  (apply 'slime args))

(color-theme-twilight)
