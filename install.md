dnf update -y
dnf install -y wget
cd ~
wget "http://10.0.0.168:8765/libero-installer/Libero_SoC_v11.9_Linux.bin"
wget "http://10.0.0.168:8765/fs_overlay/usr/local/bin/libero_env.sh"
chmod +x Libero_SoC_v11.9_Linux.bin
chmod +x libero_env.sh
./Libero_SoC_v11.9_Linux.bin -i silent

yum install libXft.i686 motif.i686

ln -f -s /lib/ld-linux.so.2 /lib/ld-lsb.so.3
ln -f -s /usr/lib64/libXm.so.4 /usr/lib/libXm.so.4
ln -f -s /usr/lib/libXm.so.4 /usr/lib/libXm.so.3

./libero_env.sh /usr/local/microsemi/Libero_SoC_v11.9/Libero/bin/libero
