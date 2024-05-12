FROM nginx
COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY ./50x.html /etc/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]