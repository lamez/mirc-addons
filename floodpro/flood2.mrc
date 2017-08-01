; ----------------------------------------------------------
; Flood Protection by datalogik (datalogik@theshell.org)
;
; [+] Allowing you to protect yourself against various
;     kinds of floods.
; [+] Customization of kick messages, settings, and many
;     other things in the script.
;
; File name: flood.mrc (2/2)
; File info: Remote events: join, ctcp, deop, kick, text, notice,
;            nick change, ban, and invite.
;
; ----------------------------------------------------------

on *:join:#: {
  var %protection.loop = 1 
  var %protection.read = $readini $scriptdirflood.ini Misc Channels 
  while (%protection.loop <= $calc($count(%protection.read,$chr(032)) + 1)) {
    var %temp.set = $gettok(%protection.read,%protection.loop,032)
    if (%temp.set == #) {
      inc %temp.joins 1
      set %temp.joins.read $readini $scriptdirflood.ini # Join
      if (%temp.join [ $+ [ # ] ] != $null) { set -u6 %temp.join [ $+ [ # ] ] $ctime }
      %temp.nicks = %temp.nicks $nick
      if ($gettok(%temp.joins.read,1,058) >= %temp.joins) && ($calc($ctime - %temp.join [ $+ [ # ] ]) >= $gettok(%temp.joins.read,2,058)) {
        var %temp.read $readini $scriptdirflood.ini # Punish
        if (%temp.read == $null) { return }
        if (%temp.read == 1) { 
          inc -u6 %temp.inc1. [ $+ [ $nick ] ] 1
          if (%temp.inc1. [ $+ [ $nick ] ] == 1) { .notice $nick $pro.msg(joins,%temp.123,%temp.dur) }
          if (%temp.inc1. [ $+ [ $nick ] ] == 2) { echo # *** Automatically ignoring $nick for 3 seconds. | .ignore -u3 $nick }
        }
      }
    }
    inc %protection.loop
  } 
}
on *:text:*:#: {
  var %protection.read = $readini $scriptdirflood.ini Misc Channels 
  if (# !isin %protection.read) { return }
  var %temp.read = $readini $scriptdirflood.ini # Line
  if (%temp.read == $null) { return }
  var %temp.dur = $gettok(%temp.read,2,058)
  inc -u [ $+ [ $gettok(%temp.read,2,058) ] ] %temp.chantext [ $+ [ # ] ] 1
  if (%temp.chantext [ $+ [ # ] ] >= $gettok(%temp.read,1,058)) {
    var %temp.punish = $readini $scriptdirflood.ini # Punish
    var %temp.123 = %temp.chantext [ $+ [ # ] ]
    if (%temp.punish == $null) { return }
    if (%temp.punish == 1) { 
      inc -u6 %temp.inc1. [ $+ [ $nick ] ] 1
      if (%temp.inc1. [ $+ [ $nick ] ] == 1) { .notice $nick $pro.msg(lines,%temp.123,%temp.dur) }
      if (%temp.inc1. [ $+ [ $nick ] ] == 2) { echo # *** Automatically ignoring $nick for 3 seconds. | .ignore -u3 $nick }
    }
    if (%temp.punish == 2) { if ($me isop #) && ($nick ison #) { kick # $nick $pro.msg(lines,%temp.123,%temp.dur) } }
    if (%temp.punish == 3) { if ($me isop #) && ($nick ison #) { var %temp.ban = $readini $scriptdirflood.ini # bantype | mode # -o+b $nick $address($nick,%temp.ban) | kick # $nick $pro.msg(lines,%temp.123,%temp.dur) } }
  }
}
on *:notice:*:*: {
  var %protection.read = $readini $scriptdirflood.ini Misc Channels 
  if (# !isin %protection.read) { return }
  var %temp.read = $readini $scriptdirflood.ini # Notice
  if (%temp.read == $null) { return }
  var %temp.dur = $gettok(%temp.read,2,058)
  inc -u [ $+ [ $gettok(%temp.read,2,058) ] ] %temp.chantext [ $+ [ # ] ] 1
  if (%temp.chantext [ $+ [ # ] ] >= $gettok(%temp.read,1,058)) {
    var %temp.punish = $readini $scriptdirflood.ini # Punish
    var %temp.123 = %temp.chantext [ $+ [ # ] ]
    if (%temp.punish == $null) { return }
    if (%temp.punish == 1) { 
      inc -u6 %temp.inc1. [ $+ [ $nick ] ] 1
      if (%temp.inc1. [ $+ [ $nick ] ] == 1) { .notice $nick $pro.msg(notice,%temp.123,%temp.dur) }
      if (%temp.inc1. [ $+ [ $nick ] ] == 2) { echo # *** Automatically ignoring $nick for 3 seconds. | .ignore -u3 $nick }
    }
    if (%temp.punish == 2) { if ($me isop #) && ($nick ison #) { kick # $nick $pro.msg(notice,%temp.123,%temp.dur) } }
    if (%temp.punish == 3) { if ($me isop #) && ($nick ison #) { var %temp.ban = $readini $scriptdirflood.ini # bantype | mode # -o+b $nick $address($nick,%temp.ban) | kick # $nick $pro.msg(notice,%temp.123,%temp.dur) } }
  }
}
on *:nick: {
  var %protection.read = $readini $scriptdirflood.ini Misc Channels 
  if (# !isin %protection.read) { return }
  var %temp.read = $readini $scriptdirflood.ini # Nick
  if (%temp.read == $null) { return }
  var %temp.dur = $gettok(%temp.read,2,058)
  inc -u [ $+ [ $gettok(%temp.read,2,058) ] ] %temp.chantext [ $+ [ # ] ] 1
  if (%temp.chantext [ $+ [ # ] ] >= $gettok(%temp.read,1,058)) {
    var %temp.punish = $readini $scriptdirflood.ini # Punish
    var %temp.123 = %temp.chantext [ $+ [ # ] ]
    if (%temp.punish == $null) { return }
    if (%temp.punish == 1) { 
      inc -u6 %temp.inc1. [ $+ [ $nick ] ] 1
      if (%temp.inc1. [ $+ [ $nick ] ] == 1) { .notice $nick $pro.msg(nick,%temp.123,%temp.dur) }
      if (%temp.inc1. [ $+ [ $nick ] ] == 2) { echo # *** Automatically ignoring $nick for 3 seconds. | .ignore -u3 $nick }
    }
    if (%temp.punish == 2) { if ($me isop #) && ($nick ison #) { kick # $nick $pro.msg(nick,%temp.123,%temp.dur) } }
    if (%temp.punish == 3) { if ($me isop #) && ($nick ison #) { var %temp.ban = $readini $scriptdirflood.ini # bantype | mode # -o+b $nick $address($nick,%temp.ban) | kick # $nick $pro.msg(nick,%temp.123,%temp.dur) } }
  }
}
on *:deop:#: {
  var %protection.read = $readini $scriptdirflood.ini Misc Channels 
  if (# !isin %protection.read) { return }
  var %temp.read = $readini $scriptdirflood.ini # Deop
  if (%temp.read == $null) { return }
  var %temp.dur = $gettok(%temp.read,2,058)
  inc -u [ $+ [ $gettok(%temp.read,2,058) ] ] %temp.chantext [ $+ [ # ] ] 1
  if (%temp.chantext [ $+ [ # ] ] >= $gettok(%temp.read,1,058)) {
    var %temp.punish = $readini $scriptdirflood.ini # Punish
    var %temp.123 = %temp.chantext [ $+ [ # ] ]
    if (%temp.punish == $null) { return }
    if (%temp.punish == 1) { 
      inc -u6 %temp.inc1. [ $+ [ $nick ] ] 1
      if (%temp.inc1. [ $+ [ $nick ] ] == 1) { .notice $nick $pro.msg(deop,%temp.123,%temp.dur) }
      if (%temp.inc1. [ $+ [ $nick ] ] == 2) { echo # *** Automatically ignoring $nick for 3 seconds. | .ignore -u3 $nick }
    }
    if (%temp.punish == 2) { if ($me isop #) && ($nick ison #) { kick # $nick $pro.msg(deop,%temp.123,%temp.dur) } }
    if (%temp.punish == 3) { if ($me isop #) && ($nick ison #) { var %temp.ban = $readini $scriptdirflood.ini # bantype | mode # -o+b $nick $address($nick,%temp.ban) | kick # $nick $pro.msg(deop,%temp.123,%temp.dur) } }
  }
}
on *:kick:#: {
  if ($nick == $me) { return }
  var %protection.read = $readini $scriptdirflood.ini Misc Channels 
  if (# !isin %protection.read) { return }
  var %temp.read = $readini $scriptdirflood.ini # Kick
  if (%temp.read == $null) { return }
  var %temp.dur = $gettok(%temp.read,2,058)
  inc -u [ $+ [ $gettok(%temp.read,2,058) ] ] %temp.chantext [ $+ [ # ] ] 1
  if (%temp.chantext [ $+ [ # ] ] >= $gettok(%temp.read,1,058)) {
    var %temp.punish = $readini $scriptdirflood.ini # Punish
    var %temp.123 = %temp.chantext [ $+ [ # ] ]
    if (%temp.punish == $null) { return }
    if (%temp.punish == 1) { 
      inc -u6 %temp.inc1. [ $+ [ $nick ] ] 1
      if (%temp.inc1. [ $+ [ $nick ] ] == 1) { .notice $nick $pro.msg(kick,%temp.123,%temp.dur) }
      if (%temp.inc1. [ $+ [ $nick ] ] == 2) { echo # *** Automatically ignoring $nick for 3 seconds. | .ignore -u3 $nick }
    }
    if (%temp.punish == 2) { if ($me isop #) && ($nick ison #) { kick # $nick $pro.msg(kick,%temp.123,%temp.dur) } }
    if (%temp.punish == 3) { if ($me isop #) && ($nick ison #) { var %temp.ban = $readini $scriptdirflood.ini # bantype | mode # -o+b $nick $address($nick,%temp.ban) | kick # $nick $pro.msg(kick,%temp.123,%temp.dur) } }
  }
}
on *:ban:#: {
  var %protection.read = $readini $scriptdirflood.ini Misc Channels 
  if (# !isin %protection.read) { return }
  var %temp.read = $readini $scriptdirflood.ini # Ban
  if (%temp.read == $null) { return }
  var %temp.dur = $gettok(%temp.read,2,058)
  inc -u [ $+ [ $gettok(%temp.read,2,058) ] ] %temp.chantext [ $+ [ # ] ] 1
  if (%temp.chantext [ $+ [ # ] ] >= $gettok(%temp.read,1,058)) {
    var %temp.punish = $readini $scriptdirflood.ini # Punish
    var %temp.123 = %temp.chantext [ $+ [ # ] ]
    if (%temp.punish == $null) { return }
    if (%temp.punish == 1) { 
      inc -u6 %temp.inc1. [ $+ [ $nick ] ] 1
      if (%temp.inc1. [ $+ [ $nick ] ] == 1) { .notice $nick $pro.msg(ban,%temp.123,%temp.dur) }
      if (%temp.inc1. [ $+ [ $nick ] ] == 2) { echo # *** Automatically ignoring $nick for 3 seconds. | .ignore -u3 $nick }
    }
    if (%temp.punish == 2) { if ($me isop #) && ($nick ison #) { kick # $nick $pro.msg(ban,%temp.123,%temp.dur) } }
    if (%temp.punish == 3) { if ($me isop #) && ($nick ison #) { var %temp.ban = $readini $scriptdirflood.ini # bantype | mode # -o+b $nick $address($nick,%temp.ban) | kick # $nick $pro.msg(ban,%temp.123,%temp.dur) } }
  }
}
on *:invite:*: {
  var %protection.read = $readini $scriptdirflood.ini Misc Channels 
  if (# !isin %protection.read) { return }
  var %temp.read = $readini $scriptdirflood.ini # Invite
  if (%temp.read == $null) { return }
  var %temp.dur = $gettok(%temp.read,2,058)
  inc -u [ $+ [ $gettok(%temp.read,2,058) ] ] %temp.chantext [ $+ [ # ] ] 1
  if (%temp.chantext [ $+ [ # ] ] >= $gettok(%temp.read,1,058)) {
    var %temp.punish = $readini $scriptdirflood.ini # Punish
    var %temp.123 = %temp.chantext [ $+ [ # ] ]
    if (%temp.punish == $null) { return }
    if (%temp.punish == 1) { 
      inc -u6 %temp.inc1. [ $+ [ $nick ] ] 1
      if (%temp.inc1. [ $+ [ $nick ] ] == 1) { .notice $nick $pro.msg(invite,%temp.123,%temp.dur) }
      if (%temp.inc1. [ $+ [ $nick ] ] == 2) { echo # *** Automatically ignoring $nick for 3 seconds. | .ignore -u3 $nick }
    }
    if (%temp.punish == 2) { if ($me isop #) && ($nick ison #) { kick # $nick $pro.msg(invite,%temp.123,%temp.dur) } }
    if (%temp.punish == 3) { if ($me isop #) && ($nick ison #) { var %temp.ban = $readini $scriptdirflood.ini # bantype | mode # -o+b $nick $address($nick,%temp.ban) | kick # $nick $pro.msg(invite,%temp.123,%temp.dur) } }
  }
}
ctcp *:*:*: {
  var %protection.read = $readini $scriptdirflood.ini Misc Channels 
  if (# !isin %protection.read) { return }
  var %temp.read = $readini $scriptdirflood.ini # CTCP
  if (%temp.read == $null) { return }
  var %temp.dur = $gettok(%temp.read,2,058)
  inc -u [ $+ [ $gettok(%temp.read,2,058) ] ] %temp.chantext [ $+ [ # ] ] 1
  if (%temp.chantext [ $+ [ # ] ] >= $gettok(%temp.read,1,058)) {
    var %temp.punish = $readini $scriptdirflood.ini # Punish
    var %temp.123 = %temp.chantext [ $+ [ # ] ]
    if (%temp.punish == $null) { return }
    if (%temp.punish == 1) { 
      inc -u6 %temp.inc1. [ $+ [ $nick ] ] 1
      if (%temp.inc1. [ $+ [ $nick ] ] == 1) { .notice $nick $pro.msg(ctcp,%temp.123,%temp.dur) }
      if (%temp.inc1. [ $+ [ $nick ] ] == 2) { echo # *** Automatically ignoring $nick for 3 seconds. | .ignore -u3 $nick }
    }
    if (%temp.punish == 2) { if ($me isop #) && ($nick ison #) { kick # $nick $pro.msg(ctcp,%temp.123,%temp.dur) } }
    if (%temp.punish == 3) { if ($me isop #) && ($nick ison #) { var %temp.ban = $readini $scriptdirflood.ini # bantype | mode # -o+b $nick $address($nick,%temp.ban) | kick # $nick $pro.msg(ctcp,%temp.123,%temp.dur) } }
  }
}
