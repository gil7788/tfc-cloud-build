FROM alpine
COPY run.sh /
RUN chmod +x /run.sh
CMD ["/run.sh"]
