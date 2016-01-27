# Proxy settings

## Download this Repo
HTTPS_PROXY=proxy.esl.cisco.com:80 git clone https://github.com/vallard/ethereum-infrastructure.git

## Modify Docker Server

```
sudo mkdir /etc/systemd/system/docker.service.d
sudo vim /etc/systemd/system/docker.service.d/http-proxy.conf
```

Next make this file appear as follows: 
```
[Service]
Environment="HTTP_PROXY=http://proxy.esl.cisco.com:80"
```
Then restart docker
```
sudo systemctl daemon-reload
sudo systemctl restart docker
```

## NTP

Edit: 
```
vim /etc/systemd/network/50-dhcp-no-ntp.conf
```
And make it look like: 
```
[Network]
DHCP=v4
NTP=ntp.esl.cisco.com

[DHCP]
UseMTU=true
UseDomains=true
UseNTP=false
```

Then restart
```
sudo systemctl restart systemd-networkd
```

