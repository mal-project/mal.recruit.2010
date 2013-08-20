; Chinese Remainder Theorem
;-----------------------------------------------------------------------
    crt_validate    proc    lpx, lpszname, dwlen:dword
        local   sha256:ssha
        local   hx, hm, hcrt_primes[2], hres[2]:hBIG
        local   _return:dword
        pushad

        invoke  SHA256, lpszname, dwlen, addr sha256

        invoke  big_create_array, addr hres, 6

        ; get in two primes
        invoke  big_bytes_to_big, addr crt_prime1, sizeof crt_prime1, hcrt_primes[0]
        invoke  big_bytes_to_big, addr crt_prime2, sizeof crt_prime2, hcrt_primes[4]

        ; get in mi
        invoke  big_bytes_to_big, addr sha256.part1, 16, hres[0]
        invoke  big_bytes_to_big, addr sha256.part2, 16, hres[4]

        ; x mod p1 ==  m1
        mov     ecx, 1
        .repeat
        
            invoke  big_mod, lpx, hcrt_primes[ecx*4], hm
            invoke  big_compare, hm, hres[ecx*4]
            .break .if     eax

            dec     ecx
        .until  SIGN?
        
        .if     eax
            mov     _return, FALSE
        .else
            mov     _return, TRUE
        .endif
        
        invoke  big_destroy_array, addr hres, 6

        popad
        mov     eax, _return
        ret
    
    crt_validate    endp

;-----------------------------------------------------------------------