#!/bin/sh
#
# usage: retrieve-cert.sh remote.host.name [port]
#
REMHOST="imap.gmail.com"
REMPORT=993

echo |\
openssl s_client -connect ${REMHOST}:${REMPORT} 2>&1 |\
sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' |\
openssl x509 -noout -fingerprint |\
sed 's/^SHA1 Fingerprint=//' |\
sed 's/\://g' |\
awk '{print tolower($0)}'

