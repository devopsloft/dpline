FROM python:3

ENV TZ=Asia/Jerusalem

ADD . /

RUN apt-get update && \
    apt-get -y install cron && \
    pip3 install --upgrade pip && \
    pip3 install -r requirements.txt

COPY ./cronpy /etc/cron.d/cronpy

CMD cron -f
