#NoEnv
#SingleInstance, Force
#NoTrayIcon
ListLines, Off
SetBatchLines, -1
silent := 0
Loop, %0%
{
	param := %A_Index%
	switch param
	{
		case "-h": MsgBox, Comandos disponibles:`n-silent -> Modo silencioso (sin GUI)`n-hide/-show -> Mostrar/Ocultar ficheros`n-path <ruta ficheros> -> Especificar ruta ficheros ocultar
			ExitApp
		case "-silent": silent := 1
		case "-hide": mode := "+s +h"
		case "-show": mode := "-s -h"
	}
	if(lastparam == "-path")
	{
		ruta := param
	}
	lastparam := param
}

if(!silent)
{
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
}
else
{
	if(mode == "")
		MsgBox, No has especificado opción`, necesitas al menos -hide o -show`n`nUsa HiderBuddy -h para mostrar la ayuda.
	else if(ruta == "")
		MsgBox, No has especificado ruta!`nOpción -path no encontrada!
	else
	{
		RunWait, attrib %mode% "%ruta%\*",, Hide
		if(mode == "+s +h")
			MsgBox, Ficheros Ocultados!
		else
			MsgBox, Ficheros Desocultados!
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