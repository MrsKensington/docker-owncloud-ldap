#!/bin/bash

rm -rf [0-9].[0-9]
git clone https://github.com/docker-library/owncloud.git

for i in `find owncloud -name "Dockerfile"`; do
	DIR=`dirname $i`
	TYPE=`basename $DIR`;
	DIR=`dirname $DIR`
	VERSION=`basename $DIR`;

	DIR="${VERSION}/${TYPE}/"
	FILE="${DIR}/Dockerfile"
	mkdir -p ${DIR}
	
	echo "FROM owncloud:${VERSION}-${TYPE}" > $FILE
	echo '' >> $FILE
	echo 'MAINTAINER docker@mikeditum.co.uk' >> $FILE
	echo '' >> $FILE
 	echo 'RUN apt-get update && \' >> $FILE
    	echo '    apt-get install -y libldap2-dev && \' >> $FILE
    	echo '    apt-get clean' >> $FILE
	echo '' >> $FILE
	echo 'RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \' >> $FILE
   	echo '    docker-php-ext-install -j$(nproc) ldap' >> $FILE
done

rm -rf owncloud
