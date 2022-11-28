#include "RecordMouse.au3"
#include "FileRecord.au3"
#include "Gui.au3"
#include "ProgManage.au3"
#include <AutoitConstants.au3>


Main()

Func Main()
    
    GUI_InitialiserBoutons($GUI_Boutons , $GUI_TailleBoutons)
    Local $NomProg = GUI_DemanderNomAp("Debug")
    PROG_VerifMsgQuit($NomProg)
    Local $NomFenetre = GUI_DemanderNomFenetre("Debgu")
    PROG_VerifMsgQuit($NomProg)
    
    Exit(1)
    GUISetState(@SW_SHOW , $GUI_Fenetre)
    While True
        If GUIGetMsg() = $GUI_EVENT_CLOSE Then
            MsgBox(0 , "message" , "arrêt du programme")
            Exit(1)
        EndIf
    WEnd

EndFunc