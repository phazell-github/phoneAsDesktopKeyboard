# phoneAsDesktopKeyboard
Enables a mobile device to act as keyboard for a linux desktop

__Only works for sending text to Linux (Ubuntu) systems__

Allows you to use one device as the keyboard input for a different device on the same local network. 
Originally designed so I could utilise my phones swipekey input to type into programmes on a proper desktop.

# How to

## 1. Start the server
Run the *launch_receiver* programme on the desktop you wish to write to, this starts a web-server that receives on port 9090.

## 2. Switch focus to target software
On the same machine switch focus to the software programme you wish to write into eg; Word, Gmail, Chrome, etc.

## 3. Send text from other devices via the UI
Web UI on can be accessed via your local network, eg:

192.168.0.XX:9090       __XX needs replacing with the actual value for the host machine.__

The correct IP address can be found using _ifconfig_ at the terminal of the host machine.

Alternatively a fallback UI is provided at 192.168.0.XX:9090/api  
You can also issue a http POST request to this URL and the body of the post gets sent to the host machine.

# TODO
- Run install command on server start that checks that xdotool is installed
- Ui feedback for successfull response - something fun.
