# Galaxy - papaa

FROM bgruening/galaxy-stable:20.05

MAINTAINER nvk747, nvk747@gmail.com

# Enable Conda dependency resolution
ENV GALAXY_CONFIG_BRAND="papaa" \
    GALAXY_CONFIG_CONDA_AUTO_INSTALL=True

# Install tools, cleanup
COPY config/papaa.yml $GALAXY_ROOT/tools.yaml
RUN install-tools $GALAXY_ROOT/tools.yaml && \
    /tool_deps/_conda/bin/conda clean --tarballs --yes > /dev/null && \
    rm /export/galaxy-central/ -rf && \
    mkdir -p $GALAXY_HOME/build_assets/workflows && \
    mkdir -p $GALAXY_HOME/build_assets/data_libraries

ENV GALAXY_CONFIG_TOOL_PATH=/galaxy-central/tools/

# Import workflows, cleanup
COPY config/bin/install-workflows /usr/bin/
COPY config/workflows/* $GALAXY_HOME/build_assets/workflows/
RUN install-workflows $GALAXY_HOME/build_assets/workflows/ --publish_workflows && \
    rm -rf /export/galaxy-central/

# Import libraries, preserve datasets, cleanup
COPY config/bin/install-libraries /usr/bin/
COPY config/data_library.yaml $GALAXY_HOME/build_assets/data_libraries/data_library.yaml
RUN install-libraries $GALAXY_HOME/build_assets/data_libraries/data_library.yaml && \
    rm -f /export/galaxy-central/database/files/url_paste* && \
    mkdir -p $GALAXY_ROOT/database/files && \
    mv /export/galaxy-central/database/files/* $GALAXY_ROOT/database/files/ && \
    rm -rf /export/galaxy-central/

# Container Style
ADD assets/galaxy_papaa_logo.png $GALAXY_CONFIG_DIR/web/welcome_image.png
ADD assets/welcome.html $GALAXY_CONFIG_DIR/web/welcome.html
