# TODO заменить конфиг /etc/nginx/conf.d/default.conf и добавить 50x.html в соответствии с этим конфигом
FROM nginx:latest
COPY default.conf /etc/nginx/conf.d/default.conf
COPY 50x.html /usr/share/nginx/html/
ENTRYPOINT ["nginx", "-g", "daemon off;"]
#В последней строке указывается точка входа образа для команды: nginx -g daemon off;.
#Это гарантирует, что Nginx останется «на переднем плане», так что Docker сможет правильно отслеживать процесс
#(в противном случае контейнер остановится сразу после запуска).