# Best model is nomerge46
cp ../output_nomerge_100/nomerge46.nex.best_scheme.nex .
iqtree2 -s ../../mesquite_alignment/asterophryinae_20230527.phy -p nomerge46.nex.best_scheme.nex -B 1000 -o "UMMZ219489_Scaphiophryne_marmorata" --date ../input/asterophryinae_dates.txt --date-tip 0; 
