### R code from vignette source 'GOexpress-UsersGuide.Rnw'

###################################################
### code chunk number 5: GOexpress-UsersGuide.Rnw:201-203
###################################################
library(GOexpress) # load the GOexpress package
set.seed(4543) # set random seed for reproducibility


dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")

input <- function(inputfile) {
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1];
    pfix = prefix()
  if (length(pfix) != 0) {
     pfix <<- paste(pfix, "/", sep="")
  }
}

run <- function() {}

output <- function(outputfile) {
AlvMac <- readRDS(paste(pfix, parameters["dataset", 2], sep="/"))
AlvMac_GOgenes = read.table(paste(pfix, parameters["gogenes", 2], sep="/"), sep=",")
AlvMac_allGO = read.table(paste(pfix, parameters["go", 2], sep="/"), sep=",")
AlvMac_allgenes = read.table(paste(pfix, parameters["genes", 2], sep="/"), sep=",")
AlvMac_results <- GO_analyse(
    eSet = AlvMac, f = parameters["feature", 2],
    GO_genes=AlvMac_GOgenes, all_GO=AlvMac_allGO, all_genes=AlvMac_allgenes)

write.csv(AlvMac_results$GO, paste(outputfile, "GO", "csv", sep="."))
write.csv(AlvMac_results$genes, paste(outputfile, "genes", "csv", sep="."))
write.csv(AlvMac_results$mapping, paste(outputfile, "mapping", "csv", sep="."))
saveRDS(AlvMac_results, paste(outputfile, "rds", sep="."))
}
