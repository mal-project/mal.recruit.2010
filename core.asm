.code
    Initialize  proc    hWnd, dwEdit
        local   nSize, _szName[256]:byte
        
        mov     nSize, sizeof _szName
        invoke  GetUserName, addr _szName, addr nSize
        
        invoke  SetDlgItemText, hWnd, dwEdit, addr _szName
        ret
    Initialize endp

    ssha    struct
        part1   dword 4 dup(?)
        part2   dword 4 dup(?)
    ssha    ends
    
.const
    ;crt_prime1  db  089h, 04Dh, 07Bh, 0E7h, 085h, 0A8h, 067h, 045h, 00Ah, 082h, 012h, 04Eh, 011h, 0A5h, 099h, 017h, 065h, 0D8h, 018h, 0F5h, 0B1h, 02Ch, 0A2h, 022h, 06Fh, 067h, 013h, 074h, 0E6h, 03Ch, 035h, 00Bh
    ;crt_prime2  db  0D8h, 075h, 0D8h, 0C7h, 0F9h, 010h, 0E7h, 08Ch, 038h, 004h, 08Bh, 071h, 0BEh, 030h, 0A4h, 05Fh, 07Ch, 067h, 086h, 082h, 0DAh, 0EAh, 067h, 079h, 021h, 017h, 0E2h, 007h, 028h, 050h, 0F4h, 0D7h
	crt_prime1 db 0B5h,0A7h,05Dh,06Ch,062h,0ECh,044h,090h,0A3h,023h,043h,072h,07Ch,0A1h,03Ch,05Ch,0BEh,08Dh,04Bh,043h
	crt_prime2 db 0B6h,0F5h,08Ah,0D7h,0B0h,097h,0D2h,0A8h,0EEh,0B6h,009h,066h,0E6h,080h,0F2h,087h,096h,0A1h,001h,053h
	;B5A75D6C62EC4490A32343727CA13C5CBE8D4B43
	;B6F58AD7B097D2A8EEB60966E680F28796A10153

.code
    Verify     proc lpszname, unlen, lpszserial, uslen
        local   sha256:ssha
        local   hx, hm, hcrt_primes[2], hres[2]:hBIG

        invoke  SHA256, lpszname, unlen, addr sha256

        invoke  big_create_array, addr hres, 6
        
        invoke  big_cinstr, lpszserial, hx
        
        ; get in two primes
        invoke  big_bytes_to_big, addr crt_prime1, sizeof crt_prime1, hcrt_primes[0]
        invoke  big_bytes_to_big, addr crt_prime2, sizeof crt_prime2, hcrt_primes[4]
        ;invoke  big_cinstr, SADD("B5A75D6C62EC4490A32343727CA13C5CBE8D4B43"), hcrt_primes[0]
        ;invoke  big_cinstr, SADD("B6F58AD7B097D2A8EEB60966E680F28796A10153"), hcrt_primes[4]

        ; get in mi
        invoke  big_bytes_to_big, addr sha256.part1, 16, hres[0]
        invoke  big_bytes_to_big, addr sha256.part2, 16, hres[4]

        ; x mod p1 ==  m1
        mov     ecx, 1
        .repeat
        
            invoke  big_mod, hx, hcrt_primes[ecx*4], hm
            invoke  big_compare, hm, hres[ecx*4]
            .break .if     eax

            dec     ecx
        .until  SIGN?      
        invoke  big_destroy_array, addr hres, 6
        
        inc     ecx
        push    ecx
        pop     eax

    	ret
    Verify endp
    