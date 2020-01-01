FROM ubuntu:16.04
MAINTAINER Ciao Chung

ENV DEBIAN_FRONTEND noninteractive

# base
RUN apt-get update -y
RUN apt-get install -y wget curl
RUN apt-get install -y --assume-yes apt-utils net-tools iputils-ping
RUN apt-get install -y software-properties-common

# node.js 8.x
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN apt-get install nodejs -y
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -y
RUN apt-get install yarn libnotify-bin notify-osd build-essential -y
RUN npm -v
RUN node -v
RUN yarn --version
RUN yarn global add ciao-deploy anchor-cli

# chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome*.deb; exit 0
RUN apt-get install -f -y
RUN rm -f google-chrome*.deb
RUN google-chrome --version

# php7
RUN ciao-deploy --command=env --base --php --composer --withoutSudo

CMD ["sh", "-c", "tail -f /dev/null"]