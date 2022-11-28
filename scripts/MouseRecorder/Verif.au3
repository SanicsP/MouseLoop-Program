#include-once 
#include <StringConstants.au3>


Func VERIF_VerifAp(Const $NomFichier)
    
    Local $Div = StringSplit($NomFichier , "\", $STR_NOCOUNT)
    Local $Taille = UBound($Div)
    Local $ErrDiv = @error

    Local $subDiv
    Local $subTaille 
    Local $ErrSubDiv    

    If $ErrDiv <> 1 Then ;Si l'entrée est un chemin 
        
        $subDiv = StringSplit($Div[$Taille - 1] , "." , $STR_NOCOUNT)
        $ErrSubDiv = @error
        
        If $ErrSubDiv <> 1 Then ; si l'entrée a une extension 
            
            $subTaille = UBound($subDiv)
            
            If $subDiv[$subTaille - 1] <> "exe" Then ; si le fichier du répertoire n'est pas un .exe
                Return 3
            EndIf
        Else ; le fichier n'a pas d'extesion 
            Return 3
        EndIf
    EndIf

    If FileExists($NomFichier) = 0 Then 
        Return 1
    ElseIf ProcessExists($NomFichier) <> 0 Then 
        Return 2
    EndIf 


    Return 0
EndFunc

Func VERIF_VerifFenetre($NomFenetre)
    If WinExists($NomFenetre) = 0 Then 
        Return 0
    EndIf
    Return 1
EndFunc