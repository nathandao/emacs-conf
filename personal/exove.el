;;; exove.el --- Custom Exove tasks
;;; Commentary:
;;; License:
;;; Code:

(require 'request)
;;(require 'notify)

;; Load confidential exove info
(add-to-list 'load-path "~/exoveconf")
(load "exoveconf")

;; Insert a task
(defun exove-task (task start end desc log-inside)
  "Log a new hour item"
  (interactive
   (list (completing-read "Task name: " exove-task-list nil t "")
         (read-string "Start: " (format-time-string "%Y-%m-%d %H:%M"))
         (read-string "End: " (format-time-string "%H:%M"))
         (read-string "Description: " "")
         (read-string "Insert entry to inside? [y/n] [default n]: " "")))
  (let ((task-entry (concat (format "%s;" task)
                      (format "%s;" start)
                      (format "%s;" end)
                      (format "%s" desc))))
    (insert (concat (format "| %s |" start)
                    (format " %s |" end)
                    (format " %s |" task)
                    (format " %s |" desc)
                    (format " %s |" task-entry) "\n"))
    (cond ((equal log-inside "y")
           (exove-curl task-entry))
          (t
           (notify "Exove Inside" "Entry only added to text file")))))

;; Open the hour file
(defun exove-view ()
  "Load up Exove log file"
  (interactive)
  (find-file "~/Documents/hours.org"))

;; Custom curl call
(defun exove-curl (task-entry)
  "Exove curl"
  (interactive)
  (let* ((exove-buffer (get-buffer-create "*exove*"))
         (exove-curl-cmd (concat curl-cmd " -F 'data=" task-entry "'"))
         (result (call-process-shell-command exove-curl-cmd nil exove-buffer t))
         (output (with-current-buffer exove-buffer (buffer-string))))
    (cond ((zerop result)
           (notify "EXOVE INSIDE" "Entry logged to inside."))
          (t
           (message nil)
           (split-window-vertically)
           (set-window-buffer (next-window) exove-buffer)))))

;; Collect fortune cookies
(defun exove-fortune ()
  "Collecd random fortunes for the fortune"
  (interactive)
  (url-retrieve
   "http://fortunecookieapi.com/v1/fortunes?limit=3"
   (lambda (events)
     (goto-char url-http-end-of-headers)
     (let ((json-object-type 'plist)
           (json-key-type 'symbol)
           (json-array-type 'vector))
       (let ((result (json-read)))
         (notify "Fortune babay" result)
         (let ((array-of-times (json-read-from-string result)))
           (let ((c (length array-of-times)))
             (dotimes (n c)
               (insert (format "user_id %s\n" (cdr (assoc 'message (elt array-of-times n)))))))))))))

;; Insert current date timestamp
(defun exove-today ()
  (interactive)
  (insert (format-time-string "%a %d-%m-%Y")))

;; Insert table header
(defun exove-hour-header ()
  (interactive)
  (insert "| Start | End | Task | Description | Log |"))

;;(provide 'exove)
;;; exove.el ends here
