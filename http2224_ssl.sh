#!/bin/bash
# mysql innodb install scripts
# Author:wdlinux
# Url http://www.wdlinux.cn

if [ ! -f /usr/bin/gcc ];then
        yum install -y gcc gcc-c++ make autoconf libtool-ltdl-devel gd-devel freetype-devel libxml2-devel libjpeg-devel libpng-devel openssl-devel curl-devel patch libmcrypt-devel libmhash-devel ncurses-devel sudo bzip2
fi

if [ -d /root/lanmp/httpd-2.2.24 ];then
	cd /root/lanmp/httpd-2.2.24
	make clean
elif [ -f /root/lanmp/httpd-2.2.24.tar.gz ];then
	cd /root/lanmp
	tar zxvf httpd-2.2.24.tar.gz
	cd httpd-2.2.24
else
	cd /tmp
	wget -c http://dl.wdlinux.cn:5180/soft/httpd-2.2.24.tar.gz
	tar zxvf httpd-2.2.24.tar.gz
	cd httpd-2.2.24
fi
IN_DIR="/www/wdlinux"
./configure --prefix=$IN_DIR/httpd-2.2.24 --enable-rewrite --enable-deflate --disable-userdir --enable-so --enable-expires --enable-headers --with-included-apr --with-apr=/usr --with-apr-util=/usr --enable-ssl --with-ssl=/usr
[ $? != 0 ] && exit
make
[ $? != 0 ] && exit
service httpd stop
make install
[ $? != 0 ] && exit
service httpd start
echo 
echo "httpd ssl install is OK"
echo
