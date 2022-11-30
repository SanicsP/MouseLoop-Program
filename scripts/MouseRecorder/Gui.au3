#include-once
#include <GuiConstants.au3>
#include <Verif.au3>
#include <MsgBoxConstants.au3>
#include <AutoitConstants.au3>
#include <ColorConstants.au3>
#include <FileConstants.au3>

Global $GUI_NonFenetre = "Test"
Global $GUI_TailleFenetre[2] = [400 , 400]
Global $GUI_Fenetre = GUICreate($GUI_NonFenetre , $GUI_TailleFenetre[0] , $GUI_TailleFenetre[1])

;boutons
Global $GUI_Boutons[7]
Global $GUI_TailleBoutons[2] = [50 , 50]
;Accélérateur 
$GUI_D_Touch = 0
$GUI_C_Touch = 0
$GUI_F_Touch = 0


#cs ##################################################################################################################
    fonctions     
#ce ##################################################################################################################

#cs 
    @brief Place les boutons dans la fenêtre du Script
    @param $Abotons Tableau contenant l'identifiant des contrôles de la fenêtre 
    @return Aucune valeur 
#ce 
Func GUI_InitialiserBoutons(Byref $Aboutons , $AtailleBouton)

        $Aboutons[0] = GUICtrlCreateButton("Init+0" , -1 , -1 , $AtailleBouton[0] , $AtailleBouton[1])
    
    $posi = 50
    For $i = 1 To Ubound($Aboutons) - 1 Step 1
        $Aboutons[$i] = GUICtrlCreateButton("Init+" & $i , -1 , -1 , $AtailleBouton[0] , $AtailleBouton[1])
        GUICtrlSetPos($Aboutons[$i] , $posi)
        $posi = $posi + 50 
    Next
EndFunc




#cs 
    @brief Demande une saisi utilisateur pour le nom du programme 
    @param $nomAp Le nom du script 
    @return Le nom valide saisi pas l'utilisateur , 0 si l'utilisateur souhaite arrêter l'execution du script
#ce 
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

#cs 
    @brief Demande ube saisi utilisateur pour le nom de la fenêtre qui recevera le focus et sur laquelle 
    la séquence de clics s'enregistrer 
    @param $nomAp Le nom du script 
    @return Le nom valide de la fenêtre , 0 si l'utilisateur souhaite arrêter le script 
#ce 
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

#cs 
    @brief Réduit toute les fenêtres du bureau
    @param rien
    @return aucune valeur 
#ce 
Func GUI_IsolerFenetre() 
    WinMinimizeAll()
EndFunc

#cs 
    @brief Place les boutons dans différents endroits de la fenêtre du script 
    @param $TailleFentre La taille de la fenêtre sous forme de tableau [Largeur , Hauteur]
    @param $TBoutons Tableau contenant les identifiants des contrôles des boutons 
    @return Aucune valeur 
#ce 
Func GUI_PlacerBoutons($tailleFenetre , Byref $TBoutons )
    
    ;Initialisation des fenêtres

    $Tboutons[0] = GUICtrlCreateButton("Nb enregistrement" , 0 ,0 , $tailleFenetre[0]/2 , 100)
    $Tboutons[1] = GUICtrlCreateButton("Drag" , 0  , 100 , $tailleFenetre[0]/2 , 100)
    $Tboutons[2] = GUICtrlCreateButton("Drop" , 0  , 200 , $tailleFenetre[0]/2 , 100)
    $Tboutons[3] = GUICtrlCreateButton("Annuler" , 0  , 300 , $tailleFenetre[0]/2 , 100)
    $Tboutons[4] = GUICtrlCreateButton("Recommencer" , $tailleFenetre[0]/2  , 0 , $tailleFenetre[0]/2 , 100)
    $Tboutons[5] = GUICtrlCreateButton("Enregistrement Clic" , $tailleFenetre[0]/2  , 100 , $tailleFenetre[0]/2 , 200)
    $Tboutons[6] = GUICtrlCreateButton("Enregistrer la séquence" , $tailleFenetre[0]/2  , 300 , $tailleFenetre[0]/2 , 100)

EndFunc

#cs 
    @brief Colorie les Boutons de la fenêtre du script 
    @param 
    @return Aucune Valeur 
#ce 
Func GUI_ColorerBoutons(Byref $TBoutons , $handleFenetre)

    GUICtrlSetBkColor($Tboutons[0] , 0x81d41a)
    GUICtrlSetBkColor($Tboutons[1] , 0xff860d)
    GUICtrlSetBkColor($Tboutons[2] , 0xffe994)
    GUICtrlSetBkColor($Tboutons[3] , 0xff0000)
    GUICtrlSetBkColor($Tboutons[4] , 0xe16173)
    GUICtrlSetBkColor($Tboutons[5] , 0xffbf00)
    GUICtrlSetBkColor($Tboutons[6] , 0x800080)

EndFunc 




#cs 
    @brief Demande une saisie utilisateur pour le delais d'attente entre chaque clic de l'utilisateur 
    @param $NomAp nom du script 
    @return La valeur valide du delais , 0 si l'utilisateur souhaite Annuler l'enregistrement de son clic
#ce 
Func GUI_DemanderDelais($NomAp) ; En cours de modificaton
    Local $EntreeValide = False
    Local $delais = 0
    Local $retour = 0
    
    While $EntreeValide = False 
       
        $delais = InputBox($nomAp , "indiquez le delais d'attente pour le prochain clic")
        Local $ErrInput = @error
        $delais = INT($delais)
    
        If $ErrInput = 1 Then
            
             $retour = MsgBox(4 , $nomAp , "Voulez vous annuler votre clic ?") 
            
            Switch $retour
                case $IDYES
                    MsgBox(0 , $nomAp , "Vous avez annulé lenregistrement du clic , il ne sera pas enregistré")
                    Return 0
                case $IDNO
                    MsgBox(0 , $nomAp , "resaisisez le délais , votre clic n'a pas été annulé")
                    ContinueLoop
            EndSwitch

        ElseIf VERIF_verifDelais($delais) = 0 Then
            MsgBox(0 , $nomAp , "Votre saisie est incorrecte") 
            ContinueLoop
        EndIf
        
        $EntreeValide = True
        
    WEnd

    Return $delais
EndFunc

#cs 
    @brief Fonction Pour capter les pression de l'utilisateur sur la Touche D du clavier 
    @param aucun argument
    @return aucune valeur 
#ce 
Func GUI_D_presse()
    If $GUI_D_Touch = 0 Then
        $GUI_D_Touch = 1
    Else
        $GUI_D_Touch = 0 
    EndIf
EndFunc

#cs 
    @brief Fonction Pour capter les pression de l'utilisateur sur la Touche C du clavier 
    @param aucun argument
    @return aucune valeur 
#ce 
Func GUI_C_presse()
    If $GUI_C_Touch = 0 Then
        $GUI_C_Touch = 1
    Else
        $GUI_C_Touch = 0 
    EndIf
EndFunc

#cs 
    @brief Fonction Pour capter les pression de l'utilisateur sur la Touche F du clavier 
    @param aucun argument
    @return aucune valeur 
#ce 
Func GUI_F_presse()
    If $GUI_F_Touch = 0 Then
        $GUI_F_Touch = 1
    Else
        $GUI_F_Touch = 0 
    EndIf
EndFunc

#cs 
    @brief Active les raccourcis clavier pour les Touches D ,F et C 
    @param aucun argument 
    @return aucune valeur 
#ce 
Func GUI_ActiverTouches() 
     HotKeySet("d" , "GUI_D_presse")
    HotKeySet("f" , "GUI_F_presse")
    HotKeySet("c" , "GUI_C_presse")
EndFunc

#cs 
    @brief Desactive les raccourcis clavier pour les Touches D ,F et C 
    @param aucun argument 
    @return aucune valeur 
#ce
Func GUI_DesactiverTouches() 
    HotKeySet("d")
    HotKeySet("f")
    HotKeySet("c")
EndFunc

#cs 
    @brief Demande une saisie utilisateur Pour le nom du fichier .ml qui contiendra toute 
    les instructions de clic
    @param $nomAp Le nom du script 
    @return l'handle du fichier nouvellement crée , 0 si une erreur est survenue 
#ce 
Func GUI_DemanderNomFichier($nomAp) 
    $EntreeValide = 0
    $Entree = ""

    While $EntreeValide = 0
        $Entree = InputBox($nomAp , "Saisez le nom du fichier et spécifiez le chemin absolu")
        IF @error = 1 Then
            Local $EntreMsgBox = MsgBox(4 , $nomAp , "Voulez vous annuler la sauvegarde ?")
            
            Switch $EntreMsgBox
                
                case $IDYES
                    MsgBox(0 , $nomAp , "Le fichier ne sera pas Sauvegardé")
                    Return 0
                case $IDNO
                    ContinueLoop 
            EndSwitch
        EndIf

        IF VERIF_VerifRepertoirExiste($Entree) = 0 Then 
            MsgBox(0 , $nomAp , "Le Repertoir spécifié n'existe pas")
            ContinueLoop
        EndIf
        $EntreeValide = 1
    WEnd
    
    Local $Fichier = FileOpen($Entree & ".ml" , $FO_OVERWRITE)
    
    If $Fichier = -1 Then 
        MsgBox(0 , $nomAp , "Erreur Le fichier n'as pas pu s'ouvir")
        return 0
    EndIf

    Return $Fichier 
EndFunc

#cs 
    @brief Demande une saisie utilisateur Pour la saisie du nombre d'itérations de suite d'instructions de clics 
    @param $nomAp Le nom du script 
    @return La valeur d'itération valide , 0 si l'utilisateur veut anuler la saisie 
#ce 
Func GUI_DemanderNbIterations($nomAp)
    Local $EntreeValide = 0 
    Local $NbIteration = 0 
    
    While $EntreeValide = 0
        $NbIteration = InputBox($nomAp , "Combien de fois voulez vous que le scripte s'execute ? ")
        
        If @error = 1 Then
            Local $Retour = MsgBox(4 , "Itérations" , "Voulez vous annuler la sauvegarde ?")
            Switch $Retour 
                Case $IDYES 
                    Return 0 
                Case $IDNO
                    ContinueLoop
            EndSwitch
        EndIf

        If VERIF_VerifNbIteration($NbIteration) = 0 Then 
            MsgBox(48 , "Erreur" , "L'entrée n'est pas valide")
            ContinueLoop
        EndIf 
        $EntreeValide = 1
    Wend
    Return $NbIteration
EndFunc 