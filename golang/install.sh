wget https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.14.2.linux-amd64.tar.gz

echo '
PATH=$PATH:/usr/local/go/bin' > ~/.bashrc  
source ~/.bashrc  
