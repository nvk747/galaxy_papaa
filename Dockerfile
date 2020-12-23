# Galaxy - papaa

FROM bgruening/galaxy-stable:20.05

MAINTAINER nvk747, nvk747@gmail.com

# Enable Conda dependency resolution
ENV GALAXY_CONFIG_BRAND="papaa" \
    GALAXY_CONFIG_CONDA_AUTO_INSTALL=True

COPY config/papaa.yml $GALAXY_ROOT/tools.yaml
RUN install-tools $GALAXY_ROOT/tools.yaml && \
    /tool_deps/_conda/bin/conda clean --tarballs --yes > /dev/null && \
    rm /export/galaxy-central/ -rf && \
    mkdir -p $GALAXY_HOME/workflows

# Import workflows (local and from training) and data manager description, install the data libraries and the workflows
COPY config/workflows/* $GALAXY_HOME/workflows/
COPY config/data_library.yaml $GALAXY_ROOT/data_library.yaml
COPY install-workflows /usr/bin/
COPY install-libraries /usr/bin/
ENV GALAXY_CONFIG_TOOL_PATH=/galaxy-central/tools/
RUN install-workflows $GALAXY_HOME/workflows/ --publish_workflows
RUN install-libraries $GALAXY_ROOT/data_library.yaml
