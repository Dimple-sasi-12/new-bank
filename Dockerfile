FROM maven AS build
WORKDIR /test
COPY . /test
RUN mvn clean install -DskipTests

FROM tomcat
# RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /test/target/bankapp-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD [ "catalina.sh", "run" ]