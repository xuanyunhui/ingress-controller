FROM golang:1.13.8
MAINTAINER gxthrj@163.com

WORKDIR /go/src/github.com/iresty/ingress-controller
COPY . .
RUN mkdir /opt/ingress-controller \
    && go env -w GOPROXY=https://goproxy.io,direct \
    && export GOPROXY=https://goproxy.io \
    && go build -o /opt/ingress-controller/ingress-controller \
    && mv /go/src/github.com/iresty/ingress-controller/build.sh /opt/ingress-controller/ \
    && mv /go/src/github.com/iresty/ingress-controller/conf.json /opt/ingress-controller/ \
    && rm -rf /go/src/github.com/iresty/ingress-controller \
    && rm -rf /etc/localtime \
    && ln -s  /usr/share/zoneinfo/Hongkong /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && chmod g+ws /opt/ingress-controller

WORKDIR /opt/ingress-controller

EXPOSE 8080
RUN chmod +x ./build.sh
CMD ["/opt/ingress-controller/build.sh"]
