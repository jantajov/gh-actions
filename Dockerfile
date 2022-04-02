FROM gradle:7.4.2-jdk11 AS builder
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src

RUN gradle build

FROM openjdk:11
COPY --from=builder /home/gradle/src/build/libs/*.jar /app/gh-actions.jar

ENTRYPOINT ["java", "-jar", "/app/gh-actions.jar"]
