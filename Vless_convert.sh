#!/bin/bash

# Просим пользователя ввести имя для конфигурации
read -p "Введите имя для 'name': " NAME

# Просим пользователя ввести VLESS ссылку
read -p "Введите VLESS ссылку: " VLESS_LINK

# Извлечение параметров из ссылки
UUID=$(echo "$VLESS_LINK" | grep -oP '(?<=vless://)[^@]+')
SERVER=$(echo "$VLESS_LINK" | grep -oP '(?<=@)[^:]+')
PORT=$(echo "$VLESS_LINK" | grep -oP '(?<=:)[0-9]+(?=\?)')
NETWORK=$(echo "$VLESS_LINK" | grep -oP '(?<=type=)[^&]+')
FLOW=$(echo "$VLESS_LINK" | grep -oP '(?<=flow=)[^&]*')
SNI=$(echo "$VLESS_LINK" | grep -oP '(?<=sni=)[^&]*')
FP=$(echo "$VLESS_LINK" | grep -oP '(?<=fp=)[^&]*')
PBK=$(echo "$VLESS_LINK" | grep -oP '(?<=pbk=)[^&]*')

# Генерация YAML без лишних выводов
cat <<EOL

Результат преобразования:
- name: "$NAME"
  type: vless
  server: $SERVER
  port: $PORT
  uuid: $UUID
  network: $NETWORK
  tls: true
  udp: true
  flow: $FLOW
  servername: www.$SNI
  reality-opts:
    public-key: $PBK
  client-fingerprint: $FP
EOL
