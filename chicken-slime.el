(defvar slime-csi-path "csi"
  "Path to csi executable for with Chicken SLIME.")

(setq slime-lisp-implementations
      (cons `(chicken (,slime-csi-path)
                      :init chicken-slime-init)
            slime-lisp-implementations))

(defvar swank-chicken-path nil
  "Path to swank-chicken.scm. Set to nil to use installed extension.")

(defvar swank-chicken-port 4005
  "Port to use for communicating to the swank server.")

(defun chicken-slime-init (file _)
  (setq slime-protocol-version 'ignore)
  (setq slime-complete-symbol-function 'slime-simple-complete-symbol)
  
  (format "%S\n"
          `(begin ,(if swank-chicken-path
                       `(load ,swank-chicken-path)   ; Interpet code for testing
                     '(require-extension slime))     ; Normal use
                  (swank-server-start ,swank-chicken-port ,file))))

(defun chicken-slime ()
  (interactive)
  (slime 'chicken))

(provide 'chicken-slime)
