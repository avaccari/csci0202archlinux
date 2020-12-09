# csci0202archlinux
Arch linux image for CSCI0202 - Computer Architecture at Middlebury College

## Features
- *pacman.conf* is modified to allow full extraction of all packaged. 
- The *architect* user is created and added to the *wheel* group. The container will run as this user. 
- A default password is set for *architect* user. 
- The *wheel* group is added to *sudoers*.
- The following packages are installed: 
  - *arm-none-eabi-gcc*
  - *gcc*
  - *gdb*
  - *vim* (vi symlinks to vim)
  - *sudo*
  - *man-db* and *man-pages* (the database is built when creating the image)
  - *make* (not strictly necessary for 202)
  - *python-pip* (only needed if using *gef* - the enhanced *gdb*)
  - *gef* is installed and the source is added - commented - to *.gdbinit*. To fully install, uncomment.

## Tested on
- macOS Mojave 10.14.6

## Issues
### macOS Mojave 10.14.6
- Running in docker currently prevents *gdb* from disabling address space randomization. This is problematic for some of the problem sets in computer architecture. The *seccomp* can be changed in the docker *run* command (--security-opt seccomp=unconfined) but if would be nice if this could be changed when building the image ([ref](https://stackoverflow.com/questions/35860527/warning-error-disabling-address-space-randomization-operation-not-permitted)).