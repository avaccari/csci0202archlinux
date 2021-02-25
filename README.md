# csci0202archlinux
Arch linux image for CSCI0202 - Computer Architecture at Middlebury College

## Features
-  *pacman.conf* is modified to allow full extraction of all packaged.
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

## Compatibility matrix
| Docker Desktop | macOS Mojave 10.14.6 |
| :---: | :---: |
| 3.0.1 | :white_check_mark: |
| 3.1.0 | :white_check_mark: |

## Issues
### macOS Mojave 10.14.6
- Running in docker currently prevents *gdb* from disabling address space randomization. This is problematic for some of the problem sets in computer architecture. The *seccomp* can be changed in the docker *run* command (--security-opt seccomp=unconfined) but if would be nice if this could be changed when building the image ([ref](https://stackoverflow.com/a/46676907/2312671)).
- Starting with v3.0.0 of Docker desktop, an error is reported when trying to share folders between host and container. The current workaround is to disable the gRPC FUSE under experimental options ([ref](https://github.com/docker/for-mac/issues/5115)).
- A backward compatibility issue was introduced with the update to glibc 2.33. Until the issue is fixed in the next release, this image uses a patched version of glibc ([ref](https://serverfault.com/a/1053273/616627)). "

## Log
2021-02-25 - Added workaround for glibc 2.33 backward compatibility issue.
2020-12-13 - Initial release (1.0a). Still undergoing testing."
