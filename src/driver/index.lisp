(in-package #:com.liutos.cl-github-page.driver)

(defvar *has-init-p* nil)

(defun add-post (&rest args)
  (init)
  (apply #'com.liutos.cl-github-page.post:add-post args))

(defun init ()
  "Initialize configuration and connect to database"
  (unless *has-init-p*
    (com.liutos.cl-github-page.config:init)
    (com.liutos.cl-github-page.storage:start)
    (setf *has-init-p* t)))

(defun modify-post (&rest args)
  (init)
  (apply #'com.liutos.cl-github-page.post:modify-post args))

(defun write-post-page (&rest args)
  (init)
  (apply #'com.liutos.cl-github-page.page:write-post-page args))
