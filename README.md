# phoneAsDesktopKeyboard
Enables a mobile device to act as keyboard for a linux desktop

# Only works for Linux (Ubuntu) systems

Allows you to use one device as the keyboard input for a different device. 
Originally designed so I could utilise my phones swipekey input to write into programmes on a proper desktop.

# How to
Run the binary on the desktop you wish to write to, this starts a web-server that receives on port XXXX. 

Web UI on can be accessed via your local network.

Issue http post requests via your local network and the body of the post gets written to whichever window has focus on the target desktop.

# TODO
- Run install command on server start that checks that xdotool is installed
- Ui feedback for successfull response - something fun.
- Make README better
