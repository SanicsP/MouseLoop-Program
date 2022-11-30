#include-once
#include <Array.au3>
#include "Gui.au3"

Global $ENS_PosDrag
Global $ENS_PosDrop
Global $ENS_Drag = 0

#cs 
    @brief
    @param 
    @return 
#ce 
Func ENS_AnnulerDerniereAction(ByRef $Tab)
    _ArrayPop($Tab)
    If @error = 3 Then
        MsgBox(0 , "retour" , "le tableau est vide") 
        Return 1
    EndIf
EndFunc

#cs 
    @brief
    @param 
    @return 
#ce 
Func ENS_EnregistrerPosSouris($NomFenetre) ; en cours de modifications 
    Local $pos = MouseGetPos()
        
    Local $delais = GUI_DemanderDelais("Souris")
    
    If $delais = 0 Then 
        GUI_C_presse()
      
        Return 0
    EndIf
    
    Local $instruction = 1 & " " & $pos[0] & " " & $pos[1] & " " & $delais
    
    MsgBox(0 , "Instruction" , "voici l'instruction : " & $instruction)
    
    WinActivate($NomFenetre)
    GUI_C_presse()
  
    Return $instruction

EndFunc

#cs 
    @brief
    @param 
    @return 
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
    @brief
    @param 
    @return 
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

