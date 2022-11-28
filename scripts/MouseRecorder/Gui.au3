#include-once
#include <GuiConstants.au3>
#include <Verif.au3>
#include <MsgBoxConstants.au3>

Global $GUI_NonFenetre = "Test"
Global $GUI_TailleFenetre[2] = [400 , 400]
Global $GUI_Fenetre = GUICreate($GUI_NonFenetre , $GUI_TailleFenetre[0] , $GUI_TailleFenetre[1])

;boutons
Global $GUI_Boutons[7]
Global $GUI_TailleBoutons[2] = [50 , 50]

#cs ##################################################################################################################
    fonctions     
#ce ##################################################################################################################

Func GUI_InitialiserBoutons(Byref $Aboutons , $AtailleBouton)

        $Aboutons[0] = GUICtrlCreateButton("Init+0" , -1 , -1 , $AtailleBouton[0] , $AtailleBouton[1])
    
    $posi = 50
    For $i = 1 To Ubound($Aboutons) - 1 Step 1
        $Aboutons[$i] = GUICtrlCreateButton("Init+" & $i , -1 , -1 , $AtailleBouton[0] , $AtailleBouton[1])
        GUICtrlSetPos($Aboutons[$i] , $posi)
        $posi = $posi + 50 
    Next
EndFunc




Func GUI_DemanderNomAp($nomAp = "message")

    Local $NomSaisi 
    Local $EntreeValide = False
    Local $RetourMsg 
    Local $MsgQuit
    
    While $EntreeValide = False

        $NomSaisi = InputBox($nomAp , "Saisisez le chemin du programme à lancer ")
        
        If @error = 1 Then
                $MsgQuit = MsgBox(4 , $nomAp , "Souhaitez vous quitter ? " )
                If $MsgQuit = $IDYES Then
                    Return 0
                Else
                    ContinueLoop
                EndIf
        EndIf

        Switch VERIF_verifAp($NomSaisi)
            
            Case 1
                MsgBox(0 , $nomAp , "L'application que vous avez spécifié n'existe pas")
            Case 2
                $RetourMsg = MsgBox(4 , $nomAp , "L'application que vous avez spécifié est déjà en cours d'éxecution " & @CRLF & _ 
                "voulez vous lancez un autre processus ? ")
                
                If $RetourMsg = $IDYES Then 
                    $EntreeValide = True                
                Endif
            case 3
                MsgBox(0 , $nomAp , "Le fichier a une mauvaise extension , il doit s'agir d'un executable")
            case 0
                $EntreeValide = True
                ; MsgBox(0 , $nomAp , "l'entre est valide !")
        EndSwitch
    WEnd
    Return $NomSaisi 

EndFunc

Func GUI_DemanderNomFenetre($nomAp)
    Local $EntreeValide = False
    Local $NomSaisi = False 
    Local $IdBouton 
    
    While $EntreeValide = False 

        $NomSaisi = InputBox($nomAp , "Entrez le nom de la fenêtre à éxecuter")

        If @error = 1 Then
            $IdBouton = MsgBox(4 , $nomAp , "Voulez vous quitter le programme ?")
            If $IdBouton = $IDYES Then
                return 0
            EndIf
        EndIf
        $EntreeValide = True 
    WEnd

    Return $NomSaisi

EndFunc

Func GUI_IsolerFenetre() 
    WinMinimizeAll()
EndFunc