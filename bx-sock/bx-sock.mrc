on *:sockopen:spy:{
  /sockwrite -n $sockname user %spy.ident " $+ $ip $+ " " $+ $server $+ " : $+ %spy.fullname
  /sockwrite -tn $sockname NICK %spy.nick
  /echo -s $ud 4bx-sock Connected! Nick: %spy.nick
  /window -e @Spy Helvetica 12
  /titlebar @spy [Connected] Nick: %spy.nick - Server:( $+ $sock($sockname).ip $+ )
}
on 1:sockread:spy:{
  if ($sockerr > 0) return
  sockread %tmp
  if ($window(@Spy) == $null) { window -e @Spy Helvetica 12 }
  if ($sockbr == 0) return
  if ($gettok(%tmp,1,32) == PING) { /swx PONG : $+ $gettok(%tmp,2,58) }
  if ($gettok(%tmp,4,32) == :VERSION) { /swx notice $spynick :VERSION bx-sock v1.0 for mIRC - http://shake.hit.bg $+  | echo @spy 4[CTCP VERSION]0 ->7 $spynick | halt }
  if ($gettok(%tmp,4,32) == :PING) { /swx notice $spynick :PING PONG | echo @spy 4[CTCP PING]0 ->7 $spynick | halt }
  if ($gettok(%tmp,2,32) == JOIN) { /echo @spy 3***7 $spynick 4has joined $remove($gettok(%tmp,3,32),:) | halt }
  if ($gettok(%tmp,2,32) == PART) { /echo @spy 3***7 $spynick 4has left $remove($gettok(%tmp,3,32),:) | halt }
  if ($gettok(%tmp,2,32) == KICK) { 
    if ($gettok(%tmp,4,32) == %spy.nick) { echo @spy 4You were kicked from $spynick by $remove( $gettok($gettok(%tmp,1,$asc(!)),1,32), $chr(58) ) 4with reason 7( $gettok(%tmp,5-,32) ) | sockwrite -tn $sockname JOIN $gettok(%tmp,3,32) | halt } 
    echo @spy 3***0 $gettok(%tmp,4,32) 4was kicked from  $+ $spynick $+  by11 $remove( $gettok($gettok(%tmp,1,$asc(!)),1,32), $chr(58) ) 4with reason 7( $gettok(%tmp,5-,32) )
    halt 
  }
  if ($gettok(%tmp,2,32) == 311) { 
    echo @spy 14-=9Whois for $gettok(%tmp,4,32) 14=- 
    echo @spy 14-=Nick:9 $gettok(%tmp,4,32) 14=-
    echo @spy 14-=Ident:9 $gettok(%tmp,5,32) 14=-
    echo @spy 14-=Host:9 $gettok(%tmp,6,32) 14=-
    echo @spy 14-=Fullname:9 $gettok(%tmp,7-,32) 14=-
    halt 
  }
  if ($gettok(%tmp,2,32) == 319) { echo @spy 14-=Channels:9 $gettok(%tmp,5-,32) 14=- | halt }
  if ($gettok(%tmp,2,32) == 312) { echo @spy 14-=Server:9 $gettok(%tmp,5-,32) 14=- | halt }
  if ($gettok(%tmp,2,32) == 317) { echo @spy 14-=Idle:9 $duration($gettok(%tmp,5,32)) 14=- | halt }
  if ($gettok(%tmp,2,32) == 318) { echo @spy 14-=9End of whois for $gettok(%tmp,4,32) 14=- | halt }
  if ($gettok(%tmp,2,32) == PRIVMSG) {
    if ($chr(35) isin $gettok(%tmp,3,32)) { echo @spy 12(15 $remove( $gettok($gettok(%tmp,1,$asc(!)),1,32), $chr(58) ) / $spynick $+ 12)0 $gettok(%tmp,4-,32) | halt }
    echo @spy 2MSG:0< $+ $spynick $+ >8 $gettok(%tmp,4-,32)
    halt 
  }
  if ($gettok(%tmp,2,32) == NOTICE) {
    if ($chr(35) isin $gettok(%tmp,3,32)) { echo @spy 11--NOTICE:0< $+ $spynick / $remove( $gettok($gettok(%tmp,1,$asc(!)),1,32), $chr(58) ) $+ >8 $gettok(%tmp,4-,32) | halt }
    echo @spy 11--NOTICE:0< $+ $spynick $+ >8 $gettok(%tmp,4-,32)  
    halt 
  }
  if ($gettok(%tmp,2,32) == MODE) { echo @spy 4*0|4*14 mode/10 $+ $gettok(%tmp,3,32) 15[ $+ $gettok(%tmp,4-,32) $+ ] by $remove( $gettok($gettok(%tmp,1,$asc(!)),1,32), $chr(58) ) | halt }
  if ($gettok(%tmp,2,32) == 421) { echo @spy 5***14unknown command: $gettok(%tmp,4,32) | halt }
  if ($gettok(%tmp,2,32) == 375) { echo @spy 13---===5 $gettok(%tmp,4-,32) 13===--- | halt }
  if ($gettok(%tmp,2,32) == 372) { echo @spy 5MOTD $gettok(%tmp,4-,32) | halt }
  if ($gettok(%tmp,2,32) == 376) { echo @spy 13---===5End of MOTD13===--- | halt }
  if ($gettok(%tmp,2,32) == TOPIC) { echo @spy 9<TOPIC/0 $+ $spynick $+ 9> $remove( $gettok($gettok(%tmp,1,$asc(!)),1,32), $chr(58) ) changes topic to11 $gettok(%tmp,4-,32) | halt }
  if ($gettok(%tmp,2,32) == 332) { echo @spy 3<<****13 $gettok(%tmp,4,32) 3****>> | echo @spy 3***7Topic $gettok(%tmp,5-,32) | halt }
  if ($gettok(%tmp,2,32) == 333) { echo @spy 3***7Set by0 $gettok(%tmp,5,32) | halt }
  if ($gettok(%tmp,2,32) == 353) { echo @spy 3***7Users0 $gettok(%tmp,6-,32) | halt }
  if ($gettok(%tmp,2,32) == 366) { echo @spy 3<<****13 End of $gettok(%tmp,4,32) Info 3****>> | halt }
  if ($gettok(%tmp,2,32) == 464) { echo @spy 11- $+ $spynick $+ -8 $gettok(%tmp,4-,32) | halt }
  if ($gettok(%tmp,2,32) == 381) { echo @spy 11- $+ $spynick $+ -8 $gettok(%tmp,4-,32) | halt }
  if ($gettok(%tmp,2,32) == 433) { echo @spy 4 $gettok(%tmp,4-,32) | halt }
  if ($gettok(%tmp,2,32) == 401) { echo @spy 4 $gettok(%tmp,4-,32) | halt }
  if ($gettok(%tmp,2,32) == NICK) { echo @spy 13 $spynick changes nick to0 $gettok(%tmp,3,32) | halt }
  if ($gettok(%tmp,2,32) == QUIT) { echo @spy 4SignOff11-> $spynick ( $+ $gettok(%tmp,3-,32) $+ ) | halt }
  if ($gettok(%tmp,2,32) == 306) { echo @spy 0>> $gettok(%tmp,4-,32) | halt }
  if ($gettok(%tmp,2,32) == 305) { echo @spy 0>> $gettok(%tmp,4-,32) | halt }
  /echo @spy 12 %tmp
}
alias swx {
  if ( $sock(spy) == $null ) { /echo -a 4(+)bx-sock: Not Connected to server! }
  else { /sockwrite -tn spy $1- }
}
alias spynick { 
  if ($left($gettok(%tmp,3,32),1) == $chr(35)) {  return $gettok(%tmp,3,32)  }
  else { return $remove( $gettok($gettok(%tmp,1,$asc(!)),1,32), $chr(58) ) }
}

on *:input:@Spy:{
  if ($left($1,1) == ,) && (%spy.console !== $null) { /swx PRIVMSG %spy.console : $+ $mid($1-,2-) | /echo @spy 0[5msg0(4 $+ %spy.console $+ 0)]15 $mid($1-,2-) }
  elseif ( $1 == m ) { /swx PRIVMSG $2 : $+ $3- | /echo @spy 0[5msg0(4 $+ $2 $+ 0)]15 $3- }
  elseif ($1 == console) {
    if ($2 == $null) { /echo @spy 4,0Current console: %spy.console | halt }
    /set %spy.console $2 
    /echo @spy 4,0Spy console set to: $2 
  }
  elseif ( $1 == j ) { /swx JOIN $2 }
  elseif ( $1 == p ) { /swx PART $2 }
  elseif ( $1 == k ) { /swx KICK $2 $3 : $+ $4- }
  elseif ( $1 == ban ) { /swx MODE $2 +b $3- }
  elseif ( $1 == kb ) { /swx MODE $2 +b $3- | /swx KICK $2 $3 : $+ $4- }
  else {  
    /swx $1-
    /echo @spy 6> $1-
  }
  halt
}
on *:sockclose:spy:{
  if ($window(@spy)) {
    /echo @spy 4Connection Closed!
    /titlebar @spy Not Connected!
  }
}
menu @Spy {
  Connect:/set %spy.nick $?="Enter nick:" | /sockopen spy $?="Enter server:" $?="Enter port (default 6667):"
  -
  Whois:/swx whois $?="Enter nick:"
  -
  Join:/swx join $?="Enter channel:"
  Part:/swx part $?="Enter channel:"
  -
  Op:/swx mode $?="Enter channel:" +o $?="Enter Nick:"
  DeOp:/swx mode $?="Enter channel:" -o $?="Enter Nick:"
  Voice:/swx mode $?="Enter channel:" +v $?="Enter Nick:"
  DeVoice:/swx mode $?="Enter channel:" -v $?="Enter Nick:"
  Ban:/swx mode $?="Enter channel:" +b $+ $?="Enter Hostmask:"
  Kick:/swx kick $?="Enter channel:" $+ $?="Enter nick:" : $+ $?="Enter Reason:"
  Mode:/swx mode $?="Enter channel:" $+ $?="Enter channel mode:"
  -
  MSG:/swx privmsg $?="Enter nick:" : $+ $?="Enter message:"
  -
  NS Id:/swx privmsg ns :identify $?*="Enter your nick password:"
  -
  Quit:/swx quit : $+ $?="Enter your quit message"
  Exit bx-sock:{
    swx quit :bx-sock addon for mIRC32 - Get it from http://shake.hit.bg
    /close -@ @Spy
  }
}
menu status,menubar {
 bx-sock
 .Connect:/set %spy.nick $?="Enter nick:" | /sockopen spy $?="Enter server:" $?="Enter port (default 6667):"
 .-
 .Settings
 ..Fullname( %spy.fullname ):/set %spy.fullname $?="Enter your fullname:"
 ..Ident( %spy.ident ):/set %spy.ident $?="Enter your ident:"
}
