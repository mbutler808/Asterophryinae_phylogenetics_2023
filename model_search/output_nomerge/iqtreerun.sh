#for i in `seq 1 100`; do cp  asterophryinae_15partitions.nex nomerge$(printf "%02d" $i).nex; done
for i in `seq 1 100`; 
do 
  cp  ../input/asterophryinae_15partitions.nex nomerge$(printf "%02d" $i).nex
  iqtree2 -s ../../mesquite_alignment/asterophryinae_20230527.phy -p nomerge$(printf "%02d" $i).nex -m TESTONLY -o "UMMZ219489_Scaphiophryne_marmorata" --date ../input/asterophryinae_dates.txt --date-tip 0 -mset JC,F81,K80,HKY,TN,TNe,TPM2,TPM2u,TPM3,TPM3u,TIM,TIMe,TIM2,TIM2e,TIM3,TIM3e,TVMe,TVM,SYM,GTR ; 
done


