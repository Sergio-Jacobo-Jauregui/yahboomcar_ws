#!/usr/bin/env bash
# RC-0 Parte A, pasos 4 y 5: verifica nodos/topics y mide frecuencias.
# Uso (con el bringup corriendo, en otra terminal del contenedor):
#   export ROS_DOMAIN_ID=<n>; bash scripts/setup_check.sh
LOG="${1:-setup_log.txt}"
DUR="${HUZ_SECONDS:-10}"
{
  echo "===== setup_check $(date '+%Y-%m-%d %H:%M:%S') ====="
  echo "ROS_DOMAIN_ID=${ROS_DOMAIN_ID:-<SIN DEFINIR>}"
  echo "--- ros2 node list ---";  ros2 node list
  echo "--- ros2 topic list ---"; TOPICS=$(ros2 topic list); echo "$TOPICS"
  echo "--- topics requeridos ---"
  for t in /cmd_vel /odom /imu /scan; do
    if echo "$TOPICS" | grep -qx "$t"; then echo "OK    $t"; else echo "FALTA $t"; fi
  done
  for t in /odom /imu; do
    echo "--- ros2 topic hz $t (${DUR} s) ---"
    timeout "$DUR" ros2 topic hz "$t" 2>&1
  done
  echo
} 2>&1 | tee -a "$LOG"
echo ">> Guardado en $LOG. Falta pegar/adjuntar la captura de rqt_graph."
