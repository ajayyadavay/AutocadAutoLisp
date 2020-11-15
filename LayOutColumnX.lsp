(defun C:LAYOutColumnX( / osm C2C Origin Origin_X Origin_Y End End_X End_Y ColSizeX ColSizeY P_C0 P_C1 P_C00 P_C11 P_C0_i P_C1_i P_C0_c 
		     ColIntr EqInterval temp_Origin offorigin Arrowsize TxtHt Dec Gap Extline1 Extline2 distDim P_Txt1 Txt1 Out_In
		     DmToh DmTih)
		;This autoLisp program is written by Ajay Yadav (AY) and named as L-AY-OutColumn i.e. LAYOutColumn.
		;Download from https://github.com/ajayyadavay/AutocadAutoLisp
		;Choose origin of wall
		;Enter length of wall below and above tie beam.
		
  		(setq ColSizeX 0.23 ColSizeY 0.23)
  
		(setq Origin (getpoint "\nChoose Origin:"))
		(setq Origin_X (car Origin))
	    	(setq Origin_Y (car (cdr Origin)))
  
  		(setq C2C (getreal "\nEnter Center to Center distance m:"))
  		(setq End (list (+ Origin_X C2C) (+ Origin_Y 0)))
  		(setq End_X (car End))
	   	(setq End_Y (car (cdr End)))

		(setq osm (getvar "osmode"))
		(setvar "osmode" 0)
  
  		(command "-layer" "m" "Centerline" "c" "t" "207,37,233" "Centerline" "")
		(command "line" Origin End "");Centerline

 		(command "-layer" "m" "Column" "c" "t" "255,0,0" "Column" "")
		(setq P_C0 (list (- Origin_X (/ ColSizeX 2)) (- Origin_Y (/ ColSizeY 2))))
		(setq P_C1 (list (+ Origin_X (/ ColSizeX 2)) (+ Origin_Y (/ ColSizeY 2))))
		(command "rectangle" P_C0 P_C1)

  		(setq P_C00 (list (- End_X (/ ColSizeX 2)) (- End_Y (/ ColSizeY 2))))
		(setq P_C11 (list (+ End_X (/ ColSizeX 2)) (+ End_Y (/ ColSizeY 2))))
		(command "rectangle" P_C00 P_C11)

  		(setq ColIntr (getint "\nEnter no. of interior columns:")); interior column number
  		(setq EqInterval (/ C2C (+ ColIntr 1)))

  		(setq temp_Origin Origin)
  		(repeat ColIntr
			(setq P_C0_c (list (+ (car temp_Origin) EqInterval) (+ (car (cdr temp_Origin)) 0)))
		  
		  	(setq P_C0_i (list (- (car P_C0_c) (/ ColSizeX 2)) (- (car (cdr P_C0_c)) (/ ColSizeY 2))))
			(setq P_C1_i (list (+ (car P_C0_c) (/ ColSizeX 2)) (+ (car (cdr P_C0_c)) (/ ColSizeY 2))))
			(command "rectangle" P_C0_i P_C1_i)

		  	(setq temp_Origin P_C0_c)
		)

 		;dimension
 
		(setq offorigin (getvar "dimexo"))
  		(setq Arrowsize (getvar "dimasz"))
  		(setq TxtHt (getvar "dimtxt"))
  		(setq Dec (getvar "dimdec"))
  		(setq Gap (getvar "dimgap"))
  		(setq Extline1 (getvar "dimse1"))
  		(setq Extline2 (getvar "dimse2"))
		(setvar "dimexo" 0.15)
  		(setvar "dimasz" 0.8)
  		(setvar "dimtxt" 0.6)
  		(setvar "dimdec" 3)
  		(setvar "dimgap" 0.5)
  		(setvar "dimse1" 1)
  		(setvar "dimse2" 1)
		(setvar "dimtih" 0)
  		(setvar "dimtoh" 0)

		(command "-layer" "m" "Dimension" "c" "t" "249,245,6" "Dimension" "")
  		(setq distDim (+ ColSizeY 0.5))
  		(setq Out_In (getint "\nEnter 1 for above and -1 for below text:")); Above = 1 and Below = -1
		(command "dimaligned" Origin End (list(+(car Origin) 0) (+ (cadr Origin) (* Out_In distDim))));center to center distance

  		;text
  		(command "-layer" "m" "Text" "c" "t" "237,102,18" "Text" "")

 		(setq P_Txt1 (list(/ (+(car Origin) (car End)) 2) (+ (cadr Origin) (* Out_In (+ distDim 1)))))
  		(setq Txt1 (strcat (itoa ColIntr) " nos. of interior column @ " (rtos EqInterval 2 3) " m c/c"))
  		(command "_.Text" "_Style" "standard" "_Justify" "MC" P_Txt1 0.6 0 Txt1)
  
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
		(princ osm)
	)