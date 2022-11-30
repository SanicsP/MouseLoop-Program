#include "Interpret.au3"


Main()


func Main()
Local $NomProgramme = "Mouse Loop"
	
	AutoItSetOption("MouseCoordMode" , 2)

	$NomFichier = SaisirNomFichier($NomProgramme) 
	$Tableau_Instruction = ChargerFichier($NomFichier)

	;Analyse la structure du fichier pour d'éventuelles erreurs de saisie 
	
	If $Tableau_Instruction = 0 or AnalyserTab($Tableau_Instruction) = 0 then 
		MsgBox(48 , "Erreur" , "Il semblerait qu'il y ait une erreur")
		Exit(1)
	EndIf
	
	;saisie de la fenêtre où les actions vont se dérouler
	Local $NomFenetre = SaisirNomFenetre($NomProgramme)

	Local $initPos[2] = [0 , 0] 
	
	;Lncement de l'application
	IsolerAp()
	OuvrirAp($Tableau_Instruction[0] , $NomFenetre , $initPos , 4e3)

	;éxecution de la boucle d'actions 
	BoucleInstruction($Tableau_Instruction , $Tableau_Instruction[1] ,  10 )
	
	;fermeture de l'application 
	FermerAp($NomProgramme)

	
	Return 0
EndFunc