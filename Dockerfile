FROM ubuntu:16.04
WORKDIR /tmp
ENV main_path=/tmp
RUN apt-get update -qq && apt-get install -qq && \
    apt-get -y install build-essential git mercurial cmake libpng-dev libjpeg-dev libtiff-dev libglu1-mesa-dev && \
    hg clone https://bitbucket.org/eigen/eigen#3.2 && \
    mkdir eigen_build && cd /tmp/eigen_build && \
    cmake . ../eigen && make && make install && \
    cd /tmp && rm -rf eigen eigen_build && \
    apt-get -y install libboost-iostreams-dev libboost-program-options-dev libboost-system-dev libboost-serialization-dev && \
    apt-get -y install libopencv-dev && \
    apt-get -y install libcgal-dev libcgal-qt5-dev && \
    git clone https://github.com/cdcseacave/VCG.git vcglib && \
    apt-get -y install libatlas-base-dev libsuitesparse-dev && \
    git clone https://ceres-solver.googlesource.com/ceres-solver ceres-solver && \
    mkdir ceres_build && cd ceres_build && \
    cmake . ../ceres-solver/ -DMINIGLOG=ON -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF && \
    make -j2 && make install && \
    cd /tmp && rm -rf ceres-solver ceres_build && \
    apt-get -y install freeglut3-dev libglew-dev libglfw3-dev && \
    git clone https://github.com/cdcseacave/openMVS.git openMVS && \
    mkdir openMVS_build && cd openMVS_build && \
    cmake . ../openMVS -DCMAKE_BUILD_TYPE=Release -DVCG_DIR="$main_path/vcglib" && \
    make -j2 && make install && \
    cd /tmp && rm -rf openMVS openMVS_build && \ 
    apt-get -y purge build-essential git mercurial cmake && \
    apt-get -y autoremove --purge 