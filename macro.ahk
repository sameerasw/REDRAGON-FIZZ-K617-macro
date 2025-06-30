#Requires AutoHotkey v2.0

^!Tab::Send '+#{Right}'

!q::Send '^#{Left}'
!e::Send '^#{Right}'

; Load the VirtualDesktopAccessor DLL https://github.com/Ciantic/VirtualDesktopAccessor
vdDll := DllCall("LoadLibrary", "Str", "VirtualDesktopAccessor.dll", "Ptr")

; Function to move window to adjacent desktop
MoveWindowToDesktop(direction := "right") {
    hwnd := WinGetID("A") ; Get active window

    ; Get current desktop
    currentDesktop := DllCall("VirtualDesktopAccessor.dll\GetCurrentDesktopNumber", "Int")
    totalDesktops := DllCall("VirtualDesktopAccessor.dll\GetDesktopCount", "Int")

    if (direction = "left" && currentDesktop > 0) {
        targetDesktop := currentDesktop - 1
    } else if (direction = "right" && currentDesktop < totalDesktops - 1) {
        targetDesktop := currentDesktop + 1
    } else {
        return ; Already at edge
    }

    DllCall("VirtualDesktopAccessor.dll\MoveWindowToDesktopNumber", "Ptr", hwnd, "Int", targetDesktop)
    DllCall("VirtualDesktopAccessor.dll\GoToDesktopNumber", "Int", targetDesktop)
}

GoToDesktopNumber(number) {
    ; Ensure the number is valid
    if (number < 0 || number >= DllCall("VirtualDesktopAccessor.dll\GetDesktopCount", "Int")) {
        return
    }
    DllCall("VirtualDesktopAccessor.dll\GoToDesktopNumber", "Int", number)
}

MoveWindowToDesktopNumber(number) {
    hwnd := WinGetID("A") ; Get active window
    ; Ensure the number is valid
    if (number < 0 || number >= DllCall("VirtualDesktopAccessor.dll\GetDesktopCount", "Int")) {
        return
    }
    DllCall("VirtualDesktopAccessor.dll\MoveWindowToDesktopNumber", "Ptr", hwnd, "Int", number)
}


PinorUnpinWindow() {
    hwnd := WinGetID("A") ; Get active window
    if (hwnd) {
        isPinned := DllCall("VirtualDesktopAccessor.dll\IsPinnedWindow", "Ptr", hwnd, "Int")
        if (isPinned) {
            DllCall("VirtualDesktopAccessor.dll\UnPinWindow", "Ptr", hwnd)
        } else {
            DllCall("VirtualDesktopAccessor.dll\PinWindow", "Ptr", hwnd)
        }
    }
}

; Hotkeys
+!q:: MoveWindowToDesktop("left")    ; Shift + Alt + Q
+!e:: MoveWindowToDesktop("right")   ; Shift + Alt + E

!1::GoToDesktopNumber(0) ; Alt + 1
!2::GoToDesktopNumber(1) ; Alt + 2
!3::GoToDesktopNumber(2) ; Alt + 3
!4::GoToDesktopNumber(3) ; Alt + 4

+!1::MoveWindowToDesktopNumber(0) ; Shift + Alt + 1
+!2::MoveWindowToDesktopNumber(1) ; Shift + Alt + 2
+!3::MoveWindowToDesktopNumber(2) ; Shift + Alt + 3
+!4::MoveWindowToDesktopNumber(3) ; Shift + Alt + 4

+!p::PinorUnpinWindow() ; Alt + P


<#d::#Tab



; macOS delete
#Backspace::Delete
+#Backspace::+Delete



; -----------------mouse-----------------

XButton2 & WheelUp:: {
    Send '^#{Left}'
    KeyWait "XButton2"
    return
}

XButton2 & WheelDown:: {
    Send '^#{Right}'
    KeyWait "XButton2"
    return
}

XButton2 & RButton:: {
    Send '^{PrintScreen}'
    KeyWait "XButton2"
    return
}

XButton2 & LButton:: {
    If WinActive("ahk_class CabinetWClass") and WinGetTitle("A") ~= "File Explorer" {
        Send "^{Space}"
        return
    } else if WinActive("ahk_exe PowerToys.Peek.UI.exe") and WinGetTitle("A") ~= "Peek" {
        Send "^{space}"
        return
    } else if WinActive("ahk_exe firefox.exe") and WinGetTitle("A") ~= "Mozilla Firefox" {
        Send "{Shift Down}{Alt}{Shift Up}"
        Return
    }
    return
}

; Hold mouse forward button for Ctrl
XButton2:: {
    if !KeyWait("XButton2", "T0.5") {
        SendInput "{Ctrl Down}"
        KeyWait "XButton2"
        SendInput "{Ctrl Up}"
        return
    } else {
        Send "{XButton2}"
    }
    return
}

; Hold mouse back button for Shift
XButton1:: {
    if !KeyWait("XButton1", "T0.3") {
        If WinActive("ahk_exe code.exe") and WinGetTitle("A") ~= "Visual Studio Code" {
            Send "^!{space}"
            KeyWait "XButton1"
        } Else If WinActive("ahk_exe zen.exe") or WinActive("ahk_exe firefox.exe") and WinGetTitle("A") ~= "Mozilla Firefox" {
            Send "^!z"
            KeyWait "XButton1"
        } else {
            SendInput "{Shift Down}"
            KeyWait "XButton1"
            SendInput "{Shift Up}"
        }
        return
    } else {
        if WinActive("WhatsApp Beta") {
            Send "{Esc}"
        } else if WinActive("ahk_exe Telegram.exe") {
            Send "{Esc}"
        } else {
            Send "{XButton1}"
        }
    }
    return
}

; -----------------laptop-----------------

; Press the laptop calculator button to play/pause media and hold for next track.
Launch_App2:: {
    if !KeyWait("Launch_App2", "T0.4") {
        Send "{Media_Next}"
        KeyWait "Launch_App2"
    } else {
        Click "{Media_Play_Pause}"
        return
    }
}

; Use numpad * and - for volume control if NumLock is off
if !GetKeyState("NumLock", "T") {
    NumpadSub:: Send "{Volume_Up}"
    NumpadMult:: Send "{Volume_Down}"
}

; Text replacements
::|mon::Monday
::|tue::Tuesday
::|wed::Wednesday
::|thu::Thursday
::|fri::Friday
::|sat::Saturday
::|sun::Sunday
::|jan::January
::|feb::February
::|mar::March
::|apr::April
::|may::May
::|jun::June
::|jul::July
::|aug::August
::|sep::September
::|oct::October
::|nov::November
::|dec::December
::|github::https://github.com/sameerasw/
::|link::https://www.sameerasw.com/
::|pixel::https://www.sameerasw.com/pixel
::|macos::https://www.sameerasw.com/macos
::|linkedin::https://www.linkedin.com/in/sameerasw/
::|twitter::https://twitter.com/sameera_s_w
::|telegram::https://t.me/sameera_s_w
::|instagram::https://www.instagram.com/sameera_s_w/
::|@::sameera_s_w
::|gm::Good Morning!
::|gn::Good Night!
::|wa::WhatsApp
::|tg::Telegram
::|omw::On my way!
::|brb::Be right back!
::|ty::Thank you!
::|yw::You're welcome!
::|np::No problem!
::wlcm::welcome
::|wfh::work from home
::|sri::Sri Lanka
::|hbd::Happy Cake Day
::lorem::Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod, nisl eget ultricies aliquam, nunc nisl ultricies nunc, quis ultricies nisl nisl eget nisl.
:*:spprt::support

; -----------------Application-specific hotkeys-----------------

; When Zen browser app is active, Win+S sends Ctrl+Alt+Z
; #HotIf WinActive("ahk_exe zen.exe") or WinActive("ahk_exe firefox.exe") and WinGetTitle("A") ~= "Mozilla Firefox"
; {
;     #s::Send "^!z"
;     #d::Send "^!z"
; }

; #HotIf WinActive("ahk_exe code.exe") and WinGetTitle("A") ~= "Visual Studio Code"
; {
;     #s::Send "^!{space}"
;     #d::Send "^!{space}"

; }

#HotIf WinActive("ahk_exe WindowsTerminal.exe")
{
    ; git commands
    :*:gadd::git add .{enter}
    :*:gcom::git commit -m ""{left}
    :*:gpush::git push{enter}
    :*:gpull::git pull{enter}
    :*:gstat::git status{enter}
    :*:glog::git log{enter}
    :*:gdiff::git diff{enter}
    :*:gfetch::git fetch{enter}
    :*:gclone::git clone{space}
    return
}
