package main

import (
	"bytes"
	"fmt"
	"log"
	"net/http"
	"os/exec"
)

func receiver(w http.ResponseWriter, r *http.Request) {
	if r.Method == "POST" {
		readInput(w, r)
	} else {
		//fmt.Fprint(w, "Cool web page goes here")
		http.ServeFile(w, r, "/home/paul/Documents/golang/phoneAsDesktopKeyboard/index.html")
	}
}

func readInput(w http.ResponseWriter, r *http.Request) {
	buf := new(bytes.Buffer)
	buf.ReadFrom(r.Body)
	fmt.Fprint(w, "Received & read post OK\n")
	message := buf.String()
	sendToActiveWindow(message)
}

func sendToActiveWindow(text string) {
	cmd := exec.Command("xdotool", "type", "--delay=100", text)
	err := cmd.Run()
	if err != nil {
		fmt.Println("Failed to send message to active window")
	}
}

func serve() {
	err := http.ListenAndServe(":9090", nil)
	if err != nil {
		log.Fatal("ListenAndServe failed ", err)
	} else {
		log.Println("Server up and running")
	}
}

func main() {
	http.HandleFunc("/", receiver)
	serve()
}
