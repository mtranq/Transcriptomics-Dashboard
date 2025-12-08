# Transcriptomic Dashboard

### This is a bulk RNA Seq analysis Dashboard of TCGA-BRCA samples comparing tumor to normal pairs using DESeq2. It begins with exploratory and correlational analysis of the samples. It also involves downstream pathway analysis of the ranked genes after deseq analysis. The dashboard is built on flexdashboard (R markdown) with a R shiny runtime in the background.  

1. Once file is cloned or downloaded, open up **Transcriptomic Dashboard (RShiny).Rproj**
2. Then open **RNASeq_Flexdashboard.Rmd** in the project
3. In the R console, install renv by entering:
```r
install.packages("renv")
```
6. Then activate the **manifest.json** by entering:
```r
   renv::init()
   renv::restore(lockfile = "manifest.json")
```
8. Once that is loaded, you can run the dashboard by entering:
```r
   rmarkdown::run("RNASeq_Flexdashboard.Rmd")
```
*This should load up the dashboard in a different window.*

#### Please note upon initial run, the dashboard will not have any samples selected. To load up the dashboard with samples, you can use the dropdown to select cases by ID 

#### Please note that the analysis is computationally heavy so it will take 30 seconds to 2 minutes depending on how many samples have been put in for the subsequent pages after the "Overview" to load up. So "Differentially Expressed Genes" and "Hallmark Pathway" will take some time to load so remain on the page as the information and filters will be able to be used after it is loaded.
