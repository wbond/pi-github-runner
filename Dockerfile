FROM rdogtech/github-runner-pi-base

RUN sudo apt-get update \
  && sudo apt-get install -y --no-install-recommends \
    python3-dev \
    python3-pip \
    python3-coverage \
    python \
    python-dev \
    python-coverage \
  && sudo rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/*

RUN curl -s -L -O https://bootstrap.pypa.io/pip/2.7/get-pip.py \
  && sudo python2 get-pip.py \
  && rm get-pip.py
