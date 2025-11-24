#Download and Preprocessing of TCGA BRCA count and col Data

#libraries
library(TCGAbiolinks)
library(biomaRt)
library(dplyr)

#Download GDC data
query <- GDCquery(
    project = "TCGA-BRCA",
    data.category = "Transcriptome Profiling",
    data.type = "Gene Expression Quantification",
    workflow.type = "STAR - Counts"
)
GDCdownload(query = query)
query <- GDCprepare(query = query)
saveRDS(query, file = "data/TCGA_BRCA_counts.rds")

query<-readRDS(file = "data/TCGA_BRCA_counts.rds")
cnts<-as.data.frame(assay(query))
genes<-rownames(cnts)
rna_ids <- gsub("\\..*$", "", genes)
mart <- useMart("ensembl", dataset = "hsapiens_gene_ensembl")
mapping <- getBM(
  attributes = c("ensembl_gene_id", "hgnc_symbol"),
  filters = "ensembl_gene_id",
  values = rna_ids,
  mart = mart
)
head(mapping)
# Merge the mapping with the original data
cnts$ensembl_gene_id <- rna_ids
cnts_mapped <- merge(cnts, mapping, by = "ensembl_gene_id")
# Remove rows with empty HGNC symbols
cnts_mapped <- cnts_mapped[cnts_mapped$hgnc_symbol != "", ]
# Aggregate counts by HGNC symbol (summing counts for duplicate symbols)
cnts_aggregated <- aggregate(. ~ hgnc_symbol, data = cnts_mapped[, -1], FUN = sum)
rownames(cnts_aggregated) <- cnts_aggregated$hgnc_symbol
cnts_aggregated <- cnts_aggregated[, -1]  # Remove the HGNC symbol column
cnts <- cnts_aggregated

saveRDS(cnts, file = "data/TCGA_BRCA_counts_processed.rds")

coldata<-as.data.frame(colData(query))

#replace Nas with Unknown
coldata$ajcc_pathologic_stage[is.na(coldata$ajcc_pathologic_stage)] <- "Unknown"
coldata$primary_diagnosis[is.na(coldata$primary_diagnosis)] <- "Not Reported"
coldata$race[is.na(coldata$race)] <- "UNKNOWN"
coldata$ethnicity[is.na(coldata$ethnicity)] <- "NOT REPORTED"

#capitalize values in race
coldata$race <- toupper(coldata$race)
coldata$ethnicity <- toupper(coldata$ethnicity)

# Keep only relevant columns
coldata <- coldata %>%
  select(patient, barcode, tissue_type, specimen_type, ajcc_pathologic_stage, primary_diagnosis, vital_status, gender, race, ethnicity)

# Remove tumor only samples that are not associated with a normal under patient
patients_with_tumor_and_normal <- unique(coldata$patient[coldata$tissue_type == "Normal"])
coldata <- coldata %>% filter(patient %in% patients_with_tumor_and_normal)

saveRDS(coldata, file = "data/TCGA_BRCA_coldata_processed.rds")

cnts<-cnts[,rownames(coldata)]

saveRDS(cnts, file = "data/TCGA_BRCA_counts_final.rds")