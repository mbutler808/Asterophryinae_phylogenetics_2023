# infer the concatentated tree with 1000 ultrafast bootstraps and an edge-linked fully-partitioned model (-p is the same as -spp from version 1.7 onwards) 
#iqtree -s alignment.nex -p alignment.nex --prefix concat -bb 1000 -nt AUTO

# infer the 88 single-locus trees
#iqtree -s alignment.nex -S alignment.nex --prefix loci -nt 50

# calculate concordance factors
#iqtree -t concat.treefile --gcf loci.treefile -s alignment.nex --scf 100 --prefix concord


# Installing iqtree

# download the binary for iqtree, move it into /Applications (through the gui or through the command line). 

# open your shell profile, located in your home directory, or you can open it from anywhere 

# 
# create a symbolic link to iqtree2 in your Application folder that will be executable from anywhere:
# need to invoke superuser (sudo) because you are changing your /Applicaitons folder which is outside of your user directory.

# sudo ln -s  currentlocation  newlocation
# 



# infer the a partitioned tree (modeltest) with 1000 ultrafast bootstraps and an edge-linked fully-partitioned model (-p is the same as -spp from version 1.7 onwards) 
iqtree2 -s input/asterophryinae_20230305.phy -p input/asterophryinae_15partitions.nex -m TEST --prefix out/nomerge -B 1000 -nt AUTO -o "UMMZ219489_Scaphiophryne_marmorata" --date input/asterophryinae_dates.txt --date-tip 0 -mset JC,F81,K80,HKY,TN,TNe,TPM2,TPM2u,TPM3,TPM3u,TIM,TIMe,TIM2,TIM2e,TIM3,TIM3e,TVMe,TVM,SYM,GTR 

# infer the a partitioned tree with merging (PartitionFinder) with 1000 ultrafast bootstraps and an edge-linked fully-partitioned model (-p is the same as -spp from version 1.7 onwards) 
#iqtree2 -s input/asterophryinae_20230305.phy -p input/asterophryinae_15partitions.nex -m TESTMERGE -rcluster 10 --prefix out/merge -B 1000 -nt AUTO -o "UMMZ219489_Scaphiophryne_marmorata" --date input/asterophryinae_dates.txt --date-tip 0 -mset JC,F81,K80,HKY,TN,TNe,TPM2,TPM2u,TPM3,TPM3u,TIM,TIMe,TIM2,TIM2e,TIM3,TIM3e,TVMe,TVM,SYM,GTR  -redo

# infer the a partitioned tree (modeltest) with 1000 ultrafast bootstraps and an edge-linked fully-partitioned model (-p is the same as -spp from version 1.7 onwards) 
iqtree2 -s input/asterophryinae_20230305.phy -p input/asterophryinae_15partitions.nex -m MFP -rcluster 10 --prefix out/MFP -B 1000 -nt AUTO -o "UMMZ219489_Scaphiophryne_marmorata" --date input/asterophryinae_dates.txt --date-tip 0 -mset JC,F81,K80,HKY,TN,TNe,TPM2,TPM2u,TPM3,TPM3u,TIM,TIMe,TIM2,TIM2e,TIM3,TIM3e,TVMe,TVM,SYM,GTR 


# infer the a partitioned tree (modeltest) with 1000 ultrafast bootstraps and an edge-linked fully-partitioned model (-p is the same as -spp from version 1.7 onwards) 
iqtree2 -s input/asterophryinae_20230305.phy -p input/asterophryinae_15partitions.nex -B 1000 -T AUTO -m TEST -rcluster 10 --prefix outmf/nomerge -o "UMMZ219489_Scaphiophryne_marmorata" --date input/asterophryinae_dates.txt --date-tip 0 -mset JC,F81,K80,HKY,TN,TNe,TPM2,TPM2u,TPM3,TPM3u,TIM,TIMe,TIM2,TIM2e,TIM3,TIM3e,TVMe,TVM,SYM,GTR 
