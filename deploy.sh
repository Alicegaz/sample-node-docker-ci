#!/bin/bash
sudo docker push alicegaz/sample-node

ssh gazizullina143@104.198.135.103 << EOF
sudo docker pull alicegaz/sample-node:latest
sudo docker stop web || true
sudo docker rm web || true
sudo docker rmi alicegaz/sample-node:current || true
sudo docker tag alicegaz/sample-node:latest alicegaz/sample-node:current
sudo docker run -d --restart always --name web -p 80:80 alicegaz/sample-node:current
EOF
