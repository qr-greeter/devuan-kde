#!/usr/bin/env bash
set -ex
apt update
chmod +x /usr/bin/installer
#### install osk
cd /tmp
apt install -f -y
apt install gir1.2-gtk-3.0 python3-pynput console-setup -y
git clone https://gitlab.com/sulincix/gtk-keyboard-osk.git gtk-keyboard-osk
cd gtk-keyboard-osk
make install
rm -rf /tmp/gtk-keyboard-osk
cd /tmp
#### install deb files
if [[ -d /debs ]] ; then
    #wget -O /debs/wps.deb https://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/10976/wps-office_11.1.0.10976.XA_amd64.deb
    dpkg -i /debs/* || true
    apt install -f -y
    rm -rf /debs
fi
