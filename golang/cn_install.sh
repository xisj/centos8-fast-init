tar -C /usr/local -xzf go1.14.2.linux-amd64.tar.gz

echo '
#GO111MODULE=on
# Set the GOPROXY environment variable
GOPROXY=https://goproxy.io
PATH=$PATH:/usr/local/go/bin' > ~/.bashrc  
source ~/.bashrc  


