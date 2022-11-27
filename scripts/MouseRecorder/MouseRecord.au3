#include "RecordMouse.au3"
#include "FileRecord.au3"
#include "Gui.au3"
#include "ProgManage.au3"
#include <AutoitConstants.au3>


Main()

Func Main()
    
    GUISetState(@SW_SHOW , $GUI_Fenetre)
    GUI_InitialiserBoutons($GUI_Boutons , $GUI_TailleBoutons)
    While True
        If GUIGetMsg() = $GUI_EVENT_CLOSE Then
            MsgBox(0 , "message" , "arrêt du programme")
            Exit(1)
        EndIf
    WEnd

EndFunc