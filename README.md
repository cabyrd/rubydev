# **Rubydev**
A quick and easy ruby development environment based upon ruby:latest.
Containers are expected to contain a few common development tools as follows:

### Source Control
* Git 
* Subversion

###  Editor
* vim
* [vundle](https://github.com/VundleVim/Vundle.vim)

### Utilities 
* [tmux](https://tmux.github.io/)
* [tmuxinator](https://github.com/tmuxinator/tmuxinator)
  
## **Getting Started**
1.  Pull the image `docker pull cabyrd/rubydev:latest`
2.  Start a container `docker run -ti cabyrd:/rubydev`

Starting containers as shown above will give you access to a 
development environment.  Keep in mind that all source code
will reside inside the container file system, so be sure to 
push important commits before tearing down any important 
container.
