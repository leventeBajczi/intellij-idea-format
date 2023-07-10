FROM rycus86/intellij-idea:2023.1.2

USER root

COPY format.sh /format.sh
RUN chmod +x /format.sh

ENTRYPOINT ["/format.sh"]
