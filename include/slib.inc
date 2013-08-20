;-----------------------------------------------------------------------
hBIG    typedef HANDLE

;-----------------------------------------------------------------------
big_create	proto :dword                    ;dwValue
big_create_array    proto :dword, :dword    ;ptrArrhBig, dwArrLen
big_var32	proto :dword, :dword            ;ptrBig, dwValue
big_destroy	proto :dword                    ;ptrBig
big_destroy_array   proto   :dword, :dword  ;ptrArrhBig, dwArrLen
big_clear	proto :dword
big_copy	proto :dword, :dword            ;src, dest
big_compare	proto :dword, :dword
big_is_zero	proto

big_cinstr	proto :dword, :dword            ;szHexString, ptrBig
big_cotstr	proto :dword, :dword            ;ptrBig, szBuffer
big_big_to_bytes	proto :dword, :dword
big_bytes_to_big	proto :dword, :dword, :dword
big_rev_bytes	proto :dword, :dword        ;ptrBig, lpBuffer

big_shift	proto :dword, :dword, :dword
big_shl1	proto :dword, :dword
big_shr1	proto :dword, :dword
big_add		proto :dword, :dword, :dword
big_sub		proto :dword, :dword, :dword
big_mul		proto :dword, :dword, :dword
big_div		proto :dword, :dword, :dword, :dword

big_mod		proto :dword, :dword, :dword

big_modmul	proto :dword, :dword, :dword, :dword
big_powmod	proto :dword, :dword, :dword, :dword            ;4=1^2%3
big_xgcd	proto :dword, :dword, :dword, :dword, :dword    ;5=gcd(1,2)

;-----------------------------------------------------------------------
