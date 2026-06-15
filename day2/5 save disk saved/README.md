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

## Conclusion

IPK, DEB, and RPM are package formats supported by Yocto through the `PACKAGE_CLASSES` variable. IPK uses the lightweight `opkg` package manager and is suitable for resource-constrained embedded systems. DEB uses `dpkg` and `apt`, providing strong dependency management for Debian-based systems. RPM uses `rpm` and `dnf`, offering enterprise-grade package management and rich metadata support. The selection depends on target hardware resources, distribution compatibility, and package management requirements.
