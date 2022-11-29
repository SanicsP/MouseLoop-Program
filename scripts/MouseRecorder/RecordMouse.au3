#include-once
#include <Array.au3>
Func ENS_DonnerPosSouris()
    Return MouseGetPos()
EndFunc

Func ENS_AnnulerDerniereAction(ByRef $Tab)
    _ArrayPop($Tab)
    If @error = 3 Then
        MsgBox(0 , "retour" , "le tableau est vide") 
        Return 1
    EndIf
EndFunc

Func ENS_EnregistrerPosSouris(ByRef $pos)
    $pos = ENS_DonnerPosSouris()
EndFunc