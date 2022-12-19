#NoEnv
#SingleInstance, Force
FileInstall, lib\crypt.exe, %A_Temp%\crypt.exe, 1
ListLines, Off
SetBatchLines, -1
OnMessage(0x44, "OnMsgBox")
MsgBox 0x1, Elige Acci�n, Encriptar o desencriptar?
OnMessage(0x44, "")

IfMsgBox OK, {
	FileSelectFile, ruta,,,Fichero a Encriptar:
	if(!ErrorLevel && Trim(ruta != ""))
	{
		clave = secret
		if(usarClavePrompt())
		{
			InputBox, clave, Clave, Introduce la clave para encriptar
			if(clave = "")
				clave = secret
		}
		ToolTip, Encriptando Fichero...
		RunWait, % A_Temp "\crypt.exe -encrypt -key """ clave """ -infile """ ruta """ -outfile """ ruta """",, Hide
		ToolTip
		MsgBox, Fichero Encriptado!
	}else{
		MsgBox, No has seleccionado un fichero v�lido
	}
} Else IfMsgBox Cancel, {
	FileSelectFile, ruta,,,Fichero a Desencriptar:
	if(!ErrorLevel && Trim(ruta != ""))
	{
		clave = secret
		if(usarClavePrompt())
		{
			InputBox, clave, Clave, Introduce la clave para desencriptar
			if(clave = "")
				clave = secret
		}
		ToolTip, Encriptando Fichero...
		RunWait, % A_Temp "\crypt.exe -decrypt -key """ clave """ -infile """ ruta """ -outfile """ ruta """",, Hide
		ToolTip
		MsgBox, Fichero Desencriptado!
	}else{
		MsgBox, No has seleccionado un fichero v�lido
	}
}
ExitApp

OnMsgBox() {
    DetectHiddenWindows, On
    Process, Exist
    If (WinExist("ahk_class #32770 ahk_pid " . ErrorLevel)) {
        ControlSetText Button1, Encriptar
        ControlSetText Button2, Desencriptar
    }
}

usarClavePrompt()
{
	MsgBox 0x4, Clave Encriptaci�n, �Quieres usar una clave de encriptaci�n/desencriptaci�n?
	IfMsgBox Yes, {
		return 1
	} Else IfMsgBox No, {
		return 0
	}
}