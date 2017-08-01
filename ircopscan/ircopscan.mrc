;IRCop Scanner v3.0 by ShakE
;This is one simple IRCop Scanner
;All Copyrights reserved!
;For more addons visit http://xsoft.hit.bg
;For questions and bugs mailto: shake@haho.org

on *:load:{
 /echo -a IRCop Scanner by ShakE
 /echo -a Usage: /scanops or F7
 /echo -a More addons at http://xsoft.hit.bg
}
;===========================
;IRCop Scanner

alias scanops {
  if ($server == $null) { /echo -a 4You are not connected to server!!! | halt }
  if ($active !== $chan) { /echo -a 4You are not on channel! | halt }
  /scani
}
alias stats_o  { /echo -a 0per              Host              Nick           Privs           Class | //.quote stats o }
alias total {
  set %totalchan # 
  echo -t %totalchan *** Total People In  $+ #  $+ : ( $+ $nick(#,0) $+ )  | unset %totalchan
}
alias ttotal {
  set %totalchan # 
  msg %totalchan *** Total People In  $+ #  $+ : ( $+ $nick(#,0) $+ )  | unset %totalchan
}
alias scani { 
  %iscanwin = # | set %ircopers 0 | set %msgtype echo
  echo %iscanwin ¤ Irc0p Scan Report
  echo %iscanwin *** Scanning Users In: $+  %iscanwin $+  | .enable #opscan | who # 
}
alias tscani { 
  %iscanwin = # | set %ircopers 0 | set %msgtype say
  msg %iscanwin ¤ Irc0p Scan Report
  msg %iscanwin *** Scanning Users In: $+  %iscanwin $+  | .enable #opscan | who #
}
alias f7 /scanops

#opscan off
raw 352:* {
  if ($chr(42) isin $7) {
    if (%msgtype == echo) { echo  %iscanwin *** Irc0p: 4*7 $+ $6 $+ !7 $+ $3 $+ @7 $+ $4  }
    if (%msgtype == say) { inc %stimer 1 | .timer 1 %stimer msg %iscanwin *** Irc0p: ( $+ $6 $+ ! $+ $3 $+ @ $+ $4 $+ ) }
    inc %ircopers 1
  }
  halt
}
raw 315:* {
  .disable #opscan
  if (%msgtype == echo) { 
    if (%ircopers == 0) { 
      echo %iscanwin *** No Irc0ps Status: (Users) Found In Channel !
      echo %iscanwin ¤ End Of Scans Report
    }
    else {
      echo %iscanwin *** Total Irc0ps:  $+ %ircopers $+  Found In Channel !
      echo %iscanwin ¤ End Of Scans Report
    }
  }
  if (%msgtype == say) { 
    if (%ircopers == 0) { 
      inc %stimer 1 | .timer 1 %stimer msg %iscanwin *** No Irc0p Status: (Users) Found In Channel !
      inc %stimer 1 | .timer 1 %stimer msg %iscanwin ¤ End Of Scans Report
    }
    else {
      inc %stimer 1 | .timer 1 %stimer msg %iscanwin *** Total Irc0ps: ( $+ %ircopers $+ ) Found In Channel !
      inc %stimer 1 | .timer 1 %stimer msg %iscanwin ¤ End Of Scans Report
    }
  }
  unset %ircopers %chan %msgtype
  halt
}

#opscan end

menu channel {
IRCopScan:/scanops
}