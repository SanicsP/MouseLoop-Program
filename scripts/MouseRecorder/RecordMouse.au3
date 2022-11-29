#include-once
#include <Array.au3>
#include "Gui.au3"


Func ENS_AnnulerDerniereAction(ByRef $Tab)
    _ArrayPop($Tab)
    If @error = 3 Then
        MsgBox(0 , "retour" , "le tableau est vide") 
        Return 1
    EndIf
EndFunc


Func ENS_EnregistrerPosSouris($NomFenetre) ; en cours de modifications 

    Local $pos[2] = MouseGetPos()

    Local $delais = GUI_DemanderDelais("Souris")
    
    If $delais = 0 Then 
        Return 0
    EndIf
    
    Local $instruction = 1 & " " & $pos[0] & " " & $pos[1] & " " & $delais
    
    MsgBox(0 , "Instruction" , "voici l'instruction : " & $instruction)
    
    WinActivate($NomFenetre)
    Return 1
EndFunc
