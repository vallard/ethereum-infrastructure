#!/bin/bash
## Part 1:  Set up python
PYPY_VERSION=2.4.0
HOME=/home/core
mkdir -p $HOME
cd $HOME
block-until-url https://bitbucket.org/pypy/pypy/downloads/pypy-$PYPY_VERSION-linux64.tar.bz2
wget -O - https://bitbucket.org/pypy/pypy/downloads/pypy-$PYPY_VERSION-linux64.tar.bz2 |tar -xjf -
mv -n pypy-$PYPY_VERSION-linux64 pypy
## library fixup
mkdir -p pypy/lib
ln -snf /lib64/libncurses.so.5.9 $HOME/pypy/lib/libtinfo.so.5

mkdir -p $HOME/bin
#
cat > $HOME/bin/python <<EOF
#!/bin/bash
LD_LIBRARY_PATH=$HOME/pypy/lib:$LD_LIBRARY_PATH exec $HOME/pypy/bin/pypy "\$@"
EOF
#
chmod +x $HOME/bin/python
$HOME/bin/python --version

## part 2: insecure docker registry
mkdir -p /etc/systemd/system/
cat > /etc/systemd/system/docker.service <<EOF
[Unit]
Description=Docker Application Container Engine
Documentation=http://docs.docker.com
After=docker.socket early-docker.target network.target
Requires=docker.socket early-docker.target

[Service]
Environment=TMPDIR=/var/tmp
EnvironmentFile=-/run/flannel_docker_opts.env
MountFlags=slave
LimitNOFILE=1048576
LimitNPROC=1048576
ExecStart=/usr/lib/coreos/dockerd --daemon --host=fd:// --insecure-registry ci:5000 $DOCKER_OPTS $DOCKER_OPT_BIP $DOCKER_OPT_MTU $DOCKER_OPT_IPMASQ

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl restart docker

docker run -p 80:3000 -d --name camels ci:5000/vallard/camels:latest
