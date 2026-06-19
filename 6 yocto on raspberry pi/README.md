# Yocto On RPI3
-----------------
## Raspberry Pi 3 
------------------
- SoC		: Broadcom BCM2837
- CPU		: 4× ARM Cortex-A53, 1.2GHz
- GPU		: Broadcom VideoCore IV
- RAM		: 1GB LPDDR2 (900 MHz)
- Networking: 10/100 Ethernet, 2.4GHz 802.11n wireless
- Bluetooth	: Bluetooth 4.1 Classic, Bluetooth Low Energy
- Storage	: microSD
- GPIO		: 40-pin header
- Ports		: HDMI, 3.5mm analogue audio-video jack, 4× USB 2.0, Ethernet, Camera Serial Interface (CSI), Display Serial Interface (DSI)

## Raspberry Pi 4 Model B
------------------------
- SoC      : Broadcom BCM2711
- CPU      : 4× ARM Cortex-A72, ARMv8-A, 64-bit
- Clock    : 1.5 GHz
- GPU      : Broadcom VideoCore VI
- RAM      : 1GB / 2GB / 4GB / 8GB LPDDR4
- Network  : Gigabit Ethernet
- Wireless : 2.4GHz / 5GHz 802.11ac Wi-Fi
- Bluetooth: Bluetooth 5.0, BLE
- Storage  : microSD
- GPIO     : 40-pin header
- Ports    : 2× micro-HDMI, 2× USB 3.0, 2× USB 2.0, USB-C power, CSI, DSI

## meta-raspberrypi
------------------
- Hardware specific BSP overlay for the RaspberryPi device.
- The core BSP part of meta-raspberrypi should work with different OpenEmbedded/Yocto distributions and layer
stacks, such as:
	• Distro-less (only with OE-Core).
	• Angstrom.
	• Yocto/Poky

## Hardware Supported
--------------------
- Raspberry Pi
- Raspberry Pi 3
- Raspberry Pi 4
- Raspberry Zero
- Raspberry Zero Wireless

- Link: 
```
git://git.yoctoproject.org/meta-raspberrypi
```
## Dependencies
----------------
- URI 		: git://git.openembedded.org/meta-openembedded
- Layers	: meta-oe, meta-multimedia, meta-networking, meta-python

## Steps to generate an Yocto Image for Raspberry Pi3
--------------------------------------------------
- Poky has no support for Broadcom BCM SoC.
- Step1: Download the BSP Layer for Raspberry Pi3
```
$ git clone git://git.yoctoproject.org/meta-raspberrypi
```
- Step2: Download meta-openembedded branch as meta-raspberrypi layer depends upon it
```
$ git clone git://git.openembedded.org/meta-openembedded
```
- Step3: Once you complete cloning, there should be three folders: poky, meta-openembedded, meta-raspberrypi
```
$ ls source
```
- Step4: Run the environment script to setup the Yocto Environment and create build directory
```
$ source poky/oe-init-build-env build_pi
```
- Step5: Add meta-openembedded layers ( meta-oe, meta-multimedia, meta-networking, meta-python) and meta-raspberrypi layer to bblayers.conf
- Step6: Set the MACHINE in local.conf to "raspberrypi3".
```
$ echo 'MACHINE = "raspberrypi3"' >> conf/local.conf

For Raspberry Pi 4B, use either:
```
MACHINE = "raspberrypi4"
```
or for 64-bit userspace/kernel:
```
MACHINE = "raspberrypi4-64"
```
meta-raspberrypi provides a specific raspberrypi4-64.conf machine configuration for 64-bit Raspberry Pi 4 builds.

```
- Step7: Final step is to build the image. To find out the available images:
```
$ ls ../meta-raspberrypi/recipes-*/images/
```

## Images
------------
- rpi-hwup-image.bb: This is an image based on core-image-minimal
- rpi-basic-image.bb: This is an image based on rpi-hwup-image.bb, with some added features (a splash screen)
- rpi-test-image.bb: This is an image based on rpi-basic-image.bb, which includes some packages present in meta-raspberrypi

## Enabling UART
--------------
- RaspberryPi 3 does not have the UART enabled by default because this needs a fixed core frequency and enable_uart wil set it to the minimum
- To enable it, set the following in local.conf
```
ENABLE_UART = "1"
```
```
$ bitbake rpi-hwup-image
```

## Booting Process in Raspberry Pi3
---------------------------------
- Broadcom BCM2837:
	- CPU 	-	1.2GHz 64-bit quad-core ARMv8 Cortex-A53
	- GPU 	-	Broadcom VideoCore IV
	- SDRAM	-	1024 MiB

### When you power the device
Stage 1 Booting - OnChip ROM
----------------------------
- GPU - On, CPU - Off, SDRAM - Off
- When the Pi is powered up the first thing that starts working is the GPU core and ARM CPU is held in reset
- The GPU core is the main part responsible for the first booting steps of the Pi. 
- Inside Broadcom’s SoC, there is a small boot ROM, its programmed by default to look for a file called
	bootcode.bin on the SD Card
- It loads bootcode.bin into L2 Cache memory		

Stage 2 Booting - bootcode.bin
------------------------------
- GPU - On, CPU - Off, SDRAM - On
- Executed on VideoCore GPU
- Enables SDRAM
- Loads the third stage bootloader start.elf into SDRAM

Stage 3 Booting - start.elf
----------------------------
- GPU - On, CPU - On, SDRAM - On
- start.elf is actually a full fledge proprietary operating system for GPU known as VCOS (VideoCore OS).
- It starts by reading config.txt  which contains configuration parameters for
- VideoCore (Video/HDMI modes, memory, console frame buffers etc) and
	- Linux Kernel (load addresses, device tree, uart/console baud rates etc)
	- kernel = kernel7.img
- It also loads a file cmdline.txt if it exists, and will pass its contents as kernel command line
- Finally enables the ARM CPU and loads the kernel image which is executed on the ARM CPU
- It also loads the dtb file

## Booting in Raspberry Pi3
---------------------------
- GPU Core
- first stage bootloader, which is stored in ROM on the SoC
- bootcode.bin
- start.elf
- config.txt
- cmdline.txt
- kernel7.img

## Flashing images on SD Card
-----------------------------
- Images are present in tmp/deploy/images/raspberrypi3
```
$ lsblk

$ sudo dd if=rpi-hwup-image-raspberrypi3.rpi-sdimg of=/dev/sdb bs=4096 && sync
```

## Hardware setup
-----------------
- An SD card with image flashed
- Raspberry Pi 3
- A power adapter that can supply 5V
- USB TTL-2303(PL2303) for serial communication
- USB-TTL is connected to the J8 connector of Raspberry Pi3 in the following formation:

| J8 Pin | USB-TTL Function |
|---------|------------------|
| 6       | GND (Ground)     |
| 8       | RXL              |
| 10      | TXL              |

## Raspberry Pi Zero W and Yocto
------------------------------
- 1GHz, Single-core CPU
- 512MB RAM
- Mini HDMI and USB On-The-Go ports
- Micro USB power
- HAT-compatible 40-pin header
- Composite video and reset headers
-	CSI camera connector
-	802.11n wireless LAN
-	Bluetooth 4.0

## Steps for generating Yocto Image
----------------------------------
- Everything is same except MACHINE = 'raspberrypi0-wifi'

## Remotely access raspberry pi3
--------------------------------
```
$ bitbake rpi-basic-image
```
- dropbear is a SSH 2 server designed to be small enough to be used in small memory environments

## IMAGE_ROOTFS_EXTRA_SPACE
------------------------
- Adds extra free space to the root filesystem image.
- The variable specifies the value in kilobytes
- Default value : 0
- For example, to add an additional 4 GB of space, set the variable to IMAGE_ROOTFS_EXTRA_SPACE = "4194304"


## For RPI 4B
## Additional Info: Yocto on Raspberry Pi 4B

### Raspberry Pi 4B Hardware

```md
## Raspberry Pi 4 Model B
------------------------
- SoC      : Broadcom BCM2711
- CPU      : 4× ARM Cortex-A72, ARMv8-A, 64-bit
- Clock    : 1.5 GHz
- GPU      : Broadcom VideoCore VI
- RAM      : 1GB / 2GB / 4GB / 8GB LPDDR4
- Network  : Gigabit Ethernet
- Wireless : 2.4GHz / 5GHz 802.11ac Wi-Fi
- Bluetooth: Bluetooth 5.0, BLE
- Storage  : microSD
- GPIO     : 40-pin header
- Ports    : 2× micro-HDMI, 2× USB 3.0, 2× USB 2.0, USB-C power, CSI, DSI
```

### MACHINE Selection

For Raspberry Pi 4B, use either:

```conf
MACHINE = "raspberrypi4"
```

or for 64-bit userspace/kernel:

```conf
MACHINE = "raspberrypi4-64"
```

`meta-raspberrypi` provides a specific `raspberrypi4-64.conf` machine configuration for 64-bit Raspberry Pi 4 builds. ([Yocto Project Git][1])

### Recommended for RPi 4B

```conf
MACHINE = "raspberrypi4-64"
ENABLE_UART = "1"
GPU_MEM = "64"
```

For embedded/Linux BSP learning, prefer:

```bash
bitbake core-image-minimal
```

or:

```bash
bitbake rpi-basic-image
```

### Deploy Path

For 64-bit Raspberry Pi 4:

```bash
tmp/deploy/images/raspberrypi4-64/
```

For 32-bit Raspberry Pi 4:

```bash
tmp/deploy/images/raspberrypi4/
```

### Flashing SD Card

```bash
lsblk

sudo dd if=core-image-minimal-raspberrypi4-64.rootfs.wic.bz2 of=/dev/sdX bs=4M status=progress conv=fsync
```

If image is compressed:

```bash
bunzip2 core-image-minimal-raspberrypi4-64.rootfs.wic.bz2
sudo dd if=core-image-minimal-raspberrypi4-64.rootfs.wic of=/dev/sdX bs=4M status=progress conv=fsync
```

### Raspberry Pi 4B Boot Flow

RPi4 differs from RPi3 because it uses an **EEPROM bootloader**.

```md
Power ON
  ↓
Boot ROM
  ↓
SPI EEPROM bootloader
  ↓
FAT boot partition
  ↓
start4.elf + fixup4.dat
  ↓
config.txt
  ↓
cmdline.txt
  ↓
Device Tree: bcm2711-rpi-4-b.dtb
  ↓
kernel8.img / Image
  ↓
Linux kernel
  ↓
root filesystem
```

RPi4 uses `start4.elf` and `fixup4.dat`; older Pi boards commonly use `start.elf`, `fixup.dat`, and sometimes `bootcode.bin`. ([GitHub][2])

### Important Boot Files

```md
boot partition:
-------------
- start4.elf
- fixup4.dat
- config.txt
- cmdline.txt
- bcm2711-rpi-4-b.dtb
- overlays/
- kernel8.img or Image
```

### UART Hardware Setup

Same 40-pin header logic as RPi3:

| RPi4 Pin | Function          |
| -------: | ----------------- |
|        6 | GND               |
|        8 | GPIO14 / UART TXD |
|       10 | GPIO15 / UART RXD |

Connection:

| USB-TTL | Raspberry Pi 4B |
| ------- | --------------- |
| GND     | Pin 6           |
| RX      | Pin 8 / TXD     |
| TX      | Pin 10 / RXD    |

Use **3.3V TTL only**. Do not connect 5V TTL to UART pins.

Serial terminal:

```bash
sudo minicom -D /dev/ttyUSB0 -b 115200
```

or:

```bash
screen /dev/ttyUSB0 115200
```

### `local.conf` Example

```conf
MACHINE = "raspberrypi4-64"

ENABLE_UART = "1"

IMAGE_ROOTFS_EXTRA_SPACE = "1048576"

DISTRO_FEATURES:append = " systemd wifi bluetooth"

VIRTUAL-RUNTIME_init_manager = "systemd"
```

### RPi3 vs RPi4 Yocto Differences

| Area          | Raspberry Pi 3           | Raspberry Pi 4B            |
| ------------- | ------------------------ | -------------------------- |
| SoC           | BCM2837                  | BCM2711                    |
| CPU           | Cortex-A53               | Cortex-A72                 |
| RAM           | LPDDR2                   | LPDDR4                     |
| Ethernet      | 10/100                   | Gigabit                    |
| USB           | USB 2.0                  | USB 3.0 + USB 2.0          |
| HDMI          | Full HDMI                | 2× micro-HDMI              |
| Boot          | GPU ROM loads boot files | EEPROM bootloader involved |
| Firmware      | `start.elf`, `fixup.dat` | `start4.elf`, `fixup4.dat` |
| DTB           | BCM2837 DTB              | `bcm2711-rpi-4-b.dtb`      |
| 64-bit target | optional                 | strongly preferred         |

### Common RPi4 Yocto Pitfalls

```md
1. Using wrong MACHINE
   - Use raspberrypi4 or raspberrypi4-64.

2. Mixing Yocto branches
   - poky, meta-openembedded, and meta-raspberrypi branches should match.

3. Wrong boot files
   - RPi4 needs start4.elf and fixup4.dat.

4. UART not visible
   - Add ENABLE_UART = "1".
   - Check USB-TTL wiring.
   - Use 115200 baud.

5. Power issue
   - RPi4 needs stable 5V USB-C power supply.
   - Weak adapters cause random boot failure.

6. Wrong SD card device in dd
   - Always verify with lsblk before flashing.
```

### Best Build Command for Learning

```bash
bitbake core-image-minimal
```

Then move to:

```bash
bitbake rpi-basic-image
```

For BSP/device-driver learning on RPi4B, `raspberrypi4-64 + core-image-minimal` is the cleanest starting point.

[1]: https://git.yoctoproject.org/meta-raspberrypi/tree/conf/machine/raspberrypi4-64.conf?h=master&utm_source=chatgpt.com "raspberrypi4-64.conf « machine « conf - meta-raspberrypi"
[2]: https://github.com/raspberrypi/rpi-eeprom/issues/738?utm_source=chatgpt.com "\"Firmware not found\" · Issue #738 · raspberrypi/rpi-eeprom"

