# Start with JupyterHub image.
ARG BASE_IMAGE=hub-5.2.0
FROM quay.io/jupyter/base-notebook:$BASE_IMAGE

LABEL maintainer="James Gebbie-Rayet <james.gebbie@stfc.ac.uk>"

# Root to install "rooty" things.
USER root

# Update the OS and install software dependencies
# needing root.
RUN apt-get update && apt-get -yq dist-upgrade \
 && apt-get install -yq --no-install-recommends \
    bzip2 \
    cmake \
    curl \
    sed \
    gcc \
    gfortran \
    git \
    g++ \
    nano \
    make \
    openssh-client \
    rsync \
    vim \
    wget \
    xz-utils \
    zlib1g-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Modified index for matomo metrics.
#COPY --chown=1000:100 index.html /opt/conda/share/jupyter/lab/static/index.html

# Switch to jovyan user.
USER $NB_USER
WORKDIR $HOME

# Remove work directory as it not required.
RUN rm -r $HOME/work

# Change the loooong default terminal string
RUN echo 'export PS1="\u:\W\$ "' >> /home/jovyan/.bashrc

# Always finish with non-root user as a precaution.
USER $NB_USER
