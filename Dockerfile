FROM ubuntu:xenial
MAINTAINER David Gibson <david.stanford.gibson@gmail.com>

# Get Packages
RUN apt-get update

# basics
RUN apt-get install -y nginx openssh-server git-core openssh-client curl
RUN apt-get install -y build-essential
RUN apt-get install -y openssl imagemagick rake \
  flex bison gperf ruby perl wget tar libwebp5 libwebp-dev libhyphen-dev \
  libsqlite3-dev libfontconfig1-dev libicu-dev libfreetype6 libssl-dev \
  libpng-dev libjpeg-dev python libx11-dev libxext-dev gcc-4.9 g++-4.9

# install RVM, Ruby, Bundler, and wraith
RUN \curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements && rvm install 2.1 && gem install bundler --no-ri --no-rdoc && gem install wraith"

# intall phantomJS 2.5beta for flexbox
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.5.0-beta-linux-ubuntu-xenial-x86_64.tar.gz && \
    tar -xvzf phantomjs-2.5.0-beta-linux-ubuntu-xenial-x86_64.tar.gz && \
    rm phantomjs-2.5.0-beta-linux-ubuntu-xenial-x86_64.tar.gz && \
    mv phantomjs-2.5.0-beta-ubuntu-xenial /usr/local/share && \
    ln -sf /usr/local/share/phantomjs-2.5.0-beta-ubuntu-xenial/bin/phantomjs /usr/local/bin && \
    chmod +x /usr/local/share/phantomjs-2.5.0-beta-ubuntu-xenial/bin/phantomjs

CMD ["nginx", "-g", "daemon off;"]
