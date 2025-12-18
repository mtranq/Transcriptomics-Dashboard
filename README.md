# 🧬Transcriptomics Dashboard
## Interactive RNA-seq Analysis & Visualization Dashboard

### 📌 Project Overview
This project is an interactive transcriptomics dashboard designed to explore, analyze, and visualize RNA-seq gene expression data from publicly available datasets.

The dashboard enables users to:
* Explore clinical metadata
* Identify differentially expressed genes
* Visualize results interactively without writing code
* Generate biologically interpretable insights from transcriptomic data

This project demonstrates applied skills in bioinformatics analysis, data visualization, reproducible research, and translational interpretation.

**Please note that the analysis is computationally heavy so it will take 30 seconds to 2 minutes depending on how many samples have been put in for the subsequent pages after the "Overview" to load up. So "Differentially Expressed Genes" and "Hallmark Pathway" will take some time to load so remain on the page as the information and filters will be able to be used after it is loaded.**
________________________________________
### 🎯 Scientific / Analytical Objective
The primary goal of this project is to:
Identify transcriptional differences between biological conditions (normal vs tumor) and enable interactive exploration of gene-level and pathway-level changes.

This mirrors real-world workflows used in:
* Translational research
* Precision medicine
________________________________________
### 🧪 Dataset
* Source: TCGA-BRCA
* Data type: Processed gene expression counts + sample metadata
* Organism: Human
* Experimental context: The **TCGA Breast Invasive Carcinoma (TCGA-BRCA)** project is part of The Cancer Genome Atlas (TCGA), a large-scale initiative aimed at characterizing the molecular landscape of human cancers using multi-omics profiling.

This project focuses on primary breast cancer tumors and matched adjacent normal breast tissue obtained from the same patients.
________________________________________
### 🔬 Methods Summary
The analysis follows a standard RNA-seq workflow:
1. Data preprocessing
   * Filtering low-expressed genes
   * Normalization/Transformation

2. Exploratory data analysis
   * Expression distributions
   * Sample-level comparisons

3. Differential expression analysis
   * Statistical modeling using Bioconductor tools

4. Interactive visualization
   * Density plots
   * Violin Plots
   * Volcano plots
   * Gene set enrichment plots
   * Summary tables

All results are accessible through an interactive dashboard.

________________________________________
### 🖥️ Dashboard Features
* 🔍 Sample search: Query samples of interest
* 📊 Differential expression visualization
* 📈 Interactive plots (zoom, filter, hover)
* 📥 Downloadable results/tables
* 📖 In-app guidance explaining plots and metrics

Designed for non-computational users such as biologists and clinicians.
________________________________________
### 🧰 Tech Stack
Bioinformatics & Data Science
* R
* Bioconductor
  * DESeq2
  * apeglm
  * ComplexHeatmap
  * fgsea
  * TCGAbiolinks
* tidyverse
* dplyr

Visualization & UI
* Shiny/flexdashboard
* ggplot2
* plotly
* DT
* enrichR

Reproducibility & Tooling
* Git & GitHub
* renv
* Docker (optional enhancement)
________________________________________
### 🚀 How to Run Locally
1️. Clone the repository
```bash
git clone https://github.com/mtranq/Transcriptomics-Dashboard.git
cd Transcriptomics-Dashboard
```
2️. Install renv package
```r
install.packages("renv")
```
3. Install dependencies
```r
renv::init()
renv::restore(lockfile = "manifest.json")
```
4. Launch the Dashboard
```r
rmarkdown::run("RNASeq_Flexdashboard.Rmd")
```
*This should load up the dashboard in a different window.*

**Please note upon initial run, the dashboard will not have any samples selected. To load up the dashboard with samples, you can use the dropdown to select cases by ID** 
___
### 📊 Example Results & Biological Insights
Key observations from this dataset include:
* Identification of significantly differentially expressed genes
* Enrichment of pathways related to signal transduction, metabolism, immune response, and cellular state
* Clear transcriptional separation between experimental conditions

These results demonstrate how transcriptomic data can support biological hypothesis generation and translational decision-making.
___
### 🧠 Skills Demonstrated
✔ RNA-seq data analysis
✔ Statistical modeling for differential expression
✔ Interactive data visualization
✔ Reproducible research practices
✔ Translational interpretation of omics data
___
### 👤 Author
Marvel Tranquille

Bioinformatics & Data Science/Analytics

https://www.linkedin.com/in/marvel-tranquille/

https://github.com/mtranq
