#Requires AutoHotkey v2.0

; Refactored to use Tab as a custom modifier

Tab:: HandleTab()

; Function to handle Tab key logic
HandleTab() {
    static TabState := 0
    if (TabState == 1) {
        TabState := 0
        Send "{Tab}"
        return
    }
    TabState := 1
    SetTimer ResetTabState, -200
    KeyWait "Tab", "T0.3"
    if !GetKeyState("Tab", "P") {
        TabState := 0
        Send "{Tab}"
    }
}

ResetTabState() {
    global TabState
    TabState := 0
}

; Brightness adjustment
Tab & 9:: {
    Run 'nircmd.exe changebrightness -10'
    return
}

Tab & 0:: {
    Run 'nircmd.exe changebrightness +10'
    return
}

<#d::#Tab

; Desktop switching
Tab & ,::^#Left
Tab & .::^#Right

Tab & /::#+Right

; PrintScreen key
Tab & BackSpace::PrintScreen

; macOS delete
#Backspace::Delete
+#Backspace::+Delete

; Window controls
Tab & z:: WinMinimize "A"
Tab & x:: {
    WinGetPos &X, &Y, &W, &H, "A"
    if (W < SysGet(78)) {
        WinMaximize "A"
    } else {
        WinRestore "A"
    }
}

Tab & c::^w

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
    if !KeyWait("XButton1", "T0.5") {
        SendInput "{Shift Down}"
        KeyWait "XButton1"
        SendInput "{Shift Up}"
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
::|netlify::https://sameerasw.netlify.app/
::|github::https://github.com/sameerasw/
::|link::https://sameerasw.com/
::|pixel::https://sameerasw.com/pixel
::|macos::https://sameerasw.com/macos
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
::|hack::https://hackbook.simple.ink/
::lorem::Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod, nisl eget ultricies aliquam, nunc nisl ultricies nunc, quis ultricies nisl nisl eget nisl.
:*:spprt::support

; -----------------Application-specific hotkeys-----------------

; When Zen browser app is active, Win+S sends Ctrl+Alt+Z
#HotIf WinActive("ahk_exe zen.exe") or WinActive("ahk_exe firefox.exe") and WinGetTitle("A") ~= "Mozilla Firefox"
{
    #s::Send "^!z"
    #d::Send "^!z"
}

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

; tab fixes with modifiers
^Tab::Send "{Ctrl Down}{Tab}{Ctrl Up}"
+Tab::Send "{Shift Down}{Tab}{Shift Up}"
^+Tab::Send "{Ctrl Down}{Shift Down}{Tab}{Shift Up}{Ctrl Up}"
#Tab::Send "{LWin Down}{Tab}{LWin Up}"
#+Tab::Send "{Shift Down}{LWin Down}{Tab}{LWin Up}{Shift Up}"
^#Tab::Send "{Ctrl Down}{LWin Down}{Tab}{LWin Up}{Ctrl Up}"
!Tab::Send "{Alt Down}{Tab}{Alt Up}"
!+Tab::Send "{Alt Down}{Shift Down}{Tab}{Shift Up}{Alt Up}"
!#Tab::Send "{Alt Down}{LWin Down}{Tab}{LWin Up}{Alt Up}"
!^Tab::Send "{Alt Down}{Ctrl Down}{Tab}{Ctrl Up}{Alt Up}"
!^+Tab::Send "{Alt Down}{Ctrl Down}{Shift Down}{Tab}{Shift Up}{Ctrl Up}{Alt Up}"
!^#Tab::Send "{Alt Down}{Ctrl Down}{LWin Down}{Tab}{LWin Up}{Ctrl Up}{Alt Up}"
