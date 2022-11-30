#include-once 
#include <Array.au3>

Global $FR_TableauInsructions[2] 

Func FR_AjouterInstruction(Byref $tab , $instruction)
    _ArrayAdd($tab , $instruction)    
Endfunc

Func FR_SupprimerInstruction(ByRef $tab) 
    If UBound($tab) > 2 Then
        _ArrayPop($tab)
    EndIf
EndFunc 

Func FR_RenitialiserTabInstrc(Byref $tab)
    
    If UBound($tab) > 2 Then
        _ArrayDelete($tab , "1-"&UBound($tab))
    Else
        MsgBox(0 , "DEBUG" , "Erreur suppresion tableau vide")
    EndIf
EndFunc
