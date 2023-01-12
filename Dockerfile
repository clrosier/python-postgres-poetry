FROM python:3.8.13-slim-buster

LABEL maintainer="Cameron Rosier <rosiercam@gmail.com>"

RUN apt -y update && \
    apt install -y gcc libpq-dev && \
    python -m pip install poetry
