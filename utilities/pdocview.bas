
'#!/usr/local/bin/sbasic -q
''
''	PDOC Viewer - script for Unix
''

'' lines per page
const lpp=int(ymax/txth("Q"))

'' chars per line
const cpl=int(xmax/txtw("Q"))

'' ------------------------
sub usage(x,y)
	if x=2 then ? y; " file not found"
	? "Usage: pdocview filename"
	stop 1
end
'' ------------------------
Def Q(msg)
Local ans

	Q=False

	PRINT cat(3);cmd(0);": ";msg;" (any/n/q)...";cat(0);
	REPEAT
		ans=INKEY$
	UNTIL ans<>""
	PRINT
	IF INSTR("NnQq",ans) THEN Q=True
End
'' ------------------------
'' replaces tabs with spaces
func reptab(s,tabsize)
local ret, idx, r, l
local sc

ret=s
repeat
	idx=instr(ret, chr(9))
	if idx
		sc=idx mod tabsize
		if sc=0
			sc=tabsize
		else
			sc=tabsize-sc
		fi
		l=leftof(ret,chr(9))
		r=rightof(ret,chr(9))
		ret=l+space(sc)+r
	fi
until idx=0
reptab=ret
end
'' ------------------------
Sub typearray(byref lines())
Local l,f,j,cont,brk
Local tcpl

l=1:j=1
j=1
tcpl=cpl-5
brk=false
FOR f IN lines
	f=reptab(f,4)

	REPEAT
       	IF j MOD lpp = 0 THEN
			IF Q("More") THEN
				brk=true
				EXIT
			fi
        ENDIF
		cont = LEN(f)>tcpl
        IF cont THEN
			f1 = LEFT$(f,tcpl)
            f = MID$(f,tcpl+1)
        ELSE
			f1 = f
		ENDIF
		PRINT USING "##,##0:";l;
		PRINT TAB(9);f1
		j = j + 1
	UNTIL cont=0
	IF brk THEN EXIT
	l=l+1
NEXT
End
'' ------------------------

cls

? "PDOC Viewer"
? "Copyright (c) 2001, Nicholas Christopoulos"
?

split command, " ", cmd
if empty(cmd) then usage 1, ""
if not exist(cmd(0)) then usage 2, cmd(0)

ftmp=cmd(0)+".pdoc"
copy cmd(0), ftmp

tload "pdoc:"+leftoflast(ftmp,"."), A
typearray A
kill ftmp
'
