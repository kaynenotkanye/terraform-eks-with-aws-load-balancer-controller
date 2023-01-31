#!/bin/bash

# Added some sleep because the app and load balancers take some time to initialize
sleep 60
cd ./nodejs-puppeteer-test && npm install

URL=$(kubectl get ingress -n 2048 | tail -1 | awk '{print $4}')
export BASE_URL=$URL

echo "BASE_URL: $BASE_URL"
# add curl test
curl http://$BASE_URL

function run_test {
  sleep 60
  echo "Running Puppeteer Test..."
  node check-2048.js
  if [ $? -eq 0 ]; then
    exit $?
  fi
}

do=true
while $do; do
  run_test
done