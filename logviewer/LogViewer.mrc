;LogViewer System v2.5 by ShakE
;Try this easy way to read your logs
;All Copyrights reserved!
;For more addons visit http://xsoft.hit.bg
;For questions and bugs mailto: shake@haho.org

on *:load:{
 /echo -a LogViewer by ShakE
 /echo -a Usage: /logview
 /echo -a More addons at http://xsoft.hit.bg
}
menu @LogViewer {
  dclick if ((*.* iswm $sline($active,1)) && ($exists( [ logs\ $+ [ $sline($active,1) ] ] ))) { clear -a | titlebar $active - $sline($active,1) - $bytes($file( [ logs\ $+ [ $sline($active,1) ] ] ).size) | loadbuf -p $active logs\ $+ $sline($active,1) } 
  $iif($sline($active,1), [ $sline($active,1) ] ):if ((*.* iswm $sline($active,1)) && ($exists( [ logs\ $+ [ $sline($active,1) ] ] ))) { clear -a | titlebar $active - $sline($active,1) - $bytes($file( [ logs\ $+ [ $sline($active,1) ] ] ).size) | loadbuf -p $active logs\ $+ $sline($active,1) } 
  -
  Refresh:logview
  Clear Screen:clear $active 
  -
  $iif($sline($active,1),Delete):if ($?!="Are you sure you want to remove $+ $crlf $+ $sline($active,1) $+ ?") { .remove logs\ $+ $sline($active,1) | logview }
  -
  Close:window -c $active
}
alias logview {
  if ($window(@logviewer)) { window -c @logviewer }
  if ($1) && ($exists($bind($logdir,$1,.log))) {
    if ($window(@logview)) { clear @logview }
    else { window -k +e @LogView -1 -1 500 320 }
    var %§.file = $bind($logdir,$1,.log)
    titlebar @LogView - $1 - $bytes($file(%§.file).size)
    loadbuf -p @logview %§.file
    halt
  }
  window -kSl15 +e @LogViewer -1 -1 600 320
  :loop | inc -u %§.i | if ($findfile($logdir,*.log,%§.i) == $null) { titlebar @LogViewer - Right click for menu | halt }
  aline -l @LogViewer $nopath($findfile($logdir,*.log,%§.i))
  goto loop
}
menu menubar,status {
 LogViewer:/logview
}