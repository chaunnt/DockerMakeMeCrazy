FROM ubuntu:18.04
MAINTAINER ChauNNT <chaupad@gmail.com> 

RUN echo "Update container"
RUN apt-get update

RUN echo "start making qt, refer https://wiki.qt.io/Building_Qt_5_from_Git"
RUN echo "apt-get build-dep"
RUN apt-get install -y libxcb-xinerama0-dev 

RUN echo "Build essentials"
RUN apt-get install -y build-essential perl python git wget

RUN echo "Qt WebKit"
RUN apt-get install -y flex bison gperf libicu-dev libxslt-dev ruby

RUN echo "Qt WebKit"
RUN apt-get install -y libssl-dev libxcursor-dev libxcomposite-dev libxdamage-dev libxrandr-dev libdbus-1-dev libfontconfig1-dev libcap-dev libxtst-dev libpulse-dev libudev-dev libpci-dev libnss3-dev libasound2-dev libxss-dev libegl1-mesa-dev gperf bison

RUN echo "Qt Multimedia"
RUN apt-get install -y libasound2-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev

RUN echo "I skipped QDoc Documentation Generator Tool, turn it On if you like it"

RUN echo "Go to http://download.qt.io and select a version you want"
RUN mkdir /inst && cd /inst && wget \
  http://download.qt.io/official_releases/qt/5.13/5.13.1/single/qt-everywhere-src-5.13.1.tar.xz

RUN mkdir /src && cd /src && tar -xvf /inst/qt-everywhere-src-5.13.1.tar.xz
RUN cd /src/qt-everywhere-src-5.13.1 && ./configure \											
  -confirm-license -opensource \
  -release \
  -skip qtlocation -skip qtwebchannel -skip qtwebengine -skip qtwebsockets -skip qtwebview -skip qtwayland \
  -nomake examples -nomake tests
RUN cd /src/qt-everywhere-src-5.13.1 && make
RUN cd /src/qt-everywhere-src-5.13.1 && make install
