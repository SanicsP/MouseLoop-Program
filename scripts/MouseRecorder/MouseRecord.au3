#include "RecordMouse.au3"
#include "FileRecord.au3"
#include "Gui.au3"
#include "ProgManage.au3"
#include <AutoitConstants.au3>


Main()

Func Main()
    Local $VerifQuit
    GUI_InitialiserBoutons($GUI_Boutons , $GUI_TailleBoutons)
    Local $NomProg = GUI_DemanderNomAp("Debug")
    PROG_VerifMsgQuit($NomProg)
    Local $NomFenetre = GUI_DemanderNomFenetre("Debug")
    PROG_VerifMsgQuit($NomProg)
    GUI_IsolerFenetre()
    $VerifQuit = PROG_LancerProgramme($NomProg , $NomFenetre , "Dbug")
    PROG_VerifMsgQuit($VerifQuit)

    GUISetState(@SW_SHOW , $GUI_Fenetre)
    While True
        If GUIGetMsg() = $GUI_EVENT_CLOSE Then
            MsgBox(0 , "message" , "arrêt du programme")
            Exit(1)
        EndIf
    WEnd

EndFunc