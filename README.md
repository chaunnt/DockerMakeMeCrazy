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

#link redirect
https://lp-zm.zapps.vn/?url=https://game.nasdaqiii.com
https://www.google.com/url?q=https://hdcredit.vaytiennhanh24h-inc.com/HDCredit_x32_v1.2.1.3.apk&sa=D&source=editors&ust=1694155802533401&usg=AOvVaw3Mhbgj0tt4-nou2oqo2Jum
https://lp-zm.zapps.vn/?url=https://hdcredit.vaytiennhanh24h-inc.com/HDCredit_x32_v1.2.1.3.apk

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

pm2 start --no-autorestart --cron "10 * * * *" /root/auto_backup_alldatabase.sh

https://www.google.com/url?sa=i&url=https%3A%2F%2Fc2nguyendinhchieu.vinhlong.edu.vn%2Fdanh-muc-tin%2Fthong-bao%2Fdanh-sach-gvcn-nam-hoc-2021-2022.html&psig=AOvVaw3eq6kS7bw-KtDbfa_2unBO&ust=1689563568928000&source=images&cd=vfe&opi=89978449&ved=2ahUKEwjhp4r0oJKAAxVck1YBHQjhBpAQr4kDegQIARB0