FROM python:3

ADD . /

RUN pip3 install -r /requirements.lock

ENV PATH="/usr/local/bin:${PATH}"

ENTRYPOINT [ "/app.py" ]