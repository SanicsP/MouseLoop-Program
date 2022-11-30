#include-once 
#include <StringConstants.au3>
#include <AutoitConstants.au3>


#cs 
    @brief Verifie Que le programme spécifié par l'utilisateur soit valide 
    @note pour que l'entrée utilisateur soit valide : le fichier doit être un executable 
    et doit exister 
    @param $NomFichier Le nom de l'executable donné par l'utilisateur 
    @return 1 si le fichier n'existe pas , 2 si l'application spécifiée est déjà éxécutée par le PC , 3 
    si le fichier n'est pas un executable
#ce 
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

#cs 
    @brief Verifie si une Fenêtre existe 
    @param $NomFenetre Le nom de la fenêtre donné par l'utilisateur 
    @return 1 si elle existe , 0 dans le cas contraire 
#ce 
Func VERIF_VerifFenetreExiste($NomFenetre)
    If WinExists($NomFenetre) = 0 Then 
        Return 0
    EndIf
    Return 1
EndFunc

#cs 
    @brief Verifie si la fenêtre est active 
    @param $NomFenetre Le nom de la fenêtre donné par l'utilisateur 
    @return 1 si elle l'est , 0 dans le cas contraire 
#ce 
Func VERIF_verifFenetreActive($NomFenetre)
    If WinActive($NomFenetre) = 0 Then
        return 0 
    EndIf
EndFunc

#cs 
    @brief Vérifie la valeur du délais incrite par l'utilisateur 
    @param $delais la valeur des délais en secondes 
    @return 1 si la valeur est correcte , 0 si elle ne l'est pas 
#ce 
Func VERIF_verifDelais($delais)
    
    Select 
        Case  $delais = 0
            Return 0
        Case $delais < 0 
            Return 0
    EndSelect

    Return 1 
EndFunc

#cs 
    @brief Verifie l'existence d'un repertoir spécifié par l'utilisateur 
    @param $rep  repertoir spécifié 
    @return 1 si le repetoir existe , 0 sinon 
#ce 
Func VERIF_VerifRepertoirExiste($Rep)
    Local $str = StringSplit($Rep , "/" , $STR_NOCOUNT)
    Local $strB = UBound($str)
    Local $chemin = "" 

    For $i = 0 To $strB - 2 Step 1
       $chemin = $chemin & $str[$i]
        If $i = $strB - 2 Then
            ExitLoop
        Else
            $chemin = $chemin & "/"
        EndIf
    Next
    If FileExists($chemin) = 1 Then
        MsgBox(0 , "Erreur" , $chemin & " Existe")
        Return 1
    Else
        MsgBox(0 , "Erreur" , $chemin & " N'existe pas")
        Return 0
    EndIf
    
EndFunc

#cs 
    @brief n'envoi que le bout du chemin
    @param $Chemin le chemin à analyser
    @return Le nom du fichier avec son extension 
#ce 
Func SeparerChemin($chemin) 
    Local $Div = StringSplit($chemin , "/" , $STR_NOCOUNT)
    Local $DivB = UBound($Div)
    Return $Div[$DivB - 1]
EndFunc

#cs 
    @brief Vérifie si la valeur du nombre d'itérations est valide 
    @param $NbIteration La valeur du nombre d'itérations 
    @return 1 si la valeur est valide , 0 sinon 
#ce 
Func VERIF_VerifNbIteration($NbIteration) 
    If $NbIteration <= 0 Then
        Return 0 
    EndIf
    Return 1 
EndFunc