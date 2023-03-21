#!/bin/bash
echo "update open SSL for $1"
rm -rf "/root/$1/"
mkdir "/root/$1/"
cp -f "/captain/data/letencrypt/etc/live/$1/chain.pem" "/root/$1/"
cp -f "/captain/data/letencrypt/etc/live/$1/privkey.pem" "/root/$1/"
cp -f "/captain/data/letencrypt/etc/live/$1/fullchain.pem" "/root/$1/"
cp -f "/captain/data/letencrypt/etc/live/$1/cert.pem" "/root/$1/"

