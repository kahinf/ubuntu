FROM ubuntu:14.04.3

# Copy all the static files into the container
ADD ./container/files /

# Copy the application source the /app directory
ADD . /app

# Produce a ready-to-run container
RUN /app/container/compile.sh