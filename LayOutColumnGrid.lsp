(defun C:LAYOutColumnGrid( / i j osm Origin Origin_X Origin_Y ColSizeX ColSizeY P_G1 PG2 P_D1 PD2
		     GridRows GridColumns LstRows LstColumns CoordLstRows CoordLstColumns EqInterval offorigin Arrowsize TxtHt Dec Gap Extline1 Extline2 distDim Out_In
		     DmToh DmTih)
		;This autoLisp program is written by Ajay Yadav (AY) and named as L-AY-OutColumnGrid i.e. LAYOutColumnGrid.
		;Download from https://github.com/ajayyadavay/AutocadAutoLisp
		;Choose origin 
		;Enter interval of grid in x and y axis
		
  		;(setq ColSizeX 0.23 ColSizeY 0.23)
  		(setq ColSizeX (getreal "\nEnter Column size in X direction: " )); ColumnsizeX
  		(setq ColSizeY (getreal "\nEnter Column size in Y direction: " )); ColumnsizeY
  
		(setq Origin (getpoint "\nChoose Origin:"))
		(setq Origin_X (car Origin))
	    	(setq Origin_Y (car (cdr Origin)))
 		(setq LstRows (append LstRows (list Origin_Y)))
  		(setq LstColumns (append LstColumns (list Origin_X)))

  		(setq osm (getvar "osmode"))
		(setvar "osmode" 0)

 		;input data of interval between grids
  		(setq GridRows (getint "\nEnter no. of grid in rows (in X Dir):")); X-axis gridlines
 		(setq GridColumns (getint "\nEnter no. of grid in columns (in Y Dir):")); Y-axis gridlines

  		(setq i 0)
  		(repeat (- GridRows 1)
		  (setq i (+ i 1))
		  (setq EqInterval (getreal (strcat "\nEnter interval of GridRows " (itoa i) " : "))); Gridline Row interval
		  (setq LstRows (append LstRows (list EqInterval)))
		)
  		;LstRows contains list in string data type
  		;(princ LstRows)
  
  		(setq j 0)
		(repeat (- GridColumns 1)

		    	(setq j (+ j 1))
		    
		  	(setq EqInterval (getreal (strcat "\nEnter interval of GridColumns " (itoa j) " : "))); Gridline Column interval
		 	(setq LstColumns (append LstColumns (list EqInterval)))
		  
		 )
  		;LstColumns contains list in string data type
  		;(princ LstColumns)
  		;end input data

  		;Create center to center coordinates
		;CoordLstRows contains list in real data type
		(setq CoordLstRows (append CoordLstRows (list (nth 0 LstRows))))
  		(setq i 0)
  		(repeat (- GridRows 1)
		  (setq i (+ i 1))
		  (setq CoordLstRows (append CoordLstRows (list(+ (nth (- i 1) CoordLstRows)  (nth i LstRows)))))
		  )

  		;CoordLstColumns contains list in real data type
		(setq CoordLstColumns (append CoordLstColumns (list (nth 0 LstColumns))))
  		(setq i 0)
  		(repeat (- GridColumns 1)
		  (setq i (+ i 1))
		  (setq CoordLstColumns (append CoordLstColumns (list(+ (nth (- i 1) CoordLstColumns) (nth i LstColumns)))))
		  )
  		;end coordinates

  		;dimension
 
		(setq offorigin (getvar "dimexo"))
  		(setq Arrowsize (getvar "dimasz"))
  		(setq TxtHt (getvar "dimtxt"))
  		(setq Dec (getvar "dimdec"))
  		(setq Gap (getvar "dimgap"))
  		(setq Extline1 (getvar "dimse1"))
  		(setq Extline2 (getvar "dimse2"))
		(setvar "dimexo" 0.15)
  		(setvar "dimasz" 0.4)
  		(setvar "dimtxt" 0.3)
  		(setvar "dimdec" 3)
  		(setvar "dimgap" 0.25)
  		(setvar "dimse1" 1)
  		(setvar "dimse2" 1)
		(setvar "dimtih" 0)
  		(setvar "dimtoh" 0)
  
  
  		;Draw Grid lines along X direction
  		(setq i -1)
  		(repeat (+ GridRows 0)
		  (setq i (+ i 1))
		  (setq j -1)
		  (repeat (- GridColumns 1)

		    	(setq j (+ j 1))
		  
			(setq P_G1 (list (+ (nth j CoordLstColumns) 0) (+ (nth i CoordLstRows) 0)))
		    	(setq P_G2 (list (+ (nth (+ j 1) CoordLstColumns) 0) (+ (nth (+ i 0) CoordLstRows) 0) ))
		    	(command "-layer" "m" "Grindline" "c" "t" "34,247,247" "Grindline" "")
		    	(command "line" P_G1 P_G2 "")
		    	;column
		  	(command "-layer" "m" "Column" "c" "t" "255,0,0" "Column" "")
		  	(setq P_D1 (list (- (car P_G1) (/ ColSizeX 2)) (- (car (cdr P_G1)) (/ ColSizeY 2))))
			(setq P_D2 (list (+ (car P_G1) (/ ColSizeX 2)) (+ (car (cdr P_G1)) (/ ColSizeY 2))))
			(command "rectangle" P_D1 P_D2)
		    	
		  
		    )
			;column
	  		(command "-layer" "m" "Column" "c" "t" "255,0,0" "Column" "")
	  		(setq P_D1 (list (- (car P_G2) (/ ColSizeX 2)) (- (car (cdr P_G2)) (/ ColSizeY 2))))
			(setq P_D2 (list (+ (car P_G2) (/ ColSizeX 2)) (+ (car (cdr P_G2)) (/ ColSizeY 2))))
			(command "rectangle" P_D1 P_D2)
		)
  		
  		;End drawing grid lines along X direction

  		;dimension along X direction bottom
  		(repeat 1
		  (setq i 0)
		  (setq j -1)
		  (repeat (- GridColumns 1)

		    	(setq j (+ j 1))
		    
		    	(setq P_G1 (list (+ (nth j CoordLstColumns) 0) (+ (nth i CoordLstRows) 0)))
		    	(setq P_G2 (list (+ (nth (+ j 1) CoordLstColumns) 0) (+ (nth (+ i 0) CoordLstRows) 0) ))
		    
			(command "-layer" "m" "Dimension" "c" "t" "249,245,6" "Dimension" "")
		  	(setq distDim (+ ColSizeY 0.5) Out_In -1)
			(command "dimaligned" P_G1 P_G2 (list(+(car P_G1) 0) (+ (cadr P_G1) (* Out_In distDim))));center to center distance
  			)
		)
  		;End dimension along X direction bottom


		;dimension along X direction Top
  		(repeat 1
		  (setq i (- GridRows 1))
		  (setq j -1)
		  (repeat (- GridColumns 1)

		    	(setq j (+ j 1))
		    
		    	(setq P_G1 (list (+ (nth j CoordLstColumns) 0) (+ (nth i CoordLstRows) 0)))
		    	(setq P_G2 (list (+ (nth (+ j 1) CoordLstColumns) 0) (+ (nth (+ i 0) CoordLstRows) 0) ))
		    
			(command "-layer" "m" "Dimension" "c" "t" "249,245,6" "Dimension" "")
		  	(setq distDim (+ ColSizeY 0.5) Out_In 1)
			(command "dimaligned" P_G1 P_G2 (list(+(car P_G1) 0) (+ (cadr P_G1) (* Out_In distDim))));center to center distance
  			)
		)
  		;End dimension along X direction Top


  		;Draw Grid lines along Y direction
  		(setq i -1)
  		(repeat (+ GridColumns 0)
		  (setq i (+ i 1))
		  (setq j -1)
		  (repeat (- GridRows 1)

		    	(setq j (+ j 1))
		  
			(setq P_G1 (list (+ (nth i CoordLstColumns) 0) (+ (nth j CoordLstRows) 0)))
		    	(setq P_G2 (list (+ (nth (+ i 0) CoordLstColumns) 0) (+ (nth (+ j 1) CoordLstRows) 0) ))
			(command "-layer" "m" "Grindline" "c" "t" "34,247,247" "Grindline" "")
		    	(command "line" P_G1 P_G2 "")
		  
		    )
		)
  		;End drawing grid lines along Y direction
  

  		;dimension along Y direction Left
		(setq i -1)
  		(repeat 1
		  (setq i (+ i 1))
		  (setq j -1)
		  (repeat (- GridRows 1)

		    	(setq j (+ j 1))
		    
		    	(setq P_G1 (list (+ (nth i CoordLstColumns) 0) (+ (nth j CoordLstRows) 0)))
		    	(setq P_G2 (list (+ (nth (+ i 0) CoordLstColumns) 0) (+ (nth (+ j 1) CoordLstRows) 0) ))
		    
			(command "-layer" "m" "Dimension" "c" "t" "249,245,6" "Dimension" "")
		  	(setq distDim (+ ColSizeX 0.5) Out_In -1)
			(command "dimaligned" P_G1 P_G2 (list(+(car P_G1) (* Out_In distDim)) (+ (cadr P_G1) 0)));center to center distance
  			)
		)
  		;End dimension along Y direction Left


  		;dimension along Y direction Right
		;(setq i -1)
  		(repeat 1
		  (setq i (- GridColumns 1))
		  (setq j -1)
		  (repeat (- GridRows 1)

		    	(setq j (+ j 1))
		    
		    	(setq P_G1 (list (+ (nth i CoordLstColumns) 0) (+ (nth j CoordLstRows) 0)))
		    	(setq P_G2 (list (+ (nth (+ i 0) CoordLstColumns) 0) (+ (nth (+ j 1) CoordLstRows) 0) ))
		    
			(command "-layer" "m" "Dimension" "c" "t" "249,245,6" "Dimension" "")
		  	(setq distDim (+ ColSizeX 0.5) Out_In 1)
			(command "dimaligned" P_G1 P_G2 (list(+(car P_G1) (* Out_In distDim)) (+ (cadr P_G1) 0)));center to center distance
  			)
		)
  		;End dimension along Y direction Right

  		;Reset values
 		(setvar "dimexo" offorigin)
  		(setvar "dimasz" Arrowsize)
  		(setvar "dimtxt" TxtHt)
 		(setvar "dimdec" Dec)
  		(setvar "dimgap" Gap)
		(setvar "dimse1" Extline1)
		(setvar "dimse2" Extline2)
		(setvar "osmode" osm)
		(setvar "dimtoh" DmToh)
  		(setvar "dimtih" DmTih)
		(gc)
		(princ)
	)