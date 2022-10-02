#!/bin/bash

cd ./nodejs-puppeteer-test && npm install

URL=$(kubectl get ingress -n 2048-game | tail -1 | awk '{print $4}')
export BASE_URL=$URL

echo "BASE_URL: $BASE_URL"
node check-2048.js
