#include-once
#include "Gui.au3"
#include "Verif.au3"

#cs 
    @brief
    @param 
    @return 
#ce 
Func PROG_VerifMsgQuit($retour)
    If IsArray($retour) = 0 and IsString($retour) = 0 and $retour = 0 Then 
    MsgBox(0 , "Quit" , "Arrêt du script")
        Exit(1)
    EndIf
Endfunc

#cs 
    @brief
    @param 
    @return 
#ce 
Func PROG_LancerProgramme($NomProg , $NomFenetre , $nomP)
    
    Local $nvNomFenetre = $NomFenetre
    Local $EntreeValide = False
    Local $PID_t = Run($NomProg)
    Sleep(2e3)
    
    While $EntreeValide = False 

    If VERIF_VerifFenetreExiste($nvNomFenetre) = 0 Then

        Local $IdBouton = MsgBox(4 , $nomP ,"La fenetre que vous avez spécifié n'existe pas. Voulez vous la resaisir?")
        
        IF $IdBouton = $IDYES Then ; l'utilisateur veut resaisir le nom de la fenêtre 
            
            $nvNomFenetre = GUI_DemanderNomFenetre($nomP)

            If IsString($nvNomFenetre) = 0 Then ; si l'utilisateur veut quitter le programme 
                Return 0
            EndIf

        EndIf
    Else ; le nom de la fenêtre est valide 
        $EntreeValide = True
    EndIf 

    WEnd

    WinActivate($nvNomFenetre)
    Return $PID_t

EndFunc
