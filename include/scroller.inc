; xscroll library by the asphyxia's motherfucker
xscroll_init		proto :dword
xscroll_display 	proto :dword

SCROLL_DIR_TOP		equ	-1
SCROLL_DIR_BOTTOM	equ	1

sscroll_headers	struct
	show			dword	?;TRUE if header must be draw
	hfont			dword	?;font for header title and footer
	lpheader		dword	?;ptr to string for header
	lpfooter		dword	?;ptr to string for footer
sscroll_headers	ends

sscroll_pages	struct
	_enabled		byte	?;TRUE if pages are enabled
	_count			dword	?;number of pages?
	_pauses			dword	?;unknown(!)
	_offset			dword	?;offset where to pause the scroll (in window coordinates)
	_paused			dword	?;start value
	_interval		dword	?;pause interval
sscroll_pages	ends

sscroll			struct
	; public
	lpData			dword		?;ptr to scroller string/s
	wWidth			word		?;width of scroller window
	wHeight		 	word		?;height of scroller window
	hFont		    dword	    ?;handler of scroller font
	Color	 		dword		?;color for drawing header frames etc
	BkColor	 		dword		?;color for background
	Speed			dword		?;speed of scroller movement
	Pagin			dword		?;ptr to sscroll_page struct or null
	Direction		dword		?;start direction of scroller (SCROLL_DIR_TOP or SCROLL_DIR_BOTTOM)
	Autoscroll		dword		?;TRUE if scroll moves alone or FALSE if otherwise
	Headers			sscroll_headers	<>;header structure
sscroll			ends