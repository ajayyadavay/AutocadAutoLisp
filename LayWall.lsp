(defun C:LAYWall( / Sol_th PCC_th footX Origin Origin_X Origin_Y S_P1 P_P0 P_P1 slpX P_f1 TBeamY Col_Below Col_Above P_C2 P_C3 P_C4 P_TB1 P_TB2
		    WallBelowTH WallAboveTH Sol_Hatch PCC_Hatch WA_Hatch WB_Hatch  P_TxtPCC P_TxtSol P_Title P_TBm Extline1 Extline2 GL_Lvl P_GL1 P_GL2 P_TxtGL distDim osm offorigin Arrowsize TxtHt Dec Gap TxtVerPos)
		;This autoLisp program is written by Ajay Yadav (AY) and named as L-AY-Wall i.e. LAYWall.
		;Choose origin of wall
		;Enter length of wall below and above tie beam.
		(setq osm (getvar "osmode"))
		(setvar "osmode" 0)
		(setq Sol_th 125 PCC_th 75)
		(setq footX (getint "Enter width of wall footing mm:"))
  		(setq WallBelowTH 230 WallAboveTH 230)
  		(setq slpX (/ (- footX WallBelowTH) 2))
  		
		(setq Origin (getpoint "Choose Origin:"))
		(setq Origin_X (car Origin))
	       	(setq Origin_Y (car (cdr Origin)))
		(setq S_P1 (list (+ Origin_X footX) (+ Origin_Y Sol_th)))
  		(command "-layer" "m" "Soling" "c" "t" "207,37,233" "Soling" "")
		(command "rectangle" Origin S_P1);soling
		(setq P_P0 (list Origin_X (+ Origin_Y Sol_th)))
		(setq P_P1 (list (+ Origin_X footX) (+ Origin_Y PCC_th Sol_th)))
 		(command "-layer" "m" "PCC" "c" "t" "34,247,247" "PCC" "")
		(command "rectangle" P_P0 P_P1);pcc
  		(setq P_f1 (list (+ (car P_P0) slpX) (car (cdr P_P1))))
		(setq TBeamY 230)

 		(setq Col_Below (getint "Enter height of wall below tie beam mm:"))
  		(command "-layer" "m" "TBeam" "c" "t" "66,241,50" "TBeam" "")
		(setq P_TB1 (list (+ (car P_f1) 0) (+ (car (cdr P_f1)) Col_Below)))
		(setq P_TB2 (list (+ (car P_TB1) WallBelowTH) (+ (car (cdr P_TB1)) TBeamY)))
		(command "rectangle" P_TB1 P_TB2)

  		(setq Col_Above (getint "Enter height of wall above tie beam mm:"))
  
 		(command "-layer" "m" "Wall" "c" "t" "255,0,0" "Wall" "")
		(setq P_C2 (list (+ (car P_TB2) 0) (+ (car (cdr P_TB1)) 0)))
		(command "rectangle" P_f1 P_C2);wall below tie beam
  
  		(setq P_C3 (list (- (car P_TB2) WallAboveTH) (+ (car (cdr P_TB2)) 0)))
  		(setq P_C4 (list (+ (car P_TB2) 0) (+ (car (cdr P_TB2)) Col_Above)))
 		(command "rectangle" P_C3 P_C4);wall above tie beam
  
		;dimension
		(setq offorigin (getvar "dimexo"))
  		(setq Arrowsize (getvar "dimasz"))
  		(setq TxtHt (getvar "dimtxt"))
  		(setq Dec (getvar "dimdec"))
  		(setq Gap (getvar "dimgap"))
  		;(setq TxtVerPos (getvar "dimtad"))
  		(setq Extline1 (getvar "dimse1"))
  		(setq Extline2 (getvar "dimse2"))
		(setvar "dimexo" 150)
  		(setvar "dimasz" 80)
  		(setvar "dimtxt" 80)
  		(setvar "dimdec" 0)
  		(setvar "dimgap" 50)
 		;(setvar "dimtad" 2)
  		(setvar "dimse1" 1)
  		(setvar "dimse2" 1)

		(command "-layer" "m" "Dimension" "c" "t" "249,245,6" "Dimension" "")
  		(setq distDim (+ slpX 200))
		(command "dimaligned" P_C3 (list (- (car P_C4) WallAboveTH) (car (cdr P_C4))) (list(-(car P_C3) distDim) (+(cadr P_C3) 0)));column above tie beam
  		(command "dimaligned" P_TB1 P_f1 (list(-(car P_TB1) distDim) (+(cadr P_TB1) 0)));column below tie beam
  		(command "dimaligned" P_C4 (list (- (car P_C4) WallAboveTH) (car (cdr P_C4))) (list(+(car P_C4) 0) (+(cadr P_C4) 200)));col
  		(command "dimaligned" Origin (list (car S_P1) (car (cdr Origin))) (list(+(car Origin) 0) (-(cadr Origin) 200)));footing

  		;Text
  		(command "-layer" "m" "Text" "c" "t" "237,102,18" "Text" "")
 		(setq P_TBm (list (+ (car P_TB2) 150) (- (car (cdr P_TB2)) (/ TBeamY 2))))
  		(command "_.Text" "_Style" "standard" "_Justify" "Left" P_TBm 60 0 "Tie Beam")
		(setq P_TxtPCC (list (+ (car S_P1) 220) (+ (car (cdr S_P1)) (/ 0 2))))
  		(command "_.Text" "_Style" "standard" "_Justify" "Left" P_TxtPCC 60 0 "PCC 75 mm")
 		(setq P_TxtSol (list (+ (car S_P1) 220) (- (car (cdr S_P1)) (/ Sol_th 1))))
  		(command "_.Text" "_Style" "standard" "_Justify" "Left" P_TxtSol 60 0 "Soling 125 mm")
 		(setq P_Title (list (+ (car Origin) (/ footX 2)) (- (car (cdr Origin)) 350)))
  		(command "_.Text" "_Style" "standard" "_Justify" "MC" P_Title 150 0 "Section of Wall")

  		;GL
  		(command "-layer" "m" "GL" "c" "t" "39,149,252" "GL" "")
  		(setq GL_Lvl (getint "Enter Depth of Excavation mm:"))
 		(setq P_GL1 (list (+ (car P_TB2) 0) (+ (car (cdr Origin)) GL_Lvl)))
  		(setq P_GL2 (list (+ (car P_TB2) distDim) (+ (car (cdr Origin)) GL_Lvl)))
  		(command "line" P_GL1 P_GL2 "")

  		;Dimension
  		(command "-layer" "m" "Dimension" "c" "t" "249,245,6" "Dimension" "")
  		(command "dimaligned" P_GL2 (list (car P_GL2) (car (cdr Origin))) (list(+(car P_GL2) 0) (+(cadr P_GL2) 0)));GL
  
 		(command "-layer" "m" "Text" "c" "t" "237,102,18" "Text" "")
  		(setq P_TxtGL (list (+ (car P_GL2) (/ 0 2)) (+ (car (cdr P_GL2)) 50)))
  		(command "_.Text" "_Style" "standard" "_Justify" "MC" P_TxtGL 60 0 "GL")

  		;Hatch
  		(command "-layer" "m" "Soling" "c" "t" "207,37,233" "Soling" "")
  		(setq Sol_Hatch (list (+ (car Origin) (/ footX 2)) (+ (car (cdr Origin)) (/ Sol_th 2))))
  		(command "-Hatch" "Properties" "GRAVEL" "100" "0" Sol_Hatch "")

  		(command "-layer" "m" "PCC" "c" "t" "34,247,247" "PCC" "")
  		(setq PCC_Hatch (list (+ (car P_P0) (/ footX 2)) (+ (car (cdr P_P0)) (/ PCC_th 2))))
  		(command "-Hatch" "Properties" "AR-CONC" "10" "0" PCC_Hatch "")

  		(command "-layer" "m" "Wall" "c" "t" "255,0,0" "Wall" "")
  		(setq WA_Hatch (list (+ (car P_C3) (/ WallAboveTH 2)) (+ (car (cdr P_C3)) (/ Col_Above 2))))
  		(command "-Hatch" "Properties" "ANSI32" "200" "0" WA_Hatch "")

  		(setq WB_Hatch (list (+ (car P_f1) (/ WallBelowTH 2)) (+ (car (cdr P_f1)) (/ Col_Below 2))))
  		(command "-Hatch" "Properties" "ANSI32" "200" "0" WB_Hatch "")

  		;Reset values
		(setvar "dimexo" offorigin)
  		(setvar "dimasz" Arrowsize)
  		(setvar "dimtxt" TxtHt)
 		(setvar "dimdec" Dec)
  		(setvar "dimgap" Gap)
  		;(setvar "dimtad" TxtVerPos)
		(setvar "dimse1" Extline1)
		(setvar "dimse2" Extline2)
 		(setvar "osmode" osm)
		(gc)
		(princ)
	)