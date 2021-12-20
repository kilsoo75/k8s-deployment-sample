FROM dedicatedprodacr.azurecr.io/library/tomcat:8.5.24-jre8

RUN set -eux; \
    apt-get update; \
    apt-get install -y vim wget net-tools procps curl locales

RUN mkdir -p /app/aims-web

WORKDIR /usr/local/tomcat

# tomcat config file copy
COPY assets/tomcat8.5/conf/context.xml ./conf/context.xml
COPY assets/tomcat8.5/conf/server.xml ./conf/server.xml
COPY assets/tomcat8.5/conf/logging.properties ./conf/logging.properties

# mssql library copy
COPY assets/tomcat8.5/lib/mssql-jdbc-6.2.2.jre8.jar ./lib/mssql-jdbc-6.2.2.jre8.jar

# aims-web classes copy
COPY assets/webapps /app/aims-web

# locale set up
#RUN locale-gen ko_KR.UTF-8
#RUN localedef -f UTF-8 -i ko_KR ko_KR.UTF-8
#ENV LC_ALL ko_KR.UTF-8
#RUN localedef -f UTF-8 -i ko_KR ko_KR.EUC-KR
#ENV LC_ALL ko_KR.EUC-KR

# timezone set up
ENV TZ Asia/Seoul

EXPOSE 80

CMD ["catalina.sh", "run"]
