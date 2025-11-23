FROM openanalytics/r-ver:4.4.1
#or can use rocker/r-ver:4.4.1 or rocker/shiny?
RUN apt-get update && apt-get install --no-install-recommends -y \
    pandoc \
    pandoc-citeproc \
    libxt6 \
    libcurl4-openssl-dev \
    libxml2-dev \
    libssl-dev \
    libz-dev \
    libgit2-dev \
    libhdf5-dev \
    libglpk-dev \ 
    && rm -rf /var/lib/apt/lists/*
# Install R packages
RUN R -q -e "install.packages(c('shiny','rmarkdown','flexdashboard','fst','janitor','dplyr','magrittr','ggplot2','ggpubr','tidyverse','enrichR','RColorBrewer','plotly','DT','reshape2','cluster','factoextra','highcharter','bslib','circlize','shinyWidgets'))"
RUN R -q -e "if (!requireNamespace('BiocManager', quietly=TRUE)) install.packages('BiocManager')"
RUN R -q -e "BiocManager::install(c('fgsea','DESeq2','enrichplot','ComplexHeatmap'))"
#Create Directories
RUN mkdir /app
WORKDIR /app
#these are whre the volumes will be mounted, respectively
RUN mkdir /app/data /app/www
#Upload Rmd file
COPY Organoid_RNASeq_Flexdashboard_shortened.Rmd .
#Pre-render the Rmd file (to save loading time) MAYBE NOT POSSIBLE
RUN R -q -e "rmarkdown::render('Organoid_RNASeq_Flexdashboard_shortened.Rmd')"
ENV RMARKDOWN_RUN_PRERENDER=0
#Expose port
EXPOSE 3838
RUN groupadd -g 1000 shiny && useradd -c 'shiny' -u 1000 -g 1000 -m -d /home/shiny -s /sbin/nologin shiny
USER shiny

CMD R -q -e "rmarkdown::run(file = 'Organoid_RNASeq_Flexdashboard.Rmd', shiny_args = list(port = 3838, host = '0.0.0.0'))"