;--------Jukebox----------
; mIRC Addon Port
; Only for use with mIRC 5.82+
; http://mircs.hit.bg
;-------------------------
menu menubar,channel,status,query {
  Jukebox
  .Jukebox: jukebox
  .Setup: jukebox.setup
  .MP3List: $iif($window(@mp3list),window -a @mp3list,jb.server.view)
  .$iif($jb.read(server),Advertise Server) : ame invites you to check out his MP3 server, get a file list by typing @mp3list
  .Unload: jukebox.unload
}
on *:load: {
  if ($version < 5.82) { $dialog(jb.badver,jb.badver) | jukebox.unload }
  else jukebox.setup
}
alias jukebox.unload { .remove " $+ $scriptdirjukebox.ini $+ " | jb.close | .timerjb.server.terminator off | unload -rs " $+ $scriptdirjukebox.mrc $+ " }
dialog jb.badver {
  title "Version Error"
  size -1 -1 125 36
  option dbu
  text "Jukebox requires mIRC version 5.82 or greater." 1, 2 3 115 9, center
  text "Get the latest version at:" 2, 4 12 59 9
  link "http://www.mirc.com" 3, 63 12 105 13
  button "Ok", 4, 50 23 20 10, ok
}
on *:dialog:jb.badver:sclick:3: run http://www.mirc.com
;Jukebox
alias jukebox {
  if ($window(@jukebox)) window -a @Jukebox
  elseif ($isfile($scriptdirskins\default.skin)) {
    if (($jb.read(activeskin) == $null) || ($isfile( [ $scriptdirskins\ $+ [ $jb.read(activeskin) ] ] ) == $false)) $jb.write(activeskin) default.skin
    if ($hget(jb.skin) == $null) hmake jb.skin 5
    hload jb.skin " $+ $scriptdirskins\ $+ $jb.read(activeskin) $+ "
    if (($isfile($jb.read(file))) && (*.m3u iswm $jb.read(file))) { if ($hget(jb.playlist) == $null) hmake jb.playlist $iif($lines($jb.read(file)) > 9,$int($calc($ifmatch / 10)),10) | hload -n jb.playlist " $+ $jb.read(file) $+ " }
window $iif($jb.read(ontop),-dohpk0,-dhpk0) +dl @Jukebox $iif(%jb.xy,$ifmatch,525 125) $hget(jb.skin,size) | jukebox.init
}
else echo $colour(info2) -a Error: The default skin does not exist, please re-install Jukebox
unset %jb.xy
}
alias jukebox.init {
  drawrect -f @jukebox $hget(jb.skin,bg-color) 0 0 0 $hget(jb.skin,size)
  $iif($hget(jb.skin,bg-image),jb.draw $hget(jb.skin,bg-loc) " $+ $scriptdirskins\ $+ $hget(jb.skin,bg-image) $+ ")
  drawtext @jukebox $hget(jb.skin,header-color) $hget(jb.skin,header-font) $hget(jb.skin,header-loc) Revenant Jukebox
  jb.draw.load $hget(jb.skin,close) | jb.draw.load $hget(jb.skin,min)
  jb.draw.load $hget(jb.skin,back) | jb.draw.load $hget(jb.skin,play)
  jb.draw.load $hget(jb.skin,pause) | jb.draw.load $hget(jb.skin,stop)
  jb.draw.load $hget(jb.skin,forward) | jb.draw.load $hget(jb.skin,open)
  jb.draw.load $hget(jb.skin,mp3list) | jb.draw.load $hget(jb.skin,playlist)
  jb.draw.load $hget(jb.skin,id3) | jb.draw.load $hget(jb.skin,seek)
  jb.draw.load $hget(jb.skin,seek-slider)
  tokenize 32 $hget(jb.skin,volume) $hget(jb.skin,vol-slider)
  var %jb.vol.loc $int($calc($1 + (($5 * .85) * ($vol(mp3) / 65000))))
  jb.draw.load $1-6 | jb.draw.load $iif($calc($1 + $5 - $11) < %jb.vol.loc,$ifmatch,%jb.vol.loc) $8-
  if (($jb.read(echofile)) && ($isfile($jb.read( [ $iif(*.m3u iswm $jb.read(file),plfile,file) ] )))) {
    .timerjb.scroll -om 0 200 jb.scroll $str($chr(160),5) $jb.read(echofile)
    titlebar @Jukebox - $jb.read(echofile)
  }
  else {
    drawrect -f @jukebox $hget(jb.skin,disp-bg) 1 $hget(jb.skin,disp-loc)
    drawtext -cb @jukebox $hget(jb.skin,disp-text) $hget(jb.skin,disp-bg) $hget(jb.skin,disp-font) $hget(jb.skin,disp-loc) $chr(160) Jukebox v.180
  }
  drawpic @jukebox | jb.clean | $jb.rem(paused)
}
menu @jukebox {
  mouse: {
    if (%jb.click == volume) {
      tokenize 32 $hget(jb.skin,volume) $hget(jb.skin,vol-slider)
      vol -p $iif($int($calc(($mouse.x - ($1 + ($11 / 2))) * (65000 / ($5 * .85)))) > 0,$ifmatch,0)
      var %jb.vol.loc $int($calc($1 + (($5 * .85) * ($vol(mp3) / 65000))))
      jb.draw.load $1-6 | jb.draw.load $iif($calc($1 + $5 - $11) < %jb.vol.loc,$ifmatch,%jb.vol.loc) $8- | drawpic @jukebox
    }
    elseif (%jb.click == seek) {
      tokenize 32 $hget(jb.skin,seek) $hget(jb.skin,seek-slider)
      var %jb.seek.loc = $iif($calc($5 - ($11 / 2) + $1) < $mouse.x,$ifmatch,$iif($calc($1 + ($11 / 2)) > $mouse.x,$ifmatch,$mouse.x))
      jb.draw.load $1-6 | jb.draw.load $calc(%jb.seek.loc - ($11 / 2)) $8- | drawpic @jukebox
    }
    elseif (%jb.click == move) .timer 1 0 window @jukebox $calc($mouse.dx - %jb.mouse.x) $calc($mouse.dy - %jb.mouse.y)
    elseif (%jb.click == disp) {
      $iif($mouse.x > %jb.mouse,dec,inc) %jb.scroll | %jb.mouse = $mouse.x | var %jb.scroll.disp $str($chr(160),5) $jb.read(echofile)
      drawtext -cb @jukebox $hget(jb.skin,disp-text) $hget(jb.skin,disp-bg) $hget(jb.skin,disp-font) $hget(jb.skin,disp-loc) $mid(%jb.scroll.disp,%jb.scroll,$len(%jb.scroll.disp)) %jb.scroll.disp
    }
    elseif (%jb.mouseover) {
    if (%jb.click == close) jb.draw.load $hget(jb.skin,close)
    elseif (%jb.click == min) jb.draw.load $hget(jb.skin,min)
    elseif (%jb.click == mp3list) jb.draw.load $hget(jb.skin,mp3list)
    elseif (%jb.click == playlist) jb.draw.load $hget(jb.skin,playlist)
    elseif (%jb.click == id3) jb.draw.load $hget(jb.skin,id3)
    elseif (%jb.click == back) jb.draw.load $hget(jb.skin,back)
    elseif (%jb.click == play) jb.draw.load $hget(jb.skin,play)
    elseif (%jb.click == pause) jb.draw.load $hget(jb.skin,pause)
    elseif (%jb.click == stop) jb.draw.load $hget(jb.skin,stop)
    elseif (%jb.click == forward) jb.draw.load $hget(jb.skin,forward)
    elseif (%jb.click == open) jb.draw.load $hget(jb.skin,open)
    jb.mouseover
    }
  }
  leave: { if (%jb.click == move) .timer 1 0 window @jukebox $calc($mouse.dx - %jb.mouse.x) $calc($mouse.dy - %jb.mouse.y) }
  sclick: {
    unset %jb.click
    if ($jb.mouse.check(volume)) %jb.click = volume
    elseif ($jb.mouse.check(seek)) { if ($inmp3) %jb.click = seek }
    elseif (($inrect( [ $replace( [ $mouse.x $mouse.y [ $hget(jb.skin,disp-loc) ] ,$chr(32),$chr(44)) ] ] )) && ($jb.read(echofile))) { %jb.click = disp | %jb.scroll = 1 | .timerjb.scroll off }
    else { %jb.click = move | %jb.mouse.x = $mouse.x | %jb.mouse.y = $mouse.y | jb.mouseover | %jb.mouseover = $true }
  }
  uclick: {
    if (%jb.click == close) {
      jb.draw $hget(jb.skin,close)
      if ($jb.mouse.check(close)) jb.close
    }
    elseif (%jb.click == min) { jb.draw $hget(jb.skin,min) | if ($jb.mouse.check(min)) window -n @jukebox }
    elseif (%jb.click == mp3list) { if ($jb.mouse.check(mp3list)) $iif($window(@mp3list),window -a @mp3list,jb.server.view) | jb.draw $hget(jb.skin,mp3list) }
    elseif (%jb.click == playlist) { if ($jb.mouse.check(playlist)) dialog $iif($dialog(jb.playlist),-v,-ma) jb.playlist jb.playlist | jb.draw $hget(jb.skin,playlist) }
    elseif (%jb.click == volume) {
      tokenize 32 $hget(jb.skin,volume) $hget(jb.skin,vol-slider)
      if ($jb.mouse.check(volume)) { vol -p $iif($int($calc(($mouse.x - ($1 + ($11 / 2))) * (65000 / ($5 * .85)))) > 0,$ifmatch,0) }
      var %jb.vol.loc $int($calc($1 + (($5 * .85) * ($vol(mp3) / 65000))))
      jb.draw.load $1-6 | jb.draw.load $iif($calc($1 + $5 - $11) < %jb.vol.loc,$ifmatch,%jb.vol.loc) $8- | drawpic @jukebox
    }
    elseif (%jb.click == seek) {
      tokenize 32 $hget(jb.skin,seek) $hget(jb.skin,seek-slider)
      if (($jb.mouse.check(seek)) && ($inmp3)) { splay seek $int($calc(($mouse.x - ($1 + ($11 / 2))) * ($inmp3.length / ($5 * .85)))) }
      var %jb.seek.loc $int($calc($1 + (($5 * .85) * ($inmp3.pos / $inmp3.length))))
      jb.draw.load $1-6 | jb.draw.load $iif($calc($1 + $5 - $11) < %jb.seek.loc,$ifmatch,%jb.seek.loc) $8- | drawpic @jukebox
    }
    elseif (%jb.click == id3) { if (($jb.mouse.check(id3)) && ($jb.read(file))) jb.id3.editor | jb.draw $hget(jb.skin,id3) }
    elseif (%jb.click == back) { if ($jb.mouse.check(back)) pl.back | jb.draw $hget(jb.skin,back) }
    elseif (%jb.click == play) { if ($jb.mouse.check(play)) $iif($jb.read(paused),$jb.pause(resume),jb.play) | jb.draw $hget(jb.skin,play) }
    elseif (%jb.click == pause) { if ($jb.mouse.check(pause)) if ($inmp3) $jb.pause( [ $iif($jb.read(paused),resume,pause) ] ) | jb.draw $hget(jb.skin,pause) }
    elseif (%jb.click == stop) { if ($jb.mouse.check(stop)) { if ($jb.read(paused)) $jb.rem(paused) | splay stop | .timerjb.seek off | jb.draw $hget(jb.skin,seek) | jb.draw $hget(jb.skin,seek-slider) } | jb.draw $hget(jb.skin,stop) }
    elseif (%jb.click == forward) { if ($jb.mouse.check(forward)) pl.forward | jb.draw $hget(jb.skin,forward) }
    elseif (%jb.click == open) { if ($jb.mouse.check(open)) .timer 1 0 jb.selectfile | jb.draw $hget(jb.skin,open) }
    elseif ((%jb.click == disp) && ($jb.read(file))) .timerjb.scroll -om 0 200 jb.scroll $str($chr(160),5) $jb.read(echofile)
    unset %jb.click %jb.mouse* %jb.mouseover
  }
  Minimize: window -n @jukebox
  -
  $iif($jb.read(file),File Info) : jb.id3.editor
  Skin Browser: dialog $iif($dialog(jb.skin.browser),-a,-ma) jb.skin.browser jb.skin.browser
  Playlist Manager: dialog $iif($dialog(jb.playlist),-v,-ma) jb.playlist jb.playlist
  MP3List: $iif($window(@mp3list),window -a @mp3list,jb.server.view)
  -
  Setup: jukebox.setup
}
alias -l jb.clean { if ($hget(jb.lastplfiles)) hfree jb.lastplfiles | unset %jb.totalfiles %jb.plfilenum %jb.offset) }
alias -l jb.close { window -c @jukebox | splay stop | .timerjb.scroll off | .timerjb.seek off | jb.clean | unset %jb.* | if ($hget(jb.skin)) hfree jb.skin | if ($hget(jb.playlist)) hfree jb.playlist }
alias -l jb.draw drawpic -c @jukebox $1- " $+ $scriptdirskins\ $+ $hget(jb.skin,bmp-file) $+ "
alias -l jb.draw.load drawpic -cn @jukebox $1- " $+ $scriptdirskins\ $+ $hget(jb.skin,bmp-file) $+ "
alias -l jb.draw.prev drawpic -c @jukebox-prev $1- " $+ $scriptdirskins\ $+ $hget(jb.skin-prev,bmp-file) $+ "
alias -l jb.mouse.check return $inrect( [ $replace( [ $mouse.x $mouse.y [ $gettok($hget(jb.skin,$1),1-2,32) ]  [ $gettok($hget(jb.skin,$1),5-6,32) ] ] ,$chr(32),$chr(44)) ] )
alias -l jb.mouseover {
  if ($jb.mouse.check(close)) { %jb.click = close | jb.draw.load $hget(jb.skin,close-down) }
  elseif ($jb.mouse.check(min)) { %jb.click = min | jb.draw.load $hget(jb.skin,min-down) }
  elseif ($jb.mouse.check(mp3list)) { %jb.click = mp3list | jb.draw.load $hget(jb.skin,mp3list-down) }
  elseif ($jb.mouse.check(playlist)) { %jb.click = playlist | jb.draw.load $hget(jb.skin,playlist-down) }
  elseif ($jb.mouse.check(id3)) { %jb.click = id3 | jb.draw.load $hget(jb.skin,id3-down) }
  elseif ($jb.mouse.check(back)) { %jb.click = back | jb.draw.load $hget(jb.skin,back-down) }
  elseif ($jb.mouse.check(play)) { %jb.click = play | jb.draw.load $hget(jb.skin,play-down) }
  elseif ($jb.mouse.check(pause)) { %jb.click = pause | jb.draw.load $hget(jb.skin,pause-down) }
  elseif ($jb.mouse.check(stop)) { %jb.click = stop | jb.draw.load $hget(jb.skin,stop-down) }
  elseif ($jb.mouse.check(forward)) { %jb.click = forward | jb.draw.load $hget(jb.skin,forward-down) }
  elseif ($jb.mouse.check(open)) { %jb.click = open | jb.draw.load $hget(jb.skin,open-down) }
  drawpic @jukebox
}
alias -l jb.pause {
  if ($1 == pause) { splay pause | $jb.write(paused) $true | titlebar @Jukebox - $jb.read(echofile) (Paused) }
  else { splay resume | $jb.rem(paused) | titlebar @Jukebox - $jb.read(echofile) }
}
alias -l jb.play {
  if ($isfile($jb.read(file))) {
    splay stop | .timerjb.seek off
    if (*.m3u iswm $jb.read(file)) {
      if (($jb.read(replay)) && ($isfile($jb.read(plfile)))) { jb.draw $hget(jb.skin,seek) | jb.draw $hget(jb.skin,seek-slider) | .timerjb.seek -o 0 2 jb.seek | splay -p " $+ $jb.read(plfile) $+ " }
      else pl.play
    }
    elseif ((*.mp? !iswm $jb.read(file)) || ($right($jb.read(file),1) !isnum 2-3)) echo $colour(info2) -a Error: Jukebox only supports .mp3 files
    else { if ($jb.read(replay)) { jb.draw $hget(jb.skin,seek) | jb.draw $hget(jb.skin,seek-slider) | .timerjb.seek -o 0 2 jb.seek | splay -p " $+ $jb.read(file) $+ " } | else $jb.play.run(jukebox) }
  }
  else echo $colour(info2) -a Error: Jukebox media file ( $+ $jb.read(file) $+ ) does not exist
}
alias -l jb.play.run {
  var %jb.file $jb.read( [ $iif($1 == jukebox,file,plfile) ] )
  if ($isfile(%jb.file)) {
    if ((*.mp? !iswm %jb.file) || ($right(%jb.file,1) !isnum 2-3)) echo $colour(info2) -a Error: Jukebox only supports .mp3 files
    elseif ($mp3(%jb.file).version == $null) echo $colour(info2) -a Error: File ( $+ %jb.file $+ ) is an invalid mp3 file
    else {
      splay stop | splay -p " $+ %jb.file $+ " | $jb.write(replay) $true
      if (($mp3(%jb.file).artist) && ($mp3(%jb.file).title)) $jb.write(echofile) $mp3(%jb.file).artist - $mp3(%jb.file).title $jb.time-conv(%jb.file)
      else $jb.write(echofile) $remove($nopath(%jb.file),.mp3,.mp2) $jb.time-conv(%jb.file)
      .timerjb.scroll -om 0 200 jb.scroll $str($chr(160),5) $jb.read(echofile) | titlebar @jukebox - $jb.read(echofile)
      jb.draw $hget(jb.skin,seek) | jb.draw $hget(jb.skin,seek-slider) | .timerjb.seek -o 0 2 jb.seek
      if ($jb.read(paused)) $jb.rem(paused)
      if ($dialog(jb.id3.editor)) jb.id3.load
      if (($1 == playlist) && ($dialog(jb.playlist))) did -c jb.playlist 6 %jb.plfilenum
      if ($jb.read(echosongs)) {
      if (($jb.read(server)) && (&advertise isin $jb.read(spammsg))) var %jb.server = Type @getmp3 $me $nopath(%jb.file) to download it
      if (($mp3(%jb.file).artist) && ($mp3(%jb.file).title)) var %jb.echo = $replace($jb.read(spammsg),&artist,$mp3(%jb.file).artist,&song,$mp3(%jb.file).title)
        else { var %jb.filename = $remove($nopath(%jb.file),.mp3,.mp2) | var %jb.echo = $remove( [ $replace($jb.read(spammsg),&artist - &song,%jb.filename,&song - &artist,%jb.filename,&song,%jb.filename) ] ,&artist,&song) }
        var %jb.echo = $remove($replace(%jb.echo,&color,,&bold,,&underline,,&normal,,&time,$jb.time-conv(%jb.file),&bitrate, [ $mp3(%jb.file).bitrate $+ kbps ] ,&frequency, [ $int($calc($mp3(%jb.file).sample / 1000)) $+ khz ] ),&filename,&advertise)
        if (($jb.read(spam) == channel) && ($comchan($me,0) > 0)) ame is %jb.echo $iif(%jb.server,$ifmatch)
        elseif ($jb.read(spam) == active) {
          if (($appactive) && ($appstate != minimized) && ($appstate != tray)) showmirc -s
          if ($active ischan) { var %jb.aspam $active | describe %jb.aspam is %jb.echo $iif(%jb.server,$ifmatch) }
        }
        elseif ($jb.read(spam) == nospam) {
          if (($appactive) && ($appstate != minimized) && ($appstate != tray)) showmirc -s
          echo $colour(info) -a -You are %jb.echo $iif(%jb.server,$ifmatch)
        }
      }
    }
  }
  else echo $colour(info2) -a Error: Jukebox media file ( $+ %jb.file $+ ) does not exist
}
alias jb.read return $readini " $+ $scriptdirjukebox.ini $+ " jukebox $$1
alias jb.rem { var %i 1 | while ($ [ $+ [ %i ] ] ) { .remini " $+ $scriptdirjukebox.ini $+ " jukebox $ [ $+ [ %i ] ] | inc %i } }
alias -l jb.scroll {
  if ($window(@jukebox)) {
    if (%jb.scroll >= $len($1-)) %jb.scroll = 1 | drawtext -cb @jukebox $hget(jb.skin,disp-text) $hget(jb.skin,disp-bg) $hget(jb.skin,disp-font) $hget(jb.skin,disp-loc) $mid($1-,%jb.scroll,$len($1-)) $1- $1- | inc %jb.scroll                   
  }
  else .timerjb.scroll off
}
alias -l jb.seek {
  if ($window(@jukebox)) {
    tokenize 32 $hget(jb.skin,seek) $hget(jb.skin,seek-slider)
    var %jb.seek.loc $int($calc($7 + (($5 * .85) * ($inmp3.pos / $inmp3.length))))
    jb.draw.load $1-6 | jb.draw.load $iif($calc($1 + $5 - $11) < %jb.seek.loc,$ifmatch,%jb.seek.loc) $8-
    drawpic @jukebox
  }
  else .timerjb.seek off
}
alias -l jb.selectfile {
  if ($nofile($jb.read(file))) var %jb.selfile = $$sfile($ifmatch,Choose a media file or playlist)
  else var %jb.selfile = $$sfile($iif($jb.read(startdir),$ifmatch,$mircdir),Choose a media file or playlist)
  jb.clean | $jb.rem(replay,paused) | $jb.write(file) %jb.selfile
  if (*.m3u iswm %jb.selfile) {
    if ($hget(jb.playlist)) hfree jb.playlist
    if ($lines(%jb.selfile) > 0) {
      hmake jb.playlist $iif($ifmatch > 9,$int($calc($ifmatch / 10)),10) | hload -n jb.playlist " $+ %jb.selfile $+ "
      if ($hmatch(jb.playlist,#ext*,0).data > 0) {
        while ($hmatch(jb.playlist,#ext*,1).data) { hdel jb.playlist $ifmatch }
        hsave -no jb.playlist " $+ %jb.selfile $+ " | hload -n jb.playlist " $+ %jb.selfile $+ "
      }
    }
    $jb.write(curplaylist) %jb.selfile | $jb.write(echofile) $nopath(%jb.selfile) | pl.list
  }
  elseif ((*mp? iswm %jb.selfile) && ($right(%jb.selfile,1) isnum 2-3)) {
    if (($mp3(%jb.selfile).artist) && ($mp3(%jb.selfile).title)) $jb.write(echofile) $mp3(%jb.selfile).artist - $mp3(%jb.selfile).title $jb.time-conv(%jb.selfile)
    else $jb.write(echofile) $remove($nopath(%jb.selfile),.mp3,.mp2) $jb.time-conv(%jb.selfile)
    .timerjb.scroll -om 0 200 jb.scroll $str($chr(160),5) $jb.read(echofile) | titlebar @jukebox - $jb.read(echofile)
  }
  else return
  if ($jb.read(playonselect)) jb.play
  else { .timerjb.scroll -om 0 200 jb.scroll $str($chr(160),5) $jb.read(echofile) | titlebar @jukebox - $jb.read(echofile) }
}
alias jb.start {
  if ($window(@jukebox) == $null) jukebox
  if (($1-) && (*.mp? iswm $1-)) {
    if ($isfile($1-)) $jb.write(file) $1-
    else {
      var %jb.isfile = $jb.read(startdir) $+ $1-
      if ($isfile(%jb.isfile)) $jb.write(file) %jb.isfile
    }
  }
  elseif ($findfile($iif($jb.read(startdir),$ifmatch,$mircdir),*.mp?,0)) {
    var %jb.allfiles $ifmatch
    $jb.write(file) $findfile($iif($jb.read(startdir),$ifmatch,$mircdir),*.mp?,$rand(1,%jb.allfiles))
  }
  else return
  $jb.rem(replay) | jb.play
}
alias -l jb.time-conv {
  var %jb.time-conv $calc($mp3($1-).length / 1000)
  var %jb.time-conv.mins $int($calc(%jb.time-conv / 60))
  var %jb.time-conv.secs $round($calc(%jb.time-conv - (%jb.time-conv.mins * 60)),0)
  return $chr(40) $+ %jb.time-conv.mins $+ : $+ $iif(%jb.time-conv.secs < 10,0 $+ $ifmatch,%jb.time-conv.secs) $+ $chr(41)
}
alias jb.write return .writeini " $+ $scriptdirjukebox.ini $+ " jukebox $$1
on *:close:@jukebox: { splay stop | .timerjb.scroll off | .timerjb.seek off | jb.clean | unset %jb.* | if ($hget(jb.skin)) hfree jb.skin | if ($hget(jb.playlist)) hfree jb.playlist }
;Jukebox Playlist Manager
dialog jb.playlist {
  title "Revenant Jukebox"
  size 300 250 186 141
  option dbu
  box "Jukebox Playlist Manager", 2, 2 0 182 9
  button "Add File", 3, 145 20 39 9
  button "Remove File(s)", 4, 145 30 39 9
  button "Add Directory", 10, 145 40 39 9
  button "Clear Playlist", 14, 145 50 39 9
  button "Search", 17, 145 66 39 9
  button "New Playlist" , 11, 145 82 39 9
  button "Load Playlist", 12, 145 92 39 9
  button "Delete Playlist", 13, 145 102 39 9
  text "Playlist:", 5, 3 12 70 8
  text "Total Files:", 26, 80 12 80 8
  list 6, 2 20 140 110, autovs extsel
  button "Play" 7, 38 129 27 8
  button "Stop" 8, 68 129 27 8
  button "Ok", 15, 120 130 30 9, ok default
  button "Close", 16, 153 130 30 9, cancel
}
on *:dialog:jb.playlist:init:*: {
  if ($jb.read(curplaylist)) .timer 1 0 pl.list
  else did -b $dname 3,4,6,7,8,10,13,14,17
}
on *:dialog:jb.playlist:dclick:6: $pl.play($did(6).sel)
on *:dialog:jb.playlist:sclick:*: {
  if ($did == 3) {
    var %pl.add = $$sfile($iif($jb.read(startdir),$ifmatch,*.mp?),Choose a Song to Add to Your Playlist)
    hadd jb.playlist $calc($hget(jb.playlist,0).data + 1) %pl.add | did -a jb.playlist 6 $nopath(%pl.add) | hsave -no jb.playlist " $+ $jb.read(curplaylist) $+ "
    did -e jb.playlist 4,7,14,17 | did -c jb.playlist 6 $did(6).lines | did -ra jb.playlist 26 Total Files: $did(6).lines
  }
  elseif ($did == 4) {
    if ($did(jb.playlist,6,0).sel > 1) { var %i 1 | while ($did(6,%i).sel) { hdel jb.playlist $ifmatch | inc %i } }
    else hdel jb.playlist $$did(6).sel
    hsave -no jb.playlist " $+ $jb.read(curplaylist) $+ " | pl.list
  }
  elseif ($did == 7) { $jb.write(file) $jb.read(curplaylist) | pl.play }
  elseif ($did == 8) { splay stop | .timerjb.seek off }
  elseif ($did == 10) {
    var %pl.dir = $$sdir($iif($jb.read(startdir),$ifmatch,$mircdir),Choose a Directory to Add)
    if ($hget(jb.playlist)) hfree jb.playlist
    if ($window(@jb.playlist)) window -c @jb.playlist
    window $iif($jb.read(sortplaylists),-slh,-lh) @jb.playlist | loadbuf @jb.playlist " $+ $jb.read(curplaylist) $+ " | var %jb.findfile $findfile(%pl.dir,*.mp?,@jb.playlist)
    savebuf @jb.playlist " $+ $jb.read(curplaylist) $+ " | window -c @jb.playlist | did -e jb.playlist 4,7,14,17 
    hmake jb.playlist $iif($lines($jb.read(curplaylist)) > 9,$int($calc($ifmatch / 10)),10) | hload -no jb.playlist " $+ $jb.read(curplaylist) $+ " | pl.list
  }
  elseif ($did == 11) {
    var %pl.newpl = $$sfile( [ [ $iif($jb.read(startdir),$ifmatch,$mircdir) ] $+ *.m3u ] ,Choose a Directory/Filename)
    if (*.m3u !iswm %pl.newpl) var %pl.newpl %pl.newpl $+ .m3u
    $jb.write(curplaylist) %pl.newpl | write " $+ %pl.newpl $+ " Remove This Line and Add Your files!
    did -e jb.playlist 3,4,6,7,8,10,13,14,17 | jb.clean | pl.list
  }
  elseif ($did == 12) {
    if ($nofile($jb.read(curplaylist))) var %pl.loadpl = $$sfile( [ $ifmatch $+ ] *.m3u,Choose a Playlist)
    else var %pl.loadpl = $$sfile( [ [ $iif($jb.read(startdir),$ifmatch) ] $+ ] *.m3u,Choose a Playlist)
    if ($hget(jb.playlist)) hfree jb.playlist
    if ($lines(%pl.loadpl) > 0) {
      hmake jb.playlist $iif($ifmatch > 9,$int($calc($ifmatch / 10)),10) | hload -n jb.playlist " $+ %pl.loadpl $+ "
      if ($hmatch(jb.playlist,#ext*,0).data > 0) {
        var %i 1 | while ($hmatch(jb.playlist,#ext*,%i).data) { hdel jb.playlist $ifmatch | inc %i }
        hsave -no jb.playlist " $+ %pl.loadpl $+ " | hload -n jb.playlist " $+ %pl.loadpl $+ "
      }
    }
    $jb.write(curplaylist) %pl.loadpl | did -e jb.playlist 3,4,6,7,8,10,13,14,17 | jb.clean | pl.list
  }
  elseif ($did == 13) {
    if ($?!="Really Delete this Playlist?") {
      .remove " $+ $jb.read(curplaylist) $+ " | $jb.rem(curplaylist) | jb.clean | hfree jb.playlist
      did -r jb.playlist 5,6,26 | did -b jb.playlist 3,4,6,7,8,10,13,14,17
    }
  }
  elseif (($did == 15) || ($did == 16)) unset %jb.lastsearch
  elseif ($did == 14) { if ($?!="Really Clear this Playlist?") { write -c " $+ $jb.read(curplaylist) $+ " | jb.clean | pl.list | hfree jb.playlist } }
  elseif ($did == 17) {
    var %pl.search = * $+ $$dialog(jb.playlist.search,jb.playlist.search,-4) $+ *
    var %i $calc($did(6).sel + 1) | while ($hget(jb.playlist,%i)) { if (%pl.search iswm $ifmatch) { did -c $dname 6 %i | return } | else inc %i }
    did -c $dname 6 1
  }
}
dialog jb.playlist.search {
  title "Find Song"
  size -1 -1 100 34
  option dbu
  edit "", 4, 2 11 96 10, default autohs result
  button "OK", 1, 46 23 25 9, ok
  button "Cancel", 2, 73 23 25 9, cancel
  text "Search String:", 5, 2 3 40 8
}
on *:dialog:jb.playlist.search:init:*: if (%jb.lastsearch) did -ra $dname 4 $ifmatch
on *:dialog:jb.playlist.search:sclick:1: %jb.lastsearch = $$did(4)
alias -l pl.back {
  if (*.m3u iswm $jb.read(file)) {
    if (($hget(jb.lastplfiles)) && ($calc(%jb.totalfiles + %jb.offset) > 1)) {
      dec %jb.offset
      var %jb.plfilenum $hget(jb.lastplfiles,$calc(%jb.totalfiles + %jb.offset))
      var %pl.file = $hget(jb.playlist,%jb.plfilenum)
      if ($isfile(%pl.file) == $false) {
        var %jb.isfile = $nofile($jb.read(curplaylist)) $+ %pl.file
        if ($isfile(%jb.isfile)) var %pl.file = %jb.isfile
      }
      $jb.write(plfile) %pl.file | $jb.play.run(playlist)
    }
  }
  elseif ($inmp3) splay seek $calc($inmp3.pos - 5000)
}
alias -l pl.forward {
  if (*.m3u iswm $jb.read(file)) {
    if (($hget(jb.lastplfiles)) && ($calc(%jb.totalfiles + %jb.offset) < $hget(jb.lastplfiles,0).item)) {
      if (0 > %jb.offset) inc %jb.offset
      %jb.plfilenum = $hget(jb.lastplfiles,$calc(%jb.totalfiles + %jb.offset))
      var %pl.file = $hget(jb.playlist,%jb.plfilenum)
      if ($isfile(%pl.file) == $false) {
        var %jb.isfile = $nofile($jb.read(curplaylist)) $+ %pl.file
        if ($isfile(%jb.isfile)) var %pl.file = %jb.isfile
      }
      $jb.write(plfile) %pl.file | $jb.play.run(playlist)
    }
    else pl.play
  }
  elseif ($inmp3) splay seek $calc($inmp3.pos + 5000)
}
alias -l pl.list {
  var %pl.file " $+ $jb.read(curplaylist) $+ "
  if (($dialog(jb.playlist)) && ($isfile(%pl.file))) {
    did -r jb.playlist 5,6,26 | did -a jb.playlist 5 Playlist: $nopath(%pl.file)
    if ($lines(%pl.file) > 0) {
      if ($jb.read(sortplaylists)) { window -slh @jb.playlist | loadbuf @jb.playlist %pl.file | write -c %pl.file | savebuf @jb.playlist %pl.file | window -c @jb.playlist }
      if ($hget(jb.playlist)) hfree jb.playlist | hmake jb.playlist $iif($lines($jb.read(curplaylist)) > 9,$int($calc($ifmatch / 10)),10) | hload -n jb.playlist %pl.file
      var %i 1 | while ($hget(jb.playlist,%i)) { did -a jb.playlist 6 $nopath($ifmatch) | inc %i }
      did -a jb.playlist 26 Total Files: $hget(jb.playlist,0).data | did -c jb.playlist 6 $iif(%jb.plfilenum,$ifmatch,1)
    }
    else did -b jb.playlist 4,7,14,17
  }
}
alias -l pl.play {
  var %pl.lines = $hget(jb.playlist,0).item
  if (%pl.lines > 0) {
    if (%jb.totalfiles >= %pl.lines) jb.clean
    inc %jb.totalfiles
    if ($1) { %jb.offset = 0 | %jb.plfilenum = $ifmatch }
    elseif ($jb.read(random)) { %jb.plfilenum = $rand(1,%pl.lines) | while ($hfind(jb.lastplfiles,%jb.plfilenum,0).data > 0) { %jb.plfilenum = $rand(1,%pl.lines) } }
    else { if (%jb.plfilenum >= %pl.lines) jb.clean | %jb.plfilenum = $calc(%jb.plfilenum + 1) }
    var %pl.file = $hget(jb.playlist,%jb.plfilenum)
    if ($isfile(%pl.file) == $false) {
      var %jb.isfile = $nofile($jb.read(curplaylist)) $+ %pl.file
      if ($isfile(%jb.isfile)) var %pl.file = %jb.isfile
    }
    if ($hget(jb.lastplfiles) == $null) hmake jb.lastplfiles 50 | hadd jb.lastplfiles %jb.totalfiles %jb.plfilenum
    $jb.write(plfile) %pl.file | $jb.play.run(playlist)
  }
  else echo $colour(info2) -a Error: Your Jukebox playlist is empty!
}
on *:mp3end: {
  .timerjb.seek off 
  if ($window(@jukebox)) {
    if (*.m3u iswm $jb.read(file)) pl.forward
    elseif (($jb.read(continuous)) && ($jb.read(startdir))) {
      var %jb.grab = $findfile($jb.read(startdir),*.mp?,0)
      if (%jb.grab > 0) { $jb.write(file) $findfile($jb.read(startdir) ,*.mp?, [ $rand(1,%jb.grab) ] ) | $jb.play.run(jukebox) }
    }
  }
}
;MP3 Server
menu @mp3list {
  Generate List: jb.server.list
  $iif($isfile($scriptdir@mp3list.txt),Remove MP3List) : { .remove " $+ $scriptdir@mp3list.txt $+ " | clear }
  $iif($jb.read(server),Advertise Server) : ame invites you to check out his MP3 server, get a file list by typing @mp3list $me
}
alias -l jb.server.list {
  var %jb.server.start $?!="Warning, this may cause your mIRC to lock for a few seconds, continue?"
  if (%jb.server.start) {
    var %jb.server.dir = $$sdir($iif($jb.read(startdir),$ifmatch,$mircdir),Choose a Directory to Start From)
    if ($isfile($scriptdir@mp3list.txt)) write -c " $+ $scriptdir@mp3list.txt $+ "
    if ($window(@mp3list)) window -c @mp3list | window -hls @mp3list
    var %jb.server.findfile = $findfile(%jb.server.dir,*.mp3,@mp3list)
    var %i 1 | while ($line(@mp3list,%i)) { rline @mp3list %i @getmp3 $iif($setup.read(main,nick),$setup.read(main,nick),$me) $nopath($line(@mp3list,%i)) | inc %i }
    savebuf @mp3list " $+ $scriptdir@mp3list.txt $+ " | window -c @mp3list
    write -l1 " $+ $scriptdir@mp3list.txt $+ " MP3List, Generated by Revenant Jukebox, copy/paste the @getmp3 "nick" "filename" to request a file
    jb.server.view
  }
}
alias -l jb.server.terminator {
  if ($jb.read(downloads) > $send(0)) {
    if ($send(0) == 0) { .timerjb.server.terminator off | $jb.rem(downloads) }
    else { .timerjb.server.terminator off | $jb.write(downloads) $calc($jb.read(downloads) - 1) }
  }
}
alias -l jb.server.view {
  window -l @mp3list 100 100 650 250
  if ($isfile($scriptdir@mp3list.txt)) { loadbuf @mp3list " $+ $scriptdir@mp3list.txt $+ " | sline @mp3list 1 }
  else aline $colour(info2) @mp3list @mp3list.txt does not exist, right click and select "Generate List" to create a MP3 List
}
on *:text:@*:*: {
  if ($jb.read(server)) {
    if (($1 == @getmp3) && ($2 == $me)) {
      if (($send(0) == 0) && ($jb.read(downloads) > 0)) $jb.rem(downloads)
      if ($jb.read(maxdownloads) <= $jb.read(downloads)) .privmsg $nick Error: too many downloads in progress, please wait a few minutes and try again
      elseif ($findfile($jb.read(startdir),$3-,1)) { dcc send $nick $ifmatch | $jb.write(downloads) $calc($jb.read(downloads) + 1) | .timerjb.server.terminator -o 0 30 jb.server.terminator }
      else .privmsg $nick Error: " $+ $3- $+ " No such file, type @mp3list to view a list of available mp3's
    }
    elseif (($1 == @mp3list) && ($2 == $me) && ($isfile($scriptdir@mp3list.txt))) .dcc send $nick " $+ $scriptdir@mp3list.txt $+ "
  }
}
on *:filesent:*.mp3: { if ($jb.read(downloads) > 1) $jb.write(downloads) $calc($ifmatch - 1) | else $jb.rem(downloads) }
on *:sendfail:*.mp3: { if ($jb.read(downloads) > 1) $jb.write(downloads) $calc($ifmatch - 1) | else $jb.rem(downloads) }
on *:exit: $jb.rem(downloads)
;Skin Browser
dialog jb.skin.browser {
  title "Revenant Jukebox"
  size 400 250 164 115
  option dbu
  box "Jukebox Skin Browser", 1, 2 0 160 9
  text "Select a File:", 2, 2 12 50 8
  list 3, 2 20 50 85, autovs
  button "Add", 4, 54 21 23 8
  button "Remove", 5, 54 30 23 8
  box "Preview", 6, 55 39 96 62
  icon 7, 53 47 100 50
  text "Loading Image...", 8, 80 68 40 8
  button "Ok", 15, 98 104 30 9, ok default
  button "Close", 16, 131 104 30 9, cancel
}
on *:dialog:jb.skin.browser:init:*: {
  if ($isfile($scriptdirskins\default.skin) == $false) { echo $colour(info2) -a Error: Default Skin does not exist, Jukebox will not function properly | dialog -x jb.skin.browser | return }
  else {
    $jb.write(skin-prev) $iif($jb.read(activeskin),$ifmatch,default.skin)
    jb.skin.list | jb.skin.preview
    if ($did(3).seltext == <default>) did -b $dname 5
  }
}
on *:dialog:jb.skin.browser:sclick:*: {
  if ($did == 3) {
    did $iif($did(3).seltext == <default>,-b,-e) $dname 5 | did -v $dname 8 | did -h $dname 7
    var %jb.skin.newskin $replace($did(3).seltext,<default>,default.skin)
    $jb.write(skin-prev) %jb.skin.newskin | jb.skin.preview
  }
  elseif ($did == 4) {
    var %jb.newskin $$sfile($mircdir [ $+ *.skin ] ,Choose a .skin file to add)
    if ($scriptdirskins isin %jb.newskin) return
    var %jb.newskin.buttons $readini " $+ %jb.newskin $+ " files bmp
    var %jb.newskin.bg $readini " $+ %jb.newskin $+ " bg image
    if ($isfile( [ $nofile(%jb.newskin) $+ [ %jb.newskin.buttons ] ] )) .copy " $+ $nofile(%jb.newskin) $+ %jb.newskin.buttons $+ " " $+ $scriptdirskins\ $+ %jb.newskin.buttons $+ "
    if ($isfile( [ $nofile(%jb.newskin) $+ [ %jb.newskin.bg ] ] )) .copy " $+ $nofile(%jb.newskin) $+ %jb.newskin.bg $+ " " $+ $scriptdirskins\ $+ %jb.newskin.bg $+ "
    .copy " $+ %jb.newskin $+ " " $+ $scriptdirskins\ $+ $nopath(%jb.newskin) $+ "
    jb.skin.list
  }
  elseif ($did == 5) {
    if ($?!="Really delete this skin?") {
      if ($jb.read(skin-prev) == $jb.read(activeskin)) $jb.write(activeskin) default.skin
      tokenize 94 $hget(jb.skin-prev,bmp-file) $+ ^ $+ $hget(jb.skin-prev,skin-file) $+ ^ $+ $hget(jb.skin-prev,bg-image)
      var %i 1 | while ($ [ $+ [ %i ] ] ) { .remove " $+ $scriptdirskins\ $+ $ifmatch $+ " | inc %i }
      $jb.write(skin-prev) default.skin | did -r $dname 3 | jb.skin.list | jb.skin.preview
    }
  }
  elseif ($did == 15) {
    if ($isfile($scriptdirjb-prev.bmp)) .remove " $+ $scriptdirjb-prev.bmp $+ "
    if ($jb.read(skin-prev)) $jb.write(activeskin) $ifmatch
    %jb.xy = $window(@jukebox).x $window(@jukebox).y | window -c @jukebox | .timer 1 0 jukebox
    if ($hget(jb.skin-prev)) hfree jb.skin-prev
  }
  elseif ($did == 16) { if ($isfile($scriptdirjb-prev.bmp)) .remove " $+ $scriptdirjb-prev.bmp $+ " | if ($hget(jb.skin-prev)) hfree jb.skin-prev }
}
alias -l jb.skin.list {
  window -hls @jb.skin.prev
  if ($findfile($scriptdirskins\,*.skin,@jb.skin.prev) > 0) {
    did -r jb.skin.browser 3
    var %jb.skin.active $jb.read(activeskin)
    if ((%jb.skin.active) && (%jb.skin.active != default.skin)) did -a jb.skin.browser 3 %jb.skin.active
    did -a jb.skin.browser 3 <default>
    var %i 1 | while ($line(@jb.skin.prev,%i)) {
      var %jb.skin.file = $nopath($ifmatch)
      if ((%jb.skin.file != %jb.skin.active) && (default.skin != %jb.skin.file) && (example.skin != %jb.skin.file)) did -a jb.skin.browser 3 %jb.skin.file 
      inc %i
    }
    did -c jb.skin.browser 3 1
  }
  else echo $colour(info2) -a Error: There are no Jukebox skins available
  window -c @jb.skin.prev
}
alias -l jb.skin.preview {
  if ($hget(jb.skin-prev) == $null) hmake jb.skin-prev 5
  if ($scriptdirskins\ [ $+ [ $jb.read(skin-prev) ] ] ) hload jb.skin-prev " $+ $scriptdirskins\ $+ $jb.read(skin-prev) $+ "
  window -hpk0 +dl @jukebox-prev 525 125 $hget(jb.skin-prev,size)
  drawrect -f @jukebox-prev $hget(jb.skin-prev,bg-color) 0 0 0 $hget(jb.skin-prev,size)
  $iif($hget(jb.skin-prev,bg-image),jb.draw.prev $hget(jb.skin-prev,bg-loc) " $+ $scriptdirskins\ $+ $hget(jb.skin-prev,bg-image) $+ ")
  drawtext @jukebox-prev $hget(jb.skin-prev,header-color) $hget(jb.skin-prev,header-font) $hget(jb.skin-prev,header-loc) Revenant Jukebox
  jb.draw.prev $hget(jb.skin-prev,close) | jb.draw.prev $hget(jb.skin-prev,min)
  jb.draw.prev $hget(jb.skin-prev,back) | jb.draw.prev $hget(jb.skin-prev,play)
  jb.draw.prev $hget(jb.skin-prev,pause) | jb.draw.prev $hget(jb.skin-prev,stop)
  jb.draw.prev $hget(jb.skin-prev,forward) | jb.draw.prev $hget(jb.skin-prev,open)
  jb.draw.prev $hget(jb.skin-prev,mp3list) | jb.draw.prev $hget(jb.skin-prev,playlist)
  jb.draw.prev $hget(jb.skin-prev,id3) | jb.draw.prev $hget(jb.skin-prev,seek)
  jb.draw.prev $hget(jb.skin-prev,seek-slider) | jb.draw.prev $hget(jb.skin-prev,volume)
  jb.draw.prev $hget(jb.skin-prev,vol-slider)
  drawtext -cb @jukebox-prev $hget(jb.skin-prev,disp-text) $hget(jb.skin-prev,disp-bg) $hget(jb.skin-prev,disp-font) $hget(jb.skin-prev,disp-loc) Korn - Make Me Bad (4:00)
  drawsave @jukebox-prev " $+ $scriptdirjb-prev.bmp $+ "
  did -g jb.skin.browser 7 " $+ $scriptdirjb-prev.bmp $+ "
  did -h jb.skin.browser 8 | did -v jb.skin.browser 7
  window -c @jukebox-prev
}
;ID3 Editor
alias jb.id3.editor dialog $iif($dialog(jb.id3.editor),-v,-ma) jb.id3.editor jb.id3.editor
dialog jb.id3.editor {
  title "Revenant Jukebox"
  size 100 100 196 101
  option dbu
  box "Jukebox id3 Editor", 1, 3 1 190 9
  text "Filename:", 2, 4 12 23 9, left
  text "", 3, 31 12 170 10
  text "Title", 4, 4 25 23 8, right
  edit "", 5, 30 24 65 10, left autohs limit 30
  text "Artist", 6, 4 35 23 8, right
  edit "", 7, 30 34 65 10, left autohs limit 30
  text "Album", 8, 4 45 23 8, right
  edit "", 9, 30 44 65 10, left autohs limit 30
  text "Year", 10, 4 55 23 8, right
  edit "", 11, 30 54 65 10, left autohs limit 4
  text "Comment", 12, 4 65 23 8, right
  edit "", 13, 30 64 65 10, left autohs limit 30
  text "Genre", 14, 4 75 23 8, right
  combo 15, 30 74 65 100, sort drop
  box "File Info", 16, 104 21 86 63
  text "Size ", 17, 109 30 25 8, right
  edit "", 18, 135 29 50 10, left read autohs
  text "Length ", 19, 109 40 25 8, right
  edit "", 20, 135 39 50 10, left read autohs
  text "Rates ", 21, 109 50 25 8, right
  edit "", 22, 135 49 50 10, left read autohs
  text "Copyright ", 23, 109 60 25 8, right
  edit "", 24, 135 59 50 10, left read autohs
  text "Quality ", 25, 109 70 25 8, right
  edit "", 26, 135 69 50 10, left read autohs
  button "Enable id3", 27, 3 89 33 9
  button "Ok", 28, 133 89 28 9, ok
  button "Close", 29, 164 89 28 9, cancel
}
on *:dialog:jb.id3.editor:init:*: {
  var %jb.file $iif(*.m3u iswm $jb.read(file),$jb.read(plfile),$jb.read(file))
  didtok $dname 15 46 Blues.Classic Rock.Country.Techno.Disco.Grunge.Hip-Hop.Jazz.New Age.Pop.Rap.Rock.Alternative.Soundtrack.Classical.Instrumental.Gospel.Soul.Gothic.Comedy.Rave.Swing.Other
  if ($isfile(%jb.file)) jb.id3.load
  else { did -b $dname 27,28 | did -ra $dname 3 Error: File not found }
}
on *:dialog:jb.id3.editor:sclick:*: {
  var %jb.file $iif(*.m3u iswm $jb.read(file),$jb.read(plfile),$jb.read(file))
  if ($did == 27) jb.id3.enable %jb.file
  elseif ($did == 28) {
    if ((%jb.file) && ($isfile(%jb.file))) {
      splay stop | .timerjb.seek off
      if ($jb.id3.check(%jb.file)) { 
        $jb.id3.title(%jb.file,$did(5)) | $jb.id3.artist(%jb.file,$did(7))
        $jb.id3.album(%jb.file,$did(9)) | $jb.id3.year(%jb.file,$did(11))
        $jb.id3.comment(%jb.file,$did(13)) | $jb.id3.genre(%jb.file,$jb.id3.genre.list($did(15).seltext))
      }
    }
    else echo $colour(info2) -a Error: No file to edit
  }
}
alias -l jb.id3.artist {
  var %jb.file.sector $calc($file($1).size - 95)
  if ($2) { bset &_tmp 30 $2 | bset &_tmp2 1 $2 | bwrite " $+ $1 $+ " %jb.file.sector 30 &_tmp | bwrite " $+ $1 $+ " %jb.file.sector 30 $2 }
  else { bset &_tmp 30 $asc($chr(32)) | bwrite " $+ $1 $+ " %jb.file.sector 30 &_tmp }
}
alias -l jb.id3.album {
  var %jb.file.sector $calc($file($1).size - 65)
  if ($2) { bset &_tmp 30 $2 | bset &_tmp2 1 $2 | bwrite " $+ $1 $+ " %jb.file.sector 30 &_tmp | bwrite " $+ $1 $+ " %jb.file.sector 30 $2 }
  else { bset &_tmp 30 $asc($chr(32)) | bwrite " $+ $1 $+ " %jb.file.sector 30 &_tmp }
}
alias -l jb.id3.check {
  bread " $+ $1 $+ " $calc($file($1).size - 128) 3 &id3Tag
  return $iif($bvar(&id3Tag,1-3).text == TAG,$true,$false)
}
alias -l jb.id3.comment {
  var %jb.file.sector $calc($file($1).size - 31)
  if ($2) { bset &_tmp 30 $2 | bset &_tmp2 1 $2 | bwrite " $+ $1 $+ " %jb.file.sector 30 &_tmp | bwrite " $+ $1 $+ " %jb.file.sector 30 $2 }
  else { bset &_tmp 30 $asc($chr(32)) | bwrite " $+ $1 $+ " %jb.file.sector 30 &_tmp }
}
alias -l jb.id3.enable {
  if ($jb.id3.check($$1-)) return
  elseif ((*.mp3 iswm $$1-) && ($mp3($1-).version == MPEG 1.0 Layer 3)) {
    splay stop | .timerjb.seek off | var %jb.file.size $file($1-).size
    bwrite " $+ $1- $+ " $calc(%jb.file.size - 128) 3 TAG
    bset &_tmp 125 x | bwrite " $+ $1- $+ " $calc(%jb.file.size - 125) 124 &_tmp
    did -e $dname 5,7,9,11,13,15 | jb.id3.load
  }
  else echo $colour(info2) -a Error: File is not a valid mp3, cannot write id3 tags
}
alias -l jb.id3.genre {
  var %jb.file.sector $calc($file($1).size - 1)
  if ($2) { bset &_newg 1 $2 | bwrite " $+ $1 $+ " %jb.file.sector 1 &_newg }
  else { bset &_tmp 30 $asc($chr(32)) | bwrite " $+ $1 $+ " %jb.file.sector 30 &_tmp }
}
alias -l jb.id3.genre.list {
  if ($1 == Blues) return 0
  elseif ($1 == Classic Rock) return 1
  elseif ($1 == Country) return 2
  elseif ($1 == Disco) return 4
  elseif ($1 == Grunge) return 6
  elseif ($1 == Hip-Hop) return 7
  elseif ($1 == Jazz) return 8
  elseif ($1 == New Age) return 10
  elseif ($1 == Pop) return 13
  elseif ($1 == Rap) return 15
  elseif ($1 == Rock) return 17
  elseif ($1 == Techno) return 18
  elseif ($1 == Alternative) return 20
  elseif ($1 == Soundtrack) return 24
  elseif ($1 == Classical) return 32
  elseif ($1 == Instrumental) return 33
  elseif ($1 == Gospel) return 38
  elseif ($1 == Soul) return 42
  elseif ($1 == Gothic) return 49
  elseif ($1 == Comedy) return 57
  elseif ($1 == Rave) return 68
  elseif ($1 == Swing) return 83
  else return 12
}
alias -l jb.id3.load {
  var %jb.file $iif(*.m3u iswm $jb.read(file),$jb.read(plfile),$jb.read(file))
  if (%jb.file) {
    if ($jb.id3.check(%jb.file)) {
      did -b jb.id3.editor 27 | did -e jb.id3.editor 5,7,9,11,13,15,28
      did -ra jb.id3.editor 5 $strip($mp3(%jb.file).title)
      did -ra jb.id3.editor 7 $strip($mp3(%jb.file).artist)
      did -ra jb.id3.editor 9 $strip($mp3(%jb.file).album)
      did -ra jb.id3.editor 11 $strip($mp3(%jb.file).year)
      did -ra jb.id3.editor 13 $strip($mp3(%jb.file).comment)
      did -c jb.id3.editor 15 15
      if ($mp3(%jb.file).genre) { var %jb.file.genre $ifmatch | var %i 1 | while ($did(jb.id3.editor,15,%i)) { if ($ifmatch == %jb.file.genre) { did -c jb.id3.editor 15 %i | break } | inc %i } }
    }
    else { did -rb jb.id3.editor 5,7,9,11,13 | did -cb jb.id3.editor 15 0 | did -e jb.id3.editor 27 }
    did -ra jb.id3.editor 3 $nopath(%jb.file)
    did -ra jb.id3.editor 18 $bytes($file(%jb.file).size,b) bytes
    did -ra jb.id3.editor 20 $duration($calc($mp3(%jb.file).length / 1000))
    did -ra jb.id3.editor 22 $mp3(%jb.file).bitrate $+ k $+ / $+ $calc($mp3(%jb.file).sample / 1000) $+ khz
    did -ra jb.id3.editor 24 $iif($mp3(%jb.file).copyright,Yes,No)
    did -ra jb.id3.editor 26 $mp3(%jb.file).mode
  }
}
alias -l jb.id3.title {
  var %jb.file.sector $calc($file($1).size - 125)
  if ($2) { bset &_tmp 30 $2 | bset &_tmp2 1 $2 | bwrite " $+ $1 $+ " %jb.file.sector 30 &_tmp | bwrite " $+ $1 $+ " %jb.file.sector 30 $2 }
  else { bset &_tmp 30 $asc($chr(32)) | bwrite " $+ $1 $+ " %jb.file.sector 30 &_tmp }
}
alias -l jb.id3.year {
  var %jb.file.sector $calc($file($1).size - 35)
  if ($2) { bset &_tmp 4 $2 | bset &_tmp2 1 $2 | bwrite " $+ $1 $+ " %jb.file.sector 4 &_tmp | bwrite " $+ $1 $+ " %jb.file.sector 4 $2 }
  else { bset &_tmp 30 $asc($chr(32)) | bwrite " $+ $1 $+ " %jb.file.sector 30 &_tmp }
}
;Jukebox Setup
alias jukebox.setup dialog $iif($dialog(jb.setup),-v,-m) jb.setup jb.setup
dialog jb.setup {
  title "Revenant Jukebox"
  size -1 -1 195 95
  option dbu
  box "Jukebox Settings", 1, 3 1 189 9
  text "Music Directory:", 2, 3 16 38 8
  edit "", 3, 42 14 122 10, autohs
  button "Select", 4, 166 15 25 8
  check "Song Spammer", 5, 3 28 45 10
  radio "Spam to All Channels", 6, 13 38 60 10
  radio "Spam to Active Chat", 7, 13 48 58 10
  radio "Echo Songs", 8, 13 58 53 10
  check "Play on Selection", 9, 128 28 50 10
  check "Randomize Tracks", 10, 128 38 55 10
  check "Continuous Play", 11, 128 48 47 10
  check "Sort Playlists", 18, 128 58 47 10
  check "MP3 Server", 13, 75 28 37 10
  text "Max Sends:", 14, 79 40 40 10
  edit "", 15, 108 38 15 10
  check "Open Ontop", 22, 75 48 40 10
  text "Spam Message:", 16, 3 72 40 8
  edit "", 17, 42 70 140 10, left autohs limit 80
  button "?", 19, 183 71 8 8
  button "Ok", 20, 140 84 25 9, ok
  button "Cancel", 21, 168 84 25 9, cancel
}
on *:dialog:jb.setup:init:*: {
  if ($jb.read(startdir)) did -a $dname 3 $ifmatch
  if ($jb.read(echosongs)) did -c $dname 5
  else did -b $dname 6,7,8,17
  if ($jb.read(spam) == channel) did -c $dname 6
  elseif ($jb.read(spam) == active) did -c $dname 7
  else did -c $dname 8
  if ($jb.read(playonselect)) did -c $dname 9
  if ($jb.read(random)) did -c $dname 10
  if ($jb.read(continuous)) did -c $dname 11
  did $iif($jb.read(server),-c $dname 13,-b $dname 15)
  if ($jb.read(maxdownloads)) did -a $dname 15 $ifmatch
  if ($jb.read(sortplaylists)) did -c $dname 18
  if ($jb.read(ontop)) did -c $dname 22
  did -a $dname 17 $iif($jb.read(spammsg),$replace($ifmatch,&color,,&bold,,&underline,,&normal,),listening to [&artist - &song &time])
}
on *:dialog:jb.setup:sclick:*: {
  if ($did == 4) {
    var %jb.selectdir = $$sdir(C:\,Select your base media directory. (ie C:\Music))
    if ($right(%jb.selectdir,1) != $chr(92)) var %jb.selectdir %jb.selectdir $+ $chr(92)
    if ($dialog(jb.setup)) did -ra jb.setup 3 %jb.selectdir
    $jb.write(startdir) %jb.selectdir
  }
  elseif ($did == 5) did $iif($did(5).state == 1,-e,-b) $dname 6,7,8,17
  elseif ($did == 13) did $iif($did(13).state == 1,-e,-b) $dname 15
  elseif ($did == 19) dialog $iif($dialog(jb.setup.codes),-v,-ma) jb.setup.codes jb.setup.codes
  elseif ($did == 20) {
    $iif($did(3),$jb.write(startdir) $ifmatch,$jb.rem(startdir))
    $jb.write(echosongs) $iif($did(5).state == 1,$true,$false)
    if ($did(6).state == 1) $jb.write(spam) channel
    elseif ($did(7).state == 1) $jb.write(spam) active
    else $jb.write(spam) nospam
    $jb.write(playonselect) $iif($did(9).state == 1,$true,$false)
    $jb.write(random) $iif($did(10).state == 1,$true,$false)
    $jb.write(continuous) $iif($did(11).state == 1,$true,$false)
    $jb.write(server) $iif($did(13).state == 1,$true,$false)
    $jb.write(sortplaylists) $iif($did(18).state == 1,$true,$false)
    $jb.write(ontop) $iif($did(22).state == 1,$true,$false)
    $iif($did(15),$jb.write(maxdownloads) $ifmatch,$jb.rem(maxdownloads))
    if ($did(17)) $jb.write(spammsg) $replace($ifmatch,,&color,,&bold,,&underline,,&normal) 
    else $jb.write(spammsg) listening to &color14[&artist - &song &time]&normal
  }
}
dialog jb.setup.codes {
  title "Revenant Jukebox"
  size -1 -1 95 75
  option dbu
  box "Spammer Codes", 1, 2 2 90 9
  list 2, 2 14 90 55
  button "Close", 20, 68 65 23 8, cancel
}
on *:dialog:jb.setup.codes:init:*: {
  didtok $dname 2 46 &filename - Filename.&artist - Artist (id3 Tag).&song - Title (id3 Tag).&time - Running Time (m:ss).&bitrate - mp3 Bitrate (kbps).&frequency - mp3 Frequency (khz).&advertise - Shows @getmp3 spam
  did -c $dname 2 1
}
on *:dialog:jb.setup.codes:dclick:2: did -a jb.setup 17 $gettok($did(2).seltext,1,32)
