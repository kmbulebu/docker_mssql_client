FROM ubuntu:xenial

# Install packages
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    apt-transport-https \
    curl \
    ca-certificates \
    locales \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean -y

 # Setup locale
RUN locale-gen en_US.UTF-8 \
  && echo "LANG=en_US.UTF-8" >> /etc/default/locale
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

# Install MS SQL command line tools
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
  && curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/msprod.list \
  && apt-get update -y \
  && ACCEPT_EULA=Y apt-get install unixodbc-dev Rmssql-tools -y \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean -y

# Add it to the PATH
ENV PATH=$PATH:/opt/mssql-tools/bin

COPY entrypoint.sh /usr/local/bin

# Add our entry point script
ENTRYPOINT /usr/local/bin/entrypoint.sh
