#!/usr/bin/env bash
set -ex
apt update
chmod +x /usr/bin/installer
#### install osk
cd /tmp
apt install -f -y
apt install gir1.2-gtk-3.0 python3-pynput console-setup python3-gi python3-pip -y
git clone https://gitlab.com/sulincix/gtk-keyboard-osk.git gtk-keyboard-osk
cd gtk-keyboard-osk
make install
rm -rf /tmp/gtk-keyboard-osk
cd /tmp
fetch(){
    fname=$(wget -O - "$1"  | grep ".deb" | grep -v "~" | sort -V  | tail -n 1 | cut -f 2 -d "\"")
    wget "$1"/"$fname"
}
#### install deb files
if [[ -d /debs ]] ; then
    cd /debs
    # E-tahta
    fetch https://depo.pardus.org.tr/pardus/pool/contrib/e/e-tahta/
    fetch https://depo.pardus.org.tr/pardus/pool/main/p/pardus-pen/
    wget https://github.com/qr-greeter/qr-greeter/releases/download/current/etap-greeter_0.1.0_all.deb
    dpkg -i /debs/* || true
    apt install -f -y
    rm -rf /debs
fi
#### sh is bash
rm -f /bin/sh
ln -s bash /bin/sh
#### meb ssl
update-ca-certificates -v
#### Touchegg service
ln -s ../init.d/touchegg /etc/rc4.d/touchegg
