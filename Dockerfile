FROM ruby:latest
MAINTAINER Chris Byrd

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    dos2unix \
    git \
    gnupg \
    less \
    libgmp-dev \
    patch \
    rsync \
    smbclient \
    subversion \
    silversearcher-ag \
    tmux \
    unzip \
    wget \
    vim \
    zip \
  && gem install tmuxinator \
  && gem install rubocop \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Setup packer for image builds
RUN mkdir /packer \
  && cd packer \
  && wget https://releases.hashicorp.com/packer/0.10.0/packer_0.10.0_linux_amd64.zip \
  && unzip *.zip \
  && ln -s /packer/packer /usr/local/bin/packer

# install gecode 
RUN mkdir /gecode-tmp \
  && cd /gecode-tmp \
  && wget http://www.gecode.org/download/gecode-3.7.3.tar.gz \
  && tar -xvf gecode-3.7.3.tar.gz \
  && cd gecode-3.7.3 \
  && ./configure && make && make install \
  && cd / && rm -rf /gecode-tmp 

WORKDIR /root
RUN mkdir src && mkdir .ssh

# Setup bash
RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git .bash_it \
  && .bash_it/install.sh \
  && echo "export PATH=$PATH:$BUNDLE_PATH" >> .bashrc

# Setup vim
RUN git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim \
  && git clone https://github.com/cabyrd/dot-files.git \
  && cp dot-files/.vimrc . \
  && rm -rf dot-files \ 
  && vim +PluginInstall +qall

ENV EDITOR=vim SHELL=/bin/bash
CMD ["/bin/bash"]
