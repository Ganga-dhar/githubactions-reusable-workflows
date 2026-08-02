FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y python3 python3-pip curl

WORKDIR /app

COPY . .

RUN pip3 install -r requirements.txt

CMD ["python3","app.py"]