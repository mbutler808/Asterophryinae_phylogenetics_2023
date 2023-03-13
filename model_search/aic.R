dir <- "output_10reps"
outfile <- "trees_from_partitionfinder_models_aic.txt"

summaryaic <- function( dir, outfile) {
	files <- list.files(path=dir)
	files <- grep("nex.iqtree", files, value=T)
	files <- paste(dir, files, sep="/")
	
	lines <- sapply( files, function(x) {
					        d <- readLines(x)
					        d[grepl("^Akaike", d)] 
					      }  
				       ) 
				       
	vals <- gsub(".*?([0-9]+.[0-9]+).*", "\\1", lines)
	runs <- names(vals)
	aic <- as.numeric(vals)
	
	dat <- data.frame( runs=runs, aic=aic)
	dat <- dat[ order(dat$aic), ]
	
	sink(outfile)
	
	cat("AIC scores of trees from 10 runs after PartitionFinder and tree estimation:\n")
	print(dat)
	cat(paste("delta aic worst - best: ", round(max(dat$aic) - min(dat$aic))))
	sink()
}

summaryaic(dir="output_10reps", outfile="AIC_partifionfinder_10runs.txt" )
summaryaic(dir="output_nomerge_10reps", outfile="AIC_modelselection_nomerge_10runs.txt" )