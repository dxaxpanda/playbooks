#!/bin/bash

declare -a nodes=(mariadb-client mariadb-server)
SSL_DIR=/etc


create_nodes_key() {
echo "Creating nodes key for ${nodes[@]}."
## signing server and client certs
  mkdir -p ${PWD}/certs/ca
  #generating keys
  openssl genrsa 2048 > ${PWD}/certs/ca/ca-key.pem
  ## set CA common name to "MariaDB admin" ##
  openssl req -new -x509 -nodes -days 730 -subj "/CN=mariadb-ca" -key ${PWD}/certs/ca/mariadb-ca-key.pem -out ${PWD}/certs/ca/mariadb-ca-cert.pem
  ## set server certificate common name to "MariaDB server" ##
for n in ${nodes[@]}; do
  echo "Creating key for ${n} in ${PWD}/certs/${n}/$n.key."
  if [ ! -d ${PWD}/certs/$n ]; then
    mkdir -p ${PWD}/certs/$n
  fi

  openssl req -newkey rsa:2048 -days 730 -nodes  -subj "/CN=${n}"  -keyout ${PWD}/certs/$n/$n-key.pem -out ${PWD}/certs/$n/$n-req.pem
  openssl rsa -in ${PWD}/certs/$n/$n-key.pem -out ${PWD}/certs/$n/$n-key.pem
  openssl x509 -req -in ${PWD}/certs/$n/$n-req.pem -days 730 -CA ${PWD}/certs/ca/mariadb-ca-cert.pem -CAkey ${PWD}/certs/ca/mariadb-ca-key.pem -set_serial 01 -out ${PWD}/certs/$n/$n-cert.pem
  done
  ## set client common name to "MariaDB client" ##
  openssl verify -CAfile ${PWD}/certs/ca/mariadb-ca-cert.pem ${PWD}/certs/mariadb-server/mariadb-server-cert.pem ${PWD}/certs/mariadb-client/mariadb-client-cert.pem
  echo "Done making ${n}.crt file."



}

create_nodes_key

mv ${PWD}/certs/ca/mariadb-ca-cert.pem ${PWD}/certs/ca/ca-cert.pem
mv ${PWD}/certs/ca/mariadb-ca-key.pem ${PWD}/certs/ca/ca-key.pem
mv ${PWD}/certs/mariadb-server/mariadb-server-cert.pem ${PWD}/certs/mariadb-server/server-cert.pem
mv ${PWD}/certs/mariadb-server/mariadb-server-key.pem ${PWD}/certs/mariadb-server/server-key.pem
mv ${PWD}/certs/mariadb-server/mariadb-server-req.pem ${PWD}/certs/mariadb-server/server-req.pem

mv ${PWD}/certs/mariadb-client/mariadb-client-cert.pem ${PWD}/certs/mariadb-client/client-cert.pem
mv ${PWD}/certs/mariadb-client/mariadb-client-key.pem ${PWD}/certs/mariadb-client/client-key.pem
mv ${PWD}/certs/mariadb-client/mariadb-client-req.pem ${PWD}/certs/mariadb-client/client-req.pem

#echo "Creating ca file."
## cat into super cert file
#find . -name "*.pem" -exec cat {} + > ${PWD}/certs/mariadb-ca.ca
 #echo "DONE."

## NEED TO PUT ca file to all nodes
