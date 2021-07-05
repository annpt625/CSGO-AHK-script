init:
#NoEnv
#SingleInstance, Force
#Persistent
#InstallKeybdHook
#UseHook
#KeyHistory, 0
#HotKeyInterval 1
#MaxHotkeysPerInterval 127
version = badeverything v0.02


v::
exitapp
return


k:: Hotkey, *~$LButton, Toggle


*~$LButton::

SetKeyDelay,-1, 1
SetControlDelay, -1
SetMouseDelay, -1
SetWinDelay,-1
SendMode, InputThenPlay
SetBatchLines,-1
ListLines, Off
CoordMode, Pixel, Screen, RGB
CoordMode, Mouse, Screen
PID := DllCall("GetCurrentProcessId")
Process, Priority, %PID%, High
 
EMCol := 0x808000
ColVn := 64
AntiShakeX := (A_ScreenHeight // 160)
AntiShakeY := (A_ScreenHeight // 128)
ZeroX := (A_ScreenWidth // 2) ;dont touch?
ZeroY := (A_ScreenHeight // 2) 
CFovX := (A_ScreenWidth // 40)  ;configure for FOV up = smaller lower= bigger
CFovY := (A_ScreenHeight // 64)
ScanL := ZeroX - CFovX
ScanT := ZeroY
ScanR := ZeroX + CFovX
ScanB := ZeroY + CFovY
NearAimScanL := ZeroX - AntiShakeX
NearAimScanT := ZeroY - AntiShakeY
NearAimScanR := ZeroX + AntiShakeX
NearAimScanB := ZeroY + AntiShakeY

Loop, {
	KeyWait, LButton, D
	PixelSearch, AimPixelX, AimPixelY, NearAimScanL, NearAimScanT, NearAimScanR, NearAimScanB, EMCol, ColVn, Fast RGB
	if (!ErrorLevel=0) {
		loop, 10 {
			PixelSearch, AimPixelX, AimPixelY, ScanL, ScanT, ScanR, ScanB, EMCol, ColVn, Fast RGB
			AimX := AimPixelX - ZeroX
			AimY := AimPixelY - ZeroY
			DirX := -1
			DirY := -1
			If ( AimX > 0 ) {
				DirX := 1
			}
			If ( AimY > 0 ) {
				DirY := 1
			}
			AimOffsetX := AimX * DirX
			AimOffsetY := AimY * DirY
			MoveX := Floor(( AimOffsetX ** ( 1 / 2 ))) * DirX
			MoveY := Floor(( AimOffsetY ** ( 1 / 2 ))) * DirY
			DllCall("mouse_event", uint, 1, int, MoveX * 1.5, int, MoveY, uint, 0, int, 0) ;turing mouse to color were it says * is the speed of the aimbot turn up for unhuman reactions lower for human
		}
	}
}


