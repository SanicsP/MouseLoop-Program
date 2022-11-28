#include-once

Func PROG_VerifMsgQuit($retour)
    If IsString($retour) = 0 and $retour = 0 Then 
        Exit(1)
    EndIf
Endfunc