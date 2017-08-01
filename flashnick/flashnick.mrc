;FlashNick v1.0 by ShakE
;Make your nick look cool on the nicklist
;All Copyrights reserved!
;For more addons visit http://xsoft.hit.bg
;For questions and bugs mailto: shake@haho.org

on *:load:{
 /echo -a Flash Nick v1.0 by ShakE
 /echo -a Usage: /flashnick
 /echo -a More addons at http://xsoft.hit.bg
}
on *:join:#:{
  if ($nick == $me) { /colorme $chan }
}
on *:part:#:{
  if ($nick == $me) { //.timerflashnick. $+ $chan off }
}
on *:kick:#:{
  if ($knick == $me) { //.timerflashnick. $+ $chan off }
}
alias colorme {
  //.timerflashnick. $+ $1 0 1 /clrme $1
}
alias clrme if (%scr.colorme == on) { /cline $rand(0,15) $1 $nick($1,$me) }
alias flashnick {
  if ( $?!="FlashNick ON/OFF" == $true ) { /set %scr.colorme on }
  else { /set %scr.colorme off }
}
menu menubar {
 FlashNick:/flashnick
}
