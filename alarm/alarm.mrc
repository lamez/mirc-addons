alias alarm /dialog -m alarm alarm
dialog alarm {
  title "Alarm"
  size -1 -1 142 105
  option dbu
  box "Time:", 1, 2 3 51 37
  text "Hour:", 2, 10 12 15 8
  edit "", 3, 10 21 12 10, limit 2
  text ":", 17, 25 21 21 8
  text "Minutes:", 4, 28 12 21 8
  edit "", 5, 30 21 12 10, limit 2
  box "Message", 6, 59 3 79 28
  edit "", 7, 61 13 75 11, autovs autohs
  box "Sound", 8, 1 42 137 39
  edit "", 9, 47 50 50 10, autohs
  button "Browse", 10, 98 50 27 10
  text "Select sound file:", 11, 6 51 41 8
  text "Repeat times:", 12, 7 70 36 8
  edit "", 13, 42 68 19 10
  text "(Type 0 for loop)", 14, 65 69 55 30
  button "Activate", 15, 20 86 37 12, flat ok
  button "Cancel", 16, 75 86 37 12, flat cancel
}
on *:dialog:alarm:sclick:*:{
  if ($did == 15) {
    if ($timer(alarm) == 1) { 
      /splay stop
      //.timeralarm off
      /error Alarm Stopped
      /did -ra alarm 15 Activate
      /halt
    }
    if ($len($did(3).text) >= 2) && ($len($did(5).text) >= 2) { 
      if ($did(13).text == $null) { /error Enter some number for the repeat, or type 0 (null) for loop | halt }
      //.timeralarm $did(3).text $+ $chr(58) $+ $did(5).text $did(13).text 1 /wakeup
      /set %scr.sounds on
      /set %alarm.sound $did(9).text
      if ($did(7).text !== $null) { /set %alarm.msg $did(7).text }
      /set %alarm.time $did(3).text $did(5).text
      /set %alarm.repeat $did(13).text
      /error Alarm Activated for $did(3).text $+ $chr(58) $+ $did(5).text $+ ! ( $+ $did(7).text $+ )
    }
    else { /error Please enter a valid time! $crlf Exampe: 22 : 30 | halt }
  }
  if ($did == 10) { /set %alarm.sound $sfile($mircdir) | /did -ra alarm 9 %alarm.sound }
}
on *:dialog:alarm:init:*:{
  if ($timer(alarm) == 1) { 
    /did -ra alarm 3 $gettok(%alarm.time,1,32)
    /did -ra alarm 5 $gettok(%alarm.time,2,32)
    /did -ra alarm 15 Stop!
  }
  if (%alarm.sound == $null) { /set %alarm.sound sounds\kuku.wav }
  /did -ra alarm 9 %alarm.sound
  /did -ra alarm 13 %alarm.repeat
  if (%alarm.msg !== $null) { /did -ra alarm 7 %alarm.msg }
}
alias wakeup {
  if (%alarm.sound == $null) { /set %alarm.sound sounds\kuku.wav }
  //.splay %alarm.sound
  if ($dialog(alarm-wake) == $null) { /dialog -m alarm-wake alarm-wake }
}
dialog alarm-wake {
  title "ALARM!!!"
  icon data\icons\alarm.ico
  size 120 150 193 35
  option dbu
  button "STOP!", 10, 27 17 137 11, cancel,
  text "", 20, 6 5 181 6, center,
}
on *:dialog:alarm-wake:init:*:{
  if (%alarm.msg !== $null) { /did -a alarm-wake 20 %alarm.msg }
}
on *:dialog:alarm-wake:sclick:10:{
  /splay stop
  //.timeralarm off
  /error Alarm Stopped
}
;
