; -----------------------------------------------------------------------
.486
.model	flat, stdcall
option	casemap :none   ; case sensitive

; -----------------------------------------------------------------------
include project.inc
include core.asm
include effects.asm

; -----------------------------------------------------------------------
.code
; -----------------------------------------------------------------------
DlgAbout    proc    hWnd, uMsg, wParam, lParam
    local   sRect:RECT, sPaint:PAINTSTRUCT
    
    switch  uMsg
        case    WM_INITDIALOG
            invoke  LoadPng, hInstance, hWnd, 3002
            mov     hImg2, eax
            ;invoke    LoadBitmap, hInstance, 3002
            invoke    CreatePatternBrush, eax
            mov       hBackgroundAbout, eax
            
		    invoke    GetWindowRect, hParent, addr sRect
		    invoke    SetWindowPos, hWnd,HWND_TOPMOST, sRect.left, sRect.top, 0, 0,SWP_NOSIZE
            
            invoke    ImageButton, hInstance, hWnd, addr sbutton_close
            mov       hButton_Close2, eax
            invoke    ImageButton, hInstance, hWnd, addr sbutton_help2
            mov       hButton_About2, eax
            
            invoke    GetWindowLong, hWnd, GWL_EXSTYLE
            or        eax, WS_EX_LAYERED
            invoke    SetWindowLong, hWnd, GWL_EXSTYLE, eax
            		
		    invoke    CreateThread, 0, 0, addr FadeInDlg, hWnd, 0, 0
		    mov       hFadeIn, eax
		    .if       lParam == TRUE
		          invoke  SendDlgItemMessage, hWnd, 1011, WM_SETTEXT, 0, SADD("Congratz!!:", 13, 13, 9, "Send your tut+src", 13, 9, 9, "to be part of MAL", 13, 13, "asphx.ia@gmail.com")
		          ;invoke  SetDlgItemText, hWnd, 1011, SADD("Greetz! Send your tut+src", 9, 13, "to be part of MAL\n\n\nasphx.ia@gmail.com")
		    .endif

        case    WM_PAINT
            invoke    BeginPaint, hWnd, addr sPaint
            mov       ebx, eax
            invoke    GetClientRect, hWnd, addr sRect
            invoke    FrameRect, ebx, addr sRect, hBlackBrush
            invoke    EndPaint, hWnd, addr sPaint

        case    WM_CTLCOLORSTATIC
            invoke    SetTextColor, wParam, 00FFFFFFh
		    invoke    SetBkMode, wParam, TRANSPARENT
		
		    invoke    GetDlgCtrlID, lParam
		    invoke    Calculate_offset, hWnd, eax
		    invoke    SetBrushOrgEx, wParam, eax, ebx, 0

            mov       eax, hBackgroundAbout
            ret
            
        case    WM_CTLCOLORDLG
            mov     eax, hBackgroundAbout
            ret

        case    WM_COMMAND
		    mov    eax, wParam
		    and eax, 0000FFFFh
		    
		    switch eax		          
		      case   IDB_CLOSE
		          invoke SendMessage, hWnd, WM_CLOSE, 0, 0
		          
		    endsw
		    
        case    WM_LBUTTONDOWN
            ;invoke  SendMessage, hWnd, WM_NCLBUTTONDOWN, HTCAPTION, 0
            
        case    WM_LBUTTONDBLCLK || uMsg == WM_RBUTTONUP
            invoke  SendMessage, hWnd, WM_CLOSE, 0, 0

	    case    WM_CLOSE
	        invoke  ImageDestroy, hButton_Close2
	        invoke  ImageDestroy, hButton_About2
	        invoke  CreateThread, 0, 0, addr FadeOutDlg, hWnd, 0, 0
	        push    eax
	        invoke  WaitForSingleObject, eax, -1
	        pop     eax
	        invoke  CloseHandle, eax
	        invoke  DeleteObject, hImg2
	        invoke  DeleteObject, hBackgroundAbout
            invoke	EndDialog, hWnd, 0
	endsw
    xor     eax, eax
	ret
DlgAbout endp

; -----------------------------------------------------------------------
DlgProc	proc	hWnd, uMsg, wParam, lParam
    local   sRect:RECT, sPaint:PAINTSTRUCT
    
    switch  uMsg
        case    WM_INITDIALOG
            m2m     hParent, hWnd
            
            invoke  LoadPng, hInstance, hWnd, IDR_BACKGROUND
            mov     hImg, eax
            ;invoke  LoadBitmap, hInstance, IDR_BACKGROUND
            invoke  CreatePatternBrush, eax
            mov     hBackground, eax

            invoke  uFMOD_PlaySong, 5000, 0, XM_RESOURCE
                        
            invoke  CreateFontIndirect, addr sFont
            mov     hFont, eax
            invoke  SendDlgItemMessage, hWnd, IDE_NAME, WM_SETFONT, hFont, 0
            
            invoke  Initialize, hWnd, IDE_NAME
            
            invoke  ImageButton, hInstance, hWnd, addr sbutton_close
            mov     hButton_Close1, eax
            invoke  ImageButton, hInstance, hWnd, addr sbutton_help
            mov     hButton_About1, eax

            invoke  SendDlgItemMessage, hWnd, IDE_NAME, EM_SETLIMITTEXT, NAME_MAX_LENGHT, 0
            ;invoke  SendDlgItemMessage, hWnd, IDE_SERIAL, EM_SETLIMITTEXT, SERIAL_MAX_LENGHT, 0

		    invoke  CreateSolidBrush, 0
		    mov     hBlackBrush, eax

            invoke  GetWindowLong, hWnd, GWL_EXSTYLE
            or      eax, WS_EX_LAYERED
            invoke  SetWindowLong, hWnd, GWL_EXSTYLE, eax
            
		    invoke    CreateThread, 0, 0, addr FadeInDlg, hWnd, 0, 0
		    mov       hFadeIn, eax
		    
		    invoke    LoadIcon, hInstance, 6000
		    mov       hIcon, eax
		    invoke    SendMessage, hWnd, WM_SETICON, ICON_BIG, eax

        case    WM_PAINT
            invoke    BeginPaint, hWnd, addr sPaint
            mov       ebx, eax
            invoke    GetClientRect, hWnd, addr sRect
            invoke    FrameRect, ebx, addr sRect, hBlackBrush
            invoke    EndPaint, hWnd, addr sPaint
        
        case    WM_CTLCOLOREDIT
            invoke    SetTextColor, wParam, 00FFFFFFh
		    invoke    SetBkMode, wParam, TRANSPARENT
		
		    invoke    GetDlgCtrlID, lParam
		    invoke    Calculate_offset, hWnd, eax
		    invoke    SetBrushOrgEx, wParam, eax, ebx, 0

            mov       eax, hBackground
            ret

        case    WM_CTLCOLORDLG
            mov     eax, hBackground
            ret

        case    WM_COMMAND
		    mov    eax, wParam
		    and eax, 0000FFFFh
		    
		    switch eax	          
		      case   IDB_CLOSE
		          invoke SendMessage, hWnd, WM_CLOSE, 0, 0
		      
		      case   IDB_HELP
		          invoke  DialogBoxParam, hInstance, IDE_ABOUT, hWnd, addr DlgAbout, 0

		      default
		          mov     eax, wParam
		          shr     eax, 16
		          .if     ax == EN_CHANGE
		              invoke  InvalidateRect, hWnd, 0, 0
                      invoke  GetDlgItemText, hWnd, IDE_NAME, addr szName, sizeof szName
                      .if     eax >= NAME_MIN_LENGHT && eax <= NAME_MAX_LENGHT
                          mov     ebx, eax
                          invoke  GetDlgItemText, hWnd, IDE_SERIAL, addr szSerial, sizeof szSerial
                          invoke  Verify, addr szName, ebx, addr szSerial, eax
                          .if     !eax
                                ;invoke  MessageBox, hWnd, SADD("Well done!"), SADD("yap, correct"), MB_ICONINFORMATION
                                invoke  DialogBoxParam, hInstance, IDE_ABOUT, hWnd, addr DlgAbout, TRUE
                          .endif

                      .endif   
		          .endif
		          
		    endsw
		
        case    WM_LBUTTONDOWN
            invoke  SendMessage, hWnd, WM_NCLBUTTONDOWN, HTCAPTION, 0
            
        case    WM_LBUTTONDBLCLK || uMsg == WM_RBUTTONUP
            invoke  SendMessage, hWnd, WM_CLOSE, 0, 0

	    case    WM_CLOSE
	        invoke  CreateThread, 0, 0, addr FadeOutDlg, hWnd, 0, 0
	        push    eax
	        invoke  WaitForSingleObject, eax, -1
	        pop     eax
	        invoke  CloseHandle, eax
            invoke  uFMOD_PlaySong, 0, 0, 0
            invoke  ImageDestroy, hButton_Close1
            invoke  ImageDestroy, hButton_About1
            invoke  DeleteObject, hImg
            invoke  DeleteObject, hIcon
	        invoke  DeleteObject, hBlackBrush
	        invoke  DeleteObject, hFont
	        invoke  DeleteObject, hBackground
            invoke	EndDialog, hWnd, 0
	endsw

	xor	eax,eax
	ret
DlgProc	endp

; -----------------------------------------------------------------------
start:
	invoke	GetModuleHandle, NULL
	mov     hInstance, eax
	invoke	DialogBoxParam, hInstance, 101, 0, addr DlgProc, 0
	invoke	ExitProcess, eax

end start
; -----------------------------------------------------------------------
