#!/bin/bash

../05/main.sh $1 | goaccess -a -p goaccess.conf > report.html; firefox report.html

