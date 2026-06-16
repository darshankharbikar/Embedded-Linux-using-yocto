# Yocto Project Releases
------------------------

### Naming Convention
-----------------
- Yocto Project releases follow the naming convention: Major.Minor.patch number
- Eg. yocto-2.7.3
- Major release number changes imply compatibility changes with previous releases
- Minor release number changes imply significant changes up to, but not including compatibility changes
- Minor rev number changes are for minor issues such as simple bugfixes, security updates, etc.

Poky Releases
--------------
- Poky releases has code names as well as Major.Minor.patch numbering
- Yocto Project/Poky Release, are released at the same time

## Yocto Project Releases
-----------------------
- Major Releases: Every six months in April and October
- Minor Releases: 
	- No Particular schedule
	- Driven by the accumulation of enough significant fixes or enhancements to the associated major release

### Concept of codenames
---------------------
- Branches of metadata with the same codename are compatible with each other

## Types of Releases
--------------------

a. Milestone Releases
----------------------
- Major Release is divided into milestone releases.
- Milestone releases are used as:
  - checkpoints for our progress
  - preview for the public community
  - to manage changes in the middle of a release 
- Each milestone lasts about 4-8 weeks and has one planning week, several development weeks, stabilization weeks and one release week:

b. Point Releases
-------------------
- A point release is a minor release such as 1.0.x
- Point releases are necessary to address the following:
  - Issues building on current Linux distributions.
	- fix critical bugs and security issues (CVEs) for the first 6 months after release
	- fix security issues for the first year after release

## Release Lifecycle
----------------------
- There are two possible lifecycles a release may follow:
- Initial Release -> Stable -> Community -> EOL
	OR
- Initial Release -> LTS	-> Community  -> EOL

### Stable vs LTS Release Difference
---------------------------------
- Stable releases are maintained for seven months
- LTS releases are maintained initially for two years
- LTS releases are preannounced and known to be LTS in advance (usually every two years)

### Community Support
-------------------
- Branch transitions to community support after the last stable dot release identified by the stable/LTS maintainer.
- A call for a community support maintainer is sent to the mailing lists.
	- A six (6) week waiting period.
	- if there is no new maintainer, then the branch goes to into EOL status
- Note:	Branches only have community support status if there is an active community member willing to step into the maintainer role for that series


### Layers and Branches
---------------------
- Layers being developed simultaneously by several different parties, the different flavors of Yocto and subsequent layers have to be split into branches in Git
- Most BSP layers will only work with OpenEmbedded-Core of the same branch.
- Mixing branches among your layers will end up in conflicts
- For example, the so called bbappends, sometimes are tied to specific version number and will break the build if those versions are not found in the layers.

### Which Branch to choose?
-------------------------
- You should evaluate all the layers and find a compromise between:
  - Getting the latest stable branch
  - Getting the latest branch supported by all layers.
- Note:  yocto branch you decided to use, could not be supported by your current host linux distribution.
- Eg:  I want to use a layer which forces me to stick with Krogoth, but this branch is not tested with newer distributions such as Ubunutu 16.04 or 18.04.


