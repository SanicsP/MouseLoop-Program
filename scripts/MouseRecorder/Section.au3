#include-once 
#include "Gui.au3"
#include "RecordMouse.au3"
#include "FileRecord.au3"

#cs 
    @brief Sous Programme dédiée à l'enregistrement des clics de la souris et des actions glisser déposer 
    de l'tilisateur
    @param $NomFenetre Le Nom de la Fenetre où les actions sont enregistrées 
    @param $NomFenetre $TableauInstructions Le tableau où sera stocké l'action de l'utilisateur 
    @return Aucune Valeur 
#ce 
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

#cs 
    @brief Sous Programme dédié à la modification d'un tableau d'instructions 
    @note des actions tel que le suppression de l'instruction précédente , de la rénitialisation du tableau 
    @param $TableauInstructions Le tableau sur lequel les modifications seront efféctuées 
    @param $Boutons Tableau qui contient les contrôles de la fenêtre du script
    @return 1 Si l'utilisateur souhaite enregistre sa suite d'actions , 0 dans les cas contraires
#ce 
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

#cs 
    @brief Sous Programmes dédié las sauvegarde des actions dans un fichir d'extension .ml 
    @param $TableauInstructions Le tableau d'instruction qui sera enregistré dans le fichier .ml
    @param $NomProg Le nom du programme choissi par l'utilisateur au lancement du script 
    @return 1 si L'utilisateur veut continuer à utiliser le script , 0 si il veut y mettre fin
#ce 
Func SEC_EnregistrementDansFichier(Byref $TableauInstructions , $NomProg)
    $NbIteration = GUI_DemanderNbIterations("Sauvegarde")
    If $NbIteration = 0 Then 
        MsgBox(48 , "Erreur" , "Le fichier n'a pas pu être sauvegardé")
        Return 1 
    EndIf

    $Fichier = GUI_DemanderNomFichier("Sauvegarde")
    If $Fichier = 0 Then 
        MsgBox(48 , "Erreur" , "Le fichier n'a pas pu être sauvegardé")
        Return 1
    EndIf

    FileWriteLine($Fichier , $NomProg)
    FileWriteLine($Fichier , $NbIteration)
    
    $Taille = UBound($TableauInstructions) 
    
    For $i = 0 To $Taille - 1 Step 1 
        FileWriteLine($Fichier , $TableauInstructions[$i])
    Next 

    FileClose($Fichier) 
    
    Local $retourMsg = MsgBox(4 , "Sauvegarde" , "Votre fichier a été sauvegardé avec succès. Voulez vous continuer ?")

    Switch $retourMsg 
        case $IDYES
            Return 1
        case $IDNO
            Return 0
    EndSwitch 

EndFunc