(defun c:TotalLengthOnLayer ()
  (setq total-length 0)
  (setq selset (ssget '((0 . "LINE"))))
  (setq layer (cdr (assoc 8 (entget (car (entsel "\nSelect a line to get layer: "))))))
  (if selset
    (progn
      (setq cnt 0)
      (repeat (sslength selset)
        (setq ent (ssname selset cnt))
        (setq obj (vlax-ename->vla-object ent))
        (if (equal layer (vla-get-Layer obj))
          (setq total-length (+ total-length (vla-get-Length obj))))
        (setq cnt (1+ cnt))
      )
      (prompt (strcat "\nTotal length of lines on layer " layer " is: " (rtos total-length 2 2)))
    )
    (prompt "\nNo lines found.")
  )
  (princ)
)
