---
title: "Summarize & filter sequence reads"
author: "Zhe Zhang"
date: "2016-06-07"
output:
  html_document:
    self_contained: no
    number_sections: yes
    toc: yes
    toc_float: 
      collapsed: no
---

<div style="border:black 1px solid; padding: 0.5cm 0.5cm">

**Introduction** This analysis summarizes and filters sequencing reads that have been aligned to the reference based on SAM fields such as ***FLAG***, ***MAPQ***, and ***CIGAR***. It uses the readGAlignments (single-ended reads) and readGAlignmentPairs (pair-ended reads) to import aligned reads from indexed BAM files. Summary statistics of imported reads are compared between samples for consistence and potential outliers. These statistics are

  - ***strand balance:*** reads mapped to forward vs. reverse strands
  - ***mapping flag:*** a single bitwise value that summarizes the alignment result of each read
  - ***mapping quality:*** p value of mapping certainty assigned by the aligment program
  - ***base count:*** number of bases in each read with insertion, getting trimmed, etc. (CIGAR operations)
  - ***matching length:*** total number of bases in each read matching to the reference
  
Finally, the reads will be filtered based on given criteria covering 4 possible rules:

  - ***mapping region:*** reads must be mapped to given genomic region(s)
  - ***mapping flag:*** the SAM field _FLAG_ must have one of given values
  - ***mapping quality:*** the SAM field _MAPQ_ must have value greater than or equal to a given value
  - ***matching length:*** the total number of bases matching the reference must be greater than or equal to a given value

</div>

&nbsp;





<div align='right'>_[Go to project home](http://zhezhangsh.github.io/RoCA)_</div>

# Description

## Project


[H3K4me3 of SLE in immune cells](http://grantome.com/grant/NIH/R01-AR058547-03)


## Experiment


H3K4me3 was measured in  B cell, T cell, and monocyte via ChIP-seq


## Analysis


Aligned single-ended ChIP-seq reads were loaded into R as GAlignments objects and filtered by their length, map quality, etc. Only a small portion of the total reads of each library were randomly selected as input for demo purpose Libraries were compared in this report using their summary statistics.





































