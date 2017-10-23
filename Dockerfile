FROM debian:jessie
MAINTAINER Jeroen van Rhee <jeroen.vanrhee@kpn.com>

RUN apt-get update -qq && apt-get install -y \
    wget \
    gnupg2

RUN wget -qO - https://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/Debian_8.0/Release.key | apt-key add -
RUN echo 'deb http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/Debian_8.0 ./' | tee --append /etc/apt/sources.list.d/syslog-ng-obs.list

RUN apt-get update -qq && apt-get install -y \
    syslog-ng

ADD openjdk-libjvm.conf /etc/ld.so.conf.d/openjdk-libjvm.conf
RUN ldconfig

RUN groupadd -g 601 abdsl && useradd -u 1723 -G abdsl -M -s /usr/sbin/nologin abxdsl

EXPOSE 514/udp
EXPOSE 601/tcp
EXPOSE 6514/tcp

ENTRYPOINT ["/usr/sbin/syslog-ng", "-F"]

