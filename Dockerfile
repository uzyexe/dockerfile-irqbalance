FROM debian:jessie
ENV VERSION 1.1.0
RUN apt-get update -qq && \
    apt-get install -qy curl build-essential dh-autoreconf pkg-config
RUN mkdir /src
WORKDIR /src
RUN curl https://codeload.github.com/Irqbalance/irqbalance/tar.gz/v${VERSION} | tar xzf -
RUN ln -s irqbalance-${VERSION} irqbalance
WORKDIR /src/irqbalance
RUN ./autogen.sh
RUN ./configure --enable-static
RUN make
RUN cp irqbalance /
RUN apt-get --purge remove -y curl build-essential dh-autoreconf pkg-config && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/*
