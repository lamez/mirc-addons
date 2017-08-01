DarkBoT
coded by ShakE

http://shake.hit.bg
shake@rousse.zzn.com
shake@abv.bg

a) about
  a1) ShakE Corp.
  a2) DarkBot

b) installation

c) configuration
  c1) connection
  c2) modules
  c3) misc
  c4) users
  c5) protections

d) running



          ::::: a) about :::::



 ::: a1) ShakE Corp.
We Are one bulgaria TeaM,with many friends.We drink every day and when
we are drunk I sit on my PC and start to work!Very funny don't you think
:))))).Thats for us.Our nicks are ShakE, Antler and more...


 ::: a2) DarkBot 

DarkBot is best described as an addon. Its not a script neither an
application. People are used to see bots as scripts that run
alone with protections, funny stuff etc.
But that is easy to acomplish, instead of making a script we could have
done one of that mIRC bots.
But no, people don´t want to run two clients at a time in order to go
to the irc and to put their bot on the IRC at the same time.

So, we developed a socket DarkBot that runs on your own script/mIRC
independetly so you don´t have to run two clients at the same time.
As you see, this is not a script, it is a bot that uses mIRC sockets
to connect to the IRC.

All you need to do is load the bot on your usual script/mIRC and 
everytime you want to go to the IRC and launch your bot too, that
is the only client you need to open.

Being a socket bot doesn´t make it a lowsier bot. It has all possible
features of a regular DarkBot -> protections, triggers, mail/sms,
all kinds of operator commands, stats, file server, userlist etc!
As you see, we did take the time to develop a good socket work
in order to acomplish this BOT!




          ::::: b) installation :::::



Here is nothing to read for now.



          ::::: c) configuration :::::


to configure your bot use the status or main menu popups to access
the DarkBot configuration. Choose setup!

(you can optionally type /botconf)


 ::: c1) Connection

"nickname" -> your bot's nickname
example: MyBot

"irc name" -> yours bot's irc name
example: i'm a bot...

"ident" -> your bot's ident
example: bot

"server" -> the server where your bot stays in
example: irc.netplus.bg

"nickserv password" -> the password that identifies your bot's nickname
example: mypass
if the bot's nickname isn't registered just type "none" without the quotes.

"port" -> the port the bot uses to connect to the irc server , usually 6667

"smtp server" -> the smtp server the bot will use to send emails/sms messages.
example: smtp.youserver.something
p.s. if you don't want this option type "none" without the quotes.

"channels" -> the channel(s) where the bot will stay in
example: #channel1 [#channel2] [#channel3]
the second channel is optional , only one is really needed
p.s. skip the [] :)



 ::: c2) Modules


There are a few optional modules you may or may not load every time you run
your bot.

seen -> Allows the bot to keep a database of all nicks he sees on the channels.
        if this module is not loaded the !seen trigger will not work.

sendmail -> Allows the ops/admins to use the sendmail feature using the
            !mail trigger.

sms -> Allows the ops/admins to use the sms feature using the !sms
       trigger.

filesystem -> Allows users to access a specific file server. With
              this module loaded users can request a file list and
              download files from the "your-bot-directory\files\" dir.
              (fserving sessions are requested with the '!fserve'
              command)
              
remote -> This module allows all admins and the bot´s owner to execute
          remote commands like !quit and !restart. If off all these commands
          will be ignored by the bot.

stats -> The bot creates html stats of the channels you set it for!
         On this module you must specify a refresh rate for the stats
         ( which means the timer used for the bot to update the 
         channel stats ) and the directory on which the files will
         be created.



 ::: c3) Misc


There are a few misc features you can turn on/off. 

- ask chanserv for op on deOp -> also known as deop protection.

- ban protection -> when turned on the bot will check if any ban
                    set matches its address and if so, the bot will
                    unban it and deop the nick that set it.

- cloak ctcps -> When turned on the bot will ignore any ctcp request.

- on-join msg for users with on-join msg set
  -> When turned on the bot will check every join and see if the user
     that joins the channel as an on-join quote set, if so... the bot
     will send it to the chan.

- akick list -> When turned on, the bot will check every join and see
                if the user´s address matches any host on the akick 
                list, if so... it kick/bans him/her!


- Ignore Nickserv notices -> when turned on, the bot will ignore all
                             notices from NickServ. ( good for networks
                             with no services ).


- Reconnect on disconnect -> when turned on the bot will allways reconnect
                             automaticly to the server with all definitions 
                             and stats intact. When using !quit the bot 
                             WILL NOT reconnect.



 ::: c4) Users


DarkBot as 4 types of users -> admins, ops, voices and regular users.

You have a specific section of the bot configuration to add/remove
users to the bot userlist.

- Owner:
  Its you, you have access to everything and you can add admins to
  the bot´s userlist.


- Admins:

  They have almost full access to the bot, as they can use commands such
  as !restart !quit !rehash !adduser !deluser !learn !forget etc.
  So you might want to set your admins carefully. 
  ( check functions.txt to check which type of users have access to what )
  Also, when identified or matching a known host they have auto-op on every
  channel the bot is.


- Ops:

  The ops have access to a smaller group of commands.
  They can use all operator commands, ( ex: !op !deop !kick etc ) and
  !mail !sms !say etc. They can´t addusers/delusers and they can´t
  use any configuration command on the bot.
  Also, when identified or matching a known host they have auto-op on every
  channel the bot is.
  

- Voices:
  Basicly, voices can only use the on-join quote command to set an on-join
  msg for them selves and misc not-important commands.
  Also, when identified or matching a known host they have auto-voice on every
  channel the bot is.


- Users:
  The regular users can only use the "funny-commands" such as !rose !hello
  etc. They are not allowed to set on-join quotes for them selves.


- Not-listed users:
  People that aren´t listed on the bot´s userlist can only access !date
  !time !seen ?? word and use the file server if fileserver module is active.


Any op/admin or voice can only achieve auto-op or auto-voice if they
are identified on the bot or if they own a known host for their nick.
To add/del hosts users may use the !host command.

To identify on the bot users must use the !ident command:
-> id password
If they are not using the nick that is listed as user they can
identify using:
-> id password nick

To change the password the user must be identified and use:
-> !pass new-password

On adding users you or any admin must use the command:
-> !adduser nick type [password]
if no password is specified "lame" will be set as that user´s password.




 ::: c5) Protections

- Channel Flood:

  notice, text and action flood are the main channel flood protections.
  You can configure "x" lines in "x" seconds, the kick message and
  the punishment. ( kick or kick/ban )
  ctcp flood is not included as it is triggered on text flood cause
  ctcp is considered a privmsg!


- Swearing:

  You can add your own words which will be triggered on the swearing 
  protection. Also, you can specify the kick message and the punishment.


- Misc:
  
  Underline/bold and color protection can be set to avoid people from
  using this kind of codes on the channels the bot is in.

- Personal:

  These are the bot´s personal protections on which you can configure
  "x" times in "x" seconds and the ignore time that the bot will
  ignore the user if the protection is triggered.
  Also, ctcp is not included as it is triggered on text cause
  ctcp is considered a privmsg!

- Mass:

  Mass ban/deop/join and kick. You can set your own values to avoid
  people from using this commands abusivly. 



PS: admins and ops are excempt from all channel protections so they
    won´t be kicked or kicked/ban when they flood, swear or do any
    mass command.
    But, that doesn´t happen on the bot´s personal protections, so,
    if any personal protection is triggered by one admin or op, the
    BOT WILL IGNORE!    




          ::::: d) running it :::::


running the bot
to run the bot just go to the status or menubar popups and chose "run".
then when the window appears choose connect.
p.s. the bot will only run if all options in "config" are properly set.




bugs, comments ->  shake@rousse.zzn.com
ShakE Corp. ®




