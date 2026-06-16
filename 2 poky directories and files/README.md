# YOCTO TERMINOLOGIES
## Metadata
--------------
- Poky = Bitbake + Metadata
- Metadata is collection of
  	- Configuration files (.conf): They tell the build system what to build and put into the image to support a particular platform.
	- Recipes (.bb and .bbappend) : It set of instructions that is read and processed by the bitbake.
	- Classes (.bbclass): They are used to abstract common functionality and share it amongst multiple recipe (.bb) files.
	- Includes (.inc): They store common variables or functions to avoid duplication between recipes.

## Recipes
---------
- Non-Yocto: A recipe is a set of instructions that describe how to prepare or make something, especially a dish
- Yocto: A recipe is a set of instructions that is read and processed by the bitbake
- Extension of Recipe: .bb
- A recipe describes:
    - where you get source code
    - which patches to apply
    - Configuration options
    - Compile options (library dependencies)
   	- Install
    - License
- a software component

### Examples of Recipes
----------------------
- dhcp_4.4.1.bb
- streamer1.0_1.16.1.bb


## Configuration Files
--------------------
- Files which hold
    - global definition of variables
    - user defined variables and
    - hardware configuration information
- They tell the build system what to build and put into the image to support a particular platform
- Extension: .conf

### Types
--------
- Machine Configuration Options
- Distribution Configuration Options
- Compiler tuning options
- General Common Configuration Options
- User Configuration Options (local.conf)

## classes
---------
- Class files are used to abstract common functionality and share it amongst multiple recipe (.bb) files
- To use a class file, you simply make sure the recipe inherits the class
- Eg. inherit classname
- Extension: .bbclass
- They are usually placed in classes directory inside the meta* directory

### Example of classes
-------------------
- cmake.bbclass - Handles cmake in recipes
- kernel.bbclass - Handles building kernels. Contains code to build all kernel trees
- module.bbclass - Provides support for building out-of-tree Linux Kernel Modules

## Layers
--------
- A collection of related recipes.
or
Layers are recipe containers (folders)
- Typical naming convention: meta-<layername>
- Poky has the following layers: meta, meta-poky, meta-selftest, meta-skeleton, meta-yocto-bsp

### Why Layers
-----------
- Layers provide a mechanism to isolate meta data according to functionality, for instance BSPs, distribution configuration, etc.
- You could have a BSP layer, a GUI layer, a distro configuration, middleware, or an application
- Putting your entire build into one layer limits and complicates future customization and reuse. 
- Example: meta-poky          -- Distro metadata
         meta-yocto-bsp     -- BSP    metadata
- Layers allow to easily to add entire sets of meta data and/or replace sets with other sets.
- meta-poky, is itself a layer applied on top of the OE-Core metadata layer, meta

### Which layers are used by Poky build system?
-------------------------------------------
- BBLAYERS variable present in build/conf/bblayers.conf file list the layers Bitbake tries to find
- If bblayers.conf is not present when you start the build, the OpenEmbedded build system creates it from bblayers.conf.sample when you source the oe-init-build-env script

### Command to find out which layers are present
----------------------------------------------
```
$ bitbake-layers show-layers
```
- Note: You can include any number of available layers from the Yocto Project 

### Where to get other layers
--------------------------
```
https://layers.openembedded.org/layerindex/branch/master/layers/
```

### Yocto Project Compatible Layers
--------------------------------
```
https://www.yoctoproject.org/software-overview/layers/
```
- These layers are tested and are fully compatible with yocto project.
- OpenEmbedded layer index contains more layers but the content is less universally validated

## Image
-----------
- An image is the top level recipe, it has a description, a license and inherits the core-image class
- It is used alongside the machine definition
- machine describes the hardware used and its capabilities
- image is architecture agnostic and defines how the root filesystem is built, with what packages.
- By default, several images are provided in Poky

### Command to check the list of available image recipes
----------------------------------------------------
```
$ ls meta*/recipes*/images/*.bb
```

## Packages
-------------
- Non-Yocto: Any wrapped or boxed object or group of objects.
- Yocto: A package is a binary file with name *.rpm, *.deb, or *.ipkg
- A single recipe produces many packages. All packages that a recipe generated are listed in the recipe variable

```
$ vi  meta/recipes-multimedia/libtiff/tiff_4.0.10.bb
```
PACKAGES =+ "tiffxx tiff-utils"

# Poky Source Tree

| Directory/File | Description |
|----------------|-------------|
| **bitbake** | Holds all Python scripts used by the `bitbake` command. The `bitbake/bin` directory is added to the `PATH` environment variable so the `bitbake` executable can be found. |
| **documentation** | Contains all documentation sources for the Yocto Project. These sources can be used to generate PDF and other documentation formats. |
| **meta** | Contains the OpenEmbedded Core (`oe-core`) metadata, including recipes, classes, and configuration files. |
| **meta-poky** | Holds the configuration for the Poky reference distribution. Includes sample configuration files such as `local.conf.sample` and `bblayers.conf.sample`. |
| **meta-skeleton** | Contains template recipes and examples for BSP (Board Support Package) and kernel development. |
| **meta-yocto-bsp** | Maintains several BSPs, including support for BeagleBone, EdgeRouter, and generic 32-bit and 64-bit x86 (IA) machines. |
| **scripts** | Contains scripts for environment setup, development tools, and utilities used to flash generated images onto target hardware. |
| **LICENSE** | Defines the licensing terms under which Poky is distributed (primarily a combination of GPLv2 and MIT licenses). |

# conf
-----------
- When you run source poky/oe-init-build-env, it will create a "build" folder in that directory
- Inside this build folder, it will create "conf" folder which contains two files:
  1. local.conf
  2. bblayers.conf

## local.conf
-------------
- Configures almost every aspect of the build system
- Contains local user settings
- MACHINE: The machine the target is built for
-	Eg: MACHINE = "qemux86-64"

DL_DIR: Where to place downloads
- During a first build the system will download many different source code tarballs,from various 
- upstream projects.These are all stored in DL_DIR
-	The default is a downloads directory under TOPDIR which is the build directory

TMP_DIR:  Where to place the build output
- This option specifies where the bulk of the building work should be done and
- where BitBake should place its temporary files(source extraction, compilation) and output

## Important Point:
----------------
- local.conf file is a very convenient way to override several default configurations over all the Yocto Project's tools.
- Essentially, we can change or set any variable, for example, add additional packages to an image file
- Though it is convenient, it should be considered as a temporary change as the build/conf/local.conf file is not usually tracked by any source code management system.	

## bblayers.conf
------------------
- The bblayers.conf file tells BitBake what layers you want considered during the build.
- By default, the layers listed in this file include layers minimally needed by the build system
- However, you must manually add any custom layers you have created

E.g: BBLAYERS = "\
                                  /home/linuxtrainer/poky/meta \
                                 /home/linuxtrainer/poky/meta-poky \
                                 /home/linuxtrainer/poky/meta-yocto-bsp \
                                 /home/linuxtrainer/poky/meta-mylayer \
                                 "
- This example enables four layers, one of which is a custom user defined layer named "meta-mylayer"

## BB_NUMBER_THREADS
-----------------
- Determines the number of tasks that Bitbake will perform in parallel
- Note: These tasks are related to bitbake and nothing related to compiling
- Defaults to the number of CPUs on the system

```
$ bitbake -e core-image-minimal | grep ^BB_NUMBER_THREADS=
```

## PARALLEL_MAKE
--------------
-	Corresponds to the -j make option
-	specifies the number of processes that GNU make can run in parallel on a compilation task
- Defaults to the number of CPUs on the system
```
	$ bitbake -e core-image-minimal | grep ^PARALLEL_MAKE=
```

## Where should i place the content of conf/local.conf as this file is part of build folder?
------------------------------------------------------------------------------------------
- In general, everything in your local.conf should be moved to your own distro configuration
- Finally, you should only set DISTRO to your own distro in local.conf

## Other Build Directories

| Directory | Description |
|-----------|-------------|
| **downloads** | Stores downloaded upstream source tarballs and Git repositories required by recipes during the build process. This directory helps avoid re-downloading sources for subsequent builds. |
| **sstate-cache** | Contains the Shared State (sstate) cache. BitBake uses this cache to reuse previously built components, significantly reducing build times. |
| **tmp** | Holds all build output generated by the Yocto build system, including compiled binaries, packages, logs, and images. |
| **tmp/deploy/images/<machine>** | Contains the final generated images and related artifacts (kernel, root filesystem, bootloader files, SDKs, etc.) for the target machine. |
| **cache** | Stores cache data used by BitBake's parser to speed up metadata parsing and build initialization. |


# Yocto/OpenEmbedded Build System Workflow
-----------------------------------------
1. Developers specify architecture, policies, patches and configuration details.
2. The build system fetches and downloads the source code from the specified location
 supports downloading tarballs and source code repositories systems such as git/svn
3. extracts the sources into a local work area
4. patches are applied
5. steps for configuring and compiling the software are run
6. installs the software into a temporary staging area
 depending on the user configuration, deb/rpm/ipk binaries are generated
7. the build system generates a binary package feed that is used to create the final root file image.
8. finally generates the file system image and a customized Extensible SDK (eSDK) for application development in parallel

# Images generated by Poky Build
---------------------------------
- The build process writes images out to the Build Directory inside the tmp/deploy/images/machine/ folder
1. **kernel-image:** 
- A kernel binary file
- The KERNEL_IMAGETYPE variable determines the naming scheme for the kernel image file.
	```
    $ bitbake -e core-image-minimal | grep ^KERNEL_IMAGETYPE=
    ```
2. **root-filesystem-image:**
- Root filesystems for the target device (e.g. *.ext3 or *.bz2 files).
- The IMAGE_FSTYPES variable determines the root filesystem image type
  ```
  $ bitbake -e core-image-minimal | grep ^IMAGE_FSTYPES=
  ```
3.**kernel-modules:**
		Tarballs that contain all the modules built for the kernel
4.**bootloaders:**
- If applicable to the target machine, bootloaders supporting the image.

## symlinks
-----------
- symbolic link pointing to the most recently built file for each machine
-	These links might be useful for external scripts that need to obtain  latest version of each file


# Saving Disk Space while building Yocto 
----------------------------------------
- Yocto Build System can take a lot of disk space during build. But bitbake provides options to preserve disk space
- You can tell bitbake to delete all the source code, build files after building a particular recipe by adding the following line in local.conf file
```
INHERIT += "rm_work"
```
- Disadvantage: Difficult to debug while build fails of any recipe.
- For example, if you want to exclude bitbake deleting source code of a particular package, you can add it in RM_WORK_EXCLUDE += "recipe-name"
- E.g: RM_WORK_EXCLUDE += "core-image-minimal"


# IPK vs DEB vs RPM

| Feature | IPK | DEB | RPM |
|----------|-----|-----|-----|
| Package Format | `.ipk` | `.deb` | `.rpm` |
| Package Manager | `opkg` | `dpkg`, `apt` | `rpm`, `dnf`, `yum` |
| Origin | OpenEmbedded / OpenWrt | Debian | Red Hat |
| Package Size | Smallest | Medium | Largest |
| Build Speed | Fastest | Moderate | Moderate |
| Dependency Handling | Basic | Excellent | Excellent |
| Memory Footprint | Lowest | Medium | Highest |
| Embedded Usage | Very Common | Less Common | Common |
| Yocto Support | Yes | Yes | Yes |

---

## IPK (Itsy Package)

### Description
- Lightweight package format designed for embedded Linux systems.
- Commonly used in OpenEmbedded and OpenWrt distributions.
- Managed using the `opkg` package manager.

### Advantages
- Small package size.
- Low storage and memory requirements.
- Fast package generation and installation.

### Disadvantages
- Limited dependency management compared to DEB and RPM.

### Commands

```bash
opkg install package.ipk
opkg remove package
opkg list-installed
```

### Typical Use Cases
- Routers
- IoT devices
- Resource-constrained embedded systems

---

## DEB (Debian Package)

### Description
- Standard package format for Debian-based distributions.
- Managed using `dpkg` and `apt`.

### Advantages
- Mature ecosystem.
- Excellent dependency resolution.
- Large package repositories.

### Disadvantages
- Larger package metadata.
- Higher storage requirements than IPK.

### Commands

```bash
dpkg -i package.deb
apt install package
apt remove package
```

### Typical Use Cases
- Debian
- Ubuntu
- Raspberry Pi OS

---

## RPM (Red Hat Package Manager)

### Description
- Package format used by Red Hat-based distributions.
- Managed using `rpm`, `dnf`, or `yum`.

### Advantages
- Enterprise-grade package management.
- Rich metadata support.
- Strong dependency handling.

### Disadvantages
- Larger package database.
- Higher resource consumption.

### Commands

```bash
rpm -ivh package.rpm
rpm -e package

dnf install package
```

### Typical Use Cases
- Red Hat Enterprise Linux (RHEL)
- Fedora
- CentOS
- Enterprise embedded Linux products

---

## Yocto Configuration

Select the package format using `PACKAGE_CLASSES`:

### RPM

```conf
PACKAGE_CLASSES ?= "package_rpm"
```

### DEB

```conf
PACKAGE_CLASSES ?= "package_deb"
```

### IPK

```conf
PACKAGE_CLASSES ?= "package_ipk"
```

---

## Generated Package Locations

```text
tmp/deploy/ipk/
tmp/deploy/deb/
tmp/deploy/rpm/
```

---

## Recommendation

| Scenario | Recommended Format |
|-----------|-------------------|
| Small IoT Device | IPK |
| Debian/Ubuntu Based Product | DEB |
| Enterprise Linux Product | RPM |
| Fastest Builds | IPK |
| Best Dependency Management | DEB / RPM |
| Most Common in Modern Yocto Builds | RPM |

---
IPK, DEB, and RPM are package formats supported by Yocto through the `PACKAGE_CLASSES` variable. IPK uses the lightweight `opkg` package manager and is suitable for resource-constrained embedded systems. DEB uses `dpkg` and `apt`, providing strong dependency management for Debian-based systems. RPM uses `rpm` and `dnf`, offering enterprise-grade package management and rich metadata support. The selection depends on target hardware resources, distribution compatibility, and package management requirements.
