package main

import (
	"bytes"
	"fmt"
	"log"
	"net/http"
	"os/exec"
)

func main() {
	http.Handle("/", http.StripPrefix("/", http.FileServer(http.Dir("FrontEnd/build/web"))))
	http.HandleFunc("/api", receiver)
	serve()
}

func serve() {
	err := http.ListenAndServe(":9090", nil)
	if err != nil {
		log.Fatal("ListenAndServe failed ", err)
	}
}

func receiver(w http.ResponseWriter, r *http.Request) {
	enableCors(&w)

	if r.Method == "POST" {
		readInput(w, r)
	} else {
		http.ServeFile(w, r, "./FrontEnd/fallback.html")
	}
}

func enableCors(w *http.ResponseWriter) {
	(*w).Header().Set("Access-Control-Allow-Origin", "*")
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
