# DockerMakeMeCrazy
DockerMakeMeCrazy

docker system prune -a --volumes

sudo docker rmi -f $(sudo docker images -f "dangling=true" -q)
#sudo docker rm $(sudo docker ps --filter "status=exited" -q)
#docker volume ls -qf dangling=true | xargs -r docker volume rm

du -h /var/ | sort -rh | head -5

docker system df -v

#docker image prune

# Docker stats

docker stats --no-stream --format "table {{.Name}}\t{{.Container}}\t{{.MemUsage}}" | sort -k 3 -h 

https://lp-zm.zapps.vn/?url=https://game.nasdaqiii.com

curl 'https://portal3.brandsms.vn/apis/17f5a610c6b64275886dc5f587a9c8ba' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en-GB,en;q=0.9' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'Cookie: SSID=8cf7a771191a600692de8fd0edabe243.71ef7d5f48ed4820ab9268267f21505c; UserInfo=eyJ1c2VybmFtZSI6InZ0c3MiLCJsb2dvIjpudWxsLCJpc1NhbGUiOjAsImlzQWdlbmN5IjowLCJsb2dvVGhlbSI6IiJ9' \
  -H 'Origin: https://portal3.brandsms.vn' \
  -H 'Referer: https://portal3.brandsms.vn/pages/v3/index.html' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36' \
  -H 'sec-ch-ua: "Not?A_Brand";v="8", "Chromium";v="108", "Google Chrome";v="108"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  --data-raw '{"phoneNumber":"84343902960","exportFile":[],"pageIndex":0,"pageSize":1,"currentPage":1}' \
  --compressed
