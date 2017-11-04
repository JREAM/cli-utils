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
  echo -e "$dir"
  echo -e "------------------------------------------------"
  docker-compose -f "./$dir/docker-compose.yml" up --build -d
done
