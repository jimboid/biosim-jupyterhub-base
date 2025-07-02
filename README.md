CCPBioSim Jupyterhub base container
===================================

[![base container](https://github.com/jimboid/biosim-jupyterhub-base/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/jimboid/biosim-jupyterhub-base/actions/workflows/build.yml)
[![tests](https://img.shields.io/badge/tests-manual-pink?logo=github)](https://github.com/jimboid/biosim-jupyterhub-base)
[![latest](https://img.shields.io/badge/dynamic/xml?url=https%3A%2F%2Fgithub.com%2Fjimboid%2Fbackage%2Fraw%2Findex%2Fjimboid%2Fbiosim-jupyterhub-base%2Fbiosim-jupyterhub-base.xml&query=xml%2Fversion%5B.%2Fnewest%5B.%3D%22true%22%5D%5D%2Ftags%5B.!%3D%22latest%22%5D&logo=github&label=latest&color=purple)](https://github.com/jimboid/biosim-jupyterhub-base)
[![size](https://img.shields.io/badge/dynamic/xml?url=https%3A%2F%2Fgithub.com%2Fjimboid%2Fbackage%2Fraw%2Findex%2Fjimboid%2Fbiosim-jupyterhub-base%2Fbiosim-jupyterhub-base.xml&query=xml%2Fsize&logo=github&label=size&color=orange)](https://github.com/jimboid/biosim-jupyterhub-base)
[![pulls](https://img.shields.io/badge/dynamic/xml?url=https%3A%2F%2Fgithub.com%2Fjimboid%2Fbackage%2Fraw%2Findex%2Fjimboid%2Fbiosim-jupyterhub-base%2Fbiosim-jupyterhub-base.xml&query=xml%2Fdownloads&logo=github&label=pulls&color=blue)](https://github.com/jimboid/biosim-jupyterhub-base)

This container is derived from the jupyter/base-notebook:hub image. We have
modified it to include some extra software utilities and web-services specific
to CCPBioSim and the training courses we offer.

A description of what is installed and how to use this base is below.

Container Contents
------------------

**Base image** quay.io/jupyter/base-notebook:hub

**Installed via apt**

  - bzip2
  - cmake
  - curl
  - sed
  - gcc
  - gfortran
  - git
  - g++
  - nano
  - make
  - openssh-client
  - rsync
  - vim
  - wget
  - xz-utils
  - zlib1g-dev


How to Use
----------

This container is not designed to be deployed by itself, as it has no notebooks
installed. It is designed to be used as a base container for other containers
which will contain training material and any specific software libraries that 
these notebooks use. This base image is already built and available on STFC
Harbor and to include it in your project you only need add the line::

    FROM ghcr.io/jimboid/biosim-jupyterhub-base:latest

to your Dockerfile. This will then pull this base container and build your
container on top of it. So you should add the code to copy files, install extra
software packages or do environment configuration as part of your own Dockerfile.

If you need to install software as root then you can change to the root user by
adding::

    USER root

to your dockerfile followed by the commands you need to run. You should always
try to aim to minimise the root operations by changing back to the default use
as soon you are finished operations that need privileges. Always end your
dockerfile by changing back to the default user regardless of whether it has
been done elsewhere in the dockerfile, this helps reduce mistakes.
You do this by::

    USER $NB_USER

A great deal of software packages can be installed via pip or conda which are 
both installed by the Jupyter maintainers.

Copying your notebook files is very simple. You should simply place your
notebooks in the same directory as the dockerfile and then include something
like::

    COPY --chown=1000:100 *.ipynb $HOME/
    COPY --chown=1000:100 data $HOME/data

The --chown part is important as this will change the ownership of your files
from the root user to the notebook user.

Ports
-----

In our containers we are using the JupyterHub default port 8888, so you should
forward this port when deploying locally::

    docker run -p 8888:8888 ghcr.io/jimboid/biosim-jupyterhub-base:latest

Contributing
------------

Whilst as a consortium we are open to contributions to our software tools. In
this case due to the fact that one of our services is built on top of this
container, we will be rigorous with defining what should and should not form
the base container. Suggestions and contributions are welcome, and they will be
scrutinised via review prior to acceptance.

