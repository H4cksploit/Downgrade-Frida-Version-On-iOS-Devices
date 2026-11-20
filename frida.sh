#!/bin/bash
FRIDA_VER=$1
# contains plist
cd /Library/LaunchDaemons/
# move plist to root
mv re.frida.server.plist ~
cd ~
# unload service
launchctl unload re.frida.server.plist
# stash plist
mv re.frida.server.plist /Library/LaunchDaemons
mv /Library/LaunchDaemons/re.frida.server.plist /Library/LaunchDaemons/re.frida.server.backup
# fetch FRIDA
wget -O /tmp/frida_${FRIDA_VER}_iphoneos-arm.deb https://github.com/frida/frida/releases/download/${FRIDA_VER}/frida_${FRIDA_VER}_iphoneos-arm.deb
# update server, agent and plist
dpkg -i /tmp/frida_${FRIDA_VER}_iphoneos-arm.deb
# restore plist
mv /Library/LaunchDaemons/re.frida.server.backup /Library/LaunchDaemons/re.frida.server.plist
# launch service using new plist
launchctl load /Library/LaunchDaemons/re.frida.server.plist
# delete package
rm /tmp/frida_${FRIDA_VER}_iphoneos-arm.deb
