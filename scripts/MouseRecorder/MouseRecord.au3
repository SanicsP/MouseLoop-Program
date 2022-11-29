#include "RecordMouse.au3"
#include "FileRecord.au3"
#include "Gui.au3"
#include "ProgManage.au3"
#include <AutoitConstants.au3>

AutoItSetOption("MouseCoordMode" , 2)

Main()

Func Main()
    
    $FocusFenetre = 0
    Local $VerifQuit
    Local $NomProg = GUI_DemanderNomAp("Debug")
    PROG_VerifMsgQuit($NomProg)
    Local $NomFenetre = GUI_DemanderNomFenetre("Debug")
    PROG_VerifMsgQuit($NomProg)
    GUI_IsolerFenetre()
    #cs
    $VerifQuit = PROG_LancerProgramme($NomProg , $NomFenetre , "Dbug")
    PROG_VerifMsgQuit($VerifQuit)
    #ce
    GUI_PlacerBoutons($GUI_TailleFenetre , $GUI_Boutons)
    GUI_ColorerBoutons($GUI_Boutons , $GUI_Fenetre)

    GUISetState(@SW_SHOW , $GUI_Fenetre)
    While True
    ;Actualiser la GUI 

        If GUIGetMsg() = $GUI_EVENT_CLOSE Then
            MsgBox(0 , "message" , "arrêt du programme")
            Exit(1)
        EndIf
        
        $FocusFenetre = VERIF_verifFenetreActive($NomFenetre)
        $VerifQuit = ENS_EnregistrerPosSouris($NomFenetre)
        PROG_VerifMsgQuit($VerifQuit)
    WEnd

EndFunc