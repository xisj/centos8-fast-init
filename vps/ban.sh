#!/bin/bash
#第一次运行创建记录文件
-f 1.txt || touch 1.txt
while :
do
#查看日志中登陆失败的ip次数超过10次的用户ip
fip=`awk '/Failed/{ip[$11]++;}END{for (i in ip){if (ip[i]>10){print i}}}' /var/log/secure`
#循环取出登陆失败超过十次的ip进行处理
for i in $fip
do
#查看处理记录文件如果该ip没有存在处理记录中说明是没有处理过该ip
a=`awk -F: -v i=$i '$2==i{print}' 1.txt | wc -l`
#如果有查到结果则说明已经处理过该ip
if [ "$a" -ne 0 ]
then
echo "服务器安全"
else
#将新的***ip加入防火墙阻止(方入drop的区域则该ip发送的数据包会立刻丢弃不做回应)区域
firewall-cmd --zone=drop --add-source=$i && echo "成功将:$i:加入防火墙block区域" >> 1.txt
fi
done
#120s执行一次
sleep 120
done
