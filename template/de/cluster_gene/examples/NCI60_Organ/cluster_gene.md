---
title: "Cluster genes across multiple sample groups"
author: "Zhe Zhang"
date: "2016-05-12"
output:
  html_document:
    self_contained: no
    number_sections: yes
    toc: yes
    toc_float: 
      collapsed: no
---

<div style="border:black 1px solid; padding: 0.5cm 0.5cm">
**Introduction: ** This analysis performs a gene-gene clustering procedure that will identify clusters of co-expressed genes across multiple sample groups. It first runs an ANOVA to find genes significantly changed across sample groups and uses these genes as seeds to initiate a number of gene clusters. These clusters will be further refined based on several user-specific paramters. Gene set enrichment analysis is then used to find pre-defined gene sets that are over-represented in each cluster. 

  - **Selection of differentially expressed gene:** ANOVA is used to get each gene a p value 
    for its differential expression across sample groups and false discovery rates are calculated      using the p values. Afterwards, genes are filtered sequentially by their FDR, p value, and         range until the number of remaining genes is smaller than a given minimal number.
  - **Gene clustering analysis:** Remaining genes from the last step are used as seeds for the         _hclust{stat}_ function to generate a hierchical clustering tree; the tree is cut at a given       height to get initial clusters; the cutting height will be lowered if the number of clusters is     less than the number of sample groups; the initial clusters are filtered to remove small           clusters, and refined to remove outlier genes; initial clusters close to each other are merged;     and finally, the clusters are refined through multiple rounds of re-clustering while including     genes with less significant ANOVA p values. 
  - **Gene set enrichment analysis:** Hypergeometric test is used to find predefined gene sets         over-represented in each gene cluster. A collection of gene sets obtained from                     different sources are available for a few model species and can be found at             
    https://github.com/zhezhangsh/RoCA/tree/master/data.
    
</div>

&nbsp;







































