FROM alpine
COPY run.sh /
RUN chmod +x /run.sh

COPY environments/config.sh /environments/
RUN chmod +x /environments/config.sh
CMD ["/run.sh"]
