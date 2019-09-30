#!/bin/sh

docker ps | grep lxrng
if [ $? = 1 ]; then
	exit 1
fi

docker exec -u lxrng lxrng ./refresh_git &&
docker exec -u lxrng lxrng ./update_lxr &&
echo success!
