;Don't EDIT ThiS YoU Fucking LameR
;The ScRipT Will NoT WorK Correctly
;AnD We Will FinD YoU,AnD TheN..."Dupe da ti e qko!"

dialog tbox { 
  title "E-Color-Box" 
  size -1 -1 260 250 
  text "Text:", 1, 5 5 120 20
  edit  "", 2, 15 20 230 105, multi
  text "Background Color:", 3, 5 125 120 20
  combo 6, 15 145 230 105, hsbar size drop
  text "Text Color:", 5, 5 167 120 20
  combo 4, 15 187 230 65, hsbar size drop
  button "Say", 100, 70 220 120 20, ok
}
on 1:DIALOG:tbox:init:0:{

  did -a tbox 6 Black
  did -a tbox 6 Dark Blue
  did -a tbox 6 Dark Green
  did -a tbox 6 Red
  did -a tbox 6 Dark Red
  did -a tbox 6 Purple
  did -a tbox 6 Orange
  did -a tbox 6 Yellow
  did -a tbox 6 Green
  did -a tbox 6 Blue-Green
  did -a tbox 6 Light Blue
  did -a tbox 6 Blue
  did -a tbox 6 Pink
  did -a tbox 6 Dark Grey
  did -a tbox 6 Grey
  did -a tbox 4 Black
  did -a tbox 4 White
  did -c tbox 6 4
  did -c tbox 4 1
}
on 1:dialog:tbox:sclick:100:{
  set %w53 $did(2)
  set %color $did(6)
  set %cot $did(4)
  set %lena $calc($len(%w53) + 4)
  set %len $len(%w53)
  if ( %color = Black ) set %color 1
  if ( %color = Dark Blue ) set %color 2
  if ( %color = Dark Green ) set %color 3
  if ( %color = Red ) set %color 4
  if ( %color = Dark Red ) set %color 5
  if ( %color = Purple ) set %color 6
  if ( %color = Orange ) set %color 7
  if ( %color = Yellow ) set %color 8
  if ( %color = Green ) set %color 9
  if ( %color = Blue-Green ) set %color 10
  if ( %color = Light Blue ) set %color 11
  if ( %color = Blue ) set %color 12
  if ( %color = Pink ) set %color 13
  if ( %color = Dark Grey ) set %color 14
  if ( %color = Grey ) set %color 15
  if ( %cot = Black ) set %cot 1
  if ( %cot = White ) set %cot 0

  msg $active  $+ %color $+ , $+ %color $+ $str( ,%lena)
  msg $active  $+ %color $+ , $+ %color $+    $+  $+ %cot $+ , $+ %color $+ %w53 $+  $+ %color $+ , $+ %color $+    $+ 14,14 
  msg $active  $+ %color $+ , $+ %color $+ $str( ,%lena) $+ 14,14 
  msg $active  14,14 $+ $str( ,%lena)
}
alias 3d {
  dialog -md tbox tbox
}
alias F11 /3d
