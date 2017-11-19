#!/bin/bash

# Boot
# Place this file next to all the subfolders.
#
# @important: This will boot in the order specified,
#   1: Servers first, ea.Server in that Order
#   2: Services Second, ea.Service in that Order
# -------------------------------------------------------------------

# Bnotes Variables
SERVERS=(
  server-gateway
  server-nats
  server-redis
  server-socket-gateway
  server-web
)
SERVICES=(
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
FRONTEND=(
  client-web
)

# Comnand List
#
# -------------------------------------------------------------------
banner() {
  echo -e "\n\
     ================================================================\n\
    |                  Docker-Compose Boot Manager                   |\n\
    |                    (c)2017 Jesse Boyer [MIT]                   |\n\
    |================================================================|\n\
    |                                                                |\n\
    | @Description: Run the same command for every comose file       |\n\
    |               belonging in every parent folder.                |\n\
    |                                                                |\n\
     ================================================================\n\
  "
}

cmd_list() {
  echo -e "\
    \n\
    Command; Shortcut; Description;\n\
    -------; --------; ------------;\n\
     help; h; Simple Instructions and Using this script\n\
     fresh; f; Runs <down> <build> <up> to start fresh\n\
     upbuild; ub; Runs docker up with build flag (daemon)\n\
    ;;\n\
     build; b; Build or rebuild services\n\
     down; d; Stop and remove containers, networks, images, and volumes\n\
     images; i; List images\n\
     kill; k; Kill containers\n\
     log; l; View output from containers\n\
     pause; p; Pause services\n\
     port; ; Print the public port for a port binding\n\
     ps; ; List containers\n\
     restart; ; Restart services\n\
     rm; ; Remove stopped containers\n\
     run; ; Run a one-off command\n\
     start; ; Start services\n\
     stop; ; Stop services\n\
     top; t; Display the running processes\n\
     unpause; -p; Unpause services\n\
     up; ; Create and start containers\n\
  " | column -t -s ';'
  echo -e "\n\n\
    [Remember] This runs on ALL compose files one path up!\n\
               All containers are run with -d, Daemon mode\n\
    ----------------------------------------------------------------\n\
    \n\
  ";
}

help() {
  echo -e "\n\
     ================================================================\n\
    |                                                                |\n\
    | @Help: Placed beside all of your folder, or micro-services.    |\n\
    | -------------------------------------------------------------- |\n\
    |                                                                |\n\
    | Passing Arguments:                                             |\n\
    |        $ ./boot.sh logs -f                                     |\n\
    |                                                                |\n\
    | Removing Containers & Rebuilding One Call                      |\n\
    |        $ ./boot.sh fresh                                       |\n\
    |                                                                |\n\
     ================================================================\n\
    "
}

# Display banner
#
# -------------------------------------------------------------------
banner

#
# Display CMD List if nothing passed
# -------------------------------------------------------------------
cmd=$1
if [ -z $cmd ]; then
  cmd_list
  exit 1
fi

# -------------------------------------------------------------------
# Handle a Command
# -------------------------------------------------------------------

DIR=$PWD    # Prepare the CWD from wherever the user is
CMD=false   # Current CMD Running

case $cmd in
  'help')
    help
    ;;
  'fresh'|'f')
    CMD='docker-compose down && docker-compose up --build -d'
    ;;
  'upbuild'|'ub')
    CMD='docker-compose up --build -d'
    ;;
  'build'|'b')
    CMD='docker-compose build'
    ;;
  'down'|'d')
    CMD='docker-compose down'
    ;;
  'images'|'i')
    CMD='docker-compose images'
    ;;
  'kill'|'k')
    CMD='docker-compose kill'
    ;;
  'log'|'logs'|'l')
    CMD='docker-compose logs'
    ;;
  'pause'|'p')
    CMD='docker-compose pause'
    ;;
  'port'|'ports')
    CMD='docker-compose ports'
    ;;
  'ps')
    CMD='docker-compose ps'
    ;;
  'restart')
    CMD='docker-compose restart'
    ;;
  'rm'|'remove')
    CMD='docker-compose remove'
    ;;
  'run')
    CMD='docker-compose run'
    ;;
  'start')
    CMD='docker-compose start'
    ;;
  'stop')
    CMD='docker-compose stop'
    ;;
  'top'|'t')
    CMD='docker-compose pause'
    ;;
  'unpause'|'-p')
    CMD='docker-compose unpause'
    ;;
  'up'|'u')
    CMD='docker-compose up -d'
    ;;
  *)
    CMD=false
    echo -e "Error: Command ${1} does not exist, try ./boot help\n"
    ;;
esac

#
# End with no CMD Provided
# -------------------------------------------------------------------
if [ ! $CMD ]; then
  exit 1
exit

#
# 1: Loop SERVERS first
# 2: Loop SERVICES second
# -------------------------------------------------------------------

loop_servers $CMD
# loop_services $CMD

#
# Functions
# -------------------------------------------------------------------
function loop_servers {
  for dir in "${SERVERS[@]}"; do
    echo $dir
  fi
}
# loop_servers {
#   for dir in "${SERVERS[@]}"; do
#     echo $dir
#     (cd $dir && $*)
#   done
# }

loop_services {
  for dir in "${SERVICES[@]}"; do
    echo $dir
  done
}
