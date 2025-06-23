; Switch between virtual desktops in Windows 10 using Windows + number keys

#Persistent
SetTitleMatchMode, 2

; Define the maximum number of virtual desktops you want to switch between
MaxDesktops := 10

#1:: ; Switch to desktop 1
#2:: ; Switch to desktop 2
#3:: ; Switch to desktop 3
#4:: ; Switch to desktop 4
#5:: ; Switch to desktop 5
#6:: ; Switch to desktop 6
    SwitchDesktop(Substring(A_ThisHotkey, 2))
return

SwitchDesktop(number) {
    ; Check if the number is within a valid range
    if (number > 0 && number <= MaxDesktops) {
        ; Create the title of the virtual desktop
        desktopTitle := "Desktop " . number

        ; Try to activate the virtual desktop
        IfWinExist %desktopTitle% ahk_class CabinetWClass
            WinActivate
        else
            MsgBox, Virtual desktop %number% does not exist.
    }
}

