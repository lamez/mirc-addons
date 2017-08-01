;Clone System v3.0 by ShakE
;Run clones, this may help you full your channel
;All Copyrights reserved!
;For more addons visit http://xsoft.hit.bg
;For questions and bugs mailto: shake@haho.org

on *:load:{
  /set %cclonez 0
  /set %randnicks on
  /echo -a Clone System v3.0 by ShakE
  /echo -a More addons at http://xsoft.hit.bg
  /echo -a For Contacts: shake@haho.org
}
;=========
;cl0n3z and Clonez :)
alias clone { 
  if ($dialog(clonez) == $null) {
    /dialog -md clonez clonez
  }
  else { /echo -a 4Clone Manager is allready Open! }
}

alias botwrite {
  sockwrite -n clone.* $1-
}
alias randcon {
  :start
  set %bot.nick $read $scriptdirnicks.lst
  set %bot.rand clone. $+ %bot.nick
  if ( $sock(%bot.rand).name !== $null ) { goto start }
  else { sockopen %bot.rand %rcdata | halt }
}
alias asstarget { 
  if ($left($gettok(%temp,3,32),1) == $chr(35)) {  return $gettok(%temp,3,32)  }
  else { return $remove( $gettok($gettok(%temp,1,$asc(!)),1,32), $chr(58) ) }
}

on *:SOCKOPEN:%bot.rand:{
  sockwrite -n $sockname user Xsoft " $+ $ip $+ " " $+ %rcserver $+ " :Xsoft CloneSystem - http://xsoft.hit.bg
  sockwrite -n $sockname nick %bot.nick
  inc %cclonez
  if ( $dialog(clonez) !== $null) { /did -r clonez 41 | /did -a clonez 41 %cclonez }
}
on *:sockclose:clone.*:{
  /set %cclonez $calc(%cclonez - 1)
  if ( $dialog(clonez) !== $null) { /did -r clonez 41 | /did -a clonez 41 %cclonez }
}
on 1:sockread:clone.*:{
  if ($sockerr > 0) return
  sockread %temp
  if ($sockbr == 0) return
  if ($gettok(%temp,1,32) == PING) { sockwrite -tn $sockname PONG : $+ $gettok(%temp,2,58) }
  if ($gettok(%temp,4,32) == :VERSION) { sockwrite -tn $sockname notice $asstarget :VERSION Xsoft Clone System - http://xsoft.hit.bg $+  }
  if ($dialog(clonez) !== $null) {
    inc %clonez.lines 1
    did -i clonez 2 %clonez.lines %temp
  }
}


;=
dialog cl0n3z {
  size -1 -1 115 147
  title "cl0n3z manager"
  option type dbu

  box "cl0n3z",1000,5 5 105 55
  text "NickName:",1001,10 15 25 10
  edit "",1002,35 13 70 10,autohs
  text "Server:",1003,10 30 25 10
  edit "",1004,35 28 70 10,autohs
  text "Port:",1005,10 45 25 10
  edit "",1006,35 43 70 10,autohs
  box "Flo0d3rz",1245,5 65 105 55
  check "Random Nicks",123,15 76 70 10,right
  text "How many clones:",755, 10 95 50 10
  edit "5", 45, 55 93 20 10, autohs
  button "Connect!",2992,20 125 30 15
  button "Close",2993,70 125 30 15,cancel
}
on 1:dialog:cl0n3z:sclick:*:{
  if ($did == 123) {
    if (%randnicks == off) { /set %randnicks on }
    elseif (%randnicks == on) { /set %randnicks off }
  }
  if ($did == 2992) {
    if (%randnicks == off) {
      set %bot.nick $did(1002).text
      set %bot.rand clone. $+ $rand(0,99999)
      sockopen %bot.rand $did(1004).text $did(1006).text 
    }
    elseif (%randnicks == on) {
      /set %rcdata $did(1004).text $did(1006).text
      //.timerconnectclonez $did(45) 2 /randcon
    }
    set %rcserver $did(1004)
    set %rcport $did(1006)
  }
}

on 1:DIALOG:cl0n3z:init:0: {
  if (%randnicks == on) /did -c cl0n3z 123
  if (%randnicks == off) /did -f cl0n3z 123
  did -a cl0n3z 1004 %rcserver
  did -a cl0n3z 1006 %rcport
}


;=============

; Dialogs [GUI]

dialog clonez {
  title "Clone Manager"
  size -1 -1 210 150
  option dbu

  box "ShakE cl0n3z", 1, 5 5, 200 75,

  edit "", 2, 8 15, 194 62, read multi return vsbar
  edit "", 3, 5 83, 200 11, 

  button "Send", 4, 10 96, 40 12, default
  button "Run Clone", 5, 60 96, 40 12, 
  button "Quit Clones", 6, 110 96, 40 12, ok 
  button "Clear Screen", 7, 160 96, 40 12,
  text "Clones:",1005,10 121 20 10
  edit "0", 41, 30 120 20 10, read multi return 
  button "Close", 1964, 148 126, 60 22, ok
}

; Dialogs [Events]

on 1:dialog:clonez:init:*:{
  set %clonez.lines 0
  did -f clonez 3
  did -r clonez 41
  did -a clonez 41 %cclonez
}

on 1:dialog:clonez:sclick:*:{
  if $did == 4 {
    inc %clonez.lines 1
    did -i clonez 2 %clonez.lines Command: $did(3).text
    sockwrite -n clone.* $did(3).text 
    did -r clonez 3
  }

  if $did == 7 { set %clonez.lines 0 | did -r clonez 2 }
  if $did == 5 { /dialog -md cl0n3z cl0n3z }
  if $did == 6 { /sockclose clone.* | /set %cclonez 0 |   /did -ra clonez 41 %cclonez }
}

;============================
