FROM ubuntu:16.04
MAINTAINER Ciao Chung

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y \
  && apt-get install -y wget curl \
  && apt-get install -y --assume-yes apt-utils net-tools iputils-ping \
  && apt-get install -y software-properties-common \
  && curl -sL https://deb.nodesource.com/setup_10.x | bash \
  && apt-get install nodejs -y \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -y \
  && apt-get install yarn libnotify-bin notify-osd build-essential -y \
  && yarn global add ciao-deploy apidoc \
  && ciao-deploy --command=env --base --php --composer --withoutSudo \
  && yarn global remove ciao-deploy anchor-cli

CMD ["sh", "-c", "tail -f /dev/null"]