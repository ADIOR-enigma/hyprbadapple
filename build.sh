#!/bin/sh
set -e

echo "Generating wayland protocols..."
wayland-scanner private-code < /usr/share/wayland-protocols/stable/xdg-shell/xdg-shell.xml > xdg-shell-protocol.c
wayland-scanner client-header < /usr/share/wayland-protocols/stable/xdg-shell/xdg-shell.xml > xdg-shell-client-protocol.h

echo "Compiling box..."
gcc -o box box.c xdg-shell-protocol.c -lwayland-client

echo "Compiling meti.so..."
# Use luajit or lua pkg-config depending on your system
gcc -shared -fPIC -o meti.so meti.c $(pkg-config --cflags luajit || pkg-config --cflags lua5.1 || pkg-config --cflags lua)

echo "Build complete."
