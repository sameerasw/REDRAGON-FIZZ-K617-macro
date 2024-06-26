#Requires AutoHotkey v2.0


;CapsLk hotkeys
CapsLock & a::left
CapsLock & d::right
CapsLock & w::up
CapsLock & s::down

CapsLock & q::PgUp
CapsLock & e::PgDn

CapsLock & z::Home
CapsLock & x::End

;Fn keys (broken atm)
CapsLock & 1::F1
CapsLock & 2::F2
CapsLock & 3::F3
CapsLock & 4::F4
CapsLock & 5::F5
CapsLock & 6::F6
CapsLock & 7::F7
CapsLock & 8::F8
CapsLock & 9::F9
CapsLock & 0::F10
CapsLock & -::F11
CapsLock & =::F12

CapsLock & Esc::`

;Brightness adjustment
>!9::
{
    Run 'nircmd.exe changebrightness -10'
    Return
}


>!0::
{
    Run 'nircmd.exe changebrightness +10'
    Return
}


;Right Ctrl mods
RCtrl::Right
AppsKey::Left
>!RCtrl::Down
>!RShift::Up

;Desktop switching
>!,::^#Left
>!.::^#Right

>!/::#+Right

;PrintScreen key
>!BackSpace::PrintScreen

;Media controls
>!=::Volume_Up
>!-::Volume_Down
>!\::Media_Play_Pause
>!]::Media_Next
>![::Media_Prev

;macOS delete
#Backspace::Delete
+#Backspace::+Delete

;Window controls
>!l:: WinMinimize "A"
>!;::
{
    WinGetPos &X, &Y, &W, &H, "A"
    if (W < SysGet(78))
    {
        WinMaximize "A"
    }
    else
    {
        WinRestore "A"
    }

}
>!'::^w

;-----------------mouse-----------------

;Hold mouse forward button for Alt + Tab
XButton2::XButton2

XButton2 & WheelUp::
{
    Send '^#{Left}'
    KeyWait "XButton2"
    return
}

XButton2 & WheelDown::
{
    Send '^#{Right}'
    KeyWait "XButton2"
    return
}

XButton1 & RButton::^v
XButton1 & LButton::
{
    Send "^c"
    KeyWait "XButton2"
    return
}
XButton1 & MButton::
{
    Send "^x"
    KeyWait "XButton2"
    return
}

XButton2 & LButton::#Tab

;Hold mouse back button for Ctrl
XButton1::
{
    If WinActive("WhatsApp Beta")
    {
        Send "{Esc}"
    }
    else If WinActive("ahk_exe Telegram.exe")
    {
        Send "{Esc}"
    }
    else
    {
        Send "{XButton1}"
    }
}

XButton1 & XButton2::#v

;-----------------laptop-----------------

;Press the laptop calculater button to play/pause media and hold for next track.
Launch_App2::
{
    if !KeyWait("Launch_App2", "T0.4")
    {
        Send "{Media_Next}"
        KeyWait "Launch_App2"
    }
    else
    {
        Click "{Media_Play_Pause}"
        return
    }
}

;Use numpad * and - for volume control if NumLock is off
If !GetKeyState("NumLock", "T")
{
    NumpadSub:: Send "{Volume_Up}"
    NumpadMult:: Send "{Volume_Down}"
}


;Text replacements
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

#HotIf WinActive("ahk_exe WindowsTerminal.exe")
{
    ;git commands
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