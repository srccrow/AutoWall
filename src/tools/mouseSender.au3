#include <WinAPI.au3>
#include <WindowsConstants.au3>

Func TrackMouseInWindow($Window)
    Local $hWnd = WinGetHandle($Window)
    If $hWnd = 0 Then
        MsgBox(0, "Error", "Unable to find the window.")
        Return
    EndIf

    Local $pos, $prevX = 0, $prevY = 0

    While 1
        $pos = MouseGetPos()
        If ($pos[0] <> $prevX) Or ($pos[1] <> $prevY) Then
            $prevX = $pos[0]
            $prevY = $pos[1]
            _WinAPI_PostMessage($hWnd, $WM_MOUSEMOVE, 0, _MakeLong($pos[0], $pos[1]))
        EndIf
        Sleep(10)  
    WEnd
EndFunc

Func _MakeLong($LoWord, $HiWord)
    Return BitOR($HiWord * 0x10000, BitAND($LoWord, 0xFFFF))
EndFunc

; Call the function with the class name of the window
TrackMouseInWindow($CmdLine[1])