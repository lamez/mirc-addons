alias massmsg {
  set %msg $$?="What Do You Want To Say?"
  set %people 1
  :loop
  if ($nick(#,%people) == cs) { inc %people | goto loop | halt }
  if ($nick(#,%people) == $me) { inc %people | goto loop | halt }
  if ($nick(#,%people) == $opnick) { inc %people | goto loop | halt }  
  else { .msg $nick(#,%people) %msg  }
  inc %people
  if ($nick(#,%people) == $null) { unset %msg | unset %people }
  else { goto loop }
}
alias massop {
  set %people 1
  :loop
  if ($nick(#,%people) == cs) { inc %people | goto loop | halt }
  if ($nick(#,%people) == $me) { inc %people | goto loop | halt }
  else { .mode $chan +o $nick(#,%people) }
  inc %people
  if ($nick(#,%people) == $null) { unset %people }
  else { goto loop }
}
alias massdeop {
  set %people 1
  :loop
  if ($nick(#,%people) == cs) { inc %people | goto loop | halt }
  if ($nick(#,%people) == $me) { inc %people | goto loop | halt }
  else { .mode $chan -o $nick(#,%people) }
  inc %people
  if ($nick(#,%people) == $null) { unset %people }
  else { goto loop }
}
alias massvoice {
  set %people 1
  :loop
  if ($nick(#,%people) == cs) { inc %people | goto loop | halt }
  if ($nick(#,%people) == $me) { inc %people | goto loop | halt }
  else { .mode $chan +v $nick(#,%people) }
  inc %people
  if ($nick(#,%people) == $null) { unset %people }
  else { goto loop }
}
alias massdevoice {
  set %people 1
  :loop
  if ($nick(#,%people) == cs) { inc %people | goto loop | halt }
  if ($nick(#,%people) == $me) { inc %people | goto loop | halt }
  else { .mode $chan -v $nick(#,%people) }
  inc %people
  if ($nick(#,%people) == $null) { unset %people }
  else { goto loop }
}
alias masskick {
  set %people 1
  :loop
  if ($nick(#,%people) == cs) { inc %people | goto loop | halt }
  if ($nick(#,%people) == $me) { inc %people | goto loop | halt }
  else { .kick $chan $nick(#,%people) Mass Kick [ShakE] }
  inc %people
  if ($nick(#,%people) == $null) { unset %people }
  else { goto loop }
}
alias massban {
  set %people 1
  :loop
  if ($nick(#,%people) == cs) { inc %people | goto loop | halt }
  if ($nick(#,%people) == $me) { inc %people | goto loop | halt }
  else { .ban $nick(#,%people) }
  inc %people
  if ($nick(#,%people) == $null) { unset %people }
  else { goto loop }
}
alias masskb {
  set %people 1
  :loop
  if ($nick(#,%people) == cs) { inc %people | goto loop | halt }
  if ($nick(#,%people) == $me) { inc %people | goto loop | halt }
  else { .ban $nick(#,%people) | kick $chan $nick(#,%people) Mass Kick/Ban [ShakE] }
  inc %people
  if ($nick(#,%people) == $null) { unset %people}
    else { goto loop }
  }
}
alias massinv {
  set %in $$?="Which Channel EX: #bulgaria :"
  set %people 1
  :loop
  if ($nick(#,%people) == cs) { inc %people | goto loop | halt }
  if ($nick(#,%people) == $me) { inc %people | goto loop | halt }
  if ($nick(#,%people) == $opnick) { inc %people | goto loop | halt }  
  else { .invite $nick(#,%people) %in }
  inc %people
  if ($nick(#,%people) == $null) { unset %massinv | unset %people | /window -a @MassInviteStat 7(  15( Mass Invite Of # Complete 15)  7) }
  else { goto loop }
}
menu channel,menubar {
  -
  -  
  Mass
  .Mass Msg:/massmsg
  .Mass Invite:/massinv
  .-
  .Mass Op:/massop
  .Mass Deop:/massdeop
  .Mass Voice:/massvoice
  .Mass Devoice:/massdevoice
  .-
  .Mass Ban:/massban
  .Mass Kick Ban:/masskb
  .Mass Kick:/masskick
  -
}
