#!/usr/bin/env bash
set -ex
apt update
chmod +x /usr/bin/installer
#### install osk
cd /tmp
apt install -f -y
apt install gir1.2-gtk-3.0 python3-pynput console-setup python3-gi python3-pip usbutils tzdata -y
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
openssl x509 -inform DER -in /usr/local/share/ca-certificates/MEB_SERTIFIKASI.cer -out /usr/local/share/ca-certificates/MEB_SERTIFIKASI.crt
update-ca-certificates -v
#### services
chmod +x /etc/rc.local
update-rc.d rc.local enable 5
#### e-tahta
chmod +x /opt/e-tahta
