;simple clone scanner 04b
;mirc v5.8 required.
;by hantu

;/clonescan [#channel] [-a]

on *:load:if ($version >= 5.8) { echo $colour(info) -a * loaded simple clone scanner 04b by HaNtU]uU[. | echo $colour(info) -a * command: /clonescan [channel] [-a] } | else { echo $colour(info) -a * mirc version: $version - v5.8 needed, get newer mirc at www.mirc.co.uk, unloading.. | .unload -rs $script }
alias clonescan {
  var %chan = $iif($left($1,1) == $chr(35),$1,#), %type = $iif($2,$2,$iif($left($1,1) == -,$1))
  if ($dialog(clonescanner) == $null) && (%type != -a) { dialog -m clonescanner clonescanner }
  if (%chan !ischan) {
    if (%type == -a) { echo $colour(info) -a * Please enter a valid channel, ie. a channel that you are in. | return }
    else { did -ra clonescanner 4 Please enter a valid channel, ie. a channel that you are in. | return }
  }
  if ($chan(%chan).ial != $true) {
    .ial on
    if (%type == -a) { echo $colour(info) -a * Updating IAL for %chan }
    else { did -ra clonescanner 4 Updating IAL for %chan $+ ... }
    set %cs.chan $addtok(%cs.chan,%chan,32) | raw -q WHO %chan | set %cs.type %type | return
  }
  else {
    if ($dialog(clonescanner)) { did -r clonescanner 2 | dialog -t clonescanner simple clone scanner 04b - scanning %chan }
    if ($hget(cs)) { hfree cs }
    hmake cs $nick(%chan,0)
    var %i = 1, %ticks = $ticks, %clones
    while ($nick(%chan,%i)) { hadd cs $address($nick(%chan,%i),2) $hget(cs,$address($nick(%chan,%i),2)) $iif($numtok($hget(cs,$address($nick(%chan,%i),2)),38) > 0,$chr(38)) $nick(%chan,%i) | inc %i }
    var %o = 1
    if (%type == -a) { echo -a - | echo -a * Clone Scan in %chan }
    while ($hget(cs,%o).item) {
      if ($numtok($hget(cs,$hget(cs,%o).item),38) > 1) {
        if (%type == -a) { echo -a $numtok($hget(cs,$hget(cs,%o).item),38) => $hget(cs,%o).item $+ : $hget(cs,$hget(cs,%o).item) }
        else { did -a clonescanner 2 $hget(cs,%o).item ( $+ $numtok($hget(cs,$hget(cs,%o).item),38) $+ ): $hget(cs,$hget(cs,%o).item) | did -z clonescanner 2 }
        inc %clones
      }
      inc %o
    }
    if (%type == -a) { echo -a * Done. $iif(%clones > 0,%clones,no) group $+ $iif(%clones > 1,s) of clones found. (done: $+ $calc($ticks - %ticks) $+ ms) | echo -a - }
    else { did -ra clonescanner 4 Done. $iif(%clones > 0,%clones,no) group $+ $iif(%clones > 1,s) of clones found. (done: $+ $calc($ticks - %ticks) $+ ms) }
    hfree cs
  }
}
raw 352:*:if ($istok(%cs.chan,$2,32)) { halt }
raw 315:*:if ($istok(%cs.chan,$2,32)) { set %cs.chan $remtok(%cs.chan,$2,1,32) | clonescan $2 %cs.type | unset %cs.type | halt }
menu channel {
  clone scanner:clonescan #
}

dialog clonescanner {
  title "simple clone scanner 04b"
  size -1 -1 180 100
  option dbu
  button "", 1, 0 0 0 0, ok
  list 2, 2 2 176 93
  box "", 3, 2 87 176 12
  text "", 4, 5 91 170 7
}
