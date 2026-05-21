FROM eclipse-temurin:21-jdk

LABEL author="திருமால்"
LABEL maintainer="Thirumal"

# Create user/group
RUN groupadd -r thirumal && useradd -r -g thirumal thirumal

ENV APPROOT="/eureka-server-0.0.1-SNAPSHOT"
ARG DEPENDENCY=target/dependency

# Copy application files
COPY ${DEPENDENCY}/BOOT-INF/lib ${APPROOT}/lib
COPY ${DEPENDENCY}/META-INF ${APPROOT}/META-INF
COPY ${DEPENDENCY}/BOOT-INF/classes ${APPROOT}

# Set ownership
RUN chown -R thirumal:thirumal ${APPROOT}

USER thirumal:thirumal

WORKDIR ${APPROOT}

ENTRYPOINT ["java","-cp",".:lib/*","in.thirumal.EurekaServerApplication"]