# Dockerfile for TCGA-BRCA RNASeq Flexdashboard Shiny App
# Base image: Rocker Shiny with R 4.4
FROM rocker/shiny:4.4

# Install system dependencies required for R packages
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libgit2-dev \
    libglpk-dev \
    libgmp3-dev \
    libmagick++-dev \
    pandoc \
    && rm -rf /var/lib/apt/lists/*

# Install BiocManager first
RUN R -e "install.packages('BiocManager', repos='https://cloud.r-project.org/')"

# Install CRAN packages
RUN R -e "install.packages(c( \
    'shiny', \
    'shinyWidgets', \
    'dplyr', \
    'ggplot2', \
    'tidyverse', \
    'janitor', \
    'flexdashboard', \
    'readxl', \
    'RColorBrewer', \
    'cluster', \
    'factoextra', \
    'plotly', \
    'highcharter', \
    'DT', \
    'bslib', \
    'sass', \
    'reshape2', \
    'enrichR', \
    'rmarkdown' \
), repos='https://cloud.r-project.org/')"

# Install Bioconductor packages
RUN R -e "BiocManager::install(c( \
    'ComplexHeatmap', \
    'DESeq2', \
    'fgsea', \
    'circlize', \
    'apeglm' \
), ask=FALSE, update=FALSE)"

# Install estimate package from R-Forge
RUN R -e "install.packages('estimate', repos='http://r-forge.r-project.org', dependencies=TRUE)"

# Create app directory
RUN mkdir -p /srv/shiny-server/app

# Copy application files
COPY RNASeq_Flexdashboard.Rmd /srv/shiny-server/app/
COPY data/ /srv/shiny-server/app/data/

# Set working directory
WORKDIR /srv/shiny-server/app

# Create a wrapper script to run the flexdashboard
RUN echo '#!/bin/bash\nR -e "rmarkdown::run(\"RNASeq_Flexdashboard.Rmd\", shiny_args=list(host=\"0.0.0.0\", port=3838))"' > /srv/shiny-server/app/run_app.sh \
    && chmod +x /srv/shiny-server/app/run_app.sh

# Expose port
EXPOSE 3838

# Run the flexdashboard app
CMD ["R", "-e", "rmarkdown::run('RNASeq_Flexdashboard.Rmd', shiny_args=list(host='0.0.0.0', port=3838))"]
