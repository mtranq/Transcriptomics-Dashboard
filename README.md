# Transcriptomic Dashboard

This is a bulk RNA Seq analysis Dashboard of TCGA-BRCA samples comparing tumor to normal pairs using DESeq2. It begins with exploratory and correlational analysis of the samples. It also involves downstream pathway analysis of the ranked genes after deseq analysis. The dashboard is built on flexdashboard (R markdown) with a R shiny runtime in the background.  

1. Once file is cloned or downloaded, open up .Rproj
2. Then open .Rmd in the project
3. In the R console, install renv by entering:
   install.packages("renv")
4. Then activate the manifest.json by entering:
   renv::init()
   renv::restore(lockfile = "manifest.json")
5. Once that is loaded, you can run the dashboard by entering:
   rmarkdown::run(".Rmd")
*This should load up the dashboard in a different window.*

### Please note upon initial run, the dashboard will not have any samples selected. To load up the dashboard with samples, you can use the dropdown to select cases by ID 

### Please note that the analysis is computationally heavy so it will take 30 seconds to 2 minutes depending on how many samples have been put in for the subsequent pages after the "Overview" to load up. So "Differentially Expressed Genes", "Hallmark Pathway", "Reactome Pathway", "KEGG Pathway", will take some time to load so remain on the page as the information and filters will be able to be used after it is loaded.***
