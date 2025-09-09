cut -f 7 ~/Data/GTEx/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | sort | uniq -c | sort |tail -n 3
#top 3: 
# 867 Lung
#1132 Muscle - Skeletal
#3288 Whole Blood
grep -cv RNA  ~/Data/GTEx/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt
#2935
