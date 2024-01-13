FROM alpine:3.19.0

RUN apk update && apk add git

WORKDIR /output
COPY project_setup.sh /setup_intern_s.sh
RUN chmod +x /setup_intern_s.sh

ENTRYPOINT ["/setup_intern_s.sh"]
CMD [ ]