                                      __  __  __
            ___  ____ __  _ ___  ___ / /_ \ \/ /
           / _ \´ __/ _ `/ / -_)/ __/  _/  )  (
          / .__/_/  \___/ /\___/\__/\__/  /_/\_\
         /_/ -------- /__/ ---------------------
                            
                  
================================================================


-----[ Install ]------------------------------------------------

1. Unzip the pxexplorer.zip into your mIRC directory.
2. Type /load -rs pxexplorer.mrc at the mIRC command line.
3. Click 'Yes', when a dialog box popups up to ask if you want 
   to run the initialization. If you do NOT click yes, the
   script will not be loaded. We guarantee that NO original 
   ProjectX scripts will load any code that may be harmful to
   your mIRC or computer.
   
 Note: These scripts requires mIRC 5.7 and above.  To get the 
       latest version of mIRC, visit http://www.mirc.co.uk/

-----[ Description ]--------------------------------------------

PxExplorer v1.00 is a file handling addon that basically handles
a users files. With the ability to explore both your Hard Drives
(HD) and your Removable Disk drives, you can also run, delete, move,
rename and even Dcc Send files. With this addon, handling your
files makes life much simpler. :)

-----[ Manual ]-------------------------------------------------

[Main Dialog]
-1st Combo Box: The list of HD's on your computer.
-2nd Combo Box: A given list of file ext. for searching.
-1st List Box: Lists all the dirs in the selected Dir/HD.
-2nd List Box: Lists all the files in the selected Dir/HD.
-Edit Box (*.*): Type the file of your choice (*.<ext>) to
 search the current Dir/HD.
-Button "Scan": Starts the search for files in the current
 Dir/HD with the ext. given. If no ext. is given or a text that
 is no bigger than 2 characters, the search will not work.
-1st text below 1st List Box: Shows # of files in current Dir/HD
 and the total number of bytes they equal.
-2nd text below 1st List Box: Shows # of bytes free in the HD.
-Check "Auto-Refresh": When checked, will automatically refresh
 the 2nd List Box IF a dir/file is added/removed.
-1st text below 2nd List Box: Shows selected file.
-2nd text below 2nd List Box: Shows when the selected file was
 last modified.
-3rd text below 2nd List Box: Shows the size of the select file
 in either bytes, KB, MB, GB, or TB.
-Hidden Check "Replay": This check will appear if you only have
 one selected file and it's ext. is .wav or .mid. When a non
 sound file is selected, the box is removed.
-[Buttons]
 -Run: Runs the selected file (only 1 file). If you press Run
  and it does not run, then mIRC can not find a program that the
  file is used for.
 -Delete: This brings up the 2nd main dialog (see below). This
  feature can be used for one or multiple files.
 -Move: Like Delete, this brings up the 2nd main dialog (see
  below), and has supposed for one or multiple files.
 -Rename: Opens 2nd dialog and has ability to rename only one
  file.
 -Make DIR: Opens 2nd dialog and will be available if a user
  selects in the File List Box.
 -Dcc Send: Opens 2nd dialog and enables you to Dcc Send a file
  to a nick of your choice.
 -Add Shortcut: This opens the "Add Shortcut" dialog, which you
  use to add shortcuts to the shortcuts list.
 -Hidden Buttons
  -Preview: This option is enabled when you select a .bmp file.
   When the button is pressed, the dialog will close, which will
   then open up a @window showing the picture.
  -Listen: This option is enabled when you select a .wav or
   .midi file. When the button is pressed, the button is
   replaced with a "Stop" button. Pressing "Stop" stops the
   sound being played and shows the "Listen" button in its
   original place.

[2nd Main Dialog]
-Button "OK": Closes 2nd Main Dialog. If the 1st and 2nd Main
 dialog are open and the 1st is close, the 2nd will close also.
-[Delete] tab
 -This is where you can delete your file(s) or a Dir.
 -Browse: Browse for a file/dir to remove.
 -Remove: Only enabled when the text in the edit box is a true
  file/dir. If the file/dir doesn't exist, an error msg will
  appear in the edit boxes.
-[Move] tab
 -Where you can move your file/file(s).
 -File Search: Search for a file you want to move.
 -DIR Search: Will appear when a file has been selected to move.
 -Move: Will appear IF the text in the 3rd edit box is a true
  Dir. In multiple moves, if a file already exists in the
  moving Dir, then the other file will not be moved. In single
  moves, an error msg will come up in the edit boxes if it
  arleady exists.
-[Rename] tab
 -Where you rename your selected file.
 -Browse: Search for a file you want to rename.
 -Rename: Available when you have typed a name in the 3rd edit
  box. If a file of the given name already exists, an error msg
  will appear in the edit boxes.
-[Make Dir] tab
 -DIR Search: Allows you to search for a Dir where you want
  create a new Dir under it.
 -Make DIR: Available when you hvae typed a name in the 1st edit
  box. If a Dir of that name already exists, an error msg will
  appear in the edit boxes.
-[Dcc Send] tab
 -Only works when the nick you have put in the 1st edit box is
  online and if you are currently online.
 -Browse: Searches for the file you wish to send.
 -Send: Will be available if you are online and you have typed a
  nick in the 1st edit box. When you press Send, the addon will
  check if the nick is online. If he/she is, then the file will
  automatically start sending.
 -Text: Shows the size of the file you are about to send.

[Shortcuts Dialog]
-A somewhat shortcut for your favorite programs or files.
-Add: Opens a dialog so you can add a file/program to the list.
-Edit: Edits the file/program you select.
-Remove: Removes the selected file/program.
-Run: Runs the file/program. If the file/program doesn't exist,
 no error msg will be displayed.
-OK: Closes the dialog. If the Main dialog is open and is closed
 while the shortcuts dialog is open, it will also close.

-----[ ProjectX ]-----------------------------------------------

'ProjectX' is a Scripters Crew that focuses on creating scripts,
mainly mIRC and TCL scripts. We do not concentrate on creating
full scripts, but instead on creating practical scripts for the
lazy IRC-user, protection scripts for the threatened one,
warscripts for the aggressive or vengeance-seeking among us.

We are an organised group of scripters determined to help each
other create, develop, and refine scripts. We bundle our 
knowledge, so that our inexperienced scripters may benefit from
our experienced crew-members, and our experienced crew-members
benefit from the enthusiasm and fresh insights from our newer
members. We concentrate on creating good, reliable, compatible
and useful scripts for mIRC users.

You can contact ProjectX in the following ways:
- Visit our homepage..: http://www.projectx.mx.dk/
- Vist us on IRC......: #projectx (Galaxynet)
- Drop us an e-mail...: info@projectx.mx.dk


-----[ Disclaimer ]---------------------------------------------

We will under no circumstances be held responsible for any 
damage resulting from the use of this addon, whether emotional, 
physical, loss of data, health, wealth, religious beliefs,  or
whatever other type of damage. By using this script and reading
this document you agree not to hold ProjectX or the author of
this addon responsible for (including but not limited to)
abovementioned damages. If you do not agree with the above
disclaimer, you should remove this script from your computer
immediately.

Thank you for using this ProjectX addon, we've worked hard to 
make this as useful, practical and safe as we could!