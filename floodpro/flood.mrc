; ----------------------------------------------------------
; Flood Protection by datalogik (datalogik@theshell.org)
;
; [+] Allowing you to protect yourself against various
;     kinds of floods.
; [+] Customization of kick messages, settings, and many
;     other things in the script.
;
; File name: flood.mrc (1/2)
; File info: dialog mrc file, all the main dialog is stored
;            and opperated from here. along with misc stuff.
;
; ----------------------------------------------------------

alias protection dialog -m protection protection
alias protection.help dialog -m protection.help protection.help
alias protection.messages dialog -m protection.messages protection.messages

dialog protection {
  title "Protection Settings"
  size -1 -1 290 320
  text "Channel", 1, 5 9 40 13
  combo 2, 50 5 110 102, drop
  button "Add", 3, 163 5 60 20
  button "Remove", 4, 225 5 60 20
  box "Flood Protection", 5, 5 35 280 232

  edit "", 6, 10 50 20 20
  text "Joins in", 7, 33 54 40 13
  edit "", 8, 93 50 20 20
  text "seconds.", 9, 118 54 40 13
  text "    * for", 10, 165 54 40 13
  edit "", 11, 203 50 20 20
  text "minutes.", 12, 228 54 40 13

  edit "", 13, 10 74 20 20
  text "Lines in", 14, 33 78 40 13
  edit "", 15, 93 74 20 20
  text "seconds.", 16, 118 78 40 13
  text "    * for", 17, 165 78 40 13
  edit "", 18, 203 74 20 20
  text "minutes.", 19, 228 78 40 13

  edit "", 20, 10 98 20 20
  text "Notices in", 21, 33 102 50 13
  edit "", 22, 93 98 20 20
  text "seconds.", 23, 118 102 40 13
  text "    * for", 24, 165 102 40 13
  edit "", 25, 203 98 20 20
  text "minutes.", 26, 228 102 40 13

  edit "", 27, 10 122 20 20
  text "Nicks in", 28, 33 126 50 13
  edit "", 29, 93 122 20 20
  text "seconds.", 30, 118 126 40 13
  text "    * for", 31, 165 126 40 13
  edit "", 32, 203 122 20 20
  text "minutes.", 33, 228 126 40 13

  edit "", 34, 10 146 20 20
  text "Deops in", 35, 33 150 50 13
  edit "", 36, 93 146 20 20
  text "seconds.", 37, 118 150 40 13
  text "    * for", 38, 165 150 40 13
  edit "", 39, 203 146 20 20
  text "minutes.", 40, 228 150 40 13

  edit "", 41, 10 170 20 20
  text "Kicks in", 42, 33 174 50 13
  edit "", 43, 93 170 20 20
  text "seconds.", 44, 118 174 40 13
  text "    * for", 45, 165 174 40 13
  edit "", 46, 203 170 20 20
  text "minutes.", 47, 228 174 40 13

  edit "", 48, 10 194 20 20
  text "Bans in", 49, 33 198 50 13
  edit "", 50, 93 194 20 20
  text "seconds.", 51, 118 198 40 13
  text "    * for", 52, 165 198 40 13
  edit "", 53, 203 194 20 20
  text "minutes.", 54, 228 198 40 13

  edit "", 55, 10 218 20 20
  text "Invites in", 56, 33 222 50 13
  edit "", 57, 93 218 20 20
  text "seconds.", 58, 118 222 40 13
  text "    * for", 59, 165 222 40 13
  edit "", 60, 203 218 20 20
  text "minutes.", 61, 228 222 40 13

  edit "", 62, 10 242 20 20
  text "CTCPS in", 63, 33 246 50 13
  edit "", 64, 93 242 20 20
  text "seconds.", 65, 118 246 40 13
  text "    * for", 66, 165 246 40 13
  edit "", 67, 203 242 20 20
  text "minutes.", 68, 228 246 40 13

  box "Ban type", 69, 5 270 140 44
  combo 70, 11 285 127 200, drop

  box "", 71, 150 270 135 44
  button "Ok", 72, 156 285 60 20, ok
  button "Edit", 73, 218 285 60 20
}
dialog protection.editchannels {
  title "Edit/Add a Channel"
  size -1 -1 277 100
  text "Channel", 1, 3 7 60 13
  edit "", 2, 48 3 200 22
  box "Punishment", 3, 3 25 133 42
  combo 4, 10 40 120 100, drop
  box "Protection Levels", 5, 140 25 133 42
  combo 6, 147 40 120 100, drop
  button "Ok", 7, 110 74 60 20, ok
}
dialog protection.messages {
  size -1 -1 350 75
  combo 1, 5 3 130 120, drop
  box "", 2, 3 25 344 40
  edit "", 3, 10 35 331 22
  combo 4, 150 3 80 90, drop
  button "Ok", 5, 286 3 60 20, ok
}
dialog protection.help {
  size -1 -1 380 300
  edit "", 1, 2 2 376 296, read multi vsbar
  button "", 2, 0 0 0 0, cancel
}
on *:dialog:protection.help:*:*:if ($devent == init) { filter -foc $scriptdirreadme.txt protection.help 1 | return }
on *:dialog:protection.messages:*:*: {
  if ($devent == init) {
    did -a protection.messages 1 Join Message | did -a protection.messages 1 Line Message | did -a protection.messages 1 Notice Message | did -a protection.messages 1 Nick Message | did -a protection.messages 1 Deop Message | did -a protection.messages 1 Kick Message | did -a protection.messages 1 Ban Message | did -a protection.messages 1 Invite Message | did -a protection.messages 1 Ctcp Message | did -a protection.messages 4 Events | did -a protection.messages 4 Seconds
  }
  if ($devent == sclick) { 
    if ($did == 1) { did -ra protection.messages 3 $readini $scriptdirflood.ini Messages $gettok($did(protection.messages,1,$did(protection.messages,1).sel).text,1,032) } 
    if ($did == 4) {
      var %temp = $did(protection.messages,1).sel).text
      if ($did(protection.messages,4).sel == 1) { var %protection.msg = < $+ $lower($gettok(%temp,1,032)) $+ s> }
      if ($did(protection.messages,4).sel == 2) { var %protection.msg = < $+ $lower($gettok(%temp,1,032)) $+ secs> }
      did -a protection.messages 3 %protection.msg
      if ($did(protection.messages,3).text != $null) { writeini $scriptdirflood.ini Messages $gettok($did(protection.messages,1,$did(protection.messages,1).sel).text,1,032) $did(protection.messages,3).text }
    }
  }
  if ($devent == edit) { if ($did(protection.messages,3).text != $null) { writeini $scriptdirflood.ini Messages $gettok($did(protection.messages,1,$did(protection.messages,1).sel).text,1,032) $did(protection.messages,3).text } }
}
on *:dialog:protection:*:*: {
  if ($devent == init) {
    unset %protection.*
    did -a protection 70 *!datalogik@linuxsluts.net | did -a protection 70 *!*datalogik@linuxsluts.net | did -a protection 70 *!*@linuxsluts.net | did -a protection 70 *!*datalogik@*.net | did -a protection 70 datalogik!datalogik@linuxsluts.net | did -a protection 70 datalogik!*datalogik@linuxsluts.net | did -a protection 70 datalogik!*@linuxsluts.net | did -a protection 70 datalogik!*datalogik@*.net | did -a protection 70 *!datalogik@linuxsluts.net
    did -a protection 70 *!*datalogik@linuxsluts.net | did -a protection 70 *!*@linuxsluts.net | did -a protection 70 *!*datalogik@*.net | did -a protection 70 datalogik!datalogik@linuxsluts.net | did -a protection 70 datalogik!*datalogik@linuxsluts.net | did -a protection 70 datalogik!*@linuxsluts.net | did -a protection 70 datalogik!*datalogik@*.net | did -a protection 70 datalogik!*@*.net | did -a protection 70 datalogik!datalogik@linuxsluts.net
    var %protection.loop = 1 
    var %protection.read = $readini $scriptdirflood.ini Misc Channels 
    while (%protection.loop <= $calc($count(%protection.read,$chr(032)) + 1)) {
      var %temp.set = $gettok(%protection.read,%protection.loop,032)
      did -a protection 2 %temp.set 
      inc %protection.loop
    } 
  }
  if ($devent == sclick) {
    if ($did == 2) { if ($did(protection,2,$did(protection,2).sel).text == $null) { return } | set %protection.channel $did(protection,2,$did(protection,2).sel).text | protection.update $did(protection,2,$did(protection,2).sel).text }
    if ($did == 3) { protection.add }
    if ($did == 4) { protection.remove }
    if ($did == 70) { if ($did(protection,70).sel == $null) { return } | writeini $scriptdirflood.ini %protection.channel bantype $did(protection,70).sel | return }
    if ($did == 72) {
      if (%protection.channel == $null) { return }
      writeini $scriptdirflood.ini %protection.channel Join $did(protection,6).text $+ : $+ $did(protection,8).text $+ : $+ $did(protection,11).text | writeini $scriptdirflood.ini %protection.channel Line $did(protection,13).text $+ : $+ $did(protection,15).text $+ : $+ $did(protection,18).text | writeini $scriptdirflood.ini %protection.channel Notice $did(protection,20).text $+ : $+ $did(protection,22).text $+ : $+ $did(protection,25).text | writeini $scriptdirflood.ini %protection.channel Nick $did(protection,27).text $+ : $+ $did(protection,29).text $+ : $+ $did(protection,32).text | writeini $scriptdirflood.ini %protection.channel Deop $did(protection,34).text $+ : $+ $did(protection,36).text $+ : $+ $did(protection,39).text | writeini $scriptdirflood.ini %protection.channel Kick $did(protection,41).text $+ : $+ $did(protection,43).text $+ : $+ $did(protection,46).text
      writeini $scriptdirflood.ini %protection.channel Ban $did(protection,48).text $+ : $+ $did(protection,50).text $+ : $+ $did(protection,53).text | writeini $scriptdirflood.ini %protection.channel Invite $did(protection,55).text $+ : $+ $did(protection,57).text $+ : $+ $did(protection,60).text | writeini $scriptdirflood.ini %protection.channel Ctcp $did(protection,62).text $+ : $+ $did(protection,64).text $+ : $+ $did(protection,67).text
    }
    if ($did == 73) { if ($did(protection,2,$did(protection,2).sel).text == $null) { return } | protection.edit $did(protection,2,$did(protection,2).sel).text }
  }
}

on *:dialog:protection.editchannels:*:*: {
  if ($devent == init) {
    if (%protection.add == $null) { did -ra protection.editchannels 2 %protection.edit }
    else { did -ra protection.editchannels 2 %protection.add }
    did -a protection.editchannels 4 Warn | did -a protection.editchannels 4 Kick | did -a protection.editchannels 4 Kick and Ban | did -c protection.editchannels 4 $readini $scriptdirflood.ini %protection.edit Punish
    did -a protection.editchannels 6 Leanient | did -a protection.editchannels 6 Medium | did -a protection.editchannels 6 Strict | did -c protection.editchannels 6 $readini $scriptdirflood.ini %protection.edit level
  }
  if ($devent == sclick) {
    if ($did == 4) { if ($did(protection.editchannels,2).text == $null) { return } | writeini $scriptdirflood.ini $did(protection.editchannels,2).text Punish $did(protection.editchannels,4).sel }
    if ($did == 6) { if ($did(protection.editchannels,2).text == $null) { return } 
      if ($dialog(protection) != $null) { protection.level $did(protection.editchannels,2).text $did(protection.editchannels,6,$did(protection.editchannels,6).sel).text }
      writeini $scriptdirflood.ini $did(protection.editchannels,2).text level $did(protection.editchannels,4).sel
      return
    }
    if ($did == 7) {
      if ($did(protection.editchannels,2).text == $null) { return }
      var %protection.read = $readini $scriptdirflood.ini Misc Channels
      if ($did(protection.editchannels,2).text !isin %protection.read) { writeini $scriptdirflood.ini Misc Channels %protection.read $did(protection.editchannels,2).text }
      if ($dialog(protection) != $null) { did -a protection 2 $did(protection.editchannels,2).text | did -c protection 2 $did(protection,2).lines }
      ;protection.level $did(protection.editchannels,2).text $readini $scriptdirflood.ini $did(protection.editchannels,2).text level
      set %protection.channel $did(protection.editchannels,2).text
    }
  }
}

alias -l protection.update {
  var %protection.loop = 1
  while (%protection.loop < 10) {
    if (%protection.loop == 1) { var %temp.set $readini $scriptdirflood.ini $1 join | did -ra protection 6 $gettok(%temp.set,1,058) | did -ra protection 8 $gettok(%temp.set,2,058) | did -ra protection 11 $gettok(%temp.set,3,058) } | if (%protection.loop == 2) { var %temp.set $readini $scriptdirflood.ini $1 line | did -ra protection 13 $gettok(%temp.set,1,058) | did -ra protection 15 $gettok(%temp.set,2,058) | did -ra protection 18 $gettok(%temp.set,3,058) } | if (%protection.loop == 3) { var %temp.set $readini $scriptdirflood.ini $1 notice | did -ra protection 20 $gettok(%temp.set,1,058) | did -ra protection 22 $gettok(%temp.set,2,058) | did -ra protection 25 $gettok(%temp.set,3,058) } | if (%protection.loop == 4) { var %temp.set $readini $scriptdirflood.ini $1 nick | did -ra protection 27 $gettok(%temp.set,1,058) | did -ra protection 29 $gettok(%temp.set,2,058) | did -ra protection 32 $gettok(%temp.set,3,058) }
    if (%protection.loop == 5) { var %temp.set $readini $scriptdirflood.ini $1 deop | did -ra protection 34 $gettok(%temp.set,1,058) | did -ra protection 36 $gettok(%temp.set,2,058) | did -ra protection 39 $gettok(%temp.set,3,058) } | if (%protection.loop == 6) { var %temp.set $readini $scriptdirflood.ini $1 kick | did -ra protection 41 $gettok(%temp.set,1,058) | did -ra protection 43 $gettok(%temp.set,2,058) | did -ra protection 46 $gettok(%temp.set,3,058) } | if (%protection.loop == 7) { var %temp.set $readini $scriptdirflood.ini $1 ban | did -ra protection 48 $gettok(%temp.set,1,058) | did -ra protection 50 $gettok(%temp.set,2,058) | did -ra protection 53 $gettok(%temp.set,3,058) } | if (%protection.loop == 8) { var %temp.set $readini $scriptdirflood.ini $1 invite | did -ra protection 55 $gettok(%temp.set,1,058) | did -ra protection 57 $gettok(%temp.set,2,058) | did -ra protection 60 $gettok(%temp.set,3,058) }
    if (%protection.loop == 9) { var %temp.set $readini $scriptdirflood.ini $1 ctcp | did -ra protection 62 $gettok(%temp.set,1,058) | did -ra protection 64 $gettok(%temp.set,2,058) | did -ra protection 67 $gettok(%temp.set,3,058) }
    inc %protection.loop 1
  }
  did -c protection 70 $readini $scriptdirflood.ini $1 bantype
}
alias -l protection.add var %protection.read = $readini $scriptdirflood.ini Misc Channels | if (# isin %protection.read) { echo -a *** Channel already in list, Click "Settings" for details. | return } | if ($dialog(protection) == $null) { dialog -m protection protection } | %protection.add = $1- | dialog -m protection.editchannels protection.editchannels
alias -l protection.remove var %protection.remove = $did(protection,2).text | remini $scriptdirflood.ini %protection.remove | var %temp.set = $readini $scriptdirflood.ini Misc Channels | if ($count(%temp.set,$chr(032)) == 0) { remini $scriptdirflood.ini Misc Channels } | else { writeini $scriptdirflood.ini Misc Channels $replace(%temp.set,%protection.remove,$chr(032)) } | did -r protection 2 | var %protection.loop = 1 | set %protection.read $readini $scriptdirflood.ini Misc Channels | while (%protection.loop <= $calc($count(%protection.read,$chr(032)) + 1)) { set %temp.set $gettok(%protection.read,%protection.loop,032) | did -a protection 2 %temp.set | inc %protection.loop } | protection.update none }
alias -l protection.rem {
  if ($1 == $null) { return }
  var %protection.remove = $1-
  var %protection.read = $readini $scriptdirflood.ini Misc Channels
  if (%protection.remove !isin %protection.read) { echo -a *** That channel is not in the main channel list. | return }
  if (%protection.read == %protection.remove) { remini $scriptdirflood.ini Misc Channels | goto say }
  writeini $scriptdirflood.ini Misc Channels $replace(%protection.read,%protection.remove,$chr(032))
  :say
  echo -a *** Successfully removed %protection.remove
  return
}
alias -l protection.edit if ($1 == $null) { return } | set %protection.edit $1 | dialog -m protection.editchannels protection.editchannels
alias -l protection.level {
  if ($1 == $null) || ($2 == $null) { return }
  var %protection.loop = 1
  while (%protection.loop < 10) {
    if (%protection.loop == 1) { var %temp.set $readini $scriptdirflood.ini $2 join | did -ra protection 6 $gettok(%temp.set,1,058) | did -ra protection 8 $gettok(%temp.set,2,058) | did -ra protection 11 $gettok(%temp.set,3,058) } 
    if (%protection.loop == 2) { var %temp.set $readini $scriptdirflood.ini $2 line | did -ra protection 13 $gettok(%temp.set,1,058) | did -ra protection 15 $gettok(%temp.set,2,058) | did -ra protection 18 $gettok(%temp.set,3,058) } 
    if (%protection.loop == 3) { var %temp.set $readini $scriptdirflood.ini $2 notice | did -ra protection 20 $gettok(%temp.set,1,058) | did -ra protection 22 $gettok(%temp.set,2,058) | did -ra protection 25 $gettok(%temp.set,3,058) } 
    if (%protection.loop == 4) { var %temp.set $readini $scriptdirflood.ini $2 nick | did -ra protection 27 $gettok(%temp.set,1,058) | did -ra protection 29 $gettok(%temp.set,2,058) | did -ra protection 32 $gettok(%temp.set,3,058) }
    if (%protection.loop == 5) { var %temp.set $readini $scriptdirflood.ini $2 deop | did -ra protection 34 $gettok(%temp.set,1,058) | did -ra protection 36 $gettok(%temp.set,2,058) | did -ra protection 39 $gettok(%temp.set,3,058) } 
    if (%protection.loop == 6) { var %temp.set $readini $scriptdirflood.ini $2 kick | did -ra protection 41 $gettok(%temp.set,1,058) | did -ra protection 43 $gettok(%temp.set,2,058) | did -ra protection 46 $gettok(%temp.set,3,058) } 
    if (%protection.loop == 7) { var %temp.set $readini $scriptdirflood.ini $2 ban | did -ra protection 48 $gettok(%temp.set,1,058) | did -ra protection 50 $gettok(%temp.set,2,058) | did -ra protection 53 $gettok(%temp.set,3,058) } 
    if (%protection.loop == 8) { var %temp.set $readini $scriptdirflood.ini $2 invite | did -ra protection 55 $gettok(%temp.set,1,058) | did -ra protection 57 $gettok(%temp.set,2,058) | did -ra protection 60 $gettok(%temp.set,3,058) }
    if (%protection.loop == 9) { var %temp.set $readini $scriptdirflood.ini $2 ctcp | did -ra protection 62 $gettok(%temp.set,1,058) | did -ra protection 64 $gettok(%temp.set,2,058) | did -ra protection 67 $gettok(%temp.set,3,058) }
    inc %protection.loop 1
  }
}

menu channel,menubar {
  &Flood
  .&Settings:protection
  .-
  .&Add:protection.add #
  .&Remove:protection.rem #
  .-
  .&Messages:protection.messages
  .&Help:protection.help
}

alias pro.msg {
  if ($1 == join) { var %temp = $readini $scriptdirflood.ini Messages Join | %temp = $replace(%temp,<joins>,$2 Joins) | %temp = $replace(%temp,<joinsecs>,$duration($3-)) | return %temp }
  if ($1 == lines) { var %temp = $readini $scriptdirflood.ini Messages Line | %temp = $replace(%temp,<lines>,$2 Lines) | %temp = $replace(%temp,<linesecs>,$duration($3-)) | return %temp }
  if ($1 == notice) { var %temp = $readini $scriptdirflood.ini Messages Notice | %temp = $replace(%temp,<notices>,$2 Notices) | %temp = $replace(%temp,<noticesecs>,$duration($3-)) | return %temp }
  if ($1 == nick) { var %temp = $readini $scriptdirflood.ini Messages Nick | %temp = $replace(%temp,<nicks>,$2 Nicks) | %temp = $replace(%temp,<nicksecs>,$duration($3-)) | return %temp }
  if ($1 == deop) { var %temp = $readini $scriptdirflood.ini Messages Deop | %temp = $replace(%temp,<deops>,$2 Deops) | %temp = $replace(%temp,<deopsecs>,$duration($3-)) | return %temp }
  if ($1 == kick) { var %temp = $readini $scriptdirflood.ini Messages Kick | %temp = $replace(%temp,<kicks>,$2 Kicks) | %temp = $replace(%temp,<kicksecs>,$duration($3-)) | return %temp }
  if ($1 == ban) { var %temp = $readini $scriptdirflood.ini Messages Ban | %temp = $replace(%temp,<bans>,$2 Bans) | %temp = $replace(%temp,<bansecs>,$duration($3-)) | return %temp }
  if ($1 == invite) { var %temp = $readini $scriptdirflood.ini Messages Invite | %temp = $replace(%temp,<invites>,$2 Invites) | %temp = $replace(%temp,<invitesecs>,$duration($3-)) | return %temp }
  if ($1 == ctcp) { var %temp = $readini $scriptdirflood.ini Messages CTCP | %temp = $replace(%temp,<ctcps>,$2 CTCPs) | %temp = $replace(%temp,<ctcpsecs>,$duration($3-)) | return %temp }
}

on *:load:if ($exists($scriptdirflood2.mrc) != $true) { echo -a *** Flood2.mrc does not exist, uninstalling Flood Protection. | .unload -rs flood.mrc | return } | .load -rs $scriptdirflood2.mrc | echo -a *** Flood Protection v1 by datalogik Loaded! To access "Settings" use your menu/channel popups. | return
