FROM debian:bookworm-slim

ARG IDEA_BUILD=2026.1.1

RUN apt-get update -qq \
 && apt-get install -qq --no-install-recommends -y \
      curl ca-certificates \
      libfreetype6 libfontconfig1 libxtst6 libxext6 libxrender1 libxslt1.1 libxxf86vm1 \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/idea
RUN curl -fsSL "https://download.jetbrains.com/idea/idea-${IDEA_BUILD}.tar.gz" \
    | tar --strip-components=1 -xz

COPY --chmod=755 format.sh /format.sh
ENTRYPOINT ["/format.sh"]
