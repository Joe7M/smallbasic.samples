
'#sec:Main
'' Illuminati.bas
'' 11/08/2005
''The Global Conspiracy
''by Gary Breinholt

''The Illuminati know that true power comes from the subtle application of the Rule of FIW:
''Force Intimidates Influence
''Influence Manipulates Wealth
''Wealth Bribes Force

''Each of these three factions (Force, Influence and Wealth) comprises of two Elements. 
''Control both Elements and you control the Faction.
''The World comprises of nine Regions.
''Exert your power carefully and you will control the Region.
''Claim the most Regions, with the right amount of power, and you will dominate the world.

''But beware: Too much power will overwhelm a Region. This occurs if you control TWO Factions.
''Too much power globally will reveal the Illuminati.

''You and Them will take turms to claim the six Elements, within a Region.
''Tap on an Element to claim it.
''If it is unclaimed it now belongs to you.
''If They beat you to it then Their control is revealed. Your turn is over, but at least you know where They are and maybe can use the information to your benefit.
''Your aim is to claim the Region, according to the Rule of FIW, and to avoid overhwelming Them.

''After all nine Regions have been contested a result is shown.
''Scoring shows the number of Regions held by You and Them and also the amount of Global power:
''1 point per Region + 1 point per overwhelm.
''The Illuminati with the highest score of Regions + Global Power is the winner. Unless the TOTAL Global Power is too high!


5 cls: dim world(9,2): dim you(6): dim them(6): dim ykno(6): dim tkno(6): dim states(6): you=0: them=0: anac=0: over=0: them1=0: you1=0
dim type(3): dim fact(6)

restore type: for x=0 to 3: read type(x): next

restore fact: for x=1 to 6: read fact(x): next

restore world: for x=1 to 9: read world(x,0):world(x,2)=" ": next x

label start
ply=0: repeat: ply++: 

label begin
 for x=1 to 6: ykno(x)=" ": tkno(x)=" ": states(x)=" ": next: count=0: nth=0: w=0

13 x=fix(rnd*6): if x<4 then x=1 else x=2
on x goto 20,50

20   if count=6 then goto fiw
if nth=0 then z=fix(rnd*6) else z=nth
if tkno(z)<>" " and w=1 then gosub reck: goto 20
if tkno(z)<>" " then  nth=0: goto 20
if states(z)=" " then states(z)="Them": tkno(z)=states(z):count++:gosub reck

if states(z)="You" and tkno(z)=" " then tkno(z)=states(z):  nth=z: if count=1 then gosub 99 else if count=2 then gosub 102 else gosub reck
'':if w=1 then gosub reck else


50 if count=6 then goto fiw
gosub grid
gosub pick
goto 20

label pick
122 pen on: while pen(0)=0: delay 50:
 wend: 
p4=pen(4): p5=pen(5): pen off
if p4<5 or p4>155 or p5<98 or p5>155 then goto 122

z=3
if p4<50 then z=1
 if p4>95 then z=5
if p5>125 then z++

locate 9,1:
if ykno(z)<>" "  then ? "Try Again": pause 1: cls:gosub grid: goto pick
if states(z)=" " then states(z)="You": ykno(z)=states(z):count++
if states(z)="Them" and ykno(z)=" " then ykno(z)=states(z)
print fact(z);" ";type(fix(z/2));": ";ykno(z)
pause 1:return


label fiw
for x=1 to 6: ykno(x)=states(x): next
cls: gosub 100: 
f=len(states(1))+len(states(2))-5
i=len(states(3))+len(states(4))-5
w=len(states(5))+len(states(6))-5
locate 3,1
x=f+i+w: if x=6 or (x-max(f,i,w)=3) or (x-min(f,i,w)=5) then goto 96
 print "Too much Power has been exerted:": world(ply,2)=" **" 
if x<6 then print "You overwhelmed Them": over++: world(ply,1)="You Control": you=you+3: you1++: goto fini
if x>6 then print "They overwhelmed You": over++: world(ply,1)="They Control": them=them+3:them1++: goto fini

96 if x=6 and min(f,i,w)=2 then world(ply,1)= "Anarchy reins":print world(ply,1):anac++:  goto fini

act1=2: if f=1 then act1=1: 
if w=1 then act1=3
if x=7 then act1=0
print "You control ";type(act1)
act2=2: if f=3 then act2=1: 
if w=3 then act2=3
if x=5 then act2=0
print "They control ";type(act2)

if (act1=act2-1 and act1>0) or (act1=3 and act2=1) or act2=0 then goto youwin
win=act2:them=them+2: if act1=0 then print else gosub actions :print act:them--: 
 print "Therefore They win": them1++: world(ply,1)="They Control ": goto fini

label youwin
win=act1: you=you+2: if act2=0 then print else gosub actions : print act: you--
print "Therefore You win":  you1++: world(ply,1)="You Control ": goto fini

 label fini
print:
 print world(ply,1);" ";world(ply,0)
pause 5:cls : until ply=9

cls: print :for x=1 to 9: print world(x,0),world(x,1);world(x,2): next x: print
print "You: ";you1;"/";you,"Them: ";them1;"/";them
locate 14,5
if anac>=max(you1,them1) then print "Anarchy Rules The World!";: goto 95
''if you+them>13 
if over>4 then print "The Illuminati Are Exposed!";: goto 95
if you1+you>them1+them  then print "The World Belongs To You!";:goto 95
if you1+you<them1+them  then print "The World Belongs To Them!";:goto 95
 print "The Struggle is not over!";

95 pause:cls: goto 5

label actions
restore action: For x=1 to win: read act:next win
return

label action
data "Force Intimidates Influence", "Influence Manipulates Wealth", "Wealth Bribes Force"

label grid
cls
?:?: print "Select a Faction to control"
print: print "Force:          Legal, Illegal"
 print "Influence:   Social, Media"
 print "Wealth:       Industrial, Government"

100 locate 1,1 : print world (ply,0): print
rect 5,100,50,125: at 10,100: print "Legal":  at 10,112 :print "(";ykno(1);")"
rect 50,100,95,125: at 60,100: print "Social":  at 60,112 :print "(";ykno(3);")"
 rect 95,100,155,125: at 105,100: print "Industrial":
 at 105,112 :print "(";ykno(5);")"
 rect 5,125,50,155: at 10,130: print "Illegal":  at 10,142 :print "(";ykno(2);")"
rect 50,125,95,155: at 60,130: print "Media":  at 60,142 :print "(";ykno(4);")"
 rect 95,125,155,155: at 100,130: print "Government":  at 105,142 :print "(";ykno(6);")"
return

label reck
if frac(z/2)=0 then nth=z-1 else nth=z+1
if tkno(nth)="Them" or w=1 then nth=nth-fix(rnd*2):w=1: if frac(z/2)>0 then nth--
if nth<1 then nth=nth+6
''if w=1 then goto 99
 if tkno(nth)="You" then nth=nth+fix(rnd*2): if frac(z/2)>0 then nth++
if nth>6 then nth=nth-6
''if tkno(nth)<>" " then z=nth: goto reck
return

99 if tkno(nth)="You" then nth=nth-fix(rnd*2): if frac(z/2)>0 then nth--
if nth<1 then nth=nth+6
return

102  if tkno(nth)="You" then nth=nth+fix(rnd*2): if frac(z/2)>0 then nth++
if nth>6 then nth=nth-6
return

label world
data "N. America: ","S. America: ","Europe: ","Africa:   ","Russia:   ","Middle East: ","North Asia: ","South Asia: ","Australia: ",

label type
data "nothing","Force", "Influence", "Wealth"

label fact
data "Legal","Illegal","Social","Media","Industrial","Government"'
