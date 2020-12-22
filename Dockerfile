# Galaxy - papaa

FROM bgruening/galaxy-stable:20.05

MAINTAINER nvk747, nvk747@gmail.com

ENV GALAXY_CONFIG_BRAND=PAPAA

ADD papaa.yml $GALAXY_ROOT/tools.yaml
RUN install-tools $GALAXY_ROOT/tools.yaml && \
    /tool_deps/_conda/bin/conda clean --tarballs --yes > /dev/null && \
    rm /export/galaxy-central/ -rf && \
    mkdir -p $GALAXY_HOME/workflows

# Import workflows (local and from training) and data manager description, install the data libraries and the workflows
COPY config/workflows/* $GALAXY_ROOT/workflows/
COPY config/data_library.yaml $GALAXY_ROOT/data_library.yaml
ENV GALAXY_CONFIG_TOOL_PATH=/galaxy-central/tools/
RUN startup_lite && \
    galaxy-wait && \
    workflow-install --workflow_path $GALAXY_ROOT/workflows/ -g http://localhost:8888 -u $GALAXY_DEFAULT_ADMIN_USER -p $GALAXY_DEFAULT_ADMIN_PASSWORD
    setup-data-libraries -i $GALAXY_ROOT/data_library.yaml -g http://localhost:8888 -u $GALAXY_DEFAULT_ADMIN_USER -p $GALAXY_DEFAULT_ADMIN_PASSWORD
