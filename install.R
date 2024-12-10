install.packages(c("insect", "tidyverse", "here", "BiocManager", "remotes" ,"digest"))

BiocManager::install("Biostrings")

BiocManager::install("dada2")

remotes::install_github("https://github.com/ramongallego/eDNA_functions")