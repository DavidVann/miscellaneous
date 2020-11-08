#!/user/bin/env bash
# First line of a shell script gives the path to the interpreter used to execute the script

# Use "man <command>" to get more information on commands listed below, e.g., "man apt" gives the manual page for apt

# Install Guest Additions
sudo apt update
    # sudo -> execute command as superuser
    # apt -> more user-friendly wrapper for apt-get, the package management system for Debian-based systems (software installation and removal)
    # apt update -> downloads latest package information ("apt upgrade" actually installs latest versions)
sudo apt install -y build-essential dkms
    # -y -> automatically answer yes to all prompts in the installation
    # build-essential -> packages necessary for compiling Debian packages
    # dkms -> Dynamic Kernal Module Support package, needed for compiling external kernal modules

wget https://download.virtualbox.org/virtualbox/6.1.16/VBoxGuestAdditions_6.1.16.iso
    # wget -> utility for downloading files from the internet
sudo mkdir /media/VBoxGuestAdditions
    # mkdir -> make directory
sudo mount -o loop,ro VBoxGuestAdditions_6.1.16.iso /media/VBoxGuestAdditions
    # -o -> options flag
    # loop -> mount as loop device (mounts a file which contains a file system, so that it can be interacted with in the file system of the OS)
    # ro -> read-only
sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run 
    # sh -> run as shell command
rm VBoxGuestAdditions_6.1.16.iso 
    # rm -> delete file
sudo umount /media/VBoxGuestAdditions 
    # umount -> detach file system from file system of OS
sudo rmdir /media/VBoxGuestAdditions 
    # rmdir -> remove directory


# Install Software

## Useful packages
sudo apt install -y git curl texlive-latex-extra texlive-xetex
    # install the git and curl packages and fairly comprehensive LaTeX packages

## Miniconda (minimal installation of anaconda)
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh # download the installation script
bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda3
rm Miniconda3-latest-Linux-x86_64.sh # remove after installation
source $HOME/miniconda3/bin/activate # modify shell scripts to add conda to PATH (~/.bashrc file)
conda init # Initialize Miniconda3


### Create a conda environment and install some useful packages for data science
echo y | conda create -n dsci pandas matplotlib scikit-learn jupyterlab seaborn scipy numpy statsmodels spyder plotly xlrd
    # echo y | -> print "y" to the console and pipe it to the next command (this answers "yes" to prompts about installation)
    # Modify the list of packages above as desired
    # to use: type "conda activate dsci" within a terminal then proceed as normal

## R and RStudio
sudo apt install -y r-base
wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.3.1093-amd64.deb
sudo dpkg -i rstudio-1.3.1093-amd64.deb
sudo apt -f install -y # fix any missing depencies (-f == --fix-broken)
rm rstudio-1.3.1093-amd64.deb

### Install useful R packages
sudo apt install -y libxml2-dev libssl-dev libcurl4-openssl-dev # dependencies for tidyverse

# Change the list of packages below as desired
mkdir -p $HOME/R/x86_64-pc-linux-gnu-library/3.6 # create the default library
for pkg in tidyverse FNN glmnet tidymodels;
    do
        R -e "install.packages('$pkg')"
    done

