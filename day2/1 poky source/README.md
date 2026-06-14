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
