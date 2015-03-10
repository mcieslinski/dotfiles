The Creator
===========
Created by:     Michael R. Cieslinski, Jr.
Email:          mcieslinski@gmail.com


Info about this package
=======================
Nobody will probably ever read this file or use this stuff, but...

I created this package in order to more easily set up my Debian/Ubuntu computers/VMs when
I have reason to perform a refresh on my system or when I get a new system. These are a
number of settings that I have found to be very helpful as well as scripts to perform
various tasks for which I did not want to download some extra software.


Setting up the shell environment
================================
For bash-based debian systems, run distribute.sh
    - This will back up existing files to their .bak counterparts
    - If you regret your decision/doubt my wisdom, run restore.sh 


Functions provided
==================
extract() - Function to extract tar.gz, tgz, tar.bz2, tbz, or zip files, potentially to another directory.
    - The format of this is as follows: 
        extract archive.extension [destination/directory]

bak() - Function to create backup copies of files for testing purposes. Useful if you don't have/want to set up a git repo or the like.
    - The format of the function is as follows:
        bak [-r] file.bak
    - The -r parameter [r]estores the file to its original name.

noterm() - Function to open a program from the terminal detached and without printing program output to the terminal. Useful for launching things like firefox
    - The format of the function is as folows:
        noterm someprogram [program parameters]
    - So far, noterm has not failed to open anything correctly.


Aliases provided
================


Notes about various other things
================================
