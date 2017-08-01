on 1:load:.ial on
on 1:join:#:{
  if ($nick == $me) {
    if ($chan(#).ial == $false) {
      who $chan
    }
  }
  if ( [ %onjoinscan ]  == on) { joinscan }
}
alias clonescan {
  unset %nomaskcnt
  unset %cwinc
  set %echan $chan
  unset %detectednicks
  set %csc 0
  set %clc 0
  echo -a 0,1Clone scan for13 $chan 
  :scan
  set %tsc 0
  inc %csc 1
  set %csnick $nick($chan,%csc)
  if (%csnick == $null) goto done
  set %csadd $address(%csnick,2)
  if (%csadd == $null) {
    echo $1 9,10No mask detected for 0,10 %csnick 
    echo $1 0,10 %csnick 9,10will be skipped
    inc %nomaskcnt
    goto scan
  }
  :tempscan
  inc %tsc 1
  set %tsnick $nick($chan,%tsc)
  if (%tsnick == $null) goto scan
  if (%tsnick == %csnick) goto tempscan
  set %tsadd $address(%tsnick,2)
  if (%tsadd == %csadd) goto notify
  goto tempscan
  :notify
  if (%tsnick isin %detectednicks && %csnick isin %detectednicks) goto tempscan
  set %detectednicks %detectednicks $+ %csnick
  set %detectednicks %detectednicks $+ %tsnick
  echo %echan 1,4Clones Detected 0,4 $+ %csnick $+ 1,4 and 0,4 $+ %tsnick 
  echo %echan 1,4Cloning address  $+ %tsadd $+ 
  inc %clc 1
  goto tempscan
  :done
  echo %echan 0,12Clone Scan for13 $chan 0,12complete
  echo %echan 0,12total clone pairs detected13 %clc 
  if (%nomaskcnt != $null) { echo $1 13,12 %nomaskcnt 0,12nicks skipped during scan }
}
alias pubclonescan {
  unset %nomaskcnt
  unset %cwinc
  set %echan $chan
  unset %detectednicks
  set %csc 0
  set %clc 0
  say 0,1Clone scan for13 $chan 
  :scan
  set %tsc 0
  inc %csc 1
  set %csnick $nick($chan,%csc)
  if (%csnick == $null) goto done
  set %csadd $address(%csnick,2)
  if (%csadd == $null) {
    msg $1 9,10No mask detected for 0,10 %csnick 
    msg $1 0,10 %csnick 9,10will be skipped
    inc %nomaskcnt
    goto scan
  }
  :tempscan
  inc %tsc 1
  set %tsnick $nick($chan,%tsc)
  if (%tsnick == $null) goto scan
  if (%tsnick == %csnick) goto tempscan
  set %tsadd $address(%tsnick,2)
  if (%tsadd == %csadd) goto notify
  goto tempscan
  :notify
  if (%tsnick isin %detectednicks && %csnick isin %detectednicks) goto tempscan
  set %detectednicks %detectednicks $+ %csnick
  set %detectednicks %detectednicks $+ %tsnick
  msg %echan 1,4Clones Detected 0,4 $+ %csnick $+ 1,4 and 0,4 $+ %tsnick 
  msg %echan 1,4Cloning address  $+ %tsadd $+ 
  inc %clc 1
  goto tempscan
  :done
  msg %echan 0,12Clone Scan for13 $chan 0,12complete
  msg %echan 0,12total clone pairs detected13 %clc 
  if (%nomaskcnt != $null) { msg $1 13,12 %nomaskcnt 0,12nicks skipped during scan }
}
alias joinscan {
  set %jsc 0
  set %jsnick $nick
  set %jsadd $address(%jsnick,2)
  if (%jsadd == $address($me,2)) { goto done }
  :scan
  inc %jsc 1
  set %chnick $nick($chan,%jsc)
  if (%chnick == %jsnick) goto scan
  if (%chnick == $null) goto done
  set %chadd $address(%chnick,2)
  if (%chadd == %jsadd) goto notify
  goto scan
  :notify
  echo -a 1,4Clones Detected on $chan 0,4 $+ %chnick  and 0,4 $+ %jsnick 
  echo -a 1,4Cloning address  $+ %chadd $+ 
  goto scan
  :done
}
menu menubar,channel,nicklist {
  Clone Scanner
  .Scan
  ..Private Display:clonescan
  ..Public Display:pubclonescan
  .on join clone scan ( $+ %onjoinscan $+ )
  ..on:set %onjoinscan on
  ..off:set %onjoinscan off
}
