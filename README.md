# anki-sync-server

Custom Anki server

## Building and pushing the image

```
 docker build . --build-arg ANKI_VERSION=24.06.3 -t <USERNAME>/anki-sync-server:24.06.3
 docker login -u <USERNAME> docker.io
 docker push <USERNAME>/anki-sync-server:24.06.3
```
