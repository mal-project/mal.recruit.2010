.code

FadeInDlg   proc    hWnd
    
    xor     ebx, ebx
    
    .repeat
        invoke  SetLayeredWindowAttributes, hWnd, -1, ebx, 2
        
        inc     ebx
    .until  ebx >= 255
    

	Ret
FadeInDlg EndP

FadeOutDlg   proc    hWnd
    
    mov     ebx, 255
    
    .repeat
        invoke  SetLayeredWindowAttributes, hWnd, -1, ebx, 2
        dec     ebx
    .until  SIGN?
    

	Ret
FadeOutDlg EndP

Calculate_offset    proc    hWnd, ID_EDIT
    local   swinrect:RECT, seditrect:RECT

	invoke    GetWindowRect, hWnd, addr swinrect
	invoke    GetDlgItem, hWnd, ID_EDIT
	mov       ebx, eax
	invoke    GetWindowRect, ebx, addr seditrect

	mov       eax, swinrect.left
	mov       edx, seditrect.left
	sub       eax, edx

	mov       ebx, swinrect.top
	mov       edx, seditrect.top
	sub       ebx, edx
	
	ret
Calculate_offset    endp
