FROM matrixdotorg/synapse:latest
ENV SYNAPSE_SERVER_NAME=synapse-production-6d86.up.railway.app
ENV SYNAPSE_REPORT_STATS=yes
EXPOSE 8008
COPY ./homeserver.yaml /data/homeserver.yaml
