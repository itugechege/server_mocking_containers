#!bin/bash

if [ -d "/home/frappe/frappe-bench/apps/frappe" ]; then
    echo "Bench already exists, skipping init"
    cd frappe-bench
    bench start
else
    echo "Creating new bench..."
fi

bench init --skip-redis-config-generation frappe-bench --version version-15

cd frappe-bench

# Use containers instead of localhost
bench set-mariadb-host mariadb
bench set-redis-cache-host redis:6379
bench set-redis-queue-host redis:6379
bench set-redis-socketio-host redis:6379

# Remove redis, watch from Procfile
sed -i '/redis/d' ./Procfile
sed -i '/watch/d' ./Procfile

bench get-app erpnext --branch develop
bench get-app print_designer --branch develop

bench new-site print-designer.localhost \
--force \
--mariadb-root-password 123 \
--admin-password admin \
--no-mariadb-socket

bench --site print-designer.localhost install-app erpnext
bench --site print-designer.localhost install-app print_designer
bench --site print-designer.localhost set-config developer_mode 1
bench --site print-designer.localhost clear-cache
bench --site print-designer.localhost set-config mute_emails 1
bench use print-designer.localhost
bench start