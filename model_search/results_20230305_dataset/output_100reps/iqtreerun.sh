for i in `seq 11 100`; 
do 
  cp  asterophryinae_15partitions.nex merge$(printf "%02d" $i).nex 
  ../../../../iqtree-2.2.0-Windows/bin/iqtree2 -s asterophryinae_20230305.phy -p merge$(printf "%02d" $i).nex -m TESTMERGEONLY -o "UMMZ219489_Scaphiophryne_marmorata" --date asterophryinae_dates.txt --date-tip 0 -mset JC,F81,K80,HKY,TN,TNe,TPM2,TPM2u,TPM3,TPM3u,TIM,TIMe,TIM2,TIM2e,TIM3,TIM3e,TVMe,TVM,SYM,GTR 
#  do ../../iqtree-2.2.0-Windows/bin/iqtree2 -s asterophryinae_20230305.phy -p merge$(printf "%02d" $i).nex -m TESTMERGE -B 1000 -o "UMMZ219489_Scaphiophryne_marmorata" --date asterophryinae_dates.txt --date-tip 0 -mset JC,F81,K80,HKY,TN,TNe,TPM2,TPM2u,TPM3,TPM3u,TIM,TIMe,TIM2,TIM2e,TIM3,TIM3e,TVMe,TVM,SYM,GTR ; 
done
