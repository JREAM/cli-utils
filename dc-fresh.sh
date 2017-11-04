#!/bin/bash

# Define the order to boot servers/services
DIRS=(
  server-redis
  server-nats
  server-gateway
  server-socket-gateway
  server-web
  service-accounts
  service-accounts-worker
  service-apps
  service-metrics-worker
  service-modules
  service-notes
  service-scheduler
  service-subscriptions
  service-verifications
)

for dir in "${DIRS[@]}"; do
  echo -e "------------------------------------------------"
  echo -e "Fresh: $dir"
  echo -e "------------------------------------------------"
  cd $dir && docker-compose down
  exec bash

#  docker down "${dir}/docker-compose.yml"
  #docker-compose up --force-recreate -f "${dir}/docker-compose.yml"
done
