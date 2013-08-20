fade_init   proto   hwnd:dword, lpsfade:dword, initial:dword
fade        proto   hwnd:dword, lpsfade:dword, final:dword, step:dword, speed:dword

sfade   struct
    hwnd        HANDLE ?
    dw_initial  dword ?
    dw_final    dword ?
    dw_step     dword ?
    dw_speed    dword ?
    dw_level    dword ?
sfade   ends

FADE_MAX_LEVEL  equ 0FFh
FADE_OPAQUE     equ FADE_MAX_LEVEL
FADE_INVISIBLE  equ 100h
