;---------<  ProjectX mIRC Scripters Crew  >-----------
; Filename..: pxexplorer.mrc [ProjectX Explorer]
; Release...: v1.00
; Author....: Urmac
; Bugreport.: urmac@projectx.mx.dk
; Date......: March 11, 2000
; URL.......: http://www.projectx.mx.dk/
; E-mail....: info@projectx.mx.dk
; Extra.....: Don't try to handle too many files for a certain action.
;------------------------------------------------------

;-------- -  -
; Aliases
;-------- -  -
alias -l h halt
alias -l _a did -a $1-
alias -l _b did -b $1-
alias -l _c did -c $1-
alias -l _e did -e $1-
alias -l _h did -h $1-
alias -l _r did -r $1-
alias -l _ra did -ra $1-
alias -l _v did -v $1-
alias -l px.dir return $iif(%pxep.dirt || %pxep.dir,$iif(%pxep.dirt,%pxep.dirt,%pxep.dir),$scriptdir)
alias -l px.get return $readini -n projectx.ini $1 $$2
alias -l pxep.cfg return [ $shortfn($scriptdir) ] $+ pxexplorer.cfg
alias -l pxep.d _a pxexpl 5 $1 $2 $iif(($3) && ($4 == $null),$3) | if ($3) && ($4) { _a pxexpl 5 $3- }
alias -l pxep.did1819 if (%pxep.tdir) { _ra pxexplmp 6 &DIR: | %pxep.temp = $sdir="Select Dir To Remove" $px.dir | unset %pxep.t } | else { unset %pxep.temp | %pxep.x = $dir="Select File To Remove" $px.dir } | if (%pxep.x) || (%pxep.temp) { _ra pxexplmp 7 $iif(%pxep.temp,%pxep.temp,%pxep.x) | _e pxexplmp 13 | _h pxexplmp 9,14,15,16,18,19 } | h
alias -l pxep.did189 _ra pxexpl 18 $iif(%pxep.ext,$findfile($px.dir,%pxep.ext,0,0),0) $iif($did(pxexpl,6).lines != 1,files,file) $chr(91) $+ $pxep.size(%pxep.total) $+ $chr(93) | _ra pxexpl 19 [Free: $pxep.size($disk($iif($1,$1-,$px.dir)).free) $+ $chr(93)
alias -l pxep.did26 var %pxep.temp = $sdir="Select Directory to Move File" $px.dir | if (%pxep.temp) { _ra pxexplmp 25 %pxep.temp | _e pxexplmp 28 }
alias -l pxep.dir {
  goto %pxep.#
  :1 | _r pxexplmp 7 | _b pxexplmp 13 | _h pxexplmp 8,9,10,11,15,16,38,39,45 | _v pxexplmp 14,18,19 | h
  :2 | %pxep.x = $dir="Select File To Move" $px.dir | if (%pxep.x) { _ra pxexplmp 21 $nopath(%pxep.x) | _ra pxexplmp 23 $nofile(%pxep.x) | _h pxexplmp 12 | _v pxexplmp 24,25,26 } | h
  :3 | %pxep.x = $dir="Select File To Rename" $px.dir | if (%pxep.x) { _ra pxexplmp 31 $nopath(%pxep.x) | _ra pxexplmp 33 $nofile(%pxep.x) | _v pxexplmp 34,35 } | h
  :4 | %pxep.temp = $sdir="Select Dir To Make A Dir" $px.dir | if (%pxep.temp) { _ra pxexplmp 43 %pxep.temp | if ($did(pxexplmp,41).text) { _e pxexplmp 44 } } | h
  :5 | %pxep.x = $dir="Select File To Send" $px.dir | if (%pxep.x) { _ra pxexplmp 53 $nopath(%pxep.x) | did -ra pxexplmp 55 $nofile(%pxep.x) | _ra pxexplmp 57 Size: $pxep.size($file($iif(%pxep.x,%pxep.x,%pxep.nfo)).size) | _h pxexplmp 58 } | h
}
alias pxep.fc if ($dialog(pxexpl)) { if ($timer(pxexpl)) { if (/.. == $did(pxexpl,4,1).text) { if ($finddir($px.dir,*,0,0)) { var %pxep.fc = $calc($did(pxexpl,4).lines - 1) } | else { var %pxep.fc = 0 } } | else { var %pxep.fc = $did(pxexpl,4).lines } | if ($numtok(%pxep.ext,44) > 1) { var %pxep.rf,%pxep.rft = 0 | :l | inc %pxep.rft | if (%pxep.rft > $numtok(%pxep.ext,44)) { goto e } | else { inc %pxep.rf $findfile($px.dir,$gettok(%pxep.ext,%pxep.rft,44),0,1) | goto l } } | :e | if ($findfile($px.dir,%pxep.ext,0,0) != $did(pxexpl,6).lines) || ($finddir($px.dir,*,0,0) != %pxep.fc) { .timerpxexpl off | _r pxexpl 4,6 | _h pxexpl 16,17,12,13,21,23,24 | pxep.fd | h } } } | else { unset %pxep* | .timerpxexpl off | h }
alias -l pxep.fd unset %pxep.num %pxep.total | var %pxep.temp = $finddir($px.dir,*,0,1,_a pxexpl 4 $nopath($1-)) | $iif($numtok($px.dir,92) >= 2,_a pxexpl 4 /..) | if (%pxep.ext) { if ($numtok(%pxep.ext,44) == 1) { if ($findfile($px.dir,%pxep.ext,0,1) > 0) { var %pxep.temp2 = $findfile($px.dir,%pxep.ext,0,1,pxep.file $1-) } | else { pxep.did189 } } | else { pxep.fd1 } } | else { pxep.did189 }
alias -l pxep.fd1 unset %pxep.total | $iif(($numtok($px.dir,92) >= 2) && ($did(pxexpl,4,1).text != /..),_a pxexpl 4 /..) | var %pxep.temp, %pxep.temp2 = 0 | :l | inc %pxep.temp2 | if (%pxep.temp2 > $numtok(%pxep.ext,44)) { pxep.did189 } | else { var %pxep.temp4 = $findfile($px.dir,$gettok(%pxep.ext,%pxep.temp2,44),0,1,pxep.file $1-) | goto l }
alias -l pxep.file did -a pxexpl 6 $nopath($1-) | inc %pxep.total $file($1-).size | inc %pxep.num | if ($numtok(%pxep.ext,44) == 1) { if (%pxep.num == $findfile($nofile($1-),%pxep.ext,0,0)) { pxep.did189 } } | else { if (%pxep.num == $findfile($nofile($1-),$gettok(%pxep.ext,%pxep.temp2,44),0,0)) { pxep.did189 $nofile($1-) } }
alias -l pxep.hd did -r pxexpl 3 | var %pxep.temp = 64, %pxep.temp2 = 0 | :l | inc %pxep.temp | if ($disk($chr(%pxep.temp)).type) { if ($disk($chr(%pxep.temp)).type == removable) { _a pxexpl 3 < $+ $upper($chr(%pxep.temp)) $+ :\> } | else { _a pxexpl 3 < $+ $upper($chr(%pxep.temp)) $+ :\ $+ $disk($chr(%pxep.temp)).label $+ > } | goto l } | else { inc %pxep.temp2 | if (%pxep.temp2 > 2) { %pxep.dir = $iif(%pxep.dir,%pxep.dir,C:\) } | else { goto l } }
alias -l pxep.l var %pxep.lt = 0 | :l | inc %pxep.lt | if (%pxep.lt <= $did(pxexpl,3).lines) { if (%pxep.dir == $mid($did(pxexpl,3,%pxep.lt).text,2,3)) { _c pxexpl 3 %pxep.lt | h } | else { goto l } }
alias -l pxep.size if ($1 == $null) { return 0 bytes } | if ($1 < 1000) { return $round($1,0) bytes } | if ($1 < 1000000) { return $round($calc($1 /1024),2) KB } | if ($1 < $calc(10^9)) { return $round($calc($1 /1024^2),2) MB } | if ($1 < $calc(10^12)) { return $round($calc($1 /1024^3),2) GB } | if ($1 < $calc(10^15)) { return $round($calc($1 /1024^4),2) TB }
alias -l pxep.slist var %pxep.temp = 0 | :l | inc %pxep.temp | if (%pxep.temp > $lines($pxep.cfg)) { _c pxexpls 8 1 | h } | else { var %pxep.temp2 = $read -l $+ %pxep.temp $pxep.cfg | if (%pxep.temp == 1) { _ra pxexpls 5 $gettok(%pxep.temp2,2,94) | _ra pxexpls 7 $gettok(%pxep.temp2,3,94) | _ra pxexpls 15 $gettok(%pxep.temp2,4,94) } | _a pxexpls 8 $gettok(%pxep.temp2,1,94) | goto l }

;-------- -  -
; Dialog
;-------- -  -
dialog pxexpl {
  title "PxExplorer v1.00"
  size -1 -1 574 363
  box "General:", 2, 6 2 483 355
  combo 3, 16 19 228 131,drop size
  list 4, 15 48 230 254,sort
  text "", 18, 15 294 210 13
  text "", 19, 15 313 210 13
  check "Auto Refresh", 25, 15 332 81 13,right
  combo 5, 251 19 228 196,drop size
  edit "*.*", 14, 250 48 170 20,return multi left
  button "&Scan", 15, 428 49 50 18
  list 6, 250 74 230 214,sort extsel
  text "", 16, 250 294 227 13
  text "", 17, 250 332 104 13
  text "", 24, 250 313 170 13
  check "Repeat", 23, 423 332 56 13,right,hide
  button "&Run", 7, 497 8 71 25
  button "&Delete", 8, 497 44 71 25
  button "M&ove", 22, 497 80 71 25
  button "R&ename", 9, 497 116 71 25
  button "&Make DIR", 10, 497 152 71 25
  button "Dcc Se&nd", 11, 497 188 71 25
  button "Add S&hortcut", 20, 497 224 71 25
  button "&View", 21, 497 260 71 25,hide
  button "&Listen", 12, 497 296 71 25,hide
  button "S&top", 13, 497 296 71 25,hide
  button "&Close", 1, 497 332 71 25,ok
}
dialog pxexpls {
  title "Shortcuts For You!"
  size -1 -1 376 188
  box "&Shortcuts:", 13, 5 2 365 180
  list 8, 13 18 113 124,size
  text "File:", 6, 132 18 18 13
  edit "", 7, 131 33 230 21,return multi read autohs
  text "Path:", 4, 132 62 24 13
  edit "", 5, 131 77 230 21,return multi read autohs
  text "Description:", 14, 132 106 55 13
  edit "", 15, 131 121 230 21,return multi read autohs
  button "&Add", 9, 14 151 57 21
  button "&Edit", 11, 86 151 57 21
  button "&Remove", 10, 158 151 57 21
  button "&Run", 12, 230 151 57 21
  button "&OK", 1, 303 151 57 21,ok
}
dialog pxexple {
  title "Edit Shortcut"
  size -1 -1 251 135
  text "File:",1,7 8 19 13
  edit "",2,40 5 130 20,return multi left autohs
  text "Path:",3,7 35 24 13
  edit "",4,40 32 130 20,return multi left autohs
  text "Label:",5,7 62 28 13
  edit "",6,40 59 90 20,return multi left autohs
  text "Description:",7,7 89 55 13
  edit "",8,7 109 162 20,return multi left autohs
  button "&Ok",9,177 79 67 19
  text "",11,140 62 100 13,return multi hide
  button "&Cancel",10,177 109 67 19,ok
}
dialog pxexpla {
  title "Add A Shortcut"
  size -1 -1 251 135
  text "File:",6,7 8 19 13
  edit "",7,40 5 130 20,return multi left autohs
  text "Path:",4,7 35 24 13
  edit "",5,40 32 130 20,return multi left autohs
  text "Label:",2,7 62 28 13
  edit "",3,40 59 90 20,return multi left autohs
  text "Description:",12,7 89 55 13
  edit "",13,7 109 162 20,return multi left autohs
  button "&Search",9,177 5 67 19
  button "&Add",8,177 79 67 19
  button "&Cancel",10,177 109 67 19,ok
  text "",11,140 62 100 13,hide
}
dialog pxexplmp {
  title "PxExplorer v1.00 "
  option dbu
  size -1 -1 188 124
  tab "&Delete", 1, 4 2 179 116
  tab "&Move", 2
  tab "&Rename", 3
  tab "&Make DIR", 4
  tab "&Dcc Send", 5

  text "&File:", 6, 8 21 12 7,tab1
  edit "", 7, 21 20 159 11,return multi left autohs tab1
  box "Are you sure?", 8, 8 40 171 31,hide
  box "Removed:", 9, 8 40 171 54,hide
  box "Remove a file or a dir?", 14, 8 40 171 31,hide
  box "Error:", 45, 8 40 171 30,hide
  button "&File", 18, 19 51 68 13,hide
  button "&DIR", 19, 100 51 68 13,hide
  button "&Yes", 10, 19 51 68 13,hide
  button "&No", 11, 100 51 68 13,hide
  edit "", 15, 12 51 163 11,return read multi left autohs hide
  edit "", 16, 12 75 163 11,return multi read left autohs hide
  button "&Remove", 13, 75 101 36 13,tab1
  text "To select multiple files, press &OK, select the files you want removed", 38, 8 75 158 7,hide
  text "press the &Delete button, and follow with the regular removal procedure.", 39, 8 85 168 7,hide

  text "&File:", 20, 8 21 9 7,tab2
  edit "", 21, 21 20 159 11,return multi read left autohs tab2
  text "&Dir:", 22, 8 41 9 7,tab2
  edit "", 23, 21 40 159 11,return multi read left autohs tab2
  text "&To:", 24, 8 61 9 7,hide
  edit "", 25, 21 60 159 11,return multi left autohs hide
  button "&DIR Search", 26, 8 101 36 13,hide
  button "&Move", 28, 75 101 36 13,tab2

  text "&File:", 30, 8 21 9 7,tab3
  edit "", 31, 21 20 159 11,return multi read left autohs tab3
  text "&Dir:", 32, 8 41 9 7,tab3
  edit "", 33, 21 40 159 11,return multi read left autohs tab3
  text "&To:", 34, 8 61 9 7,hide
  edit "", 35, 21 60 159 11,return multi left autohs hide
  button "&Rename", 36, 75 101 36 13,tab3
  text "", 37, 8 81 160 7,hide

  text "&DIR Name:", 40, 8 21 27 7,tab4
  edit "", 41, 36 20 144 11,return multi left autohs tab4
  text "&Main DIR:", 42, 8 41 24 7,tab4
  edit "", 43, 36 40 144 11,return multi read left autohs tab4
  button "&Make DIR", 44, 75 101 36 13,tab4

  text "&Nick:", 50, 8 21 12 7,tab5
  edit "", 51, 21 20 59 11,return multi left autohs tab5
  text "&File:", 52, 8 41 9 7,tab5
  edit "", 53, 21 40 159 11,return multi read left autohs tab5
  text "&Dir:", 54, 8 61 9 7,tab5
  edit "", 55, 21 60 159 11,return multi read multi left autohs tab5
  button "&Send", 56, 75 101 36 13,tab5
  text "", 57, 111 21 55 7,tab5
  text "", 58, 8 81 160 7,hide

  button "&Browse", 12, 8 101 36 13,hide
  button "&Close", 17, 143 101 36 13,ok
}
on *:dialog:pxex*:init:0:{
  goto $dname
  :pxexpl
  pxep.d Other (*...) All files (*.*)
  pxep.d INI (*.ini) Zip (*.zip)
  pxep.d Help (*.hlp) Log (*.log)
  pxep.d MRC (*.mrc) MIM (*.mim)
  pxep.d Doc (*.doc) Text (*.txt,*.text)
  pxep.d Executable (*.exe) HTML (*.html,*.htm,*.shtml)
  pxep.d Winamp (*.m3u,*.pls,*.mp*,*.vqf) CDDA (*.cda)
  pxep.d WAV (*.wav) MIDI (*.midi,*.mid,*.smf,*.kar,*.rmi)
  pxep.d AU Audio (*.au,*.snd,*.ulw)
  pxep.d AIFF Audio (*.aiff,*.aif,*.aifc)
  pxep.d Windows Video (*.avi)
  pxep.d Quicktime Video (*.mov,*.qt)
  pxep.d MPEG Video (*.mpg,*.mpeg)
  pxep.d RealPlayer (*.ram,*.rmm,*.ra,*.rm) GIF (*.gif)
  pxep.d BMP (*.bmp,*.rle,*.ico) JPEG (*.jpg,*.jpeg,*.jpe)
  pxep.d PICT (*.pct,*.pic) TIFF (*.tif)
  pxep.d Photoshop (*.psd,*.pdd) GEM (*.img)
  pxep.d Quicktime (*.qtif,*.qti) MacPaint (*.mac)
  pxep.d MSPaint (*.msp) Paint Shop Pro (*.psp)
  _c pxexpl 5 %pxep.ext.n | _b pxexpl 7
  if (%pxep.ext == $null) { %pxep.ext = *.* | %pxep.ext.n = 2 | _c pxexpl 5 2 }
  if ($px.get(Explorer,Refresh)) { _c pxexpl 25 | .timerpxexpl 0 0 /pxep.fc } | pxep.hd | pxep.fd | pxep.l | h
  :pxexpls | $iif($isfile($pxep.cfg) == $false,h,pxep.slist)
  :pxexpla | h
  :pxexple
  var %pxep.ftemp = $read -l $+ $did(pxexpls,8).sel $pxep.cfg
  _a pxexple 6 $gettok(%pxep.ftemp,1,94)
  _a pxexple 4 $nofile($gettok(%pxep.ftemp,2,94))
  _a pxexple 2 $gettok(%pxep.ftemp,3,94)
  _a pxexple 8 $gettok(%pxep.ftemp,4,94) | h
  :pxexplmp | h
}
on *:dialog:pxexplmp:sclick:*:{
  goto $did
  :1 {
    %pxep.# = 1 | _ra pxexplmp 6 &File:
    did -vra pxexplmp 12 &Browse | _h pxexplmp 24,25,26,34,35,37,58
    if (%pxep.nfo) || (%pxep.x) || ($chr(44) isin $did(21).text) {
      _e pxexplmp 13 | if ($chr(44) !isin $did(21).text) { _v pxexplmp 38,39 }
      _ra pxexplmp 7 $iif((%pxep.nfo) || (%pxep.x),$nofile($iif(%pxep.nfo,%pxep.nfo,%pxep.x)),$px.dir) $+ $nopath($iif(%pxep.nfo || %pxep.x,$iif(%pxep.x,%pxep.x,%pxep.nfo),$did(21).text))
    }
    else { _b pxexplmp 13 } | h
  }
  :2 {
    %pxep.# = 2 | _h pxexplmp 8,9,10,11,12,15,16,18,19,26,34,35,37,38,39,45,58
    _b pxexplmp 28 | _ra pxexplmp 12 &Browse | _v pxexplmp $iif(%pxep.nfo || %pxep.x,26,12)
    _ra pxexplmp 23 $iif((%pxep.nfo) || (%pxep.x),$nofile($iif(%pxep.nfo,%pxep.nfo,%pxep.x)),$px.dir)
    if (%pxep.nfo) || (%pxep.x) || ($chr(44) isin $did(7).text) {
      _v pxexplmp 24,25 | if ($chr(44) isin $did(7).text) { _h pxexplmp 12 | _v pxexplmp 26 }
      _ra pxexplmp 21 $nopath($iif(%pxep.nfo || %pxep.x,$iif(%pxep.x,%pxep.x,%pxep.nfo),$did(7).text))
    } | h
  }
  :3 {
    %pxep.# = 3 | _h pxexplmp 8,9,10,11,15,16,18,19,24,25,26,38,39,45,58
    _b pxexplmp 36 | _ra pxexplmp 33 $iif((%pxep.nfo) || (%pxep.x),$nofile($iif(%pxep.nfo,%pxep.nfo,%pxep.x)),$px.dir) | did -vra pxexplmp 12 &Browse
    if (%pxep.nfo) || (%pxep.x) { _ra pxexplmp 31 $nopath($iif(%pxep.x,%pxep.x,%pxep.nfo)) | _v pxexplmp 34,35 } | h
  }
  :4 {
    %pxep.# = 4 | _b pxexplmp 44
    _ra pxexplmp 43 $iif((%pxep.nfo) || (%pxep.x),$nofile($iif(%pxep.nfo,%pxep.nfo,%pxep.x)),$px.dir) | did -vra pxexplmp 12 &DIR Browse
    _h pxexplmp 8,9,10,11,15,16,18,19,24,25,26,34,35,37,38,39,45,58 | h
  }
  :5 {
    %pxep.# = 5 | _ra pxexplmp 55 $iif((%pxep.nfo) || (%pxep.x),$nofile($iif(%pxep.nfo,%pxep.nfo,%pxep.x)),$px.dir) | did -vra pxexplmp 12 &Browse
    _h pxexplmp 8,9,10,11,15,16,18,19,24,25,26,34,35,37,38,39,45 | $iif(($server) && ($did(41).text),_e pxexplmp 56,_b pxexplmp 56)
    if (%pxep.nfo) || (%pxep.x) {
      _ra pxexplmp 53 $nopath($iif(%pxep.x,%pxep.x,%pxep.nfo))
      _ra pxexplmp 57 Size: $pxep.size($file($iif(%pxep.x,%pxep.x,%pxep.nfo)).size)
    } | h
  }
  :10 {
    _h pxexplmp 8,10,11
    if (%pxep.t) {
      var %pxep.temp = 0
      :d | inc %pxep.temp
      if (%pxep.temp > $did(pxexpl,6,0).sel) {
        did -vra pxexplmp 15 $nofile($did(7).text)
        did -vra pxexplmp 16 $nopath($did(7).text)
        _r pxexpl 23 | _r pxexplmp 7 | _v pxexplmp 9
        _b pxexplmp 13 | _h pxexplmp 26 | _r pxexpl 4,6,16,17,24 | pxep.fd | unset %pxep.t | h
      }
      else {
        var %pxep.temp2 = $px.dir $+ $remtok($nopath($gettok($did(pxexplmp,7).text,%pxep.temp,44)),$chr(32),1,32)
        if ($isfile(%pxep.temp2)) { .remove " $+ %pxep.temp2 $+ " | goto d } | else { goto d }
      }
    }
    else {
      if (%pxep.tdir) { %pxep.tdir = $did(7).text | goto rdir }
      elseif ($isfile($did(7).text) == $false) && (%pxep.tdir == $null) { did -vra pxexplmp 15 This file does not exist. | h }
      .remove " $+ $did(7).text $+ "
      did -vra pxexplmp 15 $nofile($did(7).text)
      did -vra pxexplmp 16 $nopath($did(7).text)
      _b pxexplmp 13 | _r pxexpl 4,6,16,17,24
      _h pxexpl 23 | _r pxexplmp 7 | _v pxexplmp 9
      unset %pxep.nfo %pxep.x %pxep.file | pxep.fd | h
      :rdir {
        if ($findfile(%pxep.tdir,*.*,0,0)) || ($finddir(%pxep.tdir,*.*,0,0)) { did -vra pxexplmp 15 Error: There are files or dirs in the selected DIR. | _h pxexplmp 38,39 | h }
        did -vra pxexplmp 15 %pxep.tdir | .rmdir " $+ %pxep.tdir $+ "
        _h pxexpl 23 | _r pxexplmp 7 | _v pxexplmp 9
        _r pxexpl 4,6,16,17,24 | unset %pxep.nfo %pxep.x %pxep.file | pxep.fd
      }
    } | h
  }
  :11 | _h pxexplmp 8,10,11 | h
  :12 | .timer 1 0 pxep.dir | h
  :13 {
    _h pxexplmp 9,15,16,38,39
    var %pxexp $shortfn($scriptdir) $+ pxexplorer.mrc
    if ($did(7).text == $script) { did -va pxexplmp 15 You can't remove pxexplorer2.mrc | _v pxexplmp 45 }
    elseif ($did(7).text == %pxexp) { did -va pxexplmp 15 You can't remove pxexplorer.mrc | _v pxexplmp 45 }
    else _v pxexplmp 8,10,11 | h
  }
  :17 | unset %pxep.x %pxep.tdir %pxep.# %pxep.t | dialog -x pxexplmp | h
  :18 | unset %pxep.tdir | .timer 1 0 pxep.did1819 | h
  :19 | %pxep.tdir = 1 | .timer 1 0 pxep.did1819 | h
  :26 | .timer 1 0 pxep.did26 | h
  :28 {
    if ($right($did(25).text,1) != \) { _ra pxexplmp 25 $did(25).text $+ \ }
    if (%pxep.t) {
      var %pxep.temp = 0 | goto m | :m | inc %pxep.temp
      if (%pxep.temp > $did(pxexpl,6,0).sel) {
        if (%pxep2) {
          var %pxep2 = $remtok(%pxep2,$numtok(%pxep2,94),94), %pxep3 = 0 | goto m2
          :m2 | inc %pxep3
          if (%pxep3 > $numtok(%pxep2,94)) { if ($mid($did(21).text,$len($did(21).text),1) == $chr(44)) { _ra pxexplmp 21 $remtok($did(21).text,$numtok($did(21).text,44),44) } | goto m3 }
          else { _ra pxexplmp 21 $remove($did(pxexplmp,21).text,$gettok($did(pxexplmp,21).text,$gettok(%pxep2,%pxep3,94),44) $+ $chr(44)) | goto m2 }
        }
        else { goto m3 }
        :m3 | _ra pxexplmp 21 Moved $nopath($did(21).text) to | _ra pxexplmp 23 $did(25).text | _h pxexpl 23 | _b pxexplmp 28
        _h pxexplmp 24,25 | _r pxexpl 4,6,16,17,24 | pxep.fd | h
      }
      else {
        var %pxep = $did(21).text, %pxep.temp2 = $did(25).text $+ $remtok($nopath($gettok($did(pxexplmp,21).text,%pxep.temp,44)),$chr(32),1,32), %pxep.temp3 = $px.dir $+ $nopath(%pxep.temp2)
        if ($isfile(%pxep.temp2)) { var %pxep2 = %pxep2 $+ %pxep.temp $+ ^ | goto m }
        elseif ($isfile(%pxep.temp3)) { .rename " $+ %pxep.temp3 $+ " " $+ %pxep.temp2 $+ " | goto m } | else { goto m }
      }
    }
    else {
      var %pxep.ftemp = $did(23).text $+ $did(21).text
      if ($isfile(%pxep.ftemp)) && ($isdir($did(25).text)) {
        if ($findfile($did(25).text,$did(21).text,0,1)) {
          _ra pxexplmp 23 $did(25).text | _ra pxexplmp 21 Error: Filename exists in
          _v pxexplmp 12 | _b pxexplmp 28 | _h pxexplmp 24,25,26 | _r pxexplmp 25 | h
        }
        .rename " $+ %pxep.ftemp $+ " " $+ $did(25).text $+ $did(21).text $+ "
        _ra pxexplmp 23 $did(25).text
        _ra pxexplmp 21 $did(21).text has been moved to
        _h pxexpl 23 | _r pxexplmp 25 | _v pxexplmp 12
        _b pxexplmp 28 | _h pxexplmp 24,25,26
        _r pxexpl 4,6,16,17,24 | unset %pxep.file %pxep.nfo | pxep.fd | h
      }
      else {
        if ($did(25).text == $null) { h }
        elseif ($isdir($nofile($did(25).text)) == $false) { _ra pxexplmp 23 Error: Invalid Dir | _b pxexplmp 28 }
        elseif ($isfile(%pxep.ftemp) == $false) { _ra pxexplmp 21 Error: Invalid Filename | _b pxexplmp 28 }
      } | h
    }
  }
  :29 | _h pxexplmp 14,18,29 | _v pxexplmp 38,39 | h
  :36 {
    if ($did(35).text == $null) { h }
    if ($right($did(33).text,1) != \) { _ra pxexplmp 33 $did(33).text $+ \ }
    var %pxep.temp = $did(33).text $+ $did(35).text, %pxep.temp1 = $did(33).text $+ $did(31).text, %pxep.temp2 = $gettok($did(31).text,$numtok($did(31).text,46),46)
    if (%pxep.temp == %pxep.temp1) { _r pxexplmp 35 | _b pxexplmp 36 | h }
    elseif ($isdir($did(33).text) == $false) { did -vra pxexplmp 37 Error: Directory does not exist. | h }
    elseif ($isfile(%pxep.temp)) { did -vra pxexplmp 37 Error: File already exists. | h }
    else {
      if ($right(%pxep.temp,$len(%pxep.temp2)) == %pxep.temp2) { .rename " $+ %pxep.temp1 $+ " " $+ %pxep.temp $+ " | _ra pxexplmp 33 $did(35).text | goto e }
      else { .rename " $+ %pxep.temp1 $+ " " $+ %pxep.temp $+ . $+ %pxep.temp2 $+ " | _ra pxexplmp 33 $did(35).text $+ . $+ %pxep.temp2 | goto e }
      :e | _ra pxexplmp 31 Rename $did(31).text to | _h pxexpl 23 | _r pxexplmp 35 | _b pxexplmp 36
      _h pxexplmp 34,35,37 | _r pxexpl 4,6,16,17,24 | pxep.fd | unset %pxep.nfo %pxep.x %pxep.file | h
    }
  }
  :44 {
    if ($right($did(41).text,1) == \) { _ra pxexplmp 41 $remove($did(41).text,\) }
    var %pxep.temp = $did(43).text $+ $did(41).text
    if ($isdir(%pxep.temp)) { _r pxexplmp 41,43 | _ra pxexplmp 43 Error: This DIR already exists. | _b pxexplmp 44 | h }
    else {
      .mkdir " $+ %pxep.temp $+ " | _ra pxexplmp 41 The $did(41).text directory is now under
      _h pxexpl 23 | _b pxexplmp 44 | _r pxexpl 4,6,16,17,24 | unset %pxep.file %pxep.nfo | pxep.fd | h
    }
  }
  :56 | did -vra pxexplmp 58 Checking to see if nick is online... | .enable #pxep.ncheck | ison $did(51).text
}

;-------- -  -
; Remote
;-------- -  -
on *:load:if ($script(pxexplorer.mrc)) { h } | .load -rs $shortfn($scriptdir) $+ pxexplorer.mrc
