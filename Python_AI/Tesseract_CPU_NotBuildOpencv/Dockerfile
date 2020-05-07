## Cache image
FROM ubuntu:18.04 as cache-image

## Install dependencies
RUN apt-get update && \
    apt-get install -y tesseract-ocr-vie tesseract-ocr-epo libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6 libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libgtk2.0-dev build-essential pkg-config python-dev libhunspell-dev pciutils wget python3-pip software-properties-common cmake unzip libjpeg-dev libpng-dev libtiff-dev libxvidcore-dev libx264-dev libgtk-3-dev libatlas-base-dev gfortran && \
    rm -rf /var/lib/apt/lists/*
RUN add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main" && \
    apt update && \
    apt-get install -y libjasper-dev

## Install opencv
RUN pip3 install opencv-contrib-python

## Install tools
RUN pip3 install pytesseract
RUN pip3 install imutils
RUN pip3 install hunspell

## Deploy image
FROM cache-image as deploy-image
WORKDIR /usr/src/app
COPY . /usr/src/app