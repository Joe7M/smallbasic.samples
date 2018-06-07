const dice = [&
 ["L","N","H","N","Z","R"],&
 ["M","U","O","C","T","I"],&
 ["T","W","O","O","T","A"],&
 ["X","I","D","R","E","L"],&
 ["H","N","U","I","M","Q"],&
 ["B","B","A","O","O","J"],&
 ["W","R","E","T","V","H"],&
 ["T","O","E","S","I","S"],&
 ["E","U","S","E","N","I"],&
 ["W","E","G","N","H","E"],&
 ["K","S","F","F","A","P"],&
 ["O","A","C","S","P","H"],&
 ["T","S","T","I","Y","D"],&
 ["Y","R","D","V","L","E"],&
 ["A","G","A","E","E","N"],&
 ["T","Y","E","L","R","T"]]
'https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle
randomize
dim game(15)
dim grid(15)
for i = 0 to 15
  game(i) = i
next i

w = window():
w.setFont(75, "pt", true, false)

shuffle = rnd*100%10
for count = 0 to shuffle
  for i = 15 to 1 step - 1
    r = rnd * 1000 % i
    j = game(r)
    game(r) = game(i)
    game(i) = j
  next i
  for i = 0 to 15
    r = rnd * 1000 % 6
    grid(i) = dice(game(i))(r)
  next i
  at 0,0
  print
  for i = 0 to 15
    print " "; grid(i); " ";
    if (i == 3 or i == 7 or i = 11) then
      print
    fi
  next i
  delay 100
next count

w.setFont(20, "pt", true, false)
color 1,2
for i = 180 to 1 step - 1
  at 0,0
  ? time; " "; i
  pause 1
next i
pause
