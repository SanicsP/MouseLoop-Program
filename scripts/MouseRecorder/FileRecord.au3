#include-once 
#include <Array.au3>

Global $FR_TableauInsructions[0] 
Global $FR_NbIterations = 1

#cs 
    @brief Ajoute une instruction dans un tableau d'instruction
    @param $tab le tableau d'instructions à modifier 
    @param $instruction l'instruction à ajouter 
    @return aucune valeur 
#ce 
Func FR_AjouterInstruction(Byref $tab , $instruction)
    _ArrayAdd($tab , $instruction)    
Endfunc

#cs 
    @brief Suprime une instruction d'un tableau d'instructions 
    @param $tab le tableau à modifier 
    @return aucune valeur 
#ce 
Func FR_SupprimerInstruction(ByRef $tab) 
    If UBound($tab) > 0 Then
        _ArrayPop($tab)
    EndIf
EndFunc 

#cs 
    @brief Renitialise un tableau d'instructions 
    @param $le tableau d'instuctions à modifier 
    @return 1 si l'actions s'est correctement déroulée , 0 s'il y a eu une errreur 
#ce 
Func FR_RenitialiserTabInstrc(Byref $tab)
    
    
    If UBound($tab) > 0 Then
        
        $Taille = UBound($tab)

        For $i = 0 To $Taille Step 1
            _ArrayDelete($tab , 0)
        Next
        Return 1 
    Else
        ;MsgBox(0 , "DEBUG" , "Erreur suppresion tableau vide")
        Return 0
    EndIf
EndFunc
