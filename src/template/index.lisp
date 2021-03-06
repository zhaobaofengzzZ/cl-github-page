(in-package #:com.liutos.cl-github-page.template)

(defgeneric fill-template-and-print (destination template values))

(defmethod fill-template-and-print ((destination (eql nil)) template values)
  (with-output-to-string (string)
    (fill-template-and-print string template values)))

(defmethod fill-template-and-print ((destination pathname) template values)
  (with-open-file (file destination
                        :direction :output
                        :if-exists :supersede)
    (fill-template-and-print file template values)))

(defmethod fill-template-and-print ((destination stream) template values)
  (let ((html-template:*default-template-pathname*
         (com.liutos.cl-github-page.config:get-template-root)))
    (html-template:fill-and-print-template template
                                           values
                                           :stream destination)))

;;; EXPORT

(defun fill-category-template (&rest
                                 args
                               &key
                                 destination
                                 &allow-other-keys)
  (let ((html-template:*string-modifier* #'identity)
        (template #p"category.html"))
    (fill-template-and-print destination template args)))

(defun fill-page-template (&rest
                              args
                            &key
                              destination
                              &allow-other-keys)
  (let ((html-template:*string-modifier* #'identity)
        (template #p"page.html"))
    (fill-template-and-print destination template args)))

(defun fill-post-template (&rest
                             args
                           &key
                             destination
                             &allow-other-keys)
  (declare (ignorable args))
  (let ((html-template:*string-modifier* #'identity)
        (template #p"post.html"))
    (fill-template-and-print destination template args)))

(defun fill-rss-template (&rest
                            args
                          &key
                            destination
                            &allow-other-keys)
  (let ((template #p"rss.xml"))
    (fill-template-and-print destination template args)))
