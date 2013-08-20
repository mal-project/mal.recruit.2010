sbutton struct
    Coords  POINT   <>;Coords.x
    ID_UP   dword   ?
    ID_DOWN dword   ?
    ID_OVER dword   ?
    ID_BUTTON   dword   ?
sbutton ends
ImageButton	proto :dword, :dword, :dword
ImageDestroy proto :dword
LoadPng		proto	:dword, :dword, :dword
