# **Rubydev**
A quick and easy ruby development environment based upon fedora:latest.
Containers are expected to contain a few common development tools as follows:

### Shell 
* [bash](https://www.gnu.org/software/bash/)
* [bash-it](https://github.com/Bash-it/bash-it)

### Ruby 
* [RVM](https://rvm.io/)
* [Ruby 2.2.3](https://www.ruby-lang.org/en/downloads/)

### Source Control
* Git 
* Subversion

###  Editor
* vim
* [vundle](https://github.com/VundleVim/Vundle.vim)

### Utilities 
* [tmux](https://tmux.github.io/)
* [tmuxinator](https://github.com/tmuxinator/tmuxinator)
* [packer](https://www.packer.io/)
  
## **Getting Started**
1.  Pull the image `docker pull cabyrd/rubydev:latest`
2.  Start a container `docker run -ti cabyrd:/rubydev`

Starting containers as shown above will give you access to a 
development environment.  Keep in mind that all source code
will reside inside the container file system, so be sure to 
push important commits before tearing down any important 
container.
