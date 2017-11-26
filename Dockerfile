#
# Install basic system with Qt 5.9 and essential build tools
#
FROM ubuntu:xenial as basic-qt

RUN apt-get update -qq \
    && apt-get -y install --no-install-recommends \
        binutils \
        g++ \
        git \
        make \
        software-properties-common

RUN add-apt-repository --yes ppa:beineri/opt-qt593-xenial \
    && apt-get update -qq \
    && apt-get -y install --no-install-recommends \
        qt59base \
        qt59declarative \
        qt59script \
        qt59serialport \
        qt59tools \
    && rm -rf /opt/qt59/examples

ENV QT_BASE_DIR=/opt/qt59
ENV PATH="${QT_BASE_DIR}/bin:${PATH}" \
    LD_LIBRARY_PATH="${QT_BASE_DIR}/lib/x86_64-linux-gnu:${QT_BASE_DIR}/lib:${LD_LIBRARY_PATH}" \
    PKG_CONFIG_PATH="${QT_BASE_DIR}/lib/pkgconfig:${PKG_CONFIG_PATH}"

#
# Build and install qbs and clean up the left-overs
#
FROM basic-qt as qbs-builder
RUN apt-get -y install \
        libgl1-mesa-dev


RUN git clone --depth 1 -b v1.9.1 https://github.com/qbs/qbs.git qbs-build-dir \
    && cd qbs-build-dir \
    && qmake -r qbs.pro \
        CONFIG+=qbs_no_dev_install  \
        CONFIG+=release CONFIG-=debug \
        QBS_INSTALL_PREFIX=/ \
    && make -j5 \
    && make install INSTALL_ROOT=/opt/qbs


#
# Resulting environment with Qbs but without the build layer.
#
FROM basic-qt as qbs-build-environment
LABEL Description="Ubuntu development environment with Qt 5.9 and Qbs."

COPY --from=qbs-builder /opt/qbs /opt/qbs
ENV PATH="/opt/qbs/bin:${PATH}"

RUN qbs setup-toolchains --detect \
    && qbs setup-qt ${QT_BASE_DIR}/bin/qmake qt5 \
    && qbs config defaultProfile qt5 \
    && qbs config profiles.qt5.qbs.architecture x86_64

ENTRYPOINT ["/opt/qbs/bin/qbs"]