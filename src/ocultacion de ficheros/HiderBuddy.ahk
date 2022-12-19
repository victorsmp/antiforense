#NoEnv
#SingleInstance, Force
ListLines, Off
SetBatchLines, -1
OnMessage(0x44, "OnMsgBox")
MsgBox 0x1, Elige Acción, ¿Mostrar u Ocultar?
OnMessage(0x44, "")

IfMsgBox OK, {
	FileSelectFolder, ruta,,,Carpeta a Ocultar:
	if(!ErrorLevel && Trim(ruta != ""))
	{
		RunWait, attrib +s +h "%ruta%\*",, Hide
		MsgBox, Ficheros Ocultados!
	}else{
		MsgBox, No has seleccionado una carpeta válida
	}
} Else IfMsgBox Cancel, {
	FileSelectFolder, ruta,,,Carpeta a Desocultar:
	if(!ErrorLevel && Trim(ruta != ""))
	{
		RunWait, attrib -s -h "%ruta%\*",, Hide
		MsgBox, Ficheros Desocultados!
	}else{
		MsgBox, No has seleccionado una carpeta válida
	}
}
ExitApp

OnMsgBox() {
    DetectHiddenWindows, On
    Process, Exist
    If (WinExist("ahk_class #32770 ahk_pid " . ErrorLevel)) {
        ControlSetText Button1, Ocultar
        ControlSetText Button2, Mostrar
    }
}