#!/bin/bash

declare -a nodes=(glusterfs-newyork glusterfs-dallas glusterfs-toronto)
SSL_DIR=/etc

create_nodes_key() {
echo "Creating nodes key for ${nodes[@]}."
for n in ${nodes[@]}; do
  echo "Creating key for ${n} in ${PWD}/certs/${n}/glusterfs.key."
  if [ ! -d ${PWD}/certs/$n ]; then
    mkdir -p ${PWD}/certs/$n
  fi

  #generating keys
  openssl genrsa -out ${PWD}/certs/$n/glusterfs.key
  echo "Done making ${n}-glusterfs.pem file."
  openssl req -new -x509 -key ${PWD}/certs/$n/glusterfs.key -subj "/CN=${n}" -out ${PWD}/certs/$n/glusterfs.pem

  cat ${PWD}/certs/$n/glusterfs.pem >> ${PWD}/certs/glusterfs.ca
done
}

create_nodes_key

## cat into super cert file
#find . -name "*.pem" -exec cat {} + > ${PWD}/certs/glusterfs.ca
echo "DONE."

## NEED TO PUT ca file to all nodes
