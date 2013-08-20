include includes.inc

DlgProc		PROTO :DWORD,:DWORD,:DWORD,:DWORD
Calculate_offset    proto :dword, :DWORD
Initialize  proto   :dword, :dword

IDE_ABOUT       equ 102
IDE_NAME        equ 1001
IDE_SERIAL      equ 1002

IDB_CLOSE       equ 1003
IDB_HELP        equ 1004
IDB_ROLLUP      equ 1005

IDR_BACKGROUND  equ 3001

NAME_MIN_LENGHT equ 1
NAME_MAX_LENGHT equ 20
SERIAL_MAX_LENGHT   equ 33

WINDOW_WIDTH    equ 447
WINDOW_HEIGHT   equ 190
WINDOW_HEIGHT_ROLLED    equ 21

.const
    sbutton_close      sbutton <<493, 0>, 4001, 4001, 4000, IDB_CLOSE>
    sbutton_help       sbutton <<479, 0>, 4004, 4004, 4003, IDB_HELP>
    sbutton_help2      sbutton <<479, 0>, 4006, 4006, 4006, IDB_HELP>
    
.data
    sFont   LOGFONT <12,?,?,?,FW_BLACK,?,?,?,?,?,?,?,?,"Tahoma">
    
.data?
    hInstance		dd		?
    hBackground     dd      ?
    hBackgroundAbout dd     ?
    hFont           dd      ?
    hBlackBrush     dd      ?
    hParent         dd      ?
    hIcon           dd      ?
    hFadeIn         dd      ?
    hImg            dd      ?
    hImg2           dd      ?
    
    hButton_Close1  dd  ?
    hButton_Close2  dd  ?
    hButton_About1  dd  ?
    hButton_About2  dd  ?
    
    szName          db 256 dup(?)
    szSerial        db 256 dup(?)