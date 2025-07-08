# LiberoSoC-Docker
Docker image for running LiberoSoC

## Required Libero install files
Under libero-installer, you should have the following files:

```shell
ls -l libero-installer/
-rwxr-xr-x 1 eric eric 3181186330 Jun 26 13:35 Libero_SoC_v11.9_Linux.bin
-rw-r--r-- 1 eric eric 1046755557 Jun 26 13:33 Libero_SoC_v11_9_SP6_Lin.tar.gz
```

## License server
The Synopsis licence binary('snpslmd') complains about not being able to aquire a lock file, so we have to run 'lmgrd' on the host for now.

###
Request a network license from Microsemi and place it under the 'license' directory.
[Microsemi License Portal] (https://www.microsemi.com/product-directory/design-resources/1711-licensing)

## Build the Docker image
Once you have the required files in place, build the image with the 'build.sh' script. On a high-end machine, it will take at least 10 minutes.

```shell
./build
```

## windows
If you are accessing this container from windows, install xming, and xming-fonts

## Running Libero
There are a couple ways you can run Libero.

###
```shell
docker compose run --rm libero /usr/local/bin/libero_env.sh libero
```


## without compose

#Note
On some systems you may need to ensure that the time is synced between the host and the container, otherwise you may get a licensing error.
```shell
--volume="/etc/localtime:/etc/localtime"
```

#Note
If you intend to use the FlahPro5 programmer, you need to run the container in 'privileged' mode, and mount the usb device tree.

### Using local display (interactive use)
Example:
```shell
export LIBERO_USER=skeys
docker run --net=host -u $LIBERO_USER --env="DISPLAY" --privileged -v="/dev/bus/usb:/dev/bus/usb:rw" --volume="/etc/localtime:/etc/localtime" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" --volume="$HOME/workspaceLibero/:/home/$LIBERO_USER:rw" -it docker/liberosoc /usr/local/bin/libero_env.sh libero libero
```

### Running LiberoSoC in headless mode (Jenkins etc)
Almost the same as using your local display, just add 'xvfb-run' before calling 'libero'. Also, '--env="DISPLAY"' can be dropped.

Example:
```shell
export LIBERO_USER=skeys
docker run --net=host -u $LIBERO_USER --volume="/etc/localtime:/etc/localtime" --volume="$HOME/workspaceLiberoSoC:/workspace:rw" -it docker/liberosoc /usr/local/bin/libero_env.sh xvfb-run libero
```

### Setting up a docker network.
TODO: Add info here on how to setup a docker network to combile the usage of a local GUI, while specifiying the MAC address and hostname. --hostname=<hostname> --mac-address=<mac:address>

### 'lmgrd' "file not found"
cd /lib64
ln -s ld-linux-x86-64.so.2 /lib/x86_64-linux-gnu/ld-2.29.so
ln -s ld-lsb-x86-64.so.2 ld-linux-x86-64.so.2
ln -s ld-lsb-x86-64.so.3 ld-linux-x86-64.so.2


