#!/bin/bash

# start rpcbind, if its not running
ps -e | grep rpcbind > /dev/null || rpcbind

# disable MIT-SHM extension
export QT_X11_NO_MITSHM=1

export LIBERO_INSTALLED_DIR=/usr/local/microsemi/Libero_SoC_v11.9/

# export LM_LICENSE_FILE=/license/License.dat
# export LM_LICENSE_FILE=1702@10.0.0.168:$LM_LICENSE_FILE
# export SNPSLMD_LICENSE_FILE=1702@10.0.0.168:$SNPSLMD_LICENSE_FILE

export PATH=$LIBERO_INSTALLED_DIR/Libero/bin:$PATH
export PATH=$LIBERO_INSTALLED_DIR/Synplify/bin:$PATH
export PATH=$LIBERO_INSTALLED_DIR/ModelSim/modeltech/linuxacoem:$PATH
export PATH=/license/Linux_Licensing_Daemon:$PATH
export MODEL_TECH=$LIBERO_INSTALLED_DIR/ModelSim/modeltech/linuxacoem/

export LD_LIBRARY_PATH=/usr/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib/i686:/usr/lib64:$LD_LIBRARY_PATH
ldconfig /usr/local/lib


# Clean license
#actel_wuclean -R

# Start Libero from home dir
cd $HOME
exec "$@"

