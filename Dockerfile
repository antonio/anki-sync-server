FROM python:latest

EXPOSE 27701

ENV VERSION=2.1.61
ENV SYNC_HOST=0.0.0.0
ENV SYNC_PORT=27701
ENV SYNC_BASE=/syncserver

# RUN apt-get update && apt-get install -y \
#   curl zstd

# RUN curl -L https://github.com/ankitects/anki/releases/download/${VERSION}/anki-${VERSION}-linux-qt5.tar.zst -o anki-${VERSION}-linux-qt6.tar.zst
# RUN tar xaf anki-${VERSION}-linux-qt5.tar.zst
# RUN cd anki-${VERSION}-linux-qt5

# CMD SYNC_USER1=${SYNC_USER1} /anki-${VERSION}-linux-qt6/anki --syncserver

RUN python3 -m venv /syncserver
RUN /syncserver/bin/pip install -U anki
CMD /syncserver/bin/python -m anki.syncserver
