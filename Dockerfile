FROM debian

RUN  \
  apt-get update -qq && apt-get install -qq --no-install-recommends -y \
  default-jdk gcc git openssh-client less curl \
  libxtst-dev libxext-dev libxrender-dev libfreetype6-dev \
  libfontconfig1 libgtk2.0-0 libxslt1.1 libxxf86vm1 \
  && rm -rf /var/lib/apt/lists/* \
  && useradd -ms /bin/bash developer
  
ARG IDEA_VERSION=2025.3
ARG IDEA_BUILD=2025.3.1
ARG idea_local_dir=.Idea${IDEA_VERSION}

WORKDIR /opt/idea

RUN echo "Preparing IntelliJ IDEA ${IDEA_BUILD} ..." \
  && export idea_source=https://download.jetbrains.com/idea/idea-${IDEA_BUILD}.tar.gz \
  && echo "Downloading ${idea_source} ..." \
  && curl -fsSL $idea_source -o /opt/idea/installer.tgz \
  && tar --strip-components=1 -xzf installer.tgz \
  && rm installer.tgz

USER developer
ENV HOME=/home/developer

RUN mkdir /home/developer/.Idea \
  && ln -sf /home/developer/.Idea /home/developer/$idea_local_dir

USER root

COPY format.sh /format.sh
RUN chmod +x /format.sh

ENTRYPOINT ["/format.sh"]
