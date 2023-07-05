dir <- "output"
outfile <- paste("best_model_partitionfinder_aic_", Sys.Date(), ".txt", sep="" )

summaryaic <- function( dir) {
	files <- list.files(path=dir)                          # get list of filenames from the directory
	files <- grep("nex.iqtree", files, value=T)  # get files ending in nex.iqtree
	files <- paste(dir, files, sep="/")                # paste the path to the filename
	
	lines <- sapply( files, function(x) {            # for each file 		
					        d <- readLines(x)             # read the lines 
					        d[grepl("^Akaike", d)]       # select lines that start with Akaike 
					      }                                         # lines is a vector lines that start with Akaike
				       ) 
				       
	vals <- gsub(".*?([0-9]+.[0-9]+).*", "\\1", lines)    # for each line, extract the decimal number. 
	runs <- names(vals)                                           # the names hold the run number
	aic <- as.numeric(vals)                                      # coerce to numeric, save as aic
	
	dat <- data.frame( runs=runs, aic=aic)     # make a dataframe from run name and aic score
	dat <- dat[ order(dat$aic), ]                      # sort by aic score

    return(dat)
}


aic1 <- summaryaic(dir="output")
aic2 <- summaryaic(dir="output_nomerge")

aic <- rbind(aic1, aic2)                              # combine the merge and no merge results
aic <- aic[ order(aic$aic), ]	                     # sort by aic score

########################################################
# Model numbers and scores
# Best model is first
########################################################
sink(outfile)                                              # start writing to the output file
	cat("AIC scores of trees from 100 runs after PartitionFinder and tree estimation:\n")
	print(aic)
	cat(paste("delta aic worst - best: ", round(max(aic$aic) - min(aic$aic))))
sink()


########################################################
# Models written to file, ordered by best to last
# Three versions: All models, just the merged, just no merge models. 
########################################################
filenames <- sub("iqtree", "best_scheme.nex", aic$runs)
files <- lapply( filenames,  readLines)

models <- sapply( files, function(lines) {
	    				lines <- lines[(grep("charpartition", lines)+1):(length(lines)-1)]   # grab just the model
	    				lines <- trimws(lines)
	  				}
				 )

maxl <- max(sapply(models, length))  # maximum number of models
models <- sapply(models, "[", 1:maxl)
allmodels <- cbind(filenames, t(models))
write.csv(allmodels, file="allmodels.csv")

write.csv(allmodels[grep("output/", filenames),], file="allmodels_merge.csv")
write.csv(allmodels[grep("output/", filenames, invert=T),], file="allmodels_nomerge.csv")