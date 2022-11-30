#include "RecordMouse.au3"
#include "FileRecord.au3"
#include "Gui.au3"
#include "ProgManage.au3"
#include "Section.au3"
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
        
        ;Partie dediée à l'enregistrement des clics et des glisser déposer de la souris
        SEC_EnregistreMentClics($NomFenetre , $FR_TableauInsructions)

        ;Partie dediée à la modification du tableau d'instrcutions : effacer le tableau , enlever un clic
        Local $RetourSecModif = SEC_ModficationTableauInstructions($FR_TableauInsructions , $GUI_Boutons)        
        Local $RetourSecENS = 0
        If $RetourSecModif = 1 Then 
            MsgBox(0 , "DEBUG" , "Enregistrement")
            $RetourSecENS = SEC_EnregistrementDansFichier($FR_TableauInsructions , $NomProg)
            If $RetourSecENS = 0 Then 
                
            EndIf
            $RetourSecModif = 0
        EndIf

        PROG_VerifMsgQuit($VerifQuit)
    WEnd

EndFunc