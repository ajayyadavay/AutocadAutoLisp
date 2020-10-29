(defun C:LAYOutColumnY( / osm C2C Origin Origin_X Origin_Y End End_X End_Y ColSizeX ColSizeY P_C0 P_C1 P_C00 P_C11 P_C0_i P_C1_i P_C0_c 
		     ColIntr EqInterval temp_Origin)
		;This autoLisp program is written by Ajay Yadav (AY) and named as L-AY-OutColumn i.e. LAYOutColumn.
		;Download from https://github.com/ajayyadavay/AutocadAutoLisp
		;Choose origin of wall
		;Enter length of wall below and above tie beam.
		
  		(setq ColSizeX 0.23 ColSizeY 0.23)
  
		(setq Origin (getpoint "\nChoose Origin:"))
		(setq Origin_X (car Origin))
	       	(setq Origin_Y (car (cdr Origin)))
  
  		(setq C2C (getreal "\nEnter Center to Center distance m:"))
  		(setq End (list (+ Origin_X 0) (+ Origin_Y C2C)))
  		(setq End_X (car End))
	       	(setq End_Y (car (cdr End)))

  		(setq osm (getvar "osmode"))
		(setvar "osmode" 0)

  		(command "-layer" "m" "Centerline" "c" "t" "207,37,233" "Centerline" "")
		(command "line" Origin End "");Centerline

 		(command "-layer" "m" "Column" "c" "t" "255,0,0" "Column" "")
		(setq P_C0 (list (- Origin_X ColSizeX) (- Origin_Y ColSizeY)))
		(setq P_C1 (list (+ Origin_X ColSizeX) (+ Origin_Y ColSizeY)))
		(command "rectangle" P_C0 P_C1)

  		(setq P_C00 (list (- End_X ColSizeX) (- End_Y ColSizeY)))
		(setq P_C11 (list (+ End_X ColSizeX) (+ End_Y ColSizeY)))
		(command "rectangle" P_C00 P_C11)

  		(setq ColIntr (getint "\nEnter no. of interior columns:")); interior column number
  		(setq EqInterval (/ C2C (+ ColIntr 1)))

  		(setq temp_Origin Origin)
  		(repeat ColIntr
			(setq P_C0_c (list (+ (car temp_Origin) 0) (+ (car (cdr temp_Origin)) EqInterval)))
		  
		  	(setq P_C0_i (list (- (car P_C0_c) ColSizeX) (- (car (cdr P_C0_c)) ColSizeY)))
			(setq P_C1_i (list (+ (car P_C0_c) ColSizeX) (+ (car (cdr P_C0_c)) ColSizeY)))
			(command "rectangle" P_C0_i P_C1_i)

		  	(setq temp_Origin P_C0_c)
		)
  
  		;Reset values
 		(setvar "osmode" osm)
		(gc)
		(princ)
	)