;Don't EDIT ThiS YoU Fucking LameR
;The ScRipT Will NoT WorK Correctly
;AnD We Will FinD YoU,AnD TheN..."Dupe da ti e qko!"

alias scanircops.dialog { dialog -m ircop ircop }
dialog ircop {
  title "IRCop Scan"

  size -1 -1 500 360

  text "Dialog IRCop Scan v2.0", 1, 10 10 120 20 
  text "Scan for ircops in the network", 77, 10 50 190 20
  text "Scan for ircops in channel", 88, 252 50 190 20
  text "Chose chan", 6, 252 90 130 100
  list 71, 10 290 160 38, autohs
  list 81, 252 290 160 38, autohs

  box "", 3, 3 28 242 300
  box "", 11, 242 28 242 300
  combo 5, 322 87 80 50, drop
  list 35, 253 123 200 180, autohs
  list 45, 10 123 200 180, autohs

  button "&Close", 2, 430 333 60 25, ok

  button "&Scan", 19, 178 300 60 25, default
  button "&Scan", 16, 418 300 60 25, default

}
on *:dialog:ircop:dclick:45:{
  var %cop.sel $did(ircop,45).sel
  if noircops !iswm $did(ircop,45,%cop.sel).text  whois $did(ircop,45,%cop.sel).text 
}
on *:dialog:ircop:dclick:35:{
  var %cop.sel $did(ircop,35).sel
  if noircops !iswm $did(ircop,35,%cop.sel).text  whois $did(ircop,35,%cop.sel).text 
}
on *:dialog:ircop:*:*:{
  if $devent == sclick {
    if $did == 2 { dialog -x ircop }
    if $did == 19 { scan-ircops.net }
    if $did == 16 { scan-ircops.chan }
    if $did == 5 { 
      set %scan.chan $did(5).text
    }  
  }
  if $devent == init {
    getchans
    chk.connection
  }
}
alias chk.connection {
  if $server == $null {
    did -r ircop 81,71
    did -a ircop 71,81 *** you are NOT connected
  }
}
alias scan-ircops.net {
  if $server == $null { echo -s *** you are not connected to an IRC server | halt }
  did -r ircop 45
  did -r ircop 71
  set %chk.cops 0
  .disable #ircop-scan.chan  
  .enable #ircop-scan.net
  did -ra ircop 71 Status: Scanning.. please wait.
  who 0 o  
}
alias scan-ircops.chan {
  if $server == $null { echo -s *** you are not connected to an IRC server | halt }
  did -r ircop 35
  did -r ircop 81 
  set %chk.cops 0
  who %scan.chan *
  .disable #ircop-scan.net
  .enable #ircop-scan.chan
}
#ircop-scan.chan off
raw 352:* {
  did -ra ircop 81 Status: Scanning.. please wait.
  if (* isin $7) { did -a ircop 35 $6 
    inc %chk.cops
  }
}
raw 315:* { 
  dialog -t ircop IRCop Scan ( end of scan %chk.cops ircops found )
  if %chk.cops == 0 { did -a ircop 35 no ircops found. |  set %copsfound none }
  .disable #ircop-scan.chan
  unset %scan.chan
  unset %chk.cops
  if %copsfound == none { did -a ircop 81 Status: No ircops found }
  if %copsfound != none { 
    did -ra ircop 81 end of scan: DOUBLE click
    did -a ircop 81 on nick to whois
  }
  unset %copsfound
  halt 
}
#ircop-scan.chan end
#ircop-scan.net off
raw 352:* {
  did -a ircop 45 $6
  inc %chk.cops
  halt
}
raw 315:* { 
  dialog -t ircop IRCop Scan ( end of scan %chk.cops ircops found )
  if %chk.cops == 0 { did -a ircop 45 no ircops found. | set %copsfound none }
  unset %chk.cops  
  if %copsfound == none { did -a ircop 71 Status: No ircops found }
  if %copsfound != none { 
    did -ra ircop 71 end of scan: DOUBLE click
    did -a ircop 71 on nick to whois
  }
  unset %copsfound
  .disable #ircop-scan.net
  halt
}
#ircop-scan.net end
alias getchans {
  set %num.chans 0
  :start
  inc %num.chans
  if ($comchan($me,%num.chans)) {
    /did -a ircop 5 $comchan($me,%num.chans)
    goto start
  }
  unset %num.chans
  if $comchan($me,0) == 0 nonechanz 
}
alias nonechanz { did -b ircop 5 | did -b ircop 6 | did -r ircop 81 | did -a ircop 81 *** you must in a channel }
