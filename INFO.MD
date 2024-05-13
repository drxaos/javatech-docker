# Изучите docker-compose.yml. Что делает каждая из директив?

### version - отвечает за версию формата/синтаксиса docker-compose
### services - содержит сервисы, которые будут запущены в docker-compose
### volumes - определяет томы. которые могут быть использованы в сервисах
### container_name - назначает имя контейнеру
### build - блок, описывающий параметры сборки Docker-образа
### environment - указывает переменные окружения для контейнера
### ports - отвечает за связи между портами хоста и контейнера
### image - указаывает образ для сборки контейнера

# Чем отличаются 3 варианта использования volumes?
### 1. Именованные томы
```json
volumes:
  postgres-data-volume:
    driver: local
volumes:
- postgres-data-volume:/var/lib/postgresql/data
```
В этом случае создается именованный том postgres-data-volume, который будет использоваться для хранения данных PostgreSQL. Этот том будет находиться на хостовой машине

### 2. Привязанное монтирование/Монтирование в контейнер
```json
volumes:
- ./nginx-data/upstreams.conf:/etc/nginx/conf.d/upstreams.conf
```
Этот тип томов позволяет монтировать путь из хост-файловой системы в контейнер.
### 3. TMPFS
Этот тип томов представляет собой хранение данных в оперативной памяти (RAM). Они полезны, когда вам нужно быстро и временно сохранить данные в контейнере, которые не требуют постоянного сохранения. При удалении контейнера данные, хранящиеся в TMPFS томах, уничтожаются.

# Изучите Dockerfile в каждом из сервисов. Что делает каждая из директив?

### ARG - задает переменную окружения, которая будет только доступа на этапе сбокри образа
### COPY - копирует файлы или каталоги с хоста в образ
### EXPOSE - информативно указывает, какой порт будет открыт в контейнера
### WORKDIR - указывает рабочую директорию 
### FROM - указывает базовый образ
### CMD - определяет команду, которая будет запускаться при запуске контейнера, и также будет являться главной
### RUN - указывает команду, которая будет выполняться во время сборки образа

# Что означает повторение директивы FROM?
### Если несколько раз происан FROM, то сборка будет осуществляться в несколько этапов, где следующий этап будет использовать образ прошлого этапа

# Чем RUN отличается от CMD?
### RUN - выполняется во время сборки образа. CMD - выполняется во запуска контейнера

# За что отвечает каждый из параметров команды docker-compose?
### up - запуск всех сервисов
### down - выключение всех сервисов
### -d - запуск в фоновом режиме

# Запустите контейнеры и выведите на экран их логи
![photo](https://github.com/tclutin/javatech-docker/blob/master/images/1.jpg)

# Напишите Dockerfile для сервиса nginx. Добавьте сервис в docker-compose.yml
dockerfile
```json
FROM nginx
COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY ./50x.html /etc/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
```

docker-compose
```json
services:
  nginx:
    container_name: nginx.service
    build:
      context: ./nginx
    ports:
      - 22000:80
    volumes:
      - ./nginx-data/upstreams.conf:/etc/nginx/conf.d/upstreams.conf
```
# Настроить backend2, настроить upstream
docker-compose
```json
  backend2:
    container_name: backend2.service
    build:
      context: backend
    ports:
      - "22004:7000"
    volumes:
      - ./backend2-data/application.properties:/app/application.properties
```

upstream
```json
upstream backend {
  server backend1.service:7000;
  server backend2.service:7000;
}

upstream frontend {
  server frontend.service:3000;
}
```
![photo](https://github.com/tclutin/javatech-docker/blob/master/images/2.jpg)


Все работает!