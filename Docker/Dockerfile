FROM ubuntu:wily
# wily -> 15.10
# Based on https://hub.docker.com/r/ethereum/client-go/~/dockerfile/
MAINTAINER Vallard Benincosa (vallard@benincosa.com)

RUN apt-get update && apt-get upgrade -q -y
RUN apt-get install -q -y git curl software-properties-common vim
RUN add-apt-repository ppa:ethereum/ethereum 
RUN add-apt-repository ppa:ethereum/ethereum-dev 
RUN apt-get update
RUN apt-get install -q -y geth

ADD ethereum /home/ubuntu/ethereum
EXPOSE 8545
EXPOSE 30303

#CMD ["/home/ubuntu/ethereum"]
