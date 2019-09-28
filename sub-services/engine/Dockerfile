FROM python:3

ADD . /

RUN pip3 install --upgrade pip && \
    pip install -r requirements.txt

CMD [ "python", "./main.py" ]
