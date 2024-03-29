# README.md

To reconstruct the phylogeny using IQTREE (saved in `model_search` folder), use these four inputs: 

-  asterophryinae_20230803.nex = the sequence alignment in `mesquite_alignment` folder
-  asterophryinae_partitions.nex = the sequence partitions file in `input`
-  asterophryinae_dates.txt  = the dates file with timings in `input`
-  "UMMZ219489_Scaphiophryne_marmorata" outgroup specified on the command line with -o flag

The shell script is in `model_search`:

Flags:
-s  alignent.phy
-p  partitions.nex
-m  MFP+MERGE to run tree and find best model
    MF+MERGE  to find best model w/o running tree
-B  1000  to run tree with 1000 bootstrap replicates    
-o  "outgroup" 
--date  dates.txt

Use IQTREE2 and run the following command (IQTREE is run from the command line):

Template:

  iqtree2 -s <alignment> -p <partitions> -m MFP+MERGE -B 1000 --date <dates.txt> -o "outgroup" --date-tip 0

Filled in - run partitionfinder plus tree:

  iqtree2 -s ../mesquite_alignment/alignment_20230803.nex -p ../input/asterophryinae_partitions.nex -m MFP+MERGE -B 1000 --date ../input/asterophryinae_dates.txt -o "UMMZ219489_Scaphiophryne_marmorata" --date-tip 0

Filled in - run PartitionFinder only (not sure if we need the dates?)

  iqtree2 -s ../mesquite_alignment/alignment_20230803.nex -p ../input/asterophryinae_partitions.nex -m MF+MERGE --date ../input/asterophryinae_dates.txt -o "UMMZ219489_Scaphiophryne_marmorata" --date-tip 0

