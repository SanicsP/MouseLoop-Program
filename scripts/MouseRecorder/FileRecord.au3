#include-once 
#include <Array.au3>

Global $FR_TableauInsructions[0] 
Global $FR_NbIterations = 1
Func FR_AjouterInstruction(Byref $tab , $instruction)
    _ArrayAdd($tab , $instruction)    
Endfunc

Func FR_SupprimerInstruction(ByRef $tab) 
    If UBound($tab) > 0 Then
        _ArrayPop($tab)
    EndIf
EndFunc 

Func FR_RenitialiserTabInstrc(Byref $tab)
    
    
    If UBound($tab) > 0 Then
        
        $Taille = UBound($tab)

        For $i = 0 To $Taille Step 1
            _ArrayDelete($tab , 0)
        Next

    Else
        MsgBox(0 , "DEBUG" , "Erreur suppresion tableau vide")
    EndIf
EndFunc
