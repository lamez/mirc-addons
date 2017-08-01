
********************************************* TECHNIQUE ***********************************************

THE ORIGINAL TECHNIQUE LAG BAR

June 6 2002
technique lag bar v.09 by ex|l- (Ryan)  
Contact Email: linxsrc@berlin.com Website: http://techniquescript.cjb.net 
IRC /server irc.irc-style.com 6667 #TheLounge
Addon for my friends and those needing a sweet lag bar with many configurations through right click popup
Uses tbwin.dll by dohcan :)

THIS LAG BAR DOES WORK IN MIRC 5.91 6.0 AND 6.01

I WILL BE RECODING THIS ADDON FOR V1.0 AND IT WILL NO LONGER BE A .INI FILE AND WILL
HAVE MANY MORE OPTIONS FOR CONFIG FREAKS.

******************************************* INSTALL **************************************************

The 3 files that comes with this can be placed anywhere in your mirc folder or another folder, and it 
will work,but I recommend leaving them in the lagbar folder if you ended up with one! Just remember to 
have the tbwin.dll in your mirc folder or same path as the lagbar.ini script is in, and it all should 
work now!

Just load the lagbar.ini file into remotes using 1 of these commands: 
//load -rs $findfile($mircdir,lagbar.ini,1)
/load -rs lagbar\lagbar.ini  
/load -rs pathto\lagbar.ini

After you load it, accept the initialization then it will ask you to pick a lag method!
This is the way the script checks your actual lag, I made it work in
3 optional ways just in case one conflicts with something in your script you 
could try the other!

******************************************** TIPS ****************************************************

BLENDING:

If your using a graphic in your mirc switchbar/toolbar like a black, red or some picture you can now
adjust the lag bars colors using the popop and going to color and pick the text border and background
colors. Get crazy with your colors press text,border or background and type some random number like 
231235. Use a rgb color chart or something to figure out the colors, like in mspaint /run mspaint
if your using black enter 1 as 0 doesnt work for background. If you totally screw up the way the colors
look just click on "color" then "default values" to reset the lag bar colors.

SCHEMES:

I didnt really intend on making this like a scheme system, but you can use this handy alias
/lag.scheme to see all your current lag bar colors/values. If you come across one thats neat
you can pass along or save it and some other user can type:

/lag.deploy 1 2 3 4

1=text color
2=border color
3=lag color
4=face/background color

The parameters must be in that order and you dont have to use all parameters at once, but remember
that they will always be 1=text 2=border 3=color 4=face .

IGNORES:

IMPORTANT note if you ignore notices or ctcps from yourself or ignore them completely ------- IMPORTANT
this wont work, depends on the method! Remove the notice or ctcp ignore and lagbar should start working!
Ignoring other users wont effect lag bar only on yourself or total ignore!
I recommend using the raw method if you have probs with the ctcp or notice methods!

BLAH:

Leave all this code in the same file!!!!!
The lagbar.ini holds settings in it so I recommend you leave it as lagbar.ini and as 1 file!
Stop ripping this addon I get many emails about rips all the time, your busted I know who you are!

****************************** IMPORTANT NOTE MIRC 6.0 AND ABOVE ONLY!! ******************************

This lag bar now automatically changes the lag check for the active screen network\server cid your on if
your connected to multiple servers using mIRC 6.0's new multiserver capability!
The new id numbers in mIRC 6.0 are super usefull I especially like $timer(timer.name).cid 
very usefull for returning info on timers!

Example explantation using multiserver on these 2 servers:
Server 1 DALnet #mirc #techniquescript
Server 2 Undernet #mirc #lamers

Lets say your on a Dalnet #mirc channel and you decide to check out whats going on in Undernet on #lamers, 
When you change screens you will trigger the on *:active event and the lag checker will then check 
if the active screen network\server cid is what the lag checker is checking, and if its not it changes to 
that network\server cid. So when you see the lag bar with your lag it should be the lag 
from the network\server screen you actively looking at! This uses the on ACTIVE event and some new 
identifiers in mIRC 6.0 to do this. Hopefully this works good for everyone! :P

*************************************** THIS LAG BARS FUNCTIONS **************************************

Lag bar graphic fills at 10 seconds lag and no more, only the text numeric will change after 10 seconds!
Lag bar switchs server when you change screens to different server.
Can blend the colors in the lagbar to you mirc toolbar using popup.

Just to check I tested this on a plain mirc with mts and didnt seem to have any probs. (kte)
But you may have to modify some things in other mts engines from what I understand!
This is the reason there are 3 methods. Adjust your scripts to return on ctcp lag or notice lag if
you have problems, or try raw method! Or try adding this in your on notice or on ping events in your 
script not this addons if your getting a message of your lag: if ($nick == $me) && ($1 == Lag) { return }

Some usefull commands:

/lag.start (starts lagbar)
/lag.stop (stops lagbar)
/lag.stime (Sets lag check delay, try to keep this above 10 seconds.)
/lag.scheme (Shows all 4 of your current color setting in this order face,text,border,lag)
/lag.deploy 1 2 3 4 (Use to set lag bar a certain way, like a scheme in that order)

Order of /lag.deploy params:

1=text color
2=border color
3=lag color
4=face/background color

If you decide you dont like this or you just unload it, it will leave no mess behind!
Uses no %variable storage space! (hash table (txlag) and lagbar.ini are the storage) :)

****************************************** Updates and info ******************************************


Fixes,additions and misc. v.09 June 6 2002

Fixed the halt bug in the raw method, this would halt all unknown errors in your mirc oops.
Added oval to the styles in the popup for oval look for lagbar.
Tweaked the lag fill animation thingy.

Fixes,additions and misc. v.08 April 29 2002

Added small and classic visual style select.
Added text,border and face custom color select so if you wanna do something
crazy with colors and stuff or if you use graphics in your mirc switchbar
you can blend the lagbar instead of looking all odd.
Adjusted lag ignore check to be more specific, it now wont turn off lagbar if you ignore ctcps, but 
using notice method etc.
Recoded the lag bar to except more styles in future versions.
Added /lag.scheme (Shows all 4 of your current lag bar scheme colors)
Added /lag.deploy (sets custom colors for the lag bar for scriptors, or you can exchange the params
to other people using this lag bar so they can use same colors as you)

Fixes,additions and misc. v.07 February 12 2002

Added more mIRC 6.0 support!

Adjusted on *:connect event to check if lag bar already on and if your mirc version 6.0 or above
it will now only open once not eveytime you connect to multi servers in mirc 6.0.
mIRC 5.91 will just start on connect!

Adjusted on *:disconnect event to leave lag bar running in mirc 6.0 if your still connected to
some other server with multi server, will only close if your not connected to any server on any window.
mIRC 5.91 will just close on disconnect!

Added -i switch into lag.chk timers
Added on *:active event for mIRC 6.0 lag checking network auto switching!
Added Network to right click popup to show you what network the lag checker is checking on! 
Click it to see info as well!
Deleted the update popup as this confused many users and was a debugging feature for myself!
Adjusted Lag: text
Added info echo when you close lagbar to show it stopped and how to turn back on! 

Fixes,additions and misc. v.06 February 4 2002

Added new tbwin.dll v0.3 by dohcan (dohcan@mircscripts.org)
Added mIRC 6.0 support
Fixed on *:load error in syntax.
Resized window a little to fit properly in 6.0 looks great in 5.91 too!

Fixes,additions and misc. v.05 January 25 2002

Added $scriptdir to alias routine (for all you who dont use mircdir)
Deleted .00ms

Fixes,additions and misc. v.04 January 24 2002 

Fixed rgb problem wasnt using -r switch
Added lag.method lag.custom lag.stime 
Added raw lag check method uses raw 421 unknown error!
Added a lag bar scroll color fill for startup and color change, just for looks :P
Added a ignore checker to check if notices or ctcps are ignored that could affect lag functions!
Made the code more uniformed, and better suited for my needs!
Added 5 preset colors for lagbar in popup.
Fixed drawtext to proportion itself according to width of text on the left of lagbar -
so it wont overlap. (Is reason alot of people put text under a skinny lagbar, mine auto sets position on left.)
Improved look, made lagbar size bigger, and drawtext bold.
Added more error checking, so hopefully you dont see any mirc error's only mine with more info if any!

v.03 First public release and buggy! 

Versions v.02 and below weren't public as I was learning how to make pic wins!

************************************** ADDING THIS TO YOUR SCRIPT *************************************

Feel free to use this in your script,but please do not take 
my name out of this addon. Email @ linxsrc@berlin.com if you got some questions. 

If you have custom colors in your script and want the lag bar to be set a certain way in your script
when the user first uses it use /lag.deploy 1 2 3 4 in your scripts in some event.

Parameters must be in this order as follows, and you dont have to use all 4:

1=text color
2=border color
3=lag color
4=face/background color

If your wanting to add this as a module add my info to whatever structure you use.

addon=technique lag bar v.09
author=ex|l- (Ryan)
irc=Undernet #mirc or /server irc.irc-style.com 6667 #TheLounge
email=linxsrc@berlin.com
website=http://techniquescript.cjb.net
description=A lag checking addon that uses a picture window graphic that is placed in your mirc 
toolbar with many configurations through right click popup. For mIRC 5.91 6.0 6.01 and above.


*******************************************************************************************************

EOF