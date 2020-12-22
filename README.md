# galaxy_papaa
This repository is for installing and running a docker galaxy instance with pancancer aberrant pathway activity analysis (PAPAA) tools 
==================================

:whale: Galaxy Docker repository for PANCANCER ABERRANT PATHWAY ACTIVITY ANALYSIS (PAPAA)

# Installed tools

 * [PAPAA](https://github.com/nvk747/papaa)

# Requirements

 - [Docker](https://docs.docker.com/installation/) for Linux / Windows / OSX
 
 - [Kitematic](https://kitematic.com/) for Windows / OS-X (Optional)

# Usage

To launch papaa using DOCKER:

```
# pulling the galaxy_papaa docker image from Dockerhub
docker pull nvk747/galaxy_papaa:0.1.9

# run the galaxy_papaa container
docker run --publish 8888:80 --detach nvk747/galaxy_papaa:0.1.9

# view the galaxy_papaa instance in web browser
open: http://localhost:8888/ in a new window and use papaa tools

#stoping the container
docker stop containerID
```

For more details about this command line or specific usage, please consult the
[`README`](https://github.com/bgruening/docker-galaxy-stable/blob/master/README.md) of the main Galaxy Docker image, on which the current image is based.

# Contributors
 - Vijay Nagampalli
 
 - Daniel Blankenberg

# History

 - 0.1.0: First release!

# Support & Bug Reports

You can file an [github issue](https://github.com/nvk747/papaa/issues). 
