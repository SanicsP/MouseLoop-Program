#include-once
#include <Array.au3>
#include "Gui.au3"

Global $ENS_PosDrag
Global $ENS_PosDrop
Global $ENS_Drag = 0


#cs 
    @brief Enregistre la position de la souris relative à la zone cliente de la fenêtre 
    @param $NomFenetre Nom de la fenêtre donné par l'utilisateur afin de vérifier le focus 
    @return Retourne L'instruction du clic , 0 si l'utilisateur souhaite annuler l'action 
#ce 
Func ENS_EnregistrerPosSouris($NomFenetre) 
    Local $pos = MouseGetPos()
        
    Local $delais = GUI_DemanderDelais("Souris")
    
    If $delais = 0 Then 
        GUI_C_presse()
      
        Return 0
    EndIf
    
    Local $instruction = 1 & " " & $pos[0] & " " & $pos[1] & " " & $delais
    
    ;MsgBox(0 , "Instruction" , "voici l'instruction : " & $instruction)
    
    WinActivate($NomFenetre)
    GUI_C_presse()
  
    Return $instruction

EndFunc

#cs 
    @brief Enregistre le point de départ du l'action glisser déposer à enregistrer 
    @param Aucun argument 
    @return Aucune valeur 
#ce 
Func ENS_ActiverDrag() ; S'enclenche lorsque l'utilisateur appui sur D

    If $ENS_Drag = 0 Then
        $ENS_Drag = 1
        $ENS_PosDrag = MouseGetPos()
        MsgBox(0 , "DEBUG" , "DRAG")
    Else 
        MsgBox(0 , "DEBUG" , "Vous avez déjà drag")
        
    EndIf
    GUI_D_presse()
EndFunc

#cs 
    @brief Anregistre la position finale du glisser déposer 
    @param aucun argument 
    @return une cahîne d'instruction 
#ce 
Func ENS_ActiverDrop() ;; S'enclenche lorsque l'utilisateur appui sur F
    If $ENS_Drag = 1 Then
        $ENS_Drag = 0
        $ENS_PosDrop = MouseGetPos()
        MsgBox(0 , "DEBUG" , "DROP")

        $delais = GUI_DemanderDelais("Delais")
        
        $Instruction =  2 & " " & $ENS_PosDrag[0] & " " & $ENS_PosDrag[1] & " " & $ENS_PosDrop[0] & " " & $ENS_PosDrop[1] & " " & $delais
        
        MsgBox(0 , "DEBUG" , "Votre DragDrop : " & $Instruction)
        GUI_F_presse()
        Return $Instruction
    Else
        MsgBox(0 , "DEBUG" , "Vous n'avez pas Drag Avant ! ")
        GUI_F_presse()
        Return 0
    EndIf
EndFunc

