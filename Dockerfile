FROM fedora:latest
MAINTAINER Chris Byrd

RUN dnf clean all \
  && dnf update -v --debugsolver vim-minimal -y \ 
  && dnf install --best --allowerasing -y \
      automake \
      bash-completion \
      ca-certificates \
      ctags \
      curl \
      dos2unix \
      flex \
      gcc \
      gcc-c++ \
      git \
      gpg \
      kernel-devel \
      make \
      nodejs \
      openssh-clients \
      patch \
      powerline \
      procps-ng \
      rsync \
      samba-client \
      subversion \
      tar \
      task \
      the_silver_searcher \
      tmux \
      tmux-powerline \
      tree \
      unzip \
      which \
      wget \
      vim \
      zip \
    && dnf clean all

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
    && curl -v -sSL https://get.rvm.io | bash \
    && source /usr/local/rvm/scripts/rvm \ 
    && /usr/local/rvm/bin/rvm install 2.3.1 \ 
    && /usr/local/rvm/bin/rvm alias create default 2.3.1 \ 
    && /usr/local/rvm/bin/rvm all do gem install --backtrace bundle \  
    && /usr/local/rvm/bin/rvm all do gem install --backtrace tmuxinator \  
    && /usr/local/rvm/bin/rvm all do gem install --backtrace rubocop \ 
    && dnf clean all

# Setup packer for image builds
RUN mkdir /packer \
  && cd packer \
  && wget https://releases.hashicorp.com/packer/0.10.1/packer_0.10.1_linux_amd64.zip \
  && unzip *.zip \
  && ln -s /packer/packer /usr/local/bin/packer \
  && rm *.zip

# install gecode 
RUN mkdir /gecode-tmp \
  && cd /gecode-tmp \
  && wget http://www.gecode.org/download/gecode-3.7.3.tar.gz \
  && tar -xvf gecode-3.7.3.tar.gz \
  && cd gecode-3.7.3 \
  && ./configure && make && make install \
  && cd / && rm -rf /gecode-tmp 

WORKDIR /root

# Setup util desired directories, bash, and vim
RUN mkdir src \
  && mkdir .ssh \ 
  && git clone --depth=1 https://github.com/Bash-it/bash-it.git .bash_it \
  && .bash_it/install.sh \
  && echo "export TERM=screen-256color" >> .bashrc \
  && echo "source /usr/local/rvm/scripts/rvm" >> .bashrc \ 
  && echo "source /usr/share/bash-completion/completions/git" >> .bashrc \
  && echo "alias vi=vim" >> .bashrc \
  && git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim \
  && git clone https://github.com/cabyrd/dot-files.git \
  && cp dot-files/.vimrc . \
  && cp dot-files/.tmux.conf . \
  && rm -rf dot-files \ 
  && vim +PluginInstall +qall

ENV EDITOR=vim SHELL=/bin/bash LC_CTYPE=en_US.UTF-8 LC_ALL=en_US.UTF-8 LD_LIBRARY_PATH=/usr/local/lib USE_SYSTEM_GECODE=1
CMD ["/bin/bash"]
