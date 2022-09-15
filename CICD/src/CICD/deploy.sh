#!/bin/bash

### Move to artifacts dir
cd /home/gitlab-runner/builds/gMgXjUVp/0/students/DO6_CICD.ID_356283/cangelen_student.21_school.ru/

### Create archive
sudo tar -cf artifacts.tar DO6_CICD-0

### Copy archive via scp to non root dir
scp artifacts.tar cangelen@10.54.201.189:/home/cangelen/

### Remove archive
sudo rm artifacts.tar

### Connect to second machine via ssh, move, extract and remove tar
ssh cangelen@10.54.201.189 "sudo mv /home/cangelen/artifacts.tar /usr/local/bin/; sudo tar -xvf /usr/local/bin/artifacts.tar; sudo rm /usr/local/bin/artifacts.tar"

if [ $? -eq 0 ]
then
  curl -s -X POST https://api.telegram.org/bot5107057525:AAHlDQyN9sUAdfcp1jMoK3Dup8n-Gzuvdb4/sendMessage \
  -F chat_id='1740796963' -F text='Simple bash utils: all stages passed successfully'
  exit 0
else
  curl -s -X POST https://api.telegram.org/bot5107057525:AAHlDQyN9sUAdfcp1jMoK3Dup8n-Gzuvdb4/sendMessage \
  -F chat_id='1740796963' -F text='Simple bash utils: deploy fail'
  exit 1
fi