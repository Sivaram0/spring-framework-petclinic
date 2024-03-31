FROM amazoncorretto:17-alpine-jdk

EXPOSE 8090
# make this non root
CMD [ "java", "-jar", "petclinic.war" ]