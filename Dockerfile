FROM python:latest

EXPOSE 27701

ENV VERSION=2.1.61
ENV SYNC_HOST=0.0.0.0
ENV SYNC_PORT=27701
ENV SYNC_BASE=/syncserver

RUN python3 -m venv /syncserver
RUN /syncserver/bin/pip install -U anki
CMD /syncserver/bin/python -m anki.syncserver
