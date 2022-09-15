#!/bin/bash

cd ../cat/
make test
cd ../grep/
make test

if [ $? -eq 0 ]
then
  exit 0
else
  curl -s -X POST https://api.telegram.org/bot5107057525:AAHlDQyN9sUAdfcp1jMoK3Dup8n-Gzuvdb4/sendMessage \
  -F chat_id='1740796963' -F text='Simple bash utils: test fail'
  exit 1
fi