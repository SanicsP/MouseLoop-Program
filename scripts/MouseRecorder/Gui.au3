#include-once
#include <GuiConstants.au3>
Global $GUI_NonFenetre = "Test"
Global $GUI_TailleFenetre[2] = [400 , 400]
Global $GUI_Fenetre = GUICreate($GUI_NonFenetre , $GUI_TailleFenetre[0] , $GUI_TailleFenetre[1])

;boutons
Global $GUI_Boutons[7]
Global $GUI_TailleBoutons[2] = [50 , 50]

#cs ##################################################################################################################
    fonctions     
#ce ##################################################################################################################

Func GUI_InitialiserBoutons($Aboutons , $AtailleBouton)

        $Aboutons[0] = GUICtrlCreateButton("Init+0" , -1 , -1 , $AtailleBouton[0] , $AtailleBouton[1])
    
    $posi = 50
    For $i = 1 To Ubound($Aboutons) - 1 Step 1
        $Aboutons[$i] = GUICtrlCreateButton("Init+" & $i , -1 , -1 , $AtailleBouton[0] , $AtailleBouton[1])
        GUICtrlSetPos($Aboutons[$i] , $posi)
        $posi = $posi + 50 
    Next
EndFunc


