#include "RecordMouse.au3"
#include "FileRecord.au3"
#include "Gui.au3"
#include "ProgManage.au3"
#include <AutoitConstants.au3>
#include <Debug.au3>
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
   

    GUI_ActiverTouches()

    While True
    ;Actualiser la GUI 

        If GUIGetMsg() = $GUI_EVENT_CLOSE Then
            MsgBox(0 , "message" , "arrêt du programme")
            _DebugArrayDisplay($FR_TableauInsructions)
            Exit(1)
        EndIf
        
        $FocusFenetre = VERIF_verifFenetreActive($NomFenetre)
        
        #cs
            //////////////////////////////////////////////////////////////////////////
            Gestion des évenneements utilisateur  
            ////////////////////////////////////////////////////////////////////////////
        #ce

        Select 

            case $GUI_C_Touch = 1  
                GUI_DesactiverTouches()
                Local $InstructionClic = ENS_EnregistrerPosSouris($NomFenetre)
                
                If $InstructionClic <> 0 Then
                    FR_AjouterInstruction($FR_TableauInsructions , $InstructionClic)
                Else
                    MsgBox(0 , "Debug" , "Le clic n'a pas pu être enregistré")
                EndIf
                GUI_ActiverTouches()
            case $GUI_D_Touch = 1
                GUI_DesactiverTouches()
                
                ENS_ActiverDrag()

                GUI_ActiverTouches()
            case $GUI_F_Touch = 1
                GUI_DesactiverTouches()
                Local $InstructionDragDrop = ENS_ActiverDrop()

                If $InstructionDragDrop <> 0 Then
                    FR_AjouterInstruction($FR_TableauInsructions , $InstructionDragDrop)
                Else
                    MsgBox(0 , "Debug" , "Le DragDrop n'a pas pu être enregistré")
                EndIf
                GUI_ActiverTouches()
                
        EndSelect

        PROG_VerifMsgQuit($VerifQuit)
    WEnd

EndFunc