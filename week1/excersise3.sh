mv nhek.bed ~/qb25-answers/week1  
grep 1_Active nhek.bed > nhek-active.bed  
mv NHLF.bed ~/qb25-answers/week1 
grep 1_Active NHLF.bed > NHFL-active.bed
grep 12_Repressed NHLF.bed > NHLF-repressed.bed
grep 12_Repressed nhek.bed > nhek-repressed.bed 
bedtools intersect -a nhek-active.bed -b nhek-repressed.bed > nhek_overlap.bed
bedtools intersect  -a nhek-active.bed -b NHFL-active.bed >nhek_nhlf_active.bed 
wc nhek_nhlf_active.bed
   12174   97392  781739 nhek_nhlf_active.bed
bedtools intersect -v -a nhek-active.bed -b NHLF-active.bed|wc
    2405   19240  154383
bedtools intersect -v -a nhek-active.bed -b NHLF-active.bed > non_overlap_nhek_NHLF.bed
bedtools intersect -f 1 -a nhek-active.bed -b NHLF-active.bed > little_f.bed
wc little_f.bed 
    4821   38568  309082 little_f.bed
  bedtools intersect -F 1 -a nhek-active.bed -b NHLF-active.bed > big_f.bed
wc big_F.bed 
 6731   53848  432613 big_F.bed
   bedtools intersect -f 1 -F 1 -a nhek-active.bed -b NHLF-active.bed > big_and_little_f.bed
   1409   11272   90448 big_and_little_f.bed

   #getting the info to put on UCSC browser: 
   head big_and_little_f.bed
   #chr1	1051137	1051537	

   head big_F.bed 
   #chr1	19923013	19924213

   head little_f.bed 
   #chr1	25558413	25559413
#Construct three bedtools intersect commands to identify the following types of regions. 
#Active in NHEK, Active in NHLF:
bedtools intersect -a nhek-active.bed -b NHLF-active.bed > nhek_active_both.bed
head nhek_active_both.bed
chr1	19923013	19924213
#Active in NHEK, Repressed in NHLF
bedtools intersect -a nhek-active.bed -b NHLF-repressed.bed > nhek_active_NHFL_repressed.bed
head nhek_active_NHFL_repressed.bed
chr1	1981140	1981540
#Repressed in NHEK, Repressed in NHLF
bedtools intersect -a nhek-repressed.bed -b NHLF-repressed.bed > both_rep.bed
head both_rep.bed
chr1	11537413	11538213