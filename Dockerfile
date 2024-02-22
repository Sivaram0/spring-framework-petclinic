FROM amazoncorretto:17-alpine-jdk

EXPOSE 8080
# make this non root
CMD [ "java", "-jar", "/spring-petclinic-3.2.0-SNAPSHOT.jar" ]