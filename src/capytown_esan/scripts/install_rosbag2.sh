#!/usr/bin/env bash
# RC-0 Parte A, paso 6 (Anexo A): rosbag2 en el contenedor. Ejecutar como root, una vez.
set -u
apt-key del F42ED6FBAB17C654 || true   # si dice "No such key", continuar
apt-get update; apt-get install -y curl
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
  -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu jammy main" \
  > /etc/apt/sources.list.d/ros2.list
apt-get clean && apt-get update
apt-get install -y ros-humble-rosbag2 ros-humble-rosbag2-storage-mcap
ros2 bag record --list-storage         # debe listar sqlite3 y mcap
