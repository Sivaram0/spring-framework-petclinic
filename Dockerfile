FROM amazoncorretto:17-alpine-jdk
COPY --from=build /springpetclinic/target/spring-petclinic-3.2.0-SNAPSHOT.jar /spring-petclinic-3.2.0-SNAPSHOT.jar
EXPOSE 8080
# make this non root
CMD [ "java", "-jar", "/spring-petclinic-3.2.0-SNAPSHOT.jar" ]