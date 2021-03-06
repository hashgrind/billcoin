FROM ubuntu:20.04
COPY ./billcoin.conf /root/.billcoin/billcoin.conf
COPY . /billcoin
WORKDIR /billcoin
RUN apt update
RUN apt-get install -y build-essential libtool autotools-dev automake pkg-config bsdmainutils python3
RUN apt-get install -y libssl-dev libevent-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-test-dev libboost-thread-dev
RUN apt-get install -y libminiupnpc-dev
RUN apt-get install -y libzmq3-dev
RUN apt-get install -y libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler
RUN apt-get install -y libqrencode-dev
RUN ./contrib/install_db4.sh `pwd`
RUN ./autogen.sh
RUN export BDB_PREFIX='/billcoin/db4'
RUN ./configure BDB_LIBS="-L${BDB_PREFIX}/lib -ldb_cxx-4.8" BDB_CFLAGS="-I${BDB_PREFIX}/include"
RUN make
RUN make install
EXPOSE 9696
CMD ["billcoind", "--printtoconsole"]
