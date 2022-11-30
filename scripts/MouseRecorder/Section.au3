#include-once 
#include "Gui.au3"
#include "RecordMouse.au3"
#include "FileRecord.au3"

Func SEC_EnregistreMentClics($NomFenetre , ByRef $TableauInstructions)
    Select 

            case $GUI_C_Touch = 1  
                GUI_DesactiverTouches()
                Local $InstructionClic = ENS_EnregistrerPosSouris($NomFenetre)
                
                If $InstructionClic <> 0 Then
                    FR_AjouterInstruction($TableauInstructions , $InstructionClic)
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
                    FR_AjouterInstruction($TableauInstructions , $InstructionDragDrop)
                Else
                    MsgBox(0 , "Debug" , "Le DragDrop n'a pas pu être enregistré")
                EndIf
                GUI_ActiverTouches()

        EndSelect
Endfunc 

Func SEC_ModficationTableauInstructions(Byref $TableauInstructions , Const ByRef $Boutons) 
    Local $CtrlEvent = GUIGetMsg(1)
        Select 

            Case $CtrlEvent[0] = $Boutons[3] ; l'utilisateur fait un clic sur annuller 
                MsgBox(0 , "DEBUG" , "Annuler")
                FR_SupprimerInstruction($TableauInstructions)
            Case $CtrlEvent[0] = $Boutons[4] ; l'utilisateur fait un clic sur recommencer
                MsgBox(0 , "DEBUG" , "recommencer")
                FR_RenitialiserTabInstrc($TableauInstructions)
            Case $CtrlEvent[0] = $Boutons[6] ; l'utilisateur fait un clic sur enregistrer la séquence
                MsgBox(0 , "DEBUG" , "Enregistre la séquence")
                Return 1
        EndSelect
    Return 0
EndFunc

Func SEC_EnregistrementDansFichier()
    
EndFunc