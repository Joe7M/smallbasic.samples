
''' Betrayal.bas
'' 21/12/2005
'' Negotiation and betrayal in a democratic society
'' By Gary Breinholt

''The Rule of FIW states:
''Force intimidates Influence
''Influence manipulates Wealth
''Wealth bribes Force

''The six houses of Corvidea vie to attain ultimate politic power. I.e. a score of 6 in ''each of the three power strata (Force, Influence, Wealth)
''You start the game with a TOTAL power of 15 points, spread randomly across ''the three strata.

''The game is played in turns. Each turn represents one season.
''Spring, Summer and Autumn are negotiation rounds. Winter is a time of contest.

''The Report screen shows your current power structure and limited information on ''each of the other houses.
''By negotiation you must find out the power structures of the other houses - to ''give you the best chance of success during the Winter contests.

''Relations
''What they think of you (what you think of them is up to you). 
''The states, worst to best are: Enemy - Distrusts - Neutral - Trusts - Ally.
''Houses that like you are more likely to deal with you, less likely to betray you ''and less likely to attack you during the contests

''Press any button, or tap graffitti, to proceed.

''Negotiation Rounds
''Each season you may make up to three proposals and will receive any number ''from the other houses. The proposal screen, visible during your turn, has three ''options:
''Negotiate - To offer a proposal to another house
''Retire - To remove yourself from the fray. You may neither make nor recieve any ''more proposals for the remainder of the current season.
''Report - To view the report screen again

''Negotiation
''Tap on a house to negotiate with. You may now:
''Improve Relationship - If accepted this proposal will improve their view of you by ''two steps.It is easier to improve an already good relationship i.e From Trust to ''Ally - but the gain is less.
''Swap Intelligence - This is the proposal of betrayal! 

''Betryal
''This screens appears when either you make a proposal to another house or ''another house approaches you.
''You must select a house to betray (you will give your information on this house ''to the one you are dealing with) and select a house that you wish to know about ''(the dealing house will give you their information on the house selected).
''REFUSING to betray a house will prove your trustworthiness and your ''relationship with that house will improve by one step.
''You might also see a change in relationship due to:
''You betray house A to house B - House A will like you less.
''House A betrays house B to you - House B fears your knowledge and will like ''you more (Finlandisation of sorts?)

''Contests
''During the contest season (Winter) you get to MAKE one attack against another ''house. Any number of houses might attack you (depending on your relationship ''and how close you are to winning).
''Prior to your attack the report screen will appear. Tap to clear.
''Select the house you wish to attack.

''Details of your power structure appears at the top of the screen.
''Their power structure (as far as you know) is displayed below.
''Following the Rule of FIW: 
''You will win if you attack using Force and they attack using Influence. 
''Your Influence will increase by one point (to a maximum of 6), their''s will ''decrease (to a minimum of 1)
''They will win if they attack using Wealth. Your Force will decrease, their''s will ''increase. Again by one point.
''Use your knowledge of their power structure to determine WHICH strata they ''need, and are likely to contest for.
''Tap the Strata YOU wish to attack with, on your power structure grid.

''The first house to achieve a score of six in each element is the winner.


label start
cls: 
?: ? ,"BETRAYAL"
?: ?"  Negotiate, negotiate, negotiate,"
? "  Propose, propose, propose"
?
? "     Remember the Rule of FIW:"
? "  Force Intimidates Influence"
? "  Influence Manipulates Wealth"
? "  Wealth Bribes Force"
pause 20: cls
siz=1+(xmax>300) 

label setup
dim rel(6,6): dim power(6,3): dim say(6): dim fact(6): dim act(3): dim order(6): dim 

zone(6)
dim feel(5): dim type(3): dim seas(4)
win=0

restore facts: y=1: you=fix(rnd*6):
for x=1 to 6: read fact(x),say(x): if x<>you then zone(y)=fact(x): y++
for u=1 to 6: rel(x,u)=3: next u
for z=1 to 3: power(x,z)=3: next z
power(x,0)=15
 next x
 Restore acts: for z=1 to 3: read act(z): read type(z): next z
for z=1 to 5: read feel(z): next z
for z=1 to 4: read seas(z): next z

year=1900+fix(rnd*150): yend=7

label begin
ss=1: year++: yend--: if yend=0 then goto win
 dim kno(6,6,3): 
for x=1 to 6: for z=1 to 3: power(x,z)=0: next z
z=power(x,0)
while z>0: w=fix (rnd*3):  if power(x,w)<6 then power(x,w)=power(x,w)+1 : z--
wend: 
power(x,0)=sum(power(x,1),power(x,2),power(x,3)): next x
for x=1 to 6: for y=1 to 6: z=fix(rnd*3):kno(x,y,z)=power(y,z): next y: next x

 while ss<4

dim order(6): rt=0
orders=1: while orders<7
10 y=fix(rnd*6): if order(y)>0 then goto 10
order(y)=orders: orders++:wend

gosub 56
for go=1 to 6: CP=order(go):
gosub you:
if CP=you then gosub play: goto 39

''AI routines
vp1=0: vp2=0
 bt=0: prop=3: while prop>0
tar=0: dp=0:  goto 59 :for t=1 to 6
if rel(order(t),cp)=1 then dp=order(t):tar=1
next t: if tar=1 and dp<>you then goto 61

59  dp=fix(rnd*6): if dp=cp then goto 59 

61 if dp=you and rt=1 then goto 59
if (rel(dp,cp)>2 and fix(rnd*6)<6) or (rel(dp,cp)=5) or (dp=you) then gosub 70: goto 

72

if fix(rnd*6)<=rel(DP,cp) then rel(DP,cp)=min(rel(DP,cp)+2,5)

72 prop--: wend

39 cls: next go: 
ss++: wend: goto part2

70 ''swap
cp1=dp: 
gosub 68
gosub 69
goto 89

68 gosub AI: vp1=dp: if vp1=cp or vp1=cp1 then goto 68 
return

69 cp3=cp: cp=cp1
85 gosub AI: vp2=dp: if cp=you then cp1=cp3: w=1: vp3=vp1: gosub 141 

:vp2=vp1 :vp1=vp3: cp1=cp 
if vp2=cp or vp2=cp3 then goto 85
return
 
89 cp=cp3: dp=cp1: ?

 if cp=you then w=vp2: goto bet
if (rel(cp,vp2)>fix(rnd*6) and rel(cp,dp)<=fix(rnd*6)) then goto 73
 if dp=you then w=vp1: goto bet
96 if (rel(dp,vp1)>fix(rnd*6) and rel(dp,cp)<=fix(rnd*6)) then goto 74

 93 if cp=you or dp=you then  ? "Deal!": delay 1000
goto dial:

73 rel(vP2,cp)=min(rel(vP2,cp)+1,5)
 if fix(rnd*6)>rel(vP2,dp) then rel(vP2,dp)=max(rel(vP2,dp)-1,1)
x=cp: goto 102
74 rel(vP1,dp)=min(rel(vP1,dp)+1,5)
 if fix(rnd*6)>rel(vP1,cp) then rel(vP1,cp)=max(rel(vP1,cp)-1,1)
x=dp
102 if cp=you or dp=you then ? fact(x);" refused!": delay 1000
return

label bet
if bt=1 then goto 96
 z=5: y=1*siz: p=0: gosub zones: ? 
 rect 5*siz,105*siz,30*siz,130*siz: at 10*siz,110*siz: print "Yes":

 rect 40*siz,105*siz,65*siz,130*siz: at 47*siz,110*siz: print "No":  
locate 7,1: ? "Betray ";fact(w);"?"
153 gosub tap
if p5<105*siz or p5>130*siz or p4<5 or p4>130*siz then goto 153
z=0: repeat: z++: until p4<((z*25)+5)*siz
if z=1 and dp=you then goto 93 
if z=1 and cp=you then goto 96 
  if cp=you then goto 73 else goto 74
return


label play
prop=3: while prop>0
cls: gosub recgrid:locate 9,1: ? "You have ";prop;" proposals left"
gosub recgrid2

gosub pick1: if turn=1 then goto 49 else on z gosub 52,54,56: turn=0
49 wend: return

52 z=5: y=1*siz: p=0: gosub zones: ? "Negotiate with?"
gosub pick: if turn=1 then return
DP=len(zone(z))-2: gosub negotiate
prop--:return 

54 locate 11,1: print  "Your Diplomats retire"
prop=0: rt=1
goto 117

56 cls: 
locate 3,0:  print ,,"For","Inf","Wea"
 print squeeze(fact(you));" (";power(you,0);") ": locate 2,14
? power(you,1),power(you,2),power(you,3):?
z=4
for x=1 to 6: if x=you then goto 91
print squeeze(fact(x));" (";power(x,0);")" :locate z,14
if  kno(you,x,1)=0 then ? "-", else ? kno(you,x,1),
if  kno(you,x,2)=0 then ? "-", else ? kno(you,x,2),
if  kno(you,x,3)=0 then ? "-" else ? kno(you,x,3)
z=z+2
 print " (";feel(rel(x,you));")" 
91 next x : if win=1 then return else locate 14,15+siz: ? seas(ss);"  Year 

";7-yend;: pause: cls: return
for x=1 to 6: 
cls: ? fact(x):for y=1 to 6 : ? fact(y),rel(x,y)
next y: pause: next x:cls: return

label negotiate
gosub recgrid: locate 8,1: ? "Negotiating with": ? fact(DP);" 

(";feel(rel(DP,you));")": 

 rect 5*siz,125*siz,60*siz,155*siz: at 7*siz,130*siz: print "Improve":  at 

7*siz,142*siz :print "Relationship"

 rect 95*siz,125*siz,150*siz,155*siz: at 100*siz,130*siz: print "Swap":  at 

100*siz,142*siz :print "Intelligence"
locate 10,1
gosub pick2: on z goto 113,114,115


113 if rel(DP,you)=5 then print "This is not necessary": prop++: goto 117
if fix(rnd*6)>rel(DP,you) then  print "No change in relations" else  print "your 

relations improve": rel(DP,you)=min(rel(DP,you)+2,5) 
117 pause 1: return

114 ''dummy line
115 cp1=dp: w=fix(rnd*2): cp3=cp: bt=0
 if w=1 then gosub 69 else gosub 141
gosub 141: goto 89
141 cls: gosub you
 z=5: y=1*siz: p=0: gosub zones: 
 ? "Negotiating with ": ? fact(cp1): ?
 if w=2 then goto 157
? "Who do you want": ?"to know about?"
gosub pick: if turn=1 then goto 141
vp1=len(zone(z))-2: 
if vp1=cp3 or vp1=cp1 then goto 141
return

157 ? "Who will you betray?": bt=1
gosub pick: if turn=1 then goto 141
vp2=len(zone(z))-2: 
if vp2=cp1 or vp2=cp3 then goto 141
w=1: return

label dial
for x=1 to 3: if kno(cp,vp1,x)=0 then kno(cp,vp1,x)=kno(dp,vp1,x)
if kno(dp,vp2,x)=0 then kno(dp,vp2,x)=kno(cp,vp2,x)
next x

 if fix(rnd*6)<=rel(dp,vp2) and fix(rnd*6)>=rel(dp,cp) then 

rel(vP2,cp)=max(rel(vP2,cp)-1,1):if fix(rnd*6)<rel(vp2,dp) then 

rel(vP2,dp)=min(rel(vP2,dp)+1,5)

 if fix(rnd*6)<=rel(cp,vp1) and fix(rnd*6)>=rel(cp,dp) then 

rel(vP1,dp)=max(rel(vP1,dp)-1,1):if fix(rnd*6)<rel(vp1,cp) then 

rel(vP1,cp)=min(rel(vP1,cp)+1,5)
return


label recgrid
cls
rect 5*siz,40*siz,50*siz,65*siz: at 10*siz,42*siz: print "Force":  at 15*siz,52*siz 

:print "(";power(you,1);")"
rect 50*siz,40*siz,95*siz,65*siz: at 55*siz,42*siz: print "Influence":  at 

65*siz,52*siz :print "(";power(you,2);")"
 rect 95*siz,40*siz,140*siz,65*siz: at 105*siz,42*siz: print "Wealth": at 

110*siz,52*siz :print "(";power(you,3);")"

label you
 locate 2,1: print cat(2);fact(you);cat(-2): print seas(ss);"  ";year;" - Year 

";7-yend:print
return

label recgrid2
 rect 5*siz,125*siz,50*siz,155*siz: at 7*siz,130*siz: print "Negotiate": 
rect 50*siz,125*siz,95*siz,155*siz: at 60*siz,130*siz: print "Retire": 
 rect 95*siz,125*siz,140*siz,155*siz: at 100*siz,130*siz: print "Report": 
return

label them
 locate 11,1: print squeeze(fact(them));" (";power(them,0);"): ";feel(rel(them,you)): 
 rect 5*siz,125*siz,50*siz,155*siz: at 10*siz,130*siz: print "Force":  at 

15*siz,142*siz :print "(";kno(you,them,1);")"
rect 50*siz,125*siz,95*siz,155*siz: at 55*siz,130*siz: print "Influence":  at 

65*siz,142*siz :print "(";kno(you,them,2);")"
 rect 95*siz,125*siz,140*siz,155*siz: at 105*siz,130*siz: print "Wealth":  at 

110*siz,142*siz :print "(";kno(you,them,3);")"
return

label zones
cls: gosub you: 
for x=1 to 5: n=len(zone(x))-2
at 102*siz,y+(1*siz): print fact(n);" ";"(";power(n,0);")": at 110*siz,y+(12*siz): print 

"(";feel(rel(n,you));")"
y=y+(25*siz): next x

label grid
x=1*siz: for n=1 to z
rect 98*siz,x,158*siz,x+(23*siz)
x=x+(25*siz)
next: locate 6,1
 return

label pick1
122 gosub tap
if p5<125*siz or p5>155*siz or p4<5 or p4>155*siz then goto 122
z=0: repeat: z++: until p4<((z*45)+5)*siz
return

label pick2
126 gosub tap
if p5<125*siz or p5>155*siz or p4<5 or p4>155*siz then goto 126
z=0: repeat: z++: until p4<((z*50)+5)*siz: if z=2 then goto 126
return

label pick
124 gosub tap
if p4<98*siz or p4>159*siz or p5<1 or p5>(z*25)*siz then turn=1: return
z=0: repeat: z++: until p5<(z*25)*siz
return

label tap
PEN ON: REPEAT : DELAY 25 : UNTIL PEN(0)
  WHILE PEN(3) : DELAY 25 : WEND
p4=pen(4): p5=pen(5): pen off: return

label facts
data "Jay","Who do you wish to know about? ","Rook","Who will you betray? 

","Raven","Tell us about ","Magpie","We''ll tell you about ","Jackdaw","We won''t 

betray ","Chough  ","You refuse to betray "

label acts
data "Force Intimidates Influence", "Force","Influence Manipulates 

Wealth","Influence","Wealth Bribes Force","Wealth"

label feel
data "Enemy!","Distrusts","Neutral","Trusts","Ally?"

label seasons
data "Spring","Summer","Autumn","Winter"

label part2
cls: locate 9,6: ? "Let The Contests Begin.." : pause 2
for go=1 to 6:  cp=order(go)
181 gosub AI
182 z=dp: y=cp: if fix(rnd*6)=1 then gosub dpai else gosub cpai
act2=tar
if cp=you then goto 204: 
180 z=cp:y=dp: if fix(rnd*6)=6 then gosub dpai else gosub cpai
act1=tar
if dp=you then cls: gosub recgrid: locate 9,1:print fact(cp);" challenges you": 

them=cp: goto 19
goto 200

204 gosub 56: z=5: y=1*siz: p=0: gosub zones: ? "Contest with?"
gosub pick: if turn=1 then turn=0: goto 204
gosub recgrid: DP=len(zone(z))-2: them=dp:

19 gosub them:  locate 7,9: ?" Pick your Attack ":   

191 gosub tap
if p4<5*siz or p4>140*siz or p5<40*siz or p5>65*siz then goto 191
z=0: repeat: z++: until p4<((z*45)+5)*siz:  cls: 
if cp=you then act1=z else act2=z

200 cls: gosub you: print: rel(dp, cp)=max(rel(dp,cp)-2,1)
print fact(cp);" chooses ";type(act1)
print fact(dp);" chooses ";type(act2)
print
if act1=act2 then print "A draw!": goto fini
if act1=act2-1 or (act1=3 and act2=1) then goto youwin

print act(act2):print fact(dp);" wins"
 rel(cp,dp)=max(rel(cp,dp)-1,1)
if power(dp,act1)<6 then 

power(dp,act1)=power(dp,act1)+1:power(cp,act1)=max(power(cp,act1)-1,1):
 goto fini

label youwin
print act(act1): print fact(cp);" wins"
rel(dp,cp)=max(rel(dp,cp)-1,1)
if power(cp,act2)<6 then 

power(cp,act2)=power(cp,act2)+1:power(dp,act2)=max(power(dp,act2)-1,1): 
 goto fini

 label fini
pause 2 : 
for x=1 to 6: for z=1 to 3
if kno(x,cp,z)>0 then kno(x,cp,z)=power(cp,z)
if kno(x,dp,z)>0 then kno(x,dp,z)=power(dp,z)
 next z:next x
power(dp,0)=sum(power(dp,1),power(dp,2),power(dp,3))
power(cp,0)=sum(power(cp,1),power(cp,2),power(cp,3)): if power(cp,0)=18 or 

power(dp,0)=18 then goto win
next go: erase order: ''erase kno
goto begin

label win
if power(dp,0)=18 then cp=dp
for x=1 to 6: for y=1 to 3
kno(you,x,y)=power(x,y): next y: next x: win=1 :gosub 56
locate 13,16:  if yend=0 then goto 263 
? squeeze(fact(cp));" has gained": locate 14,16: ? "Ultimate Power!";: if yend>3 

then x=1 else x=2
goto 264
263  ? "The Illuminati" :locate 14,16: ? "have seized control!";: x=3
264 pause: cls: locate 5,1: on x gosub 329,330,331  : pause: goto start

329 ?: ? ,"CONGRATULATIONS!"
?: ?"    The Illuminati honour ";fact(cp)
? "    for achieving total domination"
? "    within three years."
return

330 ?: ? ,"WELL DONE"
?: ?"    The Illuminati praise ";fact(cp)
? "    for achieving total domination"
? "    within six years."
return

331  ?: ? ,"TOUGH LUCK..."
?: ?"    The Illuminati condem the"
? "    six factions of The Corvidea,"
? "    for failing to achieve total"
? "    domination within six years."
?: ?,"YOU ALL LOOSE!"
return

label AI
tar=0: for t=6 to 1: 
if (rel(cp,order(t))=1 or power(order(t),0)=17) and order(t)<>cp then 

dp=order(t):tar=1
next t: if tar=1 then goto 220
218  dp=fix(rnd*6): tar=1
 if dp=cp or rel(cp,dp)>=fix(rnd*6) then tar=0: goto 218
220 return

 label cpai
237 tar=0: x=fix(rnd*3): y=x-1: if y=0 then y=3
if power(z,x)<= power(z,y) and power(z,x)<6 then tar=y else goto 237
return

 label cpai1
x=min(power(cp,1),power(cp,2),power(cp,3))
if power(cp,1)=x and power(cp,3)>x then tar=3
if power(cp,2)=x and power(cp,1)>x then tar=1 else  tar=fix(rnd*3)
return

label dpai
x=max(kno(z,y,1),kno(z,y,2),kno(z,y,3))
if kno(z,y,1)=x then tar=3
if kno(z,y,2)=x then tar=1 else tar=2
return'
