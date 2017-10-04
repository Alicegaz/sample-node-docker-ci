#!/bin/bash
docker build -t alicegaz/sample-node .
docker push alicegaz/sample-node

ssh -i ~/.ssh/key gazizullina143@104.198.135.103 << EOF
docker pull alicegaz/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi alicegaz/sample-node:current || true
docker tag alicegaz/sample-node:latest alicegaz/sample-node:current
docker run -d --restart always --name web -p 80:80 alicegaz/sample-node:current
EOF
