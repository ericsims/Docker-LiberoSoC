FROM centos:7

LABEL project="LiberoSoC"
LABEL remarks="This is a dockerfile for LiberoSoC"

# change to vault
RUN yum-config-manager --disable CentOS-$releasever - Base && \
    yum-config-manager --disable CentOS-$releasever - Updates && \
    yum-config-manager --disable CentOS-$releasever - Extras
COPY CentOS-Vault.repo /etc/yum.repos.d/
RUN yum clean all && yum makecache

# Update CentOS and install packages
RUN yum update -y
# RUN yum install -y wget \
#     firefox \
#     net-tools \
#     xauth \
#     xeyes \
#     which \
#     nano \
#     motif \
#     libgcc.i686 \
#     libstdc++-devel.i686 \
#     ncurses-devel.i686 \
#     motif-devel \
#     psmisc \
#     mlocate \
#     usbutils \
#     ncurses-libs.i686 \
#     xorg-x11-server-Xvfb \
#     atk.i686 \
#     cairo.i686 \
#     glibc.i686 \
#     fontconfig.i686 \
#     freetype-2.8-12.el7_6.1.i686 \
#     ibgcc.i686 \
#     gdk-pixbuf2.i686 \
#     gtk2.i686 \
#     libICE.i686 \
#     pango.i686 \
#     libpng12.i686 \
#     libSM-1.2.2-2.el7.i686 \
#     libstdc++.i686 \
#     libX11.i686 \
#     libXau.i686 \
#     libXcursor.i686 \
#     libXdmcp.i686 \
#     libXext.i686 \
#     libXfixes.i686 \
#     libXinerama.i686 \
#     libXi.i686 \
#     libXmu.i686 \
#     libXp.i686 \
#     libXrandr.i686 \
#     libXrender.i686 \
#     libXt.i686 \
#     zlib-1.2.7-18.el7.i686 \
#     glib2.i686 \
#     ksh.x86_64 \
#     xorg-x11-fonts-75dpi \
#     xorg-x11-fonts-100dpi \
#     xorg-x11-fonts-Type1 \
#     libglib2.0-0 \
#     libsm6 \
#     libxi6 \
#     libxrender1 \
#     libxrandr2 \
#     libfreetype6 \
#     libfontconfig1 \
#     libxslt.i686 \
#     libxslt-devel \
#     pulseaudio.x86_64

RUN yum install -y wget net-tools xauth xeyes which nano motif.i686 libgcc.i686 libstdc++-devel.i686 ncurses-devel.i686 motif-devel.i686 psmisc mlocate usbutils ncurses-libs.i686 xorg-x11-server-Xvfb atk.i686 cairo.i686 glibc.i686 fontconfig.i686 freetype-2.8-12.el7_6.1.i686 ibgcc.i686 gdk-pixbuf2.i686 gtk2.i686 libICE.i686 pango.i686 libpng12.i686 libSM-1.2.2-2.el7.i686 libstdc++.i686 libX11.i686 libXau.i686 libXcursor.i686 libXdmcp.i686 libXext.i686 libXfixes.i686 libXinerama.i686 libXi.i686 libXmu.i686 libXp.i686 libXrandr.i686 libXrender.i686 libXt.i686 glib2.i686 ksh.x86_64 xorg-x11-fonts-75dpi xorg-x11-fonts-100dpi xorg-x11-fonts-Type1 libglib2.0-0 libsm6 libxi6 libxrender1 libxrandr2 libfreetype6 libfontconfig1 libxslt.i686 libxslt-devel pulseaudio.x86_64
RUN yum install -y zlib-1.2.7-18.el7.i686

# For mlocate
RUN updatedb

# # Install Libero 12.4
RUN cd /tmp && wget --progress=bar:force:noscroll "http://127.0.0.1:8765/Libero_SoC_v11.9_Linux.bin" && \
    chmod +x Libero_SoC_v11.9_Linux.bin && \
    TERM=xterm ./Libero_SoC_v11.9_Linux.bin -i silent && \
    rm -f Libero_SoC_v11.9_Linux.bin

RUN cd /usr/local/microsemi/Libero_SoC_v11.9/Libero && \
    wget --progress=bar:force:noscroll "http://127.0.0.1:8765/Libero_SoC_v11_9_SP6_Lin.tar.gz" && \
    tar -xf Libero_SoC_v11_9_SP6_Lin.tar.gz && \
    rm -f Libero_SoC_v11_9_SP6_Lin.tar.gz && \
    rm -f License.txt && \
    yes | ./wsupdate.sh

# # Install paticular version of freetype, for ModelSim 10.x
# RUN yum-builddep -y freetype
# RUN yum install -y gcc make libtool glibc-devel.i686 libstdc++-devel.i686 glibc-headers.i686 gcc-c++ glibc-devel
# RUN cd /tmp && wget --progress=bar:force:noscroll "http://127.0.0.1:8765/freetype-2.4.12.tar.gz" && \
#     tar -xf freetype-2.4.12.tar.gz && cd freetype-2.4.12 && \
#     ./configure --build=i686-pc-linux-gnu "CFLAGS=-m32" "CXXFLAGS=-m32" "LDFLAGS=-m32" && make && make install

# # Install python PIP for vUnit etc.
# RUN yum install -y epel-release
# RUN yum install -y python-pip
# RUN pip install --upgrade pip
# RUN pip install vunit_hdl


# # Add udev rules for FlashPro hardware
# # FIXME: "locate: can not stat () `/var/lib/mlocate/mlocate.db': No such file or directory"
# # use fs_overlay for now.
# #RUN cd /usr/local/microsemi/Libero_SoC_v11.9/Libero/bin/ && bash ./udev_install

# # FIXME It would be nice to do this dynamically at runtime. If you don't add the user to the contailer, you get "invalid" user when starting the container.
RUN useradd -u 287294 skeys

RUN yum install -y motif motif-devel unzip portmap openssh openssh-server openssh-client firefox

# # Fix misc ELF errors, by adding symlinks.
RUN ln -f -s /lib/ld-linux.so.2 /lib/ld-lsb.so.3
# RUN ln -f -s /usr/lib64/libXm.so.4 /usr/lib/libXm.so.4
RUN ln -f -s /usr/lib/libXm.so.4 /usr/lib/libXm.so.3

# # Add overlay files to local fs (copied as context, but not mounted anywhere)
COPY fs_overlay /

# #Fix: "su <username>" failed to execute /bin/bash: Permission denied
RUN chmod 755 /usr
RUN chmod 755 /
RUN chmod 755 /usr/local/bin
RUN chmod 755 /usr/local/bin/libero_env.sh

RUN echo "root:redhatredhat" | chpasswd 
RUN echo "skeys:redhatredhat" | chpasswd 
RUN ssh-keygen -A

EXPOSE 22

