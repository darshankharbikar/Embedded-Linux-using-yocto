## What is Yocto?
-----------------
- The Yocto Project is an open-source framework used to create custom Linux distributions for embedded systems.
- It lets you build a Linux OS that is tailored to your hardware and application needs, instead of using a generic distro like Ubuntu.
- Yocto is not a Linux distribution itself — it’s a build system and ecosystem.

## Why Yocto is used
--------------------
- Build minimal, optimized images for embedded devices
- Full control over:
1. Kernel
2. Bootloader
3. Libraries
4. Packages
- Support for many architectures (ARM, ARM64, x86, RISC-V, etc.)
- Industry standard (used in automotive, telecom, medical, IoT)

## Key Components
-----------------
1. BitBake
- The build engine (to make but more powerful)
- Reads recipes and executes tasks

2. Recipes (.bb files)
- Describe how to build a package
- Include:
  - Source URL
  - Dependencies
  - Compile/install steps

3. Layers
- Logical grouping of recipes
- Allow modularity and reuse
- Common layers:
  - meta (core)
  - meta-poky
  - meta-openembedded
  - BSP layers (hardware-specific)

4. Poky
- Reference distribution provided by Yocto
- Includes:
      -BitBake
      -Core metadata
      -Tools and documentation

5. Images
- Final output (e.g., .wic, .img, .tar.gz)
- Examples:
    - core-image-minimal
    - core-image-full-cmdline

## Typical Yocto Build Flow
----------------------------
1. Choose hardware (BSP layer)
2. Configure build (local.conf, bblayers.conf)
3. Select image
4. Run:
$ bitbake <image-name>

5. Flash image to target board

## Directory Structure (simplified)
-----------------------------------
- build/ – build output and configs
- meta-* – layers
- conf/ – configuration files
- tmp/ – work and output files

## Advantages
-------------
- Highly customizable
- Reproducible builds
- Scales well for large projects
- Long-term support options

## Challenges
-------------
- Steep learning curve
- Long build times
- Debugging can be complex
- Requires good Linux fundamentals

## Common Use Cases
-------------------
- Embedded Linux devices
- Automotive infotainment systems
- Routers and networking devices
- Industrial controllers
- IoT gateways
