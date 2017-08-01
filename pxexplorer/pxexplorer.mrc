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
alias -l e_va did -va pxexple 11 $1-
alias -l a_va did -va pxexpla 11 $1-
alias -l _a did -a $1-
alias -l _b did -b $1-
alias -l _c did -c $1-
alias -l _e did -e $1-
alias -l _h did -h $1-
alias -l _r did -r $1-
alias -l _ra did -ra $1-
alias -l _v did -v $1-
alias -l _va did -va $1-
alias -l exs window -c @PxExpl_BMP-View | dialog -m pxexpl pxexpl
alias -l px.dir return $iif(%pxep.dirt || %pxep.dir,$iif(%pxep.dirt,%pxep.dirt,%pxep.dir),$scriptdir)
alias -l pxep.cfg return [ $shortfn($scriptdir) ] $+ pxexplorer.cfg
alias -l pxep.check if ($isfile($pxep.cfg) == $false) { return $1 } | var %pxep.temp, %pxep.temp2 = 0 | :l | inc %pxep.temp | var %pxep.ftemp = $read -l $+ %pxep.temp $pxep.cfg | if (%pxep.temp > $lines($pxep.cfg)) { if (%pxep.temp2 > 0) { return $1 $+ ( $+ %pxep.temp2 $+ ) } | else { return $1 } } | if ($gettok($gettok(%pxep.ftemp,1,40),1,94) == $1) { inc %pxep.temp2 | goto l } | goto l
alias -l pxep.did15 var %pxep = $did(pxexpl,14).text, %pxep1 = 1, %pxep3 = 0 | :l | inc %pxep1 | var %pxep2 = $remove($gettok($did(pxexpl,5,%pxep1).text,2,40),$chr(41)) | if (%pxep1 < $did(pxexpl,5).lines) { :1 | inc %pxep3 | if (%pxep3 > $numtok(%pxep2,44)) { %pxep3 = 0 | goto l } | else { if (%pxep == $gettok(%pxep2,%pxep3,44)) { _c pxexpl 5 %pxep1 | %pxep.ext.n = %pxep1 } | else { goto 1 } } } | else { _c pxexpl 5 1 }
alias -l pxep.did1819 if (%pxep.tdir) { _ra pxexplmp 6 &File: | %pxep.temp = $sdir="Select Dir To Remove" $px.dir } | else { %pxep.x = $dir="Select File To Remove" $px.dir } | if (%pxep.x) || (%pxep.temp) { _ra pxexplmp 7 $iif(%pxep.temp,%pxep.temp,%pxep.x) | _e pxexplmp 13 | _h pxexplmp 9,14,15,16,18,19,29 }
alias -l pxep.did189 _ra pxexpl 18 $iif(%pxep.ext,$findfile($px.dir,%pxep.ext,0,0),0) $iif($did(pxexpl,6).lines != 1,files,file) $chr(91) $+ $pxep.size(%pxep.total) $+ $chr(93) | _ra pxexpl 19 [Free: $pxep.size($disk($iif($1,$1-,$px.dir)).free) $+ $chr(93)
alias -l pxep.did26 var %pxep.temp = $sdir="Select Directory to Move File" $px.dir | if (%pxep.temp) { _ra pxexplmp 25 %pxep.temp | _e pxexplmp 28 }
alias -l pxep.did5 %pxep.ext = $remove($gettok($did(pxexpl,5,$did(pxexpl,5).sel).text,2,40),$chr(41)) | %pxep.ext.n = $did(pxexpl,5).sel | if ($numtok(%pxep.ext,44) > 1) { var %pxep.temp = $finddir($px.dir,*,0,1,_a pxexpl 4 $nopath($1-)) | pxep.fd1 } | else { pxep.fd }
alias -l pxep.did9 var %pxep.temp = $dir="Select Shortcut To Add" $px.dir | if (%pxep.temp) { _ra pxexpla 5 $nofile(%pxep.temp) | _ra pxexpla 7 $gettok(%pxep.temp,$numtok(%pxep.temp,92),92) }
alias -l pxep.dir {
  goto %pxep.#
  :1 | _v pxexplmp 14,18,19 | h
  :2 | %pxep.x = $dir="Select File To Move" $px.dir | if (%pxep.x) { _ra pxexplmp 21 $nopath(%pxep.x) | _ra pxexplmp 23 $nofile(%pxep.x) | _h pxexplmp 12 | _v pxexplmp 24,25,26 } | h
  :3 | %pxep.x = $dir="Select File To Rename" $px.dir | if (%pxep.x) { _ra pxexplmp 31 $nopath(%pxep.x) | _ra pxexplmp 33 $nofile(%pxep.x) | _v pxexplmp 34,35 } | h
  :4 | %pxep.temp = $sdir="Select Dir To Make A Dir" $px.dir | if (%pxep.temp) { _ra pxexplmp 43 %pxep.temp | if ($did(pxexplmp,41).text) { _e pxexplmp 44 } } | h
  :5 | %pxep.x = $dir="Select File To Send" $px.dir | if (%pxep.x) { _ra pxexplmp 53 $nopath(%pxep.x) | _ra pxexplmp 55 $nofile(%pxep.x) | _ra pxexplmp 57 Size: $pxep.size($file($iif(%pxep.x,%pxep.x,%pxep.nfo)).size) | _h pxexplmp 58 } | h
}
alias -l pxep.fd {
  unset %pxep.num %pxep.total
  $iif($numtok($px.dir,92) >= 2,_a pxexpl 4 /..) | var %pxep.temp = $finddir($px.dir,*,0,1,_a pxexpl 4 $nopath($1-))
  if (%pxep.ext) {
    if ($numtok(%pxep.ext,44) == 1) {
      if ($findfile($px.dir,%pxep.ext,0,1) > 0) { var %pxep.temp2 = $findfile($px.dir,%pxep.ext,0,1,pxep.file $1-) }
      else { pxep.did189 }
    } | else { pxep.fd1 }
  } | else { pxep.did189 }
}
alias -l pxep.fd1 unset %pxep.total | $iif(($numtok($px.dir,92) >= 2) && ($did(pxexpl,4,1).text != /..),_a pxexpl 4 /..) | var %pxep.temp, %pxep.temp2 = 0 | :l | inc %pxep.temp2 | if (%pxep.temp2 > $numtok(%pxep.ext,44)) { pxep.did189 } | else { var %pxep.temp4 = $findfile($px.dir,$gettok(%pxep.ext,%pxep.temp2,44),0,1,pxep.file $1-) | goto l }
alias -l pxep.file if ($px.get(Explorer,Refresh)) && ($timer(pxexpl) == $null) { .timerpxexpl 0 0 /pxep.fc } | _a pxexpl 6 $nopath($1-) | inc %pxep.total $file($1-).size | inc %pxep.num | if ($numtok(%pxep.ext,44) == 1) { if (%pxep.num == $findfile($nofile($1-),%pxep.ext,0,0)) { pxep.did189 } } | else { if (%pxep.num == $findfile($nofile($1-),$gettok(%pxep.ext,%pxep.temp2,44),0,0)) { pxep.did189 $nofile($1-) } }
alias -l pxep.hd _r pxexpl 3 | var %pxep.temp = 64, %pxep.temp2 = 0 | :l | inc %pxep.temp | if ($disk($chr(%pxep.temp)).type) { if ($disk($chr(%pxep.temp)).type == removable) { _a pxexpl 3 < $+ $upper($chr(%pxep.temp)) $+ :\> } | else { _a pxexpl 3 < $+ $upper($chr(%pxep.temp)) $+ :\ $+ $disk($chr(%pxep.temp)).label $+ > } | goto l } | else { inc %pxep.temp2 | if (%pxep.temp2 > 2) { %pxep.dir = $iif(%pxep.dir,%pxep.dir,C:\) | pxep.l } | else { goto l } }
alias -l pxep.init {
  if ($1) { if ($dialog(pxexplmp)) { dialog -x pxexplmp } | dialog -m pxexplmp pxexplmp } | else { h }
  %pxep.# = $1 | unset %pxep.x | did -f pxexplmp $iif($1 > 5,$calc($1 - 5),$1) | if (%pxep.nfo == $null) { _v pxexplmp 12 } | goto $1
  :1 | _v pxexplmp 12,38,39 | if (%pxep.nfo) || (%pxep.tdir) { if (%pxep.tdir) { _ra pxexplmp 6 &DIR: } | _ra pxexplmp 7 $iif(%pxep.tdir,%pxep.tdir,%pxep.nfo) } | else { _b pxexplmp 13 } | h
  :2 | if (%pxep.nfo) { _h pxexplmp 12 | _ra pxexplmp 21 $nopath(%pxep.nfo) | _v pxexplmp 24,25,26 } | else { _h pxexplmp 24,25,26 } | _b pxexplmp 28 | _ra pxexplmp 23 $px.dir | h
  :3 | if (%pxep.nfo) { _ra pxexplmp 31 $nopath(%pxep.nfo) | _v pxexplmp 34,35 } | _b pxexplmp 36 | _ra pxexplmp 33 $px.dir | _v pxexplmp 12 | h
  :4 | did -vra pxexplmp 12 &DIR Search | _b pxexplmp 44 | _ra pxexplmp 43 $px.dir | h
  :5 | if (%pxep.nfo) { _ra pxexplmp 53 $nopath(%pxep.nfo) | _ra pxexplmp 57 Size: $pxep.size($file(%pxep.nfo).size) } | _v pxexplmp 12 | _ra pxexplmp 55 $px.dir | _b pxexplmp 56 | h
  :6 | %pxep.# = 1 | %pxep.t = 1 | var %pxep.temp = 0 | :l | inc %pxep.temp | if (%pxep.temp > $did(pxexpl,6,0).sel) { _ra pxexplmp 6 &Files: | h } | else { _ra pxexplmp 7 $iif(%pxep.temp == 1,$px.dir) $+ $did(pxexplmp,7).text $+ $iif(%pxep.temp > 1,$chr(44)) $did(pxexpl,6,$did(pxexpl,6,%pxep.temp).sel).text | goto l }
  :7 | %pxep.# = 2 | %pxep.t = 1 | var %pxep.temp = 0 | :l2 | inc %pxep.temp | if (%pxep.temp > $did(pxexpl,6,0).sel) { _ra pxexplmp 20 &Files: | _b pxexplmp 28 | _ra pxexplmp 23 $px.dir | _h pxexplmp 12 | _v pxexplmp 24,25,26 | h } | else { _ra pxexplmp 21 $did(pxexplmp,21).text $+ $iif(%pxep.temp > 1,$chr(44)) $did(pxexpl,6,$did(pxexpl,6,%pxep.temp).sel).text | goto l2 }
}
alias -l pxep.l var %pxep.lt = 0 | :l | inc %pxep.lt | if (%pxep.lt <= $did(pxexpl,3).lines) { if (%pxep.dir == $mid($did(pxexpl,3,%pxep.lt).text,2,3)) { _c pxexpl 3 %pxep.lt | h } | else { goto l } }
alias -l pxep.size if ($1 == $null) || ($1 < 1000) { return $iif($1,$round($1,0),0) $iif($1,$iif($1 != 1,bytes,byte),bytes) } | if ($1 < 1000000) { return $round($calc($1 /1024),2) KB } | if ($1 < $calc(10^9)) { return $round($calc($1 /1024^2),2) MB } | if ($1 < $calc(10^12)) { return $round($calc($1 /1024^3),2) GB } | if ($1 < $calc(10^15)) { return $round($calc($1 /1024^4),2) TB }
alias -l pxep.slist var %pxep.temp = 0 | :l | inc %pxep.temp | if (%pxep.temp > $lines($pxep.cfg)) { _c pxexpls 8 1 | h } | else { var %pxep.temp2 = $read -l $+ %pxep.temp $pxep.cfg | if (%pxep.temp == 1) { _ra pxexpls 5 $gettok(%pxep.temp2,2,94) | _ra pxexpls 7 $gettok(%pxep.temp2,3,94) | _ra pxexpls 15 $gettok(%pxep.temp2,4,94) } | _a pxexpls 8 $gettok(%pxep.temp2,1,94) | goto l }

;-------- -  -
; Popups
;-------- -  -
menu menubar,status,channel {
  ProjectX Explorer
  .&Run Explorer:if ($dialog(pxexpl) == $null) { unset %pxep* } | $iif($dialog(pxexpl),dialog -v pxexpl,dialog -m pxexpl pxexpl)
  .&Shortcuts:$iif($dialog(pxexpls),dialog -v pxexpls,dialog -m pxexpls pxexpls)
  .&Read Me:var %pxep.re = $scriptdir $+ \pxexplorer-readme.txt | if ($exists(%pxep.re)) { .run %pxep.re } | else { echo 4 -a Could not locate pxexplorer-readme.txt }
  .-
  .&Unload Explorer:if ($?!="Do you wish to unload $crlf ProjectX Explorer v1.00?") { unset %pxep* | .timerpxexpl off | $iif($dialog(pxexpls),dialog -x pxexpls) | $iif($dialog(pxexple),dialog -x pxexple) | $iif($dialog(pxexpla),dialog -x pxexpla) | $iif($dialog(pxexplmp),dialog -x pxexplmp) | unload -rs pxexplorer2.mrc | echo -s $px.lp Unload of PxExplorer v1.00 successful. | unload -rs pxexplorer.mrc }
  .-
  .ProjectX &Website:px.about | px.www http://www.projectx.mx.dk/px.html
}
menu @PxExpl_BMP-View {
  dclick:exs
  &Close:exs
}

;-------- -  -
; Remote
;-------- -  -
on *:start:var %pxep = $shortfn($scriptdir) $+ pxexplorer2.mrc | if ($version < 5.7) { echo $colour(info) -ae $px.lp ProjectX Explorer v1.00 requires mIRC 5.7 or higher. Visit http://www.mirc.com/ for the latest version of mIRC. | unload -rs $shortfn($script) | if ($script(%pxep)) { .unload -rs %pxep } | h } | else { if ($isfile(%pxep)) && ($script(%pxep) == $null) { .load -rs %pxep } | .events on }
on *:load:{
  var %pxep = $shortfn($scriptdir) $+ pxexplorer2.mrc
  if ($version < 5.7) { echo $colour(info) -ae $px.lp ProjectX Explorer v1.00 requires mIRC 5.7 or higher. Visit http://www.mirc.com/ for the latest version of mIRC. | unload -rs $shortfn($script) | .unload -rs %pxep | h }
  else {
    if ($isfile(%pxep)) { echo $colour(info) -ae $px.lp ProjectX Explorer v1.00 loaded. (by Urmac <urmac@projectx.mx.dk>) | .load -rs %pxep | px.info | px.about | .events on | h }
    else { echo $colour(info2) -ae $px.lp Error: Could not locate pxexplorer2.mrc. Visit http://www.projectx.mx.dk/ to download PxExplorer v1.00. | .timer 1 1 .unload -rs $shortfn($script) | h }
  }
}
on *:connect:.events on | $px.reg(PxExplorer,v1.00)
on *:disconnect:unset %px.using
on *:waveend:if ($dialog(pxexpl)) { $iif(($gettok(%pxep.file,2,46) == wav) || ($gettok(%pxep.file,2,46) == mid),_v pxexpl 12) | if (%pxep.repeat == on) && ($did(pxexpl,6,$did(pxexpl,6).sel).text == $nopath(%pxep.ptemp)) { .splay " $+ %pxep.ptemp $+ " | _v pxexpl 13 | _h pxexpl 12 | h } | else { _h pxexpl 13 } }
on *:midiend:if ($dialog(pxexpl)) { $iif(($gettok(%pxep.file,2,46) == wav) || ($gettok(%pxep.file,2,46) == mid),_v pxexpl 12) | if (%pxep.repeat == on) && ($did(pxexpl,6,$did(pxexpl,6).sel).text == $nopath(%pxep.ptemp)) { .splay " $+ %pxep.ptemp $+ " | _v pxexpl 13 | _h pxexpl 12 | h } | else { _h pxexpl 13 } }
on *:close:@PxExpl_BMP-View:dialog -m pxexpl pxexpl

#pxep.ncheck off
raw 303:*:if ($dialog(pxexplmp)) { if ($2) { _ra pxexplmp 58 Nick found. Now sending the file to $did(pxexplmp,51).text $+ . | dcc send $did(pxexplmp,51).text $shortfn($iif(%pxep.x,%pxep.x,%pxep.nfo)) } | else { _ra pxexplmp 58 Error: No such nick $chr(91) $did(pxexplmp,51).text $chr(93) } } | .disable #pxep.ncheck | h
#pxep.ncheck end
on *:dialog:pxexpl:sclick:*:{
  goto $did
  :1 | unset %pxep* | dialog -x pxexpl | window -c @PxExpl_BMP-View | .timerpxexpl off | $iif($dialog(pxexpls),dialog -x pxexpls) | $iif($dialog(pxexple),dialog -x pxexple) | $iif($dialog(pxexpla),dialog -x pxexpla) | $iif($dialog(pxexplmp),dialog -x pxexplmp) | h
  :3 | unset %pxep.dirt | %pxep.dir = $did(3,$did(3).sel).text | %pxep.dir = $mid(%pxep.dir,2,3) | if ($disk(%pxep.dir).type != removable) { goto n } | else { h } | :n | _r pxexpl 4,6,16,17,24 | _h pxexpl 23 | _b pxexpl 7 | pxep.fd | h
  :4 | if (/.. != $did(4,$did(4).sel).text) { %pxep.tdir = $px.dir $+ $did(4,$did(4).sel).text } | _e pxexpl 8 | _b pxexpl 7 | _h pxexpl 12,13,21,23 | h
  :5 | if ($did(5).sel == 1) { h } | else { _r pxexpl 4,6 | _ra pxexpl 14 *.* | pxep.did5 } | if ($timer(pxexpl)) { .timerpxexpl off } | h
  :6 {
    unset %pxep.bmp %pxep.nfo %pxep.file %pxep.total %pxep.num %pxep.tdir
    %pxep.file = $did(6,$did(6).sel).text | %pxep.nfo = $px.dir $+ %pxep.file
    _e pxexpl 7 | _va pxexpl 16 %pxep.file | window -c @PxExpl_BMP-View
    _va pxexpl 17 Size: $pxep.size($file(%pxep.nfo).size)
    _va pxexpl 24 Modified: $asctime($file(%pxep.nfo).mtime,m/dd/yyyy) $asctime($file(%pxep.nfo).mtime,h:nn.sstt)
    if ($did(6,0).sel > 1) {
      _b pxexpl 7 | _h pxexpl 16,17,21,23,24
      _va pxexpl 16 Files: $did(6,0).sel
      var %pxep.temp = 0, %pxep.temp1 = 0
      :f | inc %pxep.temp
      if (%pxep.temp > $did(6,0).sel) { _va pxexpl 24 Size: $pxep.size(%pxep.temp1) | unset %pxep.file %pxep.nfo }
      else { var %pxep.temp2 = $px.dir $+ $did(6,$did(6,%pxep.temp).sel).text | inc %pxep.temp1 $file(%pxep.temp2).size | goto f }
    }
    if ($gettok(%pxep.file,$numtok(%pxep.file,46),46) == bmp) { did -ve pxexpl 21 | %pxep.bmp = %pxep.nfo | $iif(($inwave) || ($inmidi),_v pxexpl 13) }
    elseif ($gettok(%pxep.file,$numtok(%pxep.file,46),46) == wav) || ($gettok(%pxep.file,$numtok(%pxep.file,46),46) == mid) {
      if ($inwave) || ($inmidi) { if ($did(6,$did(6).sel).text == $gettok(%pxep.ptemp,$numtok(%pxep.ptemp,92),92)) { _v pxexpl 13,23 | _h pxexpl 12 | h } | else { goto e } } | else { goto e }
      :e | _v pxexpl 12,23 | _h pxexpl 13,21 | %pxep.play = %pxep.nfo
    }
    else { _h pxexpl 23,21,12,13 | $iif(($inwave) || ($inmidi),did -v pxexpl 13) } | h
  }
  :7 | if (%pxep.nfo) { if ($isfile(%pxep.nfo)) && ($isdir($nofile(%pxep.nfo))) { run " $+ $shortfn(%pxep.nfo) $+ " } | h }
  :8 | $iif($did(6,0).sel > 1,pxep.init 6,pxep.init 1) | h
  :9 | pxep.init 3 | h
  :10 | pxep.init 4 | h
  :11 | pxep.init 5 | h
  :12 {
    %pxep.ptemp = %pxep.play | .splay stop
    if (%pxep.play != $did(6,$did(6).sel).text) { .splay " $+ $shortfn(%pxep.nfo) $+ " }
    else { .splay " $+ $shortfn(%pxep.play) $+ " }
    _v pxexpl 13 | _h pxexpl 12 | h
  }
  :13 {
    _h pxexpl 13 | .splay stop
    $iif(($gettok(%pxep.file,$numtok(%pxep.file,46),46) == wav) || ($gettok(%pxep.file,$numtok(%pxep.file,46),46) == mid),_v pxexpl 12) | h
  }
  :15 | if ($len($did(14).text) > 2) { %pxep.ext = $did(14).text | _r pxexpl 4,6,16,17,24 | _b pxexpl 7 | _h pxexpl 21,23 | pxep.did15 | pxep.fd | h } | else { h }
  :20 | $iif($dialog(pxexpls),dialog -v pxexpls,dialog -m pxexpls pxexpls) | $iif($dialog(pxexpla),dialog -v pxexpla,dialog -m pxexpla pxexpla) | if ($did(6,$did(6).sel).text) { _ra pxexpla 7 $did(6,$did(6).sel).text | _ra pxexpla 5 $px.dir } | h
  :21 | .timerpxexpl off | window -p +t @PxExpl_BMP-View $px.centerwin($calc($pic(%pxep.bmp).width + 8),$calc($pic(%pxep.bmp).height + 28)) $calc($pic(%pxep.bmp).width + 8) $calc($pic(%pxep.bmp).height + 28) | drawpic -t @PxExpl_BMP-View 1 1 1 $shortfn(%pxep.bmp) | dialog -x pxexpl | h
  :22 | $iif($did(6,0).sel > 1,pxep.init 7,pxep.init 2) | h
  :23 | %pxep.repeat = $iif(%pxep.repeat != on,on,off) | h
  :25 | if ($did(25).state) { px.set Explorer Refresh 1 | .timerpxexpl 0 0 pxep.fc | h } | else { px.set Explorer Refresh 0 | .timerpxexpl off | h }
}
on *:dialog:pxexplmp:edit:25:$iif($isdir($did(25).text),_e pxexplmp 28,_b pxexplmp 28)
on *:dialog:pxexplmp:edit:35:$iif($did(35).text,_e pxexplmp 36,_b pxexplmp 36)
on *:dialog:pxexplmp:edit:41:$iif($did(41).text,_e pxexplmp 44,_b pxexplmp 44)
on *:dialog:pxexplmp:edit:51:if ($server == $null) { _b pxexplmp 56 | h } | if ($did(51).text) { if ($chr(32) isin $did(51).text) { _ra pxexplmp 51 $replace($did(51).text,$chr(32),_) } | _e pxexplmp 56 } | else { _b pxexplmp 56 }
on *:dialog:pxexpls:sclick:*:{
  goto $did
  :1 | $iif($dialog(pxexple),dialog -x pxexple) | $iif($dialog(pxexpla),dialog -x pxexpla) | dialog -x pxexpls | if ($dialog(pxexpl) == $null) { unset %pxep* } | h
  :8 | var %pxep.ftemp = $read -l $+ $did(8).sel $pxep.cfg | _ra pxexpls 5 $nofile($gettok(%pxep.ftemp,2,94)) | _ra pxexpls 7 $gettok(%pxep.ftemp,3,94) | _ra pxexpls 15 $gettok(%pxep.ftemp,4,94) | h
  :9 | $iif($dialog(pxexpla),dialog -v pxexpla,dialog -m pxexpla pxexpla) | h
  :10 | $iif(($isfile($pxep.cfg) == $false) || ($did(8).sel == $null),h) | write -dl $+ $did(8).sel $pxep.cfg | _r pxexpls 5,7,8,15 | pxep.slist | h
  :11 | $iif($did(8).sel == $null,h) | $iif($dialog(pxexple),dialog -v pxexple,dialog -m pxexple pxexple) | h
  :12 | $iif(($isfile($pxep.cfg) == $false) || ($did(8).sel == $null),h) | var %pxep.ftemp = $read -l $+ $did(8).sel $pxep.cfg, %pxep.temp = $gettok(%pxep.ftemp,2,94) $+ $gettok(%pxep.ftemp,3,94) | if ($isfile(%pxep.temp)) { .run " $+ %pxep.temp $+ " | h }
}
on *:dialog:pxexpla:sclick:*:{
  goto $did
  :8 {
    if ($did(3).text) && ($did(5).text) && ($did(7).text) {
      write $pxep.cfg $pxep.check($did(3)) $+ ^ $+ $did(5) $+ ^ $+ $did(7) $+ ^ $+ $iif($did(13),$did(13),No description)
      dialog -x pxexpla | _r pxexpls 5,7,8 | pxep.slist | h
    }
    else {
      if ($did(3).text == $null) && ($did(5).text == $null) && ($did(7).text == $null) { a_va Error: No Info | h }
      elseif ($did(3).text) && ($did(5).text == $null) && ($did(7).text == $null) { a_va Error: No File Info | h }
      elseif ($did(3).text == $null) && ($did(5).text) && ($did(7).text == $null) { a_va Error: No Label/File | h }
      elseif ($did(3).text == $null) && ($did(5).text == $null) && ($did(7).text) { a_va Error: No Label/Path | h }
      elseif ($did(3).text == $null) { a_va Error: No Label | h }
      elseif ($did(5).text == $null) { a_va Error: No Path | h }
      elseif ($did(7).text == $null) { a_va Error: No File | h }
    }
  }
  :9 | .timer 1 0 pxep.did9 | h
  :10 | dialog -x pxexpla
}
on *:dialog:pxexple:sclick:9:{
  if ($did(2).text == $null) && ($did(4).text == $null) && ($did(6).text == $null) { e_va Error: No Info | h }
  elseif ($did(2).text) && ($did(4).text == $null) && ($did(6).text == $null) { e_va Error: No File Info | h }
  elseif ($did(2).text == $null) && ($did(4).text) && ($did(6).text == $null) { e_va Error: No Label/File | h }
  elseif ($did(2).text == $null) && ($did(4).text == $null) && ($did(6).text) { e_va Error: No Label/Path | h }
  elseif ($did(6).text == $null) { e_va Error: No Label | h }
  elseif ($did(4).text == $null) { e_va Error: No Path | h }
  elseif ($did(2).text == $null) { e_va Error: No File | h }
  write -l $+ $did(pxexpls,8).sel $pxep.cfg $did(6).text $+ ^ $+ $did(4).text $+ ^ $+ $did(2).text $+ ^ $+ $did(8).text
  dialog -x pxexple | _r pxexpls 5,7,8,15 | pxep.slist
}
on *:dialog:pxexpl:dclick:*:{
  goto $did
  :4 {
    if ($timer(pxexpl)) { .timerpxexpl off } | unset %pxep.tdir %pxep.file %pxep.nfo | _h pxexpl 23 | var %pxep.sel = $did(4,$did(4,1).sel) | _r pxexpl 4,6,16,17,24
    if (/.. == %pxep.sel) {
      if (%pxep.dirt2) {
        %pxep.dirt = %pxep.dirt2 | if ($numtok(%pxep.dirt2,92) > 2) { %pxep.dirt2 = $remtok(%pxep.dirt2,$gettok(%pxep.dirt2,$numtok(%pxep.dirt2,92),92),1,92) | goto e } | else { unset %pxep.dirt2 | goto f }
        :e | if ($right(%pxep.dirt2,1) != $chr(92)) { %pxep.dirt2 = %pxep.dirt2 $+ \ } | goto f
        :f | if (%pxep.dirt2) { if ($isdir(%pxep.dirt2) == $false) { %pxep.dirt2 = %pxep.dirt } } | else { if ($isdir(%pxep.dirt) == $false) { %pxep.dirt = %pxep.dir } }
      }
      else { %pxep.dirt = %pxep.dir } | pxep.fd | h
    }
    else {
      if (%pxep.dirt) { %pxep.dirt2 = %pxep.dirt | %pxep.dirt = %pxep.dirt $+ $remove(%pxep.sel,/) $+ \ }
      else { %pxep.dirt = %pxep.dir $+ $remove(%pxep.sel,/) $+ \ } | pxep.fd | h
    }
  }
  :6 | if (%pxep.nfo) { if ($isfile(%pxep.nfo)) && ($isdir($nofile(%pxep.nfo))) { run " $+ %pxep.nfo $+ " } | h }
}
on *:dialog:pxexpls:dclick:8:$iif($isfile($pxep.cfg) == $false,h) | var %pxep.ftemp = $read -l $+ $did(8).sel $pxep.cfg, %pxep.temp = $gettok(%pxep.ftemp,2,94) $+ $gettok(%pxep.ftemp,3,94) | if ($isfile(%pxep.temp)) { .run " $+ %pxep.temp $+ " } | var %pxep.ftemp = $read -l $+ $did(8).sel $pxep.cfg | _ra pxexpls 5 $gettok(%pxep.ftemp,2,94) | _ra pxexpls 7 $gettok(%pxep.ftemp,3,94)

;-------- -  -
; ProjectX
;-------- -  -
alias -l px.about window -alk +ef @ProjectX $px.centerwin(370,199) 370 199 @ProjectX Fixedsys | clear @ProjectX | px.aline ...............................__..._.._... | px.aline .....___..____.__.._.___..___././_.\.\/./.. | px.aline ..../._.\¦.__/._.`/./.-_)/.__/.._/..)..(... | px.aline .../.!__/_/..\___/./\___/\__/\__/../_/\_\.. | px.aline ../_/.--------/__/..---------------------.. | px.aline .....................Scripting.Crew..... | px.aline . | px.aline ......The.Official.ProjectX.Homepage:...... | px.aline ........http://www!projectx!mx!dk/......... | px.aline ......Email:.info@projectx!mx!dk......... | px.aline . | px.aline ......(Double click window to close) | sline @ProjectX 12
alias -l px.aline aline @ProjectX $replace($1-,., ,!,.,-, )
alias -l px.centerwin return $int($calc(($window(-3).w - $1) / 2)) $int($calc(($window(-3).h - $2) / 2))
alias -l px.get return $readini -n projectx.ini $1 $$2
alias -l px.info {
  var %. $shortfn($nopath($script))
  px.set %. name PxExplorer
  px.set %. author Urmac
  px.set %. version v1.00
  px.set %. email urmac@projectx.mx.dk
  px.set %. date March 11, 2000
  px.set %. extra Don't try to handle too many files for a certain action.
} 
alias -l px.lp return $iif($isalias(pxt.lp),$pxt.lp,***)
alias -l px.reg var %. = $chr(32) $+ $1 $+ ( $+ $2 $+ ) | %px.using = $addtok(%px.using,%.,44)
alias -l px.set $iif($3 != $null,writeini,remini) projectx.ini $$1-
alias -l px.using return ProjectX %px.using (12http://www.projectx.mx.dk/)
alias px.www if ($shortfn( [ $readini $mircini files browser ] )) run $ifmatch $$1
alias quit quit $iif($1,$1-,ProjectX :: www.projectx.mx.dk)
menu @ProjectX {
  dclick:window -c @ProjectX
  Close:window -c @ProjectX
}
ctcp &*:version:*: .ctcpreply $nick version $px.using | h
