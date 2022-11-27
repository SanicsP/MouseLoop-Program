#include-once 
#include <Array.au3>
#include <StringConstants.au3>
#include <MsgBoxConstants.au3>



#cs 
    brief : Verifie la saisie de l'utilisateur , veille à ce que le nom soit celui 
    d'un fhichier qui existe et qui possède la bonne extension (ml : MouseLoop)
    param : $NomFichier nom du fichier à verifier 
    return : 0 si une erreur de saisie est rencontrée 1 s'il n'y en a aucune 
#ce
func VerifNomFichier($NomFichier)

    $split = StringSplit($NomFichier , "." , $STR_NOCOUNT)
    $spltL = UBound($split)

    If $split[$spltL-1] <> "ml" then
        MsgBox(0 , "Erreur" , "Le fichier " & $NomFichier & " n'as pas la bonne extension")
        Return 0
    ElseIf FileExists($NomFichier) = 0 then
        MsgBox(0 , "Erreur" , "Le fichier " & $NomFichier & " n'existe pas")
        Return 0
    Endif

    Return 1

Endfunc 

#cs 
    brief : Charge le fichier iniqué par l'utilisateur dans un tableau de chaîne de caractères  
    param : $nom nom du fichier à charger , il doit être d'abord verifié par VerifNomFichier
    return
#ce
func chargerFichier(Const $nom)
    Local $fichier = FileOpen($nom)
    $tab = FileReadToArray($fichier)
    FileFlush($fichier)
    return $tab
EndFunc

#cs 
    brief : Optenir l'identifiant de l'instruction ,  donne l'id de l'instruction à effectuer 
    param : $str la chaîne à analyser
    return : l'identifiant de l'instruction 
#ce
func OptIdInstrc(Const $str) 
    Local $Stab = StringSplit($str , " ")
    IF $Stab[1] = 1 then 
        Return 1
    ElseIf $Stab[1] = 2 then
        Return 2 
    Else
        Return 0
    EndIf
EndFunc

#cs 
    brief : Ananlyse le tableau chargé au préalable et verifie qu'il n'y est pas d'information incohérentes qui 
    pourraient entraîner des compertements indéterminés 
    param : $tab le tableau de châine de caractères à analyser 
    return
#ce
func AnalyserTab(Const Byref $tab)
    
    If FileExists($tab[0]) = 0 then 
        MsgBox(0 , "Erreur" , "le processus " & $tab[0] &" n'existe pas ")
        return 0
    ElseIf StringIsDigit($tab[1]) = 0 then
        MsgBox(0 , "Erreur" , $tab[1] & "n'est pas un nombre")
        Return 0
    Endif
    
    For $i = 2 to UBound($tab) - 1 step 1
        $split = StringSplit($tab[$i] , " ")
        ;MsgBox(0 , "db" , $split[0])
        If OptIdInstrc($tab[$i]) = 0 Then 
            MsgBox(0 , "Erreur" , $tab[$i] & " : l'id est non reconnu ")
            Return 0
        ElseIf OptIdInstrc($tab[$i]) = 1 and $split[0] <> 4 Then 
            MsgBox(0 , "Erreur" , "ligne " & $i & " -> " & $tab[$i] & " : il y a trop ou pas assez de paramètres")
            Return 0
        ElseIf OptIdInstrc($tab[$i]) = 2 and $split[0] <> 6 Then
            MsgBox(0 , "Erreur" , "ligne " & $i & " -> " & $tab[$i] & " : il y a trop ou pas assez de paramètres")
            Return 0
        ElseIf StringIsdigit(StringRegExpReplace($tab[$i] , " " , "")) = 0 then 
            MsgBox(0 , "Erreur" , "ligne " & $i & " -> " & $tab[$i] & " : présence de caractères alphanumériques")
            Return 0
        Endif      
        Return 1       
    Next
    _ArrayDisplay($tab , "debug")
    Return 1
EndFunc

#cs 
    brief : éxecute une instrcution décrite par une ligne en focntion de l'identifiant que contient cette dernière 
    param : $str ligne d'instruction
    param : $vitesse vitesse de clic
    return rien
#ce
func ExctLigne($str , $vitesse = 10)
    
    $split = StringSplit($str , " ", $STR_NOCOUNT)
    Switch OptIdInstrc($str)
        case  1
            MouseClick("left" , $split[1] , $split[2] , $vitesse)
            Sleep($split[3] * 1e3)
        case  2
            MouseClickDrag("left" , $split[1] , $split[2] , $split[3] , $split[4] , $vitesse)
            Sleep($split[5] * 1e3)
    EndSwitch
EndFunc

#cs 
    brief : execute à l'aide de la focntion ExctLigne ligne par ligne le tableau de chaîne de caractères 
    param : $tab tableau de chaîne de caractères à traiter 
    param : $vitesse vitesse de clic
    return rien
#ce
func ExctTableau(Const Byref $tab, $vitesse)

    For $i = 2 To Ubound($tab) - 1 Step 1
        ExctLigne($tab[$i] , $vitesse)
        IF ProcessExists($tab[0]) = 0 then 
            MsgBox(0 , "MouseLoop" , "Vous avez fermé le processus")
            Exit(0)
        EndIf
    Next
EndFunc

#cs 
    brief : execute les instructions d'un tableau de chaîne de caractères plusieurs fois 
    param : $tab le tableau de chîne de carctères à executer 
    param : $iteration le nombre d'itération d'execution du tableau
    param : $vitesse vitesse de clic
    return
#ce
func BoucleInstruction(Const Byref $tab , $iteration , $vitesse)
    For $i = 0 To $iteration Step 1
        ExctTableau($tab , $vitesse)
    Next
EndFunc

#cs 
    brief : Ouvre un executable et donne le focus à une fenêtre choisie  
    param : $nom le du programme à executer son chemin
    param : $NomFenetre le nom de la fenetre qui aura le focus lors du lancement de l'executable 
    param : $poseDepart la position de la fenetre au moment du lancement de l'excutable 
    param : $temps entre le lancement de l'executable et l'obtention du focus de la fenetre 
    return
#ce
func OuvrirAp($nom , $NomFenetre , $posDepart , $temps_attente)
    Run($nom)
    AutoItSetOption("WinTitleMatchMode" , 2)
    WinActivate($NomFenetre)
    Sleep($temps_attente)
    WinMove($NomFenetre , "", $posDepart[0] , $posDepart[1])
EndFunc

#cs 
    brief : arrête le processus de l'application choissie 
    param : $nom le nom de l'application 
    return
#ce
func FermerAp($nom)
    ProcessClose($nom)
EndFunc

#cs 
    brief : permet à l'utilisateur de saisir le nom de la fenêtre qui aura le focus lors du lancemment du script 
    param : $Nomprogramme le nom du programme qui sera affiché sur la boîte de saisie 
    return 
#ce
func SaisirNomFenetre($NomProgramme) 
    Return InputBox($NomProgramme , "Entrez le nom de votre fenêtre")
EndFunc

#cs 
    brief : demande à l'utilisateur de saisir le fichier et verifie que l'entrée soit valide 
    que le fichier est dans le bon format et qu'il existe 
    param : $nom nom du programme qui sera affiché dans la boîte de saisi utilisateur 
    return
#ce
Func SaisirNomFichier($nom)

    Local $valide = False

    Local $NomFichier = 0
    Local $quitt = 0
    
    While not $valide 

        $nomFichier = InputBox($nom , "Entrez du ficher(.ml)")
        ;sais utilisateur 
        IF @error = 0 Then 
            $valide = True
        ElseIf @error = 1 Then
            $quitt = MsgBox(4 , "MouseLoop" , "voulez vous quitter l'aplication ?")
        EndIf

        If $quitt = $IDYES Then 
                Return 1
        ElseIf $valide = False Then
                ContinueLoop
        EndIf

        IF VerifNomFichier($nomFichier) = 0 then
            $valide = False
        EndIf
            
    WEnd
    Return $nomFichier
EndFunc

#cs 
    brief : Réduit toute les fenêtres 
    param :
    return
#ce
func IsolerAp() 
    WinMinimizeAll()
EndFunc