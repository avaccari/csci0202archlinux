# Docker image for csci0202 - Computer Architecure at Middlebury College

# base arch linux image
FROM archlinux

# A label
LABEL description="Arch linux image for CSCI0202 - Computer Architecture at Middlebury College" \
      version="1.0a" \
      date="2020-12" \
      maintainer="Andrea Vaccari <avaccari _at_ middlebury _dot_ edu>" \
      features="\
* 'pacman.conf' is modified to allow full extraction of all packaged. \
* The 'architect' user is created and added to the 'wheel' group. The container will run as this user. \
* A default password is set for the 'architect' user to allow for 'sudo'. \
* The 'wheel' group is added to 'sudoers'. \
* The following packages are installed: \
arm-none-eabi-gcc, \
gcc, \
gdb, \
vim (vi symlinks to vim), \
sudo, \
man-db and man-pages (the database is built when creating the image), \
make (not strictly necessary for 202), \
python-pip (only needed if using 'gef' - the enhanced gdb), \
'gef' is installed and the source is added - commented - to '.gdbinit'. To fully install, uncomment."\
      tested_with="\
macOS Mojave 10.14.6" \
      issues="\
macOS Mojave 10.14.6: \
* Running in docker currently prevents gdb from disabling address space randomization. \
This is problematic for some of the problem sets in computer architecture. \
The seccomp can be changed in the docker run command (--security-opt seccomp=unconfined) but if would be nice if this could \
be changed when building the image. \
(https://stackoverflow.com/questions/35860527/warning-error-disabling-address-space-randomization-operation-not-permitted). \
* Starting with v3.0.0 of Docker desktop, an error is reported when trying to share folders between host and container. \
The current workaround is to disable the gRPC FUSE under experimental options. \
(https://github.com/docker/for-mac/issues/5115)."


# Modfy the pacman.conf so allow extractions of all packages.
# Force refresh the databases, update the system, install the required packages, and configure.
RUN sed -i '/NoExtract/d' /etc/pacman.conf \
    && pacman --noconfirm -Syyu \
    && pacman --noconfirm -S arm-none-eabi-gcc gcc gdb vim sudo man-db man-pages make python-pip \
    && mandb && ln -s /usr/bin/vim /usr/bin/vi 

# Add architect user and allow it to sudo
RUN useradd -m -G wheel architect \
    && echo 'architect:$1$kpO1zN4r$Rask8zrYury2aKIG4C1g31' | chpasswd -e\
    && sed -i -e '/wheel ALL=(ALL) ALL$/ s/^# //' /etc/sudoers

## start as user architect
USER architect
WORKDIR /home/architect

# This is to instal gef (a glorified gdb)
# The source line in .gdbinit is commented out to start with the regular gdb
# Uncomment the line or use 'source ~/.gdbinit-gef.py' to use gef.
RUN yes | pip install keystone-engine unicorn capstone ropper \
    && curl -s -o ~/.gdbinit-gef.py https://raw.githubusercontent.com/hugsy/gef/master/gef.py \
    && echo '#source ~/.gdbinit-gef.py' >> ~/.gdbinit