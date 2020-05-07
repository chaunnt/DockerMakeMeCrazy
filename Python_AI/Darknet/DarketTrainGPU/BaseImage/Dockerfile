## Cache image
FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04 as cache-image
WORKDIR /root

## Install dependencies
RUN apt-get update
RUN apt-get install -y tesseract-ocr-vie tesseract-ocr-epo libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6 libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libgtk2.0-dev build-essential pkg-config python-dev libhunspell-dev pciutils wget python3-pip software-properties-common cmake unzip libjpeg-dev libpng-dev libtiff-dev libxvidcore-dev libx264-dev libgtk-3-dev libatlas-base-dev gfortran && \
    rm -rf /var/lib/apt/lists/*
RUN add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main" && apt update && apt-get install -y libjasper-dev

## Install opencv
RUN pip3 install -U pip numpy
RUN pip install -U pip numpy xgboost
RUN wget -O opencv.zip https://github.com/opencv/opencv/archive/4.2.0.zip && \
    wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.2.0.zip
RUN unzip opencv.zip && mv opencv-4.2.0 opencv && rm -f opencv.zip && \
    unzip opencv_contrib.zip && mv opencv_contrib-4.2.0 opencv_contrib && rm -f opencv_contrib.zip
RUN cd opencv && \
    mkdir build && \
    cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D OPENCV_GENERATE_PKGCONFIG=YES \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D WITH_CUDA=ON \
    -D WITH_CUDNN=ON \
    -DCUDA_ARCH_BIN=5.3,6.0,6.1,7.0,7.5 \
    -DCUDA_ARCH_PTX=7.5 \
    -D OPENCV_DNN_CUDA=ON \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D BUILD_EXAMPLES=OFF ..  && \
    make -j8 && \
    make install && \
    ldconfig 

## Install tools
RUN pip3 install pytesseract
RUN pip3 install imutils
RUN pip3 install hunspell

## Build darknet
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git libopencv-dev
RUN git clone --branch Yolo_v3 --depth 1 https://github.com/AlexeyAB/darknet.git
COPY darknet-Makefile darknet/Makefile 
RUN cd darknet && make
# COPY darknet53.conv.74 darknet/build/darknet/x64/darknet53.conv.74
RUN cd darknet/build/darknet/x64/ && wget https://pjreddie.com/media/files/darknet53.conv.74
