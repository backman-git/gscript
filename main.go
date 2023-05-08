package main

import (
	"runtime"
)

var ch = make(chan int, 10)

func main() {
	runtime.GOMAXPROCS(1)

	go f(1) // goid is 5
	go f(2) // goid is 6
	go f(3) // goid is 7

	select {}
}

func f(a int) {
	for {

	}
}
