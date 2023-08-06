git clone https://github.com/murmurlab/golang-httpflood ~/flo
wget https://go.dev/dl/go1.19.4.linux-amd64.tar.gz -O ~/gol
tar -xzf ~/gol
~/go/bin/go build ~/flo/httpflood.go
~/go/bin/go build ~/flo/gg.go

./httpflood
./gg
