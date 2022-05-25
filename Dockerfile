FROM i386/ubuntu:trusty

ARG DSHOWURL="https://www.ime.usp.br/~gnann/dshow_nt.cab"

# instalação
RUN apt-get install -y software-properties-common \
 && add-apt-repository -y ppa:pipelight/stable \
 && apt-get update \
 && echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections \
 && apt-get -y install ttf-mscorefonts-installer  \
 && apt-get install --install-recommends -y libgtk2.0-0 pipelight-multi samba-libs xvfb \
 && apt-get -y purge firefox \
 && cp /usr/lib/i386-linux-gnu/libnetapi.so.0 /usr/lib/i386-linux-gnu/libnetapi.so \
 && rm -f /usr/bin/zenity \
 && pipelight-plugin --update \
 && sed -i "s|http://download.microsoft.com/download/8/0/D/80D7E79D-C0E4-415A-BCCA-E229EAFE2679/dshow_nt.cab|$DSHOWURL|" /usr/share/pipelight/install-dependency

# firefox 51
RUN wget -q https://ftp.mozilla.org/pub/firefox/releases/51.0/linux-i686/en-US/firefox-51.0.tar.bz2 -O/tmp/firefox.tar.bz2 \
 && tar xf /tmp/firefox.tar.bz2 -C /opt \
 && rm -f /opt/firefox/updater

# pipelight
ENV WINE=/opt/wine-staging/bin/wine
ENV WINEPREFIX=/root/.wine-pipelight
ENV QUIETINSTALLATION=1
RUN /usr/share/pipelight/install-dependency wine-mpg2splt-installer
RUN xvfb-run /usr/share/pipelight/install-dependency wine-silverlight5.1-installer \
 && pipelight-plugin --accept --enable silverlight5.1

ENTRYPOINT ["/opt/firefox/firefox", "--no-remote", "--private-window"]
